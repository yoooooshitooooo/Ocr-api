# UbuntuベースのPythonイメージを使用（書き込み可能な環境にする）
FROM ubuntu:20.04

# 必要な環境変数を設定
ENV DEBIAN_FRONTEND=noninteractive
ENV TESSDATA_PREFIX="/usr/share/tesseract-ocr/4.00/tessdata/"

# 必要なパッケージをインストール（apt-get update を回避）
RUN apt update && \
    apt install -y \
    python3 python3-pip \
    tesseract-ocr \
    tesseract-ocr-jpn \
    tesseract-ocr-eng \
    libtesseract-dev \
    lsb-release && \
    rm -rf /var/lib/apt/lists/*  # これで不要なキャッシュを削除

# Tesseract のシンボリックリンクを作成
RUN ln -s /usr/bin/tesseract /usr/local/bin/tesseract

# Pythonのライブラリをインストール
WORKDIR /app
COPY . /app
RUN pip3 install --no-cache-dir -r requirements.txt

# Tesseractのインストール確認
RUN which tesseract && tesseract --version

# サーバーを起動
CMD ["python3", "ocr.py"]
