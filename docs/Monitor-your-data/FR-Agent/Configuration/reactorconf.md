

Each FusionReactor instance has its own `reactor.conf` configuration file, located in the instance's `conf` directory:
```
<FR instance folder>/conf/reactor.conf
```
This file is used to persist general FusionReactor settings across server restarts. Once an instance has been configured, its `reactor.conf` file can be copied to another instance's `conf` folder to replicate the settings. After copying, the target instance must be restarted for the changes to take effect.


!!! info "Learn more"
    [How to copy FusionReactor configuration between instances](/Monitor-your-data/FR-Agent/FAQs/Copying-FusionReactor-Configuration-Between_Instances/)
