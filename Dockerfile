FROM mcr.microsoft.com/powershell:alpine-3.13 as posh

SHELL ["pwsh", "-Command"]

COPY scripts /app/
WORKDIR /app

HEALTHCHECK --interval=60s CMD [ "pwsh", "-file", "healthcheck.ps1" ]

#USER root

ENTRYPOINT [ "pwsh" ]
CMD [ "-file", "entry.ps1" ]

FROM posh as pester

RUN Install-module Pester -Force
RUN Invoke-Pester -Output Detailed tests.ps1

CMD [ "-file", "tests.ps1" ]
