Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB32154774E
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jun 2022 21:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiFKTaJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Jun 2022 15:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiFKTaI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Jun 2022 15:30:08 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2132.outbound.protection.outlook.com [40.107.212.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A242AE05
        for <linux-hyperv@vger.kernel.org>; Sat, 11 Jun 2022 12:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2wnFXtnLtC9OpXvXO8fye8fGCaAx/zDZLvRic24Twc/zWsT71TDtBBrfFrbeRoRFoe0buMyoY4FZmS+e01/kBptgtPboRfnA8jaDW7v7m51HOHBGCUCWVw8254IUQho3iWQ0ke0kOaRKy5Cr6XhWFmmiQ3nD6tRTtMCVH4lmc+f2cRbNhNTyCfkIj8uKkCT08maet7zzhffD/f93LHMCbyA2hSHtGb5IWMefxVXkvB1/rI9epb50vwa6/LI5oy9XcEMpTpDyJwhtjII2Bkb0gYPew6XElHbe7fbLT/f2QKMVf3vNuu/zNAx85A3r9NPiS5Jef+evi9CwK4A1SkqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krgSCaMGrIfKkcXuasZV6r7l7Nga3lsH1yUhpNjRE4Y=;
 b=FH1xKT4swrA7pVOty8jFPTO28LUya74/zLlIV3XOrKhxSRccR/gf/AYIo4vI8rCHZUYK13drW78bfESPgvOl9qhU3LsPQzuow1SDsrM6mMXm8aT9FpSUdPt7+9xzx+N/6kC/3TyexmrsPDNHOpNrYpOI/+hlqm8qnpwScEGjFaIf1H1eDT+e/i7QfOOhtWkkPnpOW6PCCPDTymJvxD8zcjA2IJndOHc8YhrF3DAeH5mP59qRef1OaZjH/6ipsCMJcL/CPO/DJm0boY56oT5Q6lJPP1Bbo5XVAa5uEdzws09hiT80Mk2/rOodEW6q7UyuNTd84uiuJosQjw7Jq/6YBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krgSCaMGrIfKkcXuasZV6r7l7Nga3lsH1yUhpNjRE4Y=;
 b=b8e3kC/OevGOdGTXWHYvOm4PIdgmIiw/LR3+jnpFx/LDXUIPzS8g9/eV8o0m5rLHvgBqBKFNBKApySj9nd0Ui2gjYuAQdpBZIAPMIQBcx6gnPOe3vPAOYKRIXAaA6oWrt41xOY2rmfK/GOyZ5qqmfg2zhKG+M2X1Ud5IWszbJnk=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DS7PR21MB3343.namprd21.prod.outlook.com (2603:10b6:8:82::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.5; Sat, 11 Jun
 2022 19:30:01 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::f80c:f3b1:a285:4a2d]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::f80c:f3b1:a285:4a2d%6]) with mapi id 15.20.5353.006; Sat, 11 Jun 2022
 19:30:00 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     =?iso-8859-1?Q?Florian_M=FCller?= <max06.net@outlook.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: hv_balloon: Only works in ubuntu
