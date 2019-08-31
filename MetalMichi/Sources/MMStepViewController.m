//
//  MMStepViewController.m
//  MetalMichi
//
//  Created by CmST0us on 2019/8/29.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "MMStepViewController.h"
#import "MMMetalRender.h"
@interface MMStepViewController ()
@property (nonatomic, strong) UIButton *exitButton;
@end

@implementation MMStepViewController

#pragma mark - Init
- (instancetype)init {
    self = [super init];
    if (self) {
        [self didInit];
    }
    return self;
}
#pragma mark - Lazy
- (UIButton *)exitButton {
    if (_exitButton == nil) {
        _exitButton = [[UIButton alloc] init];
        [_exitButton setTitle:@"退出" forState:UIControlStateNormal];
        [_exitButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [_exitButton addTarget:self
                        action:@selector(handleExitButtonPress:)
              forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitButton;
}
#pragma mark - Getter Setter

#pragma mark - Private

#pragma mark - Method

#pragma mark - Slot

#pragma mark - Action

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.exitButton];
    [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(44);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - Overide
- (void)didInit {
    
}

- (void)handleExitButtonPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (Class)renderClass {
    return [MMMetalRender class];
}

@end
