//
//  MatricesHelper.m
//  MetalMichi
//
//  Created by CmST0us on 2019/9/1.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "MatricesHelper.h"

@implementation MatricesHelper

/*
 Translation:
 
 | 1     0     0    Dx |
 | 0     1     0    Dy |
 | 0     0     1    Dz |
 | 0     0     0     1 |

 
 Scale:
 | Sx    0     0     0 |
 | 0     Sy    0     0 |
 | 0     0     Sz    0 |
 | 0     0     0     1 |
 
 Rotation:
 R = Rx Ry Rz
 
 Rx
 | 1     0     0     0 |
 | 0    cos  -sin    0 |
 | 0    sin   cos    0 |
 | 0     0     0     1 |

 Ry
 | cos   0    sin    0 |
 | 0     1     0     0 |
 | -sin  0    cos    0 |
 | 0     0     0     1 |

 Rz
 | cos  -sin   0     0 |
 | sin  cos    0     0 |
 | 0     0     1     0 |
 | 0     0     0     1 |
 */

+ (simd_float4x4)make3DTransformMatrix {
    return matrix_identity_float4x4;
}

+ (simd_float4x4)translation:(simd_float4x4)matrix toPosition:(simd_float3)position {
    matrix.columns[3][0] = position[0];
    matrix.columns[3][1] = position[1];
    matrix.columns[3][2] = position[2];
    return matrix;
}

+ (simd_float4x4)scale:(simd_float4x4)matrix toValue:(simd_float3)scale {
    matrix.columns[0][0] = scale[0];
    matrix.columns[1][1] = scale[1];
    matrix.columns[2][2] = scale[2];
    matrix.columns[3][3] = 1;
    return matrix;
}

+ (simd_float4x4)rotation:(simd_float4x4)matrix toAngle:(simd_float3)angle {
    simd_float4x4 rx = matrix_identity_float4x4;
    rx.columns[1][1] = cos(angle[0]);
    rx.columns[2][1] = -sin(angle[0]);
    rx.columns[1][2] = sin(angle[0]);
    rx.columns[2][2] = cos(angle[0]);
    
    simd_float4x4 ry = matrix_identity_float4x4;
    ry.columns[0][0] = cos(angle[1]);
    ry.columns[2][0] = sin(angle[1]);
    ry.columns[0][2] = -sin(angle[1]);
    ry.columns[2][2] = cos(angle[1]);
    
    simd_float4x4 rz = matrix_identity_float4x4;
    rz.columns[0][0] = cos(angle[2]);
    rz.columns[1][0] = -sin(angle[2]);
    rz.columns[0][1] = sin(angle[2]);
    rz.columns[1][1] = cos(angle[2]);

    simd_float4x4 mul = simd_mul(rx, ry);
    mul = simd_mul(mul, rz);
    matrix = simd_mul(mul, matrix);
    matrix.columns[3][3] = 1;
    return matrix;
}

@end
