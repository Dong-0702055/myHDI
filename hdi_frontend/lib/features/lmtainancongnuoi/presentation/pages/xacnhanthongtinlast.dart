import 'package:flutter/material.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/text_button_app.dart';
import '../widgets/tientrinh.dart';
import 'thanhtoan_tai_nan_con_nguoi.dart';

class XacNhanThongTinThanhToan extends StatelessWidget {
  final Map<String, dynamic> dataPacket;
  const XacNhanThongTinThanhToan({super.key, required this.dataPacket});

  String _formatDynamicDate(dynamic dateKey) {
    if (dateKey == null) return "Chưa nhập";
    if (dateKey is DateTime) {
      return "${dateKey.day.toString().padLeft(2, '0')}/${dateKey.month.toString().padLeft(2, '0')}/${dateKey.year}";
    }
    return dateKey.toString();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Map<String, dynamic> safeData = Map<String, dynamic>.from(dataPacket);
    final Map<String, dynamic> goiBaoHiem = Map<String, dynamic>.from(safeData['sanPham'] ?? {});

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5),
      appBar: AppBarHome("Thông tin người được bảo hiểm"),
      body: Column(
        children: [
          Tientrinh(trangThai: const [true, true, true, true, true, true, true]),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildProductSummaryCard(goiBaoHiem, isDark),
                  const SizedBox(height: 16),
                  _buildCustomerDetailsCard(context, safeData, isDark),
                  const SizedBox(height: 12),
                  _buildSampleCertificateRow(isDark),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColor.containerDark : AppColor.containerLight,
              border: Border(top: BorderSide(color: isDark ? Colors.white10 : Colors.grey.shade200)),
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: TextButtonApp("Thanh toán", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThanhToanScreen(
                        dataPacket: safeData,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductSummaryCard(Map<String, dynamic> goiBaoHiem, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColor.containerDark : AppColor.containerLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              goiBaoHiem['image'] ?? 'assets/image/baohiem6.png',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 48,
                height: 48,
                color: isDark ? Colors.blue.shade900.withOpacity(0.3) : Colors.blue.shade100,
                child: Icon(Icons.shield, color: isDark ? Colors.blue.shade400 : Colors.blue),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bảo hiểm tai nạn con người",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColor.textDark : AppColor.textLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "x1 ${goiBaoHiem['title'] ?? 'Gói cơ bản'}",
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  goiBaoHiem['price'] ?? "0 VNĐ",
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.red.shade400 : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerDetailsCard(BuildContext context, Map<String, dynamic> personalData, bool isDark) {
    String thoiHanBaoHiem = "Chưa xác định";
    if (personalData['startDate'] != null && personalData['endDate'] != null) {
      String start = _formatDynamicDate(personalData['startDate']);
      String end = _formatDynamicDate(personalData['endDate']);
      thoiHanBaoHiem = "$start - $end";
    }

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColor.containerDark : AppColor.containerLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Người được bảo hiểm",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColor.textDark : AppColor.textLight,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Chỉnh sửa",
                    style: TextStyle(fontSize: 13, color: AppColor.appButtonColor, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: isDark ? Colors.white10 : const Color(0xFFF5F5F5)),
          _buildInfoRow("Họ tên:", personalData['name'] ?? "Chưa nhập", isDark),
          _buildInfoRow("Ngày sinh:", _formatDynamicDate(personalData['birthDate']), isDark),
          _buildInfoRow("Giới tính:", personalData['gender'] ?? "Chưa nhập", isDark),
          _buildInfoRow("CMND/CCCD/Hộ Chiếu:", personalData['idNumber'] ?? "Chưa nhập", isDark),
          _buildInfoRow("Số điện thoại:", personalData['phone'] ?? "Chưa nhập", isDark),
          _buildInfoRow("Email:", personalData['email'] ?? "Chưa nhập", isDark),
          _buildInfoRow("Thời hạn bảo hiểm:", thoiHanBaoHiem, isDark),

          Divider(height: 1, thickness: 1, color: isDark ? Colors.white10 : const Color(0xFFF5F5F5)),

          InkWell(
            onTap: () {},
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Xem chi tiết quyền lợi ",
                    style: TextStyle(color: AppColor.appButtonColor, fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 12, color: AppColor.appButtonColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- DÒNG THÔNG TIN CHI TIẾT ---
  Widget _buildInfoRow(String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? AppColor.textDark : AppColor.textLight,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- THANH XEM GIẤY CHỨNG NHẬN MẪU ---
  Widget _buildSampleCertificateRow(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? AppColor.containerDark : AppColor.containerLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/icons/icon_doc.png',
            width: 20,
            height: 20,
            errorBuilder: (c, e, s) => const Icon(Icons.description, color: Colors.grey, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Xem giấy chứng nhận mẫu",
              style: TextStyle(
                fontSize: 13,
                color: isDark ? AppColor.textDark : AppColor.textLight,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward, size: 18, color: Colors.grey),
        ],
      ),
    );
  }
}