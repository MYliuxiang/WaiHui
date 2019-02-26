//
//  QSeachConeCell.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/10.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "QSeachConeCell.h"

@implementation QSeachConeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
    
}

-(void)filleCellWithArray:(NSArray *)tags{
    
    [self.tagView addTags:tags];
    
}
-(UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    
    [self setNeedsLayout];
    
    [self layoutIfNeeded];
    
    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
    
    CGRect cellFrame = layoutAttributes.frame;
    
    cellFrame.size.height= size.height;
    
    layoutAttributes.frame= cellFrame;
    
    return layoutAttributes;
    
}

@end
