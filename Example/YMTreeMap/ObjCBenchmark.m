//  Created by Adam Kaplan on 8/29/17.
//  Copyright 2017 Yahoo Holdings Inc.

#import "ObjCBenchmark.h"
@import YMTreeMap;

@implementation ObjCBenchmark

+ (NSArray<NSValue *> * _Nonnull)runBenchmarkWithValues:(NSArray<NSNumber *> * _Nonnull)values inRect:(CGRect)rect
{
    YMTreeMap *treeMap = [[YMTreeMap alloc] initWithValues:values];
    treeMap.alignment = FrameAlignmentRetinaSubPixel;
    return [treeMap tessellateInRect:rect];
}

@end
