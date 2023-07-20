// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'app_colors.dart';


// /// Show loading icon for any asynchronous task
// Future<void> showLoading(BuildContext context,{bool useRootNavigator = false}) {
//   return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       useRootNavigator: useRootNavigator,
//       builder: (BuildContext context) {
//         return WillPopScope(
//             onWillPop: () async => false,
//             child:  const SimpleDialog(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0.0,
//                 children: <Widget>[
//                   SpinKitThreeBounce(
//                     color: AppColors.white,
//                     size: 45,
                   
//                   )
//                 ]));
//       });
// }

