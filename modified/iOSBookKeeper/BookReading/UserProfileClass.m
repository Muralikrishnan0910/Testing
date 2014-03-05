//
//  UserProfileClass.m
//  BookReading
//
//  Created by Thabib on 06/02/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "UserProfileClass.h"

@implementation UserProfileClass
@synthesize UserNamesArray;



-(NSMutableArray *)GetUserNames
{
    UserNamesArray=[[NSMutableArray alloc]init];
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserProfile"
                                              inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    NSError* error;
    
    
    // Query on managedObjectContext With Generated fetchRequest
    
    
    NSArray *matchingData = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (!matchingData)
    {
        
                }
    else
    {
        for (int i=0; i<[matchingData count]; i++) {
            NSManagedObject *obj=[matchingData objectAtIndex:i];
            [UserNamesArray addObject:[obj valueForKey:@"userName"]];

    }
        

    }
    
   
    return  UserNamesArray;
    
}


@end
