//
//  ChangeCell.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/13.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *price1View;
@property (weak, nonatomic) IBOutlet UIView *price2View;
@property (weak, nonatomic) IBOutlet UILabel *centerLab;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UILabel *price1TypeLab;
@property (weak, nonatomic) IBOutlet UILabel *price1Lab;
@property (weak, nonatomic) IBOutlet UILabel *price2Lab;
@property (weak, nonatomic) IBOutlet UILabel *price2TypeLab;

@property (nonatomic,copy) void(^typeClickBlock)(int type) ;

@end

NS_ASSUME_NONNULL_END
