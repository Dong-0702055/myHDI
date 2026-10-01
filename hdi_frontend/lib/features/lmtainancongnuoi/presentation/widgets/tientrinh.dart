import 'package:flutter/material.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../app/theme/app_theme.dart';


class Tientrinh extends StatelessWidget {
  final List<bool> trangThai;
  const Tientrinh({
    super.key,
    required this.trangThai,
  });
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isDarkMode,
        builder: (context, isDark, child){
          return Container(
            color: isDark ? AppColor.containerDark: AppColor.containerLight,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStepNode(context, isDark, "1", "Chọn gói\nsức khoẻ", isCompleted: trangThai[0], isActive: !trangThai[0]),
                _buildStepLine(isDark, isCompleted: trangThai[1]),
                _buildStepNode(context, isDark, "2", "Người được\nbảo hiểm", isCompleted: trangThai[2], isActive: trangThai[0] && !trangThai[2]),
                _buildStepLine(isDark, isCompleted: trangThai[3]),
                _buildStepNode(context, isDark, "3", "Xác nhận\nthông tin", isCompleted: trangThai[4], isActive: trangThai[2] && !trangThai[4]),
                _buildStepLine(isDark, isCompleted: trangThai[5]),
                _buildStepNode(context, isDark, "4", "Thanh toán", isCompleted: false, isActive: trangThai[6]),
              ],
            ),
          );
        }
    );
  }
  Widget _buildStepNode(BuildContext context, bool isDark, String number, String title, {bool isCompleted = false, bool isActive = false}) {
    Color circleColor = isDark ? Colors.white10 : Colors.grey.shade300;
    Color textColor =  Colors.white;

    if (isCompleted || isActive) {
      circleColor = const Color(0xFF0A7029);
      textColor = Colors.white;
    }
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: circleColor,
            child: Text(
              number,
              style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10,
                color: isDark ? (isActive ? Colors.amber : Colors.white70) : (isActive ? Colors.black : Colors.black54),
                fontWeight: (isActive || isCompleted) ? FontWeight.bold : FontWeight.w400,
                height: 1.2
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepLine(bool isDark, {required bool isCompleted}) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(top: 11),
        color: isCompleted
            ? const Color(0xFF0A7029)
            : (isDark ? Colors.white10 : Colors.grey.shade300),
      ),
    );
  }
}