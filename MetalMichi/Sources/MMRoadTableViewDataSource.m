//
//  MMRoadTableViewDataSource.m
//  MetalMichi
//
//  Created by CmST0us on 2019/8/29.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "MMRoadTableViewDataSource.h"

@implementation MMRoadTableViewDataSource
#pragma mark - Configuation
- (NSArray<NSDictionary<NSString *, NSString *> *> *)roadClass {
    static NSArray *roadClass = nil;
    if (roadClass != nil) return roadClass;
    
    roadClass = @[
        @{@"显示一个Metal视图":@"MMMetalFirstStepViewController"},
        @{@"渲染一个三角形": @"MMRenderTriangleViewController"},
        @{@"使用片元着色器差值渲染一个彩色三角形": @"MMFragmentColorViewController"},
        @{@"使用向顶点着色器传递变化矩阵": @"MMTransformViewController"},
        @{@"使用核函数的分型结构": @"MMFractalViewController"},
        @{@"加载外部立方体模型并旋转": @"MMCubeViewController"},
    ];
    
    return roadClass;
}

- (NSUInteger)sectionCount {
    return 1;
}

#pragma mark - Init

#pragma mark - Lazy

#pragma mark - Getter Setter

#pragma mark - Private

#pragma mark - Method

#pragma mark - Slot

#pragma mark - Action

#pragma mark - Life Cycle

@end
