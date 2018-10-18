//
//  JXCategorySubTitleCellModel.h
//  JXCategoryView
//
//  Created by iosteams on 2018/10/12.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorCellModel.h"

@interface JXCategorySubTitleCellModel : JXCategoryIndicatorCellModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIFont *titleSelectedFont;

@property (nonatomic, assign) BOOL titleLabelZoomEnabled;

@property (nonatomic, assign) CGFloat titleLabelZoomScale;

@property (nonatomic, assign) CGFloat subtitleAlpha;
@end
