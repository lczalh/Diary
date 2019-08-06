//
//  LCZPlaceholderView.m
//  Diary
//
//  Created by 谷粒公社 on 2019/7/12.
//  Copyright © 2019 lcz. All rights reserved.
//

#import "LCZPlaceholderView.h"

@implementation LCZPlaceholderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    
    // 图标
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 75, self.frame.size.height / 2 - 75, 150, 150)];
    [self addSubview:imageView];
    imageView.image = [[UIImage imageNamed:@"wuwifi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, imageView.frame.origin.y + imageView.frame.size.height, self.frame.size.width - 30, 40)];
    [self addSubview:titleLabel];
    titleLabel.text = @"您的网络好像不太给力或暂无数据，请稍后再试";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14 * UIScreen.mainScreen.bounds.size.width / 375.0];
    titleLabel.textColor = [UIColor colorWithRed:162 / 255.0 green:160 / 255.0 blue:159 / 255.0 alpha:1];
    
    // 重新加载按钮
    UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:reloadButton];
    reloadButton.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:211 / 255.0 blue:0 / 255.0 alpha:1];
    [reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
    [reloadButton setTitleColor:[UIColor colorWithRed:110 / 255.0 green:72 / 255.0 blue:9 / 255.0 alpha:1] forState:UIControlStateNormal];
    reloadButton.titleLabel.font = [UIFont systemFontOfSize:14 * UIScreen.mainScreen.bounds.size.width / 375.0];
    reloadButton.frame = CGRectMake(self.frame.size.width / 2 - 50, titleLabel.frame.origin.y + titleLabel.frame.size.height + 20, 100, 30);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:reloadButton.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = reloadButton.bounds;
    layer.path = path.CGPath;
    reloadButton.layer.mask = layer;
    [reloadButton addTarget:self action:@selector(reloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}




/**
 重新加载事件

 @param sender uibutton
 */
- (void)reloadButtonAction:(UIButton *)sender {
    if (self.reloadButtonTap) {
        self.reloadButtonTap(sender);
    }
}


@end
