# Python 3.9 の公式 Docker イメージを使用
FROM python:3.9

# 必要なパッケージをインストール（Tesseract OCR & 日本語データ）
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-jpn \
    tesseract-ocr-eng \
    libtesseract-dev \
    && apt-get clean

# 確認のために Tesseract のバージョンを表示（デバッグ用）
RUN echo "=== Checking Tesseract Version ===" && tesseract --version

# 環境変数を設定（Tesseract のデータフォルダを指定）
ENV TESSDATA_PREFIX=/usr/share/tesseract-ocr/4.00/tessdata/

# 作業ディレクトリを設定
WORKDIR /app

# 必要なファイルをコンテナにコピー
COPY . /app

# Python ライブラリをインストール
RUN pip install --no-cache-dir -r requirements.txt

# Tesseract の言語リストを表示（デバッグ用）
RUN echo "=== Installed Tesseract Languages ===" && tesseract --list-langs

# サーバーを起動
CMD ["python", "ocr.py"]
