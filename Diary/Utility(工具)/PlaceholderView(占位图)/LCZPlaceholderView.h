//
//  LCZPlaceholderView.h
//  Diary
//
//  Created by 谷粒公社 on 2019/7/12.
//  Copyright © 2019 lcz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCZPlaceholderView : UIView

/**
 重新加载事件
 */
@property (nonatomic, copy) void (^reloadButtonTap)(UIButton *sender);

@end

NS_ASSUME_NONNULL_END
