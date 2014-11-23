#import "MainViewController+CDVRemote.h"

@implementation MainViewController (CDVRemote)

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

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