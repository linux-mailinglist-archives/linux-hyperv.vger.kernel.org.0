Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C36547634
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jun 2022 17:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiFKPke (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Jun 2022 11:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiFKPkd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Jun 2022 11:40:33 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2026.outbound.protection.outlook.com [40.92.58.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B3E6A40B
        for <linux-hyperv@vger.kernel.org>; Sat, 11 Jun 2022 08:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ic8sR9U4U6IqTh2uDJ5KO6b10scvE/rO3IR99Ix2pgAZyahlbHIHbIyfU7pBsMb5xH3frY7fiD17KO4b7dvGEUzWUSER3NMMq5UPQxzYWk+KnrHHYONwex0kOpxzI1hvZjJjWl1WhvF2ypFcrwZW1cAWhkEs6DgxwCYBSta/EVOb12LPlEDU5JEUFnE8sQ1xd311nvGeqfXA2SMIFUGE6/I5rNQo1UDBU1F/sG4oC6lkjACVo7TJJeWaREGKkAKkqkMRqDma4NUAp4LEdmSGOtkgnO9znRYAivokNucG7BirJBmr/Vzu7qZm90ZCAESV//pPp4KlAZ6S3vZ4ICX43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vi259VWaTkhZwNTuO8gB7JQqPocXh83QLHHYr5MvkCI=;
 b=jZSXMEcvc7kcb2pJcDmUiy8QGHCm0ZtKQlvjZHq0eYsgbutMZWjFVT+mZQ/XtVnDSNgaRgnjIwaJs+kb02lWfb86k4lsgeO4vXREIhuiSDqe7QhpdZg99KzatOEhAV7JlXJPDAN+ZMqHsUmiJsM/hH9RXrLOuo14jO6JSHWKLE1zmXX4lPFfOYQv1uW9AMnUmWf7I9P7TiU1YQbkPBn72HGK14far/7K2z5Q/6ButnNolZyiFDujYVLcZJ1tRaN7JZY7ftSwNfaAXLAsGK+uDg/ygGPrEY+lTNUm0wq0vIKmjGPSU34QieA2aWK5saOej/efVIfA7yRGg7I0/ngbog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vi259VWaTkhZwNTuO8gB7JQqPocXh83QLHHYr5MvkCI=;
 b=QrWDcGSrzTc+5pIpAyZThOFscMz9U50cDHeCM3Y1LsbYrfaxQ9qhAADLlqxIQWg3Q3Jr1BoUOAjzvBKYUcGC7rJUL0xDCRUQeed5k7SWRVx4YgrHdNrePBO2uyuojXQcJ2Zkn4oyhCEVDelNLV4Tq/dy44K4o6GGDiIUDLM8SXWgQU/C1bdr7sxSt1ruQCW8JBZQWy/Gtb8Fk+IFyeTw4pzY4UA92pGVwf83AQZg+ZEdcM63d0KzFfvts5XkvlLv5TPILMh7a0Hc5WpCqq7i8KQuMIvrZwwmEBDSqekUTv2B/PQbxwzzRp+R73mL37aCQn1yvFKwfPheybobLZJtNg==
Received: from DB3PR0602MB3674.eurprd06.prod.outlook.com (2603:10a6:8:6::17)
 by VI1PR06MB6669.eurprd06.prod.outlook.com (2603:10a6:800:184::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Sat, 11 Jun
 2022 15:40:30 +0000
Received: from DB3PR0602MB3674.eurprd06.prod.outlook.com
 ([fe80::69f2:bf3f:5091:da62]) by DB3PR0602MB3674.eurprd06.prod.outlook.com
 ([fe80::69f2:bf3f:5091:da62%7]) with mapi id 15.20.5332.016; Sat, 11 Jun 2022
 15:40:30 +0000
From:   =?iso-8859-1?Q?Florian_M=FCller?= <max06.net@outlook.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: hv_balloon: Only works in ubuntu
Thread-Topic: hv_balloon: Only works in ubuntu
Thread-Index: AQHYfamAAWvh3ZSqEEGxb5JpUeTQGg==
Date:   Sat, 11 Jun 2022 15:40:29 +0000
Message-ID: <DB3PR0602MB3674BB09316BB82B4116F27DFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [sb5bX7oJ8lZfMwqpO6s6cIwyNibHu1aWXYdz6u/75gGux9zpm7UFNzR29jhVOHDO]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36d67ad6-45cb-408d-0849-08da4bc0b6db
x-ms-traffictypediagnostic: VI1PR06MB6669:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4t5RnXwiSGp6D3G7072RsQjF/UsFuNumPhUPEgCY5WpUUePx2yKugDq1gdkuuCgq0ZU8CLvG6jFRhafAzfcUHAYhYp3UYdKB52ymhmPMn0Y1CFRvOD6iGCO54xvKLHJ2pcAXyziPicruSYgpDQ0k2AWkaWTqyyNs4eXEi4fRDWRITGLWJnaktOZNJ4pAqbycJ7RDncfsD3L/p19oVbXzgCHBXrqyenvQzMh/ocF0iUzST8OuGwCwMWJlc7qBXdXETh9zhWpUDtsuneDsv8PDgPJIzJplsvHMDnoNKvneZiCzJ9KTvjFwAs/ZC8mXFEka2mTSPbF0p8H1+JOjIGbRb0YjG918ZK9hfCM2p72MSqElzWsJ866XHUviQLvxsIDoRVgYwcwchVBettPndbbYVSWY75ifQxeGDvkO0TKJ8KEzBur5MRCbsijp/7aZQX8mkYRSl0O8EUnKSEadAnzLLgxAaVW4RwyzeW6rUQTqWduKQfZpOvUOF/Hem1H2At+2NJTcE1HmtYehWQGJXgn3Wb4Q94cc/K/3UUj+wId/qMiyl3RXs4q1VPjHPRGjFEbsoqNxXmyBO+F4KT+8RrHXCA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wedYJ/4veAUDX/5XpPDK7OyJ+vcvKqV9wWdF1cPRyZvKG0Qa1P4uxD2uTh?=
 =?iso-8859-1?Q?kqGtOutWlFqr+P/VfrAyY/7rQZre2yAfs2YuahfVEKx+/euWuXjY66t9G7?=
 =?iso-8859-1?Q?AzXditinj07193JCFjZnUuDBvrVYKZceWBU8SqPYGBSLM2msGViCewXcWl?=
 =?iso-8859-1?Q?luqX7yzC4RJb3+sSJRfGRwibHjRfLdrN5aWXOsAG8zXHx3aKRCPCn4Pzhy?=
 =?iso-8859-1?Q?6UCKhz5fMl7ZojRo56mf6z9aM9PoO+v4TteSD1QlSFEnetaD3vnvTDGLgu?=
 =?iso-8859-1?Q?cZPUDAZYlnJB2jXHPGiqEOoqaVffl/nM4CWl36H0AZe9MSP9DWOyhoJ3Em?=
 =?iso-8859-1?Q?QonALB44/titLfmnDgLRvkkSyMZTcHqdgOp4uJS/T1m9UCKSa7f+8t5UD+?=
 =?iso-8859-1?Q?y0JqT9ds+bbGHaZn5M86RGZZiKntFfH4TLdlLsaPRch7UX7lo0AqR668yD?=
 =?iso-8859-1?Q?CC75oI4NC9jgY+Gq7wq5ZRh0DE2Za45q5hzbrEYxQsJ5lo2w8Ct9qhMJE+?=
 =?iso-8859-1?Q?YERzR7r1NiIAAwPAZ6XQ5Z9WGfj621uuyI4Edwy29vRQhw1Od/FpkUgVG4?=
 =?iso-8859-1?Q?BT0R/rLLGHlJc8vdiYK1awrRSXIZouqZlOTf2n0mdaiBhclkGk5q1Kp3J6?=
 =?iso-8859-1?Q?ZotoxMdosAuCxe11N1kBtRZPqb8O1jt/m908lsmbY1U/pt57W7P/50w+nq?=
 =?iso-8859-1?Q?tdwDIwLAuv98HTivnjU6gbV2AfRNQGbumstA8lNNt9fGFMoZVrva+xjhmR?=
 =?iso-8859-1?Q?ODGJFaRJr0AUYt4C/MVw6eMnkf24yJLXS3Mvx8DlD5rqUTATtTpL07xwIe?=
 =?iso-8859-1?Q?WLYib8Swwk0GxHyRCW/too9cWUhCJGpuve//7M52Pu1FuRwVGdb42UxFbN?=
 =?iso-8859-1?Q?U1EcNr12gtHYrA0dyX1kcpmEiaqNmBnNllj0Qmg0h+nAp9aHe53ric6zTY?=
 =?iso-8859-1?Q?rF5twgFdrbj/ahHatwx/3dBbLRnm1oM8gRrhnuzcAa/WlZBDQKywkTYIdn?=
 =?iso-8859-1?Q?hrzylwlG2zryH5Tbjs2/thZboLpT4jDXjfGzNZrRo6n8xe8W7tuTt3QFiZ?=
 =?iso-8859-1?Q?0kk1RrMAF7Id8/QNqjl4OSeC3Ao0Fl3s76DwsL/zXKNfQKGpixlpzHRja6?=
 =?iso-8859-1?Q?+BcBQP2oNMbxga1XkpjFZKUGVs4wTjC8/3p6PZuS/HNpo/AH/RsuZw/JGQ?=
 =?iso-8859-1?Q?kNsKNX1q04GznYqMSeTLIMz8ZrByYjTMhl75mwrM5abyPc82tsUcwlD5yW?=
 =?iso-8859-1?Q?gc7zj9FCDsIH/xaWHVidxkhtZ68y2D7JyzN3W5VYQWtm7AKXeDEVt7PJfh?=
 =?iso-8859-1?Q?KrRJkT3X0v/cXfYarv5zxFeChW0/zz5ldA3E3lX18JOIsvsVUwiIhjWQe6?=
 =?iso-8859-1?Q?25PWMb6Y+pMg+JFcisIQY8RoUU4jGM40DNpMmmF8trR8AVU5y1nURLqDoT?=
 =?iso-8859-1?Q?KQLf7wwl5tq36D7GZlvgjkp26uhM8wfsuAnP9jPLZMv+YjoZ0+L+GMlqwc?=
 =?iso-8859-1?Q?A6LBN0xRz4rTCoBAis+xhW+TfPTe31fJGxyxhCWcXp2pWITJ5ier2kdkqK?=
 =?iso-8859-1?Q?MD0jI2k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0602MB3674.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d67ad6-45cb-408d-0849-08da4bc0b6db
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2022 15:40:29.9333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6669
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello there,=0A=
=0A=
I'm trying to debug several, probably related issues to your hv_balloon ker=
nel module. =0A=
=0A=
All tests are done on Win11 21H2 (22000.675) pro, on a Ryzen 3950x with act=
ive AMD-V, and 64GB of memory.=0A=
An updated Ubuntu Server 20.04 Guest is used for comparison. It's currently=
 running kernel 5.13.0-1023-azure, configured with 1GB memory to start, and=
 active ballooning between 512MB and 32GB of memory. Memory hot-plugging an=
d -unplugging works.=0A=
=0A=
Issues showed up when I set up a Kali Linux Guest. I missed the memory conf=
iguration before booting up the instance, so it started with 1GB of memory,=
 and ballooning active between 512MB and several TB of memory. Hyper-V star=
ted to allocate more and more memory to this guest since the reported memor=
y requirements also increased. The guest kernel didn't see any of that allo=
cated memory, as far as I can tell. =0A=
=0A=
This is clearly reproduceable on at least 2 Hyper-V hosts, with current liv=
e images of Debian (Bullseye) and Kali Linux, but not with Ubuntu 20.04 or =
22.04.=0A=
(Get the Kali live image, create a new guest (version 10), turn off secure =
boot and boot from that image. It takes 3-5 minutes until the issue is visi=
ble in the hyper-v console.) =0A=
=0A=
After running more tests with different memory settings for ballooning, I a=
m pretty sure:=0A=
- Hyper-V respects the maximum setting for the memory balloon. Although it =
doesn't care if there's enough memory.=0A=
- Guests can't use/see more memory than they had while booting up.=0A=
- Guests can unplug memory.=0A=
- Guests can hotplug previously unplugged memory up to their starting amoun=
t.=0A=
- The reported values seem to be off: After compiling a kernel on Kali (and=
 cooling down), the guest kernel shows a total of 3207MB memory, with 294MB=
 used, 137MB free, 2775MB buffers/caches and 2611MB available. Hyper-V repo=
rts 4905MB required and 5840MB allocated. =0A=
- As of kernel 5.17.11, the issue is not solved.=0A=
=0A=
To sum up: I could use memory ballooning if I set the initial memory size t=
o the maximum size and wait until it got freed up. =0A=
=0A=
There are several reports out there about what looks like a memory leak, wi=
thout a solution. =0A=
=0A=
I'm currently comparing the kernel built by canonical with the kali kernel,=
 but as I am not really a developer, I'm not sure if I could even find the =
difference if there is one. So, I'm calling (and hoping) for help, and offe=
ring any support when it comes to testing. I can apply patches, build kerne=
l packages and read logs if that helps.=0A=
=0A=
Thx-a-lot!=0A=
Flo=
