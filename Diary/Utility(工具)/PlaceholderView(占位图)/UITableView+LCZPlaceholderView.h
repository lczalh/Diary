//
//  UITableView+Load.h
//  Diary
//
//  Created by 谷粒公社 on 2019/7/12.
//  Copyright © 2019 lcz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (LCZPlaceholderView)

/**
 自定义占位视图 
 */
@property (nonatomic, strong) UIView *lcz_placeholderView;
/**
 重新加载事件
 */
@property (nonatomic, copy) void (^lcz_reloadClick)(UIButton *sender);

/**
 当前tableView是否是需要使用LCZPlaceholderView组件 避免与其它第三方库中的tableView冲突 所以需要设置此属性 yes：启用 no：禁用
 */
@property (nonatomic, assign) BOOL lcz_isUseComponent;
@end

NS_ASSUME_NONNULL_END
