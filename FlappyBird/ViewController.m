//
//  ViewController.m
//  FlappyBird
//
//  Created by luowei on 14-6-13.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "ViewController.h"

NSInteger hightScoreNumber;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *highScore;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    hightScoreNumber = [[NSUserDefaults standardUserDefaults]integerForKey:@"highScoreSaved"];
    _highScore.text = [NSString stringWithFormat:@"HighScore:%li",(long)hightScoreNumber];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
