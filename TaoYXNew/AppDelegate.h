//
//  AppDelegate.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/7.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "GeTuiSdk.h"

#define kGtAppId           @"ZmGN60TU3d9nJKATYX1jt9"
#define kGtAppKey          @"1nz1bsRGPh8BaOQyQTOOM6"
#define kGtAppSecret       @"fxWjnExPUf7ua6M590WX75"

@interface AppDelegate : UIResponder <UIApplicationDelegate,GeTuiSdkDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

