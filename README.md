#SKInnerShadowLayer

`SKInnerShadowLayer` is a `CAGradientLayer` subclass that adds properties to create an inner shadow on a given layer.

## Usage

`SKInnerShadowLayer` takes the graphical properties of a `CAGradientLayer` that let you set the shadow, gradient, and border of a layer, and adds four properities that let you control the look of an inner shadow for the layer.

These properties are:

	@property CGColorRef innerShadowColor;
	@property CGSize innerShadowOffset;
	@property CGFloat innerShadowRadius;
	@property CGFloat innerShadowOpacity;

They behave similarly to their drop shadow counterparts.

## Technique

The technique for drawing the inner shadow is simple. The layer:

1. creates a path for rounded rect of the layer
2. clips to this rounded rect
3. creates a larger path around the rounded rect
4. sets the shadow properties
5. draws a shadow behind this shape

and this creates the illusion of an inner shadow.

## Animations

These properties are all fully animatable. There is an example of a layer with an inner shadow opacity animation in the demo app. Being able to easily create animations is the immediate advantage of using `CoreGraphics` to draw an inner shadow instead of using an image resource.