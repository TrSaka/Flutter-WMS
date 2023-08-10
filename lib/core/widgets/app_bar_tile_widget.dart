import 'package:flutter/material.dart';
import '../constants/constants/color_constants.dart';
import '../constants/enum/store_type_enum.dart';
import '../product/vm/menu/menu_view_model.dart';

class AppBarTileWidget extends StatelessWidget {
  const AppBarTileWidget(
      {super.key,
      required MenuViewModel viewModel,
      required this.subtitleText,
      required this.iconData,
      required this.pageIndex,
      required this.storeType})
      : _viewModel = viewModel;

  final MenuViewModel _viewModel;
  final String subtitleText;
  final IconData iconData;
  final int pageIndex;
  final StoreType storeType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 56,
      child: ListTile(
        iconColor: ColorConstants.colorWhite,
        textColor: ColorConstants.colorWhite,
        title: Icon(iconData),
        subtitle: Center(child: Text(subtitleText)),
        onTap: () {
          if (storeType == StoreType.MANUAL_PAGE) {
            _viewModel.changeSelectedIndex(pageIndex);
          } else if (storeType == StoreType.PLC_PAGE) {
            _viewModel.changeSelectedIndex(1);
          } else if (storeType == StoreType.MANAGE_STORE) {
            _viewModel.changeSelectedIndex(0);
          }
        },
        minLeadingWidth: 0,
      ),
    );
  }
}
