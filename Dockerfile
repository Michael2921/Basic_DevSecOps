FROM dhi.io/python:3-dev AS builder

WORKDIR /home/app

COPY requirements.txt .

RUN pip install --target=/home/app/dependencies -r requirements.txt

FROM cgr.dev/chainguard/python:latest-dev

WORKDIR /home/app

COPY --from=builder /home/app/dependencies /home/app/dependencies

COPY app.py .

ENV PYTHONPATH=/home/app/dependencies

CMD ["app.py"]


