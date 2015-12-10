//
//  VideoPlayerController.m
//  TrainerVate
//
//  Created by Matrid on 25/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "VideoPlayerController.h"

@interface VideoPlayerController ()
{
    MPMoviePlayerController *moviePlayer;
    UIWebView *videoView;
}
@end

@implementation VideoPlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *videoURLString = @"videoFilepath";
//    NSString *videoFilepath = @"http://download5.mp4mobilemovies.net/Hollywood/Ant-Man%20-%20SCam/Ant-Man%20-%20SCam%201%20(ClubMp4.Com).mp4";
//        // Do any additional setup after loading the view from its nib.
//    
//   
//   NSString *  myString = videoFilepath;
//    NSLog(@"myString..%@",myString);
//    NSURL *fileURL=[NSURL URLWithString:myString];
//    NSLog(@"fileURL..%@",fileURL);
//  MPMoviePlayerViewController *  moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:fileURL];
//    [self presentMoviePlayerViewControllerAnimated:moviePlayerController];
//    [moviePlayerController.moviePlayer prepareToPlay];
//    moviePlayerController.moviePlayer.shouldAutoplay=YES;
//    [moviePlayerController.moviePlayer play];
    
     NSURL *url=[[NSURL alloc] initWithString:@"http://www.ebookfrenzy.com/ios_book/movie/movie.mov"];
    
   // NSURL *url = [NSURL URLWithString:@"video url address here"];
    AVURLAsset *avasset = [[AVURLAsset alloc] initWithURL:url options:nil];
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithAsset:avasset];
  AVPlayer  *player = [[AVPlayer alloc] initWithPlayerItem:item];
    
   AVPlayerLayer * playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    CGSize size = self.view.bounds.size;
    float x = size.width/2.0-202.0;
    float y = size.height/2.0 - 100;
    
    playerLayer.frame = CGRectMake(x, y, 404, 200);
    playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    
    [self.view.layer addSublayer:playerLayer];
    NSString *tracksKey = @"tracks";
    
    [avasset loadValuesAsynchronouslyForKeys:[NSArray arrayWithObject:tracksKey] completionHandler:
     ^{
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            NSError *error = nil;
                            AVKeyValueStatus status = [avasset statusOfValueForKey:tracksKey error:&error];
                            if (status == AVKeyValueStatusLoaded) {
                                [player play];
                            }
                            else {
                                NSLog(@"The asset's tracks were not loaded:\n%@", [error localizedDescription]);
                            }
                        });
     }];
}
//    NSURL *audioURL = // Your Url;
//    NSString *encodedString = [@"Your Url" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *myURL = [[NSURL alloc] initWithString:encodedString]
//    AVPlayer *player = [AVPlayer playerWithURL:myURL];
//    [player prepareToPlay];
//    player play];
//    
    //[self playbackButton: nil];
    


- (void)playerItemDidReachEnd:(NSNotification *)notification {
    
    //  code here to play next sound file
    
}
- (IBAction)playbackButton:(id)sender {
    
    // pick a video from the documents directory
     NSURL *video=[[NSURL alloc] initWithString:@"http://www.ebookfrenzy.com/ios_book/movie/movie.mov"];
   //  NSURL *video = [self grabFileURL:@"video.mov"];
    
    // create a movie player view controller
    MPMoviePlayerViewController * controller = [[MPMoviePlayerViewController alloc]initWithContentURL:video];
    [controller.moviePlayer prepareToPlay];
    [controller.moviePlayer play];
    
    // and present it
    [self presentMoviePlayerViewControllerAnimated:controller];
    
}
-(void)pplay
{
    NSURL *url=[[NSURL alloc] initWithString:@"http://www.ebookfrenzy.com/ios_book/movie/movie.mov"];
  //  NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] initWithURL:url];
    MPMoviePlayerViewController *playerController = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentMoviePlayerViewControllerAnimated:playerController];
    
    playerController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    
    [playerController.moviePlayer play];
    
    
    // When movie finished loading you can have a notification and do extra code
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MovieDidLoad:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    
    
    
    
    playerController = nil;
}


-(void)MovieDidLoad:(NSNotification *)notification {
    
    NSLog(@"logged and notification is %@", notification);
    
    // extra code if needed
    
    

}
-(IBAction)playBtnPressed
{
    NSURL *url=[[NSURL alloc] initWithString:@"http://www.ebookfrenzy.com/ios_book/movie/movie.mov"];
    moviePlayer=[[MPMoviePlayerController alloc] initWithContentURL:url];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDonePressed:) name:MPMoviePlayerDidExitFullscreenNotification object:moviePlayer];
    
    moviePlayer.controlStyle=MPMovieControlStyleDefault;
    //moviePlayer.shouldAutoplay=NO;
    [moviePlayer play];
    [self.view addSubview:moviePlayer.view];
    [moviePlayer setFullscreen:YES animated:YES];
}
- (void) moviePlayBackDonePressed:(NSNotification*)notification
{
    [moviePlayer stop];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerDidExitFullscreenNotification object:moviePlayer];
    
    
    if ([moviePlayer respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [moviePlayer.view removeFromSuperview];
    }
    
    moviePlayer=nil;
}

-(IBAction) playVideo:(id)sender
{
    
  //  NSURL *url=[[NSURL alloc] initWithString:@"http://www.ebookfrenzy.com/ios_book/movie/movie.mov"];
    
    NSURL *url = [NSURL URLWithString:
                  @"http://www.ebookfrenzy.com/ios_book/movie/movie.mov"];
    
    MPMoviePlayerController *    _moviePlayer =  [[MPMoviePlayerController alloc]
                     initWithContentURL:url];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer];
    
    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
    _moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:_moviePlayer.view];
    [_moviePlayer setFullscreen:YES animated:YES];}
-(void)Play
{
    NSURL *videoPath = [NSURL URLWithString:@"http://videos.testtube.com/revision3/web/discoverydinosaurs/0035/discoverydinosaurs--0035--male-dinosaurs-battle--large.h264.mp4"];
    
    MPMoviePlayerViewController *mpViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:videoPath];
    // Remove the movie player view controller from the "playback did finish" notification observers
    [[NSNotificationCenter defaultCenter] removeObserver:mpViewController
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:mpViewController.moviePlayer];
    
    // Register this class as an observer instead
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:mpViewController.moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doneButtonClick:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:nil];
    
    // Set the modal transition style of your choice
    mpViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    // Present the movie player view controller
    [self presentViewController:mpViewController animated:YES completion:nil];
    
    
    // Start playback
    [mpViewController.moviePlayer prepareToPlay];
    [mpViewController.moviePlayer play];
    
}
-(void)doneButtonClick:(NSNotification *)aNotification
{
[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)movieFinishedCallback:(NSNotification*)aNotification
{
    // Obtain the reason why the movie playback finished
    NSNumber *finishReason = [[aNotification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    // Dismiss the view controller ONLY when the reason is not "playback ended"
    if ([finishReason intValue] != MPMovieFinishReasonPlaybackEnded)
    {
        MPMoviePlayerController *moviePlayers = [aNotification object];
        
        // Remove this class from the observers
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerPlaybackDidFinishNotification
                                                      object:moviePlayers];
        
        // Dismiss the view controller
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    
    if ([player
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        //self.navigationController.navigationBarHidden = YES;
        [player.view removeFromSuperview];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
