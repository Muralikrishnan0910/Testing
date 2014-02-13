//
//  UpdatePage.h
//  bookdetails
//
//  Created by BSA Univ15 on 13/02/14.
//  Copyright (c) 2014 BSA Univ15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BookDetails;

@interface UpdatePage : NSManagedObject

@property (nonatomic, retain) NSString * pagesread;
@property (nonatomic, retain) BookDetails *bookdetails;

@end
