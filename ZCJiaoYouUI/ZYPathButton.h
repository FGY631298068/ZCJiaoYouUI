//
//  ZYPathButton.h
//  ZCJiaoYouUI
//
//  Created by 范国义 on 2017/3/3.
//  Copyright © 2017年 范. All rights reserved.

//#import "ZYPathItemButton.h"

@import UIKit;
@import QuartzCore;
@import AudioToolbox;

@class ZYPathButton;

@interface ZYPathButton : UIView <UIGestureRecognizerDelegate>

/*!正常情况下的按钮*/
@property (strong, nonatomic) UIButton *pathCenterButton;

@property (assign, nonatomic, getter = isBloom) BOOL bloom;
/*!弹出动画的时间*/
@property (assign, nonatomic) NSTimeInterval basicDuration;

/*!设置ZYPathButton的位置*/
@property (assign, nonatomic) CGPoint ZYButtonCenter;

/*!设置中间的按钮是否旋转*/
@property (assign, nonatomic) BOOL allowCenterButtonRotation;

/*!弹出View的颜色*/
@property (strong, nonatomic) UIColor *bottomViewColor;

- (instancetype)initWithCenterImage:(UIImage *)centerImage
                   highlightedImage:(UIImage *)centerHighlightedImage
                   bouncedOffButtonImage:(UIImage *)bouncedOffButton;

- (instancetype)initWithButtonFrame:(CGRect)centerButtonFrame
                        centerImage:(UIImage *)centerImage
                   highlightedImage:(UIImage *)centerHighlightedImage
                   bouncedOffButtonImage:(UIImage *)bouncedOffButton;

@end
