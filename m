Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663315476FC
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jun 2022 19:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiFKR6H (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Jun 2022 13:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiFKR6G (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Jun 2022 13:58:06 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2024.outbound.protection.outlook.com [40.92.89.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600F95419C
        for <linux-hyperv@vger.kernel.org>; Sat, 11 Jun 2022 10:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uy/FRFnDF+8g46xDIcaJMcZ/jqBJp1Y4DpOWe+CXfPckkBRbDRk3R2iTWVN+b+35Tvs6PZc9u/wg6DMrlQraLIDHKIBY5Kr5EcfdjCTRBprkqxjEWo/BXqKfMYpWHZSiSAabW1U13rJIYnjaTZbeQkSHNEbrHUMGYPH3fWNh15QUad5GiTNJXyG3xUddU6UTp/tOFNuCm+XK/IyRKi1BqMByl15KL4ONKTG2d+ZFBRih9r70pY8FDG8sYv+YU1hmA7KjivqLyi68+pE84QWif/EhNwt0Ofo+shlRFuuHAnp3sblffVmNDGxxQZGfXtX+8xmrj00livayC1Znvy0PqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzvGWXPxLf8s1Ic+UcEtu7hAWDtzBIZREnzyKFeUYDc=;
 b=eChB0Zybtrg7Ee2bL0ea9JkkoQrZJVdDv6k4FllSc5zKAic04GAQWadVfCKZbb/4Kh4Twhod0tmYV1bYJQnSJ59YwDeqae+owWHeWWz+rCOTtREdNYiSCd7dsbOz62cVqijBEDmkLPc+9PN3BAqtXoWDXYt5Vy7XLrb4N6zFjSKZKfRduYnXktlqx/SSm8jiYjdDw5yhYyo3hXJNwWUiqhfmm87bz5mk1VejfaeVXpcVyPH8afa+Af5sIgsT547bkRCdB0ZdV/uzTIfssLh1Kdm86VNJh8JMhveXHSV/0wT7mOn7YOhOZ+M2dT+v+5jPJEa1l2M1DVdRlSg9zyLX7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzvGWXPxLf8s1Ic+UcEtu7hAWDtzBIZREnzyKFeUYDc=;
 b=eUbZ0/T1Rv6c76UdcA+QmS5pN5w9Qb2PKXLYVQoqueFdOcuLqg57euHWeXay7bM8dOGFk1hcEb8OidoXUNU3U+DBj2IW7XUp442CHmfVyRL8qdvX27HNblahTqPAF1WHqYbjLlJ4NAQezQb7bboI2QbxNtHFnGqEWx3UPqOH3++wvbqO+vHZQLjzt4rhVWuJETaip2zdWnHuIgYH7f63kK01ulXXPbnsloeqzrV3vtZfTPZoG9QGJtPsOJyFSlyhOGeUaegkv94rn60rqO1reKtuW3MCnGAC/G2L0D91w6W/th5Q14lHOzItjzplacAEsryA1NnUE6lNyCjBMGO++w==
Received: from DB3PR0602MB3674.eurprd06.prod.outlook.com (2603:10a6:8:6::17)
 by AM7PR06MB6424.eurprd06.prod.outlook.com (2603:10a6:20b:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Sat, 11 Jun
 2022 17:58:02 +0000
Received: from DB3PR0602MB3674.eurprd06.prod.outlook.com
 ([fe80::69f2:bf3f:5091:da62]) by DB3PR0602MB3674.eurprd06.prod.outlook.com
 ([fe80::69f2:bf3f:5091:da62%7]) with mapi id 15.20.5332.016; Sat, 11 Jun 2022
 17:58:02 +0000
From:   =?iso-8859-1?Q?Florian_M=FCller?= <max06.net@outlook.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: AW: hv_balloon: Only works in ubuntu
Thread-Topic: hv_balloon: Only works in ubuntu
Thread-Index: AQHYfamAAWvh3ZSqEEGxb5JpUeTQGq1Kc/WAgAAHN5A=
Date:   Sat, 11 Jun 2022 17:58:02 +0000
Message-ID: <DB3PR0602MB3674E1BD958D00FC4B9124ADFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
References: <DB3PR0602MB3674BB09316BB82B4116F27DFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB302513B8500C25CEADA56718D7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
In-Reply-To: <PH0PR21MB302513B8500C25CEADA56718D7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d435031e-a6d4-459d-a017-b4979a3ee24f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-11T17:21:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [PpBWusqUeeJIkQZOBpTzlbTTncFo2CadvGk0OksMH127fczxq9uTzlC2s640Jonn]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2a4f7b1-22c2-4973-b300-08da4bd3ed9b
x-ms-traffictypediagnostic: AM7PR06MB6424:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cxy644qym3XfdwtpRdcYdjLNVzHtNeHm0nbTVrBNzkoTvTIeO8PtlzjAM2PqEewgNmslioaAddZRwUEMtA9kY16xbpxazWirg4tgjWdXBxjvHU1OKhnoSzsdskIpI8HovdtjZaDXtHsEnTKU73yi6SWaYOET94RcgsbwfuFrMZogRGGJ3ZHT9dWpYP/HZ60y/MaC33UPCdNjPD3DZfa3Jh+/TxrGeB1os3bB62Ywqte99WU2yoC8mcFlGsNIQ+Oc6xXbK2LbrOED3A/AD3KG4ATdfg0JpPX8WVoAIwRvZ+h9yDGuw0wQwxjiFcwBHnPU/q0yTkp6TOe3mxiJZK6tOgbgWt/z47Ebr8a5yoW9Wq0nmzNtOGfqx+fwaKaFw65Baz+dH+BAokSIqkJrtGc7N1yxViHgUm/KGFHFc6LvI0PsceRPPKfN4M1MpJ2rGPaWSvZK1GJOnk710JVoqhtBPqD/kF4gqmVxzqVv+/D1KEZaUIUYhNtA6E7ZG9z6UOb/Jpk2elD5AvGr9L7rFFmgtB4KSJ9rUPMKivgKv7arKFZCPPGD0iIVo6GlWGo2gXvLIXtnye4X5v6e41KdzGR4bD6XlLeZ7vtm2QZY2Rk8bGLeBIpJm+go18h4JmvDeKoO
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ytWm19/V0q2K7OrD60kQbhLFQpTGSj8xKxxtzl92ptE/xfCcJaFW3+T/I8?=
 =?iso-8859-1?Q?Zu2gQ6/rASXlreVei8QtifuuFzcRWK2+ZUlMAxLKYZLR5ZtzFOWHCBGvm9?=
 =?iso-8859-1?Q?/187ucVHg0ja4u8YXid1dgMS7sZmEeFJ2SlOYI2rAEi5oPk3FaWa9epcHM?=
 =?iso-8859-1?Q?gElHMr19vJJJOCZXdeKDQSErTp4mZsRurSV8qVw1AhL18L8FrZlkq9caPw?=
 =?iso-8859-1?Q?Vkmf1GiwsSaYRhX8BSOht41mZVmaCvJRoY5O9GybCYhzvg0rOLf3Mu+khe?=
 =?iso-8859-1?Q?6b83MrexqXz5dQ3D+orH7sPql/GInmj8jbcavF1471AFUdX1Dfp6yHvBSC?=
 =?iso-8859-1?Q?bo6IbldVGQA9KzD+FJdfqBPvkniMj4wENq8eyjLoMcfH2rRqQh0CnJWDLT?=
 =?iso-8859-1?Q?MO1yOdwXJtzOIUceLZwzgBR7tZHC1IVq6H458gIJd2hIWZxi7/7cyYH6xS?=
 =?iso-8859-1?Q?KlPXyo6D0hZQMV2MhHFbBjMwKs/bKcf6BgvWihkiv/x4cRiJiB362xUrPE?=
 =?iso-8859-1?Q?fpkfAsiZMRvNNnKsUvMLstWjuQ2E9vgOgwMp9BastisCiNvn/q29tVibag?=
 =?iso-8859-1?Q?Qlgm/rOjcC8yAiecUomppSX9evYK3b5praIwhHFTektwaujT+ImoHfZ9YJ?=
 =?iso-8859-1?Q?eb4SMg5HqN4u6jRy8A0bQb+bqgV838lX/8KeIDyhkg+bi992qQ4j+LMnts?=
 =?iso-8859-1?Q?m1z6j07IVyrsyeOQ/qWjIEiChALzZIiQPUyA9XIy4V22twbB/0W3XKIvQA?=
 =?iso-8859-1?Q?BQGGxhekhx9MJN6fHVUxzvFxB+NmkG6uAZHwPlWa9HHacugkDo1vwsc3D3?=
 =?iso-8859-1?Q?scTQ5abUPzhbVNwZ1Prt0375Dk6GACQ61pYY6qWdKKVPe1m1UFH4lGPI6P?=
 =?iso-8859-1?Q?99QbaklMeYHS7k8mnevQaH2HsxegW7XLtGp8uK2pSoLo4QBFWjaxmiybgU?=
 =?iso-8859-1?Q?YiuX+eoexQ6W1t7dr/W8nmcJh7at2lEgdRWBPNNvlqsqlbkRG2gNdOy9G1?=
 =?iso-8859-1?Q?SyKk2NSdI7rRLghzhC2yT8DJhmE99kbLkv3aoQP7s+mJs68sWA6LlRoQ5P?=
 =?iso-8859-1?Q?DtEMKVaofp+aBWWSXdaibp1t6tZgJcZLOF2SwHBMlFp7ZiYE4AN98jE5jb?=
 =?iso-8859-1?Q?0HF3PAVA9WH4ts8TvdwEmgQRfD61PZL7Bx5jr0O3V4Q2kmSPDRgGyrURFT?=
 =?iso-8859-1?Q?doTfMT0HjBSZma2szj9QWk3gdanBe2Iot1vKRWnzgQRL3bUp9zhyYJGAu5?=
 =?iso-8859-1?Q?4OyAENYnzwwuL5683JnqeEi6qU8mJubNH9AveVFzyeFWENSkdHCXKiOhOo?=
 =?iso-8859-1?Q?86UkahvoGPb7Io237C9Nb4gRIsKgGoGGvQ3aRwQlo3InsjtasRpcmdqEuG?=
 =?iso-8859-1?Q?A52uO4Ek88I/aEHEn03L1Ty+S8TMV4C+8zvjAQGUSd6Nlbu56S3kHFJ1z7?=
 =?iso-8859-1?Q?1+bS4EuTe7A9ZO9tDohCj8A9bd9iC2ewKkojd6sT/s4BtUENyMY8YNZaMv?=
 =?iso-8859-1?Q?X9mri/htCLDI9rYnsw0/QEVemumiVkdUCv/oyV5U9sgvRa0eLiLLxlFKAW?=
 =?iso-8859-1?Q?7NXT9ak=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0602MB3674.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a4f7b1-22c2-4973-b300-08da4bd3ed9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2022 17:58:02.2308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6424
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Von: Michael Kelley (LINUX) <mikelley@microsoft.com>
> From: Florian M=FCller <max06.net@outlook.com> Sent: Saturday, June 11,
> 2022 8:40 AM
> >
> > Hello there,
> >
> > I'm trying to debug several, probably related issues to your hv_balloon=
 kernel module.
> >
> > All tests are done on Win11 21H2 (22000.675) pro, on a Ryzen 3950x
> > with active AMD- V, and 64GB of memory.
> > An updated Ubuntu Server 20.04 Guest is used for comparison. It's
> > currently running kernel 5.13.0-1023-azure, configured with 1GB memory
> > to start, and active ballooning between 512MB and 32GB of memory.
> > Memory hot-plugging and -unplugging works.
> >
> > Issues showed up when I set up a Kali Linux Guest. I missed the memory
> > configuration before booting up the instance, so it started with 1GB
> > of memory, and ballooning active between 512MB and several TB of
> > memory. Hyper-V started to allocate more and more memory to this guest
> > since the reported memory requirements also increased. The guest kernel
> > didn't see any of that allocated memory, as far as I can tell.
>=20
> Hot-adding new memory is done partially by the hv_balloon driver, but it =
also
> requires user space action.  The user space action is provided by udev ru=
les.
> In your Ubuntu Server 20.04 guest, there's a file /lib/udev/rules.d/40-vm=
-
> hotadd.rules.
> This file contains udev rules for hot-adding memory and CPUs.  You should=
 be
> able to copy this file with the udev rules onto your Kali system, and the=
n the
> memory hot-add should work correctly.
>=20
> I'm not sure why Kali doesn't already have such udev rules.  You might gr=
ep
> through all the files in /lib/udev/rules.d and if there are any rules for
> SUBSYSTEM=3D=3Dmemory.
> Sometimes there are rules present, but commented out.
>=20
Thanks, I'll check these ones out!

In the meantime, I was able to get it working, by compiling a kernel with=20
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=3Dy
Which was previously unset. It's enabled in ubuntu and it seems to make hv_=
balloon work properly.=20
This seems to be the same case with Debian.

> >
> > This is clearly reproduceable on at least 2 Hyper-V hosts, with
> > current live images of Debian (Bullseye) and Kali Linux, but not with U=
buntu
> 20.04 or 22.04.
> > (Get the Kali live image, create a new guest (version 10), turn off
> > secure boot and boot from that image. It takes 3-5 minutes until the
> > issue is visible in the hyper-v console.)
> >
> > After running more tests with different memory settings for ballooning,=
 I
> > am pretty sure:
> > - Hyper-V respects the maximum setting for the memory balloon.
> > Although it doesn't care if there's enough memory.
> > - Guests can't use/see more memory than they had while booting up.
> > - Guests can unplug memory.
> > - Guests can hotplug previously unplugged memory up to their starting
> > amount.
>=20
> Yes, adding this memory is done via the ballooning mechanism, and does no=
t
> require user space participation.   The hot-add mechanism is different fr=
om
> ballooning, even though both are packaging in the hv_balloon driver.  Hot=
-
> add is required only when adding memory that was not present when the
> VM first booted, and that's when user space participation is needed via t=
he
> udev rule.
>=20
Gotcha, thanks for the clarification. I wasn't aware of that.

> > - The reported values seem to be off: After compiling a kernel on Kali
> > (and cooling down), the guest kernel shows a total of 3207MB memory,
> > with 294MB used, 137MB free, 2775MB buffers/caches and 2611MB
> > available. Hyper-V reports 4905MB required and 5840MB allocated.
> > - As of kernel 5.17.11, the issue is not solved.
> >
> > To sum up: I could use memory ballooning if I set the initial memory
> > size to the maximum size and wait until it got freed up.
> >
> > There are several reports out there about what looks like a memory
> > leak, without a solution.
>=20
> Could you point me at those reports?  I'm not familiar with them.
Yes, as much as I'm able to find them again.
- https://community.clearlinux.org/t/dynamic-memory-broken-on-hyper-v/3891
... and the rest is gone. I'll post them when I find them again.

>=20
> Michael
>=20
> >
> > I'm currently comparing the kernel built by canonical with the kali
> > kernel, but as I am not really a developer, I'm not sure if I could
> > even find the difference if there is one. So, I'm calling (and hoping)
> > for help, and offering any support when it comes to testing. I can appl=
y
> patches, build kernel packages and read logs if that helps.
> >
> > Thx-a-lot!
> > Flo
I hope I'm doing this mailing list thing right...=20
