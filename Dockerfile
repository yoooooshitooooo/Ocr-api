# Python 3.9 の公式 Docker イメージを使用
FROM python:3.9

# 必要なパッケージをインストール
RUN apt-get update && \
    apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-jpn \
    tesseract-ocr-eng \
    libtesseract-dev \
    python3-pip && \
    apt-get clean

# `python` コマンドがない問題を修正
RUN ln -s /usr/bin/python3 /usr/bin/python

# 作業ディレクトリを設定
WORKDIR /app

# 必要なファイルをコピー
COPY . /app

# Pythonライブラリをインストール
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Tesseract のインストール確認
RUN which tesseract && tesseract --version

# サーバーを起動
CMD ["python3", "ocr.py"]
