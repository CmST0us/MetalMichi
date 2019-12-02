//
//  EKMetalContext.m
//  EKMetalKit
//
//  Created by CmST0us on 2019/11/24.
//  Copyright © 2019 eki. All rights reserved.
//

#import "EKMetalContext.h"

@interface EKMetalContext ()
@property (nonatomic, strong) id<MTLDevice> device;
@property (nonatomic, strong) id<MTLLibrary> library;
@property (nonatomic, strong) id<MTLCommandQueue> commandQueue;

@end

@implementation EKMetalContext

- (instancetype)initWithDevice:(id<MTLDevice>)device
                       library:(id<MTLLibrary>)library
                         error:(NSError * _Nullable __autoreleasing *)error {
    self = [super init];
    if (self) {
        NSError *err = nil;
        do {
            if (device == nil) {
                err = [NSError MetalKitErrorWithType:EKMetalKitErrorTypeInvaildParameter];
                break;
            }
            if (library == nil) {
                err = [NSError MetalKitErrorWithType:EKMetalKitErrorTypeInvaildParameter];
                break;
            }
            _device = device;
            _library = library;
        } while (0);
        if (error != nil) {
            *error = err;
        }
        if (err != nil) {
            return nil;
        }
    }
    return self;
}

- (instancetype)initWithLibrary:(id<MTLLibrary>)library error:(NSError * _Nullable __autoreleasing *)error {
    id<MTLDevice> device = MTLCreateSystemDefaultDevice();
    NSError *err = nil;
    if (device == nil) {
        err = [NSError MetalKitErrorWithType:EKMetalKitErrorTypeUnsupport];
    }
    if (error != nil) {
        *error = err;
    }
    if (err != nil) {
        return nil;
    }
    return [self initWithDevice:device library:library error:error];
}

- (instancetype)init {
    id<MTLDevice> device = MTLCreateSystemDefaultDevice();
    if (device == nil) {
        return nil;
    }
    id<MTLLibrary> library = [device newDefaultLibrary];
    return [self initWithDevice:device library:library error:nil];
}

- (id<MTLCommandQueue>)commandQueue {
    if (_commandQueue == nil) {
        _commandQueue = [self.device newCommandQueue];
    }
    return _commandQueue;
}

+ (instancetype)defaultContext {
    id<MTLDevice> device = MTLCreateSystemDefaultDevice();
    if (device == nil) return nil;
    
    NSString *frameworkPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Frameworks"];
    NSString *metalKitFrameworkPath = [frameworkPath stringByAppendingPathComponent:@"EKMetalKit.framework"];
    NSString *defaultMetalLibraryFile = [metalKitFrameworkPath stringByAppendingPathComponent:@"default.metallib"];
    id<MTLLibrary> library = [device newLibraryWithFile:defaultMetalLibraryFile error:nil];
    EKMetalContext *context = [[EKMetalContext alloc] initWithDevice:device library:library error:nil];
    return context;
}

@end
