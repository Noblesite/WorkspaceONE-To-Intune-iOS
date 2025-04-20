//
//  DeviceInformation.m
//  IntuneMigrationTool
//
//  Created by Jonathon Poe on 7/5/19.
//  Copyright © 2019 Noblesite. All rights reserved.
//

#import "DeviceInformation.h"

@implementation DeviceInformation

@synthesize airWatchDeviceId;
@synthesize locationGroupId;
@synthesize deviceSerialNumber;
@synthesize userName;
@synthesize airWatchUUID;
@synthesize airWatchAppConfigs;

- (DeviceInformation*)NewDeviceInfo{
    
    DeviceInformation *newDevice = [DeviceInformation alloc];
    newDevice.airWatchAppConfigs = [self setAirWatchAppConfigs];
    newDevice.deviceSerialNumber = [newDevice.airWatchAppConfigs objectForKey:@"serialNumber"];
    newDevice.airWatchUUID = [newDevice.airWatchAppConfigs objectForKey:@"UUID"];
    NSString *firstName = [newDevice.airWatchAppConfigs objectForKey:@"FirstName"];
    NSString *lastName  = [newDevice.airWatchAppConfigs objectForKey:@"LastName"];
    newDevice.userName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    return newDevice;
}

-(NSDictionary*)setAirWatchAppConfigs{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
   
    if([prefs dictionaryForKey:@"com.apple.configuration.managed"]){
        
         NSDictionary *airWatchAppConfigs = [prefs dictionaryForKey:@"com.apple.configuration.managed"];
        
        return airWatchAppConfigs;
   
    }else{
        
        NSDictionary *airWatchAppConfigs = @{ @"serialNumber" : @"unknown", @"UUID" : @"unknown", @"FirstName" : @"unknown", @"LastName" : @"unknown", @"DeviceId" : @"unknown"};
        
        return airWatchAppConfigs;
    }
}

-(void)setUserName{
    
    NSString *firstName = [self.airWatchAppConfigs objectForKey:@"FirstName"];
    NSString *lastName  = [self.airWatchAppConfigs objectForKey:@"LastName"];
    
    self.userName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
}




- (NSString*)getDeviceSerialNumber{
    
    
    return self.deviceSerialNumber;
}

- (NSString*)getLocationGroupId{
    
    
    return self.locationGroupId;
}

- (NSString*)getAirWatchDeviceId{
    
    
    return self.airWatchDeviceId;
}

- (NSString*)getUserName{
    
    return self.userName;
}

- (void)setGroupId:(NSString*)groupId{
    
    self.locationGroupId = groupId;
}

- (void)setDeviceId:(NSString*)deviceId{
    
    self.airWatchDeviceId = deviceId;
}

- (NSString*)getAirWatchUUID{
    
    return self.airWatchUUID;
}

@end
