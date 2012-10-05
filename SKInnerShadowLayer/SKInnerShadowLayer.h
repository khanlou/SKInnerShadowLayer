//
//  CAInnerShadowLayer.h
//  FTW
//
//  Created by Soroush Khanlou on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface SKInnerShadowLayer : CAGradientLayer

@property CGColorRef innerShadowColor;
@property CGSize innerShadowOffset;
@property CGFloat innerShadowRadius;
@property CGFloat innerShadowOpacity;

@end
