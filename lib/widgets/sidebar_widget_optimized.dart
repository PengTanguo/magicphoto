import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../constants/app_dimensions.dart';

class SidebarWidgetOptimized extends StatelessWidget {
  const SidebarWidgetOptimized({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();
    
    return Container(
      width: AppDimensions.sidebarWidth,
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
            blurRadius: AppDimensions.shadowBlur,
            offset: Offset(AppDimensions.shadowOffset, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildLogoSection(),
          Expanded(child: _buildNavigationSection(controller)),
          _buildFooterSection(),
        ],
      ),
    );
  }
  
  Widget _buildLogoSection() {
    return Container(
      padding: EdgeInsets.all(AppDimensions.spacing24),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(AppDimensions.spacing16),
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
              borderRadius: BorderRadius.circular(AppDimensions.radius16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6366F1).withOpacity(0.3),
                  blurRadius: AppDimensions.shadowBlurSmall,
                  offset: Offset(0, AppDimensions.shadowOffset),
                ),
              ],
            ),
            child: Icon(
              Icons.auto_awesome_rounded,
              size: AppDimensions.iconSize32,
              color: Colors.white,
            ),
          ),
          SizedBox(height: AppDimensions.verticalSpacing16),
          Text(
            'Magic Photo',
            style: TextStyle(
              fontSize: AppDimensions.fontSize20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: AppDimensions.verticalSpacing4),
          Text(
            '多媒体处理工具',
            style: TextStyle(
              fontSize: AppDimensions.fontSize12,
              color: Colors.white.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNavigationSection(MainController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacing16),
      child: Column(
        children: [
          _buildNavItem(
            controller: controller,
            pageType: PageType.image,
            icon: Icons.image_rounded,
            title: '图片处理',
            subtitle: '镜头运动效果',
          ),
          SizedBox(height: AppDimensions.verticalSpacing8),
          _buildNavItem(
            controller: controller,
            pageType: PageType.video,
            icon: Icons.videocam_rounded,
            title: '视频处理',
            subtitle: '视频特效编辑',
          ),
          SizedBox(height: AppDimensions.verticalSpacing8),
          _buildNavItem(
            controller: controller,
            pageType: PageType.audio,
            icon: Icons.audiotrack_rounded,
            title: '音频处理',
            subtitle: '音频编辑工具',
          ),
        ],
      ),
    );
  }
  
  Widget _buildFooterSection() {
    return Container(
      padding: EdgeInsets.all(AppDimensions.spacing16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.white.withOpacity(0.1),
          ),
          SizedBox(height: AppDimensions.verticalSpacing16),
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: AppDimensions.iconSize16,
                color: Colors.white.withOpacity(0.6),
              ),
              SizedBox(width: AppDimensions.spacing8),
              Expanded(
                child: Text(
                  '版本 1.0.0',
                  style: TextStyle(
                    fontSize: AppDimensions.fontSize12,
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
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
          padding: EdgeInsets.all(AppDimensions.spacing16),
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
            borderRadius: BorderRadius.circular(AppDimensions.radius12),
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
                      blurRadius: AppDimensions.shadowBlurSmall,
                      offset: Offset(0, AppDimensions.shadowOffset),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppDimensions.spacing8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.2)
                      : Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radius8),
                ),
                child: Icon(
                  icon,
                  size: AppDimensions.iconSize20,
                  color: isSelected ? Colors.white : Colors.white.withOpacity(0.8),
                ),
              ),
              SizedBox(width: AppDimensions.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: AppDimensions.fontSize14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.white.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: AppDimensions.verticalSpacing4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: AppDimensions.fontSize11,
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
                  size: AppDimensions.fontSize14,
                  color: Colors.white.withOpacity(0.8),
                ),
            ],
          ),
        ),
      );
    });
  }
}
