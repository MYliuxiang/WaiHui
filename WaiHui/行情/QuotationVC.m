//
//  QuotationVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/6.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "QuotationVC.h"
#import "QuotationListVC.h"
#import "QSearchVC.h"

@interface QuotationVC ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray <QuotationListVC *> *listVCArray;
@property (nonatomic, strong) JXCategoryListContainerView *listVCContainerView;

@property (nonatomic,strong) NSArray *titles;

@end

@implementation QuotationVC

- (void)viewDidLoad {

    [super viewDidLoad];

   
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"行情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.rightBtnImage = @"icon_search";
    NSLog(@"%f",[WRNavigationBar navBarBottom]);
    CGFloat naviHeight = [UIApplication.sharedApplication.keyWindow jx_navigationHeight];
    

    _titles = @[@"外汇",@"商品",@"指数",@"数字货币"];
    NSUInteger count = _titles.count;
    CGFloat categoryViewHeight = 40;
    CGFloat width = kScreenWidth;
    CGFloat height = kScreenHeight - naviHeight - categoryViewHeight;

//    self.listVCArray = [NSMutableArray array];
//
//    for (int i = 0; i < count; i ++) {
//    
//        QuotationListVC *listVC = [[QuotationListVC alloc] init];
//        listVC.biaoTi = _titles[i];
//        listVC.view.frame = CGRectMake(i*width, 0, width, height);
//    
//        [self.listVCArray addObject:listVC];
////        [self addChildViewController:listVC];
//
//    }

      self.categoryView = [[JXCategoryTitleView alloc] init];
      self.categoryView.frame = CGRectMake(0, 0, kScreenWidth, categoryViewHeight);
      self.categoryView.delegate = self;
      self.categoryView.titles = _titles;
     self.categoryView.titleColor = [MyColor colorWithHexString:@"#858296"];
     self.categoryView.titleSelectedColor = [MyColor colorWithHexString:@"#2B2B76"];
    self.categoryView.titleFont = [UIFont systemFontOfSize:14];
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = [MyColor colorWithHexString:@"#2B2B76"];
    lineView.lineStyle = JXCategoryIndicatorLineStyle_JD;
    lineView.indicatorLineViewCornerRadius = 1.5;
    lineView.lineScrollOffsetX = 5;
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];

    self.listVCContainerView = [[JXCategoryListContainerView alloc] initWithParentVC:self delegate:self];
    self.listVCContainerView.frame = CGRectMake(0, categoryViewHeight, width, kScreenHeight - Height_NavBar - categoryViewHeight - Height_TabBar);
    self.listVCContainerView.defaultSelectedIndex = 0;
    self.categoryView.defaultSelectedIndex = 0;
    [self.view addSubview:self.listVCContainerView];

    self.categoryView.contentScrollView = self.listVCContainerView.scrollView;
 
    
}


- (void)doRightNavBarRightBtnAction
{
    QSearchVC *vc = [[QSearchVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listVCContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listVCContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    
    QuotationListVC *listVC = [[QuotationListVC alloc] init];
    listVC.biaoTi = _titles[index];
    CGFloat categoryViewHeight = 40;
    CGFloat naviHeight = [UIApplication.sharedApplication.keyWindow jx_navigationHeight];
    CGFloat width = kScreenWidth;
    CGFloat height = kScreenHeight - naviHeight - categoryViewHeight;
    listVC.view.frame = CGRectMake(index * width, 0, width, height);
    [self addChildViewController:listVC];
    
    return listVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}


@end

























