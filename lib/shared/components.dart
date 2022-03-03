import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_flutter/models/home_model.dart';
import 'package:shop_app_flutter/screens/category_products.dart';
import 'package:shop_app_flutter/shared/constants.dart';

class PageViewModel {
  String title;
  String text;
  String image;

  PageViewModel(
    this.title,
    this.text,
    this.image,
  );
}

void navigateTo({required BuildContext context, required Widget screen}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return screen;
    }),
  );
}

DefaultFormField({
  required String labelText,
  required TextEditingController controller,
  bool obscureText = false,
  Icon? prefixIcon,
  IconButton? suffixIcon,
  TextInputType? keyboardType,
  GestureTapCallback? onFieldTap,
  bool? isReadOnly,
  FormFieldValidator? validator,
  ValueChanged<String>? onFieldChanged,
}) {
  return TextFormField(
    onChanged: onFieldChanged,
    onTap: onFieldTap,
    keyboardType: keyboardType,
    controller: controller,
    obscureText: obscureText,
    readOnly: isReadOnly ?? false,
    validator: validator,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: labelText,
    ),
  );
}

DefaultButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return Container(
    height: 50,
    width: double.infinity,
    child: Expanded(
      child: TextButton(
        onPressed: onPressed,
        child: Text(text.toUpperCase()),
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.blue,
        ),
      ),
    ),
  );
}

LoadingButton() {
  return Stack(children: [
    Container(
      height: 50,
      width: double.infinity,
      child: Expanded(
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blue,
          ),
          onPressed: () {},
          child: const Text(''),
        ),
      ),
    ),
    const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
    )
  ]);
}

Widget Category(CategoriesDataModel category, BuildContext context) {
  return GestureDetector(
    onTap: () => navigateTo(
        context: context,
        screen: CategoryProductsScreen(category.categoryId, category.name)),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            category.image,
            fit: BoxFit.fill,
            height: 100.0,
            width: 100.0,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
            child: Text(
          category.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )),
        const Icon(
          Icons.arrow_forward_ios,
          color: primaryColor,
        )
      ],
    ),
  );
}

Widget Product(ProductDataModel product, double screenWidth) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image(
            fit: BoxFit.fill,
            width: screenWidth / 2,
            height: 150,
            image: NetworkImage(product.image),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            product.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget CategoryProduct(CategoryProductDataModel product, double screenWidth) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image(
            fit: BoxFit.fill,
            width: screenWidth / 2,
            height: 150,
            image: NetworkImage(product.image),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            product.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

void navigateToAndFinish(
    {required BuildContext context, required Widget screen}) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
    builder: (context) {
      return screen;
    },
  ), (r) => false);
}

Widget getPageViewItem(PageViewModel pageViewModel) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(pageViewModel.image),
        const SizedBox(
          height: 40,
        ),
        Text(
          pageViewModel.title,
          style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: largeFontSize),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(pageViewModel.text,
            style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300,
                fontSize: mediumFontSize)),
      ],
    ),
  );
}
