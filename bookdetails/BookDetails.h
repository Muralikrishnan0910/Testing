//
//  BookDetails.h
//  bookdetails
//
//  Created by BSA Univ15 on 13/02/14.
//  Copyright (c) 2014 BSA Univ15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UpdatePage;

@interface BookDetails : NSManagedObject

@property (nonatomic, retain) NSString * bookname;
@property (nonatomic, retain) NSString * authorname;
@property (nonatomic, retain) NSString * totalpages;
@property (nonatomic, retain) NSSet *updatepage;
@end

@interface BookDetails (CoreDataGeneratedAccessors)

- (void)addUpdatepageObject:(UpdatePage *)value;
- (void)removeUpdatepageObject:(UpdatePage *)value;
- (void)addUpdatepage:(NSSet *)values;
- (void)removeUpdatepage:(NSSet *)values;

@end
