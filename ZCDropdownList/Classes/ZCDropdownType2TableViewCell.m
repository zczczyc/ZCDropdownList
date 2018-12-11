//
//  ZCDropdownType2TableViewCell.m
//  ZCDropdownType2TableViewCell
//
//  Created by Zc on 2018/12/6.
//  Copyright © 2018年 HoYo. All rights reserved.
//


#import "ZCDropdownType2TableViewCell.h"


@interface ZCDropdownType2TableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *img;

@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation ZCDropdownType2TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self p_setupUI];
        [self p_setupFrame];
    }
    return self;
    
}


- (void)p_setupUI {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.img];
}

- (void)p_setupFrame {
    
    
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
    }
    return _titleLabel;
}

- (UIImageView *)img {
    
    if (!_img) {
        _img = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 50, 18, 20, 15)];
        _img.image = [UIImage imageNamed:@"currentShowImg"];
        _img.hidden = YES;
    }
    
    return _img;
}

- (void)setupModel:(ZCDropdownListItem *)model  currentShowString:(NSString *)currentShowString {
    
    self.titleLabel.text = model.itemName;
    
    if ([self p_itemName:model.itemName currentShowString:currentShowString]) {
        self.titleLabel.textColor = [UIColor redColor];
        self.img.hidden = NO;
    }
}

- (BOOL)p_itemName:(NSString *)itemName currentShowString:(NSString *)currentShowString {
    
    if ([itemName isEqualToString:currentShowString]) {
        return YES;
    }
    return NO;
}

@end
