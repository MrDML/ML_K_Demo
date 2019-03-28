//
//  ChartModel.m
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/3/28.
//  Copyright © 2019年 ML Day. All rights reserved.
//

#import "ChartModel.h"
#import "Section.h"

@implementation TrendObj

- (instancetype)initWithColor:(UIColor *)color isSolid:(BOOL)isSolid
{
    self = [super init];
    if (self) {
        self.color = color;
        self.isSolid = isSolid;
    }
    return self;
}

@end


@interface ChartModel ()
@property (nonatomic, weak) Section * section;
@end

@implementation ChartModel


/**
 根据索引获取指标值

 @param index 索引
 @return return value description
 */
- (ChartItem *)getChartItemExtval:(int)index
{
     ChartItem *item  = self.datas[index];
     NSNumber *value = item.extVal[self.key];
    //
     item.value = [value floatValue];
    return item;
}



@end
