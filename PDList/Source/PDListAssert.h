//
//  PDListAssert.h
//  PDList
//
//  Created by liang on 2018/3/21.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#ifndef PDListAssert_h
#define PDListAssert_h

#ifndef PDAssert
#define PDAssert(condition, ...) NSCAssert((condition) , ##__VA_ARGS__)
#endif

#ifndef PDParameterAssert
#define PDParameterAssert(condition) PDAssert((condition), @"Invalid parameter not satisfying: %@", @#condition)
#endif

#ifndef PDAssertMainThread
#define PDAssertMainThread() PDAssert(([NSThread isMainThread] == YES), @"You must operate on the main thread.")
#endif

#endif /* PDListAssert_h */
