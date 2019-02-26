//
//  BaseViewController.h
//  Familysystem
//
//  Created by 李立 on 15/8/21.
//  Copyright (c) 2015年 LILI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LxEmptyView.h"

@interface BaseViewController : UIViewController

@property (nonatomic, copy) NSString *leftBtnImage;
@property (nonatomic, copy) NSString *leftBtnTitle;
@property (nonatomic, copy) NSString *rightBtnImage;
@property (nonatomic, copy) NSString *rightBtnTitle;
@property(nonatomic, strong) UIColor *leftBtnTitleColor;
@property(nonatomic, strong) UIColor *rightBtnTitleColor;

@property (nonatomic,assign) BOOL haveData;


@property (nonatomic, assign) BOOL hiddenRightBtn;
@property (nonatomic, assign) BOOL hiddenLeftBtn;
@property (nonatomic,assign)  int  pageOffset;

@property (nonatomic,strong) LxEmptyView *noDataView;
@property (nonatomic,strong) LxEmptyView *noNetView;
@property (nonatomic,strong) LxEmptyView *systemExceptionView;

@property (nonatomic,strong) UIView *socketTipView;
@property (nonatomic,strong) UIImageView *tipImage;
@property (nonatomic,strong) UILabel *tipLab;


//@property (strong, nonatomic)  UIView *socketTipView;
//@property (strong, nonatomic)  UIImageView *tipImage;
//@property (strong, nonatomic)  UILabel *tipLab;

//是否显示NavigationBar
- (BOOL)isNaviBarVisible;
//是否显示statusBar
- (BOOL)isStatusBarVisible;

- (void)configNavigationBar;
- (void)doRightNavBarRightBtnAction;
- (void)networkReachable;
- (void)networkNoReachable;
- (void)checkNetWork;

- (void)socketUnConnected;
- (void)socketReConnecting;
- (void)socketConnected;



@end
