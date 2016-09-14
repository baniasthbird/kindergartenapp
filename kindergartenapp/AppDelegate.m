//
//  AppDelegate.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/13.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <UIKit/UIKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:245/255.0f green:111/255.0f blue:54/255.0f alpha:1]];
    NSDictionary * dict=@{NSForegroundColorAttributeName:   [UIColor whiteColor]};
    
    [[UINavigationBar appearance] setTitleTextAttributes:dict];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"FZSEJW--GB1-0" size:12.0]}            forState:UIControlStateNormal];
    
    /*
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    self.window.rootViewController=[storyboard instantiateInitialViewController];
    
    */
    
    [self enter];
    [self.window makeKeyAndVisible];
     
    
    sleep(2);
    
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
}


-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
        NSString *str_version= [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        float d_version=[str_version floatValue];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        float d_older_version=[defaults floatForKey:@"systemversion"];
        NSString *str_version1=[self notRounding:d_version afterPoint:2];
        NSString *str_older_version=[self notRounding:d_older_version afterPoint:2];
        if (![str_version1 isEqualToString:str_older_version]) {
            [defaults setBool:YES forKey:@"firstLaunch"];
            [defaults setFloat:d_version forKey:@"systemversion"];
        }
        else {
            [defaults setBool:NO forKey:@"firstLaunch"];
        }
    [defaults synchronize];
    
    
     return YES;

}

-(BOOL)checkUpdate:(NSString*)str_url {
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfURL:[NSURL URLWithString:str_url]];
    if (dict) {
        
        NSArray* list = [dict objectForKey:@"items"];
        NSDictionary* dict2 = [list objectAtIndex:0];
        
        NSDictionary* dict3 = [dict2 objectForKey:@"metadata"];
        NSString* newVersion = [dict3 objectForKey:@"bundle-version"];
        CGFloat f_newVersion=[newVersion floatValue];
        
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *myVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
        CGFloat f_myVersion=[myVersion floatValue];
        
        if (f_newVersion>f_myVersion) {
            return YES;
        }
    }
    return NO;
    
}

-(NSString *)notRounding:(float)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

-(void)enter {
    NSString *str_url=@"https://app.hnsi.cn/kindergartenapp/kindergartenapp.plist";
    BOOL b_update= [self checkUpdate:str_url];
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ViewController *vc_login=[storyboard instantiateInitialViewController];
    vc_login.b_update=b_update;
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc_login];
    self.window.rootViewController=nav;
    

  }



@end
