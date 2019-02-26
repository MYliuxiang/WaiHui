//
//  PriceOneCell.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/7.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PriceOneCell : UITableViewCell
@property(nonatomic,strong) LxChooseCountView *countView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;

@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (nonatomic,copy) NSString *min;
@property (nonatomic,copy) NSString *max;
@property (nonatomic,copy) NSString *step;


@end

NS_ASSUME_NONNULL_END
