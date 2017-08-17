//
//  ViewController.m
//  XGAlertView
//
//  Created by if you on 2017/8/17.
//  Copyright © 2017年 if you. All rights reserved.
//

#import "ViewController.h"
#import "XGAlertView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSArray     *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title                     = @"XGAlertView";
    self.view.backgroundColor      = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark -- LazyLoad
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView                 = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}

-(NSArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource                = [NSArray arrayWithObjects:@"成功",@"失败",@"警告", nil];
    }
    return _dataSource;
}



#pragma mark -- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle   = UITableViewCellSelectionStyleNone;
    cell.textLabel.text   = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [[XGAlertView shareManager] showAlertViewTypewWithType:indexPath.row title:_dataSource[indexPath.row] dismissAlertAfterTime:1.5];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
