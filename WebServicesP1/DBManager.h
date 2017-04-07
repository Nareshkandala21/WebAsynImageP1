//
//  DBManager.h
//  WebServicesP1
//
//  Created by Naresh Kandala on 07/04/17.
//  Copyright © 2017 Naresh Kandala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject
-(NSString *)databasePath;
-(BOOL)check_isdataAvailable;
-(NSMutableArray*)GetAllDetailsData;
@end
