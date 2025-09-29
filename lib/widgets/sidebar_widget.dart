import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();
    
    return Container(
      width: 280.w,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E293B),
            Color(0xFF334155),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo区域
          Container(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF6366F1),
                        Color(0xFF8B5CF6),
                        Color(0xFFA855F7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6366F1).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    size: 32.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Magic Photo',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '多媒体处理工具',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          // 导航菜单
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  _buildNavItem(
                    controller: controller,
                    pageType: PageType.image,
                    icon: Icons.image_rounded,
                    title: '图片处理',
                    subtitle: '镜头运动效果',
                  ),
                  SizedBox(height: 8.h),
                  _buildNavItem(
                    controller: controller,
                    pageType: PageType.video,
                    icon: Icons.videocam_rounded,
                    title: '视频处理',
                    subtitle: '视频特效编辑',
                  ),
                  SizedBox(height: 8.h),
                  _buildNavItem(
                    controller: controller,
                    pageType: PageType.audio,
                    icon: Icons.audiotrack_rounded,
                    title: '音频处理',
                    subtitle: '音频编辑工具',
                  ),
                ],
              ),
            ),
          ),
          
          // 底部信息
          Container(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.white.withOpacity(0.1),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 16.sp,
                      color: Colors.white.withOpacity(0.6),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        '版本 1.0.0',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNavItem({
    required MainController controller,
    required PageType pageType,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Obx(() {
      final isSelected = controller.isCurrentPage(pageType);
      
      return GestureDetector(
        onTap: () => controller.switchToPage(pageType),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    colors: [
                      Color(0xFF6366F1),
                      Color(0xFF8B5CF6),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: isSelected ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            border: isSelected
                ? null
                : Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.2)
                      : Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  icon,
                  size: 20.sp,
                  color: isSelected ? Colors.white : Colors.white.withOpacity(0.8),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.white.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: isSelected 
                            ? Colors.white.withOpacity(0.8)
                            : Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14.sp,
                  color: Colors.white.withOpacity(0.8),
                ),
            ],
          ),
        ),
      );
    });
  }
}
