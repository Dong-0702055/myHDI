import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/text_button_app.dart';
import 'home_tai_nan_con_nguoi.dart';
import 'chitietsanpham_tai_nan_con_nguoi.dart';
import 'thongtinnguoibaohiem_tai_nan_con_nguoi.dart' hide AppBarHome;


class GoibaohiemTaiNanConNguoi extends StatelessWidget {
  const GoibaohiemTaiNanConNguoi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHome("Gói bảo hiểm", duongDan: const HomeTaiNanConNguoi()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GoiBaoHiem(),
          ],
        ),
      ),
    );
  }
}

class GoiBaoHiem extends StatefulWidget {
  const GoiBaoHiem({super.key});

  @override
  State<GoiBaoHiem> createState() => _GoiBaoHiemState();
}

class _GoiBaoHiemState extends State<GoiBaoHiem> {
  int _activerPage = 0;

  // Danh sách gốc chứa thông tin và bảng màu cho cả 2 chế độ Sáng/Tối
  final List<Map<String, dynamic>> listGoiBaoHiem = [
    {
      "image": "assets/image/baohiem1.png",
      "title": "Bảo hiểm gói Đồng",
      "status": "Tiết kiệm",
      "price": "695.000 VNĐ/năm",
      "colorsLight": [Color(0xFFACEDAC), Color(0xFFC3F4C3), Color(0xFFACEDAC)],
      "colorsDark": [Color(0xFF1B4D1B), Color(0xFF246B24), Color(0xFF1B4D1B)], // Tông xanh lá trầm
      "price2": "50 triệu",
      "price3": "2 triệu"
    },
    {
      "image": "assets/image/baohiem2.png",
      "title": "Bảo hiểm gói Bạc",
      "status": "Phổ biến",
      "price": "695.000 VNĐ/năm",
      "colorsLight": [Color(0xFFABBDFF), Color(0xFFB5C1F1), Color(0xFFABBDFF)],
      "colorsDark": [Color(0xFF1F2B5C), Color(0xFF2B3A75), Color(0xFF1F2B5C)], // Tông xanh dương trầm
      "price2": "100 triệu",
      "price3": "5 triệu"
    },
    {
      "image": "assets/image/baohiem3.png",
      "title": "Bảo hiểm gói Vàng",
      "status": "Nên mua",
      "price": "695.000 VNĐ/năm",
      "colorsLight": [Color(0xFFF1E77F), Color(0xFFFDFBB3), Color(0xFFF1E77F)],
      "colorsDark": [Color(0xFF5E571E), Color(0xFF786F28), Color(0xFF5E571E)], // Tông vàng úa trầm
      "price2": "150 triệu",
      "price3": "7,5 triệu"
    },
    {
      "image": "assets/image/baohiem4.png",
      "title": "Bảo hiểm gói Titan",
      "status": "Bảo vệ tối đa",
      "price": "2.695.000 VNĐ/năm",
      "colorsLight": [Color(0xFFF3C971), Color(0xFFF6D79B), Color(0xFFF3C971)],
      "colorsDark": [Color(0xFF6B4E1B), Color(0xFF856224), Color(0xFF6B4E1B)], // Tông cam đất trầm
      "price2": "200 triệu",
      "price3": "10 triệu"
    },
    {
      "image": "assets/image/baohiem5.png",
      "title": "Bảo hiểm gói Bạch Kim",
      "status": "Cao cấp",
      "price": "2.695.000 VNĐ/năm",
      "colorsLight": [Color(0xFF76D3D8), Color(0xFFA3E9ED), Color(0xFF76D3D8)],
      "colorsDark": [Color(0xFF1E5559), Color(0xFF287075), Color(0xFF1E5559)], // Tông xanh ngọc trầm
      "price2": "250 triệu",
      "price3": "12,5 triệu"
    },
    {
      "image": "assets/image/baohiem6.png",
      "title": "Bảo hiểm gói Kim Cương",
      "status": "Siêu cao cấp",
      "price": "2.695.000 VNĐ/năm",
      "colorsLight": [Color(0xFF8199FA), Color(0xFFA5B7F6), Color(0xFF8199FA)],
      "colorsDark": [Color(0xFF243B9B), Color(0xFF334FBFFF), Color(0xFF243B9B)], // Tông xanh ánh tím trầm
      "price2": "250 triệu",
      "price3": "15 triệu"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, isDark, child) {
        return Column(
          children: [
            SizedBox(
              height: 630,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 700,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.75,
                  enlargeFactor: 0.3,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _activerPage = index;
                    });
                  },
                ),
                items: listGoiBaoHiem.map((item) {
                  return _BuildBaoHiemCard(
                    gradientColors: isDark ? item['colorsDark'] : item['colorsLight'],
                    image1: item['image'],
                    textTitle: item['title'],
                    textStatus: item['status'],
                    textPrice1: item['price'],
                    textPrice2: item['price2'],
                    textPrice3: item['price3'],
                    isDark: isDark,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThongtinnguoibaohiemTaiNanConNguoi(
                            sanPham: Map<String, dynamic>.from(item),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),

            // --- CÁC DẤU CHẤM CHỈ SỐ TRANG (INDICATORS) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: listGoiBaoHiem.asMap().entries.map((entry) {
                return Container(
                  width: _activerPage == entry.key ? 30.0 : 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: _activerPage == entry.key
                        ? AppColor.appButtonColor
                        : (isDark ? Colors.white24 : Colors.grey.withOpacity(0.3)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Container(
              color: isDark ? AppColor.containerDark : AppColor.containerLight,
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sản phẩm khác",
                    style: TextStyle(color: isDark ? Colors.redAccent.shade100 : Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Xem tất cả", style: TextStyle(color: AppColor.appButtonColor)),
                  )
                ],
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  _SanPhamKhac(isDark, icon: 'assets/image/icon_baohiemtainanconnguoi.png', text: "Bảo hiểm tai\nnạn con người"),
                  const SizedBox(width: 8),
                  _SanPhamKhac(isDark, icon: 'assets/image/icon_baohiemtainanconnguoi.png', text: "Bảo hiểm tai\nnạn con người"),
                  const SizedBox(width: 8),
                  _SanPhamKhac(isDark, icon: 'assets/image/icon_baohiemtainanconnguoi.png', text: "Bảo hiểm tai\nnạn con người"),
                  const SizedBox(width: 8),
                  _SanPhamKhac(isDark, icon: 'assets/image/icon_baohiemtainanconnguoi.png', text: "Bảo hiểm tai\nnạn con người")
                ],
              ),
            )
          ],
        );
      },
    );
  }

  // --- HÀM VẼ THẺ CHI TIẾT BẢO HIỂM ---
  Widget _BuildBaoHiemCard({
    required List<Color> gradientColors,
    required dynamic image1,
    required dynamic textTitle,
    required dynamic textStatus,
    required dynamic textPrice1,
    required dynamic textPrice2,
    required dynamic textPrice3,
    required bool isDark,
    required dynamic onTap,
  }) {
    return Stack(
      alignment: const Alignment(0, -1),
      children: [
        Container(
          margin: const EdgeInsets.only(top: 70),
          width: double.infinity,
          child: Column(
            children: [
              // Phần Header Thẻ chứa mảng màu Gradient
              Container(
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: gradientColors,
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
                child: Stack(
                  children: [
                    Image.asset("assets/image/kehoabaohiem.png", fit: BoxFit.cover),
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(textTitle, style: TextStyle(color: isDark ? Colors.white : Colors.red, fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(textStatus, style: TextStyle(color: isDark ? Colors.white70 : const Color(0xFF2D2D2D), fontSize: 12)),
                          Text(textPrice1, style: TextStyle(color: isDark ? Colors.greenAccent : const Color(0xFF1E552A), fontSize: 14, fontWeight: FontWeight.bold))
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // Phần Thân Thẻ chứa các điều khoản
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDark ? AppColor.containerDark : AppColor.containerLight,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    _RowThongTin(text1: "Quyền lợi bảo hiểm", text2: "Số tiền bảo hiểm", isDark: isDark, isHeader: true),
                    const SizedBox(height: 10),
                    Divider(thickness: 1, color: isDark ? Colors.white10 : const Color(0xFFEEEEEE)),
                    _RowThongTin(text1: "Tử vong, thương tật thân\nthể do tai nạn", text2: textPrice2, isDark: isDark),
                    const SizedBox(height: 10),
                    Divider(thickness: 1, color: isDark ? Colors.white10 : const Color(0xFFEEEEEE)),
                    _RowThongTin(text1: "Trợ cấp trong thời gian điều\ntrị tai nạn", text2: textPrice3, isDark: isDark),
                    const SizedBox(height: 10),
                    Divider(thickness: 1, color: isDark ? Colors.white10 : const Color(0xFFEEEEEE)),
                    _RowThongTin(text1: "Mở rộng bảo hiểm Ngộ độc\nthức ăn, đồ uống hoặc hít phải\nhơi độc, khí độc, chất độc", text2: "✓", isDark: isDark),
                    const SizedBox(height: 10),
                    Divider(thickness: 1, color: isDark ? Colors.white10 : const Color(0xFFEEEEEE)),

                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ChitietsanphamTaiNanConNguoi()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Xem chi tiết sản phẩm ", style: TextStyle(color: AppColor.appButtonColor)),
                          const Icon(Icons.arrow_forward_ios, size: 16, color: AppColor.appButtonColor)
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(width: double.infinity, child: TextButtonApp("Mua ngay", onTap))
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(margin: const EdgeInsets.only(top: 30), child: Image.asset(image1, fit: BoxFit.cover)),
      ],
    );
  }

  // --- HÀM VẼ NÚT SẢN PHẨM KHÁC PHÍA DƯỚI ---
  Widget _SanPhamKhac(bool isDark, {required String icon, required String text}) {
    return TextButton.icon(
      onPressed: () {},
      icon: Image.asset(icon, width: 40, height: 40),
      label: Text(text, style: TextStyle(fontSize: 13, color: isDark ? Colors.white : Colors.black87)),
      style: TextButton.styleFrom(
        minimumSize: const Size(160, 55),
        backgroundColor: isDark ? AppColor.containerDark : AppColor.containerLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _RowThongTin({required String text1, required String text2, required bool isDark, bool isHeader = false}) {
    FontWeight currentWeight = isHeader ? FontWeight.bold : FontWeight.w400;
    Color textColor = isDark ? AppColor.textDark : AppColor.textLight;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(text1, style: TextStyle(fontSize: 13, fontWeight: currentWeight, color: textColor))),
        const SizedBox(width: 10),
        Text(text2, style: TextStyle(fontSize: 13, fontWeight: currentWeight, color:  textColor )),
      ],
    );
  }
}