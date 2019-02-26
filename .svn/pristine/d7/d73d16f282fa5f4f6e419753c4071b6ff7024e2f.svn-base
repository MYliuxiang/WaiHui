//
//  SeletedAlert.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/10.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "SeletedAlert.h"
#import "SeletedCell.h"

@implementation SeletedAlert

- (instancetype)initSeletedAlert
{
    self = [super init];
    if (self) {
        
        [self setupAutoHeightWithBottomView:self.collectionView bottomMargin:0];
         [BANetManagerCache ba_httpCacheWithUrlString:[NSString stringWithFormat:@"%@%@",MainUrl,Url_marketCentre] parameters:@{@"types":@"1"} block:^(id<NSCoding> responseObject) {
             NSDictionary *dic = responseObject;
            _originlist = [ProductModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
             self.dataList = [_originlist copy];
             [self.collectionView reloadData];
        }];
        
        self.type = LxCustomAlertTypeSheet;
        self.maskView.alpha = 1;
        self.offsetBotom = 20;
        self.width = kScreenWidth - 26;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        LxEmptyView *emptyView = [LxEmptyView emptyViewWithImageStr:@"无搜索" titleStr:@"未找到相关产品" detailStr:nil];
        emptyView.imageSize = CGSizeMake(100, 100);
        emptyView.contentViewY = 20;
        self.collectionView.ly_emptyView = emptyView;
        [self creatCollection];
        
        IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
        manager.keyboardDistanceFromTextField = 230;
        
    }
    return self;
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.searbar.delegate = self;
    self.searbar.showsCancelButton = NO;
    self.searbar.layer.cornerRadius = 18;
    self.searbar.layer.masksToBounds = YES;
    
    
    UIOffset offset = {0,0};
    self.searbar.searchTextPositionAdjustment = offset;
    
    UITextField *searchTextField = [self.searbar valueForKey:@"_searchField"];
    
    searchTextField.font = [UIFont systemFontOfSize:14];
    searchTextField.backgroundColor = [MyColor colorWithHexString:@"#F4F6FB"];
    [self.searbar setImage:[UIImage imageNamed:@"icon_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
     [self.searbar setImage:[UIImage imageNamed:@"icon_close"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [self.searbar setPositionAdjustment:UIOffsetMake(-5, 0) forSearchBarIcon:UISearchBarIconSearch];
    self.searbar.backgroundImage = [UIImage new];
    self.searbar.backgroundColor = [MyColor colorWithHexString:@"#F4F6FB"];

}

- (void)creatCollection
{
    _layout.sectionInset=UIEdgeInsetsMake(0, 0, 10, 0);
    _layout.minimumLineSpacing= 10;
    _layout.minimumInteritemSpacing= 0;
    _layout.itemSize = CGSizeMake((kScreenWidth - 26 - 30) / 2, 20);
    [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];//滚动方向
    //設定代理
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [_collectionView registerNib:[UINib nibWithNibName:@"SeletedCell" bundle:nil] forCellWithReuseIdentifier:@"SeletedCellID"];
//    [_collectionView registerNib:[UINib nibWithNibName:@"HomeHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeHeaderViewID"];
    
    
    
}

#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    SeletedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SeletedCellID" forIndexPath:indexPath];
    
    cell.model = self.dataList[indexPath.row];
    [cell setNeedsLayout];
    return cell;
    
    
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//
//{
//
//    UICollectionReusableView *reusableview = nil;
//
//    if (kind == UICollectionElementKindSectionHeader){
//
//
//        UICollectionReusableView  *titleHeaderview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"titleHeaderviewID" forIndexPath:indexPath];
//        UILabel *label = [[UILabel alloc] init];
//        label.text = @"猜你喜欢";
//        label.font = [UIFont systemFontOfSize:13];
//        label.backgroundColor = [UIColor clearColor];
//        label.frame = CGRectMake(0, 0, kScreenWidth, 40);
//        label.textColor = [UIColor whiteColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        [titleHeaderview addSubview:label];
//        reusableview = titleHeaderview;
//
//    }
//
//    return reusableview;
//
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(0, 0);
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clikblock) {
        self.clikblock(self.dataList[indexPath.row]);
    }
    
    [self disMiss];
    
}

- (NSMutableArray *)resultArr
{
    if (!_resultArr) {
        _resultArr = [NSMutableArray array];
    }
    return _resultArr;
}

- (NSMutableArray *)originlist
{
    if (!_originlist) {
        _originlist = [NSMutableArray array];
    }
    return _originlist;
}

#pragma mark - UISearchBarDelegate -
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (searchBar.text == nil || [searchBar.text length] <= 0) {
        
        self.dataList = [self.originlist copy];
        [self.collectionView reloadData];
        [self.collectionView ly_endLoading];

        
    } else {
        
        [self searchWith:searchText];
    }
    
}

- (void)searchWith:(NSString *)searChText
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (self.resultArr) {
            [self.resultArr removeAllObjects];
        }
        
        NSInteger iEqual = 0;//全匹配
        for (ProductModel * model in self.originlist) {
            BOOL isSure = [self searchEqualToString:model.symbol string:searChText] ||
            [self searchEqualToString:model.symbolName string:searChText];
            if (isSure) {
                if ([self.resultArr containsObject:model]) {
                    continue;
                } else {
                    [self.resultArr insertObject:model atIndex:iEqual];
                    ++iEqual;
                }
            }else{
                NSString *searchString = [NSString stringWithFormat:@"%@,%@",model.symbol,model.symbolName];
                if ([searchString rangeOfString:searChText].location != NSNotFound) {
                    
                    [self.resultArr addObject:model];
                }
            }
        }
        
        self.dataList = [self.resultArr copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            [self.collectionView ly_endLoading];
        });
        
    });
    
    
}

- (BOOL) searchEqualToString:(NSString*) text string:(NSString*) searchString {
    NSString *searchText = [text lowercaseString];
    NSString *searchStr = [searchString lowercaseString];
    BOOL b = NO;
    
    if (nil != searchText && ![searchText isEqualToString:@""] &&
        nil != searchStr && ![searchStr isEqualToString:@""])
        b = [searchText isEqualToString:searchStr];
    return b;
}


@end
