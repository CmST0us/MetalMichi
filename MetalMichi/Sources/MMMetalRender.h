//
//  MMMetalRender.h
//  MetalMichi
//
//  Created by CmST0us on 2019/8/31.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <MetalKit/MetalKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const MMMetalRenderErrorDomain;
typedef NS_ENUM(NSInteger, MMMetalRenderErrorCode) {
    MMMetalRenderErrorCodeUnsupport = -1,
};

@interface MMMetalRender : NSObject
@property (nonatomic, nullable, weak) id<MTKViewDelegate> delegate;
@property (nonatomic, readonly) MTKView *renderView;
@property (nonatomic, nullable, readonly) id<MTLDevice> device;
@property (nonatomic, strong) id<MTLCommandQueue> commandQueue;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithMetalView:(MTKView *)mtkView
                         delegate:(nullable id<MTKViewDelegate>)delegate
                            error:(NSError * _Nullable __autoreleasing * _Nullable)error NS_DESIGNATED_INITIALIZER;

- (nullable instancetype)initWithMetalView:(MTKView *)mtkView
                            error:(NSError * _Nullable *)error;

// Init Step
- (void)createResource;
- (void)createRenderPipelines;

#pragma mark - Subclass Override
- (void)drawableSizeWillChange:(CGSize)size;
- (void)drawInRenderView;

@end

NS_ASSUME_NONNULL_END
