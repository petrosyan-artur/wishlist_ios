//
//  AppDelegate.h
//  Wish
//
//  Created by Annie Klekchyan on 1/15/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "JKLLockScreenViewController.h"
#import "Configuration.h"
#import "WebConfiguration.h"
#import "Definitions.h"

@import HockeySDK;

typedef enum PageIndexTypes
{
    HOME_PAGE,
    LIKES_PAGE,
    MY_WISHES_PAGE
} PageIndex;

@interface AppDelegate : UIResponder <UIApplicationDelegate, JKLLockScreenViewControllerDataSource, JKLLockScreenViewControllerDelegate, BITHockeyManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(nonatomic, retain) JKLLockScreenViewController * JKViewController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (nonatomic, strong) Configuration *configuration;
@property (nonatomic, strong) WebConfiguration *webConfiguration;
@property (nonatomic, strong) NSMutableArray *wishArray;
@property (assign, nonatomic) PageIndex currentPageIndex;

@end

