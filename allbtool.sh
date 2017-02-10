#!/bin/bash
#########################################
##  Used to extract and tar all btool  ## 
##  outputs for Splunk Enterprise      ##
##  Written by John Ciavarella         ##
##  2017-02-09                         ##
#########################################
#### Varibables
hostName=`hostname`
declare -a modules=("alert_actions" "app" "audit" "authentication" "authorize" "checklist" "collections" "commands" "crawl" "datamodels" "default.meta" "deploymentclient" "distsearch" "event_renderers" "eventtypes" "fields" "indexes" "inputs" "instance.cfg" "limits" "literals" "macros" "multikv" "outputs" "passwords" "procmon-filters" "props" "pubsub" "restmap" "savedsearches" "searchbnf" "segmenters" "server" "serverclass" "serverclass.seed.xml" "source-classifier" "sourcetypes" "tags" "telemetry" "times" "transactiontypes" "transforms" "ui-prefs" "user-seed" "visualizations" "viewstates" "web" "wmi" "workflow_actions")
date=`date +%s`
date2=`date`

#### Functions
btoolFunction () {
echo -e "$hostName\n$date2\n" >> $CONF.btool
$SPLUNK_HOME/bin/./splunk btool $CONF list --debug >> $CONF.btool
}

if [ -z "$SPLUNK_HOME" ]; then
        echo -e "ERROR: SPLUNK_HOME not set\nPlease set the \$SPLUNK_HOME variable"
else
        for CONF in "${modules[@]}"
        do
                echo "$CONF Running"
                btoolFunction
        done

        tar -cf btool-$hostName-$date.tar *.btool
        rm -rf *.btool

fi 

