//
//  ChartAlgorithmProtocol.h
//  ML_K_Demo
//
//  Created by 戴明亮 on 2019/3/18.
//  Copyright © 2019年 ML Day. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChartItem.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ChartAlgorithmProtocol <NSObject>

@required
- (NSArray<ChartItem *> *)handleAlgorithm:(NSArray<ChartItem *>*)datas;
@end

NS_ASSUME_NONNULL_END
