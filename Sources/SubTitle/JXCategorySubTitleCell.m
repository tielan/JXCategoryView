//
//  JXCategorySubTitleCell.m
//  JXCategoryView
//
//  Created by iosteams on 2018/10/12.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategorySubTitleCell.h"

@interface JXCategorySubTitleCell()

@property(nonatomic,assign) NSInteger preTag;

@end

@implementation JXCategorySubTitleCell

- (void)initializeViews
{
    [super initializeViews];
    
    _titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    
    _subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.subTitleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger tag = self.titleLabel.tag;
    
    NSLog(@"%@---%ld---%ld",self.titleLabel.text,(long)tag,self.preTag);
    self.titleLabel.center = CGPointMake(self.contentView.center.x, self.contentView.center.y-6*tag*0.01);
    self.subTitleLabel.center = CGPointMake(self.contentView.center.x, self.contentView.center.y+8*tag*0.01);
    
    self.preTag = tag;
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];
    
    JXCategorySubTitleCellModel *myCellModel = (JXCategorySubTitleCellModel *)cellModel;
    self.selected = myCellModel.selected;
    
    
    CGFloat pointSize = myCellModel.titleFont.pointSize;
    UIFontDescriptor *fontDescriptor = myCellModel.titleFont.fontDescriptor;
    
    if (myCellModel.selected) {
        fontDescriptor = myCellModel.titleSelectedFont.fontDescriptor;
        pointSize = myCellModel.titleSelectedFont.pointSize;
    }
    
    self.subTitleLabel.font = [UIFont systemFontOfSize:8];
    self.titleLabel.font = [UIFont fontWithDescriptor:fontDescriptor size:pointSize*myCellModel.titleLabelZoomScale];
   
    self.titleLabel.tag = myCellModel.subtitleAlpha * 100;
    self.titleLabel.text = myCellModel.title;
    self.subTitleLabel.text = @"ネットス";
    
    [self.titleLabel sizeToFit];
    [self.subTitleLabel sizeToFit];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
@end
