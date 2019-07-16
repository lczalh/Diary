//
//  UITableView+Load.m
//  Diary
//
//  Created by 谷粒公社 on 2019/7/12.
//  Copyright © 2019 lcz. All rights reserved.
//

#import "UITableView+LCZPlaceholderView.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>
#import "LCZPlaceholderView.h"

@implementation UITableView (LCZPlaceholderView)

+ (void)load {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(reloadData) andSwizzledSelector:@selector(LCZ_reloadData)];
    });
}

- (void)LCZ_reloadData {
    if (self.lcz_isUseComponent) {
        [self checkEmpty];
    }
    [self LCZ_reloadData];
}


- (void)checkEmpty {
    BOOL isEmpty = YES;//flag标示
    
    id <UITableViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1;//默认一组
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self] - 1;//获取当前TableView组数
    }
    
    for (NSInteger i = 0; i <= sections; i++) {
        NSInteger rows = [dataSource tableView:self numberOfRowsInSection:i];//获取当前TableView各组行数
        if (rows) {
            isEmpty = NO;//若行数存在，不为空
        }
    }
    if (isEmpty) {//若为空，加载占位图
        if (!self.lcz_placeholderView) {//若未自定义，展示默认占位图
            [self makeDefaultPlaceholderView];
        }
        [self addSubview:self.lcz_placeholderView];
        
    }
    self.lcz_placeholderView.hidden = isEmpty == YES ? NO : YES;
    self.scrollEnabled = isEmpty == YES ? NO : YES;
    self.bounces = isEmpty == YES ? NO : YES;
}

- (void)makeDefaultPlaceholderView {
    LCZPlaceholderView *placeholderView = [[LCZPlaceholderView alloc] initWithFrame:self.bounds];
    self.lcz_placeholderView = placeholderView;
    __weak typeof(self) weakSelf = self;
    placeholderView.reloadButtonTap = ^(UIButton * _Nonnull sender) {
        if (weakSelf.lcz_reloadClick) {
            weakSelf.lcz_reloadClick(sender);
        }
    };
}

// 向placeholderView添加get方法
- (UIView *)lcz_placeholderView {
    return objc_getAssociatedObject(self, @selector(lcz_placeholderView));
}

// 向placeholderView添加set方法
- (void)setLcz_placeholderView:(UIView *)lcz_placeholderView {
    objc_setAssociatedObject(self, @selector(lcz_placeholderView), lcz_placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 向reloadButtonTap添加get方法
- (void (^)(UIButton * _Nonnull))lcz_reloadClick {
    return objc_getAssociatedObject(self, @selector(lcz_reloadClick:));
}
// 向reloadButtonTap添加set方法
- (void)setLcz_reloadClick:(void (^)(UIButton * _Nonnull))lcz_reloadClick {
    objc_setAssociatedObject(self, @selector(lcz_reloadClick:), lcz_reloadClick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)lcz_isUseComponent {
    return objc_getAssociatedObject(self, @selector(lcz_isUseComponent));
}

- (void)setLcz_isUseComponent:(BOOL)lcz_isUseComponent {
    return objc_setAssociatedObject(self, @selector(lcz_isUseComponent), @(lcz_isUseComponent), OBJC_ASSOCIATION_ASSIGN);
}

@end
