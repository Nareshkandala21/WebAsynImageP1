//
//  DetailViewController.h
//  WebServicesP1
//
//  Created by Naresh Kandala on 07/04/17.
//  Copyright © 2017 Naresh Kandala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray *detaildata;
@end
