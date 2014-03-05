//
//  Book.h
//  BookReading
//
//  Created by BSA Univ20 on 04/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UserProfileDataModel;

@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * addnotes;
@property (nonatomic, retain) NSString * authorName;
@property (nonatomic, retain) NSString * bookName;
@property (nonatomic, retain) NSString * bookStatus;
@property (nonatomic, retain) NSNumber * pagesCompleted;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSNumber * totalPages;
@property (nonatomic, retain) UserProfileDataModel *logedinname;

@end
