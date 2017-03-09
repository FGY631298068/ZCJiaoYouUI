//
//  ZYPathButton.m
//  ZCJiaoYouUI
//
//  Created by 范国义 on 2017/3/3.
//  Copyright © 2017年 范. All rights reserved.

#import "ZYPathButton.h"

@interface ZYPathButton ()

#pragma mark - Private Property

@property (strong, nonatomic) UIImage *centerImage;
@property (strong, nonatomic) UIImage *centerHighlightedImage;
@property (nonatomic, strong) UIImage *bouncedOffButtonImage;
@property (assign, nonatomic) CGSize bloomSize;
@property (assign, nonatomic) CGSize foldedSize;

@property (assign, nonatomic) CGPoint folZYenter;
@property (assign, nonatomic) CGPoint bloomCenter;
@property (assign, nonatomic) CGPoint expanZYenter;
@property (assign, nonatomic) CGPoint pathCenterButtonBloomCenter;
@property (strong, nonatomic) UIControl *bottomView;

@property (nonatomic, strong)  UIView *bouncedView;
@end

@implementation ZYPathButton

#pragma mark - Initialization

- (instancetype)initWithCenterImage:(UIImage *)centerImage
                   highlightedImage:(UIImage *)centerHighlightedImage
              bouncedOffButtonImage:(UIImage *)bouncedOffButton{
    return [self initWithButtonFrame:CGRectZero
                         centerImage:centerImage
                      highlightedImage:centerHighlightedImage
                        bouncedOffButtonImage:bouncedOffButton];
}

- (instancetype)initWithButtonFrame:(CGRect)centerButtonFrame
                        centerImage:(UIImage *)centerImage
                   highlightedImage:(UIImage *)centerHighlightedImage
                   bouncedOffButtonImage:(UIImage *)bouncedOffButton{
    
    if (self = [super init]) {
        
        self.centerImage = centerImage;
        self.centerHighlightedImage = centerHighlightedImage;
        self.bouncedOffButtonImage = bouncedOffButton;
        if (centerButtonFrame.size.width == 0 && centerButtonFrame.size.height == 0) {
            
            [self configureViewsLayoutWithButtonSize:self.centerImage.size];
            
        }else {
            
            [self configureViewsLayoutWithButtonSize:centerButtonFrame.size];
            self.ZYButtonCenter = centerButtonFrame.origin;
        }
        
        _bottomViewColor = [UIColor grayColor];

        _basicDuration = 0.3f;
        
    }
    return self;
}

- (void)configureViewsLayoutWithButtonSize:(CGSize)centerButtonSize {
    
    self.foldedSize = centerButtonSize;
    
    self.bloomSize = [UIScreen mainScreen].bounds.size;
    
    self.bloom = NO;

    self.folZYenter = CGPointMake(self.bloomSize.width / 2, self.bloomSize.height - 25.5f);

    self.bloomCenter = CGPointMake(self.bloomSize.width / 2, self.bloomSize.height / 2);

    self.frame = CGRectMake(0, 0, self.foldedSize.width, self.foldedSize.height);

    self.center = self.folZYenter;
    
    _pathCenterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.centerImage.size.width, self.centerImage.size.height)];
   
    [_pathCenterButton setImage:self.centerImage forState:UIControlStateNormal];
    
    [_pathCenterButton setImage:self.centerHighlightedImage forState:UIControlStateHighlighted];
   
    [_pathCenterButton addTarget:self action:@selector(centerButtonTapped) forControlEvents:UIControlEventTouchUpInside];
   
    _pathCenterButton.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    [self addSubview:_pathCenterButton];
    
    _bottomView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, self.bloomSize.width , self.bloomSize.height )];
    [_bottomView addTarget:self action:@selector(clickcancel) forControlEvents:UIControlEventTouchUpInside];
    _bottomView.backgroundColor = self.bottomViewColor;
   
    _bottomView.alpha = 0.7f;
    
    _bouncedView =[[UIView alloc] initWithFrame:CGRectMake(0, _bottomView.bounds.size.height - 250, _bottomView.bounds.size.width, 250)];
    _bouncedView.alpha = 0.7;
    _bouncedView.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *buttong = [UIButton buttonWithType:UIButtonTypeCustom];
    buttong.bounds = CGRectMake(0, 0,60 , 60);
    buttong.center = CGPointMake(_bouncedView.center.x, _bouncedView.bounds.size.height - 45);
    [buttong setImage:self.bouncedOffButtonImage forState:UIControlStateNormal];
    [buttong addTarget:self action:@selector(clickcancel) forControlEvents:UIControlEventTouchUpInside];
    [_bouncedView addSubview:buttong];
    
    
    UIButton *voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [voiceButton setImage:[UIImage imageNamed:@"voiceButton"] forState:UIControlStateNormal];
    voiceButton.frame = CGRectMake((self.bloomSize.width /2 - 80 )/2, (self.bloomSize.width /2 - 80 )/2, 80, 80);
    [voiceButton addTarget:self action:@selector(clickVoiceButton) forControlEvents:UIControlEventTouchUpInside];
    [_bouncedView addSubview:voiceButton];
    
    UIButton *videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [videoButton setImage:[UIImage imageNamed:@"videobutton"] forState:UIControlStateNormal];
    videoButton.frame = CGRectMake((self.bloomSize.width /2 - 80 )/2 + self.bloomSize.width /2, (self.bloomSize.width /2 - 80 )/2, 80, 80);
     [videoButton addTarget:self action:@selector(clickvideoButton) forControlEvents:UIControlEventTouchUpInside];
    [_bouncedView addSubview:videoButton];
    
}
//点击语言的按钮
- (void)clickVoiceButton{
    NSLog(@"点击le语言的按钮");
   
}
//点击视频的按钮
- (void)clickvideoButton{
    
    NSLog(@"点击视频的按钮");
}

