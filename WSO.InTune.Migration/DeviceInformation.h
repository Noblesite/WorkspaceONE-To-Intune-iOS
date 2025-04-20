//
//  DeviceInformation.h
//  IntuneMigrationTool
//
//  Created by Jonathon Poe on 7/5/19.
//  Copyright © 2019 Noblesite. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceInformation : NSObject

@property (nonatomic, retain) NSString *deviceSerialNumber;
@property (nonatomic, retain) NSString *airWatchDeviceId;
@property (nonatomic, retain) NSString *locationGroupId;
@property (nonatomic, retain) NSString *enrollmentStatus;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *airWatchUUID;
@property (nonatomic, retain) NSDictionary *airWatchAppConfigs;

- (DeviceInformation*)NewDeviceInfo;
- (NSString*)getAirWatchDeviceId;
- (NSString*)getLocationGroupId;
- (NSString*)getDeviceSerialNumber;
- (NSString*)getUserName;
- (NSString*)getAirWatchUUID;
- (void)setGroupId:(NSString*)groupId;
- (void)setDeviceId:(NSString*)deviceId;



@end

NS_ASSUME_NONNULL_END
