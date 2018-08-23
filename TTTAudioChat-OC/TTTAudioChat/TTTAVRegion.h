//
//  TTTAVRegion.h
//  TTTAudioChat
//
//  Created by yanzhen on 2018/8/14.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTTAVRegion : UIView
@property (nonatomic, strong) TTTUser *user;

- (void)configureRegion:(TTTUser *)user;
- (void)closeRegion;
- (void)reportAudioLevel:(NSUInteger)level;
- (void)setRemoterAudioStats:(NSUInteger)stats;
- (void)mutedSelf:(BOOL)mute;
@end
