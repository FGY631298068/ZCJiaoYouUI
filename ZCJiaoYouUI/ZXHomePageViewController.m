//
//  ZXHomePageViewController.m
//  OneYuanPurchase
//
//  Created by 范国义 on 16/9/30.
//  Copyright © 2016年 范国义. All rights reserved.
//

#import "ZXHomePageViewController.h"

@interface ZXHomePageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) id ID;//用于请求数据

@property (nonatomic, retain) UITableView *tableview;
@end

@implementation ZXHomePageViewController

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 1) style:UITableViewStyleGrouped];
        _tableview.backgroundColor = [UIColor grayColor];
        _tableview.delegate = self;
        _tableview.dataSource = self;
       
    }
    return _tableview;
}

- (instancetype)initWithID:(id)itemID{
    if (self = [super init]) {
        
        _ID = itemID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [self randomColor];
    
    [self.view addSubview:self.tableview];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 6;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    
    NSLog(@"ssssssssssss");
    UIPanGestureRecognizer *recog = scrollView.panGestureRecognizer;
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewPanGesture:Translation:)]) {
        [_delegate scrollViewPanGesture:recog Translation:translation];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    NSLog(@"scrollViewDidEndDragging");
    UIPanGestureRecognizer *recog = scrollView.panGestureRecognizer;
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewPanGesture:Translation:)]) {
        [_delegate scrollViewPanGesture:recog Translation:translation];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIPanGestureRecognizer *recog = scrollView.panGestureRecognizer;
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewPanGesture:Translation:)]) {
        [_delegate scrollViewPanGesture:recog Translation:translation];
    }
    
}



- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

@end
