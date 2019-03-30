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
 清空所有的子图层
 */
- (void)removeLayerView
{
    [self.sectionLayer.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    self.sectionLayer.sublayers = nil;
    
    [self.titleLayer.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    self.titleLayer.sublayers = nil;
    
}


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
            // 为Y轴 赋值 最大值 最小值 以及是否被使用
            [self buildYAxisPerModel:obj startIndex:startIndex endIndex:endIndex];
            
            
        }];
        
        
    }else{ // 没有进行分页 计算所有系列作为坐标系的数据源
        
        for (Series *serie in self.series) {
            // 隐藏的不进行计算
            if (serie.hidden) {
                continue;
            }
            baseValueSticky = serie.baseValueSticky;
            symmtrical = serie.symmetrical;
            
            
            [serie.chartModels enumerateObjectsUsingBlock:^(ChartModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                // 为模型赋值 datas
                obj.datas = datas;
                // 为Y轴 赋值 最大值 最小值 以及是否被使用
                [self buildYAxisPerModel:obj startIndex:startIndex endIndex:endIndex];
            }];
            
            
        }
        
    }
    
    // 以下代码是设置固定基质
    if (baseValueSticky == NO) { // 不适用固定基值
        if (self.yAxis.max >= 0 && self.yAxis.min >= 0) {
            self.yAxis.baseValue = self.yAxis.min; // 固定基值 是最小值
        }else if (self.yAxis.max < 0 && self.yAxis.min < 0){
            self.yAxis.baseValue = self.yAxis.max; // 固定基值, 是最大值
        }else{
            self.yAxis.baseValue = 0;
        }
        
        
        
    }else{ // 使用固定基值
        
        if (self.yAxis.baseValue < self.yAxis.min) { // 固定基值 小于 最小值
            self.yAxis.min = self.yAxis.baseValue; // 将最小值设置为固定基值
        }
        
        if (self.yAxis.baseValue > self.yAxis.max) { // 固定基值大于最大值
            self.yAxis.max = self.yAxis.baseValue;
        }
        
    }
    // 是否以固定基值为中位数，对称显示最大最小值 default fals
    //如果使用水平对称显示y轴，基本基值计算上下的边界值
    
    if (symmtrical == YES) {
        if (self.yAxis.baseValue > self.yAxis.max) {
            self.yAxis.max = self.yAxis.baseValue + (self.yAxis.baseValue - self.yAxis.min);
        }else if (self.yAxis.baseValue < self.yAxis.min){
            self.yAxis.min = self.yAxis.baseValue - (self.yAxis.max - self.yAxis.baseValue);
        }else{
            if ((self.yAxis.max - self.yAxis.baseValue) > (self.yAxis.baseValue - self.yAxis.min)) {
                self.yAxis.min = self.yAxis.baseValue - (self.yAxis.max - self.yAxis.baseValue);
            }else{
                self.yAxis.max = self.yAxis.baseValue + (self.yAxis.baseValue - self.yAxis.min);
            }
        }
    }
    
    
}


/**
 建立Y轴左边对象，由起始位到结束位 （处理Y轴模型数组， 为Y轴模型数据（最大值最小值 是否被使用）赋值操作）
 */
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
            
            // 获取指标值
           CGFloat value = [model getChartItemExtval:i].value;
           // 对 value 需要进行判断
            if (value <= 0) {
                continue; // 无法计算的值 不绘画
            }
            
            // 判断数据结合的每个价格,把最大值和最小值设置到y轴对象中
            if(value > self.yAxis.max){
                self.yAxis.max = value;
            }
            
            // 设置Y轴的最小值
            if (value < self.yAxis.min) {
                self.yAxis.min = value;
            }

        }else if ([model isMemberOfClass:[MLColumnModel class]]){
            
            CGFloat value = item.vol;
            
            // 判断数据集合的每个价格,把最大值和最小值设置到Y轴对象中
            if (value > self.yAxis.max) {
                self.yAxis.max = value;
            }
            
            if (value < self.yAxis.min) {
                self.yAxis.min = value;
            }
            
            
        }
        
    }
    
    
    
    
    
}



/**
 绘制header上标题信息

 @param title 标题内容
 @return <#return value description#>
 */
- (NSAttributedString  * _Nullable )drawTitleForHeader:(NSString *)title
{
    if (self.showTitle == NO) {
        return nil;
    }
    
    // 先移除子控件
    [self.titleLayer.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    self.titleLayer.sublayers = nil;
    
    CGFloat yPos  = 0;
    CGFloat containerWidth = 0;
//    CGSize size =
#warning 待续.....
    return nil;
}





@end
