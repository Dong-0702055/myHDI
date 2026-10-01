import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../core/widgets/text_button_app.dart';
import 'goibaohiem_tai_nan_con_nguoi.dart';
class ChonDoTuoiModal extends StatefulWidget {
  @override
  State<ChonDoTuoiModal> createState() => _ChonDoTuoiModalState();
}
class _ChonDoTuoiModalState extends State<ChonDoTuoiModal> {
  String _selectedGender = "Nam";
  int _selectedDay = 2;
  int _selectedMonth = 7;
  int _selectedYear = 2005;
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: isDark ? AppColor.containerDark : AppColor.containerLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4,
              decoration: BoxDecoration(
                  color: isDark ? AppColor.containerDark : AppColor.containerLight,
                  borderRadius: BorderRadius.circular(10))
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48),
                Text("Chọn độ tuổi",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? AppColor.textDark : AppColor.textLight)),
                IconButton(icon:  Icon(Icons.close, size: 28, color: AppColor.iconColor,), onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Giới tính", style: TextStyle(color: Color(0xFF055E20), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildGenderOption("Nam", "assets/image/avatar_male.png"),
                  const SizedBox(height: 10),
                  _buildGenderOption("Nữ", "assets/image/avatar_female.png"),
                  const SizedBox(height: 24),
                  const Text("Ngày sinh", style: TextStyle(color: Color(0xFF055E20), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    "Độ tuổi áp dụng bảo hiểm ${_formatDate()} - ${_calculateAge(_selectedDay, _selectedMonth, _selectedYear)} tuổi",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    child: Row(
                      children: [
                        _buildScrollPicker("Ngày", List.generate(31, (i) => i + 1), (val) => _selectedDay = val),
                        _buildScrollPicker("Tháng", List.generate(12, (i) => i + 1), (val) => _selectedMonth = val),
                        _buildScrollPicker("Năm", List.generate(100, (i) => DateTime.now().year - i), (val) => _selectedYear = val),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButtonApp(
                  "Tiếp tục", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GoibaohiemTaiNanConNguoi()),
                    );
                  })
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String gender, String assetPath) {
    bool isSelected = _selectedGender == gender;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () => setState(() => _selectedGender = gender),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ?  AppColor.appButtonColor : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(assetPath, width: 30, height: 30),
            const SizedBox(width: 12),
            Text(gender, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: isDark ? AppColor.textDark : AppColor.textLight)),
            const Spacer(),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ?  AppColor.appButtonColor : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildScrollPicker(String label, List<int> items, Function(int) onSelected) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: isDark ? AppColor.textDark : AppColor.textLight)),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40,
              scrollController: FixedExtentScrollController(
                  initialItem: items.indexOf(label == "Ngày" ? _selectedDay : (label == "Tháng" ? _selectedMonth : _selectedYear))
              ),
              onSelectedItemChanged: (index) {
                setState(() {
                  onSelected(items[index]);
                });
              },
              selectionOverlay: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColor.appButtonColor, width: 0.5),
                    bottom: BorderSide(color: AppColor.appButtonColor, width: 0.5),
                  ),
                  color: Color(0x11BB8A0B),
                ),
              ),
              children: items.map((e) => Center(
                  child: Text("$e", style: TextStyle(fontSize: 16,color: isDark ? AppColor.textDark : AppColor.textLight))
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
  int _calculateAge(int day, int month, int year) {
    DateTime today = DateTime.now();
    DateTime birthDate = DateTime(year, month, day);
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }
  String _formatDate() {
    String d = _selectedDay < 10 ? "0$_selectedDay" : "$_selectedDay";
    String m = _selectedMonth < 10 ? "0$_selectedMonth" : "$_selectedMonth";
    return "$d/$m/$_selectedYear";
  }
}