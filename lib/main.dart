import 'package:flutter/material.dart';
import 'package:pricecompare/services/user_order_service.dart';
import 'package:pricecompare/services/vendor_order_service.dart';
import 'package:pricecompare/viewmodels/cart_viewmodel.dart';
import 'package:pricecompare/viewmodels/details_viewmodel.dart';
import 'package:pricecompare/viewmodels/user_order_viewmodel.dart';
import 'package:pricecompare/viewmodels/product_search_viewmodel.dart';
import 'package:pricecompare/viewmodels/vendor_order_viewmodel.dart';
import 'package:pricecompare/viewmodels/vendor_products_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'router.dart';
import 'viewmodels/signup_viewmodel.dart';
import 'viewmodels/login_viewmodel.dart';
import 'viewmodels/logout_viewmodel.dart';
import 'viewmodels/vendor_register_viewmodel.dart';
import 'viewmodels/product_viewmodel.dart';
import 'package:pricecompare/services/product_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final connectivityResult = await Connectivity().checkConnectivity();
  final hasInternet = connectivityResult != ConnectivityResult.none;

  runApp(PriceCompareApp(initialRoute: hasInternet ? '/' : '/noInternet'));
}

class PriceCompareApp extends StatelessWidget {
  final String initialRoute;
  const PriceCompareApp({Key? key, required this.initialRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => LogoutViewModel()),
        ChangeNotifierProvider(create: (_) => VendorViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel(productService: ProductService(baseUrl: 'http://192.168.1.6:8000/api'))),
        ChangeNotifierProvider(create: (_) => VendorProductViewModel()),
        ChangeNotifierProvider(create: (_) => ProductSearchViewModel()), 
        ChangeNotifierProvider(create: (_) => DetailsViewModel()), 
        ChangeNotifierProvider(create: (context) => CartViewModel(),),
        ChangeNotifierProvider(create: (_) => UserOrdersViewModel(UserOrderService())),
        ChangeNotifierProvider(create: (_) => VendorOrdersViewModel(VendorOrderService()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
