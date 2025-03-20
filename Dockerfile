# Python 3.9 の公式 Docker イメージを使用
FROM python:3.9

# 必要なパッケージをインストール（Tesseract OCR & 日本語データ）
RUN mkdir -p /var/lib/apt/lists/partial && apt-get clean
RUN apt-get update && \
    apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-jpn \
    tesseract-ocr-eng \
    libtesseract-dev \
    python3-pip && \
    apt-get clean

# Tesseract のシンボリックリンクを作成
RUN ln -s /usr/bin/tesseract /usr/local/bin/tesseract

# Tesseract コマンドがあるか確認
RUN echo "Checking Tesseract installation..." && \
    which tesseract && \
    tesseract --version

# `PATH` を明示的に設定
ENV PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# 環境変数を設定
ENV TESSDATA_PREFIX="/usr/share/tesseract-ocr/4.00/tessdata/"

# 作業ディレクトリを設定
WORKDIR /app

# 必要なファイルをコンテナにコピー
COPY . /app

# Python ライブラリをインストール
RUN pip install --no-cache-dir -r requirements.txt

# デバッグ用: Tesseract のインストール確認
RUN tesseract --version

# サーバーを起動
CMD ["python", "ocr.py"]
