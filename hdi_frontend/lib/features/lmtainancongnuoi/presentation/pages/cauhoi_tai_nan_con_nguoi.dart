import 'package:flutter/material.dart';

import '../../../../app/theme/app_color.dart';

class CauhoiTaiNanConNguoi extends StatefulWidget {
  @override
  State<CauhoiTaiNanConNguoi> createState() => _CauhoiTaiNanConNguoiState();
}

class _CauhoiTaiNanConNguoiState extends State<CauhoiTaiNanConNguoi> {
  int? _openedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    double fixedHeight = MediaQuery.of(context).size.height * 0.9;
    return Container(
      height: fixedHeight,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: isDark ? AppColor.containerDark : AppColor.containerLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48), 
                Text(
                  "Câu hỏi",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: isDark ? AppColor.textDark : AppColor.textLight),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 28,color: AppColor.iconColor,),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildQuestionTile(
                  0,
                  "Tôi có thể mua bảo hiểm với thời hạn bảo hiểm là bao lâu?",
                  "Thời hạn chuẩn của bảo hiểm này là 1 năm và sẽ được tái tục bảo hiểm hàng năm nếu Quý khách có nhu cầu. Trường hợp Quý khách muốn mua bảo hiểm với thời hạn dưới 1 năm hoặc trên 1 năm, Quý khách vui lòng liên hệ trực tiếp với Bảo hiểm HD để được tư vấn.",
                ),
                _buildQuestionTile(1, "Tôi có cần kiểm tra sức khỏe khi tham gia bảo hiểm không?", "Nội dung trả lời câu hỏi..."),
                _buildQuestionTile(2, "Tôi có thể mua bảo hiểm ở đâu?", "Nội dung trả lời câu hỏi..."),
                _buildQuestionTile(3, "Thời gian chờ trong bảo hiểm sức khoẻ là gì?", "Nội dung trả lời câu hỏi..."),
                _buildQuestionTile(4, "Phí bảo hiểm có bị thay đổi trong thời hạn bảo hiểm không?", "Nội dung trả lời câu hỏi..."),
                _buildQuestionTile(5, "Tôi có phải đóng thêm khoản phí/ lệ phí nào ngoài phí bảo hiểm không?", "Nội dung trả lời câu hỏi..."),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionTile(int index, String question, String answer) {
    bool isOpen = _openedIndex == index;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColor.containerDark : AppColor.containerLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isOpen ? AppColor.appButtonColor : Colors.grey.shade200,
          width: isOpen ? 1.5 : 1,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: GlobalKey(),
          initiallyExpanded: isOpen,
          title: Text(question, style: TextStyle(fontSize: 16, color: Color(0xFF1E552A), fontWeight: FontWeight.w500)),
          onExpansionChanged: (expanded) {
            setState(() {
              _openedIndex = expanded ? index : null;
            });
          },
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("✦ ", style: TextStyle(color:Color(0xFF1E552A))),
                  Expanded(
                    child: Text(answer, style: TextStyle(fontSize: 14, height: 1.5, color: isDark ? AppColor.textDark : AppColor.textLight),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}