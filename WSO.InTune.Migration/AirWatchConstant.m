//
//  AirWatchCN223Constant.m
//  IntuneMigrationTool
//
//  Created by Jonathon Poe on 7/5/19.
//  Copyright © 2019 Noblesite. All rights reserved.
//

#import "AirWatchConstant.h"

@implementation AirWatchConstant

@synthesize apiUrl;
@synthesize tenant;
@synthesize authorization;
@synthesize coporateOwnedId;
@synthesize coporateExecId;
@synthesize coporateOwnedTokenId;
@synthesize empolyeOwnedId;
@synthesize airWatchAppConfigs;
@synthesize airWatchUrl;

- (AirWatchConstant*)NewAirWatchEnv{
    
    AirWatchConstant *airWatch = [AirWatchConstant alloc];
   
    airWatch.airWatchAppConfigs = [self setAirWatchAppConfigs];
    airWatch.empolyeOwnedId = [airWatch.airWatchAppConfigs objectForKey:@"EmpolyeOwnedOgId"];
    airWatch.coporateOwnedId = [airWatch.airWatchAppConfigs objectForKey:@"CoporateOwnedOgId"];
    airWatch.apiUrl = [airWatch.airWatchAppConfigs objectForKey:@"APIURL"];
    airWatch.airWatchUrl = [airWatch.airWatchAppConfigs objectForKey:@"URL"];
    airWatch.tenant = [self unEncodeAppConfigs:[airWatch.airWatchAppConfigs objectForKey:@"Tenant"]];
    airWatch.authorization = [self unEncodeAppConfigs:[airWatch.airWatchAppConfigs objectForKey:@"Authorization"]];
    airWatch.coporateOwnedTokenId = @"0000";

    return airWatch;
}

-(NSDictionary*)setAirWatchAppConfigs{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
   
    if([prefs dictionaryForKey:@"com.apple.configuration.managed"]){
        
         NSDictionary *airWatchAppConfigs = [prefs dictionaryForKey:@"com.apple.configuration.managed"];
        
        return airWatchAppConfigs;
   
    }else{
        
        NSDictionary *airWatchAppConfigs = @{ @"APIURL" : @"unknown", @"Tenant" : @"unknown", @"Authorization" : @"unknown"};
        
        return airWatchAppConfigs;
    }
}

-(NSString*)unEncodeAppConfigs:(NSString*)data{
    
    NSData *encodedData = [[NSData alloc] initWithBase64EncodedString:data options:0];

    NSString *decoded = [[NSString alloc]initWithData:encodedData encoding:NSUTF8StringEncoding];
   
    return decoded;
}

- (NSString*)getApiUrl{
    
    
    return self.apiUrl;
}

- (NSString*)getTenant{
    
    
    return self.tenant;
}

- (NSString*)getAuthorization{
    
    
    return self.authorization;
}

- (NSString*)getCoporateOwnedId{
    
    
    return self.coporateOwnedId;
}
- (NSString*)getCoporateExecId{
    
    
    return self.coporateExecId;
}
- (NSString*)getCoporateOwnedTokenId{
    
    
    return self.coporateOwnedTokenId;
}
- (NSString*)getEmpolyeOwnedId{
    
    
    return self.empolyeOwnedId;
}

-(NSString*)getAirWatchURL{
    
    return self.airWatchUrl;
}


@end
