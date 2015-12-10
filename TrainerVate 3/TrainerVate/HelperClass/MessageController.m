//
//  MessageController.m
//  TrainerVate
//
//  Created by Matrid on 01/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 300.0f
#define CELL_CONTENT_MARGIN 10.0f

#import "MessageController.h"
#import "customMsgCell.h"

@interface MessageController ()

@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    customMsgCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    if (cell == nil) {
        NSArray *mArray=[[NSBundle mainBundle]loadNibNamed:@"customMsgCell" owner:self options:nil];
        cell=[mArray objectAtIndex:0];
    }
    NSString *text=@"asdjfasd falsd flkasdflkasdflas dfjalsd fklas dv;fljasdl;fja;dsfasdffjalksdjf;lasdlfjasdlk;fjlaksdjfl; asdl;kfaklsdjf lkasd fjlaksd;j f;lkadsj flkasd;jflas;d fasdflasdlfk;asd;f asld;f laksd;fl;asdf;";
    
   
    [cell.textLablel setLineBreakMode:NSLineBreakByWordWrapping];
    [cell.textLablel setMinimumFontSize:FONT_SIZE];
    [cell.textLablel setNumberOfLines:0];
    //cell.textLablel.backgroundColor=[UIColor clearColor];
    [cell.textLablel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [cell.textLablel setTag:1];
    
    // NSString *text1 =[NSString stringWithFormat:@"%@",text];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    if (!cell.textLablel)
        cell.textLablel = (UILabel*)[cell viewWithTag:1];
    
    
    cell.textLablel.text=[NSString stringWithFormat:@"%@",text];
    [cell.textLablel setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH          - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];
   // [cell.contentView addSubview:label];
    
    
   // cell.textLablel.text=;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // for the sake of illustration, say your model for this table is just an array of strings you wish to present.
    // it's probably more complex, but the idea is to get the string you want to present for the
    // cell at indexPath
    NSString *stringForThisCell = @"";
    
    // you can get fancier here, and dynamically get the font from the UITextView prototype
    // but for simplicity, just copy the font size you configured the text view with in your nib
    CGSize size = [stringForThisCell sizeWithFont:[UIFont systemFontOfSize:14.0]];
    
    // this is a little funky, because for it to be just right, you should format your prototype
    // cell height to be a good-looking height when your text view has a zero height.
    // the basic idea here is that the cell will get taller as the text does.
    return tableView.rowHeight + size.height;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   // NSString *cellText = @"asdjfasd falsd flkasdflkasdflas dfjalsd fklas dv;fljasdl;fja;dsfasdf";
// //   UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
//    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
//   CGSize adjustedSize = CGSizeMake(ceilf(constraintSize.width), ceilf(constraintSize.height));
//    
//    return adjustedSize.height;
//    
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
