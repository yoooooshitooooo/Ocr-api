# Python 3.9 の公式 Docker イメージを使用
FROM python:3.9

# 必要なパッケージをインストール（Tesseract OCR & 日本語データ）
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-jpn \
    tesseract-ocr-eng \
    libtesseract-dev \
    && apt-get clean

# Tesseractの環境変数を設定（デフォルトのパスを指定）
ENV TESSDATA_PREFIX=/usr/share/tesseract-ocr/4.00/tessdata/

# 作業ディレクトリを設定
WORKDIR /app

# 必要なファイルをコンテナにコピー
COPY . /app

# 必要な Python ライブラリをインストール
RUN pip install --no-cache-dir -r requirements.txt

# 🔍 デバッグ用コマンド（RenderのLogsで確認できる）
# Tesseract のバージョンを確認
RUN echo "=== Checking Tesseract Version ===" && tesseract --version

# Tesseract の言語データのリストを表示
RUN echo "=== Installed Tesseract Languages ===" && tesseract --list-langs

# 環境変数 `TESSDATA_PREFIX` の値を表示
RUN echo "=== TESSDATA_PREFIX ===" && echo $TESSDATA_PREFIX

# サーバーを起動
CMD ["python", "ocr.py"]
