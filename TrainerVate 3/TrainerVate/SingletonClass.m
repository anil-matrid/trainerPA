//
//  SingletonClass.m
//  Tenderlicious
//
//  Created by Sahil Garg on 08/10/14.
//  Copyright (c) 2014 cogniter. All rights reserved.
//

#import "SingletonClass.h"

@implementation SingletonClass


+(SingletonClass *)singleton {
    static dispatch_once_t pred;
    static SingletonClass *shared = nil;
    
    dispatch_once(&pred, ^{
        shared=[[SingletonClass alloc] init];
        shared.clientDat =[[NSMutableDictionary alloc]init];
        shared.productArray=[[NSMutableArray alloc]init];
        shared.setProfileInfo=[[NSMutableArray alloc]init];
        shared.MyClientDetail=[NSMutableArray array];
        shared.basicStats=[[NSMutableDictionary alloc]init];
        shared.bmiStats=[[NSMutableDictionary alloc]init];
        shared.smStats=[[NSMutableDictionary alloc]init];
        shared.sfStats=[[NSMutableDictionary alloc]init];
        shared.bfStats=[[NSMutableDictionary alloc]init];
        shared.clientInfo=[[NSMutableDictionary alloc]init];
        shared.calenderDate=[[NSMutableDictionary alloc]init];
        shared.errorMessages=[[NSMutableDictionary alloc]init];
        shared.reminderCreateClient=[[NSMutableDictionary alloc]init];
        shared.reminderCreateClient1=[[NSMutableDictionary alloc]init];
        shared.updationValue=[[NSMutableDictionary alloc]init];
        shared.aboutClientData=[[NSMutableDictionary alloc]init];
        shared.cartSelectedProduct=[[NSMutableArray alloc]init];
        shared.bundelSelectedProduct=[[NSMutableDictionary alloc]init];
       // shared.dietPlanBundelFood=[[NSMutableArray alloc]init];
        shared.dietPlanBundelSuppliment=[[NSMutableArray alloc]init];
        shared.dietPlanBundelArray=[[NSMutableArray alloc]init];
        shared.selectedWorkout=[[NSMutableArray alloc]init];
        shared.dietArray=[[NSMutableArray alloc]init];
        shared.Workout=[[NSString alloc]init];
        shared.remove=[[NSString alloc]init];
        shared.workoutRemove=[[NSString alloc]init];
        shared.breakfastdietPlanBundelFood=[[NSMutableArray alloc]init];
        shared.breakfastdietPlanBundelSuppliment=[[NSMutableArray alloc]init];
        shared.lunchdietPlanBundelArray=[[NSMutableArray alloc]init];
        shared.lunchdietPlanBundelSuppliment=[[NSMutableArray alloc]init];
        shared.dinnerdietPlanBundelArray=[[NSMutableArray alloc]init];
        shared.dinnerdietPlanBundelSuppliment=[[NSMutableArray alloc]init];
        shared.snaksdietPlanBundelArray=[[NSMutableArray alloc]init];
        shared.snaksdietPlanBundelSuppliment=[[NSMutableArray alloc]init];
        shared.existWorkouts=[[NSMutableArray alloc]init];
        shared.ShopSelectedProduct=[[NSMutableArray alloc]init];
        shared.DietPlanSelected=[[NSMutableDictionary alloc]init];
        shared.DietPlanSelectedProduct=[NSMutableArray array];
        shared.shopSearchSelected = [[NSMutableArray alloc]init];
        shared.shopSearchSelected = [NSMutableArray array];
    });
    
    return shared;
}
@end
