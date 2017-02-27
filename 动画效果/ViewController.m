//
//  ViewController.m
//  动画效果
//
//  Created by Nicholas on 17/2/27.
//  Copyright © 2017年 Mr.zhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *yelView;

@property (weak, nonatomic) IBOutlet UIView *orgView;
@property (weak, nonatomic) IBOutlet UIView *capView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//两点位置运动
- (void)position
{
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"position"];
    ani.toValue = [NSValue valueWithCGPoint:self.yelView.center];
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.orgView.layer addAnimation:ani forKey:@"positionAni"];
    
}


- (IBAction)btnClick:(id)sender
{
   // [self position];
   // [self squareKeyframeAni];
   // [self circlePathKeyframeAni];
   // [self transitionAni];
   // [self springAni];
    [self groupAni];

}

//设置values使其沿正方形运动
- (void)squareKeyframeAni
{
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani.duration = 4.0;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    NSValue * value1 = [NSValue valueWithCGPoint:self.yelView.center];
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(250, self.yelView.center.y)];
    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(250, 300)];
    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(self.yelView.center.x, 300)];
    NSValue *value5=[NSValue valueWithCGPoint:self.yelView.center];
    ani.values = @[value1,value2,value3,value4,value5];
    [self.yelView.layer addAnimation:ani forKey:@"PositionKeyFrameValueAni"];
}

//设置path使其绕圆圈运动
- (void)circlePathKeyframeAni
{
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani.duration = 4.0;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(130, 200, 100, 100));
    ani.path = path;
    CGPathRelease(path);
    [self.yelView.layer addAnimation:ani forKey:@"PostionKeyframePathAni"];
    
}
//CATransition
- (void)transitionAni
{
    CATransition *ani = [CATransition animation];
    ani.type = kCATransitionMoveIn;
    /*
     苹果私有api 使用需注意可能被打回
     ani.type = @"cube";//--立方体
     ani.type = @"suckEffect";// 吸走的效果
     ani.type = @"oglFlip";//When subType is "fromLeft" or "fromRight", it's the official one.//前后翻转效果
     ani.type = @"rippleEffect";//波纹效果
     ani.type = @"pageCurl";//翻页起来
     ani.type = @"pageUnCurl";//翻页下来
     ani.type = @"cameraIrisHollowOpen ";//镜头开
     ani.type = @"cameraIrisHollowClose ";//镜头关
     */
    ani.subtype = kCATransitionFromLeft;
    ani.duration = 1.5;
    self.yelView.backgroundColor = [UIColor redColor];
    [self.yelView.layer addAnimation:ani forKey:@"transitionAni"];
    
}

//弹簧动画
- (void)springAni
{
    CASpringAnimation *ani = [CASpringAnimation animationWithKeyPath:@"bounds"];
    ani.mass = 10.0;
    //弹性系数越大弹簧运动的越快
    ani.stiffness = 5000;
    //阻尼系数 阻尼系数越大 弹簧的停止越快
    ani.damping = 100.0;
    ani.initialVelocity = 5;
    ani.duration = ani.settlingDuration;
    ani.toValue = [NSValue valueWithCGRect:self.yelView.bounds];
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.capView.layer addAnimation:ani forKey:@"boundsAni"];
}

//动画组CAAnimationGroup
- (void)groupAni
{
    CABasicAnimation *posAni = [CABasicAnimation animationWithKeyPath:@"position"];
    posAni.toValue = [NSValue valueWithCGPoint:self.yelView.center];
    CABasicAnimation *opcAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opcAni.toValue = [NSNumber numberWithFloat:1.0];
    opcAni.toValue = [NSNumber numberWithFloat:0.7];
    CABasicAnimation *bodAni = [CABasicAnimation animationWithKeyPath:@"bounds"];
    bodAni.toValue = [NSValue valueWithCGRect:self.yelView.bounds];
    CAAnimationGroup *groupAni = [CAAnimationGroup animation];
    groupAni.animations = @[posAni,opcAni,bodAni];
    groupAni.fillMode = kCAFillModeForwards;
    groupAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    groupAni.removedOnCompletion = NO;
    [self.orgView.layer addAnimation:groupAni forKey:@"groupAni"];
}







@end
