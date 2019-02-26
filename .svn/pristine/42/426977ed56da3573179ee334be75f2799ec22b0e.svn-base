//
//  PersonalVC.m
//  WaiHui
//
//  Created by liuxiang on 2019/1/3.
//  Copyright © 2019年 faxian. All rights reserved.
//

#import "PersonalVC.h"
@interface PersonalVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSArray *names;
@property (nonatomic,strong) UIImage *image;


@end
@implementation PersonalVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fd_prefersNavigationBarHidden = YES;
    [self.doneBtn hyb_addCornerRadius:5 size:CGSizeMake(kScreenWidth - 30, 44)];
    [self.headerImg hyb_addCornerRadius:28 size:CGSizeMake(56, 56)];
    self.headerView.height = 58 + 62;
    self.footerView.height = 44 + 120;
    self.tableView.tableFooterView = self.footerView;
    self.tableView.tableHeaderView = self.headerView;
    self.titles = @[@"昵称",@"名",@"姓",@"本国语全名",@"注册时间"];
    self.names = @[self.model.nickname,self.model.name,self.model.surnames,self.model.username,self.model.reg_time];
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:self.model.face_img] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    
}
- (IBAction)tapHeaderImg:(id)sender {
    
    [ZZQAvatarPicker startSelected:^(UIImage * _Nonnull image) {
        if (image) {
            self.image = image;
            [self uploadImg];
        }
    }];
    
}

- (void)uploadImg
{
    BAImageDataEntity *entity = [BAImageDataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@",Url_ImagePost];
    entity.imageType = @"jpg";
    entity.imageArray = @[self.image];
    entity.imageScale = 0.7;
    entity.fileNames = @[@"file"];
    
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    
    
    [BANetManager ba_setValue:[LxUserDefaults objectForKey:Token] forHTTPHeaderKey:@"Access-Token"];
    
    [BANetManager ba_uploadImageWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            [self profilImage:result[@"data"][@"url"]];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
        }
    } failurBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
        [BANetManager ba_clearAuthorizationHeader];
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

- (void)profilImage:(NSString *)imageStr
{
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_userAction];
    entity.needCache = NO;
    entity.parameters = @{@"types":@"21",@"Access_Token":[LxUserDefaults objectForKey:Token],@"face_img":imageStr};
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 1) {
            //成功
            self.model.face_img = imageStr;
            [self.headerImg setImage:self.image];
            [SVProgressHUD dismiss];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:result[@"message"]];
            
        }
        
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.userInfo[@"NSDebugDescription"]];
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}


#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, 47.5, kScreenWidth, .5)];
        view.backgroundColor = [MyColor colorWithHexString:@"#F1F1F8"];
        [cell.contentView addSubview:view];
        
    }
    
    cell.textLabel.text = self.titles[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [MyColor colorWithHexString:@"#3D478B"];
    
    cell.detailTextLabel.textColor = [MyColor colorWithHexString:@"#747898"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = self.names[indexPath.row];
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}
- (IBAction)doneAC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FillNickNameVC *vc = [FillNickNameVC new];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.names = @[self.model.nickname,self.model.name,self.model.surnames,self.model.username,self.model.reg_time];
    [self.tableView reloadData];
}

@end
