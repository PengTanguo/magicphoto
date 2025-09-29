import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoProcessingPage extends StatelessWidget {
  const VideoProcessingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 页面标题
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEF4444).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.videocam_rounded,
                  size: 24.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '视频处理',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '强大的视频编辑和特效工具',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: 32.h),
          
          // 功能卡片网格
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 1.2,
              children: [
                _buildFeatureCard(
                  icon: Icons.video_call_rounded,
                  title: '视频录制',
                  subtitle: '高质量录制',
                  color: const Color(0xFF3B82F6),
                ),
                _buildFeatureCard(
                  icon: Icons.edit_rounded,
                  title: '视频剪辑',
                  subtitle: '精确剪辑',
                  color: const Color(0xFF8B5CF6),
                ),
                _buildFeatureCard(
                  icon: Icons.auto_awesome_rounded,
                  title: '特效滤镜',
                  subtitle: '丰富特效',
                  color: const Color(0xFFF59E0B),
                ),
                _buildFeatureCard(
                  icon: Icons.speed_rounded,
                  title: '变速播放',
                  subtitle: '速度调节',
                  color: const Color(0xFF10B981),
                ),
                _buildFeatureCard(
                  icon: Icons.rotate_right_rounded,
                  title: '旋转翻转',
                  subtitle: '方向调整',
                  color: const Color(0xFFEC4899),
                ),
                _buildFeatureCard(
                  icon: Icons.crop_rounded,
                  title: '裁剪缩放',
                  subtitle: '尺寸调整',
                  color: const Color(0xFF06B6D4),
                ),
                _buildFeatureCard(
                  icon: Icons.audiotrack_rounded,
                  title: '音频同步',
                  subtitle: '音视频同步',
                  color: const Color(0xFF84CC16),
                ),
                _buildFeatureCard(
                  icon: Icons.high_quality_rounded,
                  title: '格式转换',
                  subtitle: '多格式支持',
                  color: const Color(0xFFF97316),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.grey[50]!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: 实现具体功能
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color,
                        color.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    size: 28.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
