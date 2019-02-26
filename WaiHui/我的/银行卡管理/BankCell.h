//
//  BankCell.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/17.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface BankCell : UITableViewCell
@property (nonatomic,strong)BankModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *bankImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *numeberLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constaint;

@end

NS_ASSUME_NONNULL_END
