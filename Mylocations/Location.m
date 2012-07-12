//
//  Location.m
//  Mylocations
//
//  Created by vinguyen on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Location.h"


@implementation Location

@dynamic latitude;
@dynamic longitude;
@dynamic date;
@dynamic locationDescription;
@dynamic category;
@dynamic placemark;
@dynamic photoId;

- (BOOL)hasPhoto
{
    return (self.photoId != nil) && ([self.photoId intValue] != -1);
}

-(NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
    
}

-(NSString *)photoPath 
{
    NSString *filename = [NSString stringWithFormat:@"Photo-%d.png", [self.photoId intValue]];
    return [[self documentsDirectory] stringByAppendingPathComponent:filename];
}

- (UIImage *)photoImage
{
    NSAssert(self.photoId != nil, @"No photo ID set");
    NSAssert([self.photoId intValue] != -1, @"Photo ID is -1");
    
    return [UIImage imageWithContentsOfFile:[self photoPath]];
}


-(void)removePhotoFile
{
    NSString *path = [self photoPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error;
        if (![fileManager removeItemAtPath:path error:&error]) {
            NSLog(@"Error removing file: %@", error);
        }
    }
}
#pragma mark MKAnotation datasource
- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

- (NSString *)title
{
    if ([self.locationDescription length] > 0) {
        return self.locationDescription;
    } else {
        return @"(No Description)";
    }
}

- (NSString *)subtitle
{
    return self.category;
}
@end