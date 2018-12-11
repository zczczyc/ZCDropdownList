//
//  KDKCommoditySegmentView.m
//  KDClient
//
//  Created by Zc on 2018/12/5.
//  Copyright © 2018年 Zc. All rights reserved.
//

#import "ZCCommoditySegmentView.h"
//#import "Masonry.h"
#import "ZCDropdownListView.h"

@interface ZCCommoditySegmentView ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *select1View;

@property (nonatomic, strong) UIView *select2View;

@property (nonatomic, strong) UIView *select3View;

@property (nonatomic, strong) UIView *showChildSelect1View;

@property (nonatomic, strong) UIView *showChildSelect2View;

@property (nonatomic, strong) UIView *showChildSelect3View;


@end

@implementation ZCCommoditySegmentView

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width


- (instancetype)initWithFrame:(CGRect)frame categoryArray:(NSArray *)categoryArray{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setAllArray:(NSArray *)allArray {
    _allArray = allArray;
    
    [self p_setupUI];
}

- (void)p_setupUI {
    
    ZCDropdownListView *dropdownListView = [[ZCDropdownListView alloc] initWithDataSource:self.allArray[0] withType:1];
    dropdownListView.frame = CGRectMake(0, 0, kScreenWidth/3, 30);
    dropdownListView.selectedIndex = 0;
    //    dropdownListView.categoryName = @"分类";
    [dropdownListView setViewBorder:0.5 borderColor:[UIColor grayColor] cornerRadius:2];
    [self addSubview:dropdownListView];
    
    [dropdownListView setDropdownListViewSelectedBlock:^(ZCDropdownListView *dropdownListView) {
        NSString *msgString = [NSString stringWithFormat:
                               @"selected name:%@  id:%@"
                               , dropdownListView.selectedItem.itemName
                               , dropdownListView.selectedItem.itemId];
        
        NSLog(@"%@",msgString);
    }];
    
    ZCDropdownListView *dropdownListView1 = [[ZCDropdownListView alloc] initWithDataSource:self.allArray[1] withType:2];
    dropdownListView1.frame = CGRectMake(kScreenWidth/3, 0, kScreenWidth/3, 30);
    dropdownListView1.selectedIndex = 0;
    [dropdownListView1 setViewBorder:0.5 borderColor:[UIColor grayColor] cornerRadius:2];
    [self addSubview:dropdownListView1];
    
    [dropdownListView1 setDropdownListViewSelectedBlock:^(ZCDropdownListView *dropdownListView) {
        NSString *msgString = [NSString stringWithFormat:
                               @"selected name:%@  id:%@"
                               , dropdownListView.selectedItem.itemName
                               , dropdownListView.selectedItem.itemId];
        
        NSLog(@"%@",msgString);
    }];
    
    ZCDropdownListView *dropdownListView3 = [[ZCDropdownListView alloc] initWithDataSource:self.allArray[2] withType:2];
    dropdownListView3.frame = CGRectMake(kScreenWidth/3*2, 0, kScreenWidth/3, 30);
    dropdownListView3.selectedIndex = 0;
    [dropdownListView3 setViewBorder:0.5 borderColor:[UIColor grayColor] cornerRadius:2];
    [self addSubview:dropdownListView3];
    
    [dropdownListView3 setDropdownListViewSelectedBlock:^(ZCDropdownListView *dropdownListView) {
        NSString *msgString = [NSString stringWithFormat:
                               @"selected name:%@  id:%@"
                               , dropdownListView.selectedItem.itemName
                               , dropdownListView.selectedItem.itemId];
        
        NSLog(@"%@",msgString);
    }];
    
}

/**
 删除背景view和tableview
 */
- (void)setupRemoveFromSuperview {
    
    for (ZCDropdownListView *dropdownListView in self.subviews) {
        if ([dropdownListView isKindOfClass:[ZCDropdownListView class]]) {
            [dropdownListView setupRemoveFromSuperview];
        }
    }
}

@end
