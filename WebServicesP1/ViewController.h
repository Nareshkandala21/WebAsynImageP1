//
//  ViewController.h
//  WebServicesP1
//
//  Created by Naresh Kandala on 06/04/17.
//  Copyright © 2017 Naresh Kandala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

