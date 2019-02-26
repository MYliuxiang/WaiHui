//
//  ListCell.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/11.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UIButton *hqBtn;
@property (weak, nonatomic) IBOutlet UIButton *gdBtn;
@property (weak, nonatomic) IBOutlet UIButton *csBtn;
@property (weak, nonatomic) IBOutlet UILabel *zyLab;
@property (strong, nonatomic) ListModel *model;
@property (nonatomic,copy) void(^hqBlock)(ListModel *model);
@property (nonatomic,copy) void(^gdBlock)(ListModel *model);
@property (nonatomic,copy) void(^csBlock)(ListModel *model);
@property (nonatomic,copy) void(^reloadBlock)(void);

@property (weak, nonatomic) IBOutlet UILabel *sybolNameLab;
@property (weak, nonatomic) IBOutlet UILabel *sybolLab;

@property (weak, nonatomic) IBOutlet UIButton *voloumBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab1;
@property (weak, nonatomic) IBOutlet UILabel *priceLab2;
@property (weak, nonatomic) IBOutlet UILabel *priceLab3;
@property (weak, nonatomic) IBOutlet UILabel *slLab;

@end

NS_ASSUME_NONNULL_END
