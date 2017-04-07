//
//  DetailViewController.m
//  WebServicesP1
//
//  Created by Naresh Kandala on 07/04/17.
//  Copyright © 2017 Naresh Kandala. All rights reserved.
//

#import "DetailViewController.h"
#import "DDisplayCollectionViewCell.h"
@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize detaildata;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"vchwgv %@", detaildata);
    // Do any additional setup after loading the view.
}
#pragma mark -  <UICollectionView methods>

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DDisplayCollectionViewCell";
     DDisplayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSString *imageurl = @"https://duckduckgo.com/i/adad4e5c.png";
    
    NSURL* url = [NSURL URLWithString:imageurl];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * response,
                                               NSData * data,
                                               NSError * error) {
                               if (!error){
                                   cell.D_image.image =  [UIImage imageWithData: data];
                                   
                               }
                               
                           }];
    

    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
