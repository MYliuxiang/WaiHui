//
//  OffsetAlert.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/10.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "LxCustomAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface OffsetAlert : LxCustomAlert
@property (weak, nonatomic) IBOutlet UILabel *startLab;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
- (IBAction)sliderAC:(UISlider *)sender;

- (instancetype)initOffsetAlert;
@end

NS_ASSUME_NONNULL_END
