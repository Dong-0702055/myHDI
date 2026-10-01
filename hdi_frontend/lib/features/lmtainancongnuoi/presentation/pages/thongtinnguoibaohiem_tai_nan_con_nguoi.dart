import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/text_button_app.dart';
import '../widgets/tientrinh.dart';
import 'goibaohiem_tai_nan_con_nguoi.dart';
import 'nhaptaythontin_tai_nan_con_nguoi.dart';
import 'camera.dart';

class ThongtinnguoibaohiemTaiNanConNguoi extends StatelessWidget {
  final Map<String, dynamic> sanPham;
  const ThongtinnguoibaohiemTaiNanConNguoi({
    super.key,
    required this.sanPham,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHome("Thông tin người được bảo hiểm", duongDan: GoibaohiemTaiNanConNguoi()),
      body: ContentThongTinNguoiBaoHiem(
        sanPham: sanPham,
      ),
    );
  }
}

class ContentThongTinNguoiBaoHiem extends StatelessWidget {
  final Map<String, dynamic> sanPham;
  ContentThongTinNguoiBaoHiem({
    super.key,
    required this.sanPham,
  });
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Tientrinh(trangThai: const [true, true, false, false, false, false, false]),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
              color: isDark ? AppColor.containerDark: AppColor.containerLight,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildInputOption(
                    context,
                    isDark,
                    icon: "assets/icons/icon_camera.png",
                    label: "Chụp ảnh CMND/CCCD/Hộ chiếu",
                    onTap: () async {
                      final String? imagePath = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScanCameraScreen(),
                        ),
                      );
                      if (imagePath != null) {
                        print("Đã chụp thành công! Đường dẫn file ảnh: $imagePath");
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildInputOption(
                    context,
                    isDark,
                    icon: "assets/icons/icon_image_add.png",
                    label: "Tải lên ảnh CMND/CCCD/Hộ chiếu",
                    onTap: pickImage,
                  ),
                  const SizedBox(height: 16),
                  _buildInputOption(
                    context,
                    isDark,
                    icon: "assets/icons/icon_edit.png",
                    label: "Hoặc nhập tay",
                    showArrow: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NhapTayThongTinScreen(sanPham: sanPham),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppColor.containerDark: AppColor.containerLight,
            boxShadow: [
              BoxShadow(color: isDark ? Colors.black38 : Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, -2)),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Bảo hiểm chăm sóc sức", style: TextStyle( color: isDark ? AppColor.textDark: AppColor.textLight, fontSize: 13)),
                        Text("khỏe và tai nạn", style: TextStyle( color: isDark ? AppColor.textDark: AppColor.textLight, fontSize: 13)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${sanPham['title']}",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,  color: isDark ? AppColor.textDark: AppColor.textLight),
                        ),
                        Text(
                          "${sanPham['price']}",
                          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(width: double.infinity, height: 48, child: TextButtonApp("Tiếp tục", () {})),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildInputOption(
      BuildContext context,
      bool isDark, {
        required String icon,
        required String label,
        bool showArrow = false,
        required VoidCallback onTap,
      }) {
    final Color primaryElementColor = isDark ? const Color(0xFFF0B90B) : const Color(0xFF1E552A);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: primaryElementColor, width: 1.2),
          borderRadius: BorderRadius.circular(8),
          color: isDark ? AppColor.containerDark: AppColor.containerLight,
        ),
        child: Row(
          children: [
            ImageIcon(AssetImage(icon), color: primaryElementColor, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryElementColor
                ),
              ),
            ),
            if (showArrow) Icon(Icons.arrow_forward, color: AppColor.iconColor),
          ],
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();
  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        File imageFile = File(image.path);
        print(imageFile.path);
      }
    } catch (e) {
      print("Lỗi chọn ảnh: $e");
    }
  }
}