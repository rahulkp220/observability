# observability
A terraform based observability boilerplate that can run on AWS 

## Before you run
* Make sure you have `terraform` installed on your system
* Make sure you have AWS credentials somewhere, the default location being `~/.aws/credentials`, and have a profile created like

```
[your_profile]
aws_access_key_id = "your_access_key"
aws_secret_access_key = "your_secret_access_key"

```
* Make sure you have a `VPC` created and also a `KeyPair` generated which will be used to login into the machine. The command 
would be like 
```
ssh -i your_key.pem ubuntu@public_ip_here
```
## Making sure that the installation works!
Run the underlying command from the`AWS` instance and result should be something like, 
```
$ sudo ./es_index.sh

{"acknowledged":true}

{
  "zipkin:dependency_template" : {
    "order" : 0,
    "template" : "zipkin:dependency-*",
    "settings" : {
      "index" : {
        "mapper" : {
          "dynamic" : "false"
        },
        "requests" : {
          "cache" : {
            "enable" : "true"
          }
        },
        "number_of_shards" : "5",
        "number_of_replicas" : "1"
      }
    },
    "mappings" : {
      "dependency" : {
        "enabled" : false
      }
    },
    "aliases" : { }
  },
  "logstash_1" : {
    "order" : 0,
    "template" : "logstash-*",
    "settings" : {
      "index" : {
        "routing" : {
          "allocation" : {
            "total_shards_per_node" : "2"
          }
        },
        "refresh_interval" : "5s",
        "fielddata" : {
          "cache" : "node"
        },
        "number_of_shards" : "3",
        "query" : {
          "default_field" : "querystring"
        }
      }
    },
    "mappings" : {
      "nginx" : {
        "_source" : { },
        "properties" : {
          "event_data" : {
            "type" : "object"
          },
          "@fields" : {
            "type" : "object",
            "dynamic" : true
          },
          "@message" : {
            "type" : "text",
            "index" : true
          },
          "@source" : {
            "type" : "text",
            "index" : true
          },
          "@source_host" : {
            "type" : "text",
            "index" : true
          },
          "@source_path" : {
            "type" : "text",
            "index" : true
          },
          "@level" : {
            "type" : "text",
            "index" : true
          },
          "@sys_name" : {
            "type" : "text",
            "index" : true
          },
          "@tags" : {
            "type" : "keyword",
            "index" : true
          },
          "@timestamp" : {
            "type" : "date",
            "index" : true
          },
          "ip" : {
            "type" : "keyword",
            "index" : true
          },
          "request_method" : {
            "type" : "keyword",
            "index" : true
          },
          "request_uri" : {
            "type" : "keyword",
            "index" : true
          },
          "request_length" : {
            "type" : "long",
            "index" : true
          },
          "request_time" : {
            "type" : "float",
            "index" : true
          },
          "status" : {
            "type" : "integer",
            "index" : true
          },
          "bytes_sent" : {
            "type" : "long",
            "index" : true
          },
          "referrer" : {
            "type" : "keyword",
            "index" : true
          },
          "useragent" : {
            "type" : "keyword",
            "index" : true
          },
          "gzip_ratio" : {
            "type" : "float",
            "index" : true
          },
          "log_type" : {
            "type" : "keyword",
            "index" : true
          },
          "@type" : {
            "type" : "keyword",
            "index" : true
          }
        }
      }
    },
    "aliases" : { }
  },
  "logstash" : {
    "order" : 0,
    "version" : 50001,
    "template" : "logstash-*",
    "settings" : {
      "index" : {
        "refresh_interval" : "5s"
      }
    },
    "mappings" : {
      "_default_" : {
        "_all" : {
          "enabled" : true,
          "norms" : false
        },
        "dynamic_templates" : [
          {
            "message_field" : {
              "path_match" : "message",
              "match_mapping_type" : "string",
              "mapping" : {
                "type" : "text",
                "norms" : false
              }
            }
          },
          {
            "string_fields" : {
              "match" : "*",
              "match_mapping_type" : "string",
              "mapping" : {
                "type" : "text",
                "norms" : false,
                "fields" : {
                  "keyword" : {
                    "type" : "keyword",
                    "ignore_above" : 256
                  }
                }
              }
            }
          }
        ],
        "properties" : {
          "@timestamp" : {
            "type" : "date",
            "include_in_all" : false
          },
          "@version" : {
            "type" : "keyword",
            "include_in_all" : false
          },
          "geoip" : {
            "dynamic" : true,
            "properties" : {
              "ip" : {
                "type" : "ip"
              },
              "location" : {
                "type" : "geo_point"
              },
              "latitude" : {
                "type" : "half_float"
              },
              "longitude" : {
                "type" : "half_float"
              }
            }
          }
        }
      }
    },
    "aliases" : { }
  },
  "zipkin:span_template" : {
    "order" : 0,
    "template" : "zipkin:span-*",
    "settings" : {
      "index" : {
        "mapper" : {
          "dynamic" : "false"
        },
        "requests" : {
          "cache" : {
            "enable" : "true"
          }
        },
        "analysis" : {
          "filter" : {
            "traceId_filter" : {
              "type" : "pattern_capture",
              "preserve_original" : "true",
              "patterns" : [
                "([0-9a-f]{1,16})$"
              ]
            }
          },
          "analyzer" : {
            "traceId_analyzer" : {
              "filter" : "traceId_filter",
              "type" : "custom",
              "tokenizer" : "keyword"
            }
          }
        },
        "number_of_shards" : "5",
        "number_of_replicas" : "1"
      }
    },
    "mappings" : {
      "span" : {
        "_source" : {
          "excludes" : [
            "_q"
          ]
        },
        "properties" : {
          "traceId" : {
            "type" : "keyword",
            "norms" : false
          },
          "name" : {
            "type" : "keyword",
            "norms" : false
          },
          "localEndpoint" : {
            "type" : "object",
            "dynamic" : false,
            "properties" : {
              "serviceName" : {
                "type" : "keyword",
                "norms" : false
              }
            }
          },
          "remoteEndpoint" : {
            "type" : "object",
            "dynamic" : false,
            "properties" : {
              "serviceName" : {
                "type" : "keyword",
                "norms" : false
              }
            }
          },
          "timestamp_millis" : {
            "type" : "date",
            "format" : "epoch_millis"
          },
          "duration" : {
            "type" : "long"
          },
          "annotations" : {
            "enabled" : false
          },
          "tags" : {
            "enabled" : false
          },
          "_q" : {
            "type" : "keyword",
            "norms" : false
          }
        }
      },
      "_default_" : {
        "dynamic_templates" : [
          {
            "strings" : {
              "mapping" : {
                "type" : "keyword",
                "norms" : false,
                "ignore_above" : 256
              },
              "match_mapping_type" : "string",
              "match" : "*"
            }
          }
        ]
      }
    },
    "aliases" : { }
  }
}
