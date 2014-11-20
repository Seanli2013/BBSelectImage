//
//  BBSelectImagesViewController.m
//  BBSelectImages
//
//  Created by Xiang LI on 11/12/14.
//  Copyright (c) 2014 Xiang LI. All rights reserved.
//

#import "BBSelectImagesViewController.h"
#import "PECropViewController.h"

@interface BBSelectImagesViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, PECropViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *portraitView;
@property (weak, nonatomic) IBOutlet UIView *landscapeView;

// constraints
@property (strong, nonatomic) NSLayoutConstraint *topPortraitViewConstraint;
@property (strong, nonatomic) NSLayoutConstraint *leadingPortraitViewConstraint;
@property (strong, nonatomic) NSLayoutConstraint *bottomLandscapeViewConstraint;
@property (strong, nonatomic) NSLayoutConstraint *trailingLandscapeViewConstraint;

@property (strong, nonatomic) NSLayoutConstraint *height1Constraint;
@property (strong, nonatomic) NSLayoutConstraint *width1Constraint;
@property (strong, nonatomic) NSLayoutConstraint *height2Constraint;
@property (strong, nonatomic) NSLayoutConstraint *width2Constraint;
@property (strong, nonatomic) NSLayoutConstraint *centerXPortraitView;
@property (strong, nonatomic) NSLayoutConstraint *centerYPortraitView;
@property (strong, nonatomic) NSLayoutConstraint *centerXLandscapeView;
@property (strong, nonatomic) NSLayoutConstraint *centerYLandscapeView;

// images
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (weak, nonatomic) IBOutlet UIImageView *landscapeImageView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property (assign) BOOL imagePortrait; // YES:表示正在操作portrait，NO表示正在操作landscape
@end

typedef NS_ENUM(NSInteger, BBConstraintMode) {
    BBConstraintModeLandscape = 1,
    BBConstraintModePortrait,
};

@implementation BBSelectImagesViewController
@synthesize portraitImage = _portraitImage;
@synthesize landscapeImage = _landscapeImage;

- (UIImage *)portraitImage
{
    if (!_portraitImage) {
        _portraitImage = self.portraitImageView.image;
    }
    return _portraitImage;
}

- (UIImage *)landscapeImage
{
    if (!_landscapeImage)
    {
        _landscapeImage = self.landscapeImageView.image;
    }
    return _landscapeImage;
}

- (void)setPortraitImage:(UIImage *)portraitImage
{
    _portraitImage = portraitImage;
    self.portraitImageView.image = portraitImage;
}

