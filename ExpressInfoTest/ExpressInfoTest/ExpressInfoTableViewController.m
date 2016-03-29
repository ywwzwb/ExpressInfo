//
//  ExpressInfoTableViewController.m
//  ExpressQuery
//
//  Created by 曾文斌 on 16/3/28.
//  Copyright © 2016年 zengwenbin. All rights reserved.
//

#import "ExpressInfoTableViewController.h"
@interface ExpressInfoTableViewController ()
@property(nonatomic,copy)NSArray *infoArrary;
@end

@implementation ExpressInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArrary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *info=self.infoArrary[indexPath.row];
    cell.textLabel.text=info[@"context"];
    cell.detailTextLabel.text=info[@"time"];
    return cell;
}

-(IBAction)requestInfo{
    ExpressInfoRequst *express=[[ExpressInfoRequst alloc] initWithExpressID:self.expressID company:self.company];
    [express setSuccessResponse:^(NSArray * _Nullable response) {
        self.infoArrary=response;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
    [express setFailResponse:^(NSError * _Nullable error) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"出错了" message:error.localizedFailureReason preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        [self.refreshControl endRefreshing];
    }];
    [express request];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
