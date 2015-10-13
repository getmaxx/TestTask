//
//  ViewController.m
//  TestTask
//
//  Created by Игорь Веденеев on 09.10.15.
//  Copyright © 2015 Игорь Веденеев. All rights reserved.
//

#import "ViewController.h"
#import "IVCell.h"

static const int kNumberOfRowsInTableView = 30;

@interface ViewController () <UISearchBarDelegate> {
    NSMutableArray* dataForTableView;
}

@property IBOutlet NSLayoutConstraint* topConstraint;

@property CGFloat lastYCoord;
@property CGFloat currentTopConstraintConstant;
@property CGFloat searchBarHeight;
@property CGFloat segmentViewHeight;
@property BOOL    bounce;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView      *segmentView;
@property (weak, nonatomic) IBOutlet UIView      *cheatView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBarHeight = self.searchBar.frame.size.height;
    self.segmentViewHeight = self.segmentView.frame.size.height;
    self.bounce = NO;
    
    UITapGestureRecognizer* statusBarTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self
                                                                                                    action: @selector(statusBarTap:)];
    
    statusBarTapGestureRecognizer.numberOfTapsRequired = 1;
    [self.navigationController.navigationBar addGestureRecognizer: statusBarTapGestureRecognizer];
    
    UIImage* img1 = [UIImage imageNamed: @"audi.png"];
    UIImage* img2 = [UIImage imageNamed: @"merc.jpeg"];
    NSArray* arrayOfPictures = @[img1, img2];
    
    dataForTableView = [NSMutableArray array];
    for (int i = 0; i < kNumberOfRowsInTableView; i++) {
        [dataForTableView addObject: [arrayOfPictures objectAtIndex: arc4random() % [arrayOfPictures count]]];
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
    return [dataForTableView count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   NSString* reuseIdentifier = [NSString stringWithFormat: @"cell"];
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier forIndexPath: indexPath];
    
   cell.imageView.image = (UIImage*)[dataForTableView objectAtIndex: indexPath.row];
   cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
   return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [IVCell getHeightForRowForIndexPath: (UIImage*)[dataForTableView objectAtIndex: indexPath.row]];
}

#pragma mark - UIScrollViewDelegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.bounce = self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height);
    CGFloat delta = self.lastYCoord - scrollView.contentOffset.y;
    self.lastYCoord = scrollView.contentOffset.y;
    
    if (delta < 0) {
        if (!self.bounce) {
            self.currentTopConstraintConstant = (scrollView.contentOffset.y > self.searchBarHeight) ? MAX(-self.segmentViewHeight, self.currentTopConstraintConstant + delta):
                                                                                                      MAX(-self.segmentViewHeight, self.searchBarHeight - scrollView.contentOffset.y);
            
        }
    } else {
        if (self.bounce) {
            self.currentTopConstraintConstant = -self.segmentViewHeight;
            
        } else {
            self.currentTopConstraintConstant = (scrollView.contentOffset.y > self.searchBarHeight) ? MIN(0, self.currentTopConstraintConstant + delta):
                                                                                                      self.searchBarHeight - scrollView.contentOffset.y;
        }
    }
    
    if (self.currentTopConstraintConstant != self.topConstraint.constant) {
        self.topConstraint.constant = self.currentTopConstraintConstant;
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

- (IBAction) statusBarTap:(id) sender {
    [self.tableView setContentOffset: CGPointMake(0, -self.tableView.contentInset.top) animated: YES];
}

@end