//点击取消 和点击灰色透明的部分也去掉调用的方法
- (void)clickcancel{
    [self resizeToFoldedFrame];
}

- (void)setBottomViewColor:(UIColor *)bottomViewColor {
    
    if (bottomViewColor) {
        _bottomView.backgroundColor = bottomViewColor;
    }
    _bottomViewColor = bottomViewColor;
    
}

- (void)setCenterImage:(UIImage *)centerImage {
    
    if (!centerImage) {
        NSLog(@"Load center image failed ... ");
        return ;
    }
    _centerImage = centerImage;
}

- (void)setCenterHighlightedImage:(UIImage *)highlightedImage {
    
    if (!highlightedImage) {
        NSLog(@"Load highted image failed ... ");
        return ;
    }
    _centerHighlightedImage = highlightedImage;
}

- (void)setZYButtonCenter:(CGPoint)ZYButtonCenter {
    
    _ZYButtonCenter = ZYButtonCenter;
    
    self.center = ZYButtonCenter;
}

- (void)setPathCenterButtonBloomCenter:(CGPoint)centerButtonBloomCenter {

    if (_pathCenterButtonBloomCenter.x == 0) {
        _pathCenterButtonBloomCenter = centerButtonBloomCenter;
    }
    return ;
}


- (BOOL)isBloom {
    return _bloom;
}

- (void)centerButtonTapped {
    self.isBloom? [self pathCenterButtonFold] : [self pathCenterButtonBloom];
}

- (void)pathCenterButtonFold {
    [self resizeToFoldedFrame];
    
}
//消失调用
- (void)resizeToFoldedFrame {
    
    if (self.allowCenterButtonRotation) {
        [UIView animateWithDuration:0.0618f * 3
                              delay:0.0618f * 2
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _pathCenterButton.transform = CGAffineTransformMakeRotation(0);
                         }
                         completion:nil];
    }

    [self hideTipBarView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        self.frame = CGRectMake(0, 0, self.foldedSize.width, self.foldedSize.height);
        self.center = _ZYButtonCenter;
        
        self.pathCenterButton.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        [self.bottomView removeFromSuperview];
    });
    
    _bloom = NO;
}

// 显示
- (void)pathCenterButtonBloom {
    
    self.pathCenterButtonBloomCenter = self.center;
    
    self.frame = CGRectMake(0, 0, self.bloomSize.width, self.bloomSize.height);
   
    self.center = CGPointMake(self.bloomSize.width / 2, self.bloomSize.height / 2);
   
    [self.window insertSubview:self.bottomView belowSubview:self.pathCenterButton];
    
    [self showTipBarImage];
    
    if (self.allowCenterButtonRotation) {
        [UIView animateWithDuration:0.1575f animations:^{
       
            _pathCenterButton.transform = CGAffineTransformMakeRotation(-0.75f * M_PI);
       
        }];
    }
    
    self.pathCenterButton.center = self.pathCenterButtonBloomCenter;
   
    _bloom = YES;
    
}
- (void)showTipBarImage {
    
    _bouncedView.frame =CGRectMake(0, self.bloomSize.height , self.bloomSize.width , 250);
    
    [self.window addSubview:_bouncedView];
    
    [UIView beginAnimations:@"va" context:nil];
    
    [UIView setAnimationDuration:0.3];
   
    _bouncedView.frame = CGRectMake(0, _bottomView.bounds.size.height - 250, self.bloomSize.width , 250);
    
    [UIView commitAnimations];
    
}

- (void)hideTipBarView {
    
    [UIView beginAnimations:@"va" context:nil];
    
    [UIView setAnimationDuration:0.3];
    
    [UIView setAnimationDelegate:self];
    
    _bouncedView.frame = CGRectMake(0, self.bloomSize.height, self.bloomSize.width , 250);
    
    [UIView commitAnimations];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self resizeToFoldedFrame];
}

#pragma mark - UIGestureRecognizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0) {
    return YES;
}

@end
