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

+ (matrix_float4x4)translation:(matrix_float4x4)matrix
                        offset:(vector_float3)position {
    matrix.columns[3][0] = position[0];
    matrix.columns[3][1] = position[1];
    matrix.columns[3][2] = position[2];
    return matrix;
}

+ (matrix_float4x4)scale:(matrix_float4x4)matrix
                   value:(vector_float3)scale {
    matrix.columns[0][0] = scale[0];
    matrix.columns[1][1] = scale[1];
    matrix.columns[2][2] = scale[2];
    matrix.columns[3][3] = 1;
    return matrix;
}

+ (matrix_float4x4)rotation:(matrix_float4x4)matrix
                       axis:(vector_float3)axis
                      angle:(float)radians {
    axis = vector_normalize(axis);
    float ct = cosf(radians);
    float st = sinf(radians);
    float ci = 1 - ct;
    float x = axis.x, y = axis.y, z = axis.z;

    matrix_float4x4 rotationMatrix = (matrix_float4x4) {{
        { ct + x * x * ci,     y * x * ci + z * st, z * x * ci - y * st, 0},
        { x * y * ci - z * st,     ct + y * y * ci, z * y * ci + x * st, 0},
        { x * z * ci + y * st, y * z * ci - x * st,     ct + z * z * ci, 0},
        {                   0,                   0,                   0, 1}
    }};
    
    return simd_mul(matrix, rotationMatrix);
}
@end
