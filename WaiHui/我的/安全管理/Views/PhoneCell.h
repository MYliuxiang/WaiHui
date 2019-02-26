//
//  PhoneCell.h
//  WaiHui
//
//  Created by liuxiang on 2019/1/7.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhoneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *textField;

@end

NS_ASSUME_NONNULL_END
