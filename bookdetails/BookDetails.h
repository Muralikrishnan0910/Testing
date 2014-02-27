//
//  BookDetails.h
//  bookdetails
//
//  Created by BSA Univ15 on 20/02/14.
//  Copyright (c) 2014 BSA Univ15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BookDetails : NSManagedObject

@property (nonatomic, retain) NSString * authorname;
@property (nonatomic, retain) NSString * bookname;
@property (nonatomic, retain) NSString * totalpages;
@property (nonatomic, retain) NSString * pagesread;

@end
