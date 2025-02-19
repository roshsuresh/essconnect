# **Comprehensive Guide to Integrating Payment Gateway SDK in Flutter**
<a href="https://www.billdesk.com/">
<img src="https://payments.billdesk.com/bdcollect/bdCollect/bank/customer/resources/img/BillDeskLogo.png" width="200" height="100" alt="Billdesk Logo">
</a>

<p style="text-align: justify;">
BillDesk is a leading payment gateway provider that offers secure and seamless payment solutions for businesses and customers. By integrating multiple payment methods and ensuring encryption of sensitive data, BillDesk helps businesses offer a wide range of payment options while maintaining the highest level of security. With its reliable services, BillDesk empowers businesses to streamline their payment processes and enhance the customer experience.
</p>


## 1. BACKGROUND
<p style="text-align: justify;">This note outlines the technical integration process between the Merchant and the BillDesk platform to facilitate one-time payments using various methods such as Cards, UPI, and Net banking. It explains the specific mode and approach through which the Merchant can seamlessly connect their systems with BillDesk, enabling customers to make secure and convenient payments using different payment options.
</p>

## 2.    PREREQUISITES TO GET STARTED

-   Obtain your Merchant ID (MID) from [BillDesk](http://billdesk.com "billdesk site")

-   Merchant's server public IP address to be whitelisted at BillDesk

-   Create Order API has to be called using JWS-HMAC for [Payment SDK.]


## 3.    HEADERS and AUTHENTICATION

<p style="text-align: justify;">
JWS represents signed content using JSON data structures and base64url encoding. The representation consists of three parts: the JWS Header, the JWS Payload, and the JWS Signature. The three parts are base64url-encoded for transmission, and typically represented as the concatenation of the encoded strings in that order, with the three strings being separated by period (\'.\') characters.

The JWS Header describes the signature method and parameters employed.The JWS Payload is the message content to be secured. The JWS Signature. Ensure the integrity of both the JWS Header and the JWS Payload.

JWS-HMAC is a framework intended to provide a method to securely transfer claims (such as authorization information) between parties.

- Peer-to-Peer communication will happen over HTTPS (TLS1.2).

-   JWS-HMAC – In this implementation a secret key/HMAC key will be shared by BillDesk with the merchant, using which the merchant will sign the request and then when request comes to BillDesk, it'll verify the request using the same secret key. The same key is used at both ends.

-   Content-Type: application/jose (content-type remains jose only) Body uses compact serialization format as per JWS (i.e., RFC 7515) and the payload is JSON.

-   The JWS header fields to be included are as follows:
-   The algorithm ("alg" field) with value `HS256`.
-   Custom header `clientid` is the clientid value provided by BillDesk
</p>

**Request Headers**

With each request, following headers are required:

| **Attribute** | **Type** | **Description**                                                                                                                                                                                                |
|---------------|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Content-Type  | String   | Request Content-Type to take the values application/jose                                                                                                                                                       |
| Accept        | String   | Accept Response Content-Type to take the values application/jose                                                                                                                                               |
| BD-Traceid    | String   | Traceid is used for idempotency and the request with the same Traceid within the day will be rejected. Traceid can be alphanumeric without any spaces or special characters and should be a maximum size of 35 |
| BD-Timestamp  | String   | epoch timestamp of the server                                                                                                                                                                                  |

The process to generate JWS-HMAC request is as below:

**Step 1 :** Receive a `clientid `and a `secretkey` from BillDesk. The clientid identifies the client sending the requests, and the secretkey is used to generate the hash for the request.


Example :
```json
{
  "alg": "HS256",
  "clientid": "mercclientid"
}
```
**Step 2 :** Create the Payload (JSON) -
```json
{
  "mercid": "BDMERCID",
  "orderid": "order45608988",
  "amount": "300.00",
  "order_date": "2021-03-05T10:59:15+05:30",
  "currency": "356",
  "ru": "https://merchant.com",
  "additional_info": {
    "additional_info1": "Details1",
    "additional_info2": "Details2"
  },
  "itemcode": "DIRECT",
  "device": {
    "init_channel": "internet",
    "ip": "124.124.1.1",
    "mac": "11-AC-58-21-1B-AA",
    "imei": "990000112233445",
    "accept_header": "text/html",
    "fingerprintid": "61b12c18b5d0cf901be34a23ca64bb19"
  }
}
```
**Step 3:** The JWS Header & Payload will be signed using the secret key
(this will be shared by BillDesk).The sample JWS-HMAC request as below:

```text
eyJhbGciOiJIUzI1NiIsImNsaWVudGlkIjoidGVzdGp3c2htYWMiLCJraWQiOiJITUFDIn0.eyJvYmplY3RpZCI6Im9yZGVyIiwib3JkZXJpZCI6Im9yZGVyNDU2MDg5ODg5OTk5IiwiYmRvcmRlcmlkIjoiT0FGSjE5WFRHUEVMMUciLCJtZXJjaWQiOiJCRE1PTklUT1IiLCJvcmRlcl9kYXRlIjoiMjAyMS0wMy0xNVQxMDo1OToxNSswNTozMCIsImFtb3VudCI6IjMwMC4wMCIsImN1cnJlbmN5IjoiMzU2IiwicnUiOiJodHRwczovL21lcmNoYW50LmNvbSIsImFkZGl0aW9uYWxfaW5mbyI6eyJhZGRpdGlvbmFsX2luZm8xIjoiRGV0YWlsczEiLCJhZGRpdGlvbmFsX2luZm8yIjoiRGV0YWlsczIifSwiaXRlbWNvZGUiOiJESVJFQ1QiLCJjcmVhdGVkb24iOiIyMDIxLTAzLTE1VDEzOjQ1OjAwKzA1OjMwIiwibmV4dF9zdGVwIjoicmVkaXJlY3QiLCJsaW5rcyI6W3siaHJlZiI6Imh0dHBzOi8vd3d3LmJpbGxkZXNrLmNvbS9wZ2kvdmUxXzIvb3JkZXJzL29yZGVyNDU2MDg5ODg5OTk5IiwicmVsIjoic2VsZiIsIm1ldGhvZCI6IkdFVCJ9LHsiaHJlZiI6Imh0dHBzOi8vcGd1YXR3ZWIuYmlsbGRlc2suaW8vcGd0eG5zaW11bGF0b3IvdjFfMi90cmFuc2FjdGlvbnMvb3JkZXJmb3JtIiwicmVsIjoicmVkaXJlY3QiLCJtZXRob2QiOiJQT1NUIiwicGFyYW1ldGVycyI6eyJtZXJjaWQiOiJCRE1PTklUT1IiLCJiZG9yZGVyaWQiOiJPQUZKMTlYVEdQRUwxRyJ9LCJ2YWxpZF9kYXRlIjoiMjAyMS0wMy0xNVQxNDoxNTowMCswNTozMCIsImhlYWRlcnMiOnsiYXV0aG9yaXphdGlvbiI6Ik9Ub2tlbiA4NjNDQ0E5NkQzNEVGMjQ0NDREMkEwQkU0RjkxRUU3QzZGNEJCMDE4MTdEMzlBQkQwQzI0NzE0OTNGMzZBRTBCMDRBMTA1RjUyRTMxMzVFRjE4RkE0MzcwNTE5OUI0NjVEQkVBRUVENEE2RTVFOUU0MTAyMTMyQjJFMjgwNkVCMUY3QTVFRTY1QTc1ODk5OERGNzgwNDJBMDdEN0IyQjNCREQ3MENFNUE4QTBFOEMxRDM2MEM0MjBEQTU1OEY3OEY5MDU4Mzk3Q0NBMkU3M0E2OUNBOUQwRTRBOUE3MDI1NkVDREM3QzIxQzI4NTVDMjM1QjMwNDNBMEQwNjA0Q0U4OUYwRDAzMEMzMzAyNENERDA2MUI2MzdDRTUxMzQ3NkM2NkZGQTREQkE2QkE1MDM0MEEzNTZDQTYuNDE0NTUzNUY1NTQxNTQzMSJ9fV0sInN0YXR1cyI6IkFDVElWRSJ9.uhA497NRk-AmQplSw64KKD04wcRMTusavZ9XuNiXmJg

```

**Response Headers**

With each response, you will receive the following response headers:

| **Attribute** | **Type** | **Description**                                              |
|---------------|----------|--------------------------------------------------------------|
| Content-Type  | String   | Request Content-Type to take the values **application/jose** |
| BD-Traceid    | String   | Same Traceid as passed in request                            |
| BD-Timestamp  | String   | Same timestamp value as passed in request                    |


## 4. SDK INTEGRATION

### 4.1.  Integrating SDK library in Flutter App

1.  Navigate to the directory where you want to create your merchant Flutter app.

2.  Run the following command to create a new Flutter app:
    ```shell
    $ flutter create my_flutter_app
    ```

3.  Copy the sdk project and paste it into the root level of your directory.

4.  Import sdk in dependency and configure the path `pubspec.yaml` your project.

5.  Add the following configuration in the pubspec file to include all the libraries
    ```yaml
    dependencies:
    flutter:
    sdk: flutter
    billDeskSDK:
      path: path/to/billDeskSDK
    ```

6.  Navigate to the merchant app and sdk directory. Run the following  command to fetch and install the defined dependencies:
    ```shell
    $ flutter pub get
    ```

7.  Currently supporting `> 2.17.0` and `< 3.0.0` flutter sdk version.


### 4.2. Building sdkconfig


#### 4.2.1. Create Order API
>  This API is applicable while using the Payment SDK

-   Merchants must initiate the Create Order API using JWS-HMAC .

-   The arguments **bdOrderId** & **authToken** is returned as part of the API response from BillDesk

| **Attributes**   | **Mandatory/ Optional/ Conditional** | **Description**                                                                                                                                                                                       |
|------------------|--------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| orderid          | Mandatory                            | Unique orderid generated by the merchant to identify the transaction                                                                                                                                  |
| mercid           | Mandatory                            | Unique identifier as defined by BillDesk for each merchant                                                                                                                                            |
| order\_date      | Mandatory                            | Merchant order generation date and time in YYYY MM-DDThh:mm:ssTZD format                                                                                                                              |
| amount           | Mandatory                            | Order amount in two decimals                                                                                                                                                                          |
| currency         | Mandatory                            | ISO currency of the transaction amount                                                                                                                                                                |
| ru               | Mandatory                            | Merchant return url\*\*                                                                                                                                                                               |
| additional\_info | Optional                             | Array of 10 additional\_info values that can be attached to the transaction                                                                                                                           |
| itemcode         | Mandatory                            | Itemcode value as provided by BillDesk, with a default value **DIRECT**                                                                                                                               |
| device (object)  | Mandatory                            | Device object                                                                                                                                                                                         |
| invoice (object) | Optional                             | Applicable for UPI QR (to include GST details) • invoice\_number • invoice\_display\_number • customer\_name • invoice\_date • gst\_details o cgst o sgst o igst o gst o cess o gstincentive o gstpct |

**Response**

Returns the order object.

**Sandbox URL:**
``` text
https://pguat.billdesk.io/payments/ve1_2/orders/create
```
**Http method:** `POST`

**(a) SAMPLE (FOR PAYMENT ONLY SDK)**

**Headers:**

```text
  content-type: application/jose
  accept: application/jose
  bd-timestamp: 20200817132207
  bd-traceid: 20200817132207ABD1K
```


**Request: (encrypted & signed using JWS-HMAC)**

```json5
{
  "mercid": "BDMERCID",
  "orderid": "TSSGF43214F",
  "amount": "300.00",
  "order_date": "2020-08-17T15:19:00+0530",
  "currency": "356",
  "ru": "https://www.example.com/merchant/api/pgresponse",
  "additional_info": {
    "additional_info1": "Details1",
    "additional_info2": "Details2"
  },
  "itemcode": "DIRECT",
  "invoice": {
    "invoice_number": "MEINVU111111221133",
    "invoice_display_number": "11221133",
    "customer_name": "Tejas",
    "invoice_date": "2021-09-03T13:21:5+05:30",
    "gst_details": {
      "cgst": "8.00",
      "sgst": "8.00",
      "igst": "0.00",
      "gst": "16.00",
      "cess": "0.00",
      "gstincentive": "5.00",
      "gstpct": "16.00",
      "gstin": "12344567"
    }
  },
  "device": {
    "init_channel": "internet",
    "ip": "202.149.208.92",
    "mac": "11-AC-58-21-1B-AA",
    "imei": "990000112233445",
    "user_agent": "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:51.0) Gecko/20100101 Firefox/51.0",
    "accept_header": "text/html",
    "fingerprintid": "61b12c18b5d0cf901be34a23ca64bb19"
  }
}
```



**Response: (Encrypted & Signed using JWS-HMAC will need decryption &
sign verification)**

```json5
{
  "objectid": "order",
  "mercid": "BDMERCID",
  "amount": "300.00",
  "ru": "https://www.demourlmerchant.com/response",
  "orderid": "6yn4uhuz9e9bcw9qo6r6v4",
  "order_date": "2020-08-17T15:19:00+0530",
  "bdorderid": "OAFC19XTFD8TSP",
  "additional_info": {
    "additional_info1": "Details1",
    "additional_info2": "Details2"
  },
  "next_step": "redirect",
  "itemcode": "DIRECT",
  "createdon": "2021-03-11T19:23:24+05:30",
  "currency": "356",
  "links": [
    {
      "method": "GET",
      "rel": "self",
      "href": "https://www.sampleurl.com/request"
    },
    {
      "headers": {
        "authorization": "OToken DEDC1071B77800A146B6E8D2530E0429E76520C151B40CC3325D8B6D9242CBA3A6BFA643E7E5596FBEBAE0F46A1FB1BCD099EBC1F59DCD82F390B6BC45FCE036F37F7F589BD687A691E1378F1FF432331C62E7E641E857C8F8A405A4BFE2F01B1EB8F3C69817D45F5DDE9DEE346ACABA1B7208DECA9E43CCE7AB3761553E23D9CB36A870C1819C15C7C4B1CFE2802DFD05F651AA537AB81787.4145535F55415431"
      },
      "valid_date": "2020-08-17T15:49:00+0530",
      "method": "POST",
      "rel": "redirect",
      "href": "https://www.billdesk.com/pgi/MerchantPayment/",
      "parameters": {
        "mercid": "BDMERCID",
        "bdorderid": "OAFC19XTFD8TSP"
      }
    }
  ],
  "status": "ACTIVE",
  "invoice": {
    "invoice_number": "MEINVU111111221133",
    "invoice_display_number": "11221133",
    "customer_name": "Tejas",
    "invoice_date": "2021-09-03T13:21:5+05:30",
    "gst_details": {
      "cgst": "8.00",
      "sgst": "8.00",
      "igst": "0.00",
      "gst": "16.00",
      "cess": "0.00",
      "gstincentive": "5.00",
      "gstpct": "16.00",
      "gstin": "12344567"
    }
  },
  "device": {
    "accept_header": "text/html",
    "ip": "202.149.208.92",
    "fingerprintid": "61b12c18b5d0cf901be34a23ca64bb19",
    "imei": "990000112233445",
    "init_channel": "internet",
    "mac": "11-AC-58-21-1B-AA",
    "user_agent": "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:51.0) Gecko/20100101 Firefox/51.0"
  }
}
```

#### 4.2.2 Build SDKConfig

The above create order API will return SDKConfig which we will need to pass when invoking the SDK to launch the checkout experience for the customer.

#### 1. SDKConfig
The SDKConfig acts as a wrapper that encapsulates the necessary configurations and settings required for initializing and configuring the BillDesk SDK.
It serves as the main configuration object for the SDK integration.

| **Argument**              | **Description**                                                                                              | **DataType**           |
|---------------------------|--------------------------------------------------------------------------------------------------------------|------------------------|
| _**sdkConfigJson**_       | A json object that contains configurations required for SDK initialization                                   | Json object            |
| _**responseHandler**_     | JavaScript callback function to receive the transaction's metadata after completion of the transaction journey | ResponseHandler object |
| _**isUATEnv** (optional)_ | Set _isUATEnv value true to run in the UAT environment . In default mode will run in the PROD environment._  | Boolean                |
| _**isDevModeAllowed** (optional)_ | Set isDevModeAllowed value to true to run the sdk in developer mode. By default the value is false.    | Boolean                |
| _**isJailBreakAllowed** (optional)_ | Set isJailBreakAllowed value to true to run the sdk in developer mode. By default the value is false.   | Boolean                |

#### 2. SdkConfigJson
SdkConfigJson is a JSON object that represents the specific configuration details related to a particular payment flow.

| **Argument**       | **Description**                                                                                                                                                           | **DataType** |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| _**flowConfig**_   | A json containing the configuration details of the payment depending on flow type.                                                                                        | Json object  |
| _**flowType**_     | For payment pass " **payments**". For Pay + mandate pass " **txn\_plus\_emandate**". For E Mandate pass " **emandate"** . For Modify mandate pass " **modify\_mandate".** | String       |
| _**merchantLogo**_ | base64 image of merchant's logo                                                                                                                                           | String       |


#### 3. FlowConfig

| **Argument**                    | **Description**                                                                                                                                                                               | **DataType**                              |
|---------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|
| _**authToken**_                 | Token generated using _Create Order API_                                                                                                                                                      | String                                    |
| _**childWindow** (optional)_    | (pass true -\> if you want to close the web view on redirect aftertransaction, pass false-\> if you don't want to close the web view on redirect aftertransaction)                            | boolean                                   |
| _**merchantId**_                | Merchant id received from BillDesk once you're on boarded                                                                                                                                     | String                                    |
| _**bdOrderId**_                 | Order id generated using _Create Order API_                                                                                                                                                   | String                                    |
| _**showConvenienceFeeDetails**_ | show/hide "know more" link which has convenience fee details info                                                                                                                             | Boolean                                   |
| _**retryCount** (optional)_     | Number of retry attempts you want the customer to be able to get. Say the earlier attempt to complete the transaction failed, the customer will get a retry option in the SDK user interface. | Integer                                   |
| _**merchantLogo**_              | base64 image of merchant's logo                                                                                                                                                               | String                                    |
| _**Prefs** (optional)_          | Represents the preferences for payment and payment plus mandate. Mandatory for **Pay + mandate** flowtype.                                                                                    | Json object (Refer 4.2.2.4 Prefs section) |
| _**savedCards** (optional)_     | Customer saved cards received in createOrder api response.                                                                                                                                    | String                                    |
| _**mandateTokenId**_            | Received **mandateTokenId** from create order API, Set this value for **emandate, modify\_mandate** and **Pay + mandate** flowtype.                                                           | String                                    |

#### 4. Prefs

| **Argument**                         | **Description**                                                                                                                                                              | **DataType**                                                                                                         |
|--------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| _**Payment\_categories** (optional)_ | Sub object of **Prefs**. Payment categories list which needs to be overridden in a specific order.                                                                           | List of String. Allowed string values in list: **['quickpay', 'card', 'emi', 'nb', 'upi', 'wallets', 'qr', 'gpay']** |
| _**mandate**_                        | Sub object of **Prefs**. Represents the preference for **Pay + mandate** flowtype.                                                                                           | Json object                                                                                                          |
| _**mandate\_required**_              | Sub object of **mandate** object. This field is a boolean value that determines whether or not a mandate is required. Value set to ' **Y**' for ' **'txn\_plus\_emandate'.** | String -\> **Y/N**                                                                                                   |

### 4.3. Launching the SDK


#### 4.3.1 Passing the arguments & launching the SDK (Payments)

-   After creating the order, use the response to make flowConfigTo launch the SDK we need to invoke the below function passing the required arguments as the config object shown below.

```shell
$ flutter pub add get
```

```dart
   import 'package:billDeskSDK/sdk.dart';
   import 'package:http/http.dart' as http;
   import 'package:get/get.dart';

   class SdkLauncher{

	Response createOrder() async {
	//refer above for order url, body and headers.
      return await http.post(url, body, headers);
	}

   //need to use getx library
    function launchWebView(){
	
	//get order details
	var orderResponse = createOrder();
	
	   //refer above for flow config and flow type. use order details to map with flowConfig.
	   
	    final flowConfigMap = {
        "merchantId": OrderResponse['mercid'].toString(),
        "bdOrderId": OrderResponse['bdorderid'].toString(),
        "showConvenienceFeeDetails": showConFeeDetails,
        "authToken": OrderResponse['links'][1]['headers']['authorization'].toString(),
        "childWindow": true/false,
        "retryCount": 2, 
        "savedCards": OrderResponse['cards'], //optional
        "prefs": paymentFlowPrefs,
		....
      };

   final sdkConfigMap = {
      "flowConfig": flowConfigMap,
      "flowType": flowType,
      "merchantLogo": "company logo (base64)",
    };

// for testing purpose, use isUatEnv = true
  final sdkConfig =  SdkConfig(
        sdkConfigJson: SdkConfiguration.fromJson(sdkConfigMap),
        responseHandler: responseHandler,
        isUATEnv: false);

        Get.to(() => SDKWebView(), arguments: sdkConfig);
    }

  }
```
For more info about get library, [click here](https://pub.dev/packages/get "click here")

-   We are required to pass the below arguments to launch the billdesk SDK in Payments.

-   `SDKWebView` - It's a type of UI Class. The merchant needs to pass the reference of SDKWebView to start the SDK's SDKWebView.

-  `sdkConfig` - It's a type of **SdkConfig** object. Please refer to section `4.2.2.1`.


### 4.4. Prepare the responseHandler

4.4.1  ResponseHandler is executed when a response is received from the sdk.It is a protocol which have function to receive the transaction's metadata after completion of the transaction journey

```dart
 class SdkResponseHandler implements ResponseHandler {

 String flowType;

 SdkResponseHandler({

    required this.flowType,

 });

 @override

 void onError(SdkError sdkError) {

    print('Callback Received via responseHandler()');

 }

 @override

 void onTransactionResponse(TxnInfo txnInfo) {

    print('Callback Received via responseHandler()');

  }

 }
 ```

### 4.5. Processing transaction response

After completing the transaction on SDK, the transaction response is provided to the merchant on their Return URL (ru).

-   **Sample Transaction Response:**
```json
{
  "isCancelledByUser": "Y",
  "orderId": "yukkq8hnxcrztea8op24bk"
}
```

-   isCancelledByUser returns true if the transaction is canceled or aborted by the user otherwise returns false.

-   Irrespective of value returned by isCancelledByUser, please check transaction status explicitly.

## 5. Event handling

Handling callback events correctly is crucial to making sure your integration's business logic works as expected.

**Acknowledge events immediately**

If your callback script performs complex logic, or makes network calls, it's possible that the script would time out before BillDesk sees its complete execution. Ideally, your callback handler code (acknowledging receipt of an event by returning a 2xx status code) is separate of any other logic you do for that event.

**Handle duplicate events**

Callback endpoints might occasionally receive the same event more than once. We advise you to guard against duplicated event receipts by making your event processing idempotent. One way of doing this is logging the events you've processed, and then not processing already-logged events.

**Order of events**

BillDesk does not guarantee delivery of events in the order in which they are generated. Your endpoint should not expect delivery of these events in any particular order and should handle it accordingly. You can also use the API to fetch any missing objects.