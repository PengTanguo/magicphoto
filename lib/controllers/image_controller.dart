import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController with GetSingleTickerProviderStateMixin {
  // 图片相关
  final Rx<XFile?> selectedImage = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();
  
  // 动画控制器
  late AnimationController animationController;
  late Animation<double> zoomAnimation;
  late Animation<Offset> panAnimation;
  late Animation<double> rotationAnimation;
  late Animation<double> tiltAnimation;
  late Animation<double> orbitAnimation;
  
  // 动画参数
  final RxDouble zoomValue = 1.0.obs;
  final Rx<Offset> panValue = const Offset(0, 0).obs;
  final RxDouble rotationValue = 0.0.obs;
  final RxDouble tiltValue = 0.0.obs;
  final RxDouble orbitValue = 0.0.obs;
  
  // 动画状态
  final RxBool isAnimating = false.obs;
  final RxString currentAnimationType = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
  }
  
  void _initializeAnimations() {
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    // 推拉镜头动画
    zoomAnimation = Tween<double>(
      begin: 1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    
    // 平移镜头动画
    panAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0.2, 0.1),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    
    // 旋转镜头动画
    rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    
    // 倾斜镜头动画
    tiltAnimation = Tween<double>(
      begin: 0.0,
      end: 0.3,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    
    // 环绕镜头动画
    orbitAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    
    // 监听动画状态
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        isAnimating.value = false;
        currentAnimationType.value = '';
      }
    });
  }
  
  // 选择图片
  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      
      if (image != null) {
        selectedImage.value = image;
        resetAnimations();
        Get.snackbar('成功', '图片选择成功！');
      }
    } catch (e) {
      Get.snackbar('错误', '选择图片失败: $e');
    }
  }
  
  // 拍照
  Future<void> takePhoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      
      if (image != null) {
        selectedImage.value = image;
        resetAnimations();
        Get.snackbar('成功', '拍照成功！');
      }
    } catch (e) {
      Get.snackbar('错误', '拍照失败: $e');
    }
  }
  
  // 重置所有动画
  void resetAnimations() {
    zoomValue.value = 1.0;
    panValue.value = const Offset(0, 0);
    rotationValue.value = 0.0;
    tiltValue.value = 0.0;
    orbitValue.value = 0.0;
    animationController.reset();
  }
  
  // 推拉镜头动画
  void startZoomAnimation() {
    if (selectedImage.value == null) {
      Get.snackbar('提示', '请先选择一张图片');
      return;
    }
    
    currentAnimationType.value = 'zoom';
    isAnimating.value = true;
    
    zoomAnimation = Tween<double>(
      begin: zoomValue.value,
      end: zoomValue.value * 2.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    
    animationController.forward().then((_) {
      animationController.reverse();
    });
  }
  
  // 平移镜头动画
  void startPanAnimation() {
    if (selectedImage.value == null) {
      Get.snackbar('提示', '请先选择一张图片');
      return;
    }
    
    currentAnimationType.value = 'pan';
    isAnimating.value = true;
    
    panAnimation = Tween<Offset>(
      begin: panValue.value,
      end: Offset(panValue.value.dx + 0.2, panValue.value.dy + 0.1),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    
    animationController.forward().then((_) {
      animationController.reverse();
    });
  }
  
  // 旋转镜头动画
  void startRotationAnimation() {
    if (selectedImage.value == null) {
      Get.snackbar('提示', '请先选择一张图片');
      return;
    }
    
    currentAnimationType.value = 'rotation';
    isAnimating.value = true;
    
    rotationAnimation = Tween<double>(
      begin: rotationValue.value,
      end: rotationValue.value + 0.5,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    
    animationController.forward().then((_) {
      animationController.reverse();
    });
  }
  
  // 倾斜镜头动画
  void startTiltAnimation() {
    if (selectedImage.value == null) {
      Get.snackbar('提示', '请先选择一张图片');
      return;
    }
    
    currentAnimationType.value = 'tilt';
    isAnimating.value = true;
    
    tiltAnimation = Tween<double>(
      begin: tiltValue.value,
      end: tiltValue.value + 0.3,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    
    animationController.forward().then((_) {
      animationController.reverse();
    });
  }
  
  // 环绕镜头动画
  void startOrbitAnimation() {
    if (selectedImage.value == null) {
      Get.snackbar('提示', '请先选择一张图片');
      return;
    }
    
    currentAnimationType.value = 'orbit';
    isAnimating.value = true;
    
    orbitAnimation = Tween<double>(
      begin: orbitValue.value,
      end: orbitValue.value + 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    
    animationController.forward().then((_) {
      animationController.reverse();
    });
  }
  
  // 停止动画
  void stopAnimation() {
    animationController.stop();
    isAnimating.value = false;
    currentAnimationType.value = '';
  }
  
  // 手动控制参数
  void updateZoom(double value) {
    zoomValue.value = value;
  }
  
  void updatePan(Offset value) {
    panValue.value = value;
  }
  
  void updateRotation(double value) {
    rotationValue.value = value;
  }
  
  void updateTilt(double value) {
    tiltValue.value = value;
  }
  
  void updateOrbit(double value) {
    orbitValue.value = value;
  }
  
  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
