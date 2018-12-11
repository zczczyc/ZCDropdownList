//
//  EBDropdownList.h
//  DropdownListDemo
//
//  Created by HoYo on 2018/4/17.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCDropdownListItem : NSObject

@property (nonatomic, copy, readonly) NSString *itemId;
@property (nonatomic, copy, readonly) NSString *itemName;

- (instancetype)initWithItem:(NSString*)itemId itemName:(NSString*)itemName NS_DESIGNATED_INITIALIZER;
@end


@class ZCDropdownListView;

typedef void (^ZCDropdownListViewSelectedBlock)(ZCDropdownListView *dropdownListView);

@interface ZCDropdownListView : UIView
// 字体颜色，默认 blackColor
@property (nonatomic, strong) UIColor *textColor;
// 字体默认14
@property (nonatomic, strong) UIFont *font;
// 数据源
@property (nonatomic, strong) NSArray *dataSource;
// 默认选中第一个
@property (nonatomic, assign) NSUInteger selectedIndex;
// 当前选中的DropdownListItem
@property (nonatomic, strong, readonly) ZCDropdownListItem *selectedItem;


/**
 初始化赋值数据

 @param dataSource 数据源
 @param typeInt 显示类型   1.数组套数组  2.数组里是字符串
 @return 当前view
 */
- (instancetype)initWithDataSource:(NSArray*)dataSource withType:(NSInteger)typeInt;

- (void)setViewBorder:(CGFloat)width borderColor:(UIColor*)borderColor cornerRadius:(CGFloat)cornerRadius;

- (void)setDropdownListViewSelectedBlock:(ZCDropdownListViewSelectedBlock)block;

/**
 删除背景view和tableview
 */
- (void)setupRemoveFromSuperview;

@end
