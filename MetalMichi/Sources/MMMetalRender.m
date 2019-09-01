//
//  MMMetalRender.m
//  MetalMichi
//
//  Created by CmST0us on 2019/8/31.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <MetalKit/MetalKit.h>
#import "MMMetalRender.h"

NSString * const MMMetalRenderErrorDomain = @"MMMetalRenderErrorDomain";

@interface MMMetalRender () <MTKViewDelegate>
@property (nonatomic, strong) MTKView *renderView;
@property (nonatomic, strong) id<MTLDevice> device;
@end

@implementation MMMetalRender

- (instancetype)initWithMetalView:(MTKView *)mtkView
                            error:(NSError * _Nullable __autoreleasing * _Nullable)error{
    return [self initWithMetalView:mtkView delegate:nil error:error];
}

- (instancetype)initWithMetalView:(MTKView *)mtkView
                         delegate:(id<MTKViewDelegate>)delegate
                            error:(NSError * _Nullable __autoreleasing * _Nullable)error{
    if (mtkView.device == nil) {
         mtkView.device = MTLCreateSystemDefaultDevice();
    }
    return [self initWithMetalView:mtkView device:mtkView.device delegate:delegate error:error];
}

- (instancetype)initWithMetalView:(MTKView *)mtkView
                           device:(id<MTLDevice>)device
                         delegate:(id<MTKViewDelegate>)delegate
                            error:(NSError * _Nullable __autoreleasing *)error {
    self = [super init];
    if (self) {
        if (device == nil) {
            *error = [NSError errorWithDomain:MMMetalRenderErrorDomain code:MMMetalRenderErrorCodeUnsupport userInfo:nil];
            return nil;
        }
        _device = device;
        _renderView = mtkView;
        _renderView.device = _device;
        _delegate = delegate;
        _renderView.delegate = self;
        [self renderDidInit];
    }
    return self;
}

- (id<MTLCommandQueue>)commandQueue {
    if (_commandQueue == nil) {
        _commandQueue = [self.device newCommandQueue];
    }
    return _commandQueue;
}

#pragma mark - Subclass Override
- (void)renderDidInit {
    
}

- (void)createResource {
    
}

- (void)createRenderPipelines {
    
}

- (void)drawableSizeWillChange:(CGSize)size {
    
}

- (void)drawInRenderView {
    
}

#pragma mark - Delgate
- (void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size {
   if (self.delegate &&
       [self.delegate respondsToSelector:@selector(mtkView:drawableSizeWillChange:)]) {
       [self.delegate mtkView:view drawableSizeWillChange:size];
   } else {
       [self drawableSizeWillChange:size];
   }
}

- (void)drawInMTKView:(MTKView *)view {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(drawInMTKView:)]) {
        [self.delegate drawInMTKView:view];
    } else {
        [self drawInRenderView];
    }
}

@end
