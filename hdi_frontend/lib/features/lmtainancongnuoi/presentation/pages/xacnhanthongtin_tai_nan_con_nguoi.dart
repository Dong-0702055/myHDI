import 'package:flutter/material.dart';
import 'package:my_hdi/features/lmtainancongnuoi/presentation/pages/xacnhanthongtinlast.dart';

import '../../../../app/theme/app_color.dart';
import '../../../../core/widgets/app_bar.dart';
import '../widgets/tientrinh.dart';


class XacNhanThongTinScreen extends StatefulWidget {
  final Map<String, dynamic> dataPacket; // Nhận gói dữ liệu truyền sang từ màn hình trước

  const XacNhanThongTinScreen({super.key, required this.dataPacket});

  @override
  State<XacNhanThongTinScreen> createState() => _XacNhanThongTinScreenState();
}
class _XacNhanThongTinScreenState extends State<XacNhanThongTinScreen> {
  bool isExpanded = false;
  String selectedAnswer = "";

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5),
      appBar: AppBarHome("Xác nhận thông tin"),
      body: Column(
        children: [
          Tientrinh(trangThai: const [true, true, true, true, true, false, false]),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHealthQuestionCard(isDark),
                  const SizedBox(height: 16),
                  _buildLegalCommitmentBlock(isDark),
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
                height: 50,
                child: ElevatedButton(
                  onPressed: selectedAnswer.isNotEmpty ? () {
                    try {
                      final Map<String, dynamic> cleanDataPacket = Map<String, dynamic>.from(widget.dataPacket);
                      if (cleanDataPacket['sanPham'] != null) {
                        cleanDataPacket['sanPham'] = Map<String, dynamic>.from(cleanDataPacket['sanPham']);
                      }
                      if (cleanDataPacket['invoiceData'] != null && cleanDataPacket['invoiceData'] is Map) {
                        cleanDataPacket['invoiceData'] = Map<String, dynamic>.from(cleanDataPacket['invoiceData']);
                      }
                      cleanDataPacket['healthDeclaration'] = selectedAnswer;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => XacNhanThongTinThanhToan(
                            dataPacket: cleanDataPacket,
                          ),
                        ),
                      );
                    } catch (e) {
                      print("Lỗi đóng gói dữ liệu: $e");
                    }
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.appButtonColor,
                    disabledBackgroundColor: isDark ? Colors.white10 : Colors.grey.shade300,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    "Tiếp tục",
                    style: TextStyle(
                        color: selectedAnswer.isNotEmpty
                            ? Colors.white
                            : (isDark ? Colors.white38 : Colors.grey.shade600),
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // === KHỐI KHAI BÁO SỨC KHỎE ===
  Widget _buildHealthQuestionCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColor.containerDark : AppColor.containerLight,
        borderRadius: BorderRadius.circular(12),
        // Đổi viền sang màu trắng mờ mỏng (white10) ở Dark Mode giúp thanh lịch, dịu mắt hơn
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Người tham gia bảo hiểm có thuộc một trong các đối tượng sau đây?",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: isDark ? AppColor.textDark : AppColor.textLight,),
          ),
          const SizedBox(height: 12),
          Text(
            "1. Người đang mắc bệnh tâm thần, bệnh ung thư, bệnh phong\n"
                "2. Người bị thương tật vĩnh viễn từ 70% trở lên\n"
                "3. Người đang trong thời gian điều trị bệnh tật, thương tật",
            style: TextStyle(fontSize: 13, color: isDark ? AppColor.textDark : AppColor.textLight, height: 1.5),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              InkWell(
                onTap: () => setState(() => selectedAnswer = "Có"),
                borderRadius: BorderRadius.circular(4),
                child: Row(
                  children: [
                    Radio<String>(
                      value: "Có",
                      groupValue: selectedAnswer,
                      activeColor: AppColor.appButtonColor,
                      onChanged: (val) => setState(() => selectedAnswer = val!),
                    ),
                    Text("Có", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: isDark ? AppColor.textDark : AppColor.textLight,)),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              InkWell(
                onTap: () => setState(() => selectedAnswer = "Không"),
                borderRadius: BorderRadius.circular(4),
                child: Row(
                  children: [
                    Radio<String>(
                      value: "Không",
                      groupValue: selectedAnswer,
                      activeColor: AppColor.appButtonColor,
                      onChanged: (val) => setState(() => selectedAnswer = val!),
                    ),
                    Text("Không", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: isDark ? AppColor.textDark : AppColor.textLight,)),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // === KHỐI CAM KẾT PHÁP LÝ ===
  Widget _buildLegalCommitmentBlock(bool isDark) {
    final Color normalTextColor = isDark ? AppColor.textDark : AppColor.textLight;
    final Color boldTextColor = isDark ? AppColor.textDark : AppColor.textLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "Bằng việc nhấn nút ",
            style: TextStyle(color: normalTextColor, fontSize: 12, height: 1.4),
            children: [
              TextSpan(text: "“TIẾP TỤC”", style: TextStyle(fontWeight: FontWeight.bold, color: boldTextColor)),
              const TextSpan(text: " đồng nghĩa với việc Bên mua bảo hiểm xác nhận và cam kết:"),
            ],
          ),
        ),
        const SizedBox(height: 8),

        AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRichTextSpan(isDark, "a) Các thông tin được khai báo, cung cấp là đúng sự thật và hoàn toàn chịu trách nhiệm trước pháp luật. Đồng thời, Bên mua bảo hiểm đã đọc, hiểu và đồng ý với điều kiện, điều khoản và quy tắc của ", "Bảo hiểm HD."),
              const SizedBox(height: 8),
              _buildRichTextSpan(isDark, "b) Người được bảo hiểm hoặc người đại diện hợp pháp của người được bảo hiểm đồng ý về nội dung yêu cầu bảo hiểm, số tiền bảo hiểm, người thụ hưởng theo quy định của pháp luật.", ""),
              const SizedBox(height: 8),
              _buildRichTextSpan(isDark, "c) Tôi/chúng tôi cùng những người/các bên có quyền lợi và nghĩa vụ liên quan đồng ý các nội dung ", "Điều khoản và điều kiện chung về bảo vệ và xử lý dữ liệu cá nhân", " của Bảo hiểm HD."),
            ],
          ),
          secondChild: _buildRichTextSpan(isDark, "a) Các thông tin được khai báo, cung cấp là đúng sự thật và hoàn toàn chịu trách nhiệm trước pháp luật. Đồng thời, Bên mua bảo hiểm đã đọc, hiểu và đồng ý với điều kiện, điều khoản và quy tắc...", ""),
        ),

        Center(
          child: TextButton.icon(
            onPressed: () => setState(() => isExpanded = !isExpanded),
            icon: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: AppColor.appButtonColor,
              size: 18,
            ),
            label: Text(
              isExpanded ? "Thu gọn" : "Xem tất cả",
              style: const TextStyle(color: AppColor.appButtonColor, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRichTextSpan(bool isDark, String normalText, String highlightText, [String trailingText = ""]) {
    return RichText(
      text: TextSpan(
        text: normalText,
        style: TextStyle(color: isDark ? AppColor.textDark : AppColor.textLight, fontSize: 12, height: 1.5),
        children: [
          if (highlightText.isNotEmpty)
            TextSpan(
              text: highlightText,
              style: const TextStyle(color: AppColor.appButtonColor, fontWeight: FontWeight.w500),
            ),
          if (trailingText.isNotEmpty)
            TextSpan(text: trailingText),
        ],
      ),
    );
  }
}