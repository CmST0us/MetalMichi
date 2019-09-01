//
//  MMFractalRender.m
//  MetalMichi
//
//  Created by CmST0us on 2019/9/1.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "MMFractalRender.h"

@interface MMFractalRender ()
@property (nonatomic, assign) float timer;
@property (nonatomic, strong) id<MTLBuffer> timerBuffer;
@property (nonatomic, strong) id<MTLComputePipelineState> pipelineState;
@end

@implementation MMFractalRender

#pragma mark - Render Logic
- (void)update {
    self.timer += 0.02;
    memcpy(self.timerBuffer.contents, &_timer, sizeof(float));
}

#pragma mark - Render Override
- (void)renderDidInit {
    [super renderDidInit];
    
    self.timer = 0;
    self.renderView.framebufferOnly = NO;
}

- (void)createResource {
    self.timerBuffer = [self.device newBufferWithBytes:&_timer length:sizeof(float) options:MTLResourceOptionCPUCacheModeDefault];
}

- (void)createRenderPipelines {
    id<MTLLibrary> library = [self.device newDefaultLibrary];
    
    id<MTLFunction> kernel = [library newFunctionWithName:@"fractal_kernel_function"];
    self.pipelineState = [self.device newComputePipelineStateWithFunction:kernel error:nil];
}

- (void)drawInRenderView {
    id<MTLCommandBuffer> commandBuffer = self.commandQueue.commandBuffer;
    id<MTLComputeCommandEncoder> computeEncoder = [commandBuffer computeCommandEncoder];
    [computeEncoder setComputePipelineState:self.pipelineState];
    [computeEncoder setTexture:self.renderView.currentDrawable.texture atIndex:0];
    [computeEncoder setBuffer:self.timerBuffer offset:0 atIndex:1];
    [self update];
    
    id<CAMetalDrawable> drawable = self.renderView.currentDrawable;
    MTLSize threadGroupCount = MTLSizeMake(8, 8, 1);
    MTLSize threadGroups = MTLSizeMake(drawable.texture.width / threadGroupCount.width, drawable.texture.height / threadGroupCount.height, 1);
    
    [computeEncoder dispatchThreadgroups:threadGroups threadsPerThreadgroup:threadGroupCount];
    [computeEncoder endEncoding];
    
    [commandBuffer presentDrawable:self.renderView.currentDrawable];
    [commandBuffer commit];
}

@end
