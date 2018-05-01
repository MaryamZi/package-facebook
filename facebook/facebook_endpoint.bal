// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

documentation {FacebookConfiguration is used to set up the Facebook configuration. In order to use
this connector, you need to provide the valid access token.
    F{{clientConfig}} - The HTTP client congiguration
}
public type FacebookConfiguration {
    http:ClientEndpointConfig clientConfig = {};
};

documentation {Facebook Endpoint object.
    E{{}}
    F{{facebookConfig}} - Facebook client endpoint configuration object
    F{{facebookConnector}} - Facebook connector object
}
public type Client object {
    public {
        FacebookConfiguration facebookConfig = {};
        FacebookConnector facebookConnector = new;
    }

    documentation {Facebook endpoint initialization function
        P{{facebookConfig}} - Facebook client endpoint configuration object
    }
    public function init(FacebookConfiguration facebookConfig);

    documentation {Get Facebook connector client
        R{{}} - Facebook connector client
    }
    public function getCallerActions() returns FacebookConnector;
};

public function Client::init(FacebookConfiguration facebookConfig) {
    facebookConfig.clientConfig.url = BASE_URL;
    match facebookConfig.clientConfig.auth {
        () => {}
        http:AuthConfig authConfig => {
            authConfig.scheme = SCHEME;
        }
    }
    self.facebookConnector.httpClient.init(facebookConfig.clientConfig);
}

public function Client::getCallerActions() returns FacebookConnector {
    return self.facebookConnector;
}