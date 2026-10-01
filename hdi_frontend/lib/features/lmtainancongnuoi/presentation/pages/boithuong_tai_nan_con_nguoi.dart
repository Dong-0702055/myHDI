import 'package:flutter/material.dart';

import '../../../../app/theme/app_color.dart';

class BoiThuongModal extends StatefulWidget {
  const BoiThuongModal({super.key});
  @override
  State<BoiThuongModal> createState() => _BoiThuongModalState();
}
class _BoiThuongModalState extends State<BoiThuongModal> {
  bool _isExpanded = true;
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48),
                Text(
                  "Bồi thường",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? AppColor.textDark : AppColor.textLight),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 28, color: AppColor.iconColor,),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isExpanded ? AppColor.appButtonColor : Colors.grey.shade300,
                  width: _isExpanded ? 2 : 1,
                ),
              ),
              child: ExpansionTile(
                initiallyExpanded: true,
                shape: const Border(),
                title: Text(
                  "Quy trình xử lý bồi thường",
                  style: TextStyle(
                    color: _isExpanded ? Colors.red : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.blue,
                ),
                onExpansionChanged: (val) => setState(() => _isExpanded = val),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildStep(
                            "assets/image/boithuong1.png",
                            "1. Thanh toán và thu thập",
                            "Liên hệ thông báo tổn thất với HDI trong thời gian sớm nhất không muộn hơn 30 ngày xảy ra tai nạn."
                        ),
                        _buildStep(
                            "assets/image/boithuong2.png",
                            "2. Nộp hồ sơ",
                            "Nộp hồ sơ yêu cầu bồi thường trong vòng 30 ngày kể từ ngày khám chữa bệnh đầu tiên."
                        ),
                        _buildStep(
                            "assets/image/boithuong3.png",
                            "3. Giải quyết yêu cầu",
                            "HDI giải quyết hồ sơ và hoàn trả chi phí khám chữa bệnh trong vòng 15 ngày làm việc."
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Xem chi tiết", style: TextStyle(
                                      color: AppColor.appButtonColor, fontWeight: FontWeight.bold
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_down, color: AppColor.appButtonColor),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildStep(String img, String title, String desc) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(img, width: 50, height: 50, errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 50, color: Colors.grey)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Color(0xFF055E20), fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text(desc, style: TextStyle(fontSize: 13, height: 1.4,color: isDark ? AppColor.textDark : AppColor.textLight)),
              ],
            ),
          )
        ],
      ),
    );
  }
}