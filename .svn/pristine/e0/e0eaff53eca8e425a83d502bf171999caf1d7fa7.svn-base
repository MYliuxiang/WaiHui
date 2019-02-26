//
//  QSearchVC.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/10.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "QSearchVC.h"
#import "CXDBHandle.h"

static NSString *const cxSearchCollectionViewCell = @"CXSearchCollectionViewCell";

static NSString *const headerViewIden = @"HeadViewIden";
@interface QSearchVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet SelectCollectionLayout *layout;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;


/**
 *  存储网络请求的热搜，与本地缓存的历史搜索model数组
 */
@property (nonatomic, strong) NSMutableArray *sectionArray;
/**
 *  存搜索的数组 字典
 */
@property (nonatomic,strong) NSMutableArray *searchArray;


@property (assign,nonatomic)CGFloat fistHeight;

@end

@implementation QSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"交易品种查询";
    self.activityView.hidden = YES;
    [self wr_setNavBarShadowImageHidden:YES];
    
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = NO;
    self.searchBar.layer.cornerRadius = 18;
    self.searchBar.layer.masksToBounds = YES;
    
    
    UIOffset offset = {0,0};
    self.searchBar.searchTextPositionAdjustment = offset;
    
    UITextField *searchTextField = [self.searchBar valueForKey:@"_searchField"];
    
    searchTextField.font = [UIFont systemFontOfSize:14];
    searchTextField.backgroundColor = [MyColor colorWithHexString:@"#F4F6FB"];
    [self.searchBar setImage:[UIImage imageNamed:@"icon_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self.searchBar setImage:[UIImage imageNamed:@"icon_close"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [self.searchBar setPositionAdjustment:UIOffsetMake(-5, 0) forSearchBarIcon:UISearchBarIconSearch];
    self.searchBar.backgroundImage = [UIImage new];
    self.searchBar.backgroundColor = [MyColor colorWithHexString:@"#F4F6FB"];
    [self.searchBar resignFirstResponder];

    [self creatCollection];
    
    
    self.tableView.ly_emptyView = [LxEmptyView emptyViewWithImageStr:@"无搜索" titleStr:@"未找到相关产品" detailStr:nil];
    
    [self loadData];
    
}

- (void)loadData{
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"10"};
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        NSLog(@"%@",result);

        if ([result[@"code"] intValue] == 1) {
            //成功
            NSLog(@"%@",result);
            NSArray *array = [HotModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            CXSearchSectionModel *sectionModel =  self.sectionArray[1];
            sectionModel.section_contentArray = array;
            [_collectionView reloadData];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            
        }
        
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

- (void)creatCollection
{
    [self prepareData];
    [self prepareHisData];

    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    SelectCollectionLayout *layout = [[SelectCollectionLayout alloc] init];
    [self.collectionView setCollectionViewLayout:layout animated:YES];
    [self.collectionView registerClass:[SelectCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIden];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CXSearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cxSearchCollectionViewCell];
   
    [self.collectionView registerNib:[UINib nibWithNibName:@"QSearchTwoCell" bundle:nil] forCellWithReuseIdentifier:@"QSearchTwoCellID"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"NotHisCell" bundle:nil] forCellWithReuseIdentifier:@"NotHisCellID"];

    
    [self.collectionView registerNib:[UINib nibWithNibName:@"NetLodingCell" bundle:nil] forCellWithReuseIdentifier:@"NetLodingCellID"];



    /***  可以做实时搜索*/
    //    [self.cxSearchTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)prepareData
{
    /**
     *  测试数据 ，字段暂时 只用一个 titleString，后续可以根据需求 相应加入新的字段
     */
    NSDictionary *testDict = @{@"section_id":@"1",@"section_title":@"搜索历史",@"section_content":@[]};
    NSMutableArray *testArray = [@[] mutableCopy];
    [testArray addObject:testDict];
    
     NSDictionary *testDict1 = @{@"section_id":@"1",@"section_title":@"热搜",@"section_content":@[]};
    [testArray addObject:testDict1];

    
    /***  去数据查看 是否有数据*/
    NSDictionary *parmDict  = @{@"category":@"1"};
    NSDictionary *dbDictionary =  [CXDBHandle statusesWithParams:parmDict];
    
    self.searchArray = [NSMutableArray array];
    self.sectionArray = [NSMutableArray array];

    if (dbDictionary.count) {
        [testArray addObject:dbDictionary];
        [self.searchArray addObjectsFromArray:dbDictionary[@"section_content"]];
    }

    for (NSDictionary *sectionDict in testArray) {
        CXSearchSectionModel *model = [[CXSearchSectionModel alloc]initWithDictionary:sectionDict];
        [self.sectionArray addObject:model];
    }
}

- (void)prepareHisData
{
    CXSearchSectionModel *model = self.sectionArray[0];
    model.section_contentArray = [LxSearchModel bg_find:nil limit:0 orderBy:@"bg_id" desc:YES];
    [self.collectionView reloadData];
}




- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.sectionArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    if (_searchArray.count == 0) {
//        return 1;
//    }
    CXSearchSectionModel *sectionModel =  self.sectionArray[section];
    return sectionModel.section_contentArray.count == 0 ?1:sectionModel.section_contentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
         CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
        if (sectionModel.section_contentArray.count == 0) {
            NotHisCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NotHisCellID" forIndexPath:indexPath];
          
            return cell;
        }else{
            
            CXSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cxSearchCollectionViewCell forIndexPath:indexPath];
            CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
            LxSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
            [cell.contentButton setTitle:contentModel.searStr forState:UIControlStateNormal];
            cell.selectDelegate = self;
            return cell;
        }
        
       
    }else{
        
        CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
        if (sectionModel.section_contentArray.count == 0) {
            NetLodingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NetLodingCellID" forIndexPath:indexPath];
            [cell setNeedsLayout];
            return cell;
        }else{
            
            QSearchTwoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QSearchTwoCellID" forIndexPath:indexPath];
            cell.model = sectionModel.section_contentArray[indexPath.row];
            [cell setNeedsLayout];
            return cell;
        }
       
    }
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        
        
      SelectCollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIden forIndexPath:indexPath];
        view.delectDelegate = self;
        CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
        [view setText:sectionModel.section_title];
        /***  此处完全 也可以自定义自己想要的模型对应放入*/
        if(indexPath.section == 0)
        {
             CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
            if (sectionModel.section_contentArray.count == 0) {
                view.delectButton.hidden = YES;

            }else{
                view.delectButton.hidden = NO;

            }
        }else{
            view.delectButton.hidden = YES;
        }
        reusableview = view;
    }
    return reusableview;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
        if (sectionModel.section_contentArray.count == 0) {
            return CGSizeMake(kScreenWidth - 50, 30);
        }
        
        if (sectionModel.section_contentArray.count > 0) {
            LxSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
            return [CXSearchCollectionViewCell getSizeWithText:contentModel.searStr];
        }
        return CGSizeMake(80, 24);
    }else{
        CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
        if (sectionModel.section_contentArray.count == 0) {
            return CGSizeMake(kScreenWidth - 50, 100);
        }
        return CGSizeMake((kScreenWidth - 30 - 1 - 30) / 3, 41);
    }
   
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
        LxSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
        self.searchBar.text = contentModel.searStr;
        _collectionView.hidden = YES;
        _tableView.hidden = NO;
        [self.view bringSubviewToFront:_tableView];
        [self searchWith:self.searchBar.text];
    }else{
       //点击
        CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
        HotModel *contentModel = sectionModel.section_contentArray[indexPath.row];
        self.searchBar.text = contentModel.searchContent;
        _collectionView.hidden = YES;
        _tableView.hidden = NO;
        [self.view bringSubviewToFront:_tableView];
        [self searchWith:self.searchBar.text];
        
    }
   
}

