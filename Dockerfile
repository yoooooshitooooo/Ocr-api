# Python 3.9 の公式 Docker イメージを使用
FROM python:3.9

# 必要なパッケージをインストール（Tesseract OCR & 日本語データ）
RUN apt-get update && \
    apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-jpn \
    tesseract-ocr-eng \
    libtesseract-dev && \
    apt-get clean

# Python がインストールされているか確認
RUN which python3 && python3 --version

# `python3` を `python` として使えるようにする
RUN ln -s /usr/bin/python3 /usr/bin/python

# Tesseract のPATHを設定
ENV TESSDATA_PREFIX="/usr/share/tesseract-ocr/4.00/tessdata/"

# 作業ディレクトリを設定
WORKDIR /app

# 必要なファイルをコンテナにコピー
COPY . /app

# Python ライブラリをインストール
RUN pip install --no-cache-dir -r requirements.txt

# Tesseract のインストール確認
RUN which tesseract && tesseract --version

# サーバーを起動
CMD ["python3", "ocr.py"]
