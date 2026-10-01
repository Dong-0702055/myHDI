
import 'package:flutter/material.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../core/widgets/text_button_app.dart';
import '../../../home/presentation/pages/home_custom.dart';
import 'dotuoi_tai_nan_con_nguoi.dart';
import 'product_tai_nan_con_nguoi.dart';
import 'boithuong_tai_nan_con_nguoi.dart';
import 'cauhoi_tai_nan_con_nguoi.dart';

class HomeTaiNanConNguoi extends StatelessWidget{
  const HomeTaiNanConNguoi({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageHome(),
            BodyTaiNanConNguoi(),
          ],
        ),
      )
    );
  }
}
class BodyTaiNanConNguoi extends StatefulWidget {
  @override
  State<BodyTaiNanConNguoi> createState() => _BodyTaiNanConNguoiState();
}
class ImageHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        Container(
          child: Image(image: AssetImage("assets/image/tai_nan_con_nguoi.png"),
            width: double.infinity,
            fit: BoxFit.cover,
          )
      ),
        Positioned(
          top: 40,
          left: 16,
          child: Container(
            decoration: BoxDecoration(
              color:  isDark ? AppColor.containerDark : AppColor.containerLight,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              color: AppColor.iconColor,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context)=>HomeCustom()));
              },
            ),
          ),
        ),
      ]
    );
  }
}
class _BodyTaiNanConNguoiState extends State<BodyTaiNanConNguoi>{
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _hoveredIndex = -1;
  List<bool> _isFavorited = [false,false,false];
  final List<String> _pageTexts = [
    "Xem chi tiết",
    "Độ tuổi áp dụng",
    "Quyền lợi bảo hiểm"
  ];
  final List<String> _pageTitles = [
    "Bảo hiểm tai nạn con người",
    "Độ tuổi áp dụng & Quy tắc bảo hiểm",
    "Độ tuổi áp dụng & Quy tắc bảo hiểm",
  ];
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Transform.translate(
        offset: const Offset(0, -7),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDark ? AppColor.containerDark : AppColor.containerLight,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 390,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      _buildPageOne(),
                      _buildPageTwo(),
                      _buildPageThree(isDark),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    bool isActive = _currentPage == index;
                    return MouseRegion(
                      onEnter: (_) => setState(() => _hoveredIndex = index),
                      onExit: (_) => setState(() => _hoveredIndex = -1),
                      child: GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: isActive ? 30 : 8,
                          decoration: BoxDecoration(
                            color: isActive ? AppColor.appButtonColor : Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 4),
                Opacity(
                  opacity: _hoveredIndex != -1 ? 1.0 : 0.0,
                  child: Column(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        transform: Matrix4.rotationZ(0.785),
                        decoration: const BoxDecoration(color: Color(0xFF333333)),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -6),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF333333),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _pageTexts[_hoveredIndex != -1 ? _hoveredIndex : 0],
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildClaimServiceButton(
                      image: ("assets/image/giai_quyet_quyen_loi.png"),
                      text1: "Bồi thường",
                      onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) =>  BoiThuongModal(),
                      );
                    },
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: _buildClaimServiceButton(
                      image: ("assets/image/giai_quyet_quyen_loi.png"),
                      text1: "Câu hỏi",
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) =>  CauhoiTaiNanConNguoi());
                    }
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 20),
            child: TextButtonApp("Tham gia ngay", (){
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => ChonDoTuoiModal(),
              );
            }
            )
          )
        ],
      ),
    );
  }
  // Hàm vẽ phần Header cho mỗi trang (Tiêu đề + Trái tim + Nét đứt)
  Widget _buildPageHeader(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _pageTitles[index],
                style: const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() { _isFavorited[index] = !_isFavorited[index]; });
              },
              icon: Icon(_isFavorited[index] ? Icons.favorite : Icons.favorite_border),
              color: _isFavorited[index] ? Colors.red : Colors.grey,
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(100, (index) => Expanded(
              child: Container(color: index % 2 == 0 ? Colors.grey.shade300 : Colors.transparent, height: 1),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
  // Widget nội dung cho Trang 1
  Widget _buildPageOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPageHeader(0),
        _buildBenefitRow("Bảo vệ bản thân và những người thân yêu không chỉ là sự quan tâm, mà còn là trách nhiệm."),
        const SizedBox(height: 15),
        _buildBenefitRow("Gói bảo hiểm này không chỉ mang đến ưu đãi vượt trội, mà còn cung cấp các quyền lợi bảo hiểm tốt nhất."),
        const SizedBox(height: 15),
        _buildBenefitRow("Vì vậy, hãy lựa chọn gói bảo hiểm tai nạn con người của Bảo hiểm HD để sở hữu biện pháp tối ưu trong việc đảm bảo an toàn"),
        const SizedBox(height: 15),
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  ProductTaiNanConNguoi()),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(onPressed: (){}, child: Text("Xem chi tiết sản phẩm", style: TextStyle(color: AppColor.appButtonColor, fontSize: 16))),
                const Icon(Icons.keyboard_arrow_down_outlined, color: AppColor.appButtonColor)
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildBenefitRow(String content) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset("assets/image/protect.png", width: 24, height: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            content,
            style: TextStyle(fontSize: 16, height: 1.4, color: isDark ? AppColor.textDark: AppColor.textLight),
          ),
        ),
      ],
    );
  }
  // Widget nội dung cho Trang 2
  Widget _buildPageTwo() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPageHeader(1),
        _buildDetailRow(
          "Đối tượng tham gia bảo hiểm:",
          "Mọi công dân Việt Nam hoặc Người nước ngoài sinh sống hợp pháp tại Việt Nam từ 18 đến 65 tuổi",
        ),
        const SizedBox(height: 15),
        _buildDetailRow(
          "Thời hạn bảo hiểm:",
          "1 năm",
        ),
        const SizedBox(height: 15),
        _buildDetailRow(
          "Hình thức hợp đồng",
          "Giấy chứng nhận bảo hiểm điện tử",
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 14,color: isDark ? AppColor.textDark : AppColor.textLight),
            children: [
              const TextSpan(text: "Quy tắc, điều khoản bảo hiểm. Tham khảo "),
              TextSpan(
                text: "Tại đây",
                style: const TextStyle(
                  color: AppColor.appButtonColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
// Hàm bổ trợ để hiển thị Tiêu đề đậm + Nội dung chi tiết bên dưới
  Widget _buildDetailRow(String title, String content) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset("assets/image/protect.png", width: 24, height: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: TextStyle(fontSize: 15,color: isDark ? AppColor.textDark: AppColor.textLight),
              ),
            ],
          ),
        ),
      ],
    );
  }
  // Widget nội dung cho Trang 3
  Widget _buildPageThree(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPageHeader(2),
        _buildBenefitRow(
          "Chủ động bảo vệ bản thân và những người bạn thương yêu bằng gói bảo hiểm chăm sóc sức khoẻ và tai nạn.",
        ),
        const SizedBox(height: 15),
        _buildBenefitRow(
          "Gói bảo hiểm chăm sóc sức khoẻ và tai nạn là lựa chọn tuyệt vời với ưu đãi vượt trội, kèm theo các quyền lợi bảo hiểm ưu việt.",
        ),
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/image/protect.png", width: 24, height: 24),
            const SizedBox(width: 10),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, height: 1.4, color: isDark ? AppColor.textDark: AppColor.textLight ),
                  children: [
                    const TextSpan(
                      text: "Giải quyết chi trả quyền lợi bảo hiểm kịp thời. Hãy để HDI là chỗ dựa tài chính vững chắc, bảo vệ bạn và người thân của bạn. ",
                    ),
                    TextSpan(
                      text: "Xem chi tiết",
                      style: const TextStyle(
                        color: AppColor.appButtonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildClaimServiceButton({image,text1,onTap}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? AppColor.containerDark : AppColor.containerLight,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(image, width: 40, height: 40,),
            const SizedBox(width: 8),
            Expanded(child: Text(text1, maxLines: 2, overflow: TextOverflow.ellipsis,
                style:TextStyle(fontSize: 14, color: isDark ? AppColor.textDark : AppColor.textLight))
            ),
            const SizedBox(width: 20),
            Icon(Icons.arrow_forward, size: 20, color: AppColor.iconColor,)
          ],
        ),
      ),
    );
  }
}


