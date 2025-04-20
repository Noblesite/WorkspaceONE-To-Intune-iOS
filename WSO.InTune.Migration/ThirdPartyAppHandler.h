//
//  ThirdPartyAppHandler.h
//  IntuneMigrationTool
//
//  Created by Jonathon Poe on 7/11/19.
//  Copyright © 2019 Noblesite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThirdPartyAppHandler : NSObject

-(ThirdPartyAppHandler*)NewAppHandler;
-(bool)openMyCompanyPortalApplication;
-(BOOL)checkForCompanyPortal;
-(void)openAirWatchAppStore:(NSString*)deviceUUID :(NSString*)url;


@end

NS_ASSUME_NONNULL_END
