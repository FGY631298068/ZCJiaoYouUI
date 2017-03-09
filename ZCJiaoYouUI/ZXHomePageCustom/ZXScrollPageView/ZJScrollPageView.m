//
//  ZJScrollPageView.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJScrollPageView.h"

@interface ZJScrollPageView ()
@property (strong, nonatomic) ZJSegmentStyle *segmentStyle;
@property (weak, nonatomic) ZJScrollSegmentView *segmentView;
@property (weak, nonatomic) ZJContentView *contentView;
@property (weak, nonatomic) UIButton *tixingButton;
@property (weak, nonatomic) UIViewController *parentViewController;
@property (strong, nonatomic) NSArray *childVcs;
@property (strong, nonatomic) NSArray *titlesArray;

@end
@implementation ZJScrollPageView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame segmentStyle:(ZJSegmentStyle *)segmentStyle titles:(NSArray<NSString *> *)titles parentViewController:(UIViewController *)parentViewController delegate:(id<ZJScrollPageViewDelegate>) delegate {
    if (self = [super initWithFrame:frame]) {
        self.segmentStyle = segmentStyle;
        self.delegate = delegate;
        self.parentViewController = parentViewController;
        self.titlesArray = titles.copy;
        [self commonInit];
    }
    return self;
}


- (void)commonInit {
    
    // 触发懒加载
    self.segmentView.backgroundColor = [UIColor whiteColor];//背景颜色
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.tixingButton.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc {
    NSLog(@"ZJScrollPageView--销毁");
}

#pragma mark - public helper

/** 给外界设置选中的下标的方法 */
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated {
    [self.segmentView setSelectedIndex:selectedIndex animated:animated];
}

/**  给外界重新设置视图内容的标题的方法 */
- (void)reloadWithNewTitles:(NSArray<NSString *> *)newTitles {
    
    self.titlesArray = nil;
    self.titlesArray = newTitles.copy;
    
    [self.segmentView reloadTitlesWithNewTitles:self.titlesArray];
    [self.contentView reload];
    
}


#pragma mark - getter ---- setter
- (UIButton *)tixingButton{
    if (!_tixingButton) {
        
        UIButton *buttong = [UIButton buttonWithType:UIButtonTypeCustom];
       [buttong setImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"] forState:UIControlStateNormal];
        buttong.frame = CGRectMake(5, 12, 25, 25);
        [buttong addTarget:self action:@selector(clickTxingButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttong];
        _tixingButton = buttong;
    
    }

    return _tixingButton;
}
- (void)clickTxingButton{
    
    if ([self.delegate respondsToSelector:@selector(clickTiXingXiaoXiButton)]) {
        [self.delegate clickTiXingXiaoXiButton];
    }
}

- (ZJContentView *)contentView {
    if (!_contentView) {
        ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.segmentView.frame), self.bounds.size.width, self.bounds.size.height -1) segmentView:self.segmentView parentViewController:self.parentViewController delegate:self.delegate];
        [self addSubview:content];
        _contentView = content;
    }
    
    return  _contentView;
}


- (ZJScrollSegmentView *)segmentView {
    if (!_segmentView) {
        __weak typeof(self) weakSelf = self;
        ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(35, 0, self.bounds.size.width - 35, self.segmentStyle.segmentHeight) segmentStyle:self.segmentStyle titles:self.titlesArray titleDidClick:^(UILabel *label, NSInteger index) {
            
            [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:NO];
            
        }];
        [self addSubview:segment];
        UILabel *labve = [[UILabel alloc] initWithFrame:CGRectMake(0, segment.frame.size.height - 1, segment.frame.size.width, 1)];
        labve.backgroundColor = [UIColor groupTableViewBackgroundColor];//下边的线
        [segment addSubview:labve];
        
        _segmentView = segment;
    }
    _segmentView.extraBtnOnClick =^(UIButton *extraBtn){
        
        if (self.extraBtnOnClick) {
            self.extraBtnOnClick(extraBtn);
        }
    };
    return _segmentView;
}


- (NSArray *)childVcs {
    if (!_childVcs) {
        _childVcs = [NSArray array];
    }
    return _childVcs;
}

- (NSArray *)titlesArray {
    if (!_titlesArray) {
        _titlesArray = [NSArray array];
    }
    return _titlesArray;
}

- (void)setExtraBtnOnClick:(ExtraBtnOnClick)extraBtnOnClick {
    _extraBtnOnClick = extraBtnOnClick;
    self.segmentView.extraBtnOnClick = extraBtnOnClick;
}

@end
