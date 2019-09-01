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
+ (matrix_float4x4)make3DTransformMatrix;

+ (matrix_float4x4)translation:(matrix_float4x4)matrix
                        offset:(vector_float3)position;
/// 缩放需要早于旋转
+ (matrix_float4x4)scale:(matrix_float4x4)matrix
                   value:(vector_float3)scale;

+ (matrix_float4x4)rotation:(matrix_float4x4)matrix
                       axis:(vector_float3)axis
                      angle:(float)radians;

@end

NS_ASSUME_NONNULL_END
