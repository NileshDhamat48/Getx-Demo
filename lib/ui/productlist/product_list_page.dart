import 'package:damoapp/response/res_user.dart';
import 'package:damoapp/ui/productdetail/product_detail_screen.dart';
import 'package:damoapp/ui/productlist/product_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  ProductListScreenState createState() => ProductListScreenState();
}

class ProductListScreenState extends State<ProductListScreen> {
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar( centerTitle: true
          ,
          title: const Text("Product List Screen"),
        ),
        body: SafeArea(child: buildProductPage()),
      );

  buildProductPage() => PagedListView<int, Products>(
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate<Products>(
            itemBuilder: (context, item, index) {
          return ListTile(
            title: Text(item.title ?? ""),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(item.id)));
            },
          );
        }),
      );

  @override
  void dispose() {
    super.dispose();
  }
}
