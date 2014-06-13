//
//  Game.m
//  FlappyBird
//
//  Created by luowei on 14-6-13.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "Game.h"

int birdFlight;
int randomTopTunnelPosition;
int randomBottomTunnelPosition;
int scoreNumber;
NSInteger highScoreNumber;

@interface Game (){
    NSTimer *birdMovment;
    NSTimer *tunnelMovment;
}

@property (weak, nonatomic) IBOutlet UIImageView *bird;
@property (weak, nonatomic) IBOutlet UIButton *startGame;

@property (weak, nonatomic) IBOutlet UIImageView *tunnelTop;
@property (weak, nonatomic) IBOutlet UIImageView *tunnelBottom;
@property (weak, nonatomic) IBOutlet UIImageView *top;
@property (weak, nonatomic) IBOutlet UIImageView *bottom;
@property (weak, nonatomic) IBOutlet UIButton *exit;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation Game

-(void)score{
    scoreNumber += 1;
    _scoreLabel.text = [NSString stringWithFormat:@"%i",scoreNumber];
}

-(void)gameOver{
    if(scoreNumber > highScoreNumber){
        [[NSUserDefaults standardUserDefaults]setInteger:scoreNumber forKey:@"highScoreSaved"];
    }
    [tunnelMovment invalidate];
    [birdMovment invalidate];
    
    _exit.hidden = NO;
    _tunnelTop.hidden = YES;
    _tunnelBottom.hidden = YES;
    _bird.hidden = YES;
}

- (IBAction)startGame:(id)sender {
    _tunnelTop.hidden = NO;
    _tunnelBottom.hidden = NO;
    
    _startGame.hidden = YES;
    birdMovment = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(birdMoving) userInfo:nil repeats:YES];
    [self placeTunnels];
    
    tunnelMovment = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tunnelMoving) userInfo:nil repeats:YES];
}
-(void)tunnelMoving{
    _tunnelTop.center = CGPointMake(_tunnelTop.center.x -1, _tunnelTop.center.y);
    _tunnelBottom.center = CGPointMake(_tunnelBottom.center.x - 1, _tunnelBottom.center.y);
    
    if(_tunnelTop.center.x < -28 || _tunnelBottom.center.x < -28){
        [self placeTunnels];
    }
    if(_tunnelTop.center.x == 30){
        [self score];
    }
    if(CGRectIntersectsRect(_bird.frame, _tunnelTop.frame)){
        [self gameOver];
    }
    if(CGRectIntersectsRect(_bird.frame, _tunnelBottom.frame)){
        [self gameOver];
    }
    if(CGRectIntersectsRect(_bird.frame,_top.frame)){
        [self gameOver];
    }
    if(CGRectIntersectsRect(_bird.frame, _bottom.frame)){
        [self gameOver];
    }
    
    
}
-(void)placeTunnels{
    randomTopTunnelPosition = arc4random() % 350 ;
    randomTopTunnelPosition = randomTopTunnelPosition - 228;
    randomBottomTunnelPosition = randomTopTunnelPosition + 655;
    
    _tunnelTop.center = CGPointMake(340, randomTopTunnelPosition);
    _tunnelBottom.center = CGPointMake(340, randomBottomTunnelPosition);
}
-(void)birdMoving{
    _bird.center = CGPointMake(_bird.center.x, _bird.center.y - birdFlight);
    birdFlight = birdFlight - 3;
    if(birdFlight < -10){
        birdFlight = -10;
    }
    if(birdFlight > 0){
        _bird.image = [UIImage imageNamed:@"BirdUp.png"];
    }
    if(birdFlight < 0){
        _bird.image = [UIImage imageNamed:@"BirdDown.png"];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    birdFlight = 20;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    scoreNumber = 0;
    highScoreNumber = [[NSUserDefaults standardUserDefaults]integerForKey:@"highScoreSaved"];
    
    _exit.hidden = YES;
    
    _tunnelTop.hidden = YES;
    _tunnelBottom.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
