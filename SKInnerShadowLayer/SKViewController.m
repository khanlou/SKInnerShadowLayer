//
//  SKViewController.m
//  SKInnerShadowLayer
//
//  Created by Soroush Khanlou on 10/5/12.
//  Copyright (c) 2012 SK. All rights reserved.
//

#import "SKViewController.h"
#import "SKInnerShadowLayer.h"
#import <QuartzCore/QuartzCore.h>

@interface SKViewController ()

@end

@implementation SKViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
		
	SKInnerShadowLayer *innerShadowlayer = [[SKInnerShadowLayer alloc] init];
	innerShadowlayer.colors = (@[ (id)[UIColor colorWithWhite:0.9 alpha:1.0].CGColor,
						  (id)[UIColor colorWithWhite:0.65 alpha:1.0].CGColor]);
	
	innerShadowlayer.frame = CGRectMake(20, 20, 280, 40);
	innerShadowlayer.cornerRadius = 10;
		
	innerShadowlayer.innerShadowOpacity = 1.0f;
	innerShadowlayer.innerShadowColor = [UIColor darkGrayColor].CGColor;
		
	innerShadowlayer.borderColor = [UIColor darkGrayColor].CGColor;
	innerShadowlayer.borderWidth = 1.0f;
	
	[self.view.layer addSublayer:innerShadowlayer];
	
	
	
	
	
	
	
	SKInnerShadowLayer *animatedInnerShadowlayer = [[SKInnerShadowLayer alloc] init];
	
	animatedInnerShadowlayer.colors = (@[ (id)[UIColor colorWithWhite:0.98f alpha:1.0f].CGColor,
						  (id)[UIColor colorWithWhite:0.9f alpha:1.0f].CGColor]);
	
	animatedInnerShadowlayer.backgroundColor = [UIColor whiteColor].CGColor;
	animatedInnerShadowlayer.frame = CGRectMake(20, 80, 280, 40);
	animatedInnerShadowlayer.cornerRadius = 10;
		
	animatedInnerShadowlayer.innerShadowOpacity = 1.0f;
	animatedInnerShadowlayer.innerShadowColor = [UIColor lightGrayColor].CGColor;

	[self.view.layer addSublayer:animatedInnerShadowlayer];
	
	
	CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"innerShadowOpacity"];
	anim.duration = 1.0;
	anim.fromValue = [NSNumber numberWithFloat:1.0f];
	anim.toValue = [NSNumber numberWithFloat:0.0f];
	anim.repeatCount = 10;
	anim.autoreverses = YES;
	
	[animatedInnerShadowlayer addAnimation:anim forKey:@"someKey"];
	
		

}


@end
