//
//  ViewController.h
//  TapMe
//
//  Created by 김진선 on 2018. 1. 6..
//  Copyright © 2018년 JinseonKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<UIAlertViewDelegate> {
    
    __weak IBOutlet UILabel *timeLabel;
    __weak IBOutlet UILabel *scoreLabel;
    // The NSInteger type makes the most sense since it can store integers (whole numbers) from zero up to over two billion
    NSInteger count;
    NSInteger seconds;
    NSTimer *time;
    
    AVAudioPlayer *buttonBeep;
    AVAudioPlayer *secondBeep;
    AVAudioPlayer *backgroundMusic;
}

- (IBAction)buttonPressed:(id)sender;

@end

