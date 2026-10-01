import 'package:flutter/material.dart';

class Clause extends StatefulWidget {
  const Clause({super.key});

  @override
  State<Clause> createState() => _ClauseState();
}

class _ClauseState extends State<Clause> {
  final List<Map<String, String>> _policyData = [
    {
      "title": "Giải thích từ ngữ",
      "content": "Chính sách bảo mật và chia sẻ thông tin này điều chỉnh việc bạn truy cập vào Nền tảng Dịch vụ và Dịch vụ của Bảo hiểm HD."
    },
    {
      "title": "Cấp phép sử dụng Nền Tảng Dịch Vụ:",
      "content": "Bảo hiểm HD cấp cho bạn quyền truy cập có giới hạn, không độc quyền để sử dụng dịch vụ cho mục đích cá nhân."
    },
    {
      "title": "Truy cập và/hoặc sử dụng Dịch Vụ:",
      "content": "Bạn cam kết cung cấp thông tin chính xác và chịu trách nhiệm về mọi hoạt động dưới tài khoản của mình."
    },
    {
      "title": "Quyền Sở Hữu Trí Tuệ:",
      "content": "Mọi nội dung, nhãn hiệu và logo hiển thị trên ứng dụng đều thuộc sở hữu của Bảo hiểm HD."
    },
    {
      "title": "Điều Khoản Chung:",
      "content": "Các điều khoản này được điều chỉnh bởi pháp luật Việt Nam. Mọi tranh chấp sẽ được giải quyết tại tòa án có thẩm quyền."
    },
  ];

  int? _expandedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text("Bảo mật và chia sẻ thông tin",
            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Chính sách bảo mật và chia sẻ thông tin này điều chỉnh việc bạn truy cập vào Nền Tảng Dịch Vụ và Dịch Vụ của Bảo hiểm HD.",
              style: TextStyle(color: Colors.green, fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 16),

            // 3. Sử dụng map để tự động tạo danh sách các ô ExpansionTile
            ..._policyData.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> data = entry.value;
              bool isThisExpanded = _expandedIndex == index;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isThisExpanded ? const Color(0xFFBB8A0B) : Colors.grey[200]!,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    onExpansionChanged: (expanded) {
                      setState(() {
                        _expandedIndex = expanded ? index : null;
                      });
                    },
                    leading: const ImageIcon(
                      AssetImage("assets/icons/book-saved.png"),
                      color: Color(0xFFBB8A0B),
                      size: 24,
                    ),
                    title: Text(
                      data["title"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    trailing: Icon(
                      isThisExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          data["content"]!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}