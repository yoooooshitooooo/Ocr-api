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

# `tesseract` コマンドが存在するか確認（ログに出力）
RUN echo "Checking Tesseract installation..." && \
    which tesseract && \
    tesseract --version

# `PATH` を明示的に設定
ENV PATH="/usr/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# `TESSDATA_PREFIX` の設定（パスの微調整）
ENV TESSDATA_PREFIX="/usr/share/tesseract-ocr/tessdata/"

# 作業ディレクトリを設定
WORKDIR /app

# 必要なファイルをコンテナにコピー
COPY . /app

# Python ライブラリをインストール
RUN pip install --no-cache-dir -r requirements.txt

# `tesseract` のインストール確認（デバッグ用）
RUN tesseract --version

# デバッグ用: tesseract のフルパスを取得
RUN echo "Tesseract path:" && ls -l /usr/bin/tesseract

# サーバーを起動
CMD ["python", "ocr.py"]