- (void)selectContetnBtnClick:(CXSearchCollectionViewCell *)cell
{
    NSIndexPath* indexPath = [self.collectionView indexPathForCell:cell];
    CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    LxSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
    self.searchBar.text = contentModel.searStr;
    _collectionView.hidden = YES;
    _tableView.hidden = NO;
    [self.view bringSubviewToFront:_tableView];
    [self searchWith:self.searchBar.text];
    
}

#pragma mark - SelectCollectionCellDelegate
- (void)selectButttonClick:(CXSearchCollectionViewCell *)cell;
{
    NSIndexPath* indexPath = [self.collectionView indexPathForCell:cell];
    CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    LxSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
    [LxSearchModel bg_delete:nil where:[NSString stringWithFormat:@"where %@=%@ ",bg_sqlKey(@"searStr"),bg_sqlValue(contentModel.searStr)]];
//    [self prepareHisData];
    [sectionModel.section_contentArray removeObjectAtIndex:indexPath.row];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

#pragma mark - UICollectionReusableViewButtonDelegate
- (void)delectData:(SelectCollectionReusableView *)view;
{
    
        CXSearchSectionModel *sectionModel =  self.sectionArray[0];
    if(sectionModel.section_contentArray.count > 0){
        [LxSearchModel bg_clearAsync:@"LxSearchModel" complete:^(BOOL isSuccess) {
           
        }];
        [sectionModel.section_contentArray removeAllObjects];
        [self.collectionView reloadData];
    }
        
//        [self.sectionArray removeLastObject];
//        [self.searchArray removeAllObjects];
//        [self.collectionView reloadData];
//        [CXDBHandle saveStatuses:@{} andParam:@{@"category":@"1"}];
}
#pragma mark - scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}
#pragma mark - textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        return NO;
    }
    /***  每搜索一次   就会存放一次到历史记录，但不存重复的*/
    if ([self.searchArray containsObject:[NSDictionary dictionaryWithObject:textField.text forKey:@"content_name"]]) {
        return YES;
    }
