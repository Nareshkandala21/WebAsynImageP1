//
//  DBManager.m
//  WebServicesP1
//
//  Created by Naresh Kandala on 07/04/17.
//  Copyright © 2017 Naresh Kandala. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"

@implementation DBManager

-(BOOL)check_isdataAvailable{
    
    FMDatabase *database = [FMDatabase databaseWithPath:[self databasePath]];
    [database open];
    
    NSString *sqlSelectQuery_getclient = [NSString stringWithFormat:@"SELECT * FROM Details"];
    
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSString * str_OPEX_ACTUALS_INR;
    
    while([resultsWithName_cl1 next]) {
        
        
        str_OPEX_ACTUALS_INR = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"id" ]];
    }
    
    if (str_OPEX_ACTUALS_INR.length==0) {
        [database close];
        
        return NO;
        
    }
    
    else{
        [database close];
        
        return YES;
        
    }
    
}
-(NSString *)databasePath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDir stringByAppendingPathComponent:@"Sample.sqlite"];
    
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    if (!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Sample.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        if (!success) {
            
            NSLog(@"Failed to create writable DB. Error '%@'.", [error localizedDescription]);
            
        } else {
            
            NSLog(@"DB copied.");
            
        }
        
    }else {
        
        NSLog(@"DB exists, no need to copy.");
        
    }
    NSLog(@"dbpath%@",dbPath);
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    
    [database open];
    
    
    NSString *insertQuery_details = @"CREATE TABLE Details ( id TEXT, userid TEXT, title TEXT, body TEXT )";
    
    [database executeUpdate:insertQuery_details];
    
    [database close];
    
    return dbPath;
    
}


//Featching data

-(NSMutableArray*)GetAllDetailsData
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:self.databasePath];
    
    [database open];
    
    NSString *sqlSelectQuery_getclient =[NSString stringWithFormat:@"SELECT * FROM Details"];
    FMResultSet *resultsWithName_cl1 = [database executeQuery:sqlSelectQuery_getclient];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    
    while([resultsWithName_cl1 next]) {
        NSMutableDictionary *arr_act_inr=[[NSMutableDictionary alloc]init];
        
        
        NSString *str_id = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"id" ]];
        
        NSString *str_userid = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"userid" ]];
        NSString *str_title = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"title" ]];
        
        NSString *str_body = [NSString stringWithFormat:@"%@",[resultsWithName_cl1 stringForColumn:@"body" ]];
        
        
        [arr_act_inr setObject:str_id forKey:@"id"];
        [arr_act_inr setObject:str_userid forKey:@"userid"];
        [arr_act_inr setObject:str_title forKey:@"title"];
        [arr_act_inr setObject:str_body forKey:@"body"];

        
//        [arr_act_inr addObject:str_id];
//        [arr_act_inr addObject:str_userid];
//        [arr_act_inr addObject:str_title];
//        [arr_act_inr addObject:str_body];
        
        [arr addObject:arr_act_inr];
        
    }
    
    [database close];
    
    return arr;
    
}

@end
