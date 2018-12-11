//
//  ZCDropdownType1TableViewCell.m
//  ZCDropdownType1TableViewCell
//
//  Created by Zc on 2018/12/6.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import "ZCDropdownType1TableViewCell.h"
#import "ZCDropdownListView.h"

@interface ZCDropdownType1TableViewCell ()

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong)UIButton *selectBtn1;

@property (nonatomic, strong)UIButton *selectBtn2;

@property (nonatomic, strong)UIButton *selectBtn3;

@end

#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)

@implementation ZCDropdownType1TableViewCell

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        [self p_setupUI];
        [self p_setupFrame];
    }
    return self;
    
}


- (void)p_setupUI {
    
    NSInteger width = kScreenWidth / 3;
    
    self.selectBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn1.frame = CGRectMake(5, 5, width - 10, 30);
    [self.selectBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.selectBtn1.titleLabel.font = [UIFont systemFontOfSize:18];
    self.selectBtn1.backgroundColor = RGB(240, 240, 240);
    self.selectBtn1.layer.borderColor = RGB(240, 240, 240).CGColor;
    self.selectBtn1.layer.borderWidth = 1.0;
    self.selectBtn1.layer.cornerRadius = 5;
    self.selectBtn1.tag = 0;
    [self.selectBtn1 addTarget:self action:@selector(p_selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectBtn1];
    
    self.selectBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn2.frame = CGRectMake(width + 5, 5, width - 10, 30);
    [self.selectBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.selectBtn2.titleLabel.font = [UIFont systemFontOfSize:18];
    self.selectBtn2.backgroundColor = RGB(240, 240, 240);
    self.selectBtn2.layer.borderColor = RGB(240, 240, 240).CGColor;
    self.selectBtn2.layer.borderWidth = 1.0;
    self.selectBtn2.layer.cornerRadius = 5;
    self.selectBtn2.tag = 1;
    [self.selectBtn2 addTarget:self action:@selector(p_selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectBtn2];
    
    self.selectBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn3.frame = CGRectMake(width * 2 + 5, 5, width - 10, 30);
    [self.selectBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.selectBtn3.titleLabel.font = [UIFont systemFontOfSize:18];
    self.selectBtn3.backgroundColor = RGB(240, 240, 240);
    self.selectBtn3.layer.borderColor = RGB(240, 240, 240).CGColor;
    self.selectBtn3.layer.borderWidth = 1.0;
    self.selectBtn3.layer.cornerRadius = 5;
    self.selectBtn3.tag = 2;
    [self.selectBtn3 addTarget:self action:@selector(p_selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectBtn3];
}

- (void)p_setupFrame {
    
    
}

- (void)setupDataArray:(NSArray *)dataArray currentShowString:(NSString *)currentShowString {
    
    self.dataArray = dataArray;
    if (dataArray.count == 1) {
        ZCDropdownListItem *item = dataArray[0];
        [self.selectBtn1 setTitle:item.itemName forState:UIControlStateNormal];
        //self.selectBtn1.tag = [item.itemId integerValue];
        if ([self p_itemName:item.itemName currentShowString:currentShowString]) {
            [self.selectBtn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        
        self.selectBtn2.hidden = YES;
        self.selectBtn3.hidden = YES;
    }
    if (dataArray.count == 2) {
        ZCDropdownListItem *item1 = dataArray[0];
        [self.selectBtn1 setTitle:item1.itemName forState:UIControlStateNormal];
        //self.selectBtn1.tag = [item1.itemId integerValue];
        if ([self p_itemName:item1.itemName currentShowString:currentShowString]) {
            [self.selectBtn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        ZCDropdownListItem *item2 = dataArray[1];
        [self.selectBtn2 setTitle:item2.itemName forState:UIControlStateNormal];
        //self.selectBtn2.tag = [item2.itemId integerValue];
        if ([self p_itemName:item2.itemName currentShowString:currentShowString]) {
            [self.selectBtn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        self.selectBtn3.hidden = YES;
    }
    if (dataArray.count == 3) {
        ZCDropdownListItem *item1 = dataArray[0];
        [self.selectBtn1 setTitle:item1.itemName forState:UIControlStateNormal];
        //self.selectBtn1.tag = [item1.itemId integerValue];
        if ([self p_itemName:item1.itemName currentShowString:currentShowString]) {
            [self.selectBtn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        
        ZCDropdownListItem *item2 = dataArray[1];
        [self.selectBtn2 setTitle:item2.itemName forState:UIControlStateNormal];
        //self.selectBtn2.tag = [item2.itemId integerValue];
        if ([self p_itemName:item2.itemName currentShowString:currentShowString]) {
            [self.selectBtn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        
        ZCDropdownListItem *item3 = dataArray[2];
        [self.selectBtn3 setTitle:item3.itemName forState:UIControlStateNormal];
       // self.selectBtn3.tag = [item3.itemId integerValue];
        if ([self p_itemName:item3.itemName currentShowString:currentShowString]) {
            [self.selectBtn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }
}

- (BOOL)p_itemName:(NSString *)itemName currentShowString:(NSString *)currentShowString {
    
    if ([itemName isEqualToString:currentShowString]) {
        return YES;
    }
    return NO;
}

- (void)p_selectClick:(UIButton *)sender {
    
    if (self.dropdownTableViewCell1Block) {
        self.dropdownTableViewCell1Block(self.dataArray[sender.tag]);
    }
    
//    NSLog(@"%@",self.dataArray[sender.tag]);
    
}

@end