- (void)setLandscapeImage:(UIImage *)landscapeImage
{
    _landscapeImage = landscapeImage;
    self.landscapeImageView.image = landscapeImage;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if(orientation == UIInterfaceOrientationPortrait)
    {
        [self setConstraintsForViews:BBConstraintModePortrait];
    }
    else
    {
        [self setConstraintsForViews:BBConstraintModeLandscape];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Disable edit button if there is no selected image.
    [self updateEditButtonEnabled];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willRotateToInterfaceOrientation: (UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    
    if(orientation == UIInterfaceOrientationPortrait)
    {
        [self setConstraintsForViews:BBConstraintModePortrait];
    }
    else
    {
        [self setConstraintsForViews:BBConstraintModeLandscape];

    }
    [self.view needsUpdateConstraints];
}


- (void)setConstraintsForViews:(NSInteger)viewTag
{
    UIView *pVp = self.portraitView;
    UIView *lVp = self.landscapeView;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(pVp, lVp);

    [self.portraitView removeConstraint:self.height1Constraint];
    [self.portraitView removeConstraint:self.width1Constraint];
    [self.landscapeView removeConstraint:self.height2Constraint];
    [self.landscapeView removeConstraint:self.width2Constraint];
    [self.view removeConstraint:self.leadingPortraitViewConstraint];
    [self.view removeConstraint:self.trailingLandscapeViewConstraint];
    [self.view removeConstraint:self.topPortraitViewConstraint];
    [self.view removeConstraint:self.bottomLandscapeViewConstraint];
    [self.view removeConstraint:self.centerYPortraitView];
    [self.view removeConstraint:self.centerYLandscapeView];
    [self.view removeConstraint:self.centerXLandscapeView];
    [self.view removeConstraint:self.centerXPortraitView];
    
    self.height1Constraint = [[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pVp(280)]" options:0 metrics:nil views:viewsDictionary] lastObject];
    [self.portraitView addConstraint:self.height1Constraint];
    self.width1Constraint = [[NSLayoutConstraint constraintsWithVisualFormat:@"H:[pVp(200)]" options:0 metrics:nil views:viewsDictionary] lastObject];
    [self.portraitView addConstraint:self.width1Constraint];
    self.height2Constraint = [[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lVp(280)]" options:0 metrics:nil views:viewsDictionary] lastObject];
    [self.landscapeView addConstraint:self.height2Constraint];
    self.width2Constraint = [[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lVp(200)]" options:0 metrics:nil views:viewsDictionary] lastObject];
    [self.landscapeView addConstraint:self.width2Constraint];

    if (viewTag == BBConstraintModeLandscape) {
        
        self.leadingPortraitViewConstraint = [[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[pVp]" options:0 metrics:nil views:viewsDictionary] lastObject];
        [self.view addConstraint:self.leadingPortraitViewConstraint];
        self.trailingLandscapeViewConstraint = [[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lVp]-20-|" options:0 metrics:nil views:viewsDictionary] lastObject];
        [self.view addConstraint:self.trailingLandscapeViewConstraint];
        self.centerYPortraitView = [NSLayoutConstraint constraintWithItem:self.portraitView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        [self.view addConstraint:self.centerYPortraitView];
        self.centerYLandscapeView = [NSLayoutConstraint constraintWithItem:self.landscapeView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        [self.view addConstraint:self.centerYLandscapeView];

    }
    else if (viewTag == BBConstraintModePortrait)
    {
        self.topPortraitViewConstraint = [[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[pVp]" options:0 metrics:nil views:viewsDictionary] lastObject];
        [self.view addConstraint:self.topPortraitViewConstraint];
        self.bottomLandscapeViewConstraint = [[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lVp]-20-|" options:0 metrics:nil views:viewsDictionary] lastObject];
        [self.view addConstraint:self.bottomLandscapeViewConstraint];
        self.centerXPortraitView = [NSLayoutConstraint constraintWithItem:self.portraitView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        [self.view addConstraint:self.centerXPortraitView];
        self.centerXLandscapeView = [NSLayoutConstraint constraintWithItem:self.landscapeView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        [self.view addConstraint:self.centerXLandscapeView];

    }
    else{};
}


#pragma functions

- (void)showCamera
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:controller animated:YES completion:NULL];
}

- (void)openPhotoAlbum
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:controller animated:YES completion:NULL];
}

- (void)updateEditButtonEnabled
{
}


#pragma mark - Action methods
- (IBAction)openEditor:(UIButton *)sender {
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    
    if (sender)
    {
        if (sender.tag == 1)
        {
            self.imagePortrait = YES;
            controller.image = self.portraitImageView.image;
            
        }
        else
        {
            self.imagePortrait = NO;
            controller.image = self.landscapeImageView.image;
            
        }
    }
    else
    {
        if (self.imagePortrait) {
            controller.image = self.portraitImageView.image;
        }
        else
        {
            controller.image = self.landscapeImageView.image;
        }
    }
    
    UIImage *image = controller.image;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 2,
                                          (height - length) / 2,
                                          length,
                                          length);
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self presentViewController:navigationController animated:YES completion:NULL];

}



- (IBAction)cameraButtonAction:(UIButton *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"Photo Album", nil), nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [actionSheet addButtonWithTitle:NSLocalizedString(@"Camera", nil)];
    }
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
    
    [actionSheet showFromToolbar:self.navigationController.toolbar];
    
    if (sender.tag == 1)
    {
        self.imagePortrait = YES;
    }
    else
    {
        self.imagePortrait = NO;
    }
}


#pragma mark - PECropViewControllerDelegate methods

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    if (self.imagePortrait) {
        self.portraitImageView.image = croppedImage;
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedImagePortrait:)]) {
            [self.delegate didSelectedImagePortrait:croppedImage];
        }
    }
    else
    {
        self.landscapeImageView.image = croppedImage;
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedImageLandscape:)]) {
            [self.delegate didSelectedImageLandscape:croppedImage];
        }

    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self updateEditButtonEnabled];
    }
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self updateEditButtonEnabled];
    }
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UIActionSheetDelegate methods

/*
 Open camera or photo album.
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:NSLocalizedString(@"Photo Album", nil)]) {
        [self openPhotoAlbum];
    } else if ([buttonTitle isEqualToString:NSLocalizedString(@"Camera", nil)]) {
        [self showCamera];
    }
}

#pragma mark - UIImagePickerControllerDelegate methods

/*
 Open PECropViewController automattically when image selected.
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (self.imagePortrait) {
        self.portraitImageView.image = image;
    }
    else
    {
        self.landscapeImageView.image = image;
    }

    [picker dismissViewControllerAnimated:YES completion:^{
        [self openEditor:nil];
    }];
}


@end
