//
//  HomePageVC.m
//  ZCJiaoYouUI
//
//  Created by 范国义 on 2017/3/6.
//  Copyright © 2017年 范. All rights reserved.
//

#import "HomePageVC.h"
#import "ZJScrollPageView.h"
#import "ZXHomePageViewController.h"
#import "ZCTabBar.h"

@interface HomePageVC ()<ZJScrollPageViewDelegate,ZXHomePageViewControllerDelegate>
{
    CGFloat scrollPageViewFrameY;
    CGFloat tabBarPlusBtnFrameY;
    CGFloat tabBarControllerTabBarFrameY;
    
    ZJScrollPageView *scrollPageView;
}
@property(strong, nonatomic)NSArray<NSString *> *titles;
@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor        = [UIColor whiteColor];
    
    [self creatUI];
    
}

- (void)creatUI{
    
     CGRect screen = [[UIScreen mainScreen] bounds];
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showCover = NO;
    style.adjustCoverOrLineWidth = NO;
    style.scrollTitle = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    style.scrollLineColorName = @"chooser-moment-button";
    style.showLine = YES;
    self.titles = @[@"关注",@"发现",@"榜单",@"明显",@"榜单",@"明显"];
    // 初始化
    scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 14, self.view.bounds.size.width, screen.size.height + 2) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    
    [self.view addSubview:scrollPageView];

}
#pragma make  ZJScrollPageViewDelegate
- (void)clickTiXingXiaoXiButton{
     NSLog(@"点击了提醒的按钮");
    
}
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}


- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
        if (!childVc) {
       ZXHomePageViewController  * homePage = [[ZXHomePageViewController alloc] init];
            homePage.delegate = self;
            childVc = homePage;
        }
  
    return childVc;
}

#pragma mark ZXHomePageViewControllerDelegate
- (void)scrollViewPanGesture:(UIPanGestureRecognizer *)ges Translation:(CGPoint)translation {
    if (ges.state == UIGestureRecognizerStateBegan) {
       scrollPageViewFrameY =scrollPageView.frame.origin.y;
        tabBarControllerTabBarFrameY = self.tabBarController.tabBar.frame.origin.y;
        ZCTabBar *tabBar =  [self.tabBarController valueForKeyPath:@"tabBar"];
        tabBarPlusBtnFrameY =  tabBar.plusBtn.center.y ;
        
    } else if (ges.state == UIGestureRecognizerStateChanged) {
        CGRect screen = [[UIScreen mainScreen] bounds];
        
        CGFloat y = scrollPageViewFrameY + translation.y;
        if (y < - 50) {
            y = -50;
        }
        if (y > 14) {
            y = 14;
        }
        if (y >= -50 && y <= 14) {
            CGRect frame = scrollPageView.frame;
            frame.origin.y = y;
            frame.size.height = screen.size.height + 64 ;
            scrollPageView.frame = frame;
        }
        
        CGFloat by = tabBarControllerTabBarFrameY -  translation.y;
        
        if (by < screen.size.height - 49) {
            by = screen.size.height - 49;
        }
        
        if (by > (screen.size.height  + 40)) {
            by = screen.size.height + 40;
        }
        if (by >= ( screen.size.height - 49) && by <= (screen.size.height  + 40)) {
            CGRect frame = self.tabBarController.tabBar.frame;
            frame.origin.y = by;
            self.tabBarController.tabBar.frame = frame;
        }
        
        CGFloat ty = tabBarPlusBtnFrameY -  translation.y;
        if (ty < (screen.size.height - 44.5f)) {
            ty = screen.size.height - 44.5f;
        }
        
        if (ty > (screen.size.height + 44.5)) {
            ty = screen.size.height + 44.5;
        }
        if (ty >= ( screen.size.height - 44.5f) && ty <= (screen.size.height + 44.5)) {
            
            ZCTabBar *tabBar =  [self.tabBarController valueForKeyPath:@"tabBar"];
            CGPoint frame = tabBar.plusBtn.center;
            frame.y = ty;
            tabBar.plusBtn.center = frame;
        }

    }else if (ges.state == UIGestureRecognizerStateEnded) {
        CGRect screen = [[UIScreen mainScreen] bounds];
        CGFloat y = scrollPageViewFrameY + translation.y;
        
        ZCTabBar *tabBar =  [self.tabBarController valueForKeyPath:@"tabBar"];
        if (y < -20) {
            // 消失
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = scrollPageView.frame;
                frame.origin.y = - 50;
                frame.size.height = screen.size.height + 64 ;
                scrollPageView.frame = frame;
                CGPoint frame1 = tabBar.plusBtn.center;
                frame1.y = screen.size.height + 44.5f;
                tabBar.plusBtn.center = frame1;
                
                CGRect frame2 = self.tabBarController.tabBar.frame;
                frame2.origin.y = screen.size.height + 40;
                self.tabBarController.tabBar.frame = frame2;
                 [self tabBarHiddenBouncedAppear];
            }];
            
            
           
            
            
        }
        
        if (y >= -20) {
            
            // 显示
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = scrollPageView.frame;
                frame.origin.y = 14;
                frame.size.height = screen.size.height + 64 ;
                scrollPageView.frame = frame;
                
                CGPoint frame1 = tabBar.plusBtn.center;
                frame1.y = screen.size.height -   44.5;
                tabBar.plusBtn.center = frame1;
                
                CGRect frame2 = self.tabBarController.tabBar.frame;
                frame2.origin.y = screen.size.height - 49;
                self.tabBarController.tabBar.frame = frame2;
              [self tabBarAppearBouncedHidden];
            }];
            
        }

        
    }
    
}

//tabBar隐藏出现弹框
- (void)tabBarHiddenBouncedAppear {
    
}
//tabBar出现隐藏弹框
- (void)tabBarAppearBouncedHidden{
    
    
}
@end
