# HDI

HDI là ứng dụng di động giúp khách hàng tìm hiểu và tham gia bảo hiểm tai nạn con người. Người dùng có thể xem và so sánh các gói bảo hiểm, nhập thông tin người được bảo hiểm, tải/chụp giấy tờ cần thiết và thực hiện thanh toán.

Dự án gồm ứng dụng Flutter cho khách hàng và REST API Spring Boot. Backend xử lý đăng ký, đăng nhập, làm mới/đăng xuất phiên, hồ sơ người dùng và dashboard quản trị; dữ liệu được lưu trong MySQL.

## Công nghệ

- Frontend: Flutter, Dart, BLoC, Dio và Firebase Authentication/Cloud Firestore.
- Backend: Java 17, Spring Boot 4.1, Spring Data JPA, Spring Security và MySQL.

## Cấu trúc dự án

```text
.
|-- hdi_frontend/    # Ứng dụng Flutter
|-- hdi_backend/     # REST API Spring Boot
`-- README.md
```

## Yêu cầu

- Flutter SDK với Dart 3.11.5 trở lên.
- JDK 17.
- MySQL Server.
- Android Studio hoặc thiết bị/emulator được Flutter hỗ trợ.

## Chạy backend

1. Đảm bảo MySQL đang chạy và tạo database `hdi_db` (hoặc sử dụng JDBC URL khác).
2. Cấu hình thông tin kết nối database và khóa JWT bằng biến môi trường:

   - `SPRING_DATASOURCE_URL`: JDBC URL, ví dụ `jdbc:mysql://localhost:3306/hdi_db?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=Asia/Ho_Chi_Minh`.
   - `SPRING_DATASOURCE_USERNAME` và `SPRING_DATASOURCE_PASSWORD`: tài khoản MySQL.
   - `JWT_SECRET`: khóa bí mật đủ mạnh để ký token.
   - `JWT_EXPIRATION`: thời hạn token tính bằng mili giây (tùy chọn).

   Các biến môi trường có thể dùng để ghi đè cấu hình Spring Boot. Không commit mật khẩu hoặc khóa JWT thật vào Git. Nếu credential đã bị chia sẻ, hãy thay/thu hồi chúng.

3. Từ thư mục `hdi_backend`, chạy backend:

   ```powershell
   .\mvnw.cmd spring-boot:run
   ```

   Backend mặc định lắng nghe tại `http://localhost:8080`. Chạy kiểm thử bằng `.\mvnw.cmd test` trên Windows hoặc `./mvnw test` trên macOS/Linux.

## Chạy frontend

1. Đảm bảo backend đang chạy tại cổng 8080.
2. Từ thư mục `hdi_frontend`, tải dependencies và khởi động ứng dụng:

   ```powershell
   flutter pub get
   flutter run
   ```

   Android emulator mặc định truy cập backend qua `http://10.0.2.2:8080`. Với thiết bị thật hoặc nền tảng khác, cập nhật địa chỉ API trong `lib/features/auth/data/datasource/auth_api.dart`.

3. Cấu hình Firebase phù hợp với ứng dụng trước khi sử dụng các tính năng Firebase.

Kiểm tra frontend từ thư mục `hdi_frontend`:

```powershell
flutter analyze
flutter test
```

## API hiện có

- `POST /api/auth/register`
- `POST /api/auth/login`
- `POST /api/auth/refresh`
- `POST /api/auth/logout`
- `GET /api/user/profile`
- `GET /api/admin/dashboard`