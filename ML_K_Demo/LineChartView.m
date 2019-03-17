//
//  LineChartView.m
//  ML_K_Demo
//
//  Created by Alan.Dai on 2019/3/17.
//  Copyright © 2019 ML Day. All rights reserved.
//

#import "LineChartView.h"
#import "MLTextLayer.h"
#import "MLShapeLayer.h"
#import "Section.h"



@interface LineChartView ()
@property (nonatomic, strong) MLShapeLayer *drawLayer;
@end


@implementation LineChartView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
@property (nonatomic, strong) MLShapeLayer *drawLayer;    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)addSubViews
{
    [self.layer addSublayer:self.drawLayer];
}


- (void)drawLayerView
{
    
    [self buildSection:^(Section *section, int index) {
       
        
    }];
}





/**
 初始化各个分区

 @param completeBlock completeBlock description
 */
- (void)buildSection:(void (^)(Section *section, int index))completeBlock
{
    
    CGFloat height = self.frame.size.height - (self.padding.top + self.padding.bottom);
    CGFloat weight = self.frame.size.width - (self.padding.left + self.padding.right);
    
    // x 轴的起始高度
    CGFloat xAxisHeight = 0;
   
    if ( [self.delegate respondsToSelector:@selector(heightForXAxisInKLineChart:)]) {
        xAxisHeight  = [self.delegate heightForXAxisInKLineChart:self];
    }
    // 区剩余高度
    height = height - xAxisHeight;
    
    // 获取总比例
    CGFloat total_rations = [self getSectionRatioTotal];
    
    CGFloat offsetY = self.padding.top;
    
    for (int i = 0; i < self.sections.count; i++) {
        
    }
    
    
}

/**
 获取每个区域的所占比例总和
 如果使用fixHeight, rations 需要设置为 0
 @return total Ratio Value
 */
- (CGFloat)getSectionRatioTotal
{
    int total = 0;
    for (int i = 0; i < self.sections.count; i++) {
        Section *section = self.sections[i];
        section.index = i;
        
        if (section.hiddent == NO) {
            total += section.rations;
        }
    }
    return total;
}




- (MLShapeLayer *)drawLayer
{
    if (_drawLayer == nil) {
        _drawLayer = [MLShapeLayer new];
    }
    return _drawLayer;
}


@end
