import 'package:damoapp/api/api_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:infinite_scroll_pagination/src/core/paging_controller.dart';

import '../../response/product_details.dart';
import '../../response/res_user.dart';

class ProductDetailController extends GetxController {
  final productDetail = ProductDetails().obs;
  final isLoading = true.obs;
  final ApiManager apiManager = ApiManager();

  ProductDetailController();

  void getProductList(int? id) async {
    try {
      var response = await apiManager
          .getCall(ApiConstant.apiProductDetail +( id?.toString() ?? ""));
      ProductDetails data = ProductDetails.fromJson(response);
      isLoading.value = false;
      productDetail.value = data;
    } catch (error) {
      isLoading.value = false;
    }
  }
}
