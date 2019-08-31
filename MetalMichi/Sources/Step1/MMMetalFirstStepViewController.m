//
//  MMMetalFirstStepViewController.m
//  MetalMichi
//
//  Created by CmST0us on 2019/8/29.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <MetalKit/MetalKit.h>
#import <Masonry/Masonry.h>
#import "MMMetalFirstStepViewController.h"

@interface MMMetalFirstStepViewController () <MTKViewDelegate>
@property (nonatomic, strong) MTKView *mtkView;
@property (nonatomic, strong) id<MTLDevice> mtlDevice;

@end

@implementation MMMetalFirstStepViewController

#pragma mark - Init
- (void)didInit {
    [super didInit];
    _mtlDevice = MTLCreateSystemDefaultDevice();
    _mtkView = [[MTKView alloc] initWithFrame:CGRectZero device:_mtlDevice];
    _mtkView.delegate = self;
}

#pragma mark - Lazy

#pragma mark - Getter Setter

#pragma mark - Private
- (void)setupConstraints {
    [self.mtkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)renderFirstFrame {
    id<MTLCommandQueue> commandQueue = [self.mtlDevice newCommandQueue];
    id<MTLCommandBuffer> commandBuffer = [commandQueue commandBuffer];
    
    MTLRenderPassDescriptor *description = self.mtkView.currentRenderPassDescriptor;
    description.colorAttachments[0].clearColor = MTLClearColorMake(0, 1, 1, 1);
    id<MTLRenderCommandEncoder> renderCommandEncoder = [commandBuffer renderCommandEncoderWithDescriptor:description];
    [renderCommandEncoder endEncoding];
    [commandBuffer presentDrawable:self.mtkView.currentDrawable];
    [commandBuffer commit];
    
}
#pragma mark - Method

#pragma mark - Slot

#pragma mark - Action

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [self.view addSubview:self.mtkView];
    self.mtkView.frame = self.view.bounds;
    
    [super viewDidLoad];
}

#pragma mark - Delegate
- (void)drawInMTKView:(nonnull MTKView *)view {
    [self renderFirstFrame];
}

- (void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size {
    
}
@end
