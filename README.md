# Thu Thập Tin Tức Kenh14 Bằng Robot Framework

Dự án này là một trình crawler đơn giản sử dụng **Robot Framework** và **Selenium** để tự động thu thập các bài viết từ chuyên mục "Đời sống" trên trang [Kenh14.vn](https://kenh14.vn/) vào lúc **6h sáng mỗi ngày**.

## Tính Năng
- Mở trang chủ Kenh14.vn.
- Click vào mục **Đời sống**
- Lấy dữ liệu các bài viết gồm:
  - **Tiêu đề**
  - **Mô tả**
  - **Hình ảnh**
  - **Thời gian**
- Tự động chuyển trang để lấy hết tất cả bài viết.
- Lưu dữ liệu vào file `tintuc.csv`.
- Chạy tự động vào lúc **06:00 sáng mỗi ngày** bằng vòng lặp `WHILE`

## Yêu Cầu

- Python >= 3.7
- Google Chrome
- ChromeDriver (phiên bản phù hợp với Chrome)

## Cài Đặt

1. **Clone dự án:**
   ```bash
   git clone https://github.com/Th0Kh4nh/crawltintuc.git
   cd crawltintuc

2. **Cài đặt các thư viện cần thiết:**
   ```bash
   pip install -r requirements.txt

3. **Clone dự án:**
   ```bash
   Tải ChromeDriver:
   Vào: https://sites.google.com/chromium.org/driver/
   Chọn đúng phiên bản tương ứng với Chrome bạn đang dùng.
   Giải nén và đặt vào thư mục hệ thống hoặc cùng thư mục với project.

## Cách Chạy
   ```bash
   robot crawlVN.robot