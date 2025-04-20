//
//  RestHandler.h
//  IntuneMigrationTool
//
//  Created by Jonathon Poe on 7/5/19.
//  Copyright © 2019 Noblesite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AirWatchConstant.h"
#import "DeviceInformation.h"

NS_ASSUME_NONNULL_BEGIN

@interface RestHandler : NSURLConnection <NSURLConnectionDelegate>

@property (nonatomic, retain)  AirWatchConstant *airWatchEnv;

- (RestHandler*)newRestHandler;
- (DeviceInformation*)getDeviceInfoAirWatch:(DeviceInformation*)deviceInformation;
- (bool)removeDeviceFromAirWatch:(NSString*)deviceId;

@end

NS_ASSUME_NONNULL_END
