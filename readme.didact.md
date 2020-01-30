# Camel K Basic Example

This example demonstrates how to get started with Camel K by showing you some of the most important 
features that you should know before trying to develop more complex examples.

## Before you begin

Make sure you check-out this repository from git and open it with [VSCode](https://code.visualstudio.com/).

Instructions are based on [VSCode Didact](https://github.com/redhat-developer/vscode-didact), so make sure it's installed
from the VSCode extensions marketplace.

From the VSCode UI, click on the `readme.didact.md` file and select "Didact: Start Didact tutorial from File". A new Didact tab will be opened in VS Code.

[Make sure you've checked all the requirements](./requirements.didact.md) before jumping into the tutorial section.

## Checking requirements

<a href='didact://?commandId=vscode.didact.validateAllRequirements' title='Validate all requirements!'><button>Validate all Requirements at Once!</button></a>

**VS Code Extension Pack for Apache Camel**

The VS Code Extension Pack for Apache Camel by Red Hat provides a collection of useful tools for Apache Camel K developers,
such as code completion and integrated lifecycle management.

You can install it from the VS Code Extensions marketplace.

[Check if the VS Code Extension Pack for Apache Camel by Red Hat is installed](didact://?commandId=vscode.didact.extensionRequirementCheck&text=extension-requirement-status$$redhat.apache-camel-extension-pack&completion=Camel%20extension%20pack%20is%20available%20on%20this%20system. "Checks the VS Code workspace to make sure the extension pack is installed"){.didact}

*Status: unknown*{#extension-requirement-status}

**OpenShift CLI ("oc")**

The OpenShift CLI tool ("oc") will be used to interact with the OpenShift cluster.

[Check if the OpenShift CLI ("oc") is installed](didact://?commandId=vscode.didact.requirementCheck&text=oc-requirements-status$$oc%20version$$oc&completion=OpenShift%20%20CLI%20is%20available%20on%20this%20system. "Tests to see if `oc version` returns a result"){.didact}

*Status: unknown*{#oc-requirements-status}


**Connection to an OpenShift cluster**

You need to connect to an OpenShift cluster in order to run the examples.

[Check if you're connected to an OpenShift cluster](didact://?commandId=vscode.didact.requirementCheck&text=cluster-requirements-status$$oc%20get%20project$$NAME&completion=OpenShift%20is%20connected. "Tests to see if `kamel version` returns a result"){.didact}

*Status: unknown*{#cluster-requirements-status}

**Apache Camel K CLI ("kamel")**

Apart from the support provided by the VS Code extension, you also need the Apache Camel K CLI ("kamel") in order to 
access all Camel K features.

[Check if the Apache Camel K CLI ("kamel") is installed](didact://?commandId=vscode.didact.requirementCheck&text=kamel-requirements-status$$kamel%20version$$Camel%20K%20Client&completion=Apache%20Camel%20K%20CLI%20is%20available%20on%20this%20system. "Tests to see if `kamel version` returns a result"){.didact}

*Status: unknown*{#kamel-requirements-status}


## 1. Preparing a new OpenShift project

We'll setup a new project called `camel-basic` where we'll run the integrations.

To create the project, open a terminal tab and type the following command:


```
oc new-project camel-basic
```
([^ execute](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$oc%20new-project%20camel-basic&completion=New%20project%20creation. "Opens a new terminal and sends the command above"){.didact})


Upon successful creation, you should ensure that the Camel K operator is installed. We'll use the `kamel` CLI to do it:

```
kamel install
```
([^ execute](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$kamel%20install&completion=Camel%20K%20operator%20installation. "Opens a new terminal and sends the command above"){.didact})


Camel K should have created an IntegrationPlatform custom resource in your project. To verify it:

```
oc get integrationplatform
```
([^ execute](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$oc%20get%20integrationplatform&completion=Camel%20K%20integration%20platform%20verification. "Opens a new terminal and sends the command above"){.didact})

If everything is ok, you should see an IntegrationPlatform named `camel-k` with phase `Ready`.


## 2. Running a basic integration

This repository contains a simple Camel K integration that periodically prints 
a "Hello World..." message.

The integration is all contained in a single file named `Basic.java` ([open](didact://?commandId=vscode.openFolder&projectFilePath=Basic.java&completion=Opened%20the%20Basic.java%20file "Opens the Basic.java file"){.didact}).

> **Note:** the `Basic.java` file contains a simple integration that uses the `timer` and `log` components.
> Dependency management is automatically handled by Camel K that imports all required libraries from the Camel
> catalog via code inspection. This means you can use all 300+ Camel components directly in your routes.

We're ready to run the integration on our `camel-basic` project in the cluster.

Use the following command to run it in "dev mode", in order to see the logs in the integration terminal:

```
kamel run Basic.java --dev
```
([^ execute](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$kamel%20run%20Basic.java%20--dev&completion=Camel%20K%20basic%20integration%20run%20in%20dev%20mode. "Opens a new terminal and sends the command above"){.didact})

If everything is ok, after the build phase finishes, you should see the Camel integration running and continuously printing "Hello World!..." in the terminal window.

When running in dev mode, you can change the integration code and let Camel K redeploy the changes automatically.

To try this feature,
[open the `Basic.java` file](didact://?commandId=vscode.openFolder&projectFilePath=Basic.java&completion=Opened%20the%20Basic.java%20file "Opens the Basic.java file"){.didact} 
and change "Hello World" into "Ciao Mondo", then save the file.
You should see the new integration starting up in the terminal window and replacing the old one.

**To exit dev mode and terminate the execution**, click on the terminal window and press `ctrl+c`.

> **Note:** When you terminate a "dev mode" execution, also the remote integration will be deleted. This gives the experience of a local program execution, but the integration is actually running in the remote cluster.

To keep the integration running and not linked to the terminal, you can run it without "dev mode", just run:

```
kamel run Basic.java
```
([^ execute](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$kamel%20run%20Basic.java&completion=Camel%20K%20basic%20integration%20run. "Opens a new terminal and sends the command above"){.didact})


After executing the command, you should be able to see it among running integrations:

```
oc get integrations
```
([^ execute](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$oc%20get%20integrations&completion=Getting%20running%20integrations. "Opens a new terminal and sends the command above"){.didact})

An integration named `basic` should be present in the list and it should be in status `Running`. There's also a `kamel get` command which is an alternative way to list all running integrations.

> **Note:** the first time you've run the integration, an IntegrationKit (basically, a container image) has been created for it and 
> it took some time for this phase to finish. When you run the integration a second time, the existing IntegrationKit is reused 
> (if possible) and the integration reaches the "Running" state much faster.
>


Even if it's not running in dev mode, you can still see the logs of the integration using the following command:

```
kamel log basic
```
([^ execute](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$kamel%20log%20basic&completion=Show%20integration%20logs. "Opens a new terminal and sends the command above"){.didact})

The last parameter ("basic") is the name of the running integration for which you want to display the logs.

**Click on the terminal and hit `ctrl+c` to close** the log stream.


## 2. Applying configuration and routing

The second example is a bit more complex as it shows how to configure the integration using external properties and 
also a simple content-based router.

The integration is contained in a file named `Routing.java` ([open](didact://?commandId=vscode.openFolder&projectFilePath=Routing.java&completion=Opened%20the%20Routing.java%20file "Opens the Routing.java file"){.didact}).

The routes use two configuration properties named `items` and `priority-marker` that should be provided using an external file such
as the `routing.properties` ([open](didact://?commandId=vscode.openFolder&projectFilePath=routing.properties&completion=Opened%20the%20routing.properties%20file "Opens the routing.properties file"){.didact}).

The `Routing.java` file shows how to inject properties into the routes via property placeholders and also the usage of the `@PropertyInject` annotation.

To run the integration, we should link the integration to the property file providing configuration for it:

```
kamel run Routing.java --property-file routing.properties --dev
# XXX Workaround until fixed:
# (oc delete secret routing-properties > /dev/null 2>&1 || true) && oc create secret generic routing-properties --from-file routing.properties && kamel run Routing.java --secret routing-properties --dev
```
([^ execute](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$kamel%20run%20Routing.java%20--property-file%20routing.properties%20--dev&completion=Run%20Routing.java%20integration. "Opens a new terminal and sends the command above"){.didact})

([^ execute working](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$(oc%20delete%20secret%20routing-properties%20>%20/dev/null%202>%261%20||%20true)%20%26%26%20oc%20create%20secret%20generic%20routing-properties%20--from-file%20routing.properties%20%26%26%20kamel%20run%20Routing.java%20--secret%20routing-properties%20--dev&completion=Run%20Routing.java%20integration. "Opens a new terminal and sends the command above"){.didact})

You can now open both the [Routing.java](didact://?commandId=vscode.openFolder&projectFilePath=Routing.java&completion=Opened%20the%20Routing.java%20file "Opens the Routing.java file"){.didact} file or
the [routing.properties](didact://?commandId=vscode.openFolder&projectFilePath=routing.properties&completion=Opened%20the%20routing.properties%20file "Opens the routing.properties file"){.didact}
file, make some changes and see the integration redeployed.
For example, change the word `door` with `*door` to see it sent to the priority queue.

**Click on the terminal window and hit `ctrl+c` to terminate** the integration and exit the "dev mode".

When you need to pass multiple arguments to `kamel run`, it's often desirable to save them and avoid repeating them each time.
Let's re-execute the previous command in standard mode with the `--save` option:

```
kamel run Routing.java --property-file routing.properties --save
# XXX Workaround until fixed:
# kamel run Routing.java --secret routing-properties --save
```

([^ execute](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$kamel%20run%20Routing.java%20--property-file%20routing.properties%20--save&completion=Run%20Routing.java%20integration%20and%20save%20configuration. "Opens a new terminal and sends the command above"){.didact})

([^ execute working](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$kamel%20run%20Routing.java%20--secret%20routing-properties%20--save&completion=Run%20Routing.java%20integration%20and%20save%20configuration. "Opens a new terminal and sends the command above"){.didact})

The previous command will run the integration on the remote cluster, but also save a file with the command line options used for
the integration. You can inspect the file by opening it: [kamel-config.yaml](didact://?commandId=vscode.openFolder&projectFilePath=kamel-config.yaml&completion=Opened%20the%20kamel%20configuration%20file "Opens the kamel-config.yaml file"){.didact}.

Note that the command line options have been saved into the file. From next time, you can run the integration with the simpler command `kamel run Routing.java`, the configuration file will be linked automatically.

You can delete the integration as you'd do with any Kubernetes resource:

```
oc delete integration routing
```
([^ execute](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$oc%20delete%20integration%20routing%20&completion=Deleted%20integration%20routing. "Opens a new terminal and sends the command above"){.didact})

## 3. Running integrations as Kubernetes CronJobs

The previous example can be automatically deployed as a Kubernetes CronJob if the delay between executions is changed into a value that can be expressed by a cron tab expression.

For example, you can change the first endpoint (`timer:java?period=3s`) into the following: `timer:java?period=1m` (1 minute between executions). [Open the Routing.java file](didact://?commandId=vscode.openFolder&projectFilePath=Routing.java&completion=Opened%20the%20Routing.java%20file "Opens the Routing.java file"){.didact} to apply the changes.

Now you can run the integration again:

```
kamel run Routing.java
```

([^ execute](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$kamel%20run%20Routing.java&completion=Run%20Routing.java%20integration. "Opens a new terminal and sends the command above"){.didact})

If you have used `--save` in the previous step, the CLI will automatically link the property file.

Now you'll see that Camel K has materialized a cron job:

```
oc get cronjob
```

([^ execute](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$oc%20get%20cronjob&completion=Get%20CronJobs. "Opens a new terminal and sends the command above"){.didact})

You'll find a Kubernetes CronJob named "routing".

The running behavior changes, because now there's no pod always running (beware you should not store data in memory when using the cronJob strategy).

You can see the pods starting and being destroyed by watching the namespace:

```
oc get pod -w
```

([^ execute](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$oc%20get%20pod%20-w&completion=Watch%20Pods. "Opens a new terminal and sends the command above"){.didact})

Click on the terminal window and **hit `ctrl+c` to exit the current command**.

To see the logs of each integration starting up, you can use the `kamel log` command:

```
kamel log routing
```

([^ execute](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$kamel%20log%20routing&completion=Watch%20integration%20logs. "Opens a new terminal and sends the command above"){.didact})

You should see every minute a JVM starting, executing a single operation and terminating.

The CronJob behavior is controlled via a Trait called `cron`. Traits are the main way to configure high level Camel K features, to 
customize how integrations are rendered.

To disable the cron feature and use the deployment strategy, you can run the integration with:

```
kamel run Routing.java -t cron.enabled=false
```
([^ execute](didact://?commandId=vscode.didact.sendNamedTerminalAString&text=camelTerm$$kamel%20run%20Routing.java%20-t%20cron.enabled=false&completion=Run%20Routing.java%20integration%20without%20CronJobs. "Opens a new terminal and sends the command above"){.didact})

This will disable the cron trait and restore the classic behavior (always running pod).

