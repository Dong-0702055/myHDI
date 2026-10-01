import 'package:flutter/material.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../core/widgets/text_button_app.dart';
import 'home_tai_nan_con_nguoi.dart';

class ThanhToanThanhCongScreen extends StatelessWidget {
  final String tenKhachHang;
  const ThanhToanThanhCongScreen({Key? key, required this.tenKhachHang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? const [Color(0xFF0D2B15), Color(0xFF1F2E0E)] // Màu Gradient tối trầm, sang trọng cho Dark Mode
                : const [Color(0xFF1E552A), Color(0xFFBDD753)], // Màu Gradient sáng nguyên bản
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? AppColor.containerDark : AppColor.containerLight,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isDark
                          ? [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]
                          : null,
                    ),
                    padding: const EdgeInsets.all(24),
                    margin: const EdgeInsets.only(top: 168),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          "Thanh toán thành công",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColor.textDark : AppColor.textLight,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Chào mừng Quý khách $tenKhachHang đã tham gia Bảo hiểm HD",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? AppColor.textDark : AppColor.textLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Để xem giấy chứng nhận bảo hiểm của bạn, vui lòng đăng nhập vào Cổng thông tin khách hàng hoặc kiểm tra email đã đăng ký",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: TextButtonApp("Quay về trang chủ", () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeTaiNanConNguoi()),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                Image.asset("assets/image/image_hoatietthanhtoan1.png"),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 160),
                    Text(
                      "Kết quả giao dịch",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 150),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: isDark ? AppColor.containerDark : AppColor.containerLight,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: isDark ? Colors.green.shade400 : Colors.green,
                        size: 64,
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: const EdgeInsets.only(top: 650),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset("assets/image/image_hoatietthanhtoan2.png"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}