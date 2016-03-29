//
//  ExpressInfoRequst.h
//  ExpressInfo
//
//  Created by 曾文斌 on 16/3/25.
//  Copyright © 2016年 zengwenbin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ExpressCompany) {
    ExpressCompanyShenTong,
    ExpressCompanyYuanTong,
    ExpressCompanyZhongTong,
    ExpressCompanyYunDa
};

@interface ExpressInfoRequst : NSObject
@property(nonatomic, copy, nonnull) NSString *expressID;
@property(nonatomic) ExpressCompany company;
@property(nonatomic, copy, nullable) void (^successResponse)(NSArray *_Nullable response);
@property(nonatomic, copy, nullable) void (^failResponse)(NSError*_Nullable error);
- (nullable instancetype)initWithExpressID:(nonnull NSString *)expressID
                                   company:(ExpressCompany)company;
- (void)request;
@end
