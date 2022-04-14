//
//  ZooMockDropdownListView.m
//  Zoo
//
//  Created by lZackx on 2022/4/14.

#import "ZooMockFilterListView.h"
#import "ZooMockFilterTableCell.h"
#import "ZooDefine.h"

@interface ZooMockFilterListView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) UIView *bgroundView;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, assign) CGFloat cellHeight;
@property(nonatomic, copy) NSArray *itemTitleArray;
@property(nonatomic, strong) NSString *ZooMockFilterTableCellID;

@end

@implementation ZooMockFilterListView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _bgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.zoo_width, self.zoo_height)];
        _bgroundView.alpha = 0;
        _bgroundView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_bgroundView];
        UITapGestureRecognizer *todo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [_bgroundView addGestureRecognizer:todo];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.zoo_width, 0)];
        [self addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _selectedIndex = 0;
        _cellHeight = kZooSizeFrom750_Landscape(104);
        _ZooMockFilterTableCellID = @"ZooMockFilterTableCell";
    }
    return self;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.zoo_width, 0)];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[ZooMockFilterTableCell class] forCellReuseIdentifier:_ZooMockFilterTableCellID];
    }
    return _tableView;
}

- (void)showList:(NSArray *)itemArray{
    _itemTitleArray = itemArray;
    [_tableView reloadData];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25f];
    self.tableView.frame = CGRectMake(0, 0, self.zoo_width, itemArray.count * _cellHeight);
    self.bgroundView.alpha = 0.5f;
    [UIView commitAnimations];
    self.userInteractionEnabled = YES;
}

- (void)closeList{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25f];
    self.bgroundView.alpha = 0;
    self.tableView.frame = CGRectMake(0, 0, self.zoo_width, 0);
    [UIView commitAnimations];
    self.userInteractionEnabled = NO;
}

- (void)tap{
    if (_delegate && [_delegate respondsToSelector:@selector(filterBgroundClick)]) {
        [_delegate filterBgroundClick];
    }
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _itemTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZooMockFilterTableCell *tableCell = [self.tableView dequeueReusableCellWithIdentifier:_ZooMockFilterTableCellID];
    if(!tableCell){
       tableCell = [[ZooMockFilterTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:_ZooMockFilterTableCellID];
    }
    [tableCell renderUIWithTitle:_itemTitleArray[indexPath.section]];
    [tableCell selectedColor:NO];
    if(_selectedIndex == indexPath.section){
        [tableCell selectedColor:YES];
    }
    return  tableCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndex = indexPath.section;
    [_tableView reloadData];
    if (_delegate && [_delegate respondsToSelector:@selector(filterSelectedClick)]) {
        [_delegate filterSelectedClick];
    }
}


@end
