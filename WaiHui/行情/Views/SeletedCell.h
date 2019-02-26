//
//  SeletedCell.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/10.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeletedCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *sybolLab;
@property(nonatomic,strong)ProductModel *model;
@end

NS_ASSUME_NONNULL_END
