//  Created by Adam Kaplan on 8/29/17.
//  Copyright 2017 Yahoo Holdings Inc.

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface ObjCBenchmark : NSObject

+ (NSArray<NSValue *> * _Nonnull)runBenchmarkWithValues:(NSArray<NSNumber *> * _Nonnull)values inRect:(CGRect)rect;

@end
