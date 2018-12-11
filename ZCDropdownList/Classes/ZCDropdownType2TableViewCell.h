//
//  ZCDropdownType2TableViewCell.h
//  ZCDropdownType2TableViewCell
//
//  Created by Zc on 2018/12/6.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCDropdownListView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZCDropdownType2TableViewCell : UITableViewCell

- (void)setupModel:(ZCDropdownListItem *)model  currentShowString:(NSString *)currentShowString;

@end

NS_ASSUME_NONNULL_END
