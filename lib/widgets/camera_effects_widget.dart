import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/image_controller.dart';

class CameraEffectsWidget extends StatelessWidget {
  const CameraEffectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageController controller = Get.find<ImageController>();
    
    return Obx(() {
      if (controller.selectedImage.value == null) {
        return const SizedBox.shrink();
      }
      
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.video_camera_back_rounded,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  '镜头运动效果',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            
            // 动画按钮网格
            _buildAnimationButtons(controller),
            
            SizedBox(height: 20.h),
            
            // 手动控制面板
            _buildManualControls(controller),
          ],
        ),
      );
    });
  }
  
  Widget _buildAnimationButtons(ImageController controller) {
    final List<Map<String, dynamic>> effects = [
      {
        'title': '推拉镜头',
        'subtitle': 'Zoom In/Out',
        'icon': Icons.zoom_in_rounded,
        'color': const Color(0xFF3B82F6),
        'onTap': controller.startZoomAnimation,
      },
      {
        'title': '平移镜头',
        'subtitle': 'Pan Left/Right',
        'icon': Icons.pan_tool_rounded,
        'color': const Color(0xFF10B981),
        'onTap': controller.startPanAnimation,
      },
      {
        'title': '旋转镜头',
        'subtitle': 'Rotation',
        'icon': Icons.rotate_right_rounded,
        'color': const Color(0xFFF59E0B),
        'onTap': controller.startRotationAnimation,
      },
      {
        'title': '倾斜镜头',
        'subtitle': 'Tilt',
        'icon': Icons.transform_rounded,
        'color': const Color(0xFF8B5CF6),
        'onTap': controller.startTiltAnimation,
      },
      {
        'title': '环绕镜头',
        'subtitle': 'Orbit',
        'icon': Icons.screen_rotation_rounded,
        'color': const Color(0xFFEF4444),
        'onTap': controller.startOrbitAnimation,
      },
    ];
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.2,
      ),
      itemCount: effects.length,
      itemBuilder: (context, index) {
        final effect = effects[index];
        return _buildEffectButton(
          title: effect['title'],
          subtitle: effect['subtitle'],
          icon: effect['icon'],
          color: effect['color'],
          onTap: effect['onTap'],
          isAnimating: controller.isAnimating.value && 
                      controller.currentAnimationType.value == _getAnimationType(effect['title']),
        );
      },
    );
  }
  
  Widget _buildEffectButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required bool isAnimating,
  }) {
    return GestureDetector(
      onTap: isAnimating ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: isAnimating 
              ? LinearGradient(
                  colors: [
                    color.withOpacity(0.15),
                    color.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [
                    Colors.grey[50]!,
                    Colors.grey[100]!,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isAnimating ? color.withOpacity(0.3) : Colors.grey[200]!,
            width: isAnimating ? 2 : 1,
          ),
          boxShadow: [
            if (isAnimating)
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: isAnimating 
                        ? color.withOpacity(0.2)
                        : Colors.grey[200]!.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    icon,
                    size: 32.sp,
                    color: isAnimating ? color : Colors.grey[600],
                  ),
                ),
                if (isAnimating)
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      width: 12.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: isAnimating ? color : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildManualControls(ImageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '手动控制',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        
        // 推拉控制
        _buildSliderControl(
          label: '推拉镜头',
          value: controller.zoomValue.value,
          min: 0.5,
          max: 3.0,
          onChanged: controller.updateZoom,
          color: Colors.blue,
        ),
        
        SizedBox(height: 12.h),
        
        // 旋转控制
        _buildSliderControl(
          label: '旋转角度',
          value: controller.rotationValue.value,
          min: -1.0,
          max: 1.0,
          onChanged: controller.updateRotation,
          color: Colors.orange,
        ),
        
        SizedBox(height: 12.h),
        
        // 倾斜控制
        _buildSliderControl(
          label: '倾斜角度',
          value: controller.tiltValue.value,
          min: -0.5,
          max: 0.5,
          onChanged: controller.updateTilt,
          color: Colors.purple,
        ),
        
        SizedBox(height: 12.h),
        
        // 环绕控制
        _buildSliderControl(
          label: '环绕效果',
          value: controller.orbitValue.value,
          min: -1.0,
          max: 1.0,
          onChanged: controller.updateOrbit,
          color: Colors.red,
        ),
        
        SizedBox(height: 16.h),
        
        // 重置按钮
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              controller.resetAnimations();
            },
            icon: Icon(Icons.refresh, size: 18.sp),
            label: Text('重置所有效果', style: TextStyle(fontSize: 14.sp)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[600],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildSliderControl({
    required String label,
    required double value,
    required double min,
    required double max,
    required Function(double) onChanged,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Text(
              value.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        SliderTheme(
          data: SliderTheme.of(Get.context!).copyWith(
            activeTrackColor: color,
            inactiveTrackColor: color.withOpacity(0.2),
            thumbColor: color,
            overlayColor: color.withOpacity(0.2),
            trackHeight: 3.h,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
  
  String _getAnimationType(String title) {
    switch (title) {
      case '推拉镜头':
        return 'zoom';
      case '平移镜头':
        return 'pan';
      case '旋转镜头':
        return 'rotation';
      case '倾斜镜头':
        return 'tilt';
      case '环绕镜头':
        return 'orbit';
      default:
        return '';
    }
  }
}
