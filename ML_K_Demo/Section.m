//
//  Section.m
//  ML_K_Demo
//
//  Created by Alan.Dai on 2019/3/17.
//  Copyright © 2019 ML Day. All rights reserved.
//

#import "Section.h"
#import "MLShapeLayer.h"
#import "ChartItem.h"

#import "MLCandleModel.h"
#import "MLLineModel.h"
#import "MLColumnModel.h"
#import "MLBarModel.h"
#import "MLRoundModel.h"

@interface Section ()
/**
 显示标题内容的层
 */
@property (nonatomic, strong) MLShapeLayer *titleLayer;

/**
 分区的绘图层
 */
@property (nonatomic, strong) MLShapeLayer *sectionLayer;

/**
 用户自定义的view
 */
@property (nonatomic, strong)UIView *titleView;
@end

@implementation Section



/**
 建立Y轴的数值范围
 
 @param startIndex 计算范围的开始数据点
 @param endIndex 计算范围结束数据点
 @param datas datas description
 */
- (void)buildTAxis:(int)startIndex endIndex:(int)endIndex datas:(NSArray <ChartItem *>*)datas
{
    
    self.yAxis.isUsed =  NO;
    BOOL baseValueSticky = NO;
    BOOL symmtrical = NO;
    if (self.paging) { // 如果分页， 计算当前选中的系列作为坐标系的数据源
        
        // 建立分页每条线的坐标系
        Series *series = self.series[self.selectedIndex];
        // 是否以固定的基值显示最小或者最大值，若超出范围  default false
        baseValueSticky = series.baseValueSticky;
        // 是否以固定的基值作为中位数，对称显示最大最小值  default false
        symmtrical = series.symmetrical;
        
        [series.chartModels enumerateObjectsUsingBlock:^(ChartModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // 为模型赋值 datas
            obj.datas = datas;
            // 为Y轴 赋值 最大值
            
            
        }];
        
        
    }else{ // 没有进行分页
        
    }
    
    
}



- (void)buildYAxisPerModel:(ChartModel *)model startIndex:(int)startIndex endIndex:(int)endIndex
{
    
    NSArray * datas = model.datas;
    
    if (datas.count == 0) {
        return;
    }
    
    if (self.yAxis.isUsed == NO) {
        self.yAxis.decimal = self.decimal;
        
        self.yAxis.max = 0;
        self.yAxis.min = CGFLOAT_MIN;
        self.yAxis.isUsed = YES;
    }
    
    for (int i = startIndex ; i < endIndex; i++) {
        
        ChartItem *item = datas[i];

        if ([model isMemberOfClass:[MLCandleModel class]]) {
            
            CGFloat high = item.highPrice;
            CGFloat low  = item.lowPrice;
            
            // 判断数据集合的每个价格，吧最大值和最少值设置到Y轴对象中
            if (high > self.yAxis.max) {
                self.yAxis.max = high;
            }
            if (low < self.yAxis.min) {
                self.yAxis.min = low;
            }
            
        }else if ([model isMemberOfClass:[MLLineModel class]] || [model isMemberOfClass:[MLBarModel class]]){
            
           CGFloat value = [model getChartItemExtval:i].value;
           // 对 value 需要进行判断
            if (value <= 0) {
                continue; // 无法计算的值 不绘画
            }
            
            
        }else if ([model isMemberOfClass:[MLColumnModel class]]){
            
        }
        
    }
    
    
    
    
    
}





@end
