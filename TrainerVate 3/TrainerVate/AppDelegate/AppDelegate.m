//
//  AppDelegate.m
//  TrainerVate
//
//  Created by Matrid on 29/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//
/******* Set your tracking ID here *******/




#import "AppDelegate.h"
#import "MainScreenController.h"
#import "AccountTypeController.h"
#import "Constants.h"
#import "DatePickerController.h"
#import "MessageController.h"
#import <Parse/Parse.h>
#import <Bolts/Bolts.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>



static BOOL const kGaDryRun = NO;
static int const kGaDispatchPeriod = 30;
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize ObjNavi,StrDeviceToken;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Fabric with:@[[Crashlytics class]]];
    [Crashlytics sharedInstance].debugMode = YES;
    // Override point for customization after application launch.
    //AccountTypeController *viewCon=[[AccountTypeController alloc]init];
    //self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [Parse setApplicationId:@"w0DS8OxQXVKY8sfawyrzNNSlolwVf6G0RmGhZ9bQ"
                  clientKey:@"Y9duTGm7RvgSZwolsV3luCBP6x2veW7Gu0IhbVsv"];
    
    // [self initializeGoogleAnalytics];
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:kGoogleAnalyticsID];
    
    // Provide unhandled exceptions reports.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Enable Remarketing, Demographics & Interests reports. Requires the libAdIdAccess library
    // and the AdSupport framework.
    // https://developers.google.com/analytics/devguides/collection/ios/display-features
    tracker.allowIDFACollection = YES;

    
    float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if(ver >= 8 && ver<9)
    {
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
        {
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            
        }
    }else if (ver >=9){
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    
    
    // Register for Push Notitications
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];

    
    [NSThread sleepForTimeInterval:0.9];
    [[NSUserDefaults standardUserDefaults]setObject:@"Yes" forKey:@"loadUser"];// adding value to weather load user or not
    
    
    NSString *apiKey=[[NSUserDefaults standardUserDefaults]objectForKey:@"apiKey"];
    if (apiKey.length==0 || apiKey==nil) {
        NSString *urlString=[Globals urlCombile:kApiDomin ClassUrl:kUrlGenerateApiKey apiKey:@""];
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:urlString parameters:[NSDictionary dictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError* error;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:kNilOptions error:&error];
            
            [[NSUserDefaults standardUserDefaults]setObject:[json objectForKey:@"key"] forKey:@"apiKey"];
           // [Globals alert:@"Alert" :@"Secuss"];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [Globals alert:@"Something went wrong. Please try again later"];
        }];
    }
    [Globals sharedInstance];
    

    
//     [SingletonClass singleton].addStatsValuse=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"Height",@"",@"Weight",@"",@"Waist_Size",@"",@"Body_fat_%",@"",@"Arm_size",@"",@"Leg_Size",@"",@"Water_%",@"",@"Chest size",@"",@"Total_weight",@"",@"Physical_ratings",@"",@"Bone Mass",@"",@"BMR",@"",@"Visceral_fat",@"",@"Arm_-_r",@"",@"Arm_-_I",@"",@"Trunk",@"",@"Leg_-_r",@"",@"Leg_-I",@"",@"Pectoral",@"",@"Abdominal",@"",@"Thigh",@"",@"Triceps",@"",@"Subscapular",@"",@"Supariliac",@"",@"Axilla",@"",@"BFArm_-_r",@"",@"BFArm_-_I",@"",@"BFLeg_-_r",@"",@"BFLeg_-_I", nil];
    
    // adding slide menu
    
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
//    DatePickerController *ObjLoginView;
//    
//        ObjLoginView=[[DatePickerController alloc]initWithNibName:@"DatePickerController" bundle:nil];
    
//    AccountTypeController *ObjLoginView;
//    
//    ObjLoginView=[[AccountTypeController alloc]initWithNibName:@"AccountTypeController" bundle:nil];

    AccountTypeController *ObjLoginView;
    
    ObjLoginView=[[AccountTypeController alloc]initWithNibName:@"AccountTypeController" bundle:nil];
    
    ObjNavi=[[SlideNavigationController alloc]initWithRootViewController:ObjLoginView];
    ObjNavi.navigationBarHidden=YES;

    
    rightMenuController *ObjRight=[[rightMenuController alloc]init];
    
    [SlideNavigationController sharedInstance].rightMenu = ObjRight;
    // Creating a custom bar button for right menu
    
    
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@"Navi"] forState:UIControlStateNormal];
    [button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [SlideNavigationController sharedInstance].leftBarButtonItem = rightBarButtonItem;
    
    
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        
    }
    else{
        
        [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIFont fontWithName:@"SinkinSans-400Regular" size:17],
          NSFontAttributeName,  [UIColor whiteColor],NSForegroundColorAttributeName,
          [UIColor whiteColor],NSBackgroundColorAttributeName,nil]];
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidClose object:nil queue:nil usingBlock:^(NSNotification *note) {

    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidOpen object:nil queue:nil usingBlock:^(NSNotification *note) {

    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidReveal object:nil queue:nil usingBlock:^(NSNotification *note) {
    }];
    

    
    [self.window addSubview:ObjNavi.view];
    self.window.rootViewController = ObjNavi;
    [self.window makeKeyAndVisible];
    

    
    return YES;
}
//- (void)initializeGoogleAnalytics {
//    
//    [[GAI sharedInstance] setDispatchInterval:kGaDispatchPeriod];
//    [[GAI sharedInstance] setDryRun:kGaDryRun];
//    self.tracker = [[GAI sharedInstance] trackerWithTrackingId:kGaPropertyId];
//}
+(AppDelegate*)shared {
    
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
+(void)generateTheAPiKey
{
        NSString *apiKey=[[NSUserDefaults standardUserDefaults]objectForKey:@"apiKey"];
        if (apiKey.length==0 || apiKey==nil) {
            NSString *urlString=[Globals urlCombile:kApiDomin ClassUrl:kUrlGenerateApiKey apiKey:@""];
            AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manager POST:urlString parameters:[NSDictionary dictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSError* error;
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:kNilOptions error:&error];
                
                [[NSUserDefaults standardUserDefaults]setObject:[json objectForKey:@"key"] forKey:@"apiKey"];
                // [Globals alert:@"Alert" :@"Secuss"];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [Globals alert:@"Something went wrong. Please try again later"];
            }];
        }
    
    
}

#pragma mark Notification Methods

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *devToken = [[[[deviceToken description]
                            stringByReplacingOccurrencesOfString:@"<"withString:@""]
                           stringByReplacingOccurrencesOfString:@">" withString:@""]
                          stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
    
    // Update the device token record in our database
#if !defined (CONFIGURATION_Distribution)
    // Update the database with our development device token
#endif
    
#if defined (CONFIGURATION_Distribution)
    // Update the database with our production device token
#endif
    
    StrDeviceToken=devToken;
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    // NSString *str = [NSString stringWithFormat: @"Error: %@", err];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
   
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"snacksDay"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"lunchDay"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"breakDay"];
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.Trainervate.TrainerVate" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TrainerVate" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TrainerVate.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
