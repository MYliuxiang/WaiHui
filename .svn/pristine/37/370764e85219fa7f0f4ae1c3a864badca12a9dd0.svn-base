//
//  RegistSuccessVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/19.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "RegistSuccessVC.h"

@interface RegistSuccessVC ()
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@end

@implementation RegistSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopDisabled = YES;
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 60, 48)];

}
- (IBAction)doneAC:(id)sender {
    if (self.type == 0) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else{
        
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    }
    
}

@end
