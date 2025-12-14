import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/common/shimmer/shimmer_effect.dart';

class DetailShimmer extends StatelessWidget {
  const DetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0.h),
      children: [
        ShimmerEffect(height: 200.h),
        16.verticalSpace,

        ShimmerEffect(height: 24.h, width: 200.w),
        8.verticalSpace,

        Row(
          children: [
            ShimmerEffect(height: 30.h, width: 120.w),
            10.verticalSpace,
            ShimmerEffect(height: 30.h, width: 120.w),
          ],
        ),

        16.verticalSpace,

        ShimmerEffect(height: 20.h, width: 150.w),

        8.verticalSpace,

        ShimmerEffect(height: 20.h, width: 150.w),

        8.verticalSpace,

        ShimmerEffect(height: 20.h),
        ShimmerEffect(height: 20.h),
        ShimmerEffect(height: 20.h),
        16.verticalSpace,

        ShimmerEffect(height: 20.h, width: 150.w),
        8.verticalSpace,

        ShimmerEffect(height: 20.h),
        ShimmerEffect(height: 20.h),
        ShimmerEffect(height: 20.h),
        16.verticalSpace,

        ShimmerEffect(height: 20.h, width: 200),
        ShimmerEffect(height: 20.h, width: 150),
        ShimmerEffect(height: 20.h, width: 250),
      ],
    );
  }
}
