
import 'package:flutter/material.dart';
import 'package:my_hdi/features/lmtainancongnuoi/presentation/pages/thongtinnguoibaohiem_tai_nan_con_nguoi.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/text_button_app.dart';
import 'goibaohiem_tai_nan_con_nguoi.dart';
class ChitietsanphamTaiNanConNguoi extends StatefulWidget {
  @override
  State<ChitietsanphamTaiNanConNguoi> createState()
  => _ChitietsanphamTaiNanConNguoiState();
}
class _ChitietsanphamTaiNanConNguoiState extends State<ChitietsanphamTaiNanConNguoi>{
  Map<String, dynamic>? goiDangMua;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHome("Chi tiết quyền lợi các gói",duongDan: GoibaohiemTaiNanConNguoi()),
      body: SingleChildScrollView(
        child: ContentChiTietSanPham(
          onChonGoi: (goi){
            setState(() {
              goiDangMua = goi;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomMuaHang(
        goiDangMua: goiDangMua,
      ),
    );
  }

}
class ContentChiTietSanPham extends StatefulWidget {
  final Function(Map<String, dynamic>) onChonGoi;

  const ContentChiTietSanPham({
    super.key,
    required this.onChonGoi,
  });
  @override
  State<ContentChiTietSanPham> createState() => _ContentChiTietSanPhamState();

}
class _ContentChiTietSanPhamState extends State<ContentChiTietSanPham>{
  final List<Map<String, dynamic>> listGoiBaoHiem = [
    {
      "title": "Gói Đồng",
      "status": "Tiết kiệm",
      "price": "695.000 VNĐ/năm",
      "price2": "50.000.000 VND",
      "price3": "2.500.000VND"
    },
    {
      "title": "Gói Bạc",
      "status": "Phổ biến",
      "price": "695.000 VNĐ/năm",
      "price2": "100.000.000 VND",
      "price3": "5.000.000VND"
    },
    {
      "title": "Gói Vàng",
      "status": "Nên mua",
      "price": "695.000 VNĐ/năm",
      "price2": "150.000.000 VND",
      "price3": "7.500.000VND"
    },
    {
      "title": "Gói Titan",
      "status": "Bảo vệ tối đa",
      "price": "2.695.000 VNĐ/năm",
      "price2": "200.000.000 VND",
      "price3": "10.000.000 VND"
    },
    {
      "title": "Gói Bạch Kim",
      "status": "Cao cấp",
      "price": "2.695.000 VNĐ/năm",
      "price2": "250.000.000 VND",
      "price3": "12.500.000 VND"
    },
    {
      "title": "Gói Kim Cương",
      "status": "Siêu cao cấp",
      "price": "2.695.000 VNĐ/năm",
      "price2": "300.000.000 VND",
      "price3": "15.000.000 VND"
    },
  ];
  Map<String, dynamic>? goi1;
  Map<String, dynamic>? goi2;
  int viTriDangChon = 1;
  @override
  void initState() {
    super.initState();
    goi1 = listGoiBaoHiem[0];
    goi2 = listGoiBaoHiem[5];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onChonGoi(goi1!);
    });
  }
  void hienThiDanhSachGoi() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppColor.containerDark : AppColor.containerLight,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 24),
                  Text("Gói bảo hiểm", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: isDark ? AppColor.textDark : AppColor.textLight)),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.grey.shade100),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listGoiBaoHiem.length,
                itemBuilder: (context, index) {
                  final goi = listGoiBaoHiem[index];
                  bool isSelected = (viTriDangChon == 1 ? goi1 == goi : goi2 == goi);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (viTriDangChon == 1) {
                          goi1 = goi;widget.onChonGoi(goi1!);
                        } else {
                          goi2 = goi;widget.onChonGoi(goi2!);
                        }});
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? AppColor.containerDark : AppColor.containerLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSelected ? Colors.orange : Colors.grey[200]!, width: 1.5),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: isSelected ? Colors.orange : Colors.grey,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(goi["title"], style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: isDark ? AppColor.textDark : AppColor.textLight)),
                                Text(goi["status"], style: TextStyle(fontSize: 13, color: isDark ? AppColor.textDark : AppColor.textLight)),
                              ],
                            ),
                          ),
                          // Giá tiền
                          Text(goi["price"], style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: hienThiDanhSachGoi,
                child: Row(
                  children: [
                    Text("Chọn gói so sánh khác  ",style: TextStyle(fontSize: 14,color: AppColor.appButtonColor)),
                    Icon(Icons.keyboard_arrow_down_outlined,color: AppColor.appButtonColor)
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: (){setState(() {viTriDangChon = 1;});
                  widget.onChonGoi(goi1!);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? AppColor.containerDark : AppColor.containerLight,
                    border: Border.all(
                      color: viTriDangChon == 1 ? Colors.orange : Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: _GoiSoSanh(
                    textTitle: goi1!["title"],
                    textStatus: goi1!["status"],
                    textPrice: goi1!["price"],
                    isSelected: viTriDangChon == 1,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){setState(() {viTriDangChon = 2;});widget.onChonGoi(goi2!);},
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? AppColor.containerDark : AppColor.containerLight,
                    border: Border.all(
                      color: viTriDangChon == 2 ? Colors.orange : Colors.transparent, width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _GoiSoSanh(
                    textTitle: goi2!["title"],
                    textStatus: goi2!["status"],
                    textPrice: goi2!["price"],
                    isSelected: viTriDangChon == 2,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10, offset: Offset(0, 4))
              ],
            ),
            child: Column(
              children: [
                _RowTieuDeLonBoGoc(title: "I. Tử vong, thương tật thân thể do tai nạn"),
                _RowSoSanh(text1:goi1!["price2"],text2: goi2!["price2"] ),
                _RowTieuDeNho(title:"1. Tử vong thương tật toàn bộ vĩnh viễn" ),
                _RowSoSanh(text1:"Tối đa số tiền bảo hiểm",text2: "Tối đa số tiền bảo hiểm" ),
                _RowTieuDeNho(title:"2. Thương tật bộ phận vĩnh viễn" ),
                _RowSoSanh(text1:"Theo bảng tí lệ trả tiền bảo hiểm thương tật",text2: "Theo bảng tí lệ trả tiền bảo hiểm thương tật" ),
                _RowTieuDeNho(title:"3. Thương tật tạm thời" ),
                _RowSoSanh(text1:"Trả toàn bộ các chi phí hợp lý phát sinh cho việc điều trị thương tật",text2: "Trả toàn bộ các chi phí\nhợp lý phát sinh cho việc\nđiều trị thương tật" ),
                Container(
                  padding: EdgeInsets.all(10),
                  color: isDark ? AppColor.containerDark : AppColor.containerLight,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              text: TextSpan(style: TextStyle(fontSize: 14),
                                children: [
                                  TextSpan(text: "Tiền bồi dưỡng = ",
                                      style: TextStyle(color: isDark ? AppColor.textDark: AppColor.textLight)),
                                  TextSpan(text: "0,1% × Số tiền bảo hiểm × Số ngày nằm viện (Tối đa không vượt quá 180 ngày/vụ)",style: TextStyle(color: Color(0xFFC58B00))),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(width: 1, height: 100, color: Colors.grey),
                      Expanded(
                        child: Column(
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              text: TextSpan(style: TextStyle(fontSize: 14),
                                children: [
                                  TextSpan(text: "Tiền bồi dưỡng = ",
                                      style: TextStyle(
                                          color: isDark ? AppColor.textDark: AppColor.textLight
                                      )),
                                  TextSpan(text: "0,1% × Số tiền bảo hiểm × Số ngày nằm viện (Tối đa không vượt quá 180 ngày/vụ)",style: TextStyle(color: Color(0xFFC58B00))),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _RowSoSanh(
                    text1:"Trong mọi trường hợp tổng số tiền chi trả  không vượt tỷ lệ % thương tật trong bảng tỷ lệ trả tiền bảo hiểm",
                    text2: "Trong mọi trường hợp tổng số tiền chi trả  không vượt tỷ lệ % thương tật trong bảng tỷ lệ trả tiền bảo hiểm"
                ),
                _RowTieuDeLon(title:"II. Trợ cấp trong thời gian điều trị tai nạn"),
                _RowSoSanh(text1:goi1!["price3"],text2: goi2!["price3"] ),
                _RowTieuDeNho(title:"1. Quyền lợi một ngày nằm viện"),
                _RowSoSanh(text1: "244.000VND",text2: "244.000VND" ),
                _RowTieuDeLon(title:"III. Mở rộng BH ngộ độc thức ăn, đồ uống hít phải hơi độc, khí độc, chất độc"),
                _RowSoSanh(text1: "50.000.000VND",text2: "50.000.000VND"),
              ],
            ),
          )
        ],
      ),
    );

  }
  Widget _RowSoSanh({text1,text2}){
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      color: isDark ? AppColor.containerDark : AppColor.containerLight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Text(text1, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,maxLines: 5,
                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: isDark ? AppColor.textDark: AppColor.textLight),
                ),
              ),
            ),
          ),
          Container(width: 1, height: 44, color: Colors.grey),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Text(text2, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,maxLines: 5,
                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: isDark ? AppColor.textDark: AppColor.textLight),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _RowTieuDeLonBoGoc({title}){
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
        width: double.infinity,
        height: 44,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Color(0xFFD8FFE4),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: isDark ? AppColor.textDark: AppColor.textLight))
            ])
    );
  }
  Widget _RowTieuDeLon({title}){
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Color(0xFFD8FFE4),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text(title,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,maxLines: 2,
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: isDark ? AppColor.textDark: AppColor.textLight)))
              ])
      );

  }
  Widget _RowTieuDeNho({title}){
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return
        Container(
          width: double.infinity,
            decoration: BoxDecoration(
                color: isDark ? AppColor.containerDark: AppColor.containerLight
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: isDark ? AppColor.textDark: AppColor.textLight)),
              ],
            )
        );
  }
  Widget _GoiSoSanh({
    required textTitle,
    required textStatus,
    required textPrice,
    required bool isSelected,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20,),
          height: 100,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
              color: isDark ? AppColor.containerDark: AppColor.containerLight,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10, offset: Offset(0, 4))
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(textTitle, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              SizedBox(height: 7),
              Text(textStatus, style: TextStyle(fontSize: 14)),
              SizedBox(height: 7),
              Text(textPrice, style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        if (isSelected)
          Positioned(top: 0, right: 0,
            child: Container(width: 30, height: 30,
              decoration: BoxDecoration(
                color: AppColor.appButtonColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(100),
                ),
              ),
              child: Icon(Icons.check, size: 16, color: Colors.white),
            ),
          ),
      ],
    );
  }
}
class BottomMuaHang extends StatelessWidget {
  final Map<String, dynamic>? goiDangMua;
  const BottomMuaHang({
    super.key,
    required this.goiDangMua,
  });
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 80,
      decoration: BoxDecoration(
        color: isDark ? AppColor.containerDark : AppColor.containerLight,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 14,color: isDark ? AppColor.textDark: AppColor.textLight),
                    children: [
                      TextSpan(text: "Gói bảo hiểm: "),
                      TextSpan(
                        text: goiDangMua?["title"] ?? "",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                RichText(
                  text: TextSpan(style: TextStyle(fontSize: 14, color: isDark ? AppColor.textDark: AppColor.textLight),
                    children: [
                      TextSpan(text: "Phí bảo hiểm: "),
                      TextSpan(
                        text: goiDangMua?["price"] ?? "",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          TextButtonApp("Mua ngay", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ThongtinnguoibaohiemTaiNanConNguoi(sanPham: goiDangMua!),
              ),
            );
          })
        ],
      ),
    );
  }
}