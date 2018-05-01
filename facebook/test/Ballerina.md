## Compatibility

| Ballerina Language Version  | Facebook API Version |
| ----------------------------| ---------------------|
|  0.970.0                    |   v2.12              |

### Prerequisites

Login into [Graph API Explorer](https://developers.facebook.com/tools/explorer/) and get the access token.

## Running Samples
You can use the `tests.bal` file to test all the connector actions by following the below steps:
1. Navigate to package-facebook and initialize the ballerina project
    ```
    ballerina init
    ```

2. Obtain the access token as mentioned above and add that value in the package-facebook/ballerina.conf file.
    ```
    ACCESS_TOKEN="your_access_token"
    ```
4. Run the following command to execute the tests.
    ```
    ballerina test facebook --config ballerina.conf
    ```