Thread-Topic: hv_balloon: Only works in ubuntu
Thread-Index: AQHYfamAAWvh3ZSqEEGxb5JpUeTQGq1Kc/WAgAAHN5CAABp5wA==
Date:   Sat, 11 Jun 2022 19:30:00 +0000
Message-ID: <PH0PR21MB30252F8660A16DE36206B0EBD7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <DB3PR0602MB3674BB09316BB82B4116F27DFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB302513B8500C25CEADA56718D7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB3674E1BD958D00FC4B9124ADFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
In-Reply-To: <DB3PR0602MB3674E1BD958D00FC4B9124ADFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d435031e-a6d4-459d-a017-b4979a3ee24f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-11T17:21:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af54d54c-2c72-4043-3784-08da4be0c6e5
x-ms-traffictypediagnostic: DS7PR21MB3343:EE_
x-microsoft-antispam-prvs: <DS7PR21MB3343259F2587CD7AA346D9F6D7A99@DS7PR21MB3343.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SFFqxpGVtyJ06ukyQFm7THzT468KjuBqxBcX6xPykyYl5uBhLpaWzIaicLsBBwSUUgrBAVM08pnI6TGSkqANjQD9U6fWbCn7U1qqv2x9rmuDym9CZ/7U6ZYFLXUDdPX+QmfKMmF42ahE7pa4Khta1sr6iRhZVkSFZPwdaX6klceAeMDIgjNfOUlq2XGw/7110Y0793+UO8+KX0W2Ea5nEysN/WMPW+CNtIAjZfagKkd6LWw1zf1ib2QRov4t+v2q3UHpxpQudsOgemDA38Xq3jGwurPpVhqsw5PEmqf1mM+oPnN+DyrEM1vDF1tuXXGUtmGZScMFrTau+RF/ME2wN9AYO4BZtbURnbziv+Vba86yeYEk1eINfomTHJmV/LKm+APQr4VNuhdlC9k+wnKoSjBArskKnZs6m5umGmhc0T+w+sJiYbGfQzxwcTovOik7wRL+LrTi/7VXRL6e21sthqjRFbhxShXRbkqfM8pt9CTkLv3j4j2JZ5xYfp5Og/wxSDXqri1HAxaqZ1zFw4976PwlNeGwS1gmL5GpX9LDK4wQ+s+cZ6oHz8URQli1WmRa8O468+nAeulifCn8lmC/OLIlcUAjjunXPjAI3HeldJwAShILBgUeSzxJsGWYY/7Wuzbb+6VzAFJqTLJCrNrh+c7OQIgkxpx5VaSKri/gQjIeQcx3Aw8/v9h5uF6eFCu+l+iiAjzoclwSt8rxvTrARnJ06IShoecoXpu4iNgwpVbDOgz23wT9qI6DdU2fzly/FYHS2KBod/rODKeuGB5D2LkUcbjDwSjZxJEunSjZGHUC4ldtGllrR55egJ1bamgJ1S39MCCo44CIswVkgtOy8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(451199009)(110136005)(122000001)(6506007)(7696005)(9686003)(26005)(186003)(316002)(38070700005)(8990500004)(86362001)(66574015)(966005)(508600001)(38100700002)(8936002)(52536014)(71200400001)(55016003)(5660300002)(33656002)(82960400001)(82950400001)(83380400001)(10290500003)(8676002)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7gIWKIGQESNFO1VsekpxnsgmFxcwgmxnoyTLqXNBKLjbX/TXudIzGlBmWo?=
 =?iso-8859-1?Q?LiWImxKV8x8n8mTwiy5mVYMjW6x32JFTqREIWHLkFb8WRqNSdhwqgjC87h?=
 =?iso-8859-1?Q?uJrnaprdTwHZsqOStlXucB/FBuQ6y+Vycv0FtG3//C43+VVbso8qKGgwoH?=
 =?iso-8859-1?Q?8K/IIdi3ei5Lyntcy1cYrA602NI5Jmqz3JoLEKm9C8KR1TYLsPXYW26UY9?=
 =?iso-8859-1?Q?f6a9GFAKV+s43kZaHzJwPID+YMQeiwO3YcUGALHlUegz/Hicf1aicb9WxW?=
 =?iso-8859-1?Q?cU9cI4XvxXdoQpkW8gHjA901nphGCe3yg/LZMiYHWZYdgPtJ/ilrUHB6rd?=
 =?iso-8859-1?Q?OSyd67wZVcQgG0GfmNPTMxR8SFWv9pPpKQABPizWc2uKIPfByM7m3w1eYU?=
 =?iso-8859-1?Q?/vbTw0YU6gNargIIMz4rAS16OgraeKdL0OwSKVT5tl5MP9d8I9acSoQ9T7?=
 =?iso-8859-1?Q?OfkCXqZEIhcrym5x3R2hGKdUcGKiQ+3X8t+F0L987mI3irnw+/cKspD+ZL?=
 =?iso-8859-1?Q?GrVy0W2zHWXnqLs4JRFfmuJCkTlrkTDD6c3ev2nQ6E+00K+Fc3zMG5CFOf?=
 =?iso-8859-1?Q?cxxk2w2ofXoLK4Wpj1AZ+uHwEKQfN1foE5XyfzsbI0AUno5dADYtB1fHF7?=
 =?iso-8859-1?Q?ZS4bKrnSqk2/xoqt1UFV4gyy1h3Th/fNVVQ0yX6SSZZsI94ehNCtXxU1dj?=
 =?iso-8859-1?Q?JBgSm83TO8/MUBjcKbWo9EihWfoelJyp6mIWq9HGegQD2PfNI9IfiC4iOI?=
 =?iso-8859-1?Q?KbPQxpDeDxZ9j50EVlmnhj4K2R4/jzsJ2KzZE6bJ13mzl47sbmR+XMGneT?=
 =?iso-8859-1?Q?V64q2o2OsuRLkoUBW45nCgfVa67hmNgtDuyK4ChfSSlQ6TkSpVtifM3V/j?=
 =?iso-8859-1?Q?itQGjaWVNHPoxh43xwh2ue4B5A2u/nehRhJJ45GRvAYMTIxxOWqr+LqE1I?=
 =?iso-8859-1?Q?oFmEjLAlwoymd0h0JZcnDYjDHu51NYeJX3KhiEDjHvDUQoidoNVHQzeT7t?=
 =?iso-8859-1?Q?wX+sv3pSJmRX3Vug/GeBEFjdZ3w7GHnVifP9N3vUzy5vrf+ovlx9Y0h03L?=
 =?iso-8859-1?Q?gniwQegWT7uJ5j3kIgAz3Ia++8men0n3o5XO39HaINKR0Cuc0Nww9oyscu?=
 =?iso-8859-1?Q?3GeSgDPNdQp3OHxQdcIRYhmTGFQ1mFCx0EgbW88nLRAlG1Yfne287nSdIH?=
 =?iso-8859-1?Q?IbAboOW4rMWAur2VyrhxjZeSp088lD5dfSr3eRnhjhJ9TjkM5OmmTiOLKv?=
 =?iso-8859-1?Q?9VWKl+96OO/t161zOTLMiiwI9zvY7Gbvy/BooofvLowj5joOLsGajt0Cj8?=
 =?iso-8859-1?Q?9K87OKAUqPohEezRM91XLtNF8iDw5bcqp/w2qAoD/7LYNj1KgmIisbPwus?=
 =?iso-8859-1?Q?zYCh67ig2K9cENvH1kw6Gt2tkjOoBD9WsfP+mjgS0FkLIjfV0uwBMk9b3o?=
 =?iso-8859-1?Q?5UgV/DSWcpwf2gCI0Q2F6eZ6/NnQZ4ICcSCAhIZkSBoQgrHaPBGYD9vw8m?=
 =?iso-8859-1?Q?eHolSgOjTvJ2y8ALjvtKE2+oJpTAQk/3Lw8IWO9DE157nW0ZmZSnT4mkC8?=
 =?iso-8859-1?Q?fTaQVAw58/h/P5mP0TeJBJN8b7/FBM0I6PRPt6qowdU1JcX0U0836FXkOG?=
 =?iso-8859-1?Q?gGpy60CayCKoC1I/U1KFMQaFj75hJGaxtbh7ML2LXdHiQHvXM4J5noAB24?=
 =?iso-8859-1?Q?tcWpEGwVeJuPIg7CgVm1KDjNIIAsJncxE/YbW0eaXd/77+hLqQN9Bc+f02?=
 =?iso-8859-1?Q?xOrebub3CXeHlNaoP8UarmHJAphoTibqANTk2McgIlW3XthAybJbBX577H?=
 =?iso-8859-1?Q?nqdIzVWG7EqBsmqQU8DVmz4jk1fsgV8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af54d54c-2c72-4043-3784-08da4be0c6e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2022 19:30:00.7545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1l2uLP2XYuslNSZMc9sh1zQVGEZGhoNgNYkOz0DE6IsBt/M0alHuaybs5pII5XAQuRsbL7f/oFjmCpBcKdbutRYsbXuJ83VTZSUvgaErOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3343
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Florian M=FCller <max06.net@outlook.com> Sent: Saturday, June 11, 202=
2 10:58 AM
>=20
> > Von: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > From: Florian M=FCller <max06.net@outlook.com> Sent: Saturday, June 11,
> > 2022 8:40 AM
> > >
> > > Hello there,
> > >
> > > I'm trying to debug several, probably related issues to your hv_ballo=
on kernel module.
> > >
> > > All tests are done on Win11 21H2 (22000.675) pro, on a Ryzen 3950x
> > > with active AMD- V, and 64GB of memory.
> > > An updated Ubuntu Server 20.04 Guest is used for comparison. It's
> > > currently running kernel 5.13.0-1023-azure, configured with 1GB memor=
y
> > > to start, and active ballooning between 512MB and 32GB of memory.
> > > Memory hot-plugging and -unplugging works.
> > >
> > > Issues showed up when I set up a Kali Linux Guest. I missed the memor=
y
> > > configuration before booting up the instance, so it started with 1GB
> > > of memory, and ballooning active between 512MB and several TB of
> > > memory. Hyper-V started to allocate more and more memory to this gues=
t
> > > since the reported memory requirements also increased. The guest kern=
el
> > > didn't see any of that allocated memory, as far as I can tell.
> >
> > Hot-adding new memory is done partially by the hv_balloon driver, but i=
t also
> > requires user space action.  The user space action is provided by udev =
rules.
> > In your Ubuntu Server 20.04 guest, there's a file /lib/udev/rules.d/40-=
vm-
> > hotadd.rules.
> > This file contains udev rules for hot-adding memory and CPUs.  You shou=
ld be
> > able to copy this file with the udev rules onto your Kali system, and t=
hen the
> > memory hot-add should work correctly.
> >
> > I'm not sure why Kali doesn't already have such udev rules.  You might =
grep
> > through all the files in /lib/udev/rules.d and if there are any rules f=
or
> > SUBSYSTEM=3D=3Dmemory.
> > Sometimes there are rules present, but commented out.
> >
> Thanks, I'll check these ones out!
>=20
> In the meantime, I was able to get it working, by compiling a kernel with
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=3Dy
> Which was previously unset. It's enabled in ubuntu and it seems to make h=
v_balloon
> work properly.
> This seems to be the same case with Debian.
>=20

