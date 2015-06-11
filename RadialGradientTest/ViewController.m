//
//  ViewController.m
//  RadialGradientTest
//
//  Created by Ho, Derrick on 6/8/15.
//  Copyright (c) 2015 Ho, Derrick. All rights reserved.
//

#import "ViewController.h"



IB_DESIGNABLE
@interface MyView : UIImageView
@property (nonatomic, strong) IBInspectable UIColor *color1;
@property (nonatomic, strong) IBInspectable UIColor *color2;
@property (nonatomic, assign) IBInspectable CGFloat divider;
@property (nonatomic, assign) IBInspectable CGFloat gradLocation1;
@property (nonatomic, assign) IBInspectable CGFloat gradLocation2;
@property (nonatomic, assign) IBInspectable CGSize size;
@property (nonatomic, assign) IBInspectable CGPoint gradCenter;
@property (nonatomic, assign) IBInspectable CGFloat gradRadius;


@end

@implementation MyView

- (void)commonInit { // Set property defaults
	_divider = 1;
	_gradLocation1 = 0.0;
	_gradLocation2 = 1.0;
	
	_color1 = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
	_color2 = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
	_size =  [UIScreen mainScreen].bounds.size;
	_gradCenter = CGPointMake(_size.width/2, _size.height/2);
	_gradRadius = MIN(_size.width , _size.height);
}

- (instancetype)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		[self commonInit];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self commonInit];
	}
	
	return self;
}

- (void)prepareForInterfaceBuilder {
	self.image = [self imageWithRadialGradient:self.size
											  :self.gradCenter
											  :self.gradRadius
											  :self.color1
											  :self.color2
											  :self.gradLocation1
											  :self.gradLocation2];
}

- (UIImage *)imageWithRadialGradient:(CGSize)size :(CGPoint)gradCenter :(CGFloat)gradRadius :(UIColor *)color1 :(UIColor *)color2 :(CGFloat) gradLocation1 :(CGFloat)gradLocation2 {

	// To offset the numbers.  Uncomment to use
	// gradLocation1 /= pow(10, _divider);
	// gradLocation2 /= pow(10, _divider);

	UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
	CGContextRef context = UIGraphicsGetCurrentContext();
	

	size_t gradLocationsNum = 2;
    CGFloat gradLocations[2] = {gradLocation1, gradLocation2};
	CGFloat gradColors[8];
	[color1 getRed:&gradColors[0] green:&gradColors[1] blue:&gradColors[2] alpha:&gradColors[3]];
	[color2 getRed:&gradColors[4] green:&gradColors[5] blue:&gradColors[6] alpha:&gradColors[7]];
	

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
    CGColorSpaceRelease(colorSpace);

    CGContextDrawRadialGradient (context, gradient, gradCenter, 0, gradCenter, gradRadius, kCGGradientDrawsAfterEndLocation);


    CGGradientRelease(gradient);
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}
@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)prepareForInterfaceBuilder {
	self.view.backgroundColor = [UIColor redColor];
}



@end
