# Python 3.9 の公式 Docker イメージを使用
FROM python:3.9

# 必要なパッケージをインストール（Tesseract OCR & 日本語データ）
RUN apt-get update && apt-get install -y tesseract-ocr \
    && apt-get install -y tesseract-ocr-jpn tesseract-ocr-eng \
    && apt-get install -y libtesseract-dev \
    && apt-get clean

# Tesseractの環境変数を正しく設定（パスを明示）
ENV TESSDATA_PREFIX=/usr/share/tesseract-ocr/4.00/tessdata

# 作業ディレクトリを設定
WORKDIR /app

# 必要なファイルをコンテナにコピー
COPY . /app

# 必要な Python ライブラリをインストール
RUN pip install --no-cache-dir -r requirements.txt

# Tesseractのインストール確認（デバッグ用）
RUN tesseract --list-langs

# サーバーを起動
CMD ["python", "ocr.py"]
