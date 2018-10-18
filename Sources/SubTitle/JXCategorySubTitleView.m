//
//  JXCategorySubTitleView.m
//  JXCategoryView
//
//  Created by iosteams on 2018/10/12.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategorySubTitleView.h"
#import "JXCategoryFactory.h"

@implementation JXCategorySubTitleView


- (void)initializeData
{
    [super initializeData];
    
    _titleLabelZoomEnabled = YES;
    _titleLabelZoomScale = 1.4;
    _titleColor = [UIColor blackColor];
    _titleSelectedColor = [UIColor blackColor];
    _titleFont = [UIFont systemFontOfSize:15];
    _titleColorGradientEnabled = YES;
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
    return [JXCategorySubTitleCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        JXCategorySubTitleCellModel *cellModel = [[JXCategorySubTitleCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];
        
    JXCategorySubTitleCellModel *myUnselectedCellModel = (JXCategorySubTitleCellModel *)unselectedCellModel;
    myUnselectedCellModel.titleColor = self.titleColor;
    myUnselectedCellModel.titleSelectedColor = self.titleSelectedColor;
    myUnselectedCellModel.titleLabelZoomScale = 1.0;
    myUnselectedCellModel.subtitleAlpha = 1;
    
    JXCategorySubTitleCellModel *myselectedCellModel = (JXCategorySubTitleCellModel *)selectedCellModel;
    myselectedCellModel.titleColor = self.titleColor;
    myselectedCellModel.titleSelectedColor = self.titleSelectedColor;
    myselectedCellModel.titleLabelZoomScale = self.titleLabelZoomScale;
    myselectedCellModel.subtitleAlpha = 0;
}

- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];
    
    
    JXCategorySubTitleCellModel *leftModel = (JXCategorySubTitleCellModel *)leftCellModel;
    JXCategorySubTitleCellModel *rightModel = (JXCategorySubTitleCellModel *)rightCellModel;
    
    if(ratio > 0.80){
        if (self.titleLabelZoomEnabled && self.titleLabelZoomScrollGradientEnabled) {
            leftModel.titleLabelZoomScale = [JXCategoryFactory interpolationFrom:self.titleLabelZoomScale to:1.0 percent:ratio];
            leftModel.subtitleAlpha = [JXCategoryFactory interpolationFrom:0 to:1.0 percent:ratio];
            
            rightModel.titleLabelZoomScale = [JXCategoryFactory interpolationFrom:1.0 to:self.titleLabelZoomScale percent:ratio];
            rightModel.subtitleAlpha = [JXCategoryFactory interpolationFrom:1.0 to:0 percent:ratio];

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

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];
    
    JXCategorySubTitleCellModel *model = (JXCategorySubTitleCellModel *)cellModel;
    model.titleFont = self.titleFont;
    model.titleSelectedFont = self.titleSelectedFont;
    model.titleColor = self.titleColor;
    model.titleSelectedColor = self.titleSelectedColor;
    model.title = self.titles[index];
    model.titleLabelZoomEnabled = self.titleLabelZoomEnabled;
    model.titleLabelZoomScale = 1.0;
    model.subtitleAlpha = 1;
    if (index == self.selectedIndex) {
        model.titleLabelZoomScale = self.titleLabelZoomScale;
        model.subtitleAlpha = 0;
    }
}
@end
