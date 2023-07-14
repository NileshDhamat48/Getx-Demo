import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:damoapp/ui/productdetail/product_detail_controller.dart';
import 'package:damoapp/ui/productlist/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  final int? productId;

  const ProductDetailScreen(this.productId, {Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailController controller = Get.put(ProductDetailController());

  @override
  void initState() {
    super.initState();
    controller.getProductList(widget.productId);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
      appBar: AppBar( centerTitle: true,
        title: const Text("Product Details Screen"),
      ),
      body: SafeArea(
          child: Obx(() => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.productDetail.value.images?.isNotEmpty == true
                  ? buildImageSlider(controller.productDetail.value.images)
                  : const Center(
                      child: Text("No Image found"),
                    ))));

  buildImageSlider(List<String>? images) {
    return CarouselSlider(
        items: buildImage(images),
        options: CarouselOptions(
          height: 400,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        ));
  }

  List<Widget> buildImage(List<String>? images) {
    return List.generate(
        images?.length ?? 0,
        (index) => CachedNetworkImage(
              imageUrl: images![index],
              placeholder: (context, url) => Center(child: const CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ));
  }
}
