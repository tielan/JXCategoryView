//
//  TestViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "SegmentTitleViewController.h"
#import "JXCategorySegmentView.h"
#import "UIWindow+JXSafeArea.h"
#import "ListViewController.h"
#import "JXCategoryIndicatorLineView.h"

#define WindowsSize [UIScreen mainScreen].bounds.size

@interface SegmentTitleViewController () <JXCategoryViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) JXCategorySegmentView *categoryView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation SegmentTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"JXCategorySegmentView";
    
    _titles = @[@"推荐", @"网上超市", @"网上超"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGFloat naviHeight = [UIApplication.sharedApplication.keyWindow jx_navigationHeight];
    
    NSUInteger count = self.titles.count;
    CGFloat categoryViewHeight = 50;
    CGFloat width = WindowsSize.width;
    CGFloat height = WindowsSize.height - naviHeight - categoryViewHeight;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, categoryViewHeight, width, height)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(width*count, height);
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    for (int i = 0; i < count; i ++) {
        UIViewController *listVC = [[ListViewController alloc] init];
        [self configListViewController:listVC index:i];
        [self addChildViewController:listVC];
        listVC.view.frame = CGRectMake(i*width, 0, width, height);
        [self.scrollView addSubview:listVC.view];
    }
    self.categoryView = [[JXCategorySegmentView alloc] init];
    self.categoryView.titles = self.titles;
    CGFloat ajustContentWidth = [self.categoryView ajustWidth:@[@"网上超", @"网上超市", @"网上超"]];
    self.categoryView.frame = CGRectMake(WindowsSize.width*0.5-ajustContentWidth*0.5, 0, ajustContentWidth, categoryViewHeight);
    self.categoryView.delegate = self;
    self.categoryView.contentScrollView = self.scrollView;
   
    
    //self.categoryView.cellSpacing = 8;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.cellWidthZoomEnabled = NO;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[lineView];
    
     [self.view addSubview:self.categoryView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}



- (void)configListViewController:(UIViewController *)controller index:(NSUInteger)index {
    
}
@end
