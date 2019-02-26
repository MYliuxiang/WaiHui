//
//  QSearchTwoCell.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/10.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QSearchTwoCell : UICollectionViewCell
@property (nonatomic,strong) HotModel *model;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@end

NS_ASSUME_NONNULL_END
