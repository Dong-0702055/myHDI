import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../app/router/route_name.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../core/widgets/text_field_icon_app.dart';
import '../../../lmtainancongnuoi/presentation/pages/home_tai_nan_con_nguoi.dart';
import '../../../settings/presentation/pages/setting_custom.dart';



class HomeCustom extends StatelessWidget{
  const HomeCustom({super.key});
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: HomeAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ContainerHome(),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(),
      );
  }
}
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      backgroundColor: isDark ? AppColor.containerDark : AppColor.containerLight,
      leading: Padding(padding: EdgeInsets.only(left:16),
          child: Image.asset('assets/image/logo.png')),
      actions: [
        TextButton.icon(onPressed: (){
          Navigator.pushNamed(context, RouteNames.login);
        },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap
            ),
            icon: Icon(Icons.person_2_outlined, color: Colors.green,),
            label: Text("Đăng nhập", style: TextStyle(fontSize: 18, color: Colors.green))
        ),
        _IconButtonBar(icon: Icons.search, onPress: (){},isDark: isDark),
        _IconButtonBar(icon: Icons.notifications_none, onPress: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=> HomeTaiNanConNguoi()));
        },
          isDark: isDark
        ),
        _IconButtonBar(icon: Icons.format_list_bulleted, onPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AccountSettingsScreen(),
            ),
          );
        },
            isDark: isDark
        ),
      ],
    );
  }
  Widget _IconButtonBar({required icon, required onPress, required bool isDark}){
    return IconButton(
      icon: Icon(icon, color: isDark ? Colors.white :  Colors.green),
      onPressed: onPress,
    );
  }
  @override
  // TODO: implement preferredSize
  final Size preferredSize = const Size.fromHeight(60.0);
  const HomeAppBar({super.key});
}
class ContainerHome extends StatelessWidget{
  final List<String> imgList1 = [
    'assets/image/title1.png',
    'assets/image/title.png',
  ];
  final List<String> imgList2 = [
    'assets/image/slide1.png',
    'assets/image/slide2.png',
  ];
   ContainerHome({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          CarouselSlider(
              options: CarouselOptions(
              height: 350.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                viewportFraction: 1.0,
                enlargeCenterPage: false,
              ),
              items: imgList1.map((item) => Container(
              child: Image.asset(item, fit: BoxFit.cover, width: double.infinity,),
              )).toList(),
              ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 285),
                  padding: EdgeInsets.only(top:45),
                  alignment: Alignment.topCenter,
                  decoration: const BoxDecoration(
                  image: DecorationImage(
                  image: AssetImage("assets/image/bg_home_1.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  ),
                ),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Column(
                        children: [
                          _Title(text: "Bảo hiểm trực tuyến"),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _SanPhamBaoHiemTrucTuyen(
                                  image: "assets/image/home_1.png",
                                  title:  "Bảo hiểm",
                                  text: "Chăm sóc sức khỏe và tai nạn",
                                  price: '1.695.000',
                                  onpress: (){}
                                ),
                                _SanPhamBaoHiemTrucTuyen(
                                    image: "assets/image/home_2.png",
                                    title:  "Bảo hiểm",
                                    text: "Chăm sóc sức khỏe và tai nạn",
                                    price: '1.695.000',
                                    onpress: (){}
                                ),
                                _SanPhamBaoHiemTrucTuyen(
                                    image: "assets/image/home_3.png",
                                    title:  "Bảo hiểm",
                                    text: "Chăm sóc sức khỏe và tai nạn",
                                    price: '1.695.000',
                                    onpress: (){}
                                ),
                              ],
                            ),
                          ),
                          _ButtonXemThem(
                              onpress: (){}
                          ),
                         _Title(text: "Dịch vụ khách hàng")
                        ],
                      ),
                    ],
                  )
                ),
                Container(
                    width: double.infinity,
                    height: 720,
                    alignment: Alignment.topCenter,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/image/bg_home_2.png"),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _SanPhamBaoHiemTrucTuyenSmall(image: "assets/image/home_1.png", title: "Bảo hiểm"),
                              _SanPhamBaoHiemTrucTuyenSmall(image: "assets/image/home_1.png", title: "Bảo hiểm"),
                              _SanPhamBaoHiemTrucTuyenSmall(image: "assets/image/home_1.png", title: "Bảo hiểm"),
                              _SanPhamBaoHiemTrucTuyenSmall(image: "assets/image/home_1.png", title: "Bảo hiểm"),
                            ],
                          ),
                        ),
                        _ButtonXemThem(
                            onpress: (){}
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top:30),
                          child: Text("Tiện ích hỗ trợ",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight(500),
                                color: Color(0xFF196121)
                            ),),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _SanPhamBaoHiemTrucTuyenSmall(image: "assets/image/home_1.png", title: "Bảo hiểm"),
                              _SanPhamBaoHiemTrucTuyenSmall(image: "assets/image/home_1.png", title: "Bảo hiểm"),
                              _SanPhamBaoHiemTrucTuyenSmall(image: "assets/image/home_1.png", title: "Bảo hiểm"),
                              _SanPhamBaoHiemTrucTuyenSmall(image: "assets/image/home_1.png", title: "Bảo hiểm"),
                            ],
                          ),
                        ),
                        _ButtonXemThem(
                            onpress: (){}
                        ),
                      ],
                    )
                ),
              ],
            ),
          Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top:1400),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/image/bg_home_3.png"),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top:80),
                      child: Text("Thông tin đối tác",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight(500),
                            color: Colors.white
                        ),),
                    ),
                    CarouselSlider(
                        options: CarouselOptions(
                          height: 180,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          viewportFraction: 0.7,
                          enlargeCenterPage: true,
                        ),
                        items: imgList2.map((item) => Container(
                          padding: EdgeInsets.all(25),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              item,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )).toList(),
                      ),
                  ],
                ),
                ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/image/bg_home_4.png"),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Liên hệ tư vấn bảo hiểm",style: TextStyle(fontSize: 20,color: Colors.red),),
                            Text("Vui lòng để lại thông tin và chọn\n thời gian tư vấn,"
                                " tư vấn viên sẽ hồi\n đáp mọi thắc mắc và vấn đề liên\n quan"
                                " đến các sản phẩm bảo hiểm\n và dịch vụ khách hàng",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            )
                          ],
                        ),
                        Image.asset(
                            "assets/image/logo1.png",
                          height: 100,
                          width: 100,

                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        TextFieldIcon("Số điện thoại",Icons.phone),
                        SizedBox(width: 20),
                        TextFieldIcon("Họ tên",Icons.person),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        TextFieldIcon("Email",Icons.email),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        TextFieldIcon("Ngày hẹn",Icons.event_available),
                        SizedBox(width: 20,),
                        TextFieldIcon("Giờ bắt hẹn",Icons.event_available),
                      ],
                    ),
                    SizedBox(height: 10,),
                    TextButton(onPressed: (){},
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.appButtonColor,
                          minimumSize: Size(400, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10)
                          )
                        ),
                        child: Text("Đặt lịch ngay",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                          ),
                        )

                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                 image: DecorationImage(
                     image: AssetImage("assets/image/bg_home_5.png"),
                      fit: BoxFit.cover
                 )
                ),
                child: Column(
                  children: [
                    Text("TIN TỨC",style: TextStyle(fontSize: 25,color: Colors.green)),
                    _TinTuc(
                      image: "assets/image/new1.png",
                      text1: "Thông báo về: \"Điều khoản và điều kiện chung"
                          " về bảo vệ và xử lí dữ liệu cá nhân\"",
                      text2: "11:00 - 20/12/2023",
                      onpress: (){}
                    ),
                    Row(
                      children: [
                        Expanded(flex: 1,
                          child: _TinTucSmall(
                              image: "assets/image/new2.png",
                              text1: "Hướng dẫn của Bộ Tài Chính về bảo"
                                  " hiểm cháy, nổ bắt buộc",
                              text2: "11:00 - 20/12/2023",
                              onpress: (){}
                          ),
                        ),
                        Expanded(flex: 1,
                          child: _TinTucSmall(
                              image: "assets/image/new3.png",
                              text1: "Hoàn tiền dến 10 triệu đồng khi dùng thẻ HDBank",
                              text2: "11:00 - 20/12/2023",
                              onpress: (){}
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top:30),
                      child: OutlinedButton(
                          onPressed: (){},
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(1),
                              ),
                              side: BorderSide(
                                  color: AppColor.appButtonColor
                              )
                          ),
                          child: Text("Xem thêm",style: TextStyle(fontSize: 20, color: AppColor.appButtonColor),)),
                    ),
                    SizedBox(height: 100,)
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 2790),
            height: 800,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/image/bg_home_6.png"),
                  fit: BoxFit.cover
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 180,),
                Row(
                  children: [
                    SizedBox(width: 50,),
                    Image.asset("assets/image/logohd_insurance.png"),
                  ],
                ),
                SizedBox(height: 80,),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Công ty TNHH Bảo hiểm HD",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      SizedBox(height: 15,),
                      Text("Giấy phép thành lập và hoạt động số 82/GP/KDBH\n"
                          "ngày cấp 19/5/2020 cấp bởi Bộ Tài Chính",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          ImageIcon(AssetImage("assets/icons/icon_addres.png"),color: Colors.white,size: 24,),
                          Text("Tòa nhà Abacus, 58 Nguyễn Đình Chiều \n,Quận 1, Tp.Hồ Chí Minh",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          ImageIcon(AssetImage("assets/icons/icon_email.png"),color: Colors.white,size: 24,),
                          Text("Email: info@hdinsurance.com.vn",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          ImageIcon(AssetImage("assets/icons/icon_call.png"),color: Colors.white,size: 24,),
                          Text("Hotline: (028) 3528 2888",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          ImageIcon(AssetImage("assets/icons/icon_global.png"),color: Colors.white,size: 24,),
                          Text("Website: hdinsurance.com.vn",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      Text("Theo dõi chúng tôi",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Container(
                           decoration: BoxDecoration(
                             color: Color(0xFF1E7E34),
                             borderRadius: BorderRadius.circular(10)
                           ),
                           child:  IconButton(padding: EdgeInsets.zero,
                               onPressed: (){},
                               icon: Image.asset("assets/icons/icon_fb.png",fit: BoxFit.contain,width: 30,)),
                         ),
                          SizedBox(width: 15,),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF1E7E34),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:  IconButton(padding: EdgeInsets.zero,
                                onPressed: (){},
                                icon: Image.asset("assets/icons/icon_in.png",fit: BoxFit.contain,width: 30,)),
                          ),
                          SizedBox(width: 15,),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF1E7E34),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:  IconButton(padding: EdgeInsets.zero,
                                onPressed: (){},
                                icon: Image.asset("assets/icons/icon_ytb.png",fit: BoxFit.contain,width: 30,)),
                          ),
                          SizedBox(width: 15,),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF1E7E34),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:  IconButton(padding: EdgeInsets.zero,
                                onPressed: (){},
                                icon: Image.asset("assets/icons/icon_ig.png",fit: BoxFit.contain,width: 30,)),
                          ),
                          SizedBox(width: 15,),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF1E7E34),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:  IconButton(padding: EdgeInsets.zero,
                                onPressed: (){},
                                icon: Image.asset("assets/icons/icon_zalo.png",fit: BoxFit.contain,width: 30,)),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
