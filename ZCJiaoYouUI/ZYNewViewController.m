//
//  ZYNewViewController.m
//  ZCJiaoYouUI
//
//  Created by 范国义 on 2017/3/3.
//  Copyright © 2017年 范. All rights reserved.

#import "ZYNewViewController.h"

@interface ZYNewViewController ()

@end

@implementation ZYNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分界面";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
