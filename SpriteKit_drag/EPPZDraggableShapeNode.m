//
//  EPPZDraggableShapeNode.m
//  SpriteKitDrag
//
//  Created by Gardrobe on 2/23/14.
//  Copyright (c) 2014 eppz! development, LLC. All rights reserved.
//

#import "EPPZDraggableShapeNode.h"


@implementation EPPZDraggableShapeNode


-(BOOL)isDragged
{ return (self.touch != nil); }

-(void)bindTouch:(UITouch*) touch
{
    self.touch = touch; // Reference
    
    // Physics, and coordinate works moved here.
    CGPoint touchLocation = [self.touch locationInNode:self.scene];
    self.touchOffset = subtractVectorPoints(touchLocation, self.position);
    self.physicsBody.affectedByGravity = NO;
}

-(void)dragIfNeeded
{
    // If any touch bound.
    if (self.isDragged == NO) return;
    
    // Coordinate works moved here.
    CGPoint touchLocation = [self.touch locationInNode:self.scene];
    self.position = subtractVectorPoints(touchLocation, self.touchOffset);
}

-(void)unbindTouchIfNeeded:(UITouch*) touch
{
    // Unbind only if bound.
    if (self.touch != touch) return;
    
    // Physics work moved here.
    self.touch = nil;
    self.physicsBody.affectedByGravity = YES;
}


@end
