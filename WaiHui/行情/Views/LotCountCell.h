//
//  LotCountCell.h
//  WaiHui
//
//  Created by liuxiang on 2019/1/23.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LotCountCell : UITableViewCell
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
