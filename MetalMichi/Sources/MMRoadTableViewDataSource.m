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
