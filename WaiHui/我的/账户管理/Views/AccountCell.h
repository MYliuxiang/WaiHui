//
//  AccountCell.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/14.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic,copy) void(^moreBlock)(void) ;
@property (nonatomic,strong) Mt4Model *model;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *labe1;

@property (weak, nonatomic) IBOutlet UILabel *lab2;

@property (weak, nonatomic) IBOutlet UILabel *lab3;

@property (weak, nonatomic) IBOutlet UILabel *lab4;

@property (weak, nonatomic) IBOutlet UILabel *lab5;
@property (weak, nonatomic) IBOutlet UIButton *qieHuanBtn;
@property (weak, nonatomic) IBOutlet UIImageView *statusImg;
@property (nonatomic,copy) void(^switchBlock)(void) ;

- (IBAction)qieHuanAC:(id)sender;

@end

NS_ASSUME_NONNULL_END
