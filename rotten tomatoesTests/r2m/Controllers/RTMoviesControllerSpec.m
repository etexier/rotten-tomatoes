//
//  RTMoviesControllerSpec.m
//
//  File generated by Magnet rest2mobile 1.1 - Feb 7, 2015 11:25:59 AM
//  @See Also: http://developer.magnet.com
//
#import <Kiwi/Kiwi.h>
#import "RTMoviesController.h"
#import "RTBoxOfficeResult.h"
#import "RTSearchResult.h"
#import "RTTopRentalsResult.h"

#define DEFAULT_TEST_TIMEOUT 5.0

SPEC_BEGIN(RTMoviesControllerSpec)

describe(@"RTMoviesController", ^{

    RTMoviesController *sut = [[RTMoviesController alloc] init];


    context(@"when calling getBoxOffice", ^{

        it(@"should invoke", ^{
            // FIXME: Set the expected output
            RTBoxOfficeResult *output;
            // FIXME: Set the input parameter(s)
            NSString *limit;
            NSString *country;
            NSString *apikey;

            __block RTBoxOfficeResult *_response;
            [sut getBoxOffice:limit
                      country:country
                       apikey:apikey
                      success:^(RTBoxOfficeResult *response){
                         _response = response;
                      }
                      failure:^(NSError *error){
                      }];

            // Assert
            [[expectFutureValue(_response) shouldEventuallyBeforeTimingOutAfter(DEFAULT_TEST_TIMEOUT)] equal:output];
        });
    });


    context(@"when calling getTopRentals", ^{

        it(@"should invoke", ^{
            // FIXME: Set the expected output
            RTTopRentalsResult *output;
            // FIXME: Set the input parameter(s)
            NSString *limit;
            NSString *country;
            NSString *apikey;

            __block RTTopRentalsResult *_response;
            [sut getTopRentals:limit
                       country:country
                        apikey:apikey
                       success:^(RTTopRentalsResult *response){
                          _response = response;
                       }
                       failure:^(NSError *error){
                       }];

            // Assert
            [[expectFutureValue(_response) shouldEventuallyBeforeTimingOutAfter(DEFAULT_TEST_TIMEOUT)] equal:output];
        });
    });


    context(@"when calling search", ^{

        it(@"should invoke", ^{
            // FIXME: Set the expected output
            RTSearchResult *output;
            // FIXME: Set the input parameter(s)
            NSString *q;
            NSString *page_limit;
            NSString *page;
            NSString *apikey;

            __block RTSearchResult *_response;
            [sut search:q
             page_limit:page_limit
                   page:page
                 apikey:apikey
                 success:^(RTSearchResult *response){
                     _response = response;
                 }
                 failure:^(NSError *error){
                 }];

            // Assert
            [[expectFutureValue(_response) shouldEventuallyBeforeTimingOutAfter(DEFAULT_TEST_TIMEOUT)] equal:output];
        });
    });


});

SPEC_END
