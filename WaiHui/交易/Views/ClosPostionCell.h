//
//  ClosPostionCell.h
//  WaiHui
//
//  Created by liuxiang on 2019/1/24.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClosPostionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property(nonatomic,strong) LxChooseCountView *countView;
@property (nonatomic,copy) NSString *min;
@property (nonatomic,copy) NSString *max;
@property (nonatomic,copy) NSString *step;

@end

NS_ASSUME_NONNULL_END
