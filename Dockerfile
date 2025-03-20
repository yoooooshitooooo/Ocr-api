# Python 3.9 の公式 Docker イメージを使用
FROM python:3.9

# 必要なパッケージをインストール（Tesseract OCR & 日本語データ）
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:alex-p/tesseract-ocr-devel && \
    apt-get update && \
    apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-jpn \
    tesseract-ocr-eng \
    libtesseract-dev && \
    apt-get clean

# Tesseract のPATHを設定
ENV PATH="/usr/bin/:${PATH}"
ENV TESSDATA_PREFIX="/usr/share/tesseract-ocr/4.00/tessdata/"

# 作業ディレクトリを設定
WORKDIR /app

# 必要なファイルをコンテナにコピー
COPY . /app

# Python ライブラリをインストール
RUN pip install --no-cache-dir -r requirements.txt

# デバッグ用（Tesseractがインストールされているか確認）
RUN echo "=== Checking Tesseract Version ===" && which tesseract && tesseract --version
RUN echo "=== Installed Tesseract Languages ===" && tesseract --list-langs

# サーバーを起動
CMD ["python", "ocr.py"]
