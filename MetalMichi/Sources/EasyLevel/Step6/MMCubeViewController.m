//
//  MMCubeViewController.m
//  MetalMichi
//
//  Created by CmST0us on 2019/9/1.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "MMCubeRender.h"
#import "MMCubeViewController.h"

@interface MMCubeViewController ()
@property (nonatomic, strong) MMCubeRender *render;
@property (nonatomic, strong) MTKView *mtkView;
@end

@implementation MMCubeViewController

#pragma mark - Init

#pragma mark - Lazy
- (MMCubeRender *)render {
    if (_render == nil) {
        NSError *error;
        _render = [[MMCubeRender alloc] initWithMetalView:self.mtkView error:&error];
        if (error) {
            NSLog(@"init render error: %@", error);
        }
    }
    return _render;
}

- (MTKView *)mtkView {
    if (_mtkView == nil) {
        _mtkView = [[MTKView alloc] initWithFrame:CGRectZero];
    }
    return _mtkView;
}
#pragma mark - Getter Setter

#pragma mark - Private

#pragma mark - Method

#pragma mark - Slot

#pragma mark - Action

#pragma mark - Life Cycle
- (void)viewDidLoad {
    
    if (self.render == nil) {
        NSLog(@"unsupport render!");
    }
    
    [self.render createResource];
    [self.render createPipelines];
    
    [self.view addSubview:self.mtkView];
    [self.mtkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [super viewDidLoad];
}
@end
