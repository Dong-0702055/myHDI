import 'package:flutter/material.dart';

import '../../../../app/theme/app_color.dart';
import '../../../../app/theme/app_theme.dart' as AppTheme;
import '../../../../core/widgets/app_bar.dart';
import '../../../auth/login/pages/login_custom.dart';



class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppTheme.isDarkMode,
      builder: (context, isDark, child) {
        return Scaffold(
          backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5),
          appBar: const AppBarHome("Cài đặt tài khoản"),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildSectionTitle("Tài khoản"),
              const SizedBox(height: 8),
              _buildGroupCard(isDark, [
                _buildSettingsItem(context, isDark, Icons.person_outline, "Thông tin tài khoản", onTap: () {}),
                _buildSettingsItem(context, isDark, Icons.face_retouching_natural, "Xác thực khuôn mặt", onTap: () {}),
                _buildSettingsItem(context, isDark, Icons.fingerprint, "Cài đặt vân tay", onTap: () {}),
                _buildSettingsItem(context, isDark, Icons.description_outlined, "Quản lý hợp đồng bảo hiểm", onTap: () {}),
                _buildSettingsItem(context, isDark, Icons.favorite_border, "Sản phẩm bảo hiểm đã lưu", onTap: () {}),
                _buildSettingsItem(context, isDark, Icons.lock_open_outlined, "Đổi mật khẩu", isLast: true, onTap: () {}),
              ]),

              const SizedBox(height: 24),

              _buildSectionTitle("Hỗ trợ và cài đặt"),
              const SizedBox(height: 8),
              _buildGroupCard(isDark, [
                _buildDarkModeSwitchItem(isDark),
                _buildSettingsItem(context, isDark, Icons.g_translate, "Ngôn ngữ", trailingText: "Tiếng Việt", onTap: () {}),
                _buildSettingsItem(context, isDark, Icons.notifications_none, "Cài đặt thông báo", onTap: () {}),
                _buildSettingsItem(context, isDark, Icons.chat_bubble_outline, "Thuật ngữ bảo hiểm", onTap: () {}),
                _buildSettingsItem(context, isDark, Icons.help_outline, "Trung tâm trợ giúp", onTap: () {}),
                _buildSettingsItem(context, isDark, Icons.gavel, "Quy chế hoạt động", onTap: () {}),
                _buildSettingsItem(context, isDark, Icons.info_outline, "Thông tin ứng dụng", isLast: true, onTap: () {}),
              ]),

              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  color: isDark ? AppColor.containerDark : AppColor.containerLight,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2)),
                  ],
                ),
                child: TextButton.icon(
                  onPressed: () => _showLogoutDialog(context),
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    "Đăng xuất",
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDarkModeSwitchItem(bool isDark) {
    return Column(
      children: [
        ListTile(
          dense: true,
          leading: Icon(
            isDark ? Icons.dark_mode : Icons.light_mode,
            color: isDark ? Colors.amber : Colors.black54,
            size: 22,
          ),
          title: Text(
            "Chế độ tối",
            style: TextStyle(fontSize: 14, color: isDark ? AppColor.textDark : AppColor.textLight),
          ),
          trailing: Switch(
            value: isDark,
            activeColor: Colors.green,
            onChanged: (value) {
              AppTheme.isDarkMode.value = value;
            },
          ),
        ),
        Divider(height: 1, indent: 50, endIndent: 16, color: isDark ? Colors.white12 : const Color(0xFFF0F0F0)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(color: Color(0xFFC6890A), fontWeight: FontWeight.bold, fontSize: 15),
    );
  }

  Widget _buildGroupCard(bool isDark, List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColor.containerDark : AppColor.containerLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(children: items),
    );
  }

  Widget _buildSettingsItem(BuildContext context, bool isDark, IconData icon, String title, {String? trailingText, bool isLast = false, required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
          dense: true,
          leading: Icon(icon, color: isDark ? AppColor.textDark : AppColor.textLight, size: 22),
          title: Text(
            title,
            style: TextStyle(fontSize: 14, color: isDark ? AppColor.textDark : AppColor.textLight),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (trailingText != null)
                Text(trailingText, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
            ],
          ),
          onTap: onTap,
        ),
        if (!isLast)
          Divider(height: 1, indent: 50, endIndent: 16, color: isDark ? Colors.white12 : const Color(0xFFF0F0F0)),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Row(
            children: [
              Icon(Icons.logout, color: Colors.red),
              SizedBox(width: 8),
              Text("Đăng xuất", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: const Text("Bạn có chắc chắn muốn đăng xuất khỏi tài khoản này không?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Hủy", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginCustom()));
              },
              child: const Text("Đồng ý", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}