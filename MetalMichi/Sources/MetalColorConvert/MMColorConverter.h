//
//  MMColorConverter.h
//  MetalMichi
//
//  Created by CmST0us on 2019/9/13.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <CoreMedia/CoreMedia.h>
#import "MMMetalRender.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MMColorConverterColorFormat) {
    MMColorConverterColorFormatBGRA,
    MMColorConverterColorFormatYUV,
};

@interface MMColorConverter : MMMetalRender

- (CMSampleBufferRef)convertSampleBuffer:(CMSampleBufferRef)sampleBuffer
                         withColorFormat:(MMColorConverterColorFormat)sourceColorFormat
                           toColorFormat:(MMColorConverterColorFormat)targetColorFormat;

@end

NS_ASSUME_NONNULL_END
