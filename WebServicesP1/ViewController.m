//
//  ViewController.m
//  WebServicesP1
//
//  Created by Naresh Kandala on 06/04/17.
//  Copyright © 2017 Naresh Kandala. All rights reserved.
//

#import "ViewController.h"
#import "DisplayTableViewCell.h"
#import "DetailViewController.h"
#import "DBManager.h"
#import "FMDatabase.h"

@interface ViewController ()
{
    NSArray *array_data;
}
@property (strong, nonatomic) ViewController *entry;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DBManager *db = [[DBManager alloc]init];

    BOOL checkdata=[db check_isdataAvailable];
    
    if (checkdata==YES) {
        NSLog(@"data_isavailable");
        
        DBManager *db = [[DBManager alloc]init];
        
        
        array_data = [db GetAllDetailsData];
        
        [self.tableview reloadData];

        
        
    }else{
        [self GetAPIService];

    }
    
//    self.tableview.rowHeight = UITableViewAutomaticDimension;

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)GetAPIService{
    
    NSDictionary *headers = @{ @"cache-control": @"no-cache",
                               @"postman-token": @"67d4faa1-5c8b-7170-eda5-e662dda224aa" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://jsonplaceholder.typicode.com/posts"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        
                                                        NSError *err;

                                                        array_data =   [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];

     NSLog(@"data: %@",array_data);
     BOOL check;
     DBManager *db = [[DBManager alloc]init];
                                                        
    
                                                        
     FMDatabase *database = [FMDatabase databaseWithPath:[db databasePath]];
     [database open];
                                                        
                                                        
            for (int i = 0; i<[array_data count]; i++) {
                                                            
             NSString *str_id = [[array_data objectAtIndex:i] objectForKey:@"id"];
             NSString *str_body = [[array_data objectAtIndex:i] objectForKey:@"body"];
             NSString *str_title = [[array_data objectAtIndex:i] objectForKey:@"title"];
             NSString *str_userid = [[array_data objectAtIndex:i] objectForKey:@"userId"];

            NSString *insertQuery_insert_Names  = [NSString stringWithFormat:@"INSERT INTO Details (id ,userid ,title ,body  ) VALUES ('%@','%@','%@','%@')",str_id,str_userid,str_title,str_body];
                check =   [database executeUpdate:insertQuery_insert_Names];
                
                if (check) {
                    NSLog(@"inserted");
                    
                }else
                {
                    NSLog(@"not inserted");
                    
                }
         }
                                                        
                                                        
                                                        
//     NSString *insertQuery_insert_Names = [NSString stringWithFormat:@"INSERT INTO Details (id ,userid ,title ,body  ) VALUES ('%@','%@','%@')",];
                                                        
                                                        
                                                        
//      check =   [database executeUpdate:insertQuery_insert_Names];
//                                                        
//       if (check) {
//        NSLog(@"inserted");
//                                                            
//        }else
//        {
//         NSLog(@"not inserted");
//                                                            
//         }
//                                                        
       [database close];

                                                        
                                                        
      dispatch_async(dispatch_get_main_queue(), ^{
                                                            
            [self.tableview reloadData];
                                                            
       });
                                                        
        }}];
    
    [dataTask resume];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
        return array_data.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyIdentifier = @"DisplayTableViewCell";
    
    DisplayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[DisplayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    
    cell.title_value_lbl.text = [[array_data objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.body_value_lbl.text = [[array_data objectAtIndex:indexPath.row] objectForKey:@"body"];

        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    ViewController *sender = [ViewController new];
    sender.entry = [array_data objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"data" sender:sender];

    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    
        NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
        DetailViewController *destViewController = segue.destinationViewController;
        destViewController.detaildata = [array_data objectAtIndex:indexPath.row];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
