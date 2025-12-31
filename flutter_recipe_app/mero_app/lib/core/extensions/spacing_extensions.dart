import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Spacing on num {
  SizedBox get vSpace => SizedBox(height: h);
  SizedBox get hSpace => SizedBox(width: w);
}