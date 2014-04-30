//
//  config.h
//  Hot Spot
//
//  Created by Mathieu GHENNASSIA on 29/04/2014.
//  Copyright (c) 2014 Patrick Reynolds. All rights reserved.
//

#ifndef Hot_Spot_config_h
#define Hot_Spot_config_h

# ifdef ENV_DEV
#  define ENVIRONMENT @"development"
#  define API_URL @"http://localhost:3000/"
# endif

# ifdef ENV_PROD
#  define ENVIRONMENT @"production"
#  define API_URL @"http://api-hotspot.herokuapp.com/"
# endif

#endif
