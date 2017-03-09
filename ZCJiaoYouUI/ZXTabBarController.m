//
//  ZXTabBarController.m
//  ZCJiaoYouUI
//
//  Created by 范国义 on 2017/3/3.
//  Copyright © 2017年 范. All rights reserved.
//

#import "ZXTabBarController.h"
#import "ZCTabBar.h"
#import "HomePageVC.h"
#import "MyViewController.h"
@interface ZXTabBarController ()

@end

@implementation ZXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildVc];
    [self configureZYPathButton];
}

- (void)configureZYPathButton {
    ZCTabBar *tabBar = [[ZCTabBar alloc] init];
    tabBar.delegate = self;
    tabBar.basicDuration = 0.5;
    tabBar.allowCenterButtonRotation = YES;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}

- (void)setUpAllChildVc {
    HomePageVC *HomeVC = [[HomePageVC alloc] init];
    
    [self setUpOneChildVcWithVc:HomeVC Image:@"home_normal" selectedImage:@"home_highlight" title:@"首页"];

    MyViewController *MineVC = [[MyViewController alloc] init];
    [self setUpOneChildVcWithVc:MineVC Image:@"account_normal" selectedImage:@"account_highlight" title:@"我的"];
}
#pragma mark - 初始化设置tabBar上面单个按钮的方法

- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:Vc];
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.image = myImage;
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Vc.tabBarItem.selectedImage = mySelectedImage;
    Vc.tabBarItem.title = title;
    Vc.navigationItem.title = title;
    [self addChildViewController:nav];
    
}

@end
