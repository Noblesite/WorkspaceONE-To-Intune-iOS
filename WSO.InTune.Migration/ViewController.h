//
//  ViewController.h
//  WAB.InTune.Migration
//
//  Created by Jonathon Poe on 9/3/19.
//  Copyright © 2019 Noblesite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ThirdPartyAppHandler.h"
#import "AppDelegate.h"
#import "DeviceInformation.h"
#import "AirWatchConstant.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *migrationButton;

- (IBAction)migrationButton:(id)sender;

@end

