import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../models/category_model/category_model.dart';
import '../../models/favourite_model/favourite_model.dart';

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateToAndReplace(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) {
      return false;
    },
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color background = mainColor,
  bool isUpperCase = true,
  double radius = 10,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: mainColor,
      ),
      child: IconButton(
        onPressed: () {
          function();
        },
        icon: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
      ),
    );

Widget defaultTextFormField({
  required TextEditingController controller,
  required FormFieldValidator<String> validate,
  required String text,
  required IconData prefixIcon,
  required TextInputType keyboardType,
  IconData? suffix,
  bool isPassword = false,
  Function? suffixPressed,
  Color textColor = Colors.black,
  Function? submit,
}) =>
    TextFormField(
      onFieldSubmitted: (value) {
        submit!(value);
      },
      validator: validate,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(

        labelText: text,
        labelStyle: TextStyle(
          color: textColor,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: mainColor,
        ),

        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(
                  suffix,
                  color: mainColor,
                ),
                onPressed: () {
                  suffixPressed!();
                },
              )
            : null,
        // lw passet 7aga lel suffix el suffixicon hayb2a beysawi el suffix el baseto else yeb2a mafeee4(null)

        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gapPadding: 30,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: mainColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        filled: false,
      ),
      obscureText: isPassword,
    );

Future<bool?> toast({
  required String text,
  required Color color,
}) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget productScreenBuilder(
    context, HomeModel homeModel, CategoriesModel category) {
  return SingleChildScrollView(
    child: Column(
      children: [
        CarouselSlider(
            items: homeModel.data!.banners
                .map((e) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image(
                      image: NetworkImage(e.image),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )))
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1.0,
            )),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 100,
          child: ListView.separated(
            itemBuilder: (context, index) =>
                categoryItemInProductScreen(category.data!.dataModel[index]),
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
            itemCount: category.data!.dataModel.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 1 / 1.8,
            crossAxisCount: 2,
            children: List.generate(
              homeModel.data!.products.length,
              (index) => productItem(homeModel.data!.products[index], context),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget productItem(ProductModel product, context) {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image(
                image: NetworkImage(
                  product.image,
                ),
                height: 200,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(product.name,
                style: const TextStyle(),
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
            Expanded(child: Container()),
            Row(
              children: [
                Text(
                  "${product.price} EG",
                  style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (product.discount != 0)
                  Text(
                    "${product.oldPrice} EG",
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
      Row(
        children: [
          if (product.discount != 0)
            Container(
              height: 15,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(30))),
              alignment: Alignment.center,
              width: 80,
              child: const Text(
                "DISCOUNT",
                style: TextStyle(color: Colors.white),
              ),
            ),
          const Spacer(),
          IconButton(
            onPressed: () {
              AppCubit.get(context).changeFavourites(productId: product.id);
            },
            icon: AppCubit.get(context).favouritesMap[product.id] == true
                ? Icon(
                    Icons.favorite,
                    color: mainColor,
                  )
                : const Icon(Icons.favorite_outline),
            color: Colors.grey,
          ),
        ],
      ),
    ],
  );
}

Widget categoryItemInProductScreen(DataModelOfCategory category) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        child: Image(
          width: 100,
          height: 100,
          image: NetworkImage(category.image),
        ),
      ),
      Container(
        alignment: Alignment.center,
        width: 100,
        height: 20,
        color: Colors.black.withOpacity(0.7),
        child: Text(
          category.name,
          style: const TextStyle(color: Colors.white),
        ),
      )
    ],
  );
}

Widget categoryItem(DataModelOfCategory category) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      children: [
        Image(
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            image: NetworkImage(category.image)),
        const SizedBox(width: 20),
        Container(
          padding: const EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          width: 150,
          height: 30,
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            category.name,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_right_alt),
          color: mainColor,
        )
      ],
    ),
  );
}

Widget favouriteItem(FavoritesData model, context, {bool isOld = true}) {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image(
                image: NetworkImage(model.product!.image!),
                height: 200,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(model.product!.name!,
                style: TextStyle(),
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
            Expanded(child: Container()),
            Row(
              children: [
                Text(
                  "${model.product!.price} EG",
                  style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (model.product!.discount != 0 && isOld == true)
                  Text(
                    "${model.product!.oldPrice} EG",
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
      Row(
        children: [
          if (model.product!.discount != 0 && isOld == true)
            Container(
              height: 15,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(30))),
              alignment: Alignment.center,
              width: 80,
              child: const Text(
                "DISCOUNT",
                style: TextStyle(color: Colors.white),
              ),
            ),
          const Spacer(),
          IconButton(
            onPressed: () {
              AppCubit.get(context)
                  .changeFavourites(productId: model.product!.id!);
            },
            icon:
                AppCubit.get(context).favouritesMap[model.product!.id!] == true
                    ? Icon(
                        Icons.favorite,
                        color: mainColor,
                      )
                    : const Icon(Icons.favorite_outline),
            color: Colors.grey,
          ),
        ],
      ),
    ],
  );
}

Widget favouriteScreenBuilder(FavoritesModel model, context) {
  return SingleChildScrollView(
    child: Container(
      alignment: Alignment.topCenter,
      color: Colors.white,
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        childAspectRatio: 1 / 1.8,
        crossAxisCount: 2,
        children: List.generate(
          model.data!.data.length,
          (index) => favouriteItem(model.data!.data[index], context),
        ),
      ),
    ),
  );
}

Widget test(SearchProduct model) {
  return Container(
    height: 150,
    child: Stack(
      children: [
        Row(
          children: [
            Container(
              width: 100,
              height: double.infinity,
              child: Image.network(
                '${model.image}',

              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Text(
                      '${model.price } Eg',
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

      ],
    ),
  );
}

