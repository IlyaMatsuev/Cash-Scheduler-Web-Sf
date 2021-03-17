# Cash Scheduler Web Sf

This project contains sources of the Salesforce part of the Cash Scheduler Web application.
Its aim is to handle some clients' information, build reports and dashboards, notify clients via emails and execute some jobs. 

-   [Full Project](#full-project)
-   [Installation](#installation)
    - [Scratch](#scratch-org-installation)
    - [Dev](#dev-org-installation)

## Full Project

The full project is located here:
- [Cash Scheduler Web Front-End](https://github.com/IlyaMatsuev/Cash-Scheduler-Web-Client)
- [Cash Scheduler Web Back-End](https://github.com/IlyaMatsuev/Cash-Scheduler-Web-Server)

## Installation

### Scratch Org Installation

1. Clone the project

```bash
git clone https://github.com/IlyaMatsuev/cash-scheduler-web-sf.git
```

2. Go to the root project directory

```bash
cd ./cash-scheduler-web-sf
```

3. Run init script with such parameters as scratch alias, dev hub alias and amount of days the scratch will expire (optional).

```bash
./scripts/sh/init-scratch.sh {SCRATCH_ALIAS} {DEV_HUB_ALIAS} {EXPIRED_IN_DAYS}
```

4. Follow the instructions in the script

### Dev Org Installation

All steps are the same as for scratch org installation but instead of calling:

```bash
./scripts/sh/init-scratch.sh
```
You should use:

```bash
./scripts/sh/init-dev.sh {ORG_ALIAS}
```

All other steps are identical