Yes, that looks like a good solution.  I didn't remember that there is a
kernel config option to automatically do the onlining.  With this kernel
option enabled, using a udev rule obviously isn't needed.  The kernel
option was added in Linux kernel version 4.7, which might be
after the last time I looked at Hyper-V memory hot-add in detail.

Michael

> > >
> > > This is clearly reproduceable on at least 2 Hyper-V hosts, with
> > > current live images of Debian (Bullseye) and Kali Linux, but not with=
 Ubuntu 20.04 or 22.04.
> > > (Get the Kali live image, create a new guest (version 10), turn off
> > > secure boot and boot from that image. It takes 3-5 minutes until the
> > > issue is visible in the hyper-v console.)
> > >
> > > After running more tests with different memory settings for balloonin=
g, I
> > > am pretty sure:
> > > - Hyper-V respects the maximum setting for the memory balloon.
> > > Although it doesn't care if there's enough memory.
> > > - Guests can't use/see more memory than they had while booting up.
> > > - Guests can unplug memory.
> > > - Guests can hotplug previously unplugged memory up to their starting
> > > amount.
> >
> > Yes, adding this memory is done via the ballooning mechanism, and does =
not
> > require user space participation.   The hot-add mechanism is different =
from
> > ballooning, even though both are packaging in the hv_balloon driver.  H=
ot-
> > add is required only when adding memory that was not present when the
> > VM first booted, and that's when user space participation is needed via=
 the
