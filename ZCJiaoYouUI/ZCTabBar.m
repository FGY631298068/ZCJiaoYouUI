//
//  ZCTabBar.m
//  ZCJiaoYouUI
//
//  Created by 范国义 on 2017/3/3.
//  Copyright © 2017年 范. All rights reserved.
//

#import "ZCTabBar.h"

#import "UIView+Extension.h"
#import <objc/runtime.h>

#define ZYMagin 10

@interface ZCTabBar ()

@end

@implementation ZCTabBar
//对按钮的一些基本设置
- (void)setUpPathButton:(ZYPathButton *)pathButton {
    pathButton.allowCenterButtonRotation = self.allowCenterButtonRotation;
    pathButton.bottomViewColor = [UIColor lightGrayColor];
    pathButton.basicDuration = self.basicDuration;
   
}

- (void)drawRect:(CGRect)rect {
    self.plusBtn = [[ZYPathButton alloc]initWithCenterImage:[UIImage imageNamed:@"chooser-button-input"]highlightedImage:[UIImage imageNamed:@"chooser-button-input"] bouncedOffButtonImage:[UIImage imageNamed:@"guanbianniu"]];
    [self setUpPathButton:self.plusBtn];
    self.plusBtn.ZYButtonCenter = CGPointMake(self.centerX, self.superview.height - self.height * 0.5 - 2 *ZYMagin );

    //必须加到父视图上
    [self.superview addSubview:self.plusBtn];

}
//重新绘制按钮
- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    Class class = NSClassFromString(@"UITabBarButton");
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {
        if ([btn isKindOfClass:class]) {
            btn.width = self.width * 0.5;
            btn.x = btn.width * btnIndex;
            btnIndex ++;
            if (btnIndex == 2) {
                btnIndex++;
            }
        }
    }
    
}


@end
