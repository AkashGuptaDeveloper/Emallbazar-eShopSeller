import 'package:flutter/material.dart';
import '../Model/CategoryModel/categoryModel.dart';
import '../Repository/categoryRepositry.dart';
import '../Screen/AddProduct/Add_Product.dart';
import '../Screen/EditProduct/EditProduct.dart';

class CategoryProvider extends ChangeNotifier {
  String errorMessage = '';

  Future<bool> setCategory(bool fromAddProduct, BuildContext context) async {
    try {
      var parameter = {
        // SellerId: context.read<SettingProvider>().currentUerID,
      };
      var result = await CategoryRepository.setCategory(parameter: parameter);
      bool error = result['error'];
      errorMessage = result['message'];
      if (!error) {
        var data = result['data'];
        if (fromAddProduct) {
          addProvider!.catagorylist.clear();
          addProvider!.catagorylist = (data as List)
              .map((data) => CategoryModel.fromJson(data))
              .toList();
        } else {
          editProvider!.catagorylist.clear();
          editProvider!.catagorylist = (data as List)
              .map((data) => CategoryModel.fromJson(data))
              .toList();
        }
      }
      return error;
    } catch (e) {
      errorMessage = e.toString();
      return true;
    }
  }
}
