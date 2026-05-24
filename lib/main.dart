import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zob/login/splash_screen.dart';

void main() {
  runApp(
      // DevicePreview(enabled: true, builder: (context) =>
      MyApp());
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// com.backupp.zob ==> pakage name 
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'ZOBMATE',
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!),

      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      // home: BottomNavigationScreen(
      //   selectIndex: 0,
      // ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // Barcode? result;
//   // QRViewController? controller;
//   // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   /* @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     }
//     controller!.resumeCamera();
//   }
//  */

//   @override
//   void initState() {
//     super.initState();
//     scanQR();
//   }

//   String _scanBarcode = 'Unknown';
// Future<void> scanQR() async {
//   String barcodeScanRes;
//   // Platform messages may fail, so we use a try/catch PlatformException.
//   try {
//     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666', 'Cancel', true, ScanMode.QR);
//     print(barcodeScanRes);
//   } on PlatformException {
//     barcodeScanRes = 'Failed to get platform version.';
//   }

//   if (!mounted) return;
//   debugPrint("Get scanner : ${barcodeScanRes}");
//   setState(() {
//     _scanBarcode = barcodeScanRes;
//   });
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             /*  Expanded(
//               flex: 4,
//               child: _buildQrView(context),
//             ), */
//           ],
//         ),
//       ),
//     );
//   }

// /*   Widget _buildQrView(BuildContext context) {
//     // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 150.0
//         : 300.0;
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       debugPrint("Scanned data : ${scanData.code}");
//       setState(() {
//         result = scanData;
//       });
//     });
//   }

//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//     if (!p) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('no Permission')),
//       );
//     }
//   }
//  */
//   // @override
//   // void dispose() {
//   //   controller?.dispose();
//   //   super.dispose();
//   // }
// }
