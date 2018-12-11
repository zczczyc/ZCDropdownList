//
//  UITableView+ZCAnimationKit.h
//  ZCTableViewAnimationKit-OC
//
//  Created by 王小树 on 17/9/9.
//  Copyright © 2017年 com.cn.fql. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCTableViewAnimationKitConfig.h"

@interface UITableView (ZCAnimationKit)

/**
 show the tableView animation 
 
 @param animationType type of animation to show TableView
 */
- (void)zc_showTableViewAnimationWithType:(ZCTableViewAnimationType )animationType;


@end
