FROM python:2.7-slim 

RUN mkdir /app 
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py /app/
COPY static /app/static
EXPOSE 9080
WORKDIR /app
CMD python app.py 9080