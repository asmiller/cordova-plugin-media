#import "MainViewController+CDVRemote.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation MainViewController (CDVRemote)

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    AVAudioSession *audioSession = [AVAudioSession sharedInstance];

    NSError *setCategoryError = nil;
    BOOL success = [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    if (!success) { /* handle the error condition */ }

    NSError *activationError = nil;
    success = [audioSession setActive:YES error:&activationError];
    if (!success) { /* handle the error condition */ }


    // Turn on remote control event delivery
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

    // Set itself as the first responder
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {

    // Turn off remote control event delivery
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];

    // Resign as first responder
    [self resignFirstResponder];

    [super viewWillDisappear:animated];
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)theEvent
{
  if (theEvent.type == UIEventTypeRemoteControl)
  {
    NSString *jsString = [NSString stringWithFormat:@"%@(\"%@\",%d);", @"cordova.require('org.apache.cordova.media.Media').onStatus", "controls", theEvent.subtype];
    [self.commandDelegate evalJs:jsString];
  }
}

@end