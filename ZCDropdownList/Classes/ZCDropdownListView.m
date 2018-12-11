//
//  ZCDropdownList.m
//  DropdownListDemo
//
//  Created by HoYo on 2018/4/17.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import "ZCDropdownListView.h"
#import "ZCDropdownType1TableViewCell.h"
#import "ZCDropdownType2TableViewCell.h"
#import "ZCTableViewAnimationKitHeaders.h"

@interface ZCDropdownListView ()

/**
 使用哪种样式
 */
@property (nonatomic, assign) NSInteger typeInt;

@property (nonatomic, copy) NSString *currentShowString;

/**
 当前是否是打开状态
 */
@property (nonatomic, assign) BOOL isOpen;

@end

@implementation ZCDropdownListItem

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

static NSString *identifier1 = @"ZCDropdownType1TableViewCell";
static NSString *identifier2 = @"ZCDropdownType2TableViewCell";

- (instancetype)initWithItem:(NSString*)itemId itemName:(NSString*)itemName {
    self = [super init];
    if (self) {
        _itemId = itemId;
        _itemName = itemName;
    }
    return self;
}

- (instancetype)init {
    return [self initWithItem:nil itemName:nil];
}
@end


@interface ZCDropdownListView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *arrowImg;
@property (nonatomic, strong) UITableView *tbView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, copy) ZCDropdownListViewSelectedBlock selectedBlock;
@end

static CGFloat const kArrowImgHeight= 10;
static CGFloat const kArrowImgWidth= 15;
static CGFloat const kTextLabelX = 5;
static CGFloat const kItemCellHeight = 50;

@implementation ZCDropdownListView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self setupProperty];
    }
    return self;
}

/**
 初始化赋值数据
 
 @param dataSource 数据源
 @param typeInt 显示类型   1.数组套数组  2.数组里是字符串
 @return 当前view
 */
- (instancetype)initWithDataSource:(NSArray*)dataSource withType:(NSInteger)typeInt {
    self.typeInt = typeInt;
    if (typeInt == 1) {
        _dataSource = [self p_getNewDataArray:dataSource];
    }else if (typeInt == 2){
        _dataSource = dataSource;
    }
    
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupFrame];
}

#pragma mark - Setup
- (void)setupProperty {
    _textColor = [UIColor blackColor];
    _font = [UIFont systemFontOfSize:14];
    _selectedIndex = 0;
    _textLabel.font = _font;
    _textLabel.textColor = _textColor;
    _textLabel.textAlignment = NSTextAlignmentCenter;
    
    
    UITapGestureRecognizer *tapLabel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewExpand:)];
    [_textLabel addGestureRecognizer:tapLabel];
    
    UITapGestureRecognizer *tapImg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewExpand:)];
    [_arrowImg addGestureRecognizer:tapImg];
}

- (void)setupView {
    [self addSubview:self.textLabel];
    [self addSubview:self.arrowImg];
}

- (void)setupFrame {
    CGFloat viewWidth = CGRectGetWidth(self.bounds)
    , viewHeight = CGRectGetHeight(self.bounds);
    
    _textLabel.frame = CGRectMake(kTextLabelX, 0, viewWidth - kTextLabelX - kArrowImgWidth , viewHeight);
    _arrowImg.frame = CGRectMake(CGRectGetWidth(_textLabel.frame), viewHeight / 2 - kArrowImgHeight / 2, kArrowImgWidth, kArrowImgHeight);
}
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#pragma mark - Events
-(void)tapViewExpand:(UITapGestureRecognizer *)sender {
    
    [self p_setupAllFrame];
    
    if (_isOpen) {

        [self removeBackgroundView];
    } else {

        [self rotateArrowImage];
        
        for (UILabel *l in sender.view.superview.subviews) {
            if ([l isKindOfClass:[UILabel class]]) {
                self.currentShowString = l.text;
            }
        }
        
        CGFloat tableHeight = _dataSource.count * kItemCellHeight;
        
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self.backgroundView];
        [window addSubview:self.tbView];
        
        // 获取按钮在屏幕中的位置
        CGRect frame = [self convertRect:self.bounds toView:window];
        CGFloat tableViewY = frame.origin.y + frame.size.height;
        CGRect tableViewFrame;
        tableViewFrame.size.width = kScreenWidth;
        tableViewFrame.size.height = tableHeight;
        tableViewFrame.origin.x = 0;
        if (tableViewY + tableHeight < CGRectGetHeight([UIScreen mainScreen].bounds)) {
            tableViewFrame.origin.y = tableViewY;
        }else {
            tableViewFrame.origin.y = frame.origin.y - tableHeight;
        }
        tableViewFrame.size.height = tableHeight;
        
        _tbView.frame = tableViewFrame;
        
        [self p_setupBackgroundViewFrame];
        
        UITapGestureRecognizer *tagBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewDismiss:)];
        [_backgroundView addGestureRecognizer:tagBackground];
        
        [_tbView reloadData];
        [self starAnimationWithTableView:self.tbView];
        self.isOpen = !self.isOpen;
    }
    
    
    
    
}

- (void)p_setupBackgroundViewFrame {
    
    CGRect frame = self.backgroundView.frame;
    frame.origin.y = self.tbView.frame.origin.y;
    self.backgroundView.frame = frame;
}

- (void)p_setupAllFrame {
    
    for (UIView *subview in self.superview.subviews) {
        if ([subview isKindOfClass:[ZCDropdownListView class]] && subview != self) {
            ZCDropdownListView *dropdownListView = (ZCDropdownListView *)subview;
            if (dropdownListView.isOpen) {
                [dropdownListView removeBackgroundView];
                dropdownListView.isOpen = NO;
            }
        }
    }
}

