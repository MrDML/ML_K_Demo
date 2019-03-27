//
//  ChartItem.m
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/3/18.
//  Copyright © 2019年 ML Day. All rights reserved.
//

#import "ChartItem.h"

@implementation ChartItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.norm = [[NormModel alloc] init];
    }
    return self;
}


@end
