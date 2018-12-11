//
//  KDKCommoditySegmentView.h
//  KDClient
//
//  Created by Zc on 2018/12/5.
//  Copyright © 2018年 Zc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCCommoditySegmentView : UIView


@property (nonatomic, strong) NSArray *allArray;

- (instancetype)initWithFrame:(CGRect)frame categoryArray:(NSArray *)categoryArray;

/**
 删除背景view和tableview
 */
- (void)setupRemoveFromSuperview;


@end

NS_ASSUME_NONNULL_END
