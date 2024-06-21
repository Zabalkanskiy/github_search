
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppTextDialog extends StatelessWidget {
  const AppTextDialog(
      this.text, {
        super.key,
      });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Dialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            insetPadding: EdgeInsets.symmetric(horizontal: 6.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.h),
            ),
            child: Container(
              height: 25.h,
              padding: EdgeInsets.symmetric(
                vertical: 2.h,
                horizontal: 6.w,
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 27.h,
            right: 3.w,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}