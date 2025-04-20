//
//  AppDelegate.m
//  WAB.InTune.Migration
//
//  Created by Jonathon Poe on 9/3/19.
//  Copyright © 2019 Noblesite. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize deviceInfo;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  
    self.deviceInfo  = [[DeviceInformation alloc]NewDeviceInfo];
    [self checkDeviceInfomation];
 
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    
    [self saveContext];
}


-(void)startMigrationCompanyOwned{
    
    if(airWatchManaged){
    
        ThirdPartyAppHandler *appHandler = [[ThirdPartyAppHandler alloc]NewAppHandler];
        
        if([appHandler checkForCompanyPortal]){
            
            [self openMyCompanyPortal];
            [self removeDeviceFromAirWatch];
          
        }else{
            
           [self openAirWatchAppStore];
        }
        
    }else{
        
        [self deviceNotFoundNotification];
    }
}

-(void)empOwnedRemoveFromAirWatch{
    
    if(airWatchManaged){
      
        [self removeDeviceFromAirWatch];
        [self byodRemoveRequestNotification];
        
      }else{
          
        [self deviceNotFoundNotification];
      }
    
}
-(void)openAirWatchAppStore{
    
    ThirdPartyAppHandler *appHandler = [[ThirdPartyAppHandler alloc]NewAppHandler];
    AirWatchConstant *airWatchEnv  = [[AirWatchConstant alloc]NewAirWatchEnv];
    
    [appHandler openAirWatchAppStore:self.getDeviceInformation.getAirWatchUUID :airWatchEnv.getAirWatchURL];
   
}


-(void)checkDeviceInfomation{
    
    RestHandler *restHandler = [[RestHandler alloc]newRestHandler];
    self.deviceInfo = [restHandler getDeviceInfoAirWatch:self.deviceInfo];
    
    if([self.deviceInfo getAirWatchDeviceId] == NULL){
       
        [self deviceNotFoundNotification];
        airWatchManaged = false;
        
    }else{
        
        airWatchManaged = true;
        
    }
    
}

-(void)removeDeviceFromAirWatch{
    
    RestHandler *restHandler = [[RestHandler alloc]newRestHandler];
    
    [restHandler removeDeviceFromAirWatch:self.deviceInfo.getAirWatchDeviceId];
    
}

-(void)openMyCompanyPortal{
    
    ThirdPartyAppHandler *appHandler = [[ThirdPartyAppHandler alloc]NewAppHandler];
    
    [appHandler openMyCompanyPortalApplication];
}

- (void)setHasCompnayPortoal:(BOOL)hasApp{
    
    companyPortalInstalled = hasApp;
}

- (DeviceInformation*)getDeviceInformation{
    
    return self.deviceInfo;
}


- (void)deviceNotFoundNotification{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Device Not Found",nil)
                                                           message:[NSString stringWithFormat:NSLocalizedString(@"Sorry but we cannot find your device. Please check your Network connection then select Ok. Or, Please contact your AirWatch Admin",nil)]
                                                          delegate:self cancelButtonTitle:NSLocalizedString(@"Ok",nil) otherButtonTitles:nil, nil];
     alert.tag = 100;
           [alert show];
}

- (void)byodRemoveRequestNotification{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Request Sent",nil)
                                                           message:[NSString stringWithFormat:NSLocalizedString(@"The Request to Remove your device from AirWatch has been sent. You may now exit the Migration App. Thank You!",nil)]
                                                          delegate:self cancelButtonTitle:NSLocalizedString(@"Ok",nil) otherButtonTitles:nil, nil];
   
           [alert show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

      if(alertView.tag == 100){
          self.deviceInfo  = [[DeviceInformation alloc]NewDeviceInfo];
          [self checkDeviceInfomation];
      }


}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"WAB_InTune_Migration"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
