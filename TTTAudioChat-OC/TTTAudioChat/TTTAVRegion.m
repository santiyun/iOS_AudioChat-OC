//
//  TTTAVRegion.m
//  TTTAudioChat
//
//  Created by yanzhen on 2018/8/14.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

#import "TTTAVRegion.h"

@interface TTTAVRegion ()
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *audioStatsLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;

@end

@implementation TTTAVRegion

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"TTTAVRegion" owner:self options:nil];
        _backgroundView.frame = self.bounds;
        [self addSubview:_backgroundView];
    }
    return self;
}

- (UIImage *)getVoiceImage:(NSUInteger)audioLevel {
    UIImage *image = nil;
    if (audioLevel < 4) {
        image = [UIImage imageNamed:@"voice_small"];
    } else if (audioLevel < 7) {
        image = [UIImage imageNamed:@"voice_middle"];
    } else {
        image = [UIImage imageNamed:@"voice_big"];
    }
    return image;
}
#pragma mark - public
- (void)configureRegion:(TTTUser *)user {
    self.user = user;
    [_voiceBtn setImage:[UIImage imageNamed:@"voice_small"] forState:UIControlStateNormal];
    _idLabel.hidden = NO;
    _audioStatsLabel.hidden = NO;
    _voiceBtn.hidden = NO;
    _idLabel.text = [NSString stringWithFormat:@"%lld", user.uid];
    if (user.mutedSelf) {
        [self mutedSelf:YES];
    }
}

- (void)closeRegion {
    _idLabel.hidden = YES;
    _audioStatsLabel.hidden = YES;
    _voiceBtn.hidden = YES;
    _user = nil;
}

- (void)reportAudioLevel:(NSUInteger)level {
    if (_user.mutedSelf) { return; }
    [_voiceBtn setImage:[self getVoiceImage:level] forState:UIControlStateNormal];
}

- (void)setRemoterAudioStats:(NSUInteger)stats {
    _audioStatsLabel.text = [NSString stringWithFormat:@"A-↓%ldkbps",stats];
}

- (void)mutedSelf:(BOOL)mute {
    [_voiceBtn setImage:[UIImage imageNamed:mute ? @"speaking_closed" : @"voice_small"] forState:UIControlStateNormal];
}
@end
