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


function updateUrlByKey(shouldUseOldUat = false){

  let urls = [];

  if(shouldUseOldUat){
    urls = ['https://uat.billdesk.com/jssdk/v1/dist/billdesksdk/billdesksdk.esm.js', 'https://uat.billdesk.com/jssdk/v1/dist/billdesksdk.js']
  }else{
    urls = ['https://uat1.billdesk.com/merchant-uat/sdk/dist/billdesksdk/billdesksdk.esm.js','https://uat1.billdesk.com/merchant-uat/sdk/dist/billdesksdk.js']
  }

  attachScript(urls)

}

function attachScript(urls){

          const moduleScriptTag = generateScriptTag(urls[0], {type: "module", async: true});
          const NoModuleScriptTag = generateScriptTag(urls[1], {async: true});
          document.head.appendChild(moduleScriptTag)
          document.head.appendChild(NoModuleScriptTag)
}

function generateScriptTag(src, attr){

  const scriptTag = document.createElement("script");

  scriptTag.src=src;

  if(scriptTag.type != null)
      scriptTag.type = attr.type;

  scriptTag.async = attr.async !== undefined ? attr.async : false;

  return scriptTag;
}

var isInfoAttached = false

function attachListenerToLogo(){
  try{

    var intrID = setInterval(()=>{  
      let logo = document.querySelector("body > bd-modal").shadowRoot.querySelector("#myModal > div > bd-sdk > div > bd-footer > div > img")

      if(logo != null){  

        logo.addEventListener("click", ()=>{ 
               tapCount++ 
               if(tapCount%7 == 0){
                   window.flutter_inappwebview.callHandler("buildDetailEvent", JSON.stringify({"alert":true}));
               }
             }) 
          }

          isInfoAttached = true;

          if(isInfoAttached){
            clearInterval(intrID);
          }

    }, 500);
    
  }catch(e){
    console.error(e);
  }
}



// function appendBuildVersion(buildVersion) {
//    const footer = document.querySelector("body > bd-modal").shadowRoot.querySelector("#myModal > div > bd-sdk > div > bd-footer > div");
//    if (!footer) return;
   
//    const currentStyle = window.getComputedStyle(footer);
//    footer.style.height = "60px";
   
//    footer.addEventListener("transitionend", function() {
//      footer.style.height = currentStyle.height;
//    });
   
//    const version = document.createElement("p");
//    version.innerText = `f${buildVersion}`;
   
//    footer.appendChild(version);
//    footer.addEventListener("click", ()=>{ 
//      tapCount++ 
//      if(tapCount%7 == 0){
//          window.flutter_inappwebview.callHandler("buildDetailEvent", JSON.stringify({"alert":true}));
//      }
//    })  
   
//    isVersionAppended = true;
// }

// function checkAndAppendVersion(version) {
//    if (!isVersionAppended) {
//      intervalId = setInterval(() => {
//        try {
//          appendBuildVersion(version);
//        } catch (error) {
//          console.log(error);
//        }
//          if(isVersionAppended) clearInterval(intervalId)
//      }, 2000);
//    } else {
//      clearInterval(intervalId);
//    }
//  }

