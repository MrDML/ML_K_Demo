//
//  ChartCustomViewController.m
//  ML_K_Demo
//
//  Created by Alan.Dai on 2019/3/17.
//  Copyright © 2019 ML Day. All rights reserved.
//

#import "ChartCustomViewController.h"
#import "LineChartView.h"
#import "TickerTopView.h"
#import "ToolBarView.h"
#import "MLTextLayer.h"
#import "MLShapeLayer.h"
#import "Section.h"
#import "ChartAlgorithm.h"
#import "MLChartAlgorithm.h"
#define Navigation_Heigth [UIApplication sharedApplication].statusBarFrame.size.height + 44
#define TOPVIEW_Height 60
#define TOOLBAR_Height 64
@interface ChartCustomViewController ()

@property (nonatomic, strong)LineChartView *chartView;
@property (nonatomic, strong)TickerTopView *topView;
@property (nonatomic, strong)ToolBarView   *toolbar;
@property (nonatomic, strong) ChartAlgorithm *algorithm;



@end

@implementation ChartCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addSubViews];

    
    
    self.algorithm = [[MLChartAlgorithm alloc] initWithMACD:@(10),@(20),@(30),nil];
    self.algorithm = [[MLChartAlgorithm alloc] initWithKDJ:@(10),@(20),@(30), nil];
    self.algorithm = [[MLChartAlgorithm alloc] initWithSAR:@(10),@(15),@(20), nil];
   

}



- (void)viewDidLayoutSubviews{
    [self layoutSubViews];
}






/**
 添加子视图
 */
- (void)addSubViews
{
    
   
    [self.view addSubview:self.topView];
    [self.view addSubview:self.toolbar];
    [self.view addSubview:self.chartView];
}

/**
 布局子视图的Frame
 */
- (void)layoutSubViews
{
    
    NSLayoutConstraint *topView_Cons_0 = [NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:Navigation_Heigth];
    
    NSLayoutConstraint *topView_Cons_1 = [NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *topView_Cons_2 = [NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];

    NSLayoutConstraint *topView_Cons_3 = [NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:TOPVIEW_Height];
    
    NSArray *array = [NSArray arrayWithObjects:topView_Cons_0, topView_Cons_1, topView_Cons_2 ,topView_Cons_3,nil];
    // 把约束条件设置到父视图的Contraints中
    [self.view addConstraints:array];
    
    
    
    
    
    NSLayoutConstraint *toolbar_Cons_0 = [NSLayoutConstraint constraintWithItem:self.toolbar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *toolbar_Cons_1 = [NSLayoutConstraint constraintWithItem:self.toolbar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    NSLayoutConstraint *toolbar_Cons_2 = [NSLayoutConstraint constraintWithItem:self.toolbar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    NSLayoutConstraint *toolbar_Cons_3 = [NSLayoutConstraint constraintWithItem:self.toolbar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:TOOLBAR_Height];
    
    NSArray *array_toolbar = [NSArray arrayWithObjects:toolbar_Cons_0, toolbar_Cons_1, toolbar_Cons_2 ,toolbar_Cons_3,nil];
    // 把约束条件设置到父视图的Contraints中
    [self.view addConstraints:array_toolbar];
    
    
    
    
     NSLayoutConstraint *chartView_Cons_0 = [NSLayoutConstraint constraintWithItem:self.chartView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    NSLayoutConstraint *chartView_Cons_1 = [NSLayoutConstraint constraintWithItem:self.chartView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *chartView_Cons_2 = [NSLayoutConstraint constraintWithItem:self.chartView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    NSLayoutConstraint *chartView_Cons_3 = [NSLayoutConstraint constraintWithItem:self.chartView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.toolbar attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
   
    
    NSArray *array_chartView = [NSArray arrayWithObjects:chartView_Cons_0, chartView_Cons_1, chartView_Cons_2 ,chartView_Cons_3,nil];
    // 把约束条件设置到父视图的Contraints中
    [self.view addConstraints:array_chartView];
    
    

}




#pragma mark - Getter

- (TickerTopView *)topView
{
    if (_topView == nil) {
        
        _topView = [[TickerTopView alloc] init];
        _topView.autoresizingMask = NO;
        [_topView setTranslatesAutoresizingMaskIntoConstraints:NO];
        _topView.backgroundColor = [UIColor orangeColor];
       
    }
    return _topView;
}

- (ToolBarView *)toolbar
{
    if (_toolbar == nil) {
        
        _toolbar = [[ToolBarView alloc] init];
        _toolbar.autoresizingMask = NO;
        [_toolbar setTranslatesAutoresizingMaskIntoConstraints:NO];
        _toolbar.backgroundColor = [UIColor yellowColor];
    }
    return _toolbar;
}

- (LineChartView *)chartView
{
 
    if (_chartView == nil) {
        
        _chartView = [[LineChartView alloc] init];
        _chartView.autoresizingMask = NO;
        [_chartView setTranslatesAutoresizingMaskIntoConstraints:NO];
        _chartView.backgroundColor = [UIColor blackColor];
        
    }
    return _chartView;
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
