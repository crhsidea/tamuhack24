import 'package:current_location/current_location.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
// class locationdataset({
//   final String Country,
//   final String region,
//   final int[] longlat,
//   final String currentIP,
// });

// Map<String, dynamic> toJSON(){
//   return {
//     "Country": Country,
//     "Region": region,
//     "longlat": longlat,
//     "currentIP": currentIP
//   }
// }
class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => LocationState();
}

class LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return (
        // ignore: use_function_type_syntax_for_parameters, non_constant_identifier_names
        Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              title: Text("YOUR LOCATION! GET DOXXED"),
            ),
            body: Center(
                child: FutureBuilder(
                    future: UserLocation.getValue(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Country: ${snapshot.data!.country}'),
                                Text('region: ${snapshot.data!.region}'),
                                Text('timezone: ${snapshot.data!.timezone}'),
                                Text('longitude: ${snapshot.data!.longitude}'),
                                Text('latitude: ${snapshot.data!.latitude}'),
                              ]),
                        ); 
                      }
                      return const Center(
                        child: Text('womp womp no text'),
                      );
                    }))));
  }
}
