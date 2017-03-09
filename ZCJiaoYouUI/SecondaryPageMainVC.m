//
//  SecondaryPageMainVC.m
//  ZCJiaoYouUI
//
//  Created by 范国义 on 2017/3/8.
//  Copyright © 2017年 范. All rights reserved.
//

#import "SecondaryPageMainVC.h"
#import "ZCTabBar.h"
@interface SecondaryPageMainVC ()

@end

@implementation SecondaryPageMainVC

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    ZCTabBar *tabBar =  [self.tabBarController valueForKeyPath:@"tabBar"];
    tabBar.plusBtn.hidden = NO;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    ZCTabBar *tabBar =  [self.tabBarController valueForKeyPath:@"tabBar"];
    tabBar.plusBtn.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
