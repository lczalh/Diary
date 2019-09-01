//
//  NSObject+Swizzling.h
//  LCZDemo
//
//  Created by 谷粒公社 on 2019/5/22.
//  Copyright © 2019 lcz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)

/**
 方法交换

 @param originalSelector 源方法
 @param swizzledSelector 新方法
 */
+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector
                        andSwizzledSelector:(SEL)swizzledSelector;
@end

NS_ASSUME_NONNULL_END
