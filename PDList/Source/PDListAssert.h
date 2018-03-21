//
//  PDListAssert.h
//  PDList
//
//  Created by liang on 2018/3/21.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#ifndef PDListAssert_h
#define PDListAssert_h

#ifndef PDAssertMainThread
#define PDAssertMainThread() NSAssert(([NSThread isMainThread] == YES), @"You must operate on the main thread.")
#endif

#endif /* PDListAssert_h */
