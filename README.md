#SKInnerShadowLayer

`SKInnerShadowLayer` is a `CAGradientLayer` subclass that adds properties to create an inner shadow on a given layer.

## Usage

SKInnerShadowLayer takes the graphical properties of a CAGradientLayer that let you set the shadow, gradient, and border of a layer, and adds four properities that let you control the look of an inner shadow for the layer.

These properties are:

	+ @property CGColorRef innerShadowColor;
	+ @property CGSize innerShadowOffset;
	+ @property CGFloat innerShadowRadius;
	+ @property CGFloat innerShadowOpacity;

They behave similarly to their drop shadow counterparts.

## Technique

The technique for drawing the inner shadow is simple. The layer 

1. Creates a path for rounded rect of the layer
2. Clips to this rounded rect
2. Creates a larger path around the rounded rect
3. Sets the shadow properties
4. Draws a shadow behind this shape, which creates the illusion of an inner shadow

## Animations

These properties are all full animatable. There is an example of a layer with a with an inner shadow opacity animation in the demo app. This is the immediate advantage of using a `CoreGraphics` to draw an inner shadow instead of using an image resource.

## Graphical bugs

Unfortunately, `SKInnerShadowLayer` isn't quite ready to for production yet, and that's part of the reason I'm open-sourcing it now. It has a few graphical glitches related to drawing the inner shadow around a corner that I can't quite figure out, and I would love help with them.

First, and most obvious, is the weird anti-aliasing on the outer edge of rounded corners. It's most apparent on the animated inner shadow layer. You can see as the shadow fades out, the rounded rect from the `CAGradientLayer` is visible, and it is smoother and smaller than the rounded rect from the inner shadow. I think this is because the anti-aliasing from `CGContextClip` operates differently from the normal anti-aliasing. I can confirm, though, that it is anti-aliasing. If you set the `CoreGraphics` anti-aliasing flag to `NO`, it becomes very clear it is doing some anti-aliasing.

The other graphical bug can be seen when there is both a border and a corner radius set on the layer. There are a few pixels that appear between the border and the inner shadow. They are the color of the background of the layer. I think this is related to the same problem.