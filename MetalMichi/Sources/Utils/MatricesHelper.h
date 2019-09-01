//
//  MatricesHelper.h
//  MetalMichi
//
//  Created by CmST0us on 2019/9/1.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <simd/simd.h>

NS_ASSUME_NONNULL_BEGIN

@interface MatricesHelper : NSObject
+ (simd_float4x4)make3DTransformMatrix;

+ (simd_float4x4)translation:(simd_float4x4)matrix
                  toPosition:(simd_float3)position;

+ (simd_float4x4)scale:(simd_float4x4)matrix
               toValue:(simd_float3)scale;

+ (simd_float4x4)rotation:(simd_float4x4)matrix
                  toAngle:(simd_float3)angle;
@end

NS_ASSUME_NONNULL_END
