//
//  JXCategoryView.m
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategorySegmentView.h"
#import "JXCategoryFactory.h"

@interface JXCategorySegmentView ()

@end

@implementation JXCategorySegmentView

- (void)initializeData
{
    [super initializeData];

    _titleLabelZoomEnabled = NO;
    _titleLabelZoomScale = 1.2;
    _titleColor = [UIColor blackColor];
    _titleSelectedColor = [UIColor redColor];
    _titleFont = [UIFont systemFontOfSize:15];
    _titleColorGradientEnabled = NO;
    _titleLabelMaskEnabled = NO;
    _titleLabelZoomScrollGradientEnabled = YES;
    
}

- (UIFont *)titleSelectedFont {
    if (_titleSelectedFont != nil) {
        return _titleSelectedFont;
    }
    return self.titleFont;
}

#pragma mark - Override

- (Class)preferredCellClass {
    return [JXCategorySegmentCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        JXCategorySegmentCellModel *cellModel = [[JXCategorySegmentCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];

    JXCategorySegmentCellModel *myUnselectedCellModel = (JXCategorySegmentCellModel *)unselectedCellModel;
    myUnselectedCellModel.titleColor = self.titleColor;
    myUnselectedCellModel.titleSelectedColor = self.titleSelectedColor;
    myUnselectedCellModel.titleLabelZoomScale = 1.0;

    JXCategorySegmentCellModel *myselectedCellModel = (JXCategorySegmentCellModel *)selectedCellModel;
    myselectedCellModel.titleColor = self.titleColor;
    myselectedCellModel.titleSelectedColor = self.titleSelectedColor;
    myselectedCellModel.titleLabelZoomScale = self.titleLabelZoomScale;
}

- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];

    JXCategorySegmentCellModel *leftModel = (JXCategorySegmentCellModel *)leftCellModel;
    JXCategorySegmentCellModel *rightModel = (JXCategorySegmentCellModel *)rightCellModel;

    if (self.titleLabelZoomEnabled && self.titleLabelZoomScrollGradientEnabled) {
        leftModel.titleLabelZoomScale = [JXCategoryFactory interpolationFrom:self.titleLabelZoomScale to:1.0 percent:ratio];
        rightModel.titleLabelZoomScale = [JXCategoryFactory interpolationFrom:1.0 to:self.titleLabelZoomScale percent:ratio];
    }

    if (self.titleColorGradientEnabled) {
        //处理颜色渐变
        if (leftModel.selected) {
            leftModel.titleSelectedColor = [JXCategoryFactory interpolationColorFrom:self.titleSelectedColor to:self.titleColor percent:ratio];
            leftModel.titleColor = self.titleColor;
        }else {
            leftModel.titleColor = [JXCategoryFactory interpolationColorFrom:self.titleSelectedColor to:self.titleColor percent:ratio];
            leftModel.titleSelectedColor = self.titleSelectedColor;
        }
        if (rightModel.selected) {
            rightModel.titleSelectedColor = [JXCategoryFactory interpolationColorFrom:self.titleColor to:self.titleSelectedColor percent:ratio];
            rightModel.titleColor = self.titleColor;
        }else {
            rightModel.titleColor = [JXCategoryFactory interpolationColorFrom:self.titleColor to:self.titleSelectedColor percent:ratio];
            rightModel.titleSelectedColor = self.titleSelectedColor;
        }
    }
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    if (self.cellWidth == JXCategoryViewAutomaticDimension) {
        return ceilf([self.titles[index] boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.titleFont} context:nil].size.width);
    }else {
        return self.cellWidth;
    }
}

-(CGFloat)ajustWidth:(NSArray *)ajustTitle{
    CGFloat cellSpacing = self.cellSpacing;
    CGFloat segmentWidth = cellSpacing;
    for (NSString *title in ajustTitle) {
        CGFloat itemWidth = ceilf([title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.titleFont} context:nil].size.width);
        segmentWidth += cellSpacing + itemWidth;
    }
    return segmentWidth;
  
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    JXCategorySegmentCellModel *model = (JXCategorySegmentCellModel *)cellModel;
    model.titleFont = self.titleFont;
    model.titleSelectedFont = self.titleSelectedFont;
    model.titleColor = self.titleColor;
    model.titleSelectedColor = self.titleSelectedColor;
    model.title = self.titles[index];
    model.titleLabelMaskEnabled = self.titleLabelMaskEnabled;
    model.titleLabelZoomEnabled = self.titleLabelZoomEnabled;
    model.titleLabelZoomScale = 1.0;
    if (index == self.selectedIndex) {
        model.titleLabelZoomScale = self.titleLabelZoomScale;
    }
}

@end
