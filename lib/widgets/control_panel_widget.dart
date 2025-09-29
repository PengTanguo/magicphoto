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
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.surface.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 12),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.control_camera_rounded,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Text(
                '动画控制中心',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          
          // 动画状态显示
          _buildAnimationStatus(context, controller),
          
          SizedBox(height: 16.h),
          
          // 控制按钮
          _buildControlButtons(context, controller),
          
          SizedBox(height: 16.h),
          
          // 动画设置
          _buildAnimationSettings(controller),
        ],
      ),
    );
  }
  
  Widget _buildAnimationStatus(BuildContext context, ImageController controller) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: controller.isAnimating.value 
              ? LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.15),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.surface.withOpacity(0.5),
                    Theme.of(context).colorScheme.surface.withOpacity(0.3),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: controller.isAnimating.value 
                ? Theme.of(context).colorScheme.primary.withOpacity(0.4)
                : Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            if (controller.isAnimating.value)
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 16.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: controller.isAnimating.value 
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline.withOpacity(0.5),
                shape: BoxShape.circle,
                boxShadow: controller.isAnimating.value ? [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ] : null,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.isAnimating.value ? '动画进行中' : '动画已停止',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: controller.isAnimating.value 
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (controller.isAnimating.value && controller.currentAnimationType.value.isNotEmpty)
                    Text(
                      _getAnimationTypeText(controller.currentAnimationType.value),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
            if (controller.isAnimating.value)
              Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                ),
              ),
          ],
        ),
      );
    });
  }
  
  Widget _buildControlButtons(BuildContext context, ImageController controller) {
    return Obx(() {
      return Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: controller.isAnimating.value 
                    ? LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.error,
                          Theme.of(context).colorScheme.error.withOpacity(0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: (controller.isAnimating.value 
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.primary).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: controller.isAnimating.value 
                    ? controller.stopAnimation
                    : null,
                icon: Icon(
                  controller.isAnimating.value ? Icons.stop_rounded : Icons.play_arrow_rounded,
                  size: 22.sp,
                ),
                label: Text(
                  controller.isAnimating.value ? '停止动画' : '开始动画',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.surface.withOpacity(0.8),
                    Theme.of(context).colorScheme.surface.withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: OutlinedButton.icon(
                onPressed: () {
                  controller.resetAnimations();
                },
                icon: Icon(Icons.refresh_rounded, size: 22.sp),
                label: Text(
                  '重置', 
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  side: BorderSide.none,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
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