-(void)tapViewDismiss:(UITapGestureRecognizer *)sender {
    [self removeBackgroundView];
}

#pragma mark - Methods
- (void)setDropdownListViewSelectedBlock:(ZCDropdownListViewSelectedBlock)block {
    _selectedBlock = block;
}

- (void)setViewBorder:(CGFloat)width borderColor:(UIColor*)borderColor cornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = width;
}

- (void)rotateArrowImage {
    // 旋转箭头图片
    _arrowImg.transform = CGAffineTransformRotate(_arrowImg.transform, M_PI);
}

- (void)removeBackgroundView {
    [self setupRemoveFromSuperview];
//    [self rotateArrowImage];
    
}

/**
 删除背景view和tableview
 */
- (void)setupRemoveFromSuperview {
    if (_backgroundView) {
        [_backgroundView removeFromSuperview];
    }
    if (_tbView) {
        [_tbView removeFromSuperview];
    }
    if (_isOpen) {
        [self rotateArrowImage];
        self.isOpen = !self.isOpen;
    }
    
}

- (void)selectedItemAtIndex:(NSInteger)index {
    _selectedIndex = index;
    if (index < _dataSource.count) {
        ZCDropdownListItem *item;
        if (self.typeInt == 1) {
            NSArray *array = _dataSource[index];
            item = array[0];
        }else{
            item = _dataSource[index];
        }
        _selectedItem = item;
        _textLabel.text = item.itemName;
    }
    
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.scrollEnabled = NO;
//    tableView.bounces = NO;
    
    if (self.typeInt == 1) {
        ZCDropdownType1TableViewCell *cell = [[ZCDropdownType1TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        [cell setupDataArray:self.dataSource[indexPath.row] currentShowString:self.currentShowString];
        cell.dropdownTableViewCell1Block = ^(ZCDropdownListItem *item) {
            [self p_removeBackgroundViewitem:item];
            self->_selectedItem = item;
            
            if (self->_selectedBlock) {
                self->_selectedBlock(self);
            }
        };
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (self.typeInt == 2) {
        ZCDropdownType2TableViewCell *cell = [[ZCDropdownType2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
        [cell setupModel:self.dataSource[indexPath.row] currentShowString:self.currentShowString];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.typeInt == 2) {
        [self selectedItemAtIndex:indexPath.row];
        [self removeBackgroundView];
        if (_selectedBlock) {
            _selectedBlock(self);
        }
    }
    
}

- (void)p_removeBackgroundViewitem:(ZCDropdownListItem *) item{
    _textLabel.text = item.itemName;
    [self removeBackgroundView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

#pragma mark - Setter

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    if (dataSource.count > 0) {
        [self selectedItemAtIndex:_selectedIndex];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [self selectedItemAtIndex:selectedIndex];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    _textLabel.font = font;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _textLabel.textColor = textColor;
}
#pragma mark - Getter
- (UILabel*)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.userInteractionEnabled = YES;
    }
    return _textLabel;
}

- (UIImageView*)arrowImg {
    if (!_arrowImg) {
        _arrowImg = [UIImageView new];
        _arrowImg.image = [self p_getBundleImg:@"dropdownFlag"];
        
        _arrowImg.userInteractionEnabled = YES;
    }
    return _arrowImg;
}

- (UIImage *)p_getBundleImg:(NSString *)imgName {
    
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSURL *url = [bundle URLForResource:@"ZCDropdownList" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    UIImage *image = [UIImage imageNamed:imgName inBundle:imageBundle compatibleWithTraitCollection:nil];
    
    return image;
}

- (UITableView*)tbView {
    if (!_tbView) {
        _tbView = [UITableView new];
        _tbView.dataSource = self;
        _tbView.delegate = self;
        _tbView.tableFooterView = [UIView new];
        _tbView.backgroundColor = [UIColor whiteColor];
        _tbView.layer.shadowOffset = CGSizeMake(4, 4);
        _tbView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _tbView.layer.shadowOpacity = 0.8;
        _tbView.layer.shadowRadius = 4;
        _tbView.layer.borderColor = [UIColor grayColor].CGColor;
        _tbView.layer.borderWidth = 0.5;
        _tbView.clipsToBounds = NO;
        _tbView.rowHeight = kItemCellHeight;
        
        [_tbView registerClass:[ZCDropdownType1TableViewCell class] forCellReuseIdentifier:identifier1];
        [_tbView registerClass:[ZCDropdownType2TableViewCell class] forCellReuseIdentifier:identifier2];
    }
    return _tbView;
}

- (UIView*)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, kScreenHeight - 150)];
        _backgroundView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
//        _backgroundView.backgroundColor = [UIColor redColor];
        _backgroundView.alpha = 0.3;
    }
    return _backgroundView;
}

- (void)starAnimationWithTableView:(UITableView *)tableView {
    
    [ZCTableViewAnimationKit showWithAnimationType:2 tableView:tableView];
}

- (NSArray *)p_getNewDataArray:(NSArray *)arr {
    
    NSInteger index = 0;
    if (arr.count % 3 == 1 || arr.count % 3 == 2) {
        index = 1;
    }
    NSInteger cellCount =  arr.count / 3 + index;
    NSInteger totalCount = arr.count;
    // for 循环一次取2个数据，放进cell里面；
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < cellCount; i++) {
        NSMutableArray *array = @[].mutableCopy;
        
        if(i * 3 < totalCount){
            [array addObject:arr[i*3]];
        }
        if((i*3+1)<totalCount){
            [array addObject:arr[i*3+1]];
        }
        if((i*3+2)<totalCount){
            [array addObject:arr[i*3+2]];
        }
        
        [dataArray addObject:array];
    }
    return dataArray;
}

@end
