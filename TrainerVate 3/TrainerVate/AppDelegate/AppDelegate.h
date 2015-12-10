//
//  AppDelegate.h
//  TrainerVate
//
//  Created by Matrid on 29/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <AVFoundation/AVFoundation.h>
#import "Constants.h"
#import "AccountTypeController.h"
#import "GAI.h"
#import "GAIFields.h"

@class XOViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
// Used for sending Google Analytics traffic in the background.
@property(nonatomic, assign) BOOL okToWait;
@property(nonatomic, copy) void (^dispatchHandler)(GAIDispatchResult result);
@property (strong, nonatomic) id<GAITracker> tracker;
@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)SlideNavigationController *ObjNavi;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) AccountTypeController *viewController;
@property (nonatomic, strong) AVPlayer *player;
@property(nonatomic,strong)NSString *StrDeviceToken;
+(AppDelegate*)shared;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
+(void)generateTheAPiKey;
- (void)initializeGoogleAnalytics;

@end

