import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/text_button_app.dart';
import 'xacnhanthongtin_tai_nan_con_nguoi.dart';

class InvoiceModel {
  final String companyName;
  final String taxCode;
  final String phoneNumber;
  final String address;

  InvoiceModel({
    required this.companyName,
    required this.taxCode,
    required this.phoneNumber,
    required this.address,
  });
}

class NhapTayThongTinScreen extends StatefulWidget {
  final Map<String, dynamic> sanPham;
  const NhapTayThongTinScreen({super.key, required this.sanPham});
  @override
  State<NhapTayThongTinScreen> createState() => _NhapTayThongTinScreenState();
}

class _NhapTayThongTinScreenState extends State<NhapTayThongTinScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isInvoiceEnabled = false;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? birthDate;
  String selectedGender = "";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  InvoiceModel? savedInvoiceData;

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "";
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  void _showRequiredSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleContinue() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (birthDate == null) {
      _showRequiredSnackBar("Vui lòng chọn Ngày sinh");
      return;
    }
    if (selectedGender.isEmpty) {
      _showRequiredSnackBar("Vui lòng chọn Giới tính");
      return;
    }
    if (startDate == null) {
      _showRequiredSnackBar("Vui lòng chọn Ngày bắt đầu hiệu lực");
      return;
    }
    if (endDate == null) {
      _showRequiredSnackBar("Vui lòng chọn Ngày hết hiệu lực");
      return;
    }

    if (endDate!.isBefore(startDate!)) {
      _showRequiredSnackBar("Ngày hết hiệu lực phải sau Ngày bắt đầu");
      return;
    }

    if (isInvoiceEnabled && savedInvoiceData == null) {
      _openInvoiceForm();
      return;
    }

    _navigateToNextScreen();
  }
  void _openInvoiceForm() async {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return InvoiceBottomSheetContent(initialData: savedInvoiceData, isDarkParent: isDark);
      },
    );
    if (result != null && result is InvoiceModel) {
      setState(() {
        savedInvoiceData = result;
      });
    }
  }

  void _navigateToNextScreen() {
    final Map<String, dynamic> personalData = {
      "sanPham": widget.sanPham,
      "name": _nameController.text.trim(),
      "birthDate": birthDate,
      "gender": selectedGender,
      "idNumber": _idController.text.trim(),
      "phone": _phoneController.text.trim(),
      "email": _emailController.text.trim(),
      "startDate": startDate,
      "endDate": endDate,
      "invoiceData": savedInvoiceData,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => XacNhanThongTinScreen(dataPacket: personalData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBarHome("Thông tin người được bảo hiểm"),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      isDark,
                      icon: Icons.person_outline,
                      label: "Họ và tên *",
                      controller: _nameController,
                      validator: (value) => (value == null || value.trim().isEmpty) ? "Vui lòng nhập họ và tên" : null,
                    ),
                    _buildDropdownField(
                      isDark,
                      icon: Icons.calendar_today_outlined,
                      label: "Ngày sinh *",
                      onPress: () => _selectBirthDate(context),
                      value: _formatDate(birthDate),
                    ),
                    _buildDropdownField(
                      isDark,
                      icon: Icons.person_pin_outlined,
                      label: "Giới tính *",
                      onPress: () => _showGenderPicker(context),
                      value: selectedGender,
                    ),
                    _buildTextField(
                      isDark,
                      icon: Icons.badge_outlined,
                      label: "CMND/CCCD/Hộ chiếu *",
                      controller: _idController,
                      keyboardType: TextInputType.number,
                      maxLength: 12,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return "Vui lòng nhập số CMND/CCCD/Hộ chiếu";
                        if (value.trim().length != 12) return "Số Căn cước công dân bắt buộc phải đủ 12 số";
                        return null;
                      },
                    ),
                    _buildTextField(
                      isDark,
                      icon: Icons.phone_android_outlined,
                      label: "Số điện thoại *",
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 11,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return "Vui lòng nhập số điện thoại";
                        final len = value.trim().length;
                        if (len != 10 && len != 11) {
                          return "Số điện thoại phải có độ dài 10 hoặc 11 số";
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      isDark,
                      icon: Icons.email_outlined,
                      label: "Email *",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return "Vui lòng nhập email";
                        final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if (!emailRegex.hasMatch(value.trim())) return "Định dạng Email không hợp lệ";
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      "Thời hạn bảo hiểm",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    _buildDropdownField(
                      isDark,
                      icon: Icons.calendar_today_outlined,
                      label: "Ngày bắt đầu hiệu lực *",
                      onPress: () => _selectStartDate(context),
                      value: _formatDate(startDate),
                    ),
                    _buildDropdownField(
                      isDark,
                      icon: Icons.calendar_today_outlined,
                      label: "Ngày hết hiệu lực *",
                      onPress: () => _selectEndDate(context),
                      value: _formatDate(endDate),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tôi muốn nhận Hoá đơn điện tử",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,  color: isDark ? AppColor.textDark: AppColor.textLight),
                        ),
                        Switch(
                          value: isInvoiceEnabled,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            setState(() {
                              isInvoiceEnabled = value;
                              if (!value) {
                                savedInvoiceData = null;
                              }
                            });
                          },
                        ),
                      ],
                    ),

                    if (isInvoiceEnabled && savedInvoiceData != null) ...[
                      const SizedBox(height: 12),
                      _buildInvoiceSummaryCard(isDark),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColor.containerDark : AppColor.containerLight,
              border: Border(top: BorderSide(color: isDark ? Colors.white : Colors.grey.shade200)),
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButtonApp("Tiếp tục", _handleContinue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceSummaryCard(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColor.containerDark: AppColor.containerLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isDark ? Colors.white : const Color(0xFFC8E6C9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Thông tin xuất hóa đơn",
                  style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? AppColor.textDark : AppColor.textLight, fontSize: 14),
                ),
                InkWell(
                  onTap: _openInvoiceForm,
                  child: const Row(
                    children: [
                      Text(
                        "Chỉnh sửa",
                        style: TextStyle(color: AppColor.appButtonColor, fontWeight: FontWeight.w500, fontSize: 13),
                      ),
                      Icon(Icons.chevron_right, color: AppColor.appButtonColor, size: 16),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(height: 1, color: isDark ? Colors.white : const Color(0xFFC8E6C9)),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _buildSummaryRow(isDark, "Tên đơn vị:", savedInvoiceData!.companyName),
                _buildSummaryRow(isDark, "Mã số thuế:", savedInvoiceData!.taxCode),
                _buildSummaryRow(isDark, "Điện thoại:", savedInvoiceData!.phoneNumber),
                _buildSummaryRow(isDark, "Địa chỉ:", savedInvoiceData!.address),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSummaryRow(bool isDark, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 90, child: Text(title, style: TextStyle( color: isDark ? AppColor.textDark: AppColor.textLight, fontSize: 13))),
          Expanded(
            child: Text(
              content,
              style: TextStyle( color: isDark ? AppColor.textDark: AppColor.textLight, fontWeight: FontWeight.w400, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      bool isDark, {
        required IconData icon,
        required String label,
        required TextEditingController controller,
        String? Function(String?)? validator,
        TextInputType keyboardType = TextInputType.text,
        int? maxLength,
        List<TextInputFormatter>? inputFormatters,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColor.containerDark: AppColor.containerLight,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.05), blurRadius: 4, offset: const Offset(0, 2)),
        ],
        border: Border.all(color: isDark ? Colors.white : Colors.grey.shade200),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        style: TextStyle( color: isDark ? AppColor.textDark: AppColor.textLight,),
        decoration: InputDecoration(
          prefixIcon: Icon(icon,color: AppColor.iconColor, size: 22),
          labelText: label,
          labelStyle: TextStyle( color: isDark ? AppColor.textDark: AppColor.textLight, fontSize: 13),
          border: InputBorder.none,
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          errorStyle: const TextStyle(height: 1.0, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      bool isDark, {
        required IconData icon,
        required String label,
        required VoidCallback onPress,
        String value = "",
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColor.containerDark : AppColor.containerLight,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.05), blurRadius: 4, offset: const Offset(0, 2)),
        ],
        border: Border.all(color: isDark ? Colors.white : Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: onPress,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Row(
            children: [
              Icon(icon, color: AppColor.iconColor, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: TextStyle( color: isDark ? AppColor.textDark: AppColor.textLight, fontSize: 12)),
                    if (value.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          value,
                          style: TextStyle( color: isDark ? AppColor.textDark: AppColor.textLight, fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                  ],
                ),
              ),
              Icon(Icons.keyboard_arrow_down,color: AppColor.iconColor,),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: birthDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            scaffoldBackgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF0A7029),
              brightness: isDark ? Brightness.dark : Brightness.light,
              primary: const Color(0xFF0A7029),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != birthDate) {
      setState(() {
        birthDate = picked;
      });
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF0A7029),
              brightness: isDark ? Brightness.dark : Brightness.light,
              primary: const Color(0xFF0A7029),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF0A7029),
              brightness: isDark ? Brightness.dark : Brightness.light,
              primary: const Color(0xFF0A7029),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        endDate = picked;
      });
    }
  }

  void _showGenderPicker(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColor.containerDark: AppColor.containerLight,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Chọn giới tính",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: isDark ? AppColor.textDark: AppColor.textLight),
              ),
              Divider(color: isDark ? Colors.white12 : Colors.grey.shade300),
              ListTile(
                leading: const Icon(Icons.male, color: Colors.blue),
                title: Text("Nam", style: TextStyle( color: isDark ? AppColor.textDark: AppColor.textLight)),
                onTap: () {
                  setState(() => selectedGender = "Nam");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.female, color: Colors.pink),
                title: Text("Nữ", style: TextStyle( color: isDark ? AppColor.textDark: AppColor.textLight)),
                onTap: () {
                  setState(() => selectedGender = "Nữ");
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

class InvoiceBottomSheetContent extends StatefulWidget {
  final InvoiceModel? initialData;
  final bool isDarkParent;
  const InvoiceBottomSheetContent({super.key, this.initialData, required this.isDarkParent});
  @override
  State<InvoiceBottomSheetContent> createState() => _InvoiceBottomSheetContentState();
}

class _InvoiceBottomSheetContentState extends State<InvoiceBottomSheetContent> {
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _taxCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _companyController.text = widget.initialData!.companyName;
      _taxCodeController.text = widget.initialData!.taxCode;
      _phoneController.text = widget.initialData!.phoneNumber;
      _addressController.text = widget.initialData!.address;
    }

    _companyController.addListener(_validateForm);
    _taxCodeController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _addressController.addListener(_validateForm);

    _validateForm();
  }

  @override
  void dispose() {
    _companyController.dispose();
    _taxCodeController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid = _companyController.text.trim().isNotEmpty &&
        _taxCodeController.text.trim().isNotEmpty &&
        _phoneController.text.trim().isNotEmpty &&
        _addressController.text.trim().isNotEmpty;

    if (isValid != isFormValid) {
      setState(() {
        isFormValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = widget.isDarkParent;

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColor.containerDark : AppColor.containerLight,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24),
                Text(
                  "Hoá đơn điện tử",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? AppColor.textDark : AppColor.textLight),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: AppColor.iconColor),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            Divider(height: 1, color: isDark ? Colors.white : Colors.grey.shade300),
            const SizedBox(height: 16),

            _buildInvoiceField(isDark, Icons.domain, "Tên cá nhân/tổ chức *", _companyController),
            _buildInvoiceField(
              isDark,
              Icons.receipt_long,
              "Mã số thuế *",
              _taxCodeController,
              keyboardType: TextInputType.number,
              maxLength: 14,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            _buildInvoiceField(
              isDark,
              Icons.phone_android,
              "Số điện thoại *",
              _phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 11,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            _buildInvoiceField(isDark, Icons.place_outlined, "Địa chỉ người mua *", _addressController),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        backgroundColor:isDark ? Color(0xFFEAEAEA) : Color(0xFFFFF4D8),
                        side: const BorderSide(color: Colors.transparent),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Huỷ", style: TextStyle(color: AppColor.appButtonColor, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: isFormValid ? () {
                        final invoiceData = InvoiceModel(
                          companyName: _companyController.text.trim(),
                          taxCode: _taxCodeController.text.trim(),
                          phoneNumber: _phoneController.text.trim(),
                          address: _addressController.text.trim(),
                        );
                        Navigator.pop(context, invoiceData);
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.appButtonColor,
                        disabledBackgroundColor: isDark ? Colors.white12 : Colors.grey.shade200,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        "Xác nhận",
                        style: TextStyle(
                          color: isFormValid ? Colors.white : (isDark ? AppColor.iconColor : AppColor.textLight),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceField(
      bool isDark,
      IconData icon,
      String label,
      TextEditingController controller, {
        TextInputType? keyboardType,
        int? maxLength,
        List<TextInputFormatter>? inputFormatters,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColor.containerDark : AppColor.containerLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isDark ? Colors.white : Colors.grey.shade200),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        style: TextStyle(color: isDark ? AppColor.textDark : AppColor.textLight,),
        decoration: InputDecoration(
          prefixIcon: Icon(icon,color: AppColor.iconColor, size: 22),
          labelText: label,
          labelStyle: TextStyle(color: isDark ? AppColor.textDark : AppColor.textLight, fontSize: 13),
          border: InputBorder.none,
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
      ),
    );
  }
}