class CustomBottomNavBar1 extends StatelessWidget{
  const CustomBottomNavBar1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              IconButton(
                  onPressed: (){},
                iconSize: 30,
                  icon: Image.asset("assets/icons/icon_bottom1.png"),),
              Text("Trang chủ",style: TextStyle(fontSize: 13,color: Colors.grey),)
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: (){},
                iconSize: 30,
                icon: Image.asset("assets/icons/icon_bottom1.png"),),
              Text("Trang chủ",style: TextStyle(fontSize: 13,color: Colors.grey),)
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: (){},
                iconSize: 30,
                icon: Image.asset("assets/icons/icon_bottom1.png"),),
              Text("Trang chủ",style: TextStyle(fontSize: 13,color: Colors.grey),)
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: (){},
                iconSize: 30,
                icon: Image.asset("assets/icons/icon_bottom1.png"),),
              Text("Trang chủ",style: TextStyle(fontSize: 13,color: Colors.grey),)
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: (){},
                iconSize: 30,
                icon: Image.asset("assets/icons/icon_bottom1.png"),),
              Text("Trang chủ",style: TextStyle(fontSize: 13,color: Colors.grey),)
            ],
          ),
        ],
      ),
    );
  }
}
class CustomBottomNavBar extends StatefulWidget{
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}
class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  Widget _buildBottomItem(int index, String label, String assetPath) {
    bool isSelected = _selectedIndex == index;
    bool isCenter = index == 2;

