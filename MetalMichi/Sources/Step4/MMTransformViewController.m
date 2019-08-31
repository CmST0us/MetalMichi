//
//  MMTransformViewController.m
//  MetalMichi
//
//  Created by CmST0us on 2019/9/1.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "MMTransformViewController.h"
#import "MMTransformRender.h"
@interface MMTransformViewController ()

@end

@implementation MMTransformViewController

- (Class)renderClass {
    return [MMTransformRender class];
}
@end
