//
//  TTTLoginViewController.m
//  TTTAudioChat
//
//  Created by yanzhen on 2018/8/14.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

#import "TTTLoginViewController.h"

@interface TTTLoginViewController ()<TTTRtcEngineDelegate>
@property (weak, nonatomic) IBOutlet UITextField *roomIDTF;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;
@property (nonatomic, assign) int64_t uid;
@end

@implementation TTTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *websitePrefix = @"http://www.3ttech.cn  version  ";
    _websiteLabel.text = [websitePrefix stringByAppendingString:TTTRtcEngineKit.getSdkVersion];
    _uid = arc4random() % 100000 + 1;
    NSInteger roomID = [[NSUserDefaults standardUserDefaults] stringForKey:@"ENTERROOMID"].integerValue;
    if (roomID == 0) {
        roomID = arc4random() % 1000000 + 1;
    }
    _roomIDTF.text = [NSString stringWithFormat:@"%zd", roomID];
}

- (IBAction)enterChannel:(id)sender {
    if (_roomIDTF.text.integerValue == 0) {
        [self showToast:@"请输入正确的房间ID"];
        return;
    }
    [NSUserDefaults.standardUserDefaults setValue:_roomIDTF.text forKey:@"ENTERROOMID"];
    [NSUserDefaults.standardUserDefaults synchronize];
    TTManager.me.uid = _uid;
    TTManager.me.mutedSelf = NO;
    TTManager.roomID = _roomIDTF.text.integerValue;
    [TTProgressHud showHud:self.view];
    TTManager.rtcEngine.delegate = self;
    [TTManager.rtcEngine setChannelProfile:TTTRtc_ChannelProfile_Communication];
    [TTManager.rtcEngine muteLocalAudioStream:NO];
    [TTManager.rtcEngine enableAudioVolumeIndication:200 smooth:3];
    //设置为高音质
//    [TTManager.rtcEngine setHighQualityAudioParametersWithFullband:YES stereo:YES fullBitrate:YES];
    [TTManager.rtcEngine joinChannelByKey:nil channelName:_roomIDTF.text uid:_uid joinSuccess:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_roomIDTF resignFirstResponder];
}

#pragma mark - TTTRtcEngineDelegate
-(void)rtcEngine:(TTTRtcEngineKit *)engine didJoinChannel:(NSString *)channel withUid:(int64_t)uid elapsed:(NSInteger)elapsed {
    [TTProgressHud hideHud:self.view];
    [self performSegueWithIdentifier:@"AudioChat" sender:nil];
}

-(void)rtcEngine:(TTTRtcEngineKit *)engine didOccurError:(TTTRtcErrorCode)errorCode {
    NSString *errorInfo = @"";
    switch (errorCode) {
        case TTTRtc_Error_Enter_TimeOut:
            errorInfo = @"超时,10秒未收到服务器返回结果";
            break;
        case TTTRtc_Error_Enter_Failed:
            errorInfo = @"该直播间不存在";
            break;
        case TTTRtc_Error_Enter_BadVersion:
            errorInfo = @"版本错误";
            break;
        case TTTRtc_Error_InvalidChannelName:
            errorInfo = @"Invalid channel name";
            break;
        default:
            errorInfo = [NSString stringWithFormat:@"未知错误：%zd",errorCode];
            break;
    }
    [TTProgressHud hideHud:self.view];
    [self showToast:errorInfo];
}

@end
