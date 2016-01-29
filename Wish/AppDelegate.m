//
//  AppDelegate.m
//  Wish
//
//  Created by Annie Klekchyan on 1/15/16.
//  Copyright © 2016 TLab. All rights reserved.
//

#import "AppDelegate.h"
#import "PublicService.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "JKLLockScreenViewController.h"
#import "Configuration.h"
#import "Definitions.h"
#import "WishUtils.h"
#import "PrivateService.h"

@interface AppDelegate ()
@property(nonatomic, retain) JKLLockScreenViewController * JKViewController;
@end

@implementation AppDelegate
@synthesize JKViewController;
@synthesize webConfiguration;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    webConfiguration = [[WebConfiguration alloc] init];
    [[PublicService sharedInstance] getConfigurationOnCompletion:^(NSDictionary *result, BOOL isSucess) {
       
        if(isSucess){
        
            webConfiguration.colorsArray = [[[result objectForKey:@"configs"] objectForKey:@"decorations"] objectForKey:@"colors"];
            webConfiguration.maxSymbolsCount = [[result objectForKey:@"max_symbols"] integerValue];
        }else{
            
            [WishUtils showErrorAlertWithTitle:@"" AndText:[result objectForKey:@"message"]];
        }
    }];
    
    [WishUtils configureNavigationBar];
    [WishUtils configureTabBar];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:@"1234" forKey:kpinCode];
    [defaults synchronize];
    [self fillConfiguration];
    [self passCodeCkeck];
    
    if (self.configuration.token && ![self.configuration.token isEqualToString:@""]) {
        
        [[PrivateService sharedInstance] getWishesOnCompletion:^(NSDictionary *result, BOOL isSucess) {
            
            if(isSucess){
                
                NSLog(@"%@", result);
            }else{
                
            }
        }];
    }
    
    return YES;
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.Tlab.Wish" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Wish" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Wish.sqlite"];
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
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
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

-(void)fillConfiguration{
    
    _configuration = [[Configuration alloc] init];
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    self.configuration.pinCode = [defs objectForKey:kpinCode];
    self.configuration.token = [defs objectForKey:ktoken];
}

// JKLLockScreenViewController Delegate
- (void)unlockWasSuccessfulLockScreenViewController:(JKLLockScreenViewController *)lockScreenViewController pincode:(NSString *)pincode{
    
}

- (void)unlockWasSuccessfulLockScreenViewController:(JKLLockScreenViewController *)lockScreenViewController{
    
}

- (void)unlockWasCancelledLockScreenViewController:(JKLLockScreenViewController *)lockScreenViewController{
    
}

- (void)unlockWasFailureLockScreenViewController:(JKLLockScreenViewController *)lockScreenViewController{
    
}

// JKLLockScreenViewController DataSource
- (BOOL)lockScreenViewController:(JKLLockScreenViewController *)lockScreenViewController pincode:(NSString *)pincode{
    
    if([self.configuration.pinCode isEqualToString:pincode]){
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UINavigationController *rootNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"RootNavigationController"];
        self.window.rootViewController = rootNavigationController;
        return YES;
    }else{
        
        [WishUtils shakeAnimationWithViewComtroller:JKViewController];
    }
    
    return NO;
}

- (BOOL)allowTouchIDLockScreenViewController:(JKLLockScreenViewController *)lockScreenViewController{
 
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Authentication";
    
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    // User authenticated successfully, take appropriate action
                                    
                                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                    UINavigationController *rootNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"RootNavigationController"];
                                    self.window.rootViewController = rootNavigationController;
                                    
                                } else {
                                    // User did not authenticate successfully, look at error and take appropriate action
                                }
                            }];
    } else {
        // Could not evaluate policy; look at authError and present an appropriate message to user
    }
    return YES;
}

- (void) passCodeCkeck{
 
    JKViewController = [[JKLLockScreenViewController alloc] initWithNibName:NSStringFromClass([JKLLockScreenViewController class]) bundle:nil];
    [JKViewController setLockScreenMode:LockScreenModeNormal]; // enum { LockScreenModeNormal, LockScreenModeNew, LockScreenModeChange }
    [JKViewController setDelegate:self];
    [JKViewController setDataSource:self];
    
    self.window.rootViewController = JKViewController;
}

@end
