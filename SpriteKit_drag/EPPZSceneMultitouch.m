//
//  EPPZSceneMultitouch.m
//  SpriteKitDrag
//
//  Created by Gardrobe on 2/23/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import "EPPZSceneMultitouch.h"
#import "EPPZDraggableShapeNode.h"


@implementation EPPZSceneMultitouch


-(void)didMoveToView:(SKView*) view
{
    self.backgroundColor = [UIColor tealColor];
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.view.bounds];
    
    CGFloat radius = 30.0;
    CGFloat diameter = radius * 2.0;
    CGPathRef centeredCircle = CGPathCreateWithEllipseInRect((CGRect){-radius, -radius, diameter, diameter}, NULL);
    repeat(20, ^{
        
        SKShapeNode *node = [EPPZDraggableShapeNode new];
        node.path = centeredCircle;
        node.fillColor = [UIColor canaryYellowColor];
        node.lineWidth = 0.0;
        node.position = randomPointInFrame(self.view.bounds);
        node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
        
        [self addChild:node];
        
    });
}


#pragma mark - Multitouch dragging

-(void)touchesBegan:(NSSet*) touches withEvent:(UIEvent*) event
{
    for (UITouch *eachTouch in touches) // Enumerate touches
    {
        CGPoint eachTouchLocation = [eachTouch locationInNode:self];
        NSArray *nodes = [self nodesAtPoint:eachTouchLocation];
        for (EPPZDraggableShapeNode *eachTouchedNode in nodes) // Enumerate nodes beneath
        {
            if ([eachTouchedNode isKindOfClass:[EPPZDraggableShapeNode class]] == NO) continue; // Check class
            if (eachTouchedNode.isDragged) continue; // Skip if already bound
            [eachTouchedNode bindTouch:eachTouch];
        }
    }
}

-(void)touchesEnded:(NSSet*) touches withEvent:(UIEvent*) event
{
    for (UITouch *eachTouch in touches) // Enumerate touches
    {
        for (EPPZDraggableShapeNode *eachTouchedNode in self.children) // Enumerate nodes
        {
            if ([eachTouchedNode isKindOfClass:[EPPZDraggableShapeNode class]] == NO) continue; // Check class
            [eachTouchedNode unbindTouchIfNeeded:eachTouch];
        }
    }
}

-(void)update:(NSTimeInterval) currentTime
{
    for (EPPZDraggableShapeNode *eachTouchedNode in self.children) // Enumerate nodes
    {
        if ([eachTouchedNode isKindOfClass:[EPPZDraggableShapeNode class]] == NO) continue; // Checks
        [eachTouchedNode dragIfNeeded];
    }
}


@end
