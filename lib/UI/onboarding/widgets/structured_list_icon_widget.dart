import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StructuredListIcon extends StatelessWidget {
  const StructuredListIcon({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.checkColor,
  });
  final Color backgroundColor;
  final Color borderColor;
  final Color checkColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.r),
      // padding: EdgeInsets.symmetric(vertical: 6.h),
      width: 32.w,
      // height: 40.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: borderColor, width: 2.w),
      ),
      child: Column(
        children: [
          Row(
            spacing: 2.h,
            children: [
              Icon(
                Icons.check_circle_outline_rounded,
                size: 12.r,
                color: borderColor,
              ),
              Expanded(
                child: Divider(
                  color: borderColor,
                  thickness: 2.h,
                  height: 2,
                  // indent: 8.w,
                  endIndent: 2.w,
                ),
              ),
            ],
          ),
          Row(
            spacing: 2.h,
            children: [
              Icon(
                Icons.check_circle_outline_rounded,
                size: 12.r,
                color: borderColor,
              ),
              Expanded(
                child: Divider(
                  color: borderColor,
                  thickness: 2.h,
                  height: 2,
                  // indent: 8.w,
                  endIndent: 2.w,
                ),
              ),
            ],
          ),

          Row(
            spacing: 2.h,
            children: [
              Icon(
                Icons.check_circle_outline_rounded,
                size: 12.r,
                color: borderColor,
              ),
              Expanded(
                child: Divider(
                  color: borderColor,
                  thickness: 2.h,
                  height: 2,
                  // indent: 8.w,
                  endIndent: 2.w,
                ),
              ),
            ],
          ),

          // Expanded(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     spacing: 6.h,
          //     children: [
          //       Row(
          //         spacing: 2.h,
          //         children: [
          //           Icon(
          //             Icons.check_circle_outline_rounded,
          //             size: 12.r,
          //             color: borderColor,
          //           ),
          //           Divider(
          //             color: borderColor,
          //             thickness: 2.h,
          //             height: 2,
          //             // indent: 8.w,
          //             endIndent: 2.w,
          //           ),
          //         ],
          //       ),

          //       // Divider(
          //       //   color: borderColor,
          //       //   height: 0,
          //       //   thickness: 2.h,
          //       //   // indent: 8.w,
          //       //   endIndent: 2.w,
          //       // ),
          //       // Divider(
          //       //   color: borderColor,
          //       //   height: 0,
          //       //   thickness: 2.h,
          //       //   // indent: 8.w,
          //       //   endIndent: 2.w,
          //       // ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
    //     ],
    //   ),
    // );
  }
}
