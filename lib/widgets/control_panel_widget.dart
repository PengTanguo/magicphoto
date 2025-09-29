import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/image_controller.dart';

class ControlPanelWidget extends StatelessWidget {
  const ControlPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageController controller = Get.find<ImageController>();
    
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
                    colors: [Color(0xFF10B981), Color(0xFF059669)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.control_camera_rounded,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                '动画控制',
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
          
          // 动画状态显示
          _buildAnimationStatus(controller),
          
          SizedBox(height: 16.h),
          
          // 控制按钮
          _buildControlButtons(controller),
          
          SizedBox(height: 16.h),
          
          // 动画设置
          _buildAnimationSettings(controller),
        ],
      ),
    );
  }
  
  Widget _buildAnimationStatus(ImageController controller) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: controller.isAnimating.value 
              ? LinearGradient(
                  colors: [
                    const Color(0xFF3B82F6).withOpacity(0.1),
                    const Color(0xFF1D4ED8).withOpacity(0.05),
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
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: controller.isAnimating.value 
                ? const Color(0xFF3B82F6).withOpacity(0.3)
                : Colors.grey.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            if (controller.isAnimating.value)
              BoxShadow(
                color: const Color(0xFF3B82F6).withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 12.w,
              height: 12.h,
              decoration: BoxDecoration(
                color: controller.isAnimating.value 
                    ? const Color(0xFF3B82F6) 
                    : Colors.grey[400],
                shape: BoxShape.circle,
                boxShadow: controller.isAnimating.value ? [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withOpacity(0.3),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ] : null,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.isAnimating.value ? '动画进行中' : '动画已停止',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: controller.isAnimating.value 
                          ? const Color(0xFF3B82F6) 
                          : Colors.grey[600],
                    ),
                  ),
                  if (controller.isAnimating.value && controller.currentAnimationType.value.isNotEmpty)
                    Text(
                      _getAnimationTypeText(controller.currentAnimationType.value),
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
            if (controller.isAnimating.value)
              Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF3B82F6)),
                ),
              ),
          ],
        ),
      );
    });
  }
  
  Widget _buildControlButtons(ImageController controller) {
    return Obx(() {
      return Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: controller.isAnimating.value 
                    ? const LinearGradient(
                        colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [Colors.grey[400]!, Colors.grey[500]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: controller.isAnimating.value ? [
                  BoxShadow(
                    color: const Color(0xFFEF4444).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ] : null,
              ),
              child: ElevatedButton.icon(
                onPressed: controller.isAnimating.value 
                    ? controller.stopAnimation
                    : null,
                icon: Icon(
                  controller.isAnimating.value ? Icons.stop_rounded : Icons.play_arrow_rounded,
                  size: 20.sp,
                ),
                label: Text(
                  controller.isAnimating.value ? '停止动画' : '开始动画',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey[100]!,
                    Colors.grey[200]!,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1.5,
                ),
              ),
              child: OutlinedButton.icon(
                onPressed: () {
                  controller.resetAnimations();
                },
                icon: Icon(Icons.refresh_rounded, size: 20.sp),
                label: Text(
                  '重置', 
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.grey[700],
                  side: BorderSide.none,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
  
  Widget _buildAnimationSettings(ImageController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '动画设置',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        
        // 动画持续时间
        _buildSettingItem(
          label: '动画持续时间',
          child: Row(
            children: [
              Text(
                '2秒',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.timer,
                size: 16.sp,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
        
        SizedBox(height: 8.h),
        
        // 动画曲线
        _buildSettingItem(
          label: '动画曲线',
          child: Row(
            children: [
              Text(
                '缓入缓出',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.trending_up,
                size: 16.sp,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
        
        SizedBox(height: 8.h),
        
        // 循环模式
        _buildSettingItem(
          label: '循环模式',
          child: Row(
            children: [
              Text(
                '往返循环',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.repeat,
                size: 16.sp,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildSettingItem({
    required String label,
    required Widget child,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black87,
          ),
        ),
        child,
      ],
    );
  }
  
  String _getAnimationTypeText(String type) {
    switch (type) {
      case 'zoom':
        return '推拉镜头效果';
      case 'pan':
        return '平移镜头效果';
      case 'rotation':
        return '旋转镜头效果';
      case 'tilt':
        return '倾斜镜头效果';
      case 'orbit':
        return '环绕镜头效果';
      default:
        return '未知动画';
    }
  }
}
