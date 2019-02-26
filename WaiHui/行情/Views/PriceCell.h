//
//  PriceCell.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/7.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PriceCell : UITableViewCell
@property(nonatomic,strong) LxChooseCountView *countView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (nonatomic,copy) NSString *step;
@property (nonatomic,copy) NSString *min;
@property (nonatomic,copy) NSString *max;
@property (nonatomic,copy) NSString *price;

@end

NS_ASSUME_NONNULL_END
