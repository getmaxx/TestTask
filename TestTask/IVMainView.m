//
//  IVMainView.m
//  TestTask
//
//  Created by Игорь Веденеев on 09.10.15.
//  Copyright © 2015 Игорь Веденеев. All rights reserved.
//

#import "IVMainView.h"

@interface IVMainView () <UIScrollViewDelegate> {
    BOOL visible;
}

@property (strong, nonatomic) UIView* segment;

@end

@implementation IVMainView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*visible = YES;
    UIButton *titleLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleLabelButton setTitle:@"Нажми" forState:UIControlStateNormal];
    titleLabelButton.frame = CGRectMake(0, 0, 70, 44);
    [titleLabelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //titleLabelButton.font = [UIFont boldSystemFontOfSize:16];
    [titleLabelButton addTarget:self action:@selector(didTapTitleView:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleLabelButton;
    [self.tableView setContentInset:(UIEdgeInsets){0, 0, 53, 0}];
    
    /*UIView* test = [[UIView alloc] initWithFrame: CGRectMake(0, 60, self.view.bounds.size.width, 53.5)];
    test.backgroundColor = [UIColor redColor];
    [self.view insertSubview: test atIndex:0];
    [self.tableView addSubview: test];*/
    
    /*UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 53.2)];
    //UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(XXX, YYY, XXX, YYY)];
    //[headerView addSubview:imageView];
    //UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(XXX, YYY, XXX, YYY)];
    //[headerView addSubview:labelView];
    headerView.backgroundColor = [UIColor greenColor];
    self.tableView.tableHeaderView = headerView;
    [self.tableView setContentOffset: CGPointMake(0, 52.5) animated: YES];*/
    
    if ([self.tableView.tableHeaderView isEqual: self.searchBar]) {
        NSLog(@"asdasdasdasdsadasdasdasd");
    }
    
    UITapGestureRecognizer* tapRecon = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(navigationBarTap:)];
    tapRecon.numberOfTapsRequired = 1;
    [self.navigationController.navigationBar addGestureRecognizer:tapRecon];
}

- (IBAction)navigationBarTap:(id) sender
{
    NSLog(@"Title tap");
    [self.tableView setContentOffset: CGPointMake(0, -self.tableView.contentInset.top) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    }

#pragma mark - UITableViewDataSource

/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if(section == 0) {
        
        NSIndexPath *path = [NSIndexPath indexPathForRow: 0 inSection: 0];
        return [tableView cellForRowAtIndexPath: path].contentView;
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    return cell.frame.size.height;
}
/*- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"A";
}*/


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    NSString* reuseIdentifier = [NSString stringWithFormat: @"contentCell"];
    
    if (indexPath.row == 0) {
        reuseIdentifier = @"segmentedViewCell";
    }
    else {
        reuseIdentifier = @"contentCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier forIndexPath: indexPath];
    
    if (indexPath.row != 0) {
        cell.textLabel.text = [NSString stringWithFormat: @"%d", indexPath.row];
    }
    else{
        }
       
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].y > 0) {
        NSLog(@"DOWN");
    } else {
       NSLog(@"UP");
        
    }
    
  
    //[self.tableView cellForRowAtIndexPath: firstVisibleIndexPath].frame;
   //
    
}

@end
