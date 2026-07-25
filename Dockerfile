FROM dhi.io/python:3-dev AS builder

WORKDIR /home/app

COPY requirements.txt .

RUN pip install -r requirements.txt

FROM cgr.dev/chainguard/python

WORKDIR /home/app

COPY --from=builder /home/app /home/app

COPY app.py .

CMD ["python", "app.py"]


