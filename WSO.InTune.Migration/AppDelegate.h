//
//  AppDelegate.h
//  WAB.InTune.Migration
//
//  Created by Jonathon Poe on 9/3/19.
//  Copyright © 2019 Noblesite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DeviceInformation.h"
#import "RestHandler.h"
#import "ThirdPartyAppHandler.h"
#import "AirWatchConstant.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>{
    
    BOOL hasCompanyPortal;
    BOOL companyPortalInstalled;
    BOOL airWatchManaged;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong, nonatomic) DeviceInformation *deviceInfo;

- (void)saveContext;
- (void)startMigrationCompanyOwned;
- (void)empOwnedRemoveFromAirWatch;
- (void)setHasCompnayPortoal:(BOOL)hasApp;
- (DeviceInformation*)getDeviceInformation;

@end

