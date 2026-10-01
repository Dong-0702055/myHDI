import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../../../../app/theme/app_color.dart';


class ScanCameraScreen extends StatefulWidget {
  const ScanCameraScreen({super.key});

  @override
  State<ScanCameraScreen> createState() => _ScanCameraScreenState();
}

class _ScanCameraScreenState extends State<ScanCameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // Khởi tạo camera thiết bị
  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      // Chọn camera sau (Rear Camera)
      _controller = CameraController(
        _cameras![0],
        ResolutionPreset.high,
        enableAudio: false, // Tắt âm thanh để tối ưu tốc độ
      );

      try {
        await _controller!.initialize();
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      } catch (e) {
        print("Lỗi khởi tạo Camera: $e");
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose(); // Giải phóng vùng nhớ camera khi thoát
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized || _controller == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PositionfulCameraPreview(_controller!),
          _buildCameraOverlay(context),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // 4. Các nút bấm chụp hình ở phía dưới cùng
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gợi ý "Bấm để chụp" dạng Tooltip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Bấm để chụp",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 12),
                // Nút chụp hình tròn viền vàng trắng
                GestureDetector(
                  onTap: _takePicture,
                  child: Container(
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColor.appButtonColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 28),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget vẽ khung đen mờ và chừa trống ô vuông giữa màn hình
  Widget _buildCameraOverlay(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double cardWidth = width * 0.85;
    double cardHeight = cardWidth * 0.63; // Tỷ lệ chuẩn của thẻ CMND/CCCD

    return Stack(
      children: [
        // Sử dụng ColorFiltered để đục lỗ màn hình một cách mượt mà nhất
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6), // Độ mờ của vùng bên ngoài
            BlendMode.srcOut,
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              // Vị trí và kích thước của ô vuông đục lỗ scan
              Align(
                alignment: const Alignment(0, -0.2),
                child: Container(
                  height: cardHeight,
                  width: cardWidth,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: const Alignment(0, -0.2),
          child: SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: Stack(
              children: [
                Positioned(
                  top: -50,
                  left: 0,
                  right: 0,
                  child: const Text(
                    "Hãy đặt chứng từ trên mặt phẳng và đảm bảo hình\nchụp không bị mờ, tối hoặc chói sáng",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontWeight: FontWeight.w400),
                  ),
                ),
                // 4 Góc vuông màu trắng bao quanh
                Positioned(top: 0, left: 0, child: _buildCorner(top: true, left: true)),
                Positioned(top: 0, right: 0, child: _buildCorner(top: true, left: false)),
                Positioned(bottom: 0, left: 0, child: _buildCorner(bottom: true, left: true)),
                Positioned(bottom: 0, right: 0, child: _buildCorner(bottom: true, left: false)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCorner({bool top = false, bool bottom = false, bool left = false, bool right = false}) {
    double length = 24;
    double thickness = 4;
    return SizedBox(
      width: length,
      height: length,
      child: Stack(
        children: [
          if (top) Positioned(top: 0, left: 0, right: 0, child: Container(height: thickness, color: Colors.white)),
          if (bottom) Positioned(bottom: 0, left: 0, right: 0, child: Container(height: thickness, color: Colors.white)),
          if (left) Positioned(top: 0, bottom: 0, left: 0, child: Container(width: thickness, color: Colors.white)),
          if (right) Positioned(top: 0, bottom: 0, right: 0, child: Container(width: thickness, color: Colors.white)),
        ],
      ),
    );
  }

  // Hàm xử lý chụp ảnh thực tế
  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    try {
      final XFile image = await _controller!.takePicture();
      // Trả file ảnh chụp được về màn hình trước
      if (mounted) {
        Navigator.pop(context, image.path);
      }
    } catch (e) {
      print("Lỗi khi chụp hình: $e");
    }
  }
}

// Widget bọc để ép tỷ lệ khung hình camera không bị méo (Stretch/Distorted)
Widget PositionfulCameraPreview(CameraController controller) {
  return Transform.scale(
    scale: 1.0,
    child: Center(
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      ),
    ),
  );
}