# Python 3.9 の公式イメージを使用
FROM python:3.9

# 環境変数を設定（後でパスエラーを防ぐため）
ENV DEBIAN_FRONTEND=noninteractive
ENV TESSDATA_PREFIX="/usr/share/tesseract-ocr/4.00/tessdata/"

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-jpn \
    tesseract-ocr-eng \
    libtesseract-dev \
    lsb-release && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Tesseract のシンボリックリンクを作成
RUN ln -s /usr/bin/tesseract /usr/local/bin/tesseract

# PATH を設定
ENV PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# 作業ディレクトリを設定
WORKDIR /app

# 必要なファイルをコンテナにコピー
COPY . /app

# Pythonライブラリをインストール
RUN pip install --no-cache-dir -r requirements.txt

# Tesseract のインストール確認
RUN tesseract --version

# サーバーを起動
CMD ["python", "ocr.py"]
