//
//  ViewController.m
//  WAB.InTune.Migration
//
//  Created by Jonathon Poe on 9/3/19.
//  Copyright © 2019 Noblesite. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize migrationButton;
@synthesize userNameLabel;
@synthesize messageTextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view
 
    [self setMigrationButton:migrationButton];
    [self setUserNameLabel:self.userNameLabel];
    
}

- (AppDelegate *)appDelegate{
   
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


-(void)setMigrationButton:(UIButton *)migration{
    
    DeviceInformation *deviceInfo = [[self appDelegate]getDeviceInformation];
    AirWatchConstant *airWatchEnv  = [[AirWatchConstant alloc]NewAirWatchEnv];
    ThirdPartyAppHandler *appHandler = [[ThirdPartyAppHandler alloc]NewAppHandler];
         
    if([deviceInfo.getLocationGroupId intValue] != [airWatchEnv.getEmpolyeOwnedId intValue]){

         if([appHandler checkForCompanyPortal]){
             
             [migration setTitle:@"Migrate to InTune" forState:UIControlStateNormal];
             
             NSLog(@"******** Migrate to InTune" );
             
         }else{
            
           
             [migration setTitle:@"Download Compnay Portal" forState:UIControlStateNormal];
                      
             NSLog(@"******** Download Company Portal" );
         }

    }else{
        
        [migration setTitle:@"BYOD: Remove From AirWatch" forState:UIControlStateNormal];
                 
        NSLog(@"******** BYOD: Remove From AirWatch" );
    }
    
    migration.layer.cornerRadius = 15;
    migration.clipsToBounds = YES;
    [migration.layer setBorderWidth:5];
    [migration.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [migration setTintColor:[UIColor whiteColor]];
    [migration setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}



-(void)setUserNameLabel:(UILabel *)userNameLabel{
    
    DeviceInformation *deviceInfo = [[self appDelegate]getDeviceInformation];
    [userNameLabel setText:[deviceInfo getUserName]];
}


- (IBAction)migrationButton:(id)sender {
   
    DeviceInformation *deviceInfo = [[self appDelegate]getDeviceInformation];
    AirWatchConstant *airWatchEnv  = [[AirWatchConstant alloc]NewAirWatchEnv];
    
    if([deviceInfo.getLocationGroupId intValue] != [airWatchEnv.getEmpolyeOwnedId intValue]){
    
        [[self appDelegate]startMigrationCompanyOwned];
        
        [(UIButton *)sender setTitle:@"Migrate to InTune" forState:UIControlStateNormal];
        [(UIButton *)sender setTitle:@"Migrate to InTune" forState:UIControlStateSelected];
        [(UIButton *)sender setTitle:@"Migrate to InTune" forState:UIControlStateHighlighted];
        
    }else{
        
        [[self appDelegate]empOwnedRemoveFromAirWatch];
    }
 
}
@end
