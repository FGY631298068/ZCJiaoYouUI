//
//  ZCTabBar.h
//  ZCJiaoYouUI
//
//  Created by 范国义 on 2017/3/3.
//  Copyright © 2017年 范. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYPathButton.h"

@interface ZCTabBar : UITabBar

/** 弹出动画时间*/
@property (assign, nonatomic) NSTimeInterval basicDuration;
/** 设置弹出时是否旋转   */
//@property (assign, nonatomic) BOOL allowSubItemRotation;

/**  设置中间的按钮是否旋转 */
@property (assign, nonatomic) BOOL allowCenterButtonRotation;
@property (nonatomic , strong)ZYPathButton *plusBtn;

@end
