//
//  MMCubeRender.m
//  MetalMichi
//
//  Created by CmST0us on 2019/9/1.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <ModelIO/ModelIO.h>
#import "MMCubeRender.h"

@interface MMCubeRender ()
@property (nonatomic, strong) id<MTLBuffer> cubeBuffer;
@property (nonatomic, strong) id<MTLRenderPipelineState> pipelineState;
@property (nonatomic, strong) MTKMesh *cubeMesh;
@end

@implementation MMCubeRender

- (void)createResource {
//    MDLAsset *asset = [[MDLAsset alloc] initWithURL:[[NSBundle mainBundle] URLForResource:@"cube" withExtension:@"obj"]];
//    asset.upAxis = simd_make_float3(0, 0, 1);
}

- (void)createPipelines {
    id<MTLLibrary> library = [self.device newDefaultLibrary];
    id<MTLFunction> vertexFunction = [library newFunctionWithName:@"cube_vertex_function"];
    id<MTLFunction> fragmentFunction = [library newFunctionWithName:@"cube_fragment_function"];
    
    MTLVertexDescriptor *vertexDescriptor = [[MTLVertexDescriptor alloc] init];
    vertexDescriptor.attributes[0].offset = 0;
    vertexDescriptor.attributes[0].format = MTLVertexFormatFloat3;
    
    vertexDescriptor.layouts[0].stride = 12;
    MTLRenderPipelineDescriptor *renderPipelineDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
    renderPipelineDescriptor.vertexDescriptor = vertexDescriptor;
    renderPipelineDescriptor.vertexFunction = vertexFunction;
    renderPipelineDescriptor.fragmentFunction = fragmentFunction;
    renderPipelineDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
    self.pipelineState = [self.device newRenderPipelineStateWithDescriptor:renderPipelineDescriptor error:nil];
    
    MDLVertexDescriptor *modelVertexDescriptor = MTKModelIOVertexDescriptorFromMetal(vertexDescriptor);
    MDLVertexAttribute *attr = modelVertexDescriptor.attributes[0];
    attr.name = MDLVertexAttributePosition;
    
    MTKMeshBufferAllocator *allocator = [[MTKMeshBufferAllocator alloc] initWithDevice:self.device];
    NSURL *assetURL = [[NSBundle mainBundle] URLForResource:@"cube" withExtension:@"obj"];
    MDLAsset *asset = [[MDLAsset alloc] initWithURL:assetURL vertexDescriptor:modelVertexDescriptor bufferAllocator:allocator];
    
    MDLMesh *mesh = [asset objectAtIndex:0];
    MTKMesh *meshs = [[MTKMesh alloc] initWithMesh:mesh device:self.device error:nil];
    self.cubeMesh = meshs;
}

- (void)drawInRenderView {
    MTLRenderPassDescriptor *descriptor = self.renderView.currentRenderPassDescriptor;
    descriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 0.5, 0.5, 1);
    
    id<MTLCommandBuffer> commandBuffer = self.device.newCommandQueue.commandBuffer;
    id<MTLRenderCommandEncoder> commandEncoder = [commandBuffer renderCommandEncoderWithDescriptor:descriptor];
    
    id<MTLBuffer> vertexBuffer = [self.cubeMesh vertexBuffers][0].buffer;
    [commandEncoder setRenderPipelineState:self.pipelineState];
    [commandEncoder setVertexBuffer:vertexBuffer offset:0 atIndex:0];
    [commandEncoder drawPrimitives:MTLPrimitiveTypeTriangle vertexStart:0 vertexCount:self.cubeMesh.vertexCount];
    [commandEncoder endEncoding];
    [commandBuffer presentDrawable:self.renderView.currentDrawable];
    [commandBuffer commit];
}

@end
