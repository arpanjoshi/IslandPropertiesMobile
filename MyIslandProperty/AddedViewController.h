//
//  AddedViewController.h
//  MyIslandProperty
//
//  Created by Adrian Rusin on 12/23/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface AddedViewController : UIViewController{
//    ALAssetsLibrary *library;
//    NSArray *imageArray;
//    NSMutableArray *mutableArray;
    NSMutableArray *finalArray;
}
//-(void)allPhotosCollected:(NSArray*)imgArray;

@property(nonatomic, strong) NSString *strPropertyName;
@property int ipaOrAddress;
@end
