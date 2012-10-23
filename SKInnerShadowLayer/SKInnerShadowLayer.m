//
//  CAInnerShadowLayer.m
//  FTW
//
//  Created by Soroush Khanlou on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SKInnerShadowLayer.h"

@interface SKInnerShadowLayer ()

- (void) commonInit;

@end

@implementation SKInnerShadowLayer

@dynamic innerShadowColor, innerShadowOffset, innerShadowRadius, innerShadowOpacity;

- (id) init {
	self = [super init];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (id) initWithLayer:(id)layer {
	self = [super initWithLayer:layer];
	if (self) {
		[self commonInit];
		if([layer isKindOfClass:[SKInnerShadowLayer class]]) {
			SKInnerShadowLayer *other = (SKInnerShadowLayer*)layer;
			self.innerShadowColor = other.innerShadowColor;
			self.innerShadowOffset = other.innerShadowOffset;
			self.innerShadowOpacity = other.innerShadowOpacity;
			self.innerShadowRadius = other.innerShadowRadius;
		}
	}
	return self;
}

- (void) commonInit {
	//if contentsScale isn't 2.0 for retina screens, it will draw at 1.0 scale and look chunky and weird
	self.contentsScale = [UIScreen mainScreen].scale;
	
	self.innerShadowColor = [UIColor blackColor].CGColor;
	self.innerShadowOffset = CGSizeMake(0, 3);
	self.innerShadowRadius = 5.0f;
	self.innerShadowOpacity = 1.0f;
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
	if ([key isEqualToString:@"innerShadowColor"] || [key isEqualToString:@"innerShadowRadius"] || [key isEqualToString:@"innerShadowOpacity"] || [key isEqualToString:@"innerShadowOffset"]) {
		return YES;
	}
	return [super needsDisplayForKey:key];
}

- (id)actionForKey:(NSString *) key {
	if ([key isEqualToString:@"innerShadowColor"] || [key isEqualToString:@"innerShadowRadius"] || [key isEqualToString:@"innerShadowOpacity"] || [key isEqualToString:@"innerShadowOffset"]) {
		CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:key];
		theAnimation.fromValue = [self.presentationLayer valueForKey:key];
		return theAnimation;
	}
		return [super actionForKey:key];
}

- (void)drawInContext:(CGContextRef)context {
	CGContextSetAllowsAntialiasing(context, YES);
	CGContextSetShouldAntialias(context, YES);
	CGContextSetInterpolationQuality(context, kCGInterpolationHigh);

	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
	
	CGFloat radius = self.cornerRadius;
	
	CGRect rect = self.bounds;
	if (self.borderWidth != 0) {
		rect = CGRectInset(rect, self.borderWidth, self.borderWidth);
		radius -= self.borderWidth;
		radius = MAX(radius, 0);
	}
	
	UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
	CGContextAddPath(context, bezierPath.CGPath);
	CGContextClip(context);
		
	CGMutablePathRef outer = CGPathCreateMutable();
	CGPathAddRect(outer, NULL, CGRectInset(rect, -1*rect.size.width, -1*rect.size.height));
	
	CGPathAddPath(outer, NULL, bezierPath.CGPath);
	CGPathCloseSubpath(outer);
	
	
	CGFloat *oldComponents = (CGFloat *)CGColorGetComponents(self.innerShadowColor);
	CGFloat newComponents[4];
	
	NSInteger numberOfComponents = CGColorGetNumberOfComponents(self.innerShadowColor);
	
	switch (numberOfComponents)
	{
		case 2:
		{
			//grayscale
			newComponents[0] = oldComponents[0];
			newComponents[1] = oldComponents[0];
			newComponents[2] = oldComponents[0];
			newComponents[3] = oldComponents[1]*self.innerShadowOpacity;
			break;
		}
		case 4:
		{
			//RGBA
			newComponents[0] = oldComponents[0];
			newComponents[1] = oldComponents[1];
			newComponents[2] = oldComponents[2];
			newComponents[3] = oldComponents[3]*self.innerShadowOpacity;
			break;
		}
	}
	
	
	CGColorRef innerShadowColorWithMultipliedAlpha = CGColorCreate(colorspace, newComponents);
	CGColorSpaceRelease(colorspace);
	
	
	CGContextSetFillColorWithColor(context, innerShadowColorWithMultipliedAlpha);
	CGContextSetShadowWithColor(context, self.innerShadowOffset, self.innerShadowRadius, innerShadowColorWithMultipliedAlpha);
	
	CGContextAddPath(context, outer);
	CGContextEOFillPath(context);
	
	
	CGPathRelease(outer);
	CGColorRelease(innerShadowColorWithMultipliedAlpha);
	
}

@end
