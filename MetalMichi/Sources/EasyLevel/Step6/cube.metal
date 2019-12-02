//
//  cube.metal
//  MetalMichi
//
//  Created by CmST0us on 2019/9/1.
//  Copyright © 2019 eric3u. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct CubeVertex {
    vector_float4 position;
};

struct MetalCubeVertex {
    float4 position [[position]];
    float4 color;
};

vertex MetalCubeVertex cube_vertex_function(constant CubeVertex *cube_vertex [[buffer(0)]],
                                             uint vid [[vertex_id]]) {
    MetalCubeVertex m_color_vertex;
    m_color_vertex.position = cube_vertex[vid].position;
    m_color_vertex.color = m_color_vertex.position;
    return m_color_vertex;
}

fragment float4 cube_fragment_function(MetalCubeVertex color_vertex [[stage_in]]) {
    return color_vertex.color;
}
