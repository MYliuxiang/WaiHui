//
//  DetailQuotationVC.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/7.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "BaseViewController.h"
#import "QuickTransactionAlert.h"
#import "SellVC.h"
#import "ContractualattributesVC.h"


NS_ASSUME_NONNULL_BEGIN

@interface DetailQuotationVC : BaseViewController<UIWebViewDelegate>

@property(nonatomic,strong) NSString *sybol;
@end

NS_ASSUME_NONNULL_END
