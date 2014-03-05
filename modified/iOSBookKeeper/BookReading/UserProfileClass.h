//
//  UserProfileClass.h
//  BookReading
//
//  Created by Thabib on 06/02/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "CoreDataFactory.h"

@interface UserProfileClass : CoreDataFactory

@property (nonatomic,strong)NSMutableArray *UserNamesArray;

-(NSMutableArray *)GetUserNames;

@end
