//
//  UITableView+ZCAnimationKit.m
//  ZCTableViewAnimationKit-OC
//
//  Created by 王小树 on 17/9/9.
//  Copyright © 2017年 com.cn.fql. All rights reserved.
//

#import "UITableView+ZCAnimationKit.h"
#import "ZCTableViewAnimationKit.h"

@implementation UITableView (ZCAnimationKit)

- (void)zc_showTableViewAnimationWithType:(ZCTableViewAnimationType)animationType{
    [ZCTableViewAnimationKit showWithAnimationType:animationType tableView:self];
}

@end
