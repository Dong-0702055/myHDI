import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_color.dart';
import '../../../auth/login/pages/login_custom.dart';
import '../../../auth/presentation/controllers/auth_bloc.dart';
import '../../../auth/presentation/controllers/auth_event.dart';
import '../../../auth/presentation/controllers/auth_state.dart';


class HomeUser extends StatelessWidget {
  const HomeUser({super.key});

  @override
  Widget build(BuildContext context) {
    return
      BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginCustom(),
              ),
                  (route) => false,
            );
          }

          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }

        },
        child: Scaffold(
              appBar: const HomeAppBar(),
              body: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Title("Mua bảo hiểm trực tuyến"),
                      SizedBox(height: 20,),
                      CategoryBar(),
                      ServiceGridSection1(),
                      Title("Dịch vụ khách hàng"),
                      ServiceGridSection2(),
                      TitleExtend("Coupon dành riêng cho bạn"),
                      OfferCard(),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: CustomBottomNavBar(),
        ),
      );

  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(160);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 160,
          padding: const EdgeInsets.fromLTRB(20, 45, 20, 0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/image/logohd_insurance.png", height: 45),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text("Lê Vũ Hồng Ý", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("Tài khoản khách hàng", style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
              const SizedBox(width: 10),
              PopupMenuButton<String>(
                offset: const Offset(0, 50),
                onSelected: (value) {
                  if (value == "profile") {
                    print("Hồ sơ");
                  } else if (value == "setting") {
                    print("Cài đặt");
                  } else if (value == "logout") {
                    context.read<AuthBloc>().add(
                      LogoutRequested(),
                    );
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "profile",
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 10),
                        Text("Hồ sơ"),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: "setting",
                    child: Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 10),
                        Text("Cài đặt"),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: "logout",
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 10),
                        Text("Đăng xuất"),
                      ],
                    ),
                  ),
                ],
                child: const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("assets/image/new1.png"),
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 5,
          left: 15,
          right: 15,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Tìm kiếm sản phẩm bảo hiểm",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10), // Khoảng cách giữa search và nút thông báo
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_none, color: Colors.black54),
                      onPressed: () {
                      },
                    ),
                    // Chấm đỏ thông báo
                    Positioned(
                      right: 12,
                      top: 12,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}//AppBar
class Title extends StatelessWidget {
  final String title;
  const Title(this.title, {super.key});
  @override
  Widget build(BuildContext context) {
    return Text(title,style: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),);
  }
}//Tao title mau do
class CategoryBar extends StatefulWidget {
  const CategoryBar({super.key});

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}
class _CategoryBarState extends State<CategoryBar> {
  int _selectedIndex = 0;
  final List<String> _categories = [
    "Tất cả", "Sức khỏe", "Du lịch", "Nhà cửa", "Xe cộ", "Tai nạn", "Nhân thọ", "Hưu trí"
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 15),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ?  AppColor.appButtonColor : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _categories[index],
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
class InsuranceService {
  final String title;
  final IconData icon;
  InsuranceService(this.title, this.icon);
}
class ServiceGridSection1 extends StatelessWidget {
  const ServiceGridSection1({super.key});
  @override
  Widget build(BuildContext context) {
    // Danh sách dữ liệu (Sau này có thể lấy từ API)
    final List<InsuranceService> services = [
      InsuranceService("BH sức khỏe\nvà tai nạn", Icons.medical_services_outlined),
      InsuranceService("BH tai nạn\ncon người", Icons.person_outline),
      InsuranceService("BH du lịch\nViệt Nam", Icons.luggage_outlined),
      InsuranceService("BH TNDS\nxe máy", Icons.moped_outlined),
      InsuranceService("BH TNDS\nxe ô tô", Icons.directions_car_outlined),
      InsuranceService("BH\nnhà tư nhân", Icons.home_outlined),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GridView.builder(
        shrinkWrap: true, // Để GridView không chiếm hết chiều cao màn hình
        physics: const NeverScrollableScrollPhysics(), // Để nó cuộn mượt theo trang chính
        itemCount: services.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 cột
        ),
        itemBuilder: (context, index) {
          return _buildServiceItem(services[index]);
        },
      ),
    );
  }
  // Hàm phụ để vẽ từng ô item (cho code sạch hơn)
  Widget _buildServiceItem(InsuranceService service) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
              ),
            ],
          ),
          child: Icon(
            service.icon,
            color: AppColor.appButtonColor,
            size: 32,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          service.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            height: 1.2, // Khoảng cách giữa các dòng chữ
          ),
        ),
      ],
    );
  }
}
class ServiceGridSection2 extends StatelessWidget {
  const ServiceGridSection2({super.key});
  @override
  Widget build(BuildContext context) {
    // Danh sách dữ liệu (Sau này có thể lấy từ API)
    final List<InsuranceService> services = [
      InsuranceService("BH sức khỏe\nvà tai nạn", Icons.medical_services_outlined),
      InsuranceService("BH tai nạn\ncon người", Icons.person_outline),
      InsuranceService("BH du lịch\nViệt Nam", Icons.luggage_outlined),
      InsuranceService("BH TNDS\nxe máy", Icons.moped_outlined),
      InsuranceService("BH TNDS\nxe ô tô", Icons.directions_car_outlined),
      InsuranceService("BH\nnhà tư nhân", Icons.home_outlined),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GridView.builder(
        shrinkWrap: true, // Để GridView không chiếm hết chiều cao màn hình
        physics: const NeverScrollableScrollPhysics(), // Để nó cuộn mượt theo trang chính
        itemCount: services.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 cột
        ),
        itemBuilder: (context, index) {
          return _buildServiceItem(services[index]);
        },
      ),
    );
  }
  // Hàm phụ để vẽ từng ô item (cho code sạch hơn)
  Widget _buildServiceItem(InsuranceService service) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
              ),
            ],
          ),
          child: Icon(
            service.icon,
            color: AppColor.appButtonColor,
            size: 32,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          service.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            height: 1.2, // Khoảng cách giữa các dòng chữ
          ),
        ),
      ],
    );
  }
}
class TitleExtend extends StatelessWidget {
  final String title;
  const TitleExtend(this.title, {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),),
        TextButton(onPressed: (){}, child: Text("Xem tất cả",style: TextStyle(fontSize: 16,color: Colors.green),))
      ],
    );
  }
}//Tao title mau do + nut xem them
class OfferCard extends StatelessWidget {
  const OfferCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CONTAINER 1: CHỨA ẢNH (BÊN TRÁI)
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32), // Màu nền xanh
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage("assets/image/new1.png"), // Thay bằng ảnh của bạn
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12), // Khoảng cách giữa 2 container

          // CONTAINER 2: CHỨA CHỮ (BÊN PHẢI)
          Expanded(
            child: Container(
              // Bạn có thể thêm padding hoặc decoration riêng cho khối chữ ở đây
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ưu đãi 10% bảo hiểm Sức khoẻ (Text tối đa 2 dòng)",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontFamily: 'Roboto',
                          ),
                          children: [
                            const TextSpan(
                              text: "Hạn sử dụng: ",
                            ),
                            TextSpan(
                              text: "90 ngày",
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColor.appButtonColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Chi tiết",
                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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

    Color activeColor = AppColor.appButtonColor;
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
              color: isSelected ? activeColor : (isCenter ? null : inactiveColor),
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
      child: SafeArea( // Quan trọng để tránh Home bar của iPhone
        child: Row(
          // Không cần spaceAround nữa vì đã có Expanded chia đều
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