> > udev rule.
> >
> Gotcha, thanks for the clarification. I wasn't aware of that.
>=20
> > > - The reported values seem to be off: After compiling a kernel on Kal=
i
> > > (and cooling down), the guest kernel shows a total of 3207MB memory,
> > > with 294MB used, 137MB free, 2775MB buffers/caches and 2611MB
> > > available. Hyper-V reports 4905MB required and 5840MB allocated.
> > > - As of kernel 5.17.11, the issue is not solved.
> > >
> > > To sum up: I could use memory ballooning if I set the initial memory
> > > size to the maximum size and wait until it got freed up.
> > >
> > > There are several reports out there about what looks like a memory
> > > leak, without a solution.
> >
> > Could you point me at those reports?  I'm not familiar with them.
> Yes, as much as I'm able to find them again.
> - https://community.clearlinux.org/t/dynamic-memory-broken-on-hyper-v/389=
1
> ... and the rest is gone. I'll post them when I find them again.
>=20

Thanks.

> >
> > Michael
> >
> > >
> > > I'm currently comparing the kernel built by canonical with the kali
> > > kernel, but as I am not really a developer, I'm not sure if I could
> > > even find the difference if there is one. So, I'm calling (and hoping=
)
> > > for help, and offering any support when it comes to testing. I can ap=
ply
> > patches, build kernel packages and read logs if that helps.
> > >
> > > Thx-a-lot!
> > > Flo
> I hope I'm doing this mailing list thing right...

Looks OK to me. :-)

Michael
