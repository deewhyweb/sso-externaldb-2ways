FROM registry.redhat.io/rh-sso-7/sso74-openshift-rhel8:latest

COPY extensions/postconfigure.sh /opt/eap/extensions/
COPY extensions/actions.cli /opt/eap/extensions/
COPY extensions/postgresql-42.2.19.jar /opt/eap/extensions/jdbc-driver.jar

USER root
RUN chmod 774 /opt/eap/extensions/*.sh
USER jboss

CMD ["/opt/eap/bin/openshift-launch.sh"]
