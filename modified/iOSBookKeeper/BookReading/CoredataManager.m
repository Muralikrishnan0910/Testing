//
//  CoredataManager.m
//  BookReading
//
//  Created by Thabib on 24/02/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "CoredataManager.h"

@implementation CoredataManager

-(NSArray*)getAllBookRecords
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Book"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSLog(@"%@",fetchedRecords);
   
    
    // Returning Fetched Records
    return fetchedRecords;
}

@end
