//
//  ZXHomePageViewController.h
//  OneYuanPurchase
//
//  Created by 范国义 on 16/9/30.
//  Copyright © 2016年 范国义. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJScrollPageViewDelegate.h"

@protocol ZXHomePageViewControllerDelegate <NSObject>

- (void)scrollViewPanGesture:(UIPanGestureRecognizer*)ges Translation:(CGPoint)translation;

@end
@interface ZXHomePageViewController : UIViewController<ZJScrollPageViewChildVcDelegate>
- (instancetype)initWithID:(id)itemID;
@property (nonatomic, weak) id<ZXHomePageViewControllerDelegate>delegate;
@end
