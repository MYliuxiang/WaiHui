//
//  QuoTationListCell.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/6.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuoTationListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (nonatomic,strong) ProductModel *model;
@property (weak, nonatomic) IBOutlet UILabel *subNameLab;
@property (weak, nonatomic) IBOutlet UILabel *price1Lab;
@property (weak, nonatomic) IBOutlet UILabel *price2Lab;





@end

NS_ASSUME_NONNULL_END
