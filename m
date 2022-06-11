Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6732154775B
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jun 2022 21:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiFKToq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Jun 2022 15:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiFKTop (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Jun 2022 15:44:45 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2013.outbound.protection.outlook.com [40.92.89.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8057F2DD40
        for <linux-hyperv@vger.kernel.org>; Sat, 11 Jun 2022 12:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTpgMTi32ACWpIRPQ3AXnZ/55XNbU6Igzx4dhEc8E+KkSiSDiZJ8h3ytsJZms9fdttpZIsQ7JhelmshzJdn5oDuGB829TrVZ7bfDpKXB12zUznC4rs2LPrQhJs0uPmvbXKMycG9tc9IwxAYx9LsfzkIIk6/7t5PH5U4CGkimKZNj/B5Dx6W4VK23MiA+8ZxM3oIN9vBFuOrBI5ByBFgvdjKmJSX7l42QLGkn4497tu1o+FW1vxPol7a8D6iYpclkstjnsXHm9AXpD1IR4pcyZ2OtNZ7kzNXELPrSp46L1JpjHTMH7LVkVmWFhP5s5cvLDLZyVlKQDGoeTgrLM14bFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhrWrx/sutyECx8of9MtbvdjHWvz40BwDyUrXc/fqTw=;
 b=bZMl4YZ2LhtUTSI5WTTHNhX0rFDGBOWVZjgwUUUZIHZXtrg3NiGgcFfTtz59X1m0XI2Nzf+UobXRPWySQaKKJvgdTuN7P7cPJrSRVb979eEi+cxiJdnn+qMqBC2r9nlw7KopHpnGrQsCxNnII84X3ubJ/0k1RobCzUlopn2u3w/MMK6kcFf0ZxTt8GK30x+hq4HcIucPYelf6S0FFIZxrfeNO1gEYrwhuLqr9W9Vg/eudAu/q2RB6R4343VsvB1KtIBssBAzkseeqD+Cj67WAC/ro5xWAUgk6GGGAZ6ymyGgEuIT+vx14eqFa2eNyiRjmhs5Jeh5sMJtXJVJQm5jgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhrWrx/sutyECx8of9MtbvdjHWvz40BwDyUrXc/fqTw=;
 b=uifo4E+jWhdjQQ0B0N7lyoY/Hyahk6uGRE0Lqn6BZpQzmGfyasI14wX2p0Eql2jmCv9CsxLu1yZaZZQw2Qltf6VBbV2pb9El9zzChNIIDBBnWxd/Ex4bFcNoNLdofVrGAhOahUzPHmkUo1z0Um4zgGEZ/YYz8v/o9VzVCCySsCdliq/cShqdjxr0d3vNW0vXIblAgjxOdsJkcDEdK87RN1jmVxrag2I/Pv+DsGIxUl9BhRPlSFP3X44Q3iymgJMMeDFuBWGZc2H20NmfoiOqFfo2PduVUZ84U79FjzIo7M2WpzegZ+H2meJYZtc8dotk4b+E1A48TyQMmQ9UilRsYA==
Received: from DB3PR0602MB3674.eurprd06.prod.outlook.com (2603:10a6:8:6::17)
 by VI1PR06MB3854.eurprd06.prod.outlook.com (2603:10a6:802:5f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Sat, 11 Jun
 2022 19:44:41 +0000
Received: from DB3PR0602MB3674.eurprd06.prod.outlook.com
 ([fe80::69f2:bf3f:5091:da62]) by DB3PR0602MB3674.eurprd06.prod.outlook.com
 ([fe80::69f2:bf3f:5091:da62%7]) with mapi id 15.20.5332.016; Sat, 11 Jun 2022
 19:44:41 +0000
From:   =?iso-8859-1?Q?Florian_M=FCller?= <max06.net@outlook.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: AW: hv_balloon: Only works in ubuntu
Thread-Topic: hv_balloon: Only works in ubuntu
Thread-Index: AQHYfamAAWvh3ZSqEEGxb5JpUeTQGq1Kc/WAgAAHN5CAABp5wIAAAvTQ
Date:   Sat, 11 Jun 2022 19:44:41 +0000
Message-ID: <DB3PR0602MB36740EE00B8BA3B897BCB7C0FFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
References: <DB3PR0602MB3674BB09316BB82B4116F27DFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB302513B8500C25CEADA56718D7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB3674E1BD958D00FC4B9124ADFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB30252F8660A16DE36206B0EBD7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
In-Reply-To: <PH0PR21MB30252F8660A16DE36206B0EBD7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d435031e-a6d4-459d-a017-b4979a3ee24f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-11T17:21:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [4JAiOjTks1r5S9Dgw+7Z5pmftNU7VXqIelViZSlYji9hHQ3LEz8GKFy++RIwurGd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee9d9576-f6f1-4716-e345-08da4be2d3b7
x-ms-traffictypediagnostic: VI1PR06MB3854:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6AtA+xRQHWpniGnrimc1zred5efFRYLE/uMkkueoM5GSGHYJtHDJdngKS6latpLUHtBQtxgqmx2TqP7K/bvXiwsRVeQnocvlk0HPF8T9vzTFWpLMmeFey+ORmV9yTFLb8gLEevyUve+RaCO0j3sGK2Udko8h3ZoQA2b34ZX7Kru07/xnMAUp9k5R3xVumFCUagPusmTQfnsah+xpYIg2caeoRcEVLe8EiakIr6RrJXR0bRkU/OV3ps0RWt/lzhFnn7RaY5PyDQ5yCgpaOf3HH+qw746uqBNtWtnhqI4G66H0p6USsYH+B61lqYl+HAOD661qh/sUyXqtf4JeHsmx42udJBhi0YGnOkViZrf5qSX/1QB8bLAEUI6tLIR8Fu7TQoJcmTDnlDUlyMcHKyUIdOwlBR3cFHMSujRtV+6dxlwl0upMyPw8o01cuFQJay086R2ejkCUVZq/KKWARu2m45AVNVcCb7bFsm3gU9QCevnbanogvwlkIFBOlZBAopD/5YpgUmMFfntOa1IszBax8wVAscZnF5P9W9X8RjLSYgqrP8MiPEZTBn+2Vvff3mrBRx7QkliK7a2uhvGryv8oIrWVIDQeJlTcyx4nUImUWW5h/EhFkSKQjC9gGfLuyldv
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L3q/TixvIBmfMc1tM9OrUyj/zJtF8VyBAeRB18J7vB7ntwy4dRNq/qqr62?=
 =?iso-8859-1?Q?1+4J8oCFA8ZXZJoCDhnxy9cD1jRMB48oWVE2YNDYiaBfI3SvtcBeyxsJyM?=
 =?iso-8859-1?Q?o6vEPThycQovZu3ppCFo73qpk54j5s/7DISmvtThIpB1k8t+yy2TvBnV/F?=
 =?iso-8859-1?Q?+r5azGNhSdCIHa343AaSv/btBP5YhFb/jombE4rcfzDd+T/7DrS2c57eNt?=
 =?iso-8859-1?Q?569cmqtvY1iT2CW28/38ZNep+MBOiQ7uLfH5TZYl0RyfvoJN7phUaS4wmc?=
 =?iso-8859-1?Q?FNFpaG0oBrbcNBh+lHltU0B7Bw4eV4A/UXiNvUXTzc7gMPS8dBX23wZpSk?=
 =?iso-8859-1?Q?MGVml0o4uxAEnvFeLsc6+3TecuUuhTlfvrnm2HI9gbWE45xEU3hmeGF2eC?=
 =?iso-8859-1?Q?mKophHRfxcSL+qfpXZ7zDPdb92VZasseDFmUtlG80vnen5JdbeOJQMLfKm?=
 =?iso-8859-1?Q?KjJCcK+B57e8xQblpCUYXOq0FGK1dcVLdbnbk2gQiLJvF0Wnf6sxKlce5P?=
 =?iso-8859-1?Q?EWglEZuVQE3Kksl/MAVQULfJPE9P9SuXn2YqdDsldjPLYLjsSq/RsJur8o?=
 =?iso-8859-1?Q?8smKO+c7atvzEM+BYAtga6OZSSgZvlicm+6IroLfvW8ih6DRPYvD04+l6t?=
 =?iso-8859-1?Q?nFVmNr3J/PJIb/c7uXbBOXz9ht4UDQszm5HEfJnUQecLzGEnXY25/BAVUk?=
 =?iso-8859-1?Q?pw7xWVUNV8JHatjj7P+vVuGiJV+hP+wRLomWTGlYF6ibIOi7XqQBd7X2By?=
 =?iso-8859-1?Q?iYlGQRwy5Mty3eXO6DY+T/xzmU37Wa/Yjlu8wTSL6cXjKp75nJrgdUEJ+G?=
 =?iso-8859-1?Q?HF2LsLkOrX4PYl6bk8btijVg51DQK6pPXH2AAZW+O9RgE+u5mPkPCDqn6D?=
 =?iso-8859-1?Q?KNYFq7rZzSScncQKaaUUu74HOxdkLv6vOi8u8SqUc0i86D6noaWfT71qmK?=
 =?iso-8859-1?Q?owrJNub3TW5OrYu9ZeWm932yxtEW6IuaMSwZmF/ivRmlT6XH4kY3pRvTjH?=
 =?iso-8859-1?Q?yu6hx0Zn2izDMHmke8BDvp5d3GocvYoYSzZnCW0D88DAQfGC9sbLqqaH4M?=
 =?iso-8859-1?Q?+Ezkgb1K8zIrZWtJk0mgCVZ4ammo5OeqZY6270xty3+MHZZIrBuH5q2TJZ?=
 =?iso-8859-1?Q?/0HD4VbOK0ZOfSSd9T7sxS0sxHN01bUCgC+GeH2VrHnjoluJiq/27XnqUU?=
 =?iso-8859-1?Q?m8lsXznW5KYqc60dXOtOSCq401T2nC1LOnOoKaUJGCiD+8xZ+/MgbGvXPG?=
 =?iso-8859-1?Q?ReYVV/7WBqxeJygD/AoypEaCPoTGD/dAxlYaVw+nNj+jUrGcr6yLu1ieZL?=
 =?iso-8859-1?Q?mRaHWhZLyYqAdAeeQ8m1BMr3GeQ0mAesSMq8AWnLqt7kfZ1dYhjy1bhBH/?=
 =?iso-8859-1?Q?cU2GmLjxpot4V5RYEBj0CeVUWZwtPtbicnxIhT4EWejgKHNXrhoUsQEqcr?=
 =?iso-8859-1?Q?uW9mqKD6iF9eFUXla1PMDdhclcUYypeoyfogj5HOzsFAQn0PBhh0q8/owH?=
 =?iso-8859-1?Q?9grl5vwcErMfAWbr9WLSj9k/FzFghZTUvWdy/a4pGR3fM/3bGnXxIS0iMA?=
 =?iso-8859-1?Q?iumADaE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0602MB3674.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9d9576-f6f1-4716-e345-08da4be2d3b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2022 19:44:41.2926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB3854
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Von: Michael Kelley (LINUX) <mikelley@microsoft.com>
> From: Florian M=FCller <max06.net@outlook.com> Sent: Saturday, June 11,
> 2022 10:58 AM
> >
> > > Von: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > > From: Florian M=FCller <max06.net@outlook.com> Sent: Saturday, June
> > > 11,
> > > 2022 8:40 AM
> > > >
> > > > Hello there,
> > > >
> > > > I'm trying to debug several, probably related issues to your hv_bal=
loon
> kernel module.
> > > >
> > > > All tests are done on Win11 21H2 (22000.675) pro, on a Ryzen 3950x
> > > > with active AMD- V, and 64GB of memory.
> > > > An updated Ubuntu Server 20.04 Guest is used for comparison. It's
> > > > currently running kernel 5.13.0-1023-azure, configured with 1GB
> > > > memory to start, and active ballooning between 512MB and 32GB of
> memory.
> > > > Memory hot-plugging and -unplugging works.
> > > >
> > > > Issues showed up when I set up a Kali Linux Guest. I missed the
> > > > memory configuration before booting up the instance, so it started
> > > > with 1GB of memory, and ballooning active between 512MB and
> > > > several TB of memory. Hyper-V started to allocate more and more
> > > > memory to this guest since the reported memory requirements also
> > > > increased. The guest kernel didn't see any of that allocated memory=
, as
> far as I can tell.
> > >
> > > Hot-adding new memory is done partially by the hv_balloon driver,
> > > but it also requires user space action.  The user space action is pro=
vided
> by udev rules.
> > > In your Ubuntu Server 20.04 guest, there's a file
> > > /lib/udev/rules.d/40-vm- hotadd.rules.
> > > This file contains udev rules for hot-adding memory and CPUs.  You
> > > should be able to copy this file with the udev rules onto your Kali
> > > system, and then the memory hot-add should work correctly.
> > >
> > > I'm not sure why Kali doesn't already have such udev rules.  You
> > > might grep through all the files in /lib/udev/rules.d and if there
> > > are any rules for SUBSYSTEM=3D=3Dmemory.
> > > Sometimes there are rules present, but commented out.
> > >
> > Thanks, I'll check these ones out!
> >
> > In the meantime, I was able to get it working, by compiling a kernel
> > with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=3Dy
> > Which was previously unset. It's enabled in ubuntu and it seems to
> > make hv_balloon work properly.
> > This seems to be the same case with Debian.
> >
>=20
> Yes, that looks like a good solution.  I didn't remember that there is a =
kernel
> config option to automatically do the onlining.  With this kernel option
> enabled, using a udev rule obviously isn't needed.  The kernel option was
> added in Linux kernel version 4.7, which might be after the last time I l=
ooked
> at Hyper-V memory hot-add in detail.
>=20
> Michael
>=20

Awesome!

Last question: Since not having the kernel option by default and also not h=
aving the udev rule in some distributions causes the Hyper-V host to eat up=
 all the memory up to the defined limit (and to die eventually), should thi=
s be considered as a bug? And if the answer is no, how can I (or anyone) fo=
rward the requirement to the publishers to be solved at the source?

Thank you!

> > > >
> > > > This is clearly reproduceable on at least 2 Hyper-V hosts, with
> > > > current live images of Debian (Bullseye) and Kali Linux, but not wi=
th
> Ubuntu 20.04 or 22.04.
> > > > (Get the Kali live image, create a new guest (version 10), turn
> > > > off secure boot and boot from that image. It takes 3-5 minutes
> > > > until the issue is visible in the hyper-v console.)
> > > >
> > > > After running more tests with different memory settings for
> > > > ballooning, I am pretty sure:
> > > > - Hyper-V respects the maximum setting for the memory balloon.
> > > > Although it doesn't care if there's enough memory.
> > > > - Guests can't use/see more memory than they had while booting up.
> > > > - Guests can unplug memory.
> > > > - Guests can hotplug previously unplugged memory up to their
> > > > starting amount.
> > >
> > > Yes, adding this memory is done via the ballooning mechanism, and doe=
s
> not
> > > require user space participation.   The hot-add mechanism is differen=
t
> from
> > > ballooning, even though both are packaging in the hv_balloon driver.
> > > Hot- add is required only when adding memory that was not present
> > > when the VM first booted, and that's when user space participation
> > > is needed via the udev rule.
> > >
> > Gotcha, thanks for the clarification. I wasn't aware of that.
> >
> > > > - The reported values seem to be off: After compiling a kernel on
> > > > Kali (and cooling down), the guest kernel shows a total of 3207MB
> > > > memory, with 294MB used, 137MB free, 2775MB buffers/caches and
> > > > 2611MB available. Hyper-V reports 4905MB required and 5840MB
> allocated.
> > > > - As of kernel 5.17.11, the issue is not solved.
> > > >
> > > > To sum up: I could use memory ballooning if I set the initial
> > > > memory size to the maximum size and wait until it got freed up.
> > > >
> > > > There are several reports out there about what looks like a memory
> > > > leak, without a solution.
> > >
> > > Could you point me at those reports?  I'm not familiar with them.
> > Yes, as much as I'm able to find them again.
> > -
> >
> https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fcom
> m
> > unity.clearlinux.org%2Ft%2Fdynamic-memory-broken-on-hyper-
> v%2F3891&amp
> >
> ;data=3D05%7C01%7C%7Cf4d2032b2a48483e8be508da4be0c95c%7C84df9e7fe9
> f640af
> >
> b435aaaaaaaaaaaa%7C1%7C0%7C637905726063903963%7CUnknown%7CTWF
> pbGZsb3d8
> >
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C3
> >
> 000%7C%7C%7C&amp;sdata=3DQ4HXxFY2UHIvBFZv1RyEfdX21BNzo8Bd6%2BDE
> 6NhMDZM%3
> > D&amp;reserved=3D0 ... and the rest is gone. I'll post them when I find
> > them again.
> >
>=20
> Thanks.
>=20
> > >
> > > Michael
> > >
> > > >
> > > > I'm currently comparing the kernel built by canonical with the
> > > > kali kernel, but as I am not really a developer, I'm not sure if I
> > > > could even find the difference if there is one. So, I'm calling
> > > > (and hoping) for help, and offering any support when it comes to
> > > > testing. I can apply
> > > patches, build kernel packages and read logs if that helps.
> > > >
> > > > Thx-a-lot!
> > > > Flo
> > I hope I'm doing this mailing list thing right...
>=20
> Looks OK to me. :-)
>=20
> Michael

