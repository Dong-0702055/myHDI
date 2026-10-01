import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/text_button_app.dart';
import '../widgets/tientrinh.dart';
import 'thanhtoanthanhcong.dart';

class ThanhToanScreen extends StatefulWidget {
  final Map<String, dynamic> dataPacket;
  const ThanhToanScreen({super.key, required this.dataPacket});

  @override
  State<ThanhToanScreen> createState() => _ThanhToanScreenState();
}

class _ThanhToanScreenState extends State<ThanhToanScreen> {
  int selectedMethod = 0;
  Timer? _timer;
  int _startSeconds = 1800;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_startSeconds == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _startSeconds--;
        });
      }
    });
  }

  String _getFormattedMinutes() {
    int minutes = _startSeconds ~/ 60;
    return minutes.toString().padLeft(2, '0');
  }

  String _getFormattedSeconds() {
    int seconds = _startSeconds % 60;
    return seconds.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Map<String, dynamic> safeData = Map<String, dynamic>.from(widget.dataPacket);
    final Map<String, dynamic> goiBaoHiem = Map<String, dynamic>.from(safeData['sanPham'] ?? {});
    final String soTienThanhToan = goiBaoHiem['price'] ?? "1.695.000 VNĐ";
    final String tenKhachHang = safeData['name'] ?? "Khách hàng";
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5),
      appBar: AppBarHome("Thanh toán đơn hàng"),
      body: Column(
        children: [
          Tientrinh(trangThai: const [true, true, true, true, true, true, true]),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark ? AppColor.containerDark : AppColor.containerLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade100),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Image.asset("assets/image/image_thanhtoan.png"),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Text(
                                "Gói thanh toán bảo hiểm sẽ hết hạn sau ",
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                                style: TextStyle(
                                    color: isDark ? Colors.blue.shade300 : Colors.blue,
                                    fontSize: 13,
                                    height: 1.4
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _buildCountdownBox(_getFormattedMinutes(), isDark),
                                Text(
                                    " : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isDark ? Colors.blue.shade300 : Colors.blue
                                    )
                                ),
                                _buildCountdownBox(_getFormattedSeconds(), isDark),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Divider(height: 1, thickness: 1, color: isDark ? Colors.white10 : const Color(0xFFF5F5F5)),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Khách hàng:", style: TextStyle(color: Colors.grey, fontSize: 13)),
                            Text(
                              tenKhachHang,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                color: isDark ? AppColor.textDark : AppColor.textLight
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Số tiền thanh toán", style: TextStyle(color: Colors.grey, fontSize: 13)),
                            Text(
                              soTienThanhToan,
                              style: TextStyle(
                                  color: isDark ? Colors.red.shade400 : Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  Text(
                    "Phương thức thanh toán",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      color: isDark ? AppColor.textDark : AppColor.textLight,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildPaymentMethodTile(
                    index: 0,
                    title: "Thẻ ghi nợ/Tín dụng",
                    isDark: isDark,
                    subtitleWidget: Row(
                      children: [
                        Text("Visa ", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 12, color: isDark ? Colors.blue.shade300 : Colors.blue)),
                        Text("mastercard ", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 12, color: Colors.orange.shade800)),
                        Text("PayPal", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 12, color: isDark ? Colors.blueAccent.shade100 : Colors.blueAccent)),
                      ],
                    ),
                  ),
                  _buildPaymentMethodTile(
                    index: 1,
                    title: "Thẻ ATM/ Tài khoản ngân hàng",
                    isDark: isDark,
                    trailingIcon: Icons.add_to_home_screen_outlined,
                  ),
                  _buildPaymentMethodTile(
                    index: 2,
                    title: "Ứng dụng di động",
                    isDark: isDark,
                    trailingIcon: Icons.qr_code_scanner_outlined,
                  ),
                ],
              ),
            ),
          ),

          // --- BOTTOM BAR CHỨA NÚT THANH TOÁN ---
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
                child: TextButtonApp(
                  "Thanh toán",
                  _startSeconds > 0 ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThanhToanThanhCongScreen(
                          tenKhachHang: tenKhachHang,
                        ),
                      ),
                    );
                  } : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Thay đổi màu nền khối đếm ngược dịu mắt hơn trong Dark Mode
  Widget _buildCountdownBox(String time, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF152637) : const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: isDark ? Colors.blue.shade900 : const Color(0xFF90CAF9)),
      ),
      child: Text(
        time,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: isDark ? Colors.blue.shade300 : Colors.blue
        ),
      ),
    );
  }

  // Tối ưu hóa màu sắc cho Thẻ lựa chọn phương thức thanh toán
  Widget _buildPaymentMethodTile({
    required int index,
    required String title,
    required bool isDark,
    Widget? subtitleWidget,
    IconData? trailingIcon,
  }) {
    bool isSelected = selectedMethod == index;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColor.containerDark : AppColor.containerLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: isSelected ? AppColor.appButtonColor : (isDark ? Colors.white10 : Colors.grey.shade200),
            width: 1.2
        ),
      ),
      child: ListTile(
        onTap: () {
          setState(() {
            selectedMethod = index;
          });
        },
        leading: Radio<int>(
          value: index,
          groupValue: selectedMethod,
          activeColor: AppColor.appButtonColor,
          onChanged: (value) {
            setState(() {
              selectedMethod = value!;
            });
          },
        ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            color: isDark ? AppColor.textDark : AppColor.textLight,
          ),
        ),
        subtitle: subtitleWidget,
        trailing: trailingIcon != null
            ? Icon(trailingIcon, color: isDark ? Colors.green.shade400 : const Color(0xFF0A7029), size: 20)
            : null,
      ),
    );
  }
}