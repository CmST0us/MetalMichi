//
//  EKMetalRender.m
//  EKMetalKit
//
//  Created by CmST0us on 2019/11/24.
//  Copyright © 2019 eki. All rights reserved.
//

#import "EKMetalRender.h"

@interface EKMetalRender () <MTKViewDelegate>
@property (nonatomic, strong) EKMetalContext *context;
@property (nonatomic, strong) MTKView *renderView;
@end

@implementation EKMetalRender

- (instancetype)initWithContext:(EKMetalContext *)context
                      metalView:(MTKView *)mtkView
                       delegate:(nullable id<MTKViewDelegate>)delegate {
    self = [super init];
    if (self) {
        _context = context;
        _renderView = mtkView;
        _delegate = delegate;
        _renderView.delegate = self;
        [self renderDidInit];
    }
    return self;
}

- (instancetype)initWithContext:(EKMetalContext *)context
                      metalView:(MTKView *)mtkView {
    return [self initWithContext:context metalView:mtkView delegate:nil];
}

#pragma mark - Getter Setter
- (void)setFrameRate:(NSInteger)frameRate {
    self.renderView.preferredFramesPerSecond = frameRate;
}

- (NSInteger)frameRate {
    return self.renderView.preferredFramesPerSecond;
}

#pragma mark - Subclass Override
- (void)renderDidInit {
    
}

- (void)setupRenderWithError:(NSError * _Nullable __autoreleasing *)error {
    
}

- (void)drawableSizeWillChange:(CGSize)size {
    
}

- (void)drawInRenderView {
    
}

#pragma mark - Delegate
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

