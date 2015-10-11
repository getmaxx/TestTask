//
//  ViewController.m
//  TestTask
//
//  Created by Игорь Веденеев on 09.10.15.
//  Copyright © 2015 Игорь Веденеев. All rights reserved.
//

#import "ViewController.h"
#import "IVCell.h"

#define DEFAULT_OFFSET 0
#define NUMBER_OF_ROWS 30

@interface ViewController () <UISearchBarDelegate> {
    NSMutableArray* arrayOfHeights;
}

@property IBOutlet NSLayoutConstraint* topConstraint;
@property CGFloat lastYCoord;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property CGFloat lastDownYCoord;
@property CGFloat lastTopYCoord;
@property (weak, nonatomic) IBOutlet UIView *cheatView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property BOOL bounce;

@property NSMutableArray* arrayOfPictures;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayOfHeights = [NSMutableArray array];
    self.arrayOfPictures = [NSMutableArray array];
    self.bounce = NO;
    
    self.cheatView.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer* tapRecon = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(navigationBarTap:)];
    tapRecon.numberOfTapsRequired = 1;
    [self.navigationController.navigationBar addGestureRecognizer:tapRecon];
    
    //self.tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
  
    UIImage* img1 = [UIImage imageNamed: @"audi.png"];
    UIImage* img2 = [UIImage imageNamed: @"merc.jpeg"];
    
    [self.arrayOfPictures addObject: img1];
    [self.arrayOfPictures addObject: img2];
    
    for (int i = 0; i < NUMBER_OF_ROWS; i++) {
        [arrayOfHeights addObject: [self.arrayOfPictures objectAtIndex: arc4random() % [self.arrayOfPictures count]]];
        
    }
    
    }

- (IBAction) navigationBarTap:(id) sender {
    [self.tableView setContentOffset: CGPointMake(0, -self.tableView.contentInset.top) animated: YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayOfHeights count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
   NSString* reuseIdentifier = [NSString stringWithFormat: @"cell"];
    
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier forIndexPath: indexPath];
    
   cell.imageView.image = (UIImage*)[arrayOfHeights objectAtIndex: indexPath.row];
   cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
   return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [IVCell getHeightForRowForIndexPath: (UIImage*)[arrayOfHeights objectAtIndex: indexPath.row]];

}

#pragma mark - UIScrollViewDelegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.bounce = self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height);
    
    CGFloat delta = self.lastYCoord - scrollView.contentOffset.y;
    
    self.lastYCoord = scrollView.contentOffset.y;
    
    CGFloat tempCoord;
    BOOL scrollDirectionChanged = NO;
    
    if (delta < 0) {
        
        scrollDirectionChanged = YES;
        
        if (!self.bounce) {
            if ((self.lastTopYCoord <= 0)) {
                self.lastTopYCoord = 44;
            }
            // NSLog(@"UP");
                           self.topConstraint.constant =  (scrollView.contentOffset.y > 44) ? MAX(-52.5, self.topConstraint.constant + delta)/*self.lastTopYCoord - scrollView.contentOffset.y*/ : MAX( - 52.5, 44 - scrollView.contentOffset.y);
            
            self.lastDownYCoord = scrollView.contentOffset.y;
            
            
        }
            }
    else {
        
        self.lastTopYCoord = scrollView.contentOffset.y;
        
        if (self.bounce) {
            
           self.topConstraint.constant = - 52.5;
            
        }
        else {
            //NSLog(@"DOWN");
           
            self.topConstraint.constant = ((scrollView.contentOffset.y > 44)) ? MIN(0, self.topConstraint.constant + delta/*- 52.5 - (scrollView.contentOffset.y - self.lastDownYCoord)*/) : 44 - scrollView.contentOffset.y;
            
            }
    }
    
    [self.view layoutIfNeeded];
    
    [self.searchBar resignFirstResponder];
    NSLog(@"%f, %f %f", self.topConstraint.constant, scrollView.contentOffset.y, delta);
    
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (self.bounce) {
        
        self.bounce = !self.bounce;
        
    }
    
}

@end
