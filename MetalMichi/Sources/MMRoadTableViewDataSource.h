//
//  MMRoadTableViewDataSource.h
//  MetalMichi
//
//  Created by CmST0us on 2019/8/29.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMRoadTableViewDataSource : NSObject
@property (nonatomic, readonly) NSUInteger sectionCount;
- (NSArray<NSDictionary<NSString *, NSString *> *> *)roadClass ;
@end

NS_ASSUME_NONNULL_END
