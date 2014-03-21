//
//  BookSet.h
//  Hispark.BookKeeper
//
//  Created by Thabib on 07/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BookSet : NSManagedObject

@property (nonatomic, retain) NSString * authorName;
@property (nonatomic, retain) NSString * bookName;
@property (nonatomic, retain) NSNumber * completedBook;
@property (nonatomic, retain) NSString * cuserName;
@property (nonatomic, retain) NSNumber * pagesRead;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSNumber * totalPages;
@property (nonatomic, retain) NSData * notes;

@end
