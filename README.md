[![REUSE status](https://api.reuse.software/badge/github.com/SAP-samples/abap-platform-fundamentals-01)](https://api.reuse.software/info/github.com/SAP-samples/abap-platform-fundamentals-01)

# Sample code snippets for ABAP educational online sessions
<!--- Register repository https://api.reuse.software/register, then add REUSE badge:
[![REUSE status](https://api.reuse.software/badge/github.com/SAP-samples/REPO-NAME)](https://api.reuse.software/info/github.com/SAP-samples/REPO-NAME)
-->

## Description

This repository contains several packages. Each package contains sample code snippets (ABAP, CDS, SQL) that has been presented in various educational online sessions. 

- ABAP SQL – the art of accessing data 
- A new generation of CDS views - CDS view entities
- Why don't these tests run? The issue with test isolation and how it can be solved
- ABAP RESTful Application Programming Model - Fundamentals (planned)
- ABAP RESTful Application Programming Model - Entity Manipulation Language (planned)

## Requirements

In general see the [requirements document](https://github.com/SAP-samples/abap-platform-rap-workshops/blob/main/requirements_rap_workshops.md) for Workshops about the ABAP RESTful Application Programming Model (RAP).

For specific requirements see the readme documents that are part of the aforementioned packages.

## Download and Installation

Download the ABAP Development Tools as described [here](https://tools.hana.ondemand.com/#abap).

Import the source code either using the ABAPGIT report into on prem system or use the ABAPGit Plugin of ADT to import it into a Steampunk system.

Create a package (e.g. ``TEST_DSAG01` or `Z_DSAG01`) where the package name must not exceed 11 characters since the package uses prefix folder logic.


## Package ABAP SQL – the art of accessing data 

The package contains the examples / demos which have been demonstrated during the talk. The package can be installed with abapGit. After the installation you should be able to find the YBW_* classes and tables in your system. Please note that you need to load data into the YBW_... tables before executing the examples will produce valuable results. Data can be loaded by executing class YBW_LOAD_DATA in your ABAP in Eclipse editor. Just load the source code of the class with STRG+A. You can now execute the program by hitting the F9 key.

Session part 1:
- YBW_JOIN
- YBW_UNION
- YBW_INTERSECT
- YBW_EXCEPT
- YBW_CTE
- YBW_TIPPS0
- YBW_TIPPS1
- YBW_TIPPS2
- YBW_TIPPS3

Session part 2:
- YBW_WINDOWING0
- YBW_WINDOWING1
- YBW_WINDOWING2
- YBW_WINDOWING3
- YBW_WINDOWING4
- YBW_WINDOWING_ABAP
- YBW_CHAR_TO_NUMC_1
- YBW_CHAR_TO_NUMC_2
- YBW_CHAR_TO_NUMC_3
- YBW_CHAR_TO_NUMC_4
- YBW_CHAR_TO_NUMC_5
- YBW_CHAR_TO_NUMC_6
- YBW_TIPPS4
- YBW_TIPPS5
- YBW_TIPPS6
- YBW_CANDIDATE_MANAGER

## Package A new generation of CDS views - CDS view entities

The package contains the examples / demos which have been demonstrated during the talk. The package can be installed with abapGit. After the installation you should be able to find the Z_* CDS views and CDS tuning objects in your system. 

Contents:
- z_classic_view: CDS DDIC-based view
- z_view_extension: CDS view extension
- z_demo_no_1: CDS view entity
- z_view_entity_extension: CDS view entity extension
- z_demo_entity_buffer CDS view entity for buffering
- z_demo_calculated_quantity: CDS view entity, demo for calculated quantity

Content (to be created manually):  
A **CDS entity buffer** is a new kind of repository object of the technical type DTEB. This type of object is currently not supported in abapGit. To get the demo that was shown in the talk, proceed as follows:  
•	Right-click on the CDS view entity z_demo_entity_buffer and choose New Entity Buffer.
•	Insert a name, for example z_demo_entity_buffer, and type a description.
•	Paste the following source code:
  <pre>define view entity buffer on z_demo_entity_buffer
       layer core
       type generic number of key elements 1
       </pre>
•	Activate the entity buffer.


## Package "Why don't these tests run? The issue with test isolation and how it can be solved"

The package contains the examples / demos which have been demonstrated during the talk. The package can be installed with abapGit. After the installation you should be able to find the Z-classes, interfaces and a CDS entity in your system. Registered DSAGNet-members can see the details of the event here: https://dsagnet.de/dsag-event?id=357108&app=info

- zms_cds_entity.ddls.asddls
- zms_cds_entity.ddls.baseinfo
- zms_cds_entity.ddls.xml
- zmscl_code_under_test.clas.abap
- zmscl_code_under_test.clas.testclasses.abap
- zmscl_code_under_test.clas.xml
- zmscl_depended_on_component.clas.abap
- zmscl_depended_on_component.clas.xml
- zmscl_factory.clas.abap
- zmscl_factory.clas.xml
- zmscl_internal_incident.clas.abap
- zmscl_internal_incident.clas.testclasses.abap
- zmscl_internal_incident.clas.xml
- zmsif_code_under_test.intf.abap
- zmsif_code_under_test.intf.xml
- zmsif_depended_on_component.intf.abap
- zmsif_depended_on_component.intf.xml
- zmsth_injector.clas.abap
- zmsth_injector.clas.xml


## Known Issues

There are no known issues.

## How to obtain support

[Create an issue](https://github.com/SAP-samples/abap-platform-fundamentals-01/issues) in this repository if you find a bug or have questions about the content.
 
For additional support, [ask a question in SAP Community](https://answers.sap.com/questions/ask.html).

## Contributing
If you wish to contribute code, offer fixes or improvements, please send a pull request. Due to legal reasons, contributors will be asked to accept a DCO when they create the first pull request to this project. This happens in an automated fashion during the submission process. SAP uses [the standard DCO text of the Linux Foundation](https://developercertificate.org/).

## License
Copyright (c) 2022 SAP SE or an SAP affiliate company. All rights reserved. This project is licensed under the Apache Software License, version 2.0 except as noted otherwise in the [LICENSE](LICENSES/Apache-2.0.txt) file.
