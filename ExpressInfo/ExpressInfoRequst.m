//
//  ExpressInfoRequst.m
//  ExpressInfo
//
//  Created by 曾文斌 on 16/3/25.
//  Copyright © 2016年 zengwenbin. All rights reserved.
//

#import "AFNetworking.h"
#import "ExpressInfoRequst.h"
@implementation ExpressInfoRequst
- (instancetype)initWithExpressID:(NSString *)expressID
                          company:(ExpressCompany)company{
    if (!expressID) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.expressID = expressID;
        self.company = company;
    }
    return self;
}

- (void)request {
    static NSDictionary *companyNameDic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        companyNameDic = @{
                           @(ExpressCompanyShenTong) : @"shentong",
                           @(ExpressCompanyYuanTong) : @"yuantong",
                           @(ExpressCompanyZhongTong) : @"zhongtong",
                           @(ExpressCompanyYunDa) : @"yunda"
                           };
    });
    AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.kuaidi100.com"]
                                                             sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    AFJSONResponseSerializer *serializer=[AFJSONResponseSerializer serializer];
    NSMutableSet *contentTypeSet=[NSMutableSet setWithSet:serializer.acceptableContentTypes];
    [contentTypeSet addObject:@"text/html"];
    serializer.acceptableContentTypes=contentTypeSet;
    [session setResponseSerializer:serializer];
    [session GET:@"query"
      parameters:@{
                   @"type" : companyNameDic[@(self.company)],
                   @"postid" : self.expressID
                   }
        progress:nil
         success:^(NSURLSessionDataTask *_Nonnull task,
                   id _Nullable responseObject) {
             if (self.successResponse) {
                 [self processSuccessResult:responseObject];
             }
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if(self.failResponse){
                 self.failResponse(error);
             }
         }];
}
-(void)processSuccessResult:(NSDictionary *)result{
    if(![result isKindOfClass:[NSDictionary class]]){
        if(self.failResponse){
            self.failResponse(nil);
            return;
        }
    }
    NSUInteger status=[result[@"status"] integerValue];
    if(status!=200){
        if(self.failResponse){
            NSString *errorReason=result[@"message"];
            if(!errorReason){
                errorReason=@"unknown";
            }
            NSError *error=[NSError errorWithDomain:[[NSBundle bundleForClass:[self class]] bundleIdentifier] code:status userInfo:@{NSLocalizedFailureReasonErrorKey:errorReason}];
            self.failResponse(error);
            return;
        }
    }
    if(self.successResponse){
         self.successResponse(result[@"data"]);
    }
}
@end
