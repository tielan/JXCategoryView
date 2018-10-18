//
//  JXCategorySubTitleView.h
//  JXCategoryView
//
//  Created by iosteams on 2018/10/12.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorView.h"
#import "JXCategorySubTitleCell.h"
#import "JXCategorySubTitleCellModel.h"


@interface JXCategorySubTitleView : JXCategoryIndicatorView

@property (nonatomic, strong) NSArray <NSString *>*titles;
@property (nonatomic, strong) NSArray <NSString *>*subTitles;

@property (nonatomic, strong) UIColor *titleColor;      //默认：[UIColor blackColor]

@property (nonatomic, strong) UIColor *titleSelectedColor;      //默认：[UIColor redColor]

@property (nonatomic, strong) UIFont *titleFont;    //默认：[UIFont systemFontOfSize:15]

@property (nonatomic, strong) UIFont *titleSelectedFont;    //文字被选中的字体。默认：与titleFont一样

@property (nonatomic, assign) BOOL titleColorGradientEnabled;   //默认：NO，title的颜色是否渐变过渡

@property (nonatomic, assign) BOOL titleLabelMaskEnabled;   //默认：NO，titleLabel是否遮罩过滤。（需要backgroundEllipseLayerShowEnabled = YES）

//----------------------titleLabelZoomEnabled-----------------------//
@property (nonatomic, assign) BOOL titleLabelZoomEnabled;     //默认为NO

@property (nonatomic, assign) BOOL titleLabelZoomScrollGradientEnabled;     //手势滚动中，是否需要更新状态。默认为YES

@property (nonatomic, assign) CGFloat titleLabelZoomScale;    //默认1.2，titleLabelZoomEnabled为YES才生效

@end
