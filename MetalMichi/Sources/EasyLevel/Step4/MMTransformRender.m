//
//  MMTransformRender.m
//  MetalMichi
//
//  Created by CmST0us on 2019/9/1.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "MatricesHelper.h"
#import "TransformVertex.h"
#import "MMTransformRender.h"

@interface MMTransformRender ()
@property (nonatomic, strong) id<MTLRenderPipelineState> renderPipleline;
@property (nonatomic, strong) id<MTLBuffer> colorVertexBuffer;
@property (nonatomic, strong) id<MTLBuffer> transformMatrixBuffer;
@end

@implementation MMTransformRender

- (void)createResource {
    [super createResource];
    
    matrix_float4x4 transform = [MatricesHelper make3DTransformMatrix];
    transform = [MatricesHelper scale:transform value:simd_make_float3(0.5, 0.5, 1)];
    transform = [MatricesHelper rotation:transform axis:simd_make_float3(0.0, 0.0, 1.0) angle:M_PI / 2];
    transform = [MatricesHelper translation:transform offset:simd_make_float3(0, 0.4, 0)];
    
    NSUInteger transformSize = sizeof(transform);
    self.transformMatrixBuffer = [self.device newBufferWithBytes:&transform length:transformSize options:MTLResourceOptionCPUCacheModeDefault];
}

- (void)createPipelines {
    MTLRenderPipelineDescriptor *renderPipelineDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
    
    id<MTLLibrary> library = [self.device newDefaultLibrary];
    id<MTLFunction> transformVertexFunction = [library newFunctionWithName:@"transform_vertex_function"];
    id<MTLFunction> transformFragmentFunction = [library newFunctionWithName:@"transform_fragment_function"];
    renderPipelineDescriptor.vertexFunction = transformVertexFunction;
    renderPipelineDescriptor.fragmentFunction = transformFragmentFunction;
    renderPipelineDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
    
    id<MTLRenderPipelineState> renderPipelineState = [self.device newRenderPipelineStateWithDescriptor:renderPipelineDescriptor error:nil];
    self.renderPipleline = renderPipelineState;
}

- (void)drawInRenderView {
    MTLRenderPassDescriptor *descriptor = self.renderView.currentRenderPassDescriptor;
    descriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 1, 1, 1);
    
    id<MTLCommandBuffer> commandBuffer = self.commandQueue.commandBuffer;
    id<MTLRenderCommandEncoder> commandEncoder = [commandBuffer renderCommandEncoderWithDescriptor:descriptor];
    [commandEncoder setRenderPipelineState:self.renderPipleline];
    [commandEncoder setVertexBuffer:self.colorVertexBuffer offset:0 atIndex:0];
    [commandEncoder setVertexBuffer:self.transformMatrixBuffer offset:0 atIndex:1];
    [commandEncoder drawPrimitives:MTLPrimitiveTypeTriangle vertexStart:0 vertexCount:3];
    [commandEncoder endEncoding];
    [commandBuffer presentDrawable:self.renderView.currentDrawable];
    [commandBuffer commit];
}

@end
