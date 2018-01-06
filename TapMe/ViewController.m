//
//  ViewController.m
//  TapMe
//
//  Created by 김진선 on 2018. 1. 6..
//  Copyright © 2018년 JinseonKim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (AVAudioPlayer *)setupAudioPlayerWithFile:(NSString *)file type:(NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:type];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error;
    
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (!audioPlayer) {
        NSLog(@"%@", [error description]);
    }
    
    return audioPlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tile.png"]];
    
    buttonBeep = [self setupAudioPlayerWithFile:@"ButtonTap" type:@"wav"];
    secondBeep = [self setupAudioPlayerWithFile:@"SecondBeep" type:@"wav"];
    backgroundMusic = [self setupAudioPlayerWithFile:@"HallOfTheMountainKing" type:@"mp3"];
    
    
    [self setupGame];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPressed:(id)sender {
    count++;
    scoreLabel.text = [NSString stringWithFormat:@"Score\n%li", (long)count];
    [buttonBeep play];
}

- (void)setupGame {
    seconds = 30;
    count = 0;
    
    timeLabel.text = [NSString stringWithFormat:@"Time: %li", (long)seconds];
    scoreLabel.text = [NSString stringWithFormat:@"Score: %li", (long)count];
    
    time = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(subtractTime) userInfo:nil repeats:YES];
    
    [backgroundMusic setVolume:0.3];
    [backgroundMusic play];
}

- (void)subtractTime {
    seconds--;
    timeLabel.text = [NSString stringWithFormat:@"Time: %li", (long)seconds];
    [secondBeep play];
    
    if (seconds == 0) {
        [time invalidate];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Time is up!" message:[NSString stringWithFormat:@"You scored %li points", (long)count] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Play agin" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self setupGame];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}


@end
