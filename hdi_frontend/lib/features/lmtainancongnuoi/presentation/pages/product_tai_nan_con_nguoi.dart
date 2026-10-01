import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../core/widgets/app_bar.dart';
import 'home_tai_nan_con_nguoi.dart';
class ProductTaiNanConNguoi extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHome("Bảo hiểm tai nạn",duongDan: HomeTaiNanConNguoi()),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextTitle("Tại sao nên mua bảo hiểm chăm sóc sức khỏe và tai nạn?"),
              Layout1(),
              Layout2(),
              SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }

}
class TextTitle extends StatelessWidget{
  final String title;
  TextTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10,right: 30,top: 10),
        child: Text(title,style: TextStyle(fontSize: 18,color: Colors.red),)
    );
  }
}
class Layout1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center, //
        children: [
          _ContainerLayout(
              image: AssetImage("assets/image/layout1.png"),
                text1: "Phí Bảo Hiểm\n     Hợp Lý",
                text2: "Tỷ lệ phí bảo hiểm cạnh tranh nhất thị trường, với gói thấp nhất là 0.2% của số tiền bảo hiểm"
          ),
          _ContainerLayout(
              image: AssetImage("assets/image/layout2.png"),
              text1: "Quyền Lợi Vượt Trội \nThiết Kế Riêng Bạn",
              text2: "Mở rộng quyền lợi ngộ độc thức ăn, đồ uống và bảo hiểm tiền trợ cấp ngày nằm viện."
          ),
          _ContainerLayout(
              image: AssetImage("assets/image/layout3.png"),
              text1: "Bồi Thường Đơn Giản,\n      Nhanh Chóng",
              text2: "Giải quyết bồi thường trực tuyến thuận tiện và nhanh chóng trong vòng 15 ngày làm việc"
          ),
          _ContainerLayout(
              image: AssetImage("assets/image/layout4.png"),
              text1: "Giải Pháp Trực Tuyến\n   Đơn Giản, Dễ Hiểu",
              text2: "Số hoá giấy chứng nhận điện tử, quản lý và gia hạn hợp đồng ngay trên website của HDI."
          )
        ],
      ),
    );
  }
  Widget _ContainerLayout({image,text1,text2}){
    return Container(
      height: 267,
      width: 190,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ]
      ),
      child: Column(
        children: [
          Image(image: image,height: 70,width: 70),
          Column(
              children: [Text(text1,style: TextStyle(fontSize: 14,color: Color(0xFF1E552A)))]
          ),
          Text(text2, style: TextStyle(fontSize: 14))
        ],
      ),
    );
  }
}
class Layout2 extends StatefulWidget {
  const Layout2({super.key});

  @override
  State<Layout2> createState() => _Layout2State();
}
class _Layout2State extends State<Layout2> {
  int? _openedIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Thông tin chi tiết sản phẩm",
            style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildDynamicExpansionTile(0, "Đối tượng tham gia bảo hiểm", [
            const Text("Nội dung chi tiết cho đối tượng tham gia..."),
          ]),
          const SizedBox(height: 12),
          _buildDynamicExpansionTile(1, "Quyền lợi bảo hiểm", [
            const Text("a. Quyền lợi bảo hiểm ốm đau, bệnh tật:",
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildBulletPoint("Chi trả toàn bộ số tiền bảo hiểm cho trường hợp tử vong, thương tật toàn bộ vĩnh viễn;"),
            _buildBulletPoint("Trả tỷ lệ thương tật cho trường hợp thương tật bộ phận vĩnh viễn theo Bảng tỷ lệ trả tiền bảo hiểm kèm theo Quy tắc;"),
            _buildBulletPoint("Trả chi phí y tế cho trường hợp thương tật tạm thời do tai nạn;"),
            _buildBulletPoint("Chi trả tiền trợ cấp trong thời gian nằm viện điều trị thương tật do tai nạn."),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("• ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Expanded(child: Text("Quý khách vui lòng tham khảo quyền lợi bảo hiểm chi tiết của từng gói bảo hiểm.",style: TextStyle(fontWeight: FontWeight.bold),)),
              ],
            ),
          ]),
          const SizedBox(height: 12),
          _buildDynamicExpansionTile(2, "Điểm loại trừ bảo hiểm", [
            const Text("Nội dung các điểm loại trừ chi tiết..."),
          ]),
          _buildDynamicExpansionTile(3, "Tài liệu đính kèm", [
            _buildDownloadItem(
                "Hướng dẫn bồi thường xe cơ giới",
                "https://your-server.com/files/huong-dan-tnds.pdf"
            ),
            _buildDownloadItem(
                "Quy tắc bảo hiểm con người",
                "https://your-server.com/files/quy-tac.pdf"
            ),
            _buildDownloadItem(
                "Mẫu đơn bảo hiểm",
                "https://your-server.com/files/mau-don.docx"
            ),
          ]),

        ],
      ),
    );
  }

  Widget _buildDynamicExpansionTile(int index, String title, List<Widget> children) {
    bool isOpen = _openedIndex == index;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isOpen ?  AppColor.appButtonColor : Colors.grey.shade300,
          width: isOpen ? 1.5 : 1,
        ),
      ),
      child: ExpansionTile(
        key: GlobalKey(),
        initiallyExpanded: isOpen,
        shape: const Border(),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: isOpen ?  AppColor.appButtonColor : Colors.black87,
          ),
        ),
        onExpansionChanged: (bool expanded) {
          setState(() {
            if (expanded) {
              _openedIndex = index;
            } else {
              _openedIndex = null;
            }
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
  Widget _buildDownloadItem(String fileName, String fileUrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset("assets/image/tepdinhkem.png",height: 30,width: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              fileName,
              style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () async {
              final Uri url = Uri.parse(fileUrl);
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                debugPrint('Không thể mở liên kết: $fileUrl');
              }
            },
            child: Column(
              children: const [
                Icon(Icons.file_download_outlined, color: AppColor.appButtonColor, size: 24),
                Text(
                  "Tải tài liệu",
                  style: TextStyle(
                      color: AppColor.appButtonColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}