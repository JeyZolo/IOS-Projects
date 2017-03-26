//
//  GameData.h
//  
//
//  Created by 米拉 on 3/11/17.
//
//
#import <Foundation/Foundation.h>

@interface GameData : NSObject
@property int highscore;

+ (id)data;
- (void)save;
- (void)load;

@end
