import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';

class AudioProcessingPageOptimized extends StatelessWidget {
  const AudioProcessingPageOptimized({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.cardPaddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(),
          SizedBox(height: AppDimensions.verticalSpacing32),
          Expanded(child: _buildFeatureGrid()),
        ],
      ),
    );
  }
  
  Widget _buildPageHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(AppDimensions.spacing12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF059669)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radius12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withOpacity(0.3),
                blurRadius: AppDimensions.shadowBlurSmall,
                offset: Offset(0, AppDimensions.shadowOffset),
              ),
            ],
          ),
          child: Icon(
            Icons.audiotrack_rounded,
            size: AppDimensions.iconSize24,
            color: Colors.white,
          ),
        ),
        SizedBox(width: AppDimensions.spacing16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '音频处理',
              style: TextStyle(
                fontSize: AppDimensions.fontSize24,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              '专业的音频编辑和处理工具',
              style: TextStyle(
                fontSize: AppDimensions.fontSize14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildFeatureGrid() {
    final features = [
      _FeatureData(Icons.mic_rounded, '录音工具', '高质量录音', const Color(0xFF3B82F6)),
      _FeatureData(Icons.equalizer_rounded, '音频均衡器', '音效调节', const Color(0xFF8B5CF6)),
      _FeatureData(Icons.graphic_eq_rounded, '音频分析', '频谱分析', const Color(0xFFF59E0B)),
      _FeatureData(Icons.cut_rounded, '音频剪辑', '精确剪辑', const Color(0xFFEF4444)),
      _FeatureData(Icons.volume_up_rounded, '音量调节', '音量控制', const Color(0xFF10B981)),
      _FeatureData(Icons.speed_rounded, '变速播放', '速度调节', const Color(0xFFEC4899)),
    ];
    
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: AppDimensions.gridSpacing,
      mainAxisSpacing: AppDimensions.gridSpacing,
      childAspectRatio: AppDimensions.gridItemAspectRatio,
      children: features.map((feature) => _buildFeatureCard(feature)).toList(),
    );
  }
  
  Widget _buildFeatureCard(_FeatureData feature) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radius16),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: AppDimensions.shadowBlur,
            offset: Offset(0, AppDimensions.shadowOffset),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: 实现具体功能
          },
          borderRadius: BorderRadius.circular(AppDimensions.radius16),
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.cardPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(AppDimensions.spacing16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        feature.color,
                        feature.color.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radius12),
                    boxShadow: [
                      BoxShadow(
                        color: feature.color.withOpacity(0.3),
                        blurRadius: AppDimensions.shadowBlurSmall,
                        offset: Offset(0, AppDimensions.shadowOffset),
                      ),
                    ],
                  ),
                  child: Icon(
                    feature.icon,
                    size: AppDimensions.iconSize28,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: AppDimensions.verticalSpacing16),
                Text(
                  feature.title,
                  style: TextStyle(
                    fontSize: AppDimensions.fontSize16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppDimensions.verticalSpacing4),
                Text(
                  feature.subtitle,
                  style: TextStyle(
                    fontSize: AppDimensions.fontSize12,
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

class _FeatureData {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  
  const _FeatureData(this.icon, this.title, this.subtitle, this.color);
}
