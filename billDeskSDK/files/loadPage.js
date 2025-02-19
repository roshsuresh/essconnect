function loadpage(sdkConfigMap) {
   var responseHandler = function (response) {
      window.location.href = "billdesksdk://web-flow?status=" + response.status + "&response=" + response.txnResponse
   }
   const sdkConfig = JSON.parse(sdkConfigMap);
   sdkConfig['responseHandler']  = responseHandler;
   sdkConfig['flowConfig']['returnUrl'] = "" ;
   sdkConfig['flowConfig']['childWindow'] = false;

   window.loadBillDeskSdk(sdkConfig);
}

