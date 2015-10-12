//
//  ViewController.m
//  TestTask
//
//  Created by Игорь Веденеев on 09.10.15.
//  Copyright © 2015 Игорь Веденеев. All rights reserved.
//

#import "ViewController.h"
#import "IVCell.h"

#define NUMBER_OF_ROWS 30

@interface ViewController () <UISearchBarDelegate> {
    NSMutableArray* arrayOfHeights;
}

@property IBOutlet NSLayoutConstraint* topConstraint;
@property CGFloat lastYCoord;
@property BOOL bounce;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (weak, nonatomic) IBOutlet UIView *cheatView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property NSMutableArray* arrayOfPictures;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayOfHeights = [NSMutableArray array];
    self.arrayOfPictures = [NSMutableArray array];
    self.bounce = NO;
    
    self.cheatView.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer* tapRecon = [[UITapGestureRecognizer alloc] initWithTarget: self
                                                                               action: @selector(navigationBarTap:)];
    tapRecon.numberOfTapsRequired = 1;
    [self.navigationController.navigationBar addGestureRecognizer:tapRecon];
    
    UIImage* img1 = [UIImage imageNamed: @"audi.png"];
    UIImage* img2 = [UIImage imageNamed: @"merc.jpeg"];
    
    [self.arrayOfPictures addObject: img1];
    [self.arrayOfPictures addObject: img2];
    
    for (int i = 0; i < NUMBER_OF_ROWS; i++) {
        [arrayOfHeights addObject: [self.arrayOfPictures objectAtIndex: arc4random() % [self.arrayOfPictures count]]];
    }
       
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
    
    if (delta < 0) {
        if (!self.bounce) {
            self.topConstraint.constant = (scrollView.contentOffset.y > 44) ? MAX(-52.5, self.topConstraint.constant + delta):
                                                                              MAX(-52.5, 44 - scrollView.contentOffset.y);
        }
    } else {
        if (self.bounce) {
            self.topConstraint.constant = - 52.5;
        } else {
            self.topConstraint.constant = ((scrollView.contentOffset.y > 44)) ? MIN(0, self.topConstraint.constant + delta):
                                                                                44 - scrollView.contentOffset.y;
        }
    }
    
    [self.view layoutIfNeeded];
    
    [self.searchBar resignFirstResponder];
    
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (self.bounce) {
        self.bounce = !self.bounce;
    }
    
}

#pragma mark - Actions

- (IBAction) navigationBarTap:(id) sender {
    [self.tableView setContentOffset: CGPointMake(0, -self.tableView.contentInset.top) animated: YES];
    
}

@end
