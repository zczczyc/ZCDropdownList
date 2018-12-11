//
//  ZCViewController.m
//  ZCDropdownList
//
//  Created by zczczyc on 12/11/2018.
//  Copyright (c) 2018 zczczyc. All rights reserved.
//

#import "ZCViewController.h"
#import "ZCCommoditySegmentView.h"
#import "ZCDropdownListView.h"

@interface ZCViewController ()

@property (nonatomic, strong)ZCCommoditySegmentView *commoditySegmentView;

@end

static int kKD_SearchBarHeight = 142;

@implementation ZCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view addSubview:self.commoditySegmentView];
    
    NSMutableArray *mArray = [NSMutableArray array];
    NSArray *categoryArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13"];
    for (int i = 0; i < categoryArray.count; i++) {
        
        ZCDropdownListItem *item = [[ZCDropdownListItem alloc] initWithItem:[NSString stringWithFormat:@"%d",i] itemName:categoryArray[i]];
        [mArray addObject:item];
    }
    NSArray *select1Array = mArray;
    
    ZCDropdownListItem *item1 = [[ZCDropdownListItem alloc] initWithItem:@"1" itemName:@"到手价"];
    ZCDropdownListItem *item2 = [[ZCDropdownListItem alloc] initWithItem:@"2" itemName:@"返利最高"];
    ZCDropdownListItem *item3 = [[ZCDropdownListItem alloc] initWithItem:@"3" itemName:@"返利最低"];
    NSArray *select2Array = @[item1,item2,item3];
    
    ZCDropdownListItem *item4 = [[ZCDropdownListItem alloc] initWithItem:@"1" itemName:@"返利"];
    ZCDropdownListItem *item5 = [[ZCDropdownListItem alloc] initWithItem:@"2" itemName:@"不返利"];
    NSArray *select3Array = @[item4,item5];
    
    NSArray *allArray = @[select1Array,select2Array,select3Array];
    self.commoditySegmentView.allArray = allArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ZCCommoditySegmentView *)commoditySegmentView {
    
    if (!_commoditySegmentView) {
        _commoditySegmentView = [[ZCCommoditySegmentView alloc]initWithFrame:CGRectMake(0, kKD_SearchBarHeight, CGRectGetWidth(self.view.frame), 30) categoryArray:@[]];
    }
    return _commoditySegmentView;
}

@end
