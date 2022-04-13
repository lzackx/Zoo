//
//  ZooHealthInstructionsView.m
//  Zoo
//
//  Created by lZackx on 04/12/2022
//

#import "ZooHealthInstructionsView.h"
#import "ZooHealthInstructionsCell.h"
#import "ZooHealthManager.h"
#import "ZooDefine.h"

@interface ZooHealthInstructionsView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, assign) CGFloat cellHeight;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, copy) NSArray *itemTitleArray;
@property(nonatomic, strong) NSString *ZooHealthInstructionsCellID;

@end

@implementation ZooHealthInstructionsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        CGFloat bg_y = kZooSizeFrom750_Landscape(89);
        _itemTitleArray = @[
            @"点击开始体检按钮开始本次的性能数据手机。",
            @"在每一个页面至少停留10秒钟，如果低于10秒钟的话，我们将会丢弃该页面的收集数据。",
            @"测试完毕之后，重新进入该页面，点击结束测试按钮。",
            @"打开控制台，查看本次的数据报告。"
        ];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, bg_y, self.zoo_width, self.zoo_height)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ZooHealthInstructionsCellID = @"ZooHealthInstructionsCell";
        [self addSubview:_tableView];
        _cellHeight = kZooSizeFrom750_Landscape(104);

    }
    return self;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.zoo_width, self.zoo_height)];
        _tableView.backgroundColor = [UIColor yellowColor];
        [_tableView registerClass:[ZooHealthInstructionsCell class] forCellReuseIdentifier:_ZooHealthInstructionsCellID];
    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _itemTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZooHealthInstructionsCell *tableCell = [self.tableView dequeueReusableCellWithIdentifier:_ZooHealthInstructionsCellID];
    if(!tableCell){
       tableCell = [[ZooHealthInstructionsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:_ZooHealthInstructionsCellID];
    }
    NSString *title = [NSString stringWithFormat:ZooLocalizedString(@"第%d步"),(int)indexPath.section + 1];
    _cellHeight = [tableCell renderUIWithTitle:title item:_itemTitleArray[indexPath.section]];
    
    return  tableCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
