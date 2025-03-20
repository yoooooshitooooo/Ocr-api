# 軽量なAlpine LinuxベースのPython 3.9を使用
FROM python:3.9-alpine

# 必要な環境変数を設定
ENV TESSDATA_PREFIX="/usr/share/tessdata"

# 必要なパッケージをインストール
RUN apk add --no-cache \
    tesseract-ocr \
    tesseract-ocr-data-eng \
    tesseract-ocr-data-jpn \
    libtesseract

# 作業ディレクトリの設定
WORKDIR /app

# アプリケーションのファイルをコンテナにコピー
COPY . /app

# Pythonライブラリをインストール
RUN pip install --no-cache-dir -r requirements.txt

# Tesseractの動作確認
RUN which tesseract && tesseract --version

# アプリケーションを実行
CMD ["python", "ocr.py"]
