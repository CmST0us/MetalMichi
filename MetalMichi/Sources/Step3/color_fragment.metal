//
//  color_fragment.metal
//  MetalMichi
//
//  Created by CmST0us on 2019/8/31.
//  Copyright © 2019 eric3u. All rights reserved.
//

#include <metal_stdlib>
#include "ColorVertex.h"

using namespace metal;

struct MetalColorVertex {
    float4 position [[position]];
    float4 color;
};

vertex MetalColorVertex color_vertex_function(constant ColorVertex *color_vertex [[buffer(0)]],
                                         uint vid [[vertex_id]]) {
    MetalColorVertex m_color_vertex;
    m_color_vertex.position = color_vertex[vid].position;
    m_color_vertex.color = color_vertex[vid].color;
    return m_color_vertex;
}

fragment float4 color_fragment_function(MetalColorVertex color_vertex [[stage_in]]) {
    return color_vertex.color;
}
