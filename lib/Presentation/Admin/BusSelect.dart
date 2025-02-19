import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Application/StudentProviders/LocationServiceProvider.dart';
import '../../utils/constants.dart';
import '../Student/mappage.dart';
 // Ensure the correct import

class BusSelectionScreen extends StatefulWidget {
  @override
  _BusSelectionScreenState createState() => _BusSelectionScreenState();
}

class _BusSelectionScreenState extends State<BusSelectionScreen> {
  String? selectedBus;

  String busvalue = "";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var provider = Provider.of<LocationProvider>(context, listen: false);
      await provider.gpsDevice();
      await provider.busListfn();
      // selectedBus ="";
    });
  }

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<LocationProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bus Tracking',
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: UIGuide.light_Purple,
      ),
      body:
          Consumer<LocationProvider>(builder: (context,prov,_)=>
      prov.loading?
          Center(
            child: SizedBox(height: 100,width: 100,
            child: spinkitLoader(),),
          ):
      Container(
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [Colors.indigo.shade50, Colors.lightBlueAccent],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select Bus',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: selectedBus,
                    hint: Text('Select Bus'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    items: prov.buslist.map((bus) {
                      // print(prov.buslist[7].imeiNumber);
                      return DropdownMenuItem<String>(
                        value: bus.busName,
                        child: Text("Bus No- ${bus.busName}"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      print(value);
                      busvalue="";
                     busvalue = prov.buslist
                          .firstWhere((bus) => bus.busName == value)
                          .imeiNumber!;
                      print(busvalue);

                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (busvalue != "") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapScreen(
                              imeiNumber: busvalue,
                            ),
                          ),
                        );
                      }
                      else
                        {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          duration: Duration(seconds: 1),
                          margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            'IMEI number not found',
                            textAlign: TextAlign.center,
                          ),
                        ));
                          print("Iemie Number is null");
                        }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), backgroundColor: Color.fromARGB(255, 7, 68, 126),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Submit', style: TextStyle(fontSize: 16,color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
          ),
    );
  }
}
