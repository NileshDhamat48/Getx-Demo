import 'package:damoapp/api/api_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:infinite_scroll_pagination/src/core/paging_controller.dart';

import '../../response/res_user.dart';

class ProductController extends GetxController {
  final _pageSize = 10;

  final PagingController<int, Products> pagingController =
      PagingController(firstPageKey: 0);

  final ApiManager apiManager = ApiManager();

  @override
  void onInit() {
    pagingController.addPageRequestListener((skip) {
      getProductList(skip);
    });
    super.onInit();
  }

  void getProductList(int skip) async {
    try {
      var response = await apiManager.getCall(
          ApiConstant.apiProductList, {'limit': _pageSize, 'skip': skip});
      ProductData data = ProductData.fromJson(response);
      final isLastPage = (data.products?.length ?? 0) < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(data.products ?? []);
      } else {
        final nextPageKey = skip + (data.products?.length ?? 0);
        pagingController.appendPage(data.products ?? [], nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}
