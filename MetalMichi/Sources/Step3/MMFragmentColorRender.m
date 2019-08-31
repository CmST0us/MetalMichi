//
//  MMFragmentColorRender.m
//  MetalMichi
//
//  Created by CmST0us on 2019/8/31.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "ColorVertex.h"
#import "MMFragmentColorRender.h"

@interface MMFragmentColorRender ()
@property (nonatomic, strong) id<MTLBuffer> colorVertexBuffer;
@property (nonatomic, strong) id<MTLRenderPipelineState> renderPipleline;
@end

@implementation MMFragmentColorRender

- (void)createResource {
    struct ColorVertex colorVertex[3] = {
        {
            .position = {
                -1.0, -1.0, 0.0, 1.0
            },
            .color = {
                1.0, 0.0, 0.0, 1.0
            }
        },
        {
            .position = {
                1.0, -1.0, 0.0, 1.0
            },
            .color = {
                0, 1, 0, 1
            }
        },
        {
            .position = {
                0.0,  1.0, 0.0, 1.0
            },
            .color = {
                0, 0, 1, 1
            }
        }
    };
    
    NSUInteger colorVertexSize = sizeof(colorVertex);
    
    id<MTLBuffer> colorVertexBuffer = [self.device newBufferWithBytes:&colorVertex length:colorVertexSize options:MTLResourceOptionCPUCacheModeDefault];
    self.colorVertexBuffer = colorVertexBuffer;
}

- (void)createRenderPipelines {
    MTLRenderPipelineDescriptor *renderPipelineDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
    
    id<MTLLibrary> library = [self.device newDefaultLibrary];
    id<MTLFunction> colorVertexFunction = [library newFunctionWithName:@"color_vertex_function"];
    id<MTLFunction> colorFragmentFunction = [library newFunctionWithName:@"color_fragment_function"];
    renderPipelineDescriptor.vertexFunction = colorVertexFunction;
    renderPipelineDescriptor.fragmentFunction = colorFragmentFunction;
    renderPipelineDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
    
    id<MTLRenderPipelineState> renderPipelineState = [self.device newRenderPipelineStateWithDescriptor:renderPipelineDescriptor error:nil];
    self.renderPipleline = renderPipelineState;
}

- (void)drawInRenderView {
    MTLRenderPassDescriptor *renderDescriptor = self.renderView.currentRenderPassDescriptor;
    renderDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 1, 1, 1);

    id<MTLCommandBuffer> commandBuffer = self.commandQueue.commandBuffer;
    id<MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderDescriptor];
    [renderEncoder setVertexBuffer:self.colorVertexBuffer offset:0 atIndex:0];
    [renderEncoder setRenderPipelineState:self.renderPipleline];
    [renderEncoder drawPrimitives:MTLPrimitiveTypeTriangle vertexStart:0 vertexCount:3];
    [renderEncoder endEncoding];
    [commandBuffer presentDrawable:self.renderView.currentDrawable];
    [commandBuffer commit];
}

@end
