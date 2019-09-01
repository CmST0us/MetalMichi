//
//  transform.metal
//  MetalMichi
//
//  Created by CmST0us on 2019/9/1.
//  Copyright © 2019 eric3u. All rights reserved.
//

#include <metal_stdlib>
#include "TransformVertex.h"

using namespace metal;

struct TransformVertex {
    vector_float4 position;
    vector_float4 color;
};

struct TransformMatrix {
    matrix_float4x4 m;
};

struct MetalTransformVertex {
    float4 position [[position]];
    float4 color;
};

vertex MetalTransformVertex
transform_vertex_function(constant TransformVertex *transform_vertex [[buffer(0)]],
                          constant matrix_float4x4 &transform_matrix [[buffer(1)]],
                          uint vid [[vertex_id]]) {
    matrix_float4x4 transform = transform_matrix;
    MetalTransformVertex in_vertex;
    in_vertex.position = transform_vertex[vid].position;
    in_vertex.color = transform_vertex[vid].color;
    in_vertex.position = transform * in_vertex.position;
    return in_vertex;
}

fragment float4 transform_fragment_function(MetalTransformVertex in_vertex [[stage_in]]) {
    return in_vertex.color;
}
