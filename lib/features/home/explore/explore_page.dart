import 'package:ecommarce/features/home/explore/bloc/category_bloc/category_bloc.dart';
import 'package:ecommarce/helpers/color_config.dart';
import 'package:ecommarce/helpers/constant.dart';
import 'package:ecommarce/navigation/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String title = "Category";
  String path = "assets/images/png/";
  CategoryBloc? categoryBloc;
  List<String> categoryList = [];
  List<String> get categoryImageList => ['${path}icon_electronics.png', '${path}icon_jewelery.png', '${path}icon_men.png', '${path}icon_women.png'];

  @override
  void initState() {
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    categoryBloc?.add(FetchCategoriesEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: categoryAppBar(title),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading || state is CategoryInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 0.5,
                  valueColor: AlwaysStoppedAnimation<Color>(AppThemeColor.primaryColor),
                ),
              );
            }

            if (state is CategoryLoaded) {
              categoryList = state.categories;
            }

            return GridView.builder(
              itemCount: categoryList.isNotEmpty ? categoryList.length : 0,
              itemBuilder: (context, index) => categoryItem(categoryList[index]),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar categoryAppBar(String title) => AppBar(
        title: Text(
          title,
          style: TextStyleTypography.typoBoldStyle16.copyWith(color: Colors.white),
        ),
        backgroundColor: AppThemeColor.primaryColor,
      );

  Widget categoryItem(String category) => InkWell(
        onTap: () {
          context.pushNamed(AppRouteConstantName.exploreItemList, extra: category);
        },
        child: Container(
          height: MediaQuery.sizeOf(context).height*0.9,
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: ColorConstants.white,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(
                Radius.circular(4.0),
              ),
              border: Border.all(color: Colors.grey, width: 0.2),),
          child: Column(
            children: [
              Expanded(
                flex: 90,
                child: Padding(
                  padding: EdgeInsets.all(MediaQuery.sizeOf(context).width/12),
                  child: Image.network(
                    category == "electronics"
                        ? categoryImageList[0]
                        : category == "jewelery"
                            ? categoryImageList[1]
                            : category == "men's clothing"
                                ? categoryImageList[2]
                                : categoryImageList[3],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Divider(),
              Text(
                category,
                style: TextStyleTypography.typoSemiBoldStyle12,
              )
            ],
          ),
        ),
      );
}
