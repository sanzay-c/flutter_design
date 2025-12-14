import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/common/shimmer/shimmer_effect.dart';

class ListShimmer extends StatelessWidget {
  const ListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Container(
            height: 100.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShimmerEffect(    height: 100.h,
                    width: 150.w,),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Column(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .start,
                      children: [
                        ShimmerEffect(height: 10.h, width: double.infinity,),
                        10.verticalSpace,

                        ShimmerEffect(height: 10.h, width: double.infinity,),
                        
                        10.verticalSpace,
                        
                        ShimmerEffect(height: 10.h, width: double.infinity,),
                        10.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
