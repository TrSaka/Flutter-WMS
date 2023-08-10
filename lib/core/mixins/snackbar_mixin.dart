

import 'package:flutter/material.dart';

mixin SnackbarMixin{
  showSnackBar(BuildContext context,String content){
    ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(content)));
  }
}