//    [self reloadData:textField.text];
    return YES;
}



#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    QSearchTCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"QSearchTCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.model = self.searchArray[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.searchArray.count == 0) {
        return .1;
    }
    return 20;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (self.searchArray.count == 0) {
        return [UIView new];
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"共有%lu个匹配结果",(unsigned long)self.searchArray.count];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [MyColor colorWithHexString:@"#D1D1DD"];
    label.frame = CGRectMake(15, 0, kScreenWidth - 20, 20);
    [view addSubview:label];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultModel *model = self.searchArray[indexPath.row];
    DetailQuotationVC *vc = [[DetailQuotationVC alloc] init];
    vc.sybol = model.symbol;
    [self.navigationController pushViewController:vc animated:YES];
        
    
    if (self.searchBar.text.length != 0) {
        LxSearchModel *model = [[LxSearchModel alloc] init];
        model.searStr = self.searchBar.text;
       
        NSArray *findArray = [LxSearchModel bg_find:nil where: [NSString stringWithFormat:@"where %@=%@ ",bg_sqlKey(@"searStr"),bg_sqlValue(self.searchBar.text)]];
        if (findArray.count != 0){
            [LxSearchModel bg_delete:nil where:[NSString stringWithFormat:@"where %@=%@ ",bg_sqlKey(@"searStr"),bg_sqlValue(self.searchBar.text)]];
        }
        
        NSArray *array = [LxSearchModel bg_findAll:nil];
        if (array.count >= 10) {
            [LxSearchModel bg_deleteFirstObject:nil];
        }
        [model bg_saveOrUpdate];
        [self prepareHisData];

    }
    
    
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
        _collectionView.hidden = NO;
        _tableView.hidden = YES;
        [self.view bringSubviewToFront:_collectionView];
    } else {
        _collectionView.hidden = YES;
        _tableView.hidden = NO;
        [self.view bringSubviewToFront:_tableView];
        [self searchWith:searchText];
        
        
    }
    
}

- (void)searchWith:(NSString *)searStr
{
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    
    entity.parameters = @{@"types":@"6",@"mt4_id":[NSString stringWithFormat:@"%@",[LxUserDefaults objectForKey:Mt4_id]],@"content":searStr};
    self.activityView.hidden = NO;
    [self.view bringSubviewToFront:self.activityView];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            self.activityView.hidden = YES;
            self.searchArray = [ResultModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            [self.tableView reloadData];
            [self.tableView ly_endLoading];

        }else{
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
        }
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

@end
