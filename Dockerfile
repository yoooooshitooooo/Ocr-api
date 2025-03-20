# Python 3.9 の公式 Docker イメージを使用
FROM python:3.9

# 必要なパッケージをインストール
RUN apt-get update && \
    apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-jpn \
    tesseract-ocr-eng \
    libtesseract-dev && \
    apt-get clean

# `tesseract` コマンドの確認（デバッグ用）
RUN echo "Checking Tesseract installation..." && \
    ls -l /usr/bin/tesseract && \
    ls -l /usr/local/bin/tesseract && \
    which tesseract && \
    tesseract --version

# `PATH` を明示的に設定
ENV PATH="/usr/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# `TESSDATA_PREFIX` の設定
ENV TESSDATA_PREFIX="/usr/share/tesseract-ocr/4.00/tessdata/"

# 作業ディレクトリを設定
WORKDIR /app

# 必要なファイルをコンテナにコピー
COPY . /app

# Python ライブラリをインストール
RUN pip install --no-cache-dir -r requirements.txt

# `tesseract` のインストール確認（デバッグ用）
RUN tesseract --version

# サーバーを起動
CMD ["python", "ocr.py"]
