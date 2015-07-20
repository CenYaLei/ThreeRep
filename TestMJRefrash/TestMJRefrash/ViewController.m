//
//  ViewController.m
//  TestMJRefrash
//
//  Created by qianfeng on 15-7-8.
//  Copyright (c) 2015年 CenYaLei. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "AFHTTPRequestOperationManager.h"
#import "MMProgressHUD.h"
#import "App.h"

#import "NetInterface.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign,nonatomic)int count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _urlstring = LIMIT_URL;
    _currentPage = 1;
    _categoryId = @"";
    
    _dataArray = [[NSMutableArray alloc]init];
    [self startDownloadData];
    /**
     *  调用刷新的方法
     */
    [self refrash];
 
    
    
    
    
    
}
//开始下载数据
-(void)startDownloadData
{
    
    
    
    //注意: 程序刚开始的时候不需要显示, 显示则显示位置有问题
    if(_isShowHUD == NO)
    {
        _isShowHUD = YES;
    }
    else
    {
        // 显示一个HUB进度表 显示....
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
        [MMProgressHUD showWithTitle:nil status:@"正在加载数据"];
    }
    
     NSLog(@"urlString = %@",self.urlstring);
    NSString *urlString = [NSString stringWithFormat:self.urlstring,_currentPage,self.categoryId];
    
    NSLog(@"urlString = %lu",_currentPage);
    
     NSLog(@"urlString = %@",self.categoryId);
    
     NSLog(@"urlString = %@",urlString);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //此处设置后返回的默认是NSData的数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        //转换为词典数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"dict = %@",dict);
        
        NSMutableArray *tmpDataArray = [[NSMutableArray alloc] init];
        
        NSArray *arr = [dict objectForKey:@"applications"];
        for (NSDictionary *appDict in arr) {
            
            //创建数据模型对象,加入数据数组
            App *model = [App appWithDict:appDict];
            
            NSLog(@"name =  :%@",model.name);
            [tmpDataArray addObject:model];
        }
        
        
        //如果是需要显示第一页, 则清空以前的数据
        //注意: 清空数据之后需要立即刷新tableView
        if(_currentPage == 1)
        {
            [_dataArray removeAllObjects];
        }
        [_dataArray addObjectsFromArray:tmpDataArray];
        
   
        //刷新列表
        [_tableView reloadData];
        

        
        [MMProgressHUD dismissWithSuccess:@"成功下载了"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

//显示刷新条
-(void)refrash
{

    self.count = 10;
    
//    __weak typeof(self) weakSelf = self;
    __weak UITableView *tableView = self.tableView;
    
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _currentPage = 1;
            [self startDownloadData];
            [tableView.header endRefreshing];
        });
    }];
    tableView.header.autoChangeAlpha = YES;
    
    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _currentPage++;
            [self startDownloadData];
            [tableView.footer endRefreshing];
        });
    }];
    tableView.footer.autoChangeAlpha = YES;
    //以免上拉刷新控件被tabBAr遮挡
   
 tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"_dataArray.count = %lu",_dataArray.count);
    return _dataArray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@""];
    App *app = _dataArray[indexPath.row];
    
    cell.textLabel.text = app.name;
    
    return cell;
    
}
#pragma mark tableViewCell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 100;

}
@end
