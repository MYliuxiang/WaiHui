//
//  HoldCell.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/11.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HoldCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *hqBtn;
@property (weak, nonatomic) IBOutlet UIButton *pcBtn;
@property (weak, nonatomic) IBOutlet UIButton *szBtn;
@property (weak, nonatomic) IBOutlet UILabel *zyLab;

@property (weak, nonatomic) IBOutlet UIView *btnView;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *subName;

@property (weak, nonatomic) IBOutlet UIButton *orderCount;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *storageLab;

@property (weak, nonatomic) IBOutlet UILabel *commissionLab;
@property (weak, nonatomic) IBOutlet UILabel *sl;


@property (strong, nonatomic) HoldModel *model;
@property (nonatomic,copy) void(^hqBlock)(HoldModel *model);
@property (nonatomic,copy) void(^pcBlock)(HoldModel *model);
@property (nonatomic,copy) void(^szBlock)(HoldModel *model);
@property (nonatomic,copy) void(^reloadBlock)(void);


@end

NS_ASSUME_NONNULL_END
