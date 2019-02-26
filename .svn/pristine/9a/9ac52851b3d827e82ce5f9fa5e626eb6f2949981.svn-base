//
//  SeletedAlert.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/10.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "LxCustomAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface SeletedAlert : LxCustomAlert<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UISearchBar *searbar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic, retain) NSMutableArray   * resultArr;
@property (nonatomic,strong)  NSMutableArray *originlist;
@property (nonatomic,copy) void(^clikblock)(ProductModel *model) ;



- (instancetype)initSeletedAlert;

@end

NS_ASSUME_NONNULL_END
