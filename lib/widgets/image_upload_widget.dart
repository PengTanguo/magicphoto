import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/image_controller.dart';

class ImageUploadWidget extends StatelessWidget {
  const ImageUploadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageController controller = Get.find<ImageController>();
    
    return Obx(() {
      if (controller.selectedImage.value == null) {
        return _buildUploadPlaceholder(controller);
      } else {
        return _buildImageDisplay(controller);
      }
    });
  }
  
  Widget _buildUploadPlaceholder(ImageController controller) {
    return Container(
      width: 300.w,
      height: 180.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey[50]!,
            Colors.grey[100]!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: Icon(
                Icons.cloud_upload_rounded,
                size: 40.sp,
                color: const Color(0xFF6366F1),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              '选择图片开始创作',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            Text(
              '支持相册选择和拍照',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildUploadButton(
                    icon: Icons.photo_library_rounded,
                    label: '相册',
                    onTap: controller.pickImage,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildUploadButton(
                    icon: Icons.camera_alt_rounded,
                    label: '拍照',
                    onTap: controller.takePhoto,
                    color: const Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildUploadButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.1),
              color.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: color, size: 20.sp),
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildImageDisplay(ImageController controller) {
    return Container(
      width: 300.w,
      height: 180.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          children: [
            // 图片显示
            Positioned.fill(
              child: Obx(() {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..scale(controller.zoomValue.value)
                    ..translate(
                      controller.panValue.value.dx * 100,
                      controller.panValue.value.dy * 100,
                    )
                    ..rotateZ(controller.rotationValue.value)
                    ..rotateX(controller.tiltValue.value)
                    ..rotateY(controller.orbitValue.value * 0.5),
                  child: Image.file(
                    controller.selectedImage.value!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                );
              }),
            ),
            
            // 重新选择按钮
            Positioned(
              top: 12.h,
              right: 12.w,
              child: GestureDetector(
                onTap: () {
                  controller.selectedImage.value = null;
                  controller.resetAnimations();
                },
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ),
              ),
            ),
            
            // 动画状态指示器
            Obx(() {
              if (controller.isAnimating.value) {
                return Positioned(
                  bottom: 12.h,
                  left: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF6366F1).withOpacity(0.9),
                          const Color(0xFF8B5CF6).withOpacity(0.9),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 14.w,
                          height: 14.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          _getAnimationTypeText(controller.currentAnimationType.value),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
  
  String _getAnimationTypeText(String type) {
    switch (type) {
      case 'zoom':
        return '推拉镜头';
      case 'pan':
        return '平移镜头';
      case 'rotation':
        return '旋转镜头';
      case 'tilt':
        return '倾斜镜头';
      case 'orbit':
        return '环绕镜头';
      default:
        return '动画中';
    }
  }
}
