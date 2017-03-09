//
//  ZJSegmentStyle.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJSegmentStyle.h"

@implementation ZJSegmentStyle

- (instancetype)init {
    if(self = [super init]) {
        self.showCover = NO;
        self.showLine = NO;
        self.scaleTitle = NO;
        self.scrollTitle = YES;
        self.segmentViewBounces = YES;
        self.gradualChangeTitleColor = NO;
        self.showExtraButton = NO;
        self.scrollContentView = YES;
        self.adjustCoverOrLineWidth = NO;
        self.extraBtnBackgroundImageName = nil;
        self.scrollLineHeight = 10;
        self.scrollLineColor = [UIColor colorWithRed:251.0/255.0 green:193.0/255.0 blue:49/255.0 alpha:1.0];
        self.coverBackgroundColor = [UIColor colorWithRed:255.0/255.0 green:120.0/255.0 blue:0/255.0 alpha:1.0];

        self.coverCornerRadius = 14.0;
        self.coverHeight = 28.0;
        self.titleMargin = 15.0;
        self.titleFont = [UIFont systemFontOfSize:16.0];
        self.titleBigScale = 1.3;
        self.normalTitleColor = [UIColor colorWithRed:51.0/255.0 green:53.0/255.0 blue:75/255.0 alpha:1.0];
        
        self.selectedTitleColor = [UIColor colorWithRed:251.0/255.0 green:193.0/255.0 blue:49/255.0 alpha:1.0];
        
        self.segmentHeight = 50;

    }
    return self;
}


@end
