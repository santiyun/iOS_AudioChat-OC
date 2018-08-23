//
//  TTTUser.h
//  TTTAudioChat
//
//  Created by yanzhen on 2018/8/13.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTTUser : NSObject

@property (nonatomic, assign) int64_t uid;
@property (nonatomic, assign) BOOL mutedSelf; //是否静音

- (instancetype)initWith:(int64_t)uid;
@end
