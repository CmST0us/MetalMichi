//
//  MMRenderTriangleRender.m
//  MetalMichi
//
//  Created by CmST0us on 2019/8/31.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "MMRenderTriangleRender.h"
/*
 Metal 坐标系
     -1,1            0,1
      +--------------+--------------+1,1
      |              ^              |
      |              |              |
      |              |              |
      |              |              |
      |              |              |
      |              |              |
 -1,0 +---------------------------->+ 1,0
      |              |              |
      |              |              |
      |              |              |
      |              |              |
      |              |              |
      |              |              |
      +--------------+--------------+ 1,-1
 -1,-1
                     0,-1

 */


@implementation MMRenderTriangleRender


- (void)drawInRenderView {
    MTLRenderPassDescriptor *descriptor = [self.renderView currentRenderPassDescriptor];
    descriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 0.5, 0.5, 1);

    float vertexData[] = {
        /* x    y    z    w */
        -1.0, -1.0, 0.0, 1.0,
         1.0, -1.0, 0.0, 1.0,
           0,  1.0, 0.0, 1.0,
    };
    NSUInteger vertexDataSize = sizeof(vertexData) * sizeof(float);
    
    /// Create Data Buffer
    id<MTLBuffer> dataBuffer = [self.device newBufferWithBytes:&vertexData length:vertexDataSize options:MTLResourceOptionCPUCacheModeDefault];
    
    /// Create Metal Library
    id<MTLLibrary> library = [self.device newDefaultLibrary];
    id<MTLFunction> vertexFunction = [library newFunctionWithName:@"vertex_function"];
    id<MTLFunction> fragmentFunction = [library newFunctionWithName:@"fragment_function"];
    
    // Add to current render pipeline
    MTLRenderPipelineDescriptor *renderPipelineDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
    renderPipelineDescriptor.vertexFunction = vertexFunction;
    renderPipelineDescriptor.fragmentFunction = fragmentFunction;
    renderPipelineDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
    
    NSError *error;
    id<MTLRenderPipelineState> renderPipelineState = [self.device newRenderPipelineStateWithDescriptor:renderPipelineDescriptor error:&error];
    if (error) {
        NSLog(@"create render pipeline state error: %@", error);
        return;
    }
    
    id<MTLCommandQueue> commandQueue = [self.device newCommandQueue];
    id<MTLCommandBuffer> commandBuffer = [commandQueue commandBuffer];
    id<MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:descriptor];
    [renderEncoder setRenderPipelineState:renderPipelineState];
    [renderEncoder setVertexBuffer:dataBuffer offset:0 atIndex:0];
    
    /// 顶点数据放入renderEncoder中, 配置为三角形顶点
    [renderEncoder drawPrimitives:MTLPrimitiveTypeTriangle vertexStart:0 vertexCount:3];
    
    [renderEncoder endEncoding];
    [commandBuffer presentDrawable:self.renderView.currentDrawable];
    [commandBuffer commit];
    
}

- (void)drawableSizeWillChange:(CGSize)size {
    
}

@end
