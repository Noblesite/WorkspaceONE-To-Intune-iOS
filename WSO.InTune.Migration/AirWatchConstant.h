//
//  AirWatchCN223Constant.h
//  IntuneMigrationTool
//
//  Created by Jonathon Poe on 7/5/19.
//  Copyright © 2019 Noblesite. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AirWatchConstant : NSObject

@property (nonatomic, retain) NSString *apiUrl; 
@property (nonatomic, retain) NSString *tenant;
@property (nonatomic, retain) NSString *authorization;
@property (nonatomic, retain) NSString *coporateOwnedId;
@property (nonatomic, retain) NSString *coporateExecId;
@property (nonatomic, retain) NSString *coporateOwnedTokenId;
@property (nonatomic, retain) NSString *empolyeOwnedId;
@property (nonatomic, retain) NSDictionary *airWatchAppConfigs;
@property (nonatomic, retain) NSString *airWatchUrl;

- (AirWatchConstant*)NewAirWatchEnv;
- (NSString*)getApiUrl;
- (NSString*)getTenant;
- (NSString*)getAuthorization;
- (NSString*)getEmpolyeOwnedId;
- (NSString*)getCoporateOwnedTokenId;
- (NSString*)getCoporateExecId;
- (NSString*)getCoporateOwnedId;
- (NSString*)getAirWatchURL;

@end

NS_ASSUME_NONNULL_END
