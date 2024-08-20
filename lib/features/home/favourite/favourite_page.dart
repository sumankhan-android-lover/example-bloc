import 'package:ecommarce/features/common_widget/common_svgicon.dart';
import 'package:ecommarce/features/home/favourite/bloc/favourite_bloc.dart';
import 'package:ecommarce/features/home/favourite/model/favourite/favorite_model.dart';
import 'package:ecommarce/helpers/color_config.dart';
import 'package:ecommarce/helpers/common_function.dart';
import 'package:ecommarce/helpers/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  FavouriteBloc? favouriteBloc;
  List<FavoriteModel> favouriteList = [];
  String title = "Favourites";

  @override
  void initState() {
    favouriteBloc = BlocProvider.of<FavouriteBloc>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    favouriteBloc?.add(FetchFavouritesEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x0d53b175),
      appBar: commonAppBar(title, isAction: true, callback: () {
        favouriteBloc?.add(ClearAllFavouritesEvent());
      }),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: BlocBuilder<FavouriteBloc, FavouriteState>(
          builder: (context, state) {
            if (state is LoadedFavouriteState) {
              favouriteList = state.items;
            }

            if (state is FavouriteError) {
              return Center(child: Text(state.error));
            }

            return ListView.builder(
              itemCount: favouriteList.length,
              itemBuilder: (context, index) => favouriteItem(favouriteList[index], index),
            );
          },
        ),
      ),
    );
  }

  AppBar detailsAppBar(String title) => AppBar(
        title: Text(
          title,
          style: TextStyleTypography.typoBoldStyle16.copyWith(color: Colors.white),
        ),
        backgroundColor: AppThemeColor.primaryColor,
      );

  Widget favouriteItem(FavoriteModel favouriteData, int index) => Padding(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: 8,
          right: 8,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.network(
                  '${favouriteData.image}',
                  width: 55,
                  height: 55,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${favouriteData.title}',
                        style: TextStyleTypography.typoBoldStyle14,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${favouriteData.description}',
                        style: TextStyleTypography.typoMediumStyle12,
                        textAlign: TextAlign.justify,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '\u{20B9}${favouriteData.price}',
                        style: TextStyleTypography.heading12,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                InkWell(
                  onTap: () {
                    favouriteBloc?.add(RemoveFavouriteEvent(index));
                    // favouriteBloc?.add(RemoveFavouriteEvent(favouriteData));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: CommonSVGIcon(
                      imageName: 'icon_delete',
                      imagePath: 'icon',
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(),
          ],
        ),
      );
}
