//
//  RestHandler.m
//  IntuneMigrationTool
//
//  Created by Jonathon Poe on 7/5/19.
//  Copyright © 2019 Noblesite. All rights reserved.
//

#import "RestHandler.h"

@interface RestHandler () <NSURLConnectionDelegate>


@end


@implementation RestHandler

@synthesize airWatchEnv;

- (RestHandler*)newRestHandler{
    
    RestHandler *restHandler = [RestHandler alloc];
    restHandler.airWatchEnv  = [[AirWatchConstant alloc]NewAirWatchEnv];
    
    return restHandler;
}

- (DeviceInformation*)getDeviceInfoAirWatch:(DeviceInformation*)deviceInformation{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/mdm/devices?searchby=Serialnumber&id=%@", self.airWatchEnv.getApiUrl, deviceInformation.getDeviceSerialNumber];
    
    [request setURL:[NSURL URLWithString:urlString]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:self.airWatchEnv.getAuthorization forHTTPHeaderField:@"Authorization"];
    [request setValue:self.airWatchEnv.getTenant forHTTPHeaderField:@"aw-tenant-code"];
    [request setValue:@"no-cache" forHTTPHeaderField:@"cache-control"];
    [request setValue:@"0" forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
 
  
   
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
   
    NSLog(@"****Sending Get Device Information Request*********");
    
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
       
    if ([response statusCode] != 200){
       
        NSLog(@"Getting Response Error when calling AirWatch get info on the device by s/n, Check API Auth or Network connection");
        NSString *myString = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];

        NSLog(@"API Response: %@", myString);
        return NULL;
    }
    
    
    NSLog(@"****Request Returned with 200 status Code *********");
    
    return [self parseAirWatchDeviceInfoReturn:[self parseJsonResponse:urlData] :deviceInformation];
    
}

- (bool)removeDeviceFromAirWatch:(NSString*)deviceId{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/mdm/devices/%@", self.airWatchEnv.getApiUrl, deviceId];
    
    [request setURL:[NSURL URLWithString:urlString]];
    
    [request setHTTPMethod:@"DELETE"];
    [request setValue:self.airWatchEnv.getAuthorization forHTTPHeaderField:@"Authorization"];
    [request setValue:self.airWatchEnv.getTenant forHTTPHeaderField:@"aw-tenant-code"];
    [request setValue:@"no-cache" forHTTPHeaderField:@"cache-control"];
    [request setValue:@"0" forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    
    
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    
    NSLog(@"****Sending Delete Device Request*********");
    
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    
    NSString *jsonString = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    if ([response statusCode] != 200){
        
       NSLog(@"Getting Response Error when calling AirWatch to remove the Device");
        
        return false;
    }
    
    NSLog(@"**** Request Returned with 200 status Code for Removing Device *********");
    
    return true;
}


- (NSDictionary*)parseJsonResponse:(NSData*)response{
    
    NSDictionary *results;
    
    if(NSClassFromString(@"NSJSONSerialization")){
        NSError *error = nil;
        id object = [NSJSONSerialization
                     JSONObjectWithData:response
                     options:0
                     error:&error];
       
        results = object;
       
        if(error) {
            
            NSLog(@"Error From Json parsing: %@", error);
        }
    }
    
    return results;
}

- (DeviceInformation*)parseAirWatchDeviceInfoReturn:(NSDictionary*)deviceInfo :(DeviceInformation*)deviceInformation{
    
    for (id key in deviceInfo) {
        
        if([key isEqualToString:@"Id"]){
            
            NSDictionary *idValue = [deviceInfo objectForKey:key];
            
            for(id key in idValue){
                
                if([key isEqualToString:@"Value"]){
                    
                    NSString *deviceId = [idValue objectForKey:key];
                    
                    [deviceInformation setDeviceId:deviceId];
                   
                }
            }
        }
        
        if([key isEqualToString:@"LocationGroupId"]){
                  
            NSDictionary *idValue = [deviceInfo objectForKey:key];
                  
            for(id key in idValue){
                      
                if([key isEqualToString:@"Id"]){
                          
                    NSDictionary *ogIdValue = [idValue objectForKey:key];
                          
                    for(id key in ogIdValue){
                              
                        if([key isEqualToString:@"Value"]){
                                    
                            NSString *groupId = [ogIdValue objectForKey:key];
                            [deviceInformation setGroupId:groupId];
                        }
                    }
                }
            }
        }
    }
    
    return deviceInformation;
}

@end
