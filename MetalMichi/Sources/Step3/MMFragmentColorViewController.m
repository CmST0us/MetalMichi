//
//  MMFragmentColorViewController.m
//  MetalMichi
//
//  Created by CmST0us on 2019/8/31.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "MMFragmentColorRender.h"
#import "MMFragmentColorViewController.h"

@interface MMFragmentColorViewController ()
@property (nonatomic, strong) MMMetalRender *render;
@property (nonatomic, strong) MTKView *mtkView;
@end

@implementation MMFragmentColorViewController

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
    
    if (self.render == nil) {
        NSLog(@"Init render failed");
    }
    [self.render createResource];
    [self.render createPipelines];
    
    [self.view addSubview:self.mtkView];
    [self.mtkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(300 * sin(M_PI / 180 * 60));
    }];
    [super viewDidLoad];
}

- (Class)renderClass {
    return [MMFragmentColorRender class];
}

@end
