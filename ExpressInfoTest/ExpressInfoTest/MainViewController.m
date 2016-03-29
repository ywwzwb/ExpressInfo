//
//  MainViewController.m
//  ExpressQuery
//
//  Created by 曾文斌 on 16/3/28.
//  Copyright © 2016年 zengwenbin. All rights reserved.
//

#import "MainViewController.h"
#import "ExpressInfoTableViewController.h"
@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *companySegment;
@property (weak, nonatomic) IBOutlet UITextField *expressIDTextField;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([identifier isEqualToString:@"showExpressInfo"]){
        return self.expressIDTextField.text.length>0;
    }
    return [super shouldPerformSegueWithIdentifier:identifier sender:sender];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.destinationViewController isKindOfClass:[ExpressInfoTableViewController class]]){
        ExpressInfoTableViewController *infoVC=segue.destinationViewController;
        infoVC.expressID=self.expressIDTextField.text;
        infoVC.company=self.companySegment.selectedSegmentIndex;
        [infoVC requestInfo];
    }
}


@end
