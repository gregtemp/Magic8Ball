//
//  C4WorkSpace.m
//  Magic8Ball
//
//  Created by Gregory Debicki on 2013-11-29.
//

#import "C4Workspace.h"
#import <CoreMotion/CoreMotion.h>

@implementation C4WorkSpace {
    C4Shape *eightBall;
    C4Label *mysticalTruth;
    NSString *truthEssence;
    CGPoint c;
    CGFloat duration;
}
-(void)setup {
    c = self.canvas.center;
    eightBall = [self eightBall];
    mysticalTruth = [self truthDisplay];
    [self.canvas addObjects:@[eightBall, mysticalTruth]];
}
-(void) shake {
    mysticalTruth.animationDuration = 0.5f;
    mysticalTruth.alpha = 0.0f;
    duration = 0.2;
    [self motionWith:eightBall];
}
-(void) motionWith: (C4Shape *) sender {
    if ([C4Math absf:duration] > 0.03) {
        sender.animationDuration = [C4Math absf:duration];
        sender.center = CGPointMake(self.canvas.center.x + (duration * 200),
                                    self.canvas.center.y + [C4Math randomIntBetweenA:-[C4Math absf:duration*200] andB:[C4Math absf:duration*200]]);
        duration *= -0.9;
        [self runMethod:@"motionWith:" withObject:sender afterDelay:[C4Math absf:duration]];
    }
    else {
        sender.center = self.canvas.center;
        mysticalTruth.text = [self truthGenerator];
        mysticalTruth.animationDuration = 0.1f;
        mysticalTruth.center = CGPointMake(self.canvas.center.x, 350);
        [self runMethod:@"truthBubblesUp" afterDelay:0.1f];
    }
}
-(void) truthBubblesUp {
    mysticalTruth.animationDuration = 1.5f;
    mysticalTruth.alpha = 1.0f;
    mysticalTruth.center = CGPointMake(self.canvas.center.x,
                                       self.canvas.center.y);
}
-(C4Shape *) eightBall {
    C4Shape *ball = [C4Shape ellipse:CGRectMake(0, 0, 250, 250)];
    C4Shape *viewerHole = [C4Shape ellipse:CGRectMake(0, 0, 100, 100)];
    ball.center = c;
    ball.fillColor = [UIColor whiteColor];
    viewerHole.center = CGPointMake(ball.width/2, ball.height/2);
    viewerHole.fillColor = [UIColor blackColor];
    viewerHole.strokeColor = [UIColor whiteColor];
    viewerHole.lineWidth = 2.0f;
    C4Shape *bubbles = [self makeBubblesWithFrame:viewerHole.frame];
    [ball addObjects:@[viewerHole, bubbles]];
    return ball;
}
-(C4Shape *) makeBubblesWithFrame: (CGRect)frame {
    C4Shape *bubbleMask = [C4Shape ellipse:frame];
    bubbleMask.fillColor = [UIColor clearColor];
    C4Shape *holder = [C4Shape ellipse:CGRectMake(0, 0, bubbleMask.width, bubbleMask.height)];
    bubbleMask.mask = holder;
    for (int i = 0; i < 10; i++) {
        NSInteger s = [C4Math randomIntBetweenA:2 andB:10];
        CGFloat alpha = [C4Math randomIntBetweenA:20 andB:80]/100.0f;
        C4Shape *bubble = [C4Shape ellipse:CGRectMake(0, 0, s, s)];
        NSInteger xPos = [C4Math randomInt:100];
        bubble.center = CGPointMake(xPos, 120);
        bubble.fillColor = [UIColor colorWithWhite:1.0f alpha:alpha];
        bubble.strokeColor = C4GREY;
        bubble.lineWidth = 1.0f;
        [bubbleMask addShape:bubble];
        bubble.animationOptions = REPEAT;
        bubble.animationDuration = [C4Math randomIntBetweenA:50 andB:400]/100.0f;
        bubble.center = CGPointMake(xPos, -20);
    }
    return bubbleMask;
}
-(C4Label *) truthDisplay{
    c = self.canvas.center;
    C4Font *f = [C4Font fontWithName:@"Helvetica" size:12.0f];
    C4Label *tempTruth = [C4Label labelWithText:@"shake it" font:f frame:CGRectMake(0, 0, 90, 100)];
    tempTruth.center = c;
    tempTruth.textAlignment = ALIGNTEXTCENTER;
    tempTruth.textColor = [UIColor whiteColor];
    tempTruth.numberOfLines = 5.0f;
    return tempTruth;
}
-(NSString *) truthGenerator {
    NSString *truth;
    NSInteger t = [C4Math randomInt:30];
    switch (t) {
        case 0: truth = @"Hard to say at this jucture."; break;
        case 1: truth = @"Mmm, yes. Perhaps."; break;
        case 2: truth = @"Yeah, no. Absolutely not."; break;
        case 3: truth = @"Woah, woah, that's gross."; break;
        case 4: truth = @"Yes! Or no wait, no."; break;
        case 5: truth = @"Yes. Very yes."; break;
        case 6: truth = @"Look within yourself for the answer."; break;
        case 7: truth = @"I am an eightball."; break;
        case 8: truth = @"Sure."; break;
        case 9: truth = @"Lalalala I'm not listening!"; break;
        case 10:truth = @"You must ask me again."; break;
        case 11:truth = @"Do not ask me again... or else."; break;
        case 12:truth = @"Ask me again... en francais."; break;
        case 13:truth = @"Stop shaking me."; break;
        case 14:truth = @"Shake it! Shake it! Shake it baaaby!";break;
        case 15:truth = @"The truth is emmerging...";break;
        case 16:truth = @"Time is of the essence.";break;
        case 17:truth = @"You will know, and the answer will please you.";break;
        case 18:truth = @"What?";break;
        case 19:truth = @"Go on...";break;
        case 20:truth = @"Loading...";break;
        case 21:truth = @"erro̴̡̡̞̖̱͍͚̥̟͕̝̲̟̻̙̙͙͞r̴͈̫̬͔͙͉͎͔̰͕͙͇̝͍̲͝ͅ";break;
        case 22:truth = @"I guess so...";break;
        case 23:truth = @"No. Never.";break;
        case 24:truth = @"Sort of.";break;
        case 25:truth = @"Yup.";break;
        case 26:truth = @"Nah.";break;
        case 27:truth = @"This is boring, let's do something else.";break;
        case 28:truth = @"e̵ͯͩ͂̑ͫ̐̓ͨ̏͂ͩ̍ͨ̚͜͟r̴̛̃̈͗̍ͯͦͪ҉ror...̶̵̡̫̪̙͓͓͈͔͍̹͟";break;
        case 29:truth = @"Will you please shut up?";break;
        default:break;
    }
    return  truth;
}
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if(event.type == UIEventSubtypeMotionShake)
    {
        [self shake];
    }
}
@end