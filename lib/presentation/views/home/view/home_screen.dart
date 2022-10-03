import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:friendzone/presentation/views/home/view/widgets/app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

const urlImg =
    'https://images.unsplash.com/photo-1664574654700-75f1c1fad74e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Stack(
          children: [
            // FlutterMap(
            //   mapController: MapController(),
            //   options: MapOptions(
            //     center: LatLng(51.5, -0.09),
            //     zoom: 1,
            //   ),
            //   children: [
            //     TileLayer(
            //       urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            //       userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            //     ),
            //     MarkerLayer(
            //       markers: [
            //         Marker(
            //           point: LatLng(16.049680, 108.213287),
            //           width: 120,
            //           height: 100,
            //           builder: (context) => Row(
            //             children: const [
            //               CircleAvatar(
            //                 radius: 20,
            //                 backgroundImage: NetworkImage(urlImg),
            //               ),
            //               Text(
            //                 'UserName',
            //                 style: TextStyle(fontWeight: FontWeight.w600),
            //               )
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),

            //     PolylineLayer(
            //       polylineCulling: false,
            //       polylines: [
            //         Polyline(
            //           points: [
            //             LatLng(16.049680 + 1, 108.213287 + 1),
            //             LatLng(16.049680, 108.213287 + 2),
            //             LatLng(16.049680 + 2, 108.213287 + 3),
            //           ],
            //           color: Colors.blue,
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
