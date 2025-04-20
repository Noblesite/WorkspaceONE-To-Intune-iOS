//
//  ThirdPartyAppHandler.m
//  IntuneMigrationTool
//
//  Created by Jonathon Poe on 7/11/19.
//  Copyright © 2019 Noblesite. All rights reserved.
//

#import "ThirdPartyAppHandler.h"

@implementation ThirdPartyAppHandler


-(ThirdPartyAppHandler*)NewAppHandler{
    
    ThirdPartyAppHandler *appHandler = [ThirdPartyAppHandler alloc];
    
    return appHandler;
}

-(bool)openMyCompanyPortalApplication{
    
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:@"companyportal://"];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (!success) {
            NSLog(@"****** Company Portal Failed to Open ******");
            
        }
    }];
    
    return true;
}

-(BOOL)checkForCompanyPortal{
    
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:@"companyportal://"];
     
    if([application canOpenURL:URL]){
        
        return true;
        
    }else{
        
        return false;
    }
}

- (void)openAirWatchAppStore:(NSString*)deviceUUID :(NSString*)url{
    
    UIApplication *application = [UIApplication sharedApplication];
    
    // JP to update URL to make it dynamic per enviroment
    NSString *tmpURL = [NSString stringWithFormat:@"%@/DeviceManagement/AppCatalog?uid=%@&type=2",url, deviceUUID];
    NSURL *URL = [NSURL URLWithString:tmpURL];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (!success) {
               
            NSLog(@"******* AirWatch App Store Open **********");
        }
    }];
}



@end
