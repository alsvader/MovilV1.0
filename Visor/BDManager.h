//
//  BDManager.h
//  Visor
//
//  Created by chable on 11/15/16.
//  Copyright (c) 2016 ST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDManager : NSObject

    - (instancetype) initWithDatabaseFileName:(NSString * )dbFilename;
    @property (nonatomic, strong) NSMutableArray *arrResults;
    @property (nonatomic) int affectedRows;
    @property (nonatomic) long long lastInsertedRowID;

    - (NSArray *)loadDataFromDB: (NSString *) query;
    - (void) executeQuery: (NSString * )query;


@end
