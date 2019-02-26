//
//  CashTextFieldCell.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CashTextFieldCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name1;
@property (weak, nonatomic) IBOutlet UILabel *nameLab2;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *textField;


@end

NS_ASSUME_NONNULL_END
