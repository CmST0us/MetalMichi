//
//  MMColorConverter.m
//  MetalMichi
//
//  Created by CmST0us on 2019/9/13.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "MMColorConverterUniform.h"
#import "MMColorConverter.h"


@interface MMColorConverter ()
@property (nonatomic, strong) id<MTLComputePipelineState> pipelineState;
@property (nonatomic, strong) id<MTLBuffer> YUVToRGBMatrixBuffer;
@end

@implementation MMColorConverter

- (void)createResource {
    static MMColorConverterMatrix matrix = {
        .matrix = {
            (simd_float3){1.0,    1.0,   1.0},
            (simd_float3){0.0, -0.343, 1.765},
            (simd_float3){1.4, -0.711,   0.0},
        },
        .offset = {
            -(16.0 / 255.0), -0.5, -0.5
        }
    };
    
    self.YUVToRGBMatrixBuffer = [self.device newBufferWithBytes:&matrix length:sizeof(matrix) options:MTLResourceStorageModeShared];
}

- (void)createPipelines {
    id<MTLLibrary> library = [self.device newDefaultLibrary];
    
    id<MTLFunction> kernel = [library newFunctionWithName:@"color_convert_function"];
    
    self.pipelineState = [self.device newComputePipelineStateWithFunction:kernel error:nil];
}

- (CMSampleBufferRef)convertSampleBuffer:(CMSampleBufferRef)sampleBuffer
                         withColorFormat:(MMColorConverterColorFormat)sourceColorFormat
                           toColorFormat:(MMColorConverterColorFormat)targetColorFormat {
    
    id<MTLCommandBuffer> commandBuffer = self.commandQueue.commandBuffer;
    id <MTLComputeCommandEncoder> computeEncoder = [commandBuffer computeCommandEncoder];
    
    [computeEncoder setComputePipelineState:self.pipelineState];
    [computeEncoder setBuffer:self.YUVToRGBMatrixBuffer offset:0 atIndex:0];
    
     
    
}

- (CVPixelBufferRef)createPixelBufferWithSize:(CGSize)size {
    
    CVPixelBufferRef outputPixelBuffer = NULL;
    
}
@end
