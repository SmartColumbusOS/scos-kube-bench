FROM aquasec/kube-bench:latest

COPY ./kube-bench-wrapped.sh ./kube-bench-wrapped.sh

RUN ["chmod", "+x", "./kube-bench-wrapped.sh"]

ENTRYPOINT [ "./kube-bench-wrapped.sh" ]