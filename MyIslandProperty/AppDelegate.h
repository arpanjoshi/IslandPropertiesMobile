//
//  AppDelegate.h
//  MyIslandProperty
//
//  Created by Adrian Rusin on 12/23/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate, DBSessionDelegate, DBNetworkRequestDelegate>
{
    NSString *relinkUserId;
    
}

@property (strong, nonatomic) UIWindow *window;

@property int downloadFileIndex;
+ (AppDelegate *) sharedAppDelegate;

@end

