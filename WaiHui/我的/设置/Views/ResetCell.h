//
//  ResetCell.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet TXLimitedTextField *textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldConstraint;

@end

NS_ASSUME_NONNULL_END
