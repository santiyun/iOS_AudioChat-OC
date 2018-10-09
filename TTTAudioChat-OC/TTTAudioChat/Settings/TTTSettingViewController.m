//
//  TTTSettingViewController.m
//  TTTAudioChat
//
//  Created by yanzhen on 2018/9/11.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

#import "TTTSettingViewController.h"

@interface TTTSettingViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *audioSwitch;

@end

@implementation TTTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _audioSwitch.on = TTManager.isHighQualityAudio;
}

- (IBAction)saveSettingAction:(id)sender {
    TTManager.isHighQualityAudio = _audioSwitch.isOn;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
