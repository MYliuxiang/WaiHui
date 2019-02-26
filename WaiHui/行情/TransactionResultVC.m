//
//  TransactionResultVC.m
//  WaiHui
//
//  Created by liuxiang on 2019/1/24.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "TransactionResultVC.h"
#import "TransactionVC.h"

@interface TransactionResultVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UILabel *lab5;
@property (weak, nonatomic) IBOutlet UILabel *lab6;
@property (weak, nonatomic) IBOutlet UIButton *guaBtn;
@property (weak, nonatomic) IBOutlet UIButton *chicangBtn;

@end

@implementation TransactionResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"交易结果";
    [self.guaBtn hyb_addCornerRadius:2 size:CGSizeMake(164, 36)];
    self.chicangBtn.hyb_borderColor = [MyColor colorWithHexString:@"#E0E2EC"];
    self.chicangBtn.hyb_borderWidth = 1;
    [self.chicangBtn hyb_addCornerRadius:2 size:CGSizeMake(164, 36)];
  
    NSString *com = self.dic[@"command"];
    if ([com rangeOfString:@"Limit"].location != NSNotFound) {
        self.titleLab.text = @"限价挂单成功";
    }else{
        self.titleLab.text = @"停损挂单成功";
    }
    
    if([com rangeOfString:@"Buy"].location != NSNotFound){
        
        self.lab1.text = @"买入";
    }else{
        self.lab1.text = @"卖出";
    }
    self.lab2.text = self.model.symbolName;
    self.lab3.text = self.dic[@"volume"];
    self.lab4.text = self.dic[@"price"];
    NSString *sl = self.dic[@"sl"];
    if (sl.length == 0) {
        
        self.lab5.text = @"未设置";

    }else{
        self.lab5.text = sl;

    }
    
    NSString *tp = self.dic[@"tp"];
    if (tp.length == 0) {
        
         self.lab6.text = @"未设置";
        
    }else{
         self.lab6.text =tp;
        
    }


    
   
    
}




- (IBAction)chicangAC:(id)sender {
    
    MainTabBarController *vc= [MainTabBarController shareMainTabBarController];
    BaseNavigationController *nav = vc.viewControllers[2];
    TransactionVC *tvc = nav.viewControllers.firstObject;
    tvc.seltedIndex = 0;
    
    vc.selectedIndex = 2;
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (IBAction)guadanAC:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    if (self.reloadBlock) {
        self.reloadBlock();
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
