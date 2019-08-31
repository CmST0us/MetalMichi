//
//  MMRenderTriangleViewController.m
//  MetalMichi
//
//  Created by CmST0us on 2019/8/31.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <MetalKit/MetalKit.h>
#import <Masonry/Masonry.h>
#import "MMRenderTriangleViewController.h"
#import "MMRenderTriangleRender.h"
@interface MMRenderTriangleViewController ()
@property (nonatomic, strong) MMMetalRender *render;
@property (nonatomic, strong) MTKView *mtkView;
@end

@implementation MMRenderTriangleViewController

#pragma mark - Init

#pragma mark - Lazy
- (MTKView *)mtkView {
    if (_mtkView == nil) {
        _mtkView = [[MTKView alloc] initWithFrame:CGRectZero];
    }
    return _mtkView;
}

- (MMMetalRender *)render {
    if (_render == nil) {
        NSError *error = nil;
        _render = [[[self renderClass] alloc] initWithMetalView:self.mtkView error:&error];
        if (_render == nil ||
            error != nil) {
            if (error.code == MMMetalRenderErrorCodeUnsupport) {
                NSLog(@"No metal device");
            }
        }
    }
    return _render;
}


#pragma mark - Getter Setter

#pragma mark - Private

#pragma mark - Method

#pragma mark - Slot

#pragma mark - Action

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [self.view addSubview:self.mtkView];
    
    if (self.render == nil) {
        NSLog(@"Init render failed");
        return;
    }
    
    [self.render createResource];
    [self.render createRenderPipelines];
    
    [self.mtkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [super viewDidLoad];
}

- (Class)renderClass {
    return [MMRenderTriangleRender class];
}

@end
