//
//  ChangeCell.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/13.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "ChangeCell.h"

@implementation ChangeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.centerView.layer.masksToBounds = YES;
    self.centerView.layer.cornerRadius  = 5;
    
    self.price1View.layer.masksToBounds = YES;
    self.price1View.layer.cornerRadius  = 5;
    
    self.price2View.layer.masksToBounds = YES;
    self.price2View.layer.cornerRadius  = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)typePriceOneAC:(id)sender {
    if (self.typeClickBlock) {
        self.typeClickBlock(1);
    }
}

- (IBAction)typePriceTwoAC:(id)sender {
    self.typeClickBlock(2);

}


@end
