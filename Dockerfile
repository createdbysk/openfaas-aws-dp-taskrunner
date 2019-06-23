FROM openfaas/classic-watchdog:0.13.4 as watchdog

FROM python:3.7

WORKDIR /home/app

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
COPY . /home/app

RUN chmod +x /usr/bin/fwatchdog 

RUN apt-get update \
    && apt-get install -y \
        jq      \
        default-jre \
        make \
    && rm -rf /var/lib/apt/lists/*

RUN make build

RUN chmod +x docker_entrypoint.sh \
    && chmod +x entrypoint_support.sh

# Add non root user
RUN addgroup app \
    && yes Y | adduser --force-badname --disabled-password --no-create-home --ingroup app app
RUN chown app /home/app

WORKDIR /home/app

USER app

ENV fprocess="/home/app/docker_entrypoint.sh"
# Set to true to see request in function logs
ENV write_debug="true"

EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