    Color activeColor =  AppColor.appButtonColor;
    Color inactiveColor = Colors.grey;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 5),
            Image.asset(
              assetPath,
              width: isCenter ? 32 : 24,
              height: isCenter ? 32 : 24,
              color: isSelected ? activeColor : null,
              colorBlendMode: isCenter && !isSelected ? null : BlendMode.srcIn,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? activeColor : inactiveColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            _buildBottomItem(0, "Trang chủ", "assets/icons/icon_bottom1.png"),
            _buildBottomItem(1, "Bồi thường", "assets/icons/icon_bottom2.png"),
            _buildBottomItem(2, "Thao tác", "assets/icons/icon_bottom3.png"),
            _buildBottomItem(3, "Hỗ trợ", "assets/icons/icon_bottom4.png"),
            _buildBottomItem(4, "Tiện ích", "assets/icons/icon_bottom5.png"),
          ],
        ),
      ),
    );
  }

}
Widget _SanPhamBaoHiemTrucTuyen({
  required String image,
  required String title,
  required String text,
  required String price,
  required onpress
}){
  return  Container(
    margin: EdgeInsets.only(left: 10),
    padding: EdgeInsets.all(5),
    width: 200,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(image, height: 150, width: 200, fit: BoxFit.fitWidth,),
        Text(title, style: TextStyle(fontSize: 23,),),
        Text(text, style: TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis),),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Chỉ từ ', style: TextStyle(color: Colors.grey, fontSize: 14)),
              TextSpan(text: price, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
              TextSpan(text: 'VNĐ/năm', style: TextStyle(color: Colors.red, fontSize: 12)),
            ],
          ),
        ),
        OutlinedButton(onPressed: onpress,
            style: OutlinedButton.styleFrom(
                foregroundColor:  AppColor.appButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(1),
                ),
                side: BorderSide(
                    color: AppColor.appButtonColor
                )
            ),
            child: Text("Mua ngay")),
      ],
    ),
  );
}
Widget _ButtonXemThem({required VoidCallback onpress}){
  return Container(
    width: 180,
    margin: EdgeInsets.only(top:20),
    child: OutlinedButton(
        onPressed: onpress,
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(5),
            ),
            side: BorderSide(color: AppColor.appButtonColor)
        ),
        child: Row(
          children: [
            Text("Xem thêm", style: TextStyle(fontSize: 20, color: AppColor.appButtonColor)),
            const SizedBox(width: 15),
            Icon(Icons.arrow_forward_ios, size: 18, color: AppColor.appButtonColor),
          ],
        )
    ),
  );
}
Widget _Title({required String text}){
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(top:30),
    child: Text(text,
      style: TextStyle(fontSize: 28, fontWeight: FontWeight(500), color: Colors.white))
  );
}
Widget _SanPhamBaoHiemTrucTuyenSmall({
  required String image,
  required String title
}){
  return Container(
    margin: EdgeInsets.only(left: 10,top: 10),
    padding: EdgeInsets.all(5),
    width: 200,
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(image, height: 150, width: 200, fit: BoxFit.fitWidth),
        Text(title, style: TextStyle(fontSize: 23)),
      ],
    ),
  );
}
Widget _TinTuc({required String image, required String text1, required String text2, onpress}){
  return Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
    child: Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(image, width: double.infinity, fit: BoxFit.cover)),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Text("Tin thị trường", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        Text(text1, style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 16),maxLines: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text2, style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 16, fontWeight: FontWeight(350)),maxLines: 2),
            TextButton.icon(
              onPressed: onpress,
              icon: Text("Xem thêm", style: TextStyle(color: AppColor.appButtonColor)),
              label: Icon(Icons.arrow_forward, color: AppColor.appButtonColor, size: 16),
            ),
          ]
        )
      ],
    )
  );
}
Widget _TinTucSmall({required String image, required String text1, required String text2, onpress}){
  return Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white
    ),
    child: Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(image, width: double.infinity, fit: BoxFit.cover),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Text("Tin thị trường", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        Text(text1,
          style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 16),maxLines: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text2, style: TextStyle(fontSize: 16, fontWeight: FontWeight(350))),
          ],
        ),
        TextButton.icon(
          onPressed: onpress,
          icon: Text("Xem thêm", style: TextStyle(color: AppColor.appButtonColor)),
          label: Icon(Icons.arrow_forward, color: AppColor.appButtonColor, size: 16),
        )
      ]
    )
  );
}


