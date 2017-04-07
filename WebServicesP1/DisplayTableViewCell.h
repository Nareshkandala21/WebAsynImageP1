//
//  DisplayTableViewCell.h
//  WebServicesP1
//
//  Created by Naresh Kandala on 07/04/17.
//  Copyright © 2017 Naresh Kandala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *tiltle_lbl;

@property (strong, nonatomic) IBOutlet UILabel *body_lbl;

@property (strong, nonatomic) IBOutlet UILabel *title_value_lbl;

@property (strong, nonatomic) IBOutlet UILabel *body_value_lbl;

@end
