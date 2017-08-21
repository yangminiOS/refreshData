//
//  ViewController.m
//  testre
//
//  Created by 杨敏 on 2017/8/19.
//  Copyright © 2017年 com.tentiy. All rights reserved.
//

/* 主要思路：
 *1.分两组   一组表示原始的数据   一组表示刷新的数据
 *
 *
 *
 */

#import "ViewController.h"
#import <MJRefresh.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

// **
@property(strong, nonatomic) UITableView *tableView;

// **
@property(strong, nonatomic) NSMutableArray *dataArray;

// **刷新的数组
@property(strong, nonatomic) NSMutableArray *reData;

// **原始的数组
@property(strong, nonatomic) NSMutableArray *orgion;

// **计数器
@property(assign, nonatomic) NSInteger num;

// **headVeiw
@property(strong, nonatomic) UIView *headView;


@end

static NSString * const identifier =@"test";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *temp =@[@"tet",@"dgc",@"ete",@"wqe",@"sdx",@"sdf",@"dfa"];
    
    self.orgion = [[NSMutableArray alloc] initWithArray:temp];
    
    [self.dataArray addObject:self.reData];
  
    [self.dataArray addObject:self.self.orgion];
    
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSMutableArray *mutable = self.dataArray[section];
    
    return mutable.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSMutableArray *array = self.dataArray[indexPath.section];
    
    cell.textLabel.text = array[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.reData.count && section==1) {
        
        return 30;
        
    }else{
        
        return 0.01;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.reData.count && section ==1) {
        
        return self.headView;


    }else{
        return nil;
    }
}



- (void)_ref{
    
    NSMutableArray *temp = [NSMutableArray array];
    
    [temp addObjectsFromArray:self.reData];
    
    [temp addObjectsFromArray:self.orgion];
    
    [self.orgion removeAllObjects];
    
    [self.orgion addObjectsFromArray:temp];
    
    [self.reData removeAllObjects];
    
    for (int i=0; i<20; i++) {
        
        NSNumber *obj = [NSNumber numberWithInteger:_num++];
        
        NSString *title = [NSString stringWithFormat:@"刷新的index:%@",obj];
        
        [self.reData addObject:title];
    }
    
    [self.tableView reloadData];
    
    [self.tableView.mj_header endRefreshing];
    
}
                                

//***************************************重写get方法

- (UIView *)headView{
    if(!_headView){
        
        UIView *headView = [[UIView alloc] init];
        
        headView.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
        
        UIButton *button = [[UIButton alloc] init];
        
        [headView addSubview:button];
        
        button.frame = headView.bounds;
        
        [button setTitle:@"上次看到这里，点击更新" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(clickREButton) forControlEvents:UIControlEventTouchUpInside ];
        
        self.headView = headView;

    }
    
    return _headView;
}

- (void) clickREButton{
    
    [self _ref];
    
    [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
    
    
}
- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
        
        _tableView.mj_header =[ MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_ref)];
        
    }
    
    return _tableView;
}




- (NSArray *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array ];
    }
    
    return _dataArray;
}

- (NSMutableArray *)reData{
    
    if(!_reData) _reData = [NSMutableArray array];
    
    return _reData;
}

- (NSMutableArray *)orgion{
    
    if(!_orgion) _orgion = [NSMutableArray array];
    
    return _orgion;
}

@end
