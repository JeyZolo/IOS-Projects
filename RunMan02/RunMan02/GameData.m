//
//  GameData.m
//  RunMan02
//
//  Created by 米拉 on 3/11/17.
//  Copyright © 2017 米拉. All rights reserved.
//

#import "GameData.h"

@interface GameData ()
@property NSString *filePath;
@end

@implementation GameData

+ (id)data
{
    GameData *data = [GameData new];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileName = @"archive.data";
    data.filePath = [path stringByAppendingString:fileName];
    
    NSLog(@"Change some stuff");
    NSLog(@"Change some other stuff");
    
    return data;
}

- (void)save
{
    NSNumber *highscoreObject = [NSNumber numberWithInteger:self.highscore];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:highscoreObject];
    [data writeToFile:self.filePath atomically:YES];
}

- (void)load
{
    NSData *data = [NSData dataWithContentsOfFile:self.filePath];
    NSNumber *highscoreObject = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.highscore = highscoreObject.intValue;
}

@end

