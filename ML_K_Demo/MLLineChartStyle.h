//
//  MLLineChartStyle.h
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/3/28.
//  Copyright © 2019年 ML Day. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface MLULtimateValueStyle : NSObject

@property (nonatomic, strong) UIColor *color;
// 是否空心
@property (nonatomic, assign) BOOL isHollow;
- (instancetype)init;
- (instancetype)initWithColor:(UIColor *)color isHollow:(BOOL)isHollow;

@end

NS_ASSUME_NONNULL_END



NS_ASSUME_NONNULL_BEGIN

@interface MLLineChartStyle : NSObject



@end

NS_ASSUME_NONNULL_END
