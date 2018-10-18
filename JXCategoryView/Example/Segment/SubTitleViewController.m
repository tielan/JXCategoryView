//
//  TestViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "SubTitleViewController.h"
#import "JXCategorySubTitleView.h"
#import "UIWindow+JXSafeArea.h"
#import "ListViewController.h"

#define WindowsSize [UIScreen mainScreen].bounds.size

@interface SubTitleViewController () <JXCategoryViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) JXCategorySubTitleView *categoryView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation SubTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"JXCategorySegmentView";
    
    _titles = @[@"推荐1", @"网上超市2", @"网上超3",@"网上超市4", @"网上超5",@"网上超市6",];
    
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
    self.categoryView = [[JXCategorySubTitleView alloc] init];
    self.categoryView.titles = self.titles;
    self.categoryView.frame = CGRectMake(0, 0, WindowsSize.width, categoryViewHeight);
    self.categoryView.delegate = self;
    self.categoryView.contentScrollView = self.scrollView;
     self.categoryView.titleColorGradientEnabled = YES;
     [self.view addSubview:self.categoryView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}



- (void)configListViewController:(UIViewController *)controller index:(NSUInteger)index {
    
}
@end
