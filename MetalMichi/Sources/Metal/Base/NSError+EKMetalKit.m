//
//  NSError+EKMetalKit.m
//  EKMetalKit
//
//  Created by CmST0us on 2019/11/24.
//  Copyright © 2019 eki. All rights reserved.
//

#import "NSError+EKMetalKit.h"

NSErrorDomain const EKMetalKitErrorDomain = @"com.eki.metalkit";

@implementation NSError (EKMetalKit)

+ (NSError *)MetalKitErrorWithType:(EKMetalKitErrorType)errorType {
    NSError *error = [NSError errorWithDomain:EKMetalKitErrorDomain code:errorType userInfo:nil];
    return error;
}

@end
