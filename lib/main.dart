import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controllers/main_controller.dart';
import 'controllers/image_controller.dart';
import 'widgets/sidebar_widget.dart';
import 'pages/image_processing_page.dart';
import 'pages/audio_processing_page.dart';
import 'pages/video_processing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Magic Photo - 镜头运动效果',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF6366F1), // 现代紫色
              brightness: Brightness.light,
            ),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              elevation: 0,
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
            ),
            cardTheme: CardThemeData(
              elevation: 8,
              shadowColor: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          home: const MyHomePage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 初始化控制器
    Get.put(MainController());
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          // 左侧导航栏
          const SidebarWidget(),
          
          // 右侧内容区域
          Expanded(
            child: GetBuilder<MainController>(
              builder: (controller) {
                switch (controller.currentPage) {
                  case PageType.image:
                    return const ImageProcessingPage();
                  case PageType.video:
                    return const VideoProcessingPage();
                  case PageType.audio:
                    return const AudioProcessingPage();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
