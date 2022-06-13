Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957AD548271
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jun 2022 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbiFMIyF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jun 2022 04:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240628AbiFMIxY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jun 2022 04:53:24 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-oln040092066109.outbound.protection.outlook.com [40.92.66.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA24B624E
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jun 2022 01:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gI0ibGcgJsiMGovaRUhAjgOJLYRgG3EXRJ8f0cBssLqYVn12FPc2WYwUKzKkWuErNiMCQGnPNZV5J1em9c2r5mRF2jnuP+PoXCBijiwTdq8ZdzA3E7OTLwbp5ZCSzzNIVsEN/dYfVuOtkYEsn8XCWyzogGzYUfWGYfi6QTghIDo4o4hQSI1rkpc9vAq7WyOcycbV9/HVvw/pDUGsMQj9kRQb0PVBiE2yKFJC1geipwwQb7Z+sOhqXCwOFJFg7FkI/rwYitcCFQ6/H+F6BQOvSUbTQG69MxIBmvCapMDVIiDoGPVmjCHZJTSkBGoP5kpb0aTKmeR87A+6n6ZS8nHIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9Xmsatw1JmjZ5ntTbWrcaEfGBLhCLhWu5Pzwm4SRKk=;
 b=UFR5VvnLkJUBsO8taY46rlM0CzjFrkn7CtYtC1h3arHN9dMsxtgrZPORKjDYN9+G05WNQZxdUszb5DyPnedYaHOWn9erRCpOyy8evIm/k2PGiESg6jz6GWDNCdFS/z18kEhBt/qHzPzhzuOoPJSo80lc0XyOYaBtb+33Yk4CyrKrnb42LRlwUi9a97RkewdMqNKjlYnYIK0LOrpJgFPq0vPpu9keBb6bUAarmDNx91ilTVgoTzTKzq/qS/h9wRDUnkcfnIdvhCi9LP3EuTR8dn+mEyWY6JBG4SMzNpBfDGmO6BPyphO76Q9KHZgL/0JVhLgnjrQBiru9K9Srq78Mjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9Xmsatw1JmjZ5ntTbWrcaEfGBLhCLhWu5Pzwm4SRKk=;
 b=m5zb9MHfMkx9jDvffk5qufTLAyT5PXwtAmjhahsYm6JMrHAcwQ297wDs/ojIBbqgBJyxrsKy9JNEbrEU6pucFrRFFhyl0sAPXZ8KR0GnH29Nc6wJ52o3QbpI3fp2W1F66ouqMBeL7NsvRzcnD3HaWZifE9VoedRCJwGpmwWZQ1tgLp+AoEzeHJ4Mkcs2cGndpE2Ubj+KGmy7h3nHr8T4UfUeMs18TLw5PHTj/p/O9wlkt4SryiwCQeCDS9uMES4247L4uFvdwt7NX6xDZKziIbkgyrFhccdlnRIGosnRFLy5VRzHy5qLfFzRAEGq9rmdrrFaIdoQz73BQjDXDJJ6Pg==
Received: from DB3PR0602MB3674.eurprd06.prod.outlook.com (2603:10a6:8:6::17)
 by AM0PR06MB4035.eurprd06.prod.outlook.com (2603:10a6:208:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Mon, 13 Jun
 2022 08:53:19 +0000
Received: from DB3PR0602MB3674.eurprd06.prod.outlook.com
 ([fe80::69f2:bf3f:5091:da62]) by DB3PR0602MB3674.eurprd06.prod.outlook.com
 ([fe80::69f2:bf3f:5091:da62%7]) with mapi id 15.20.5332.016; Mon, 13 Jun 2022
 08:53:19 +0000
From:   Florian M?ller <max06.net@outlook.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        David Hildenbrand <dhildenb@redhat.com>
Subject: AW: hv_balloon: Only works in ubuntu
Thread-Topic: hv_balloon: Only works in ubuntu
Thread-Index: AQHYfamAAWvh3ZSqEEGxb5JpUeTQGq1Kc/WAgAAHN5CAABp5wIAAAvTQgAHnZtCAAHuLgIAAC5sQ
Date:   Mon, 13 Jun 2022 08:53:19 +0000
Message-ID: <DB3PR0602MB3674C185377647FDBBEEDDDCFFAB9@DB3PR0602MB3674.eurprd06.prod.outlook.com>
References: <DB3PR0602MB3674BB09316BB82B4116F27DFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB302513B8500C25CEADA56718D7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB3674E1BD958D00FC4B9124ADFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB30252F8660A16DE36206B0EBD7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB36740EE00B8BA3B897BCB7C0FFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <BY3PR21MB3033FBB3CF2011B1D0DA2978D7AB9@BY3PR21MB3033.namprd21.prod.outlook.com>
 <87r13tj8ou.fsf@redhat.com>
In-Reply-To: <87r13tj8ou.fsf@redhat.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [9fjUJ41Ji7gWMEuwa8b1Enbl9o0LZpdZ0WZvA4QLRplXKP7nfnYwB+vy0mKANtFP]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f42f5af-e5f6-405a-f8f3-08da4d1a2a14
x-ms-traffictypediagnostic: AM0PR06MB4035:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OakLjrQos82GW7A5fUGfRbPuKYOUYeKNynz5H1+fnBJ3SqCCH56oocA4vu7cKW3JWmb+cz3qnyttEMRUzCx8Ebb82rYf+1MRR/OyZ+zY8/3mCCNkT6syId1f3fh9Jn7ZHxF6KLZ0qj6RZ+J7VJwFeqqyGgqc1ceFaE3Rpy0KPk5DAM/lB0GWvB6oDutS/DHHok39G3gdqMTPU923B93U/JoEMxJYZhPjZ2kg2K40Xpi50WIBXsvRFi+J9QGvmmNhUZ2Oje7SlohXvCz/hiqNV2FuArCRJ6gKtw4/P9m/FiJx2XhcIlLYmo3D1s7ByRc2SatPRinLERnK5OiDT4FwF0xbNeL8n8QJHdT0t9zWUAGthNguJFmsyzsN9SPxTWi3MwqJnYCLEZdnbdVY16XfWP1kSCE6KTwmeXyuH1yyPY6Dwvqfh3kj+VE+x5JokyWmRjBKU3tdXqERA6Qk5FKrHMWhxcuk/WmaAvfDu1UBcJXC07AiBMbtdlwS35H1gG1dgD1hdY+8v7jmb13pdLKI5fTpY+2QyDaXyuRFVHRe2KbdA/OaQ15bQ3OTJQwSnFCtkZ94aeGKJ2W0eBJT7Hw1LA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3MboAEPJ2IJKrEugDw9UZIEi5GdIwCukFUr009ycqmNBoq8brKWZ1+VsgxKu?=
 =?us-ascii?Q?fU07Bqo7VQ1om8N5TCNKH++5n23fFTTOqc/EzRajqQwBEl2n4UyGD85E83CA?=
 =?us-ascii?Q?+YQWginX3zgf25ZFFDP+ir4t9RopwC7Q5ldFPlTkk4wRSCvXE19XjkMGqOg0?=
 =?us-ascii?Q?NcItD9l9FKfGWYLm8d+nELOwC96cutSYIImM7MEpzzSQk9C+9K/4SZjucNc5?=
 =?us-ascii?Q?VaZy/CwK4aP1UlqvtaM3xdJArffktF4J8O3gIerySYel+qjr7Y8FZX2c6rws?=
 =?us-ascii?Q?jUG0T/cUu9LDkCvhRpbohm7/W/UIyNjjnTMpNLUflO0SExeHjo65l8Rk/vsE?=
 =?us-ascii?Q?pxjbgM3K1AK4y4pIHpTDMA16MYVFHROpKcuEUJbpVSrJ96X2Mouh5aqhUxrw?=
 =?us-ascii?Q?VDALJzq6/sPkA+yB5uoED6Tj7uUNx+CBxN3qYGD9WaxRkhD3sWpdjM9kVyP+?=
 =?us-ascii?Q?AgojCBlqB2o5GdYRxoofcGjs1kQ4R8c8Jtxw7MgC+0hS/BmaKrfC9nBgEid+?=
 =?us-ascii?Q?KBcJBImAwp/QIwa1eBo2QsWzy2PTH6ygUQacciXBUgCYI5tMP6IhFK+rXcHe?=
 =?us-ascii?Q?Cjh1AsgelQVKOfcJA6JnNMrFfRyi1jQLuo9fFKD6tT2FdFlW3ICLul6CIMff?=
 =?us-ascii?Q?/d2bD49TaB09buMp2CSHfnKp8FrDHpu6qU31l2H9f+swZZP7Z4FZ2GMlU/Zc?=
 =?us-ascii?Q?wQiFOMjYRFJ15r1DLEinJ61BVdqqMFAztZ7qussnuHYL50h9C4GPhv+syEQ9?=
 =?us-ascii?Q?odC+pRsbz83m4hc/hG595j86m9rFkAERZmDN9vgn0F+LU7n7aUYuv51DhwBG?=
 =?us-ascii?Q?ive7PFGtth3glTlnMbMZTSoC5K4DLfR51y4DLBKfsyJnQBQMLWX2TeG83STS?=
 =?us-ascii?Q?MI16n/2Bz8lFatyHlJyTOxlxJ6x/7dP+7NtMFwsRAZVgdIqgMcmd3n10Hs7w?=
 =?us-ascii?Q?wSSmT5S/N0fxbvLq5hpAHSVF3YHTWqoxVgPyMNAgXxmP5tc6BiyqsYnApYp9?=
 =?us-ascii?Q?RiK3HJk4bP7T24RMl/gdv73VrD1eEArT0YCLbqYfUS7LnGQpq5NhxYTHCDwD?=
 =?us-ascii?Q?0SzuCN9pd7k6GzIbXt1qtn4QjU9wwU/dE2/X85Bt19SDFgkR4ie5X0IWj6GH?=
 =?us-ascii?Q?wYD8vq+tqpMdzqeT5ebo+QO6GnvbOqJ1bEomvuDFOh9XE2c6HWoXmH/HHlpB?=
 =?us-ascii?Q?eSo8GIfLWTMnF3gqcDtpD/T9VoJmeyqfQ14RGHHlsm9Fm5tpP5AJQX5euyvS?=
 =?us-ascii?Q?P28FwDJF403ktk3oXwvL6br8KSA2Vh29czIdoI7pKYhrtWT5f/4eWqDBwI8U?=
 =?us-ascii?Q?bSxck9loMZRnwzPj2/tMfgvaLUYpV7tHrctJzmXUjaiXHk6s0SBmJqG74pSP?=
 =?us-ascii?Q?ZDwFd/XYT2PyujrOpyhOesgqkQ+u63aSLDw3ICdB1OofCb5ex4AxClPNbiFs?=
 =?us-ascii?Q?Ug6sj8OkHfZA4WMg2yR3BVY3nUEXQsYVyDH5/u+pQOrOXk/pRpjcGTtZrTTY?=
 =?us-ascii?Q?f/XrOWSPetYYaPQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0602MB3674.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f42f5af-e5f6-405a-f8f3-08da4d1a2a14
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 08:53:19.6383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB4035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> >> > > > >
> >> > > > > Issues showed up when I set up a Kali Linux Guest. I missed
> >> > > > > the memory configuration before booting up the instance, so
> >> > > > > it started with 1GB of memory, and ballooning active between
> >> > > > > 512MB and several TB of memory. Hyper-V started to allocate
> >> > > > > more and more memory to this guest since the reported memory
> >> > > > > requirements also increased. The guest kernel didn't see any
> >> > > > > of that allocated memory, as far as I can tell.

Please do not forget about this: (emoji-pointing-up)

> >> >
> >> > Yes, that looks like a good solution.  I didn't remember that there
> >> > is a kernel config option to automatically do the onlining.  With
> >> > this kernel option enabled, using a udev rule obviously isn't
> >> > needed.  The kernel option was added in Linux kernel version 4.7,
> >> > which might be after the last time I looked at Hyper-V memory hot-ad=
d
> in detail.
> >> >
> >> > Michael
> >> >
> >>
> >> Awesome!
> >>
> >> Last question: Since not having the kernel option by default and also
> >> not having the udev rule in some distributions causes the Hyper-V
> >> host to eat up all the memory up to the defined limit (and to die
> >> eventually), should this be considered as a bug? And if the answer is
> >> no, how can I (or anyone) forward the requirement to the publishers to
> be solved at the source?
> >>
> >> Thank you!
> >>
> >
> > It's unclear whether this should be treated as a bug.  We certainly
> > want the "right" thing to happen as seamlessly as possible, but there
> > are tradeoffs.  Back when Vitaly Kuznetsov added
> > CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE,
> > I can see there was some debate about whether this option should be
> > enabled by default. There was reluctance to do so because of potential
> > backwards compatibility problems with other environments.  When
> > hot-adding real physical memory to a bare-metal server, apparently you
> > don't want to automatically online the added memory.

By bug I meant the effects on the hypervisor (see above). A guest without p=
roper onlining of newly added memory is currently able to choke the host to=
 standstill.

>=20
> On x86/ARM you most likely do (as why plugging in memory in the first
> place?) but there are not many bare metal systems which allow that.
>=20
> Note, there were some developments after I've added
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE, namely
>=20
> commit 5f47adf762b78cae97de58d9ff01d2d44db09467
> Author: David Hildenbrand <david@redhat.com>
> Date:   Mon Apr 6 20:07:44 2020 -0700
>=20
>     mm/memory_hotplug: allow to specify a default online_type
>=20
> >
> > The Ubuntu image you were testing is specifically an image configured
> > for use in an Azure VM, so it makes sense to have memory automatically
> > onlined by the kernel.  So I looked at a generic Ubuntu 18.04 system,
> > and it also has this kernel option set by default.  But as another
> > data point, RHEL/CentOS 8.4 does *not* have the kernel option set.  So
> > each distro evidently makes their own decision about this.
>=20
> Note: Fedora kernels come with
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=3Dy as well.
>=20
> > But both generic Ubuntu 18.04 and RHEL/CentOS 8.4 have the udev rules.
> > The RHEL/CentOS 8.4 udev rule is more sophisticated in that it does
> > not online the added memory when running on System/390 and PowerPC.
>=20
> I remember that with s390 we certainly don't want all memory to go online
> automatically because but I don't remember the reason :-)
>=20

So, using the udev rule is the easier solution, it doesn't require a kernel=
 configuration change - but it needs to be added (and managed) by every ven=
dor.
Changing the kernel default is not the easiest thing to do due to possible =
regressions, and it can still be overwritten by vendors.
Having CONFIG_HYPERV_BALLOON require CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE s=
eems like a good solution to me, but I'm not the expert here.

> >
> > I could envision changing the Linux kernel config rules to
> > automatically set CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
> whenever
> > CONFIG_HYPERV_BALLOON is selected.
>=20
> That could work for custom kernels but not for those shipped with
> distributions as these will always have CONFIG_HYPERV_BALLOON if Hyper-V
> is one of the supported targets (and it likely is).
>=20
> > Alternatively, the Kali Linux folks could consider adding the
> > appropriate udev rule.
>=20
I am in contact with the kali maintainers and forwarded this mail thread to=
 them.=20

> Or just enable CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE. We've
> enabled CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE in Fedora in 2016
> and haven't heard many (any?) complaints (besides ppc64 where it was
> disabled) since.
>=20
> Cc: David who mostly picked up the auto onlining work since.
>=20
> --
> Vitaly

