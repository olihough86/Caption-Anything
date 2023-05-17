FROM nvidia/cuda:11.8.0-runtime-ubuntu22.04
WORKDIR /app

# Define a sane environment
RUN apt-get update && \
    apt-get install --no-install-recommends -y git vim build-essential python3-dev python3-pip wget && \
    git clone https://github.com/olihough86/Caption-Anything.git .

# Install python reqs
RUN pip install --no-cache-dir -r requirements.txt

# Expose a port
EXPOSE 6086

# Define environment variable
ARG OPENAI_API_KEY
ENV OPENAI_API_KEY=${OPENAI_API_KEY}

RUN wget https://dl.fbaipublicfiles.com/segment_anything/sam_vit_h_4b8939.pth ./sam_vit_h_4b8939.pth

CMD ["python", "app_langchain.py", "--segmenter", "huge", "--captioner", "blip2", "--port", "6086", "--clip_filter"]
