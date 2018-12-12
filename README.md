### ZCDropdownList

![图片](imags/01.gif)

一：
```ruby
pod 'ZCDropdownList', '~> 0.1.1'
```

二：

```#import "ZCDropdownListView.h"```

三：
```

ZCDropdownListItem *item1 = [[ZCDropdownListItem alloc] initWithItem:@"1" itemName:@"到手价"];
ZCDropdownListItem *item2 = [[ZCDropdownListItem alloc] initWithItem:@"2" itemName:@"返利最高"];
ZCDropdownListItem *item3 = [[ZCDropdownListItem alloc] initWithItem:@"3" itemName:@"返利最低"];
NSArray *select1Array = @[item1,item2,item3];


ZCDropdownListView *dropdownListView = [[ZCDropdownListView alloc] initWithDataSource:select1Array withType:2];
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
```


