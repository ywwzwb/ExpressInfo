//
//  ExpressInfoTableViewController.h
//  ExpressQuery
//
//  Created by 曾文斌 on 16/3/28.
//  Copyright © 2016年 zengwenbin. All rights reserved.
//

#import <UIKit/UIKit.h>
@import ExpressInfo;
@interface ExpressInfoTableViewController : UITableViewController
@property(nonatomic,copy)NSString *expressID;
@property(nonatomic)ExpressCompany company;
-(IBAction)requestInfo;
@end
