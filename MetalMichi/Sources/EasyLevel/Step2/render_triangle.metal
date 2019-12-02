//
//  render_triangle.metal
//  MetalMichi
//
//  Created by CmST0us on 2019/8/31.
//  Copyright © 2019 eric3u. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct Vertex {
    float4 position [[position]];
};

vertex Vertex vertex_function(constant Vertex *vertices [[buffer(0)]],
                              uint vid [[vertex_id]]) {
    return vertices[vid];
}

fragment float4 fragment_function(Vertex aVertex [[stage_in]]) {
    /// return r g b a
    return float4(aVertex.position.x, aVertex.position.y, aVertex.position.z, 1);
}

