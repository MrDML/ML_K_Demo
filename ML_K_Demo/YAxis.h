//
//  YAxis.h
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/3/28.
//  Copyright © 2019年 ML Day. All rights reserved.
//

#import <UIKit/UIKit.h>
// 坐标轴辅助线样式风格
NS_ASSUME_NONNULL_BEGIN
@interface AxisReferenceObj : NSObject

@property (nonatomic, strong,readonly) UIColor * _Nullable color;

@property (nonatomic, strong,readonly) NSArray * _Nullable pattern;

-(instancetype)init;

- (instancetype)initWithDash:(UIColor * )color pattern:(NSArray *)pattern;

- (instancetype)initWithSolid:(UIColor *)color pattern:(NSArray *)pattern;

@end
NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN

// Y 轴的显示位置
typedef NS_ENUM(NSInteger,YAxisShowPosition) {
    YAxisShowPosition_none,
    YAxisShowPosition_left,
    YAxisShowPosition_right,
};


typedef NS_ENUM(NSInteger, ReferenceStyle){
    ReferenceStyle_none,
    ReferenceStyle_Dash,
    ReferenceStyle_Solid
};



@interface YAxis : NSObject

/**
 Y轴的最大值
 */
@property (nonatomic, assign) CGFloat max;

/**
 Y轴的最小值
 */
@property (nonatomic, assign) CGFloat min;


/**
 上下边界溢出值的比例
 */
@property (nonatomic, assign) CGFloat ext;

/**
 固定的基值
 */
@property (nonatomic, assign) CGFloat baseValue;

/**
 间断显示个数
 */
@property (nonatomic, assign) int tickInterval;

@property (nonatomic, assign) int pos;

/**
 约束小数位的位置
 */
@property (nonatomic, assign) int decimal;


/**
 Y轴是否被使用
 */
@property (nonatomic, assign) BOOL isUsed;

/**
 辅助线的样式
 */
@property (nonatomic, strong) AxisReferenceObj *referenceObj;

@property  (nonatomic, assign)  ReferenceStyle style;



@end

NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

/**
 X 轴数据模型
 */
@interface XAxis : NSObject
// 间断显示个数
@property (nonatomic, assign) int tickInterval;

@property  (nonatomic, assign) ReferenceStyle style;

@property (nonatomic, strong) AxisReferenceObj *referenceStyle;

@end

NS_ASSUME_NONNULL_END
