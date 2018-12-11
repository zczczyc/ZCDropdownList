//
//  EBDropdownTableViewCell1.h
//  DropdownListDemo
//
//  Created by Zc on 2018/12/6.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZCDropdownListItem;
typedef void(^EBDropdownTableViewCell1Block)(ZCDropdownListItem *item);

@interface ZCDropdownType1TableViewCell : UITableViewCell

@property (nonatomic, copy) EBDropdownTableViewCell1Block dropdownTableViewCell1Block;

- (void)setupDataArray:(NSArray *)dataArray currentShowString:(NSString *)currentShowString;

@end

NS_ASSUME_NONNULL_END
