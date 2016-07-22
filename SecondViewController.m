//
//  SecondViewController.m
//  Project
//
//  Created by yangqisuo on 16/7/21.
//  Copyright © 2016年 yangqisuo. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(50, 100, 100, 50)];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor purpleColor]];
    [button setTitle:@"click" forState:UIControlStateNormal];
    [self.view addSubview:button];
}
- (void)click:(id)sender{
    if (self.subject) {
        [self.subject sendNext:@"1"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
