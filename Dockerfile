# Python 3.9 の公式 Docker イメージを使用
FROM python:3.9

# 必要なパッケージをインストール（Tesseract OCR & 日本語データ）
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

# `tesseract` のパスを確認して明示的に設定
RUN echo "Checking Tesseract installation..." && \
    which tesseract && \
    tesseract --version

# `tesseract` のパス設定を環境変数として追加
ENV TESSERACT_PATH="/usr/bin/tesseract"
ENV PATH="${TESSERACT_PATH}:${PATH}"
ENV TESSDATA_PREFIX="/usr/share/tesseract-ocr/4.00/tessdata/"

# 作業ディレクトリを設定
WORKDIR /app

# 必要なファイルをコンテナにコピー
COPY . /app

# Python ライブラリをインストール
RUN pip install --no-cache-dir -r requirements.txt

# デバッグ用: Tesseract の動作確認
RUN which tesseract && tesseract --version

# サーバーを起動
CMD ["python", "ocr.py"]
