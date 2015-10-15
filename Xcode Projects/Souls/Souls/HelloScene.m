//
//  HelloScene.m
//  Souls
//
//  Created by Programming Account on 7/8/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "HelloScene.h"
#import "SpaceshipScene.h"

@interface HelloScene ()
@property BOOL contentCreated;
@end

@implementation HelloScene

- (void)didMoveToView: (SKView *) view{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

-(void)createSceneContents{
    self.backgroundColor = [SKColor redColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    [self addChild: [self newHelloNode]];
}

- (SKLabelNode *)newHelloNode{
    SKLabelNode *helloNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    helloNode.text = @"Hello, MOOOOUUUUUUTH!";
    helloNode.fontSize = 43;
    helloNode.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    helloNode.name = @"helloNode";
    return helloNode;
}

- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *)even{
    SKNode *helloNode = [self childNodeWithName:@"helloNode"];
    if (helloNode != nil){
        helloNode.name = nil;
        SKAction *moveUp = [SKAction moveByX: 0 y: 100.0 duration: 0.5];
        SKAction *zoomIn = [SKAction scaleTo: 2.0 duration: 0.25];
        SKAction *pause = [SKAction waitForDuration: 0.5];
        SKAction *fadeAway = [SKAction fadeOutWithDuration: 0.25];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *moveSequence = [SKAction sequence:@[moveUp, zoomIn, pause, fadeAway,remove]];
        [helloNode runAction: moveSequence completion:^{
            SKScene *spaceshipScene  = [[SpaceshipScene alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
            [self.view presentScene:spaceshipScene transition:doors];
        }];
    }
}

@end
