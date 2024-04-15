Return-Path: <linux-hyperv+bounces-1964-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E908A4749
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Apr 2024 05:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FCABB22B40
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Apr 2024 03:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4A51CAB2;
	Mon, 15 Apr 2024 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="raeBFNhw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2094.outbound.protection.outlook.com [40.92.40.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB101CAB1;
	Mon, 15 Apr 2024 03:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713151056; cv=fail; b=sTLn8Nxgfu2zQMuQYeZTWgvbAm86exQIA/5ic6cmDdH2u1E3xvXXARg9m1x5dsorDC0PhCREuz71dTnVm+P3x6EseM579utqZhIyVA+LQgIfOotHSMTzko0mGqZ4My/71bvFItBn5ouPJj9zB4oXdzil4XupW4fBFd7Db3CnRjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713151056; c=relaxed/simple;
	bh=Uh7Rh2Gh8uuuMV5Em/29hdxu9m0cBlRJerEoZWxPuaY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qM3RypuBwwSHUASX7VVSfiCP0GoLoKBk+J65GCGqklQ517y8T4hJb4qh55RHdwrky/GJ4h3WPedrviACrmxTY3WrDbyGSAgcfUucy5U9Hsc9SdjCWv1Ws7gPBchauTVuprgwieZBzE5YIwQGIAu2DxgE5GsWv35RlF0KGSYEOyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=raeBFNhw; arc=fail smtp.client-ip=40.92.40.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtJte2EGz+TEUKLKRLwOZgeAYoGns3S6siORr5MJN9NdRyP+q1XuU0NEbnZkywEdGLSi0o0uteI6/PU53znY/K++drhJFEMcJFLn8w+bDMr3yMcyrb8VZOByN50X84OiHGJK8lvU1fOEuelrSI9rKx/nQ09MVft11dn8PjeE8+2d0XCYBdn5ms/6nfy0pCZ4e5kxxw5cewRuZ8wBPLS4r6IZtOfiEn3ExajF8CSXviQnvEnUCINudtQhmgujgtYmWCU2QzXEZ8L4JhVdkSiTo/w4s3N+hy073wbzyeSMMUrCv+QrFNuJ6k04WdKZiTsXxgKJhuUsOQE3VsA78dc/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12+LLVvHPIOUpyZcyggni2mFrQAaXNlw3IhJ834X/ZI=;
 b=b6GS2kBiNjClMeVnMapRVRtqDf8UzzMyFBojc/+w768tuT0zEamoj9fxi9MZmci1Lkp2Q0dCLQMQAdUdyhvkULJK2KM+RqnzUTGD8duqv/L8G72IxM1kwHmgxi9CFNKb/VuSdqPg6EYGymC9dIBlSDBn5avfH4/cOh606IfQbupw5iq9NVPn6FITzHQ82fwFS6GbGn6MXVhZ5LfBpDWxEPkzLZv1TNc4Gvpel0lqyCBt+A0ID4eNzP9nDgxLHMtTe2M+b1bOk7htSQ1hiHiCGo63Gtlw7MiiQ3M3AxStWYSF0mhaMDD+N3182WvdNql8b9TcZd1p0CXf1FrynWuqaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12+LLVvHPIOUpyZcyggni2mFrQAaXNlw3IhJ834X/ZI=;
 b=raeBFNhwQ1t4KvD8KLyyuqfuKPWd6tP2M6VVPeaWAHgueHcO6/dlygJ03ygFDcbVRJsB9lkLieKrYalFCvz/z14akwx6y4rOvriG0Gcd8qsi2DzRqKXA5LOREqO1kb8skpyKajTuhjdcZe4K026LCp5e8wL/nYpaUm5nPljCOkZq+VVfa6rl+egKlqjIWT7IDbuno0HOuA+4QdvzmC2RdFhMV/FzD/qMER0bL356NQAv2WxuKjrOyeXSPgn0ZjpXiaK7B33+oXCMWQB1ZBp0tFOpWJwwkoyyaJDewxarED6CbQhqJOCPFlVzf4p21Tx60XJOf9qZfpLgeMKcWzrGag==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB8905.namprd02.prod.outlook.com (2603:10b6:510:1ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 03:17:30 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7409.053; Mon, 15 Apr 2024
 03:17:30 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Schierl <schierlm@gmx.de>, Jean Delvare <jdelvare@suse.com>, "K.
 Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
Thread-Topic: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
Thread-Index: AQHajaNnaKjzbQWkCEqfKgwSAQ9VW7FopBnA
Date: Mon, 15 Apr 2024 03:17:29 +0000
Message-ID:
 <SN6PR02MB41578C71EB900E5725231462D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <2db080ae-5e59-46e8-ac4e-13cdf26067cc@gmx.de>
In-Reply-To: <2db080ae-5e59-46e8-ac4e-13cdf26067cc@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn:
 [9n2551pDv/oGZe58bfXBmTiGgRf2r7I6bRn1kh15e8L0f5jRtNdTUNwRIaIeS/miSIw2sufnlPs=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB8905:EE_
x-ms-office365-filtering-correlation-id: dc170a42-b19e-48f9-02ae-08dc5cfa9572
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tnaQOYgvchB/T75F2Zfd2tdKURO1jM7oKTm3v9oTSJL3fjCzOn6jLNvJ0RTBy4jlbB5BF9nwwLPJT3TOzIBkdHnxv/XnyI/F4mqCaWA7/32vke+H46hcJOyoFOC3OpuOYXtqKh1ISZGgGW3/9LY1heq1tdeBdQSsstvPNJdsRcj3IuvvLHGOMD3mUNRzYkPIbg06t3/JzFbTgwaqsyj51muyVyzlojpdT5w7WXpx7m5oEh/hOM35CDAu4ygg0azWJee/zFKjj4s/8HdDzYjAv9SjlAWB17epTNj33lX/ZcSUvab4mH0oDUjLh+sJy2zOlOE7M82SYZBKYeqqWFQp7N6YFC8P0QQU+1equOXlxp7YTSu9UOuBFyZe5Ggwiz6FEE68YrpbvMK63oDb7DogU/C50l0Q+pyXm15YK3InlOv7gMAkum4w87FjOGsJJw4g0lAGQSz4BbAwQJZaE/pM+MzpmF7VTNIzgUyuc5YApapKv1dLRoYhUTLFvKfQ9in2GBdQ/s+7LazRg5zfxf8aKTqFauZiFA3ZoMfn/MygIFkUWy6Rzv6FbUPC+8tDmsKpP62ry2vmW3twFhmBs2Y+iHI0BeKklmwj/i1nzXqss2hOyPq9LajzmWdCIS76SnJVYh4w2m+Xw2cl41q6RVMgzXhaX87cxFxHUm+9BgaHmKc=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CGElr2x9ijDKT4+sGXZYadGxGEIYm3IzzOaqWeu+kseSStQsS7SsQPoXI9mg?=
 =?us-ascii?Q?LYhS33URup4qAqFV8bM0LfhGUxzBemYE2MbIvyg/rsnb9+lw8wnxn8aD4TAT?=
 =?us-ascii?Q?fYbiIhvgtU4zTFrCahdd0tX0hfr/8dbzOLdIIHDRtG9NklyCPQ8yCWBc03fH?=
 =?us-ascii?Q?o/ryKee4JVCWZ/zCamfsZZjSLLQgYObk61jj3e0adVqpTZjlmul+Rhky9Dww?=
 =?us-ascii?Q?8h5ATbz1I0MNoT/S6Ff5OZQrgQhZrng83ziAvMd9ZvdWp/jK0ppL5WDwQTGq?=
 =?us-ascii?Q?H7pIAo4iDtyTe9bjD8HZOD0i5ECZb8fKbdGmwT99Ng86P21KYonAsex2NFg7?=
 =?us-ascii?Q?P51myuzyX8J4RaAzS5dPLlNrn7TV6xXgnMKCTrHOOtGOmmjZMJs8P1Bs+jDO?=
 =?us-ascii?Q?KfZBdibnIYfSX4wm6XG9JzHXx8zmXiF5ifEAhYmOOvCFen8nomToUlW7+fMM?=
 =?us-ascii?Q?04LeUe3nmcuTiLSr3mBzZk2P9X3A5mLdcNDm8AY1Cf/T6m996e2WP5i8giTg?=
 =?us-ascii?Q?RRuVBmMIR/9OrVYnw+R77KeHb/0vq34U7uHdNZ63qTLqTYG8mn/LJzOAChBH?=
 =?us-ascii?Q?NyeAxT4vWPM9w4jgztkg6ys90vQrd+Km6oHU0/fzrlhKHIM1UaZLTwxb0Ql2?=
 =?us-ascii?Q?p67Mqqc31/mYrQ63wJLdBUYDxieec5M6nPFXNSk3ciqbyM4nvdvYZ42RR7cK?=
 =?us-ascii?Q?AAo3Mlt7PlAMEIfuogdxd7A4JS9+5bT2W5PptC1qbw5nYQcc2x4WRiXz17I0?=
 =?us-ascii?Q?Akf0fDRwCFIZ5mk3YqtGXpAnczZM2uiidLdRgdACMYfsC/Yb07Gh/Te/s5qR?=
 =?us-ascii?Q?24t8syf0XzIngoJkuujh6vWK6C8ftyPftr6OvdbUB36rPkz/2duNO1p4IQN7?=
 =?us-ascii?Q?OfKArNBBA24WnvIwbZuQwDYC1FgrYAjvIEfo82oRQduXIh31h0/F2Ws4plkE?=
 =?us-ascii?Q?UTJM4seQaVbuFr8E/YSQ7qjvhKwDUzP/jsylkBw4UN/aDs+Ic/XGPf25Q5nc?=
 =?us-ascii?Q?Pgzh/YU2W2K3yXk7LDfrGfT6YDtz5zsBmT+sMK391rptOjqsDpP5CLRBMeJ2?=
 =?us-ascii?Q?bVI4Em7AxYyTmt08OLADDSUuEQNkua5EruzJ6DoDbxXJbn+7FcMmcb4yGjC4?=
 =?us-ascii?Q?yK7QSIyEuvnuqeUN5zqUZ8cX1ialsffBOIi3DIJfi+6+HuM3wHeWmW0Ck01a?=
 =?us-ascii?Q?iVtQwoYf4XA9Zm9kLY3K5rNwqdgEFVrCzsrD/xYbmKV375waomAwWLss8BQl?=
 =?us-ascii?Q?U1wzi6iUtzbvnYsE1NITt2iQw78fl96l7QTH4Mpiswg6oLgOcV5rXbeo17Sj?=
 =?us-ascii?Q?9Gw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dc170a42-b19e-48f9-02ae-08dc5cfa9572
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 03:17:29.8234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8905

From: Michael Schierl <schierlm@gmx.de> Sent: Saturday, April 13, 2024 6:06=
 AM
>=20
> I am writing to you as Jean is listed as maintainer of dmi, and the rest
> are listed as maintainer for Hyper-V drivers. If I should have written
> elsewhere, please kindly point me to the correct location.
>=20
> I am having issues running 32-bit Debian (kernel 6.1.0) on Hyper-V on
> Windows 11 (10.0.22631.3447) when the virtual machine has assigned more
> than one vCPU. The kernel does not boot and no output is shown on screen.
>=20
> I was able to redirect early printk to serial port and capture this panic=
:
>=20
> > early console in setup code
> > Probing EDD (edd=3Doff to disable)... ok
> > [    0.000000] Linux version 6.1.0-18-686-pae (debian-kernel@lists.debi=
an.org) (gcc-12
> (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP
> PREEMPT_DYNAMIC Debian 6.1.76-1 (2024-02-01)
> > [    0.000000] BIOS-provided physical RAM map:
> > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] u=
sable
> > [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] r=
eserved
> > [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] r=
eserved
> > [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffeffff] u=
sable
> > [    0.000000] BIOS-e820: [mem 0x000000007fff0000-0x000000007fffefff] A=
CPI data
> > [    0.000000] BIOS-e820: [mem 0x000000007ffff000-0x000000007fffffff] A=
CPI NVS
> > [    0.000000] printk: bootconsole [earlyser0] enabled
> > [    0.000000] NX (Execute Disable) protection: active
> > [    0.000000] BUG: unable to handle page fault for address: ffa45000
> > [    0.000000] #PF: supervisor read access in kernel mode
> > [    0.000000] #PF: error_code(0x0000) - not-present page
> > [    0.000000] *pdpt =3D 000000000fe74001
> > [    0.000000] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-18-686-pae=
 #1  Debian 6.1.76-1
> > [    0.000000] EIP: dmi_decode+0x2e3/0x40e
> > [    0.000000] Code: 10 53 e8 b8 f9 ff ff 83 c4 0c e9 3e 01 00 00 0f b6=
 7e 01 31 db 83 ef 04
> d1 ef 39 df 0f 8e 2b 01 00 00 8a 4c 5e 04 84 c9 79 1e <0f> b6 54 5e 05 89=
 f0 88 4d f0 e8 c0
> f7 ff ff 8a 4d f0 89 c2 89 c8
> > [    0.000000] EAX: cff6d220 EBX: 000024bd ECX: cfd2caff EDX: cf9e942c
> > [    0.000000] ESI: ffa40681 EDI: 7ffffffe EBP: cfc37e90 ESP: cfc37e80
> > [    0.000000] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 002=
10086
> > [    0.000000] CR0: 80050033 CR2: ffa45000 CR3: 0fe78000 CR4: 00000020
> > [    0.000000] Call Trace:
> > [    0.000000]  ? __die_body.cold+0x14/0x1a
> > [    0.000000]  ? __die+0x21/0x26
> > [    0.000000]  ? page_fault_oops+0x69/0x120
> > [    0.000000]  ? uuid_string+0x157/0x1a0
> > [    0.000000]  ? kernelmode_fixup_or_oops.constprop.0+0x80/0xe0
> > [    0.000000]  ? __bad_area_nosemaphore.constprop.0+0xfc/0x130
> > [    0.000000]  ? bad_area_nosemaphore+0xf/0x20
> > [    0.000000]  ? do_kern_addr_fault+0x79/0x90
> > [    0.000000]  ? exc_page_fault+0xbc/0x160
> > [    0.000000]  ? paravirt_BUG+0x10/0x10
> > [    0.000000]  ? handle_exception+0x133/0x133
> > [    0.000000]  ? dmi_disable_osi_vista+0x1/0x37
> > [    0.000000]  ? paravirt_BUG+0x10/0x10
> > [    0.000000]  ? dmi_decode+0x2e3/0x40e
> > [    0.000000]  ? dmi_disable_osi_vista+0x1/0x37
> > [    0.000000]  ? paravirt_BUG+0x10/0x10
> > [    0.000000]  ? dmi_decode+0x2e3/0x40e
> > [    0.000000]  ? dmi_smbios3_present+0xd8/0xd8
> > [    0.000000]  dmi_decode_table+0xa9/0xe0
> > [    0.000000]  ? dmi_smbios3_present+0xd8/0xd8
> > [    0.000000]  ? dmi_smbios3_present+0xd8/0xd8
> > [    0.000000]  dmi_walk_early+0x34/0x58
> > [    0.000000]  dmi_present+0x149/0x1b6
> > [    0.000000]  dmi_setup+0x18d/0x22e
> > [    0.000000]  setup_arch+0x676/0xd3f
> > [    0.000000]  ? lockdown_lsm_init+0x1c/0x20
> > [    0.000000]  ? initialize_lsm+0x33/0x4e
> > [    0.000000]  start_kernel+0x65/0x644
> > [    0.000000]  ? set_intr_gate+0x45/0x58
> > [    0.000000]  ? early_idt_handler_common+0x44/0x44
> > [    0.000000]  i386_start_kernel+0x48/0x4a
> > [    0.000000]  startup_32_smp+0x161/0x164
> > [    0.000000] Modules linked in:
> > [    0.000000] CR2: 00000000ffa45000
> > [    0.000000] ---[ end trace 0000000000000000 ]---
> > [    0.000000] EIP: dmi_decode+0x2e3/0x40e
> > [    0.000000] Code: 10 53 e8 b8 f9 ff ff 83 c4 0c e9 3e 01 00 00 0f b6=
 7e 01 31 db 83 ef 04
> d1 ef 39 df 0f 8e 2b 01 00 00 8a 4c 5e 04 84 c9 79 1e <0f> b6 54 5e 05 89=
 f0 88 4d f0 e8 c0
> f7 ff ff 8a 4d f0 89 c2 89 c8
> > [    0.000000] EAX: cff6d220 EBX: 000024bd ECX: cfd2caff EDX: cf9e942c
> > [    0.000000] ESI: ffa40681 EDI: 7ffffffe EBP: cfc37e90 ESP: cfc37e80
> > [    0.000000] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 002=
10086
> > [    0.000000] CR0: 80050033 CR2: ffa45000 CR3: 0fe78000 CR4: 00000020
> > [    0.000000] Kernel panic - not syncing: Attempted to kill the idle t=
ask!
> > [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill t=
he idle task! ]---
>=20
> The same panic can be reproduced with vanilla 6.8.4 kernel.
>=20
> By adding some (or rather a lot of) printk into dmi_scan.c, I believe
> that the issue is caused by this line:
>
>  https://github.com/torvalds/linux/blob/13a0ac816d22aa47d6c393f14a99f39e4=
9b960df/drivers/firmware/dmi_scan.c#L295>=20
>
> Or rather by a dmi_header with dm->type =3D=3D 10 and dm->length =3D=3D 0=
.
>=20
> As the length is (unsigned) zero, after subtracting the (unsigned)
> header length and dividing by two, count is slightly below signed
> integer max value (and stays there after being casted to signed),
> resulting in the loop running "forever" until it reaches non-mapped
> memory, resulting in the panic above.
>=20
> I am unsure who is the culprit, whether DMI header is supposed to not
> have length zero or whether Linux is supposed to parse it more gracefully=
.

Good debugging to narrow down the problem!

I would think the DMI header should not have a zero length, but the Linux
parsing should be more robust if it encounters such a bogus header.
Computing a bogus iteration limit is definitely not robust.

But the problem might not be a bad DMI header.  It could be some kind of
bug that causes Linux to get misaligned, such that what it is looking at
isn't really a DMI header.  See below for suggestions on how to narrow
it down further.

>=20
> In any case, when adding an extra if clause to this function to return
> early in case dm->length is zero, the system boots fine and appears to
> work fine at first glance. As I unfortunately have no idea what DMI is
> used for by the kernels, I do not know if there are any other things I
> should test, since the "Onboard device information" is obviously missing.
>=20
>=20
> If I should perform other tests, please tell me. Otherwise I hope that
> either an update of Hyper-V or the Linux kernel (or maybe some kernel
> parameter I missed) can make 32-bit Linux bootable on Hyper-V again in
> the future.

Let me suggest some additional diagnostics.  The DMI information is
provided by the virtual firmware, which is provided by the Hyper-V
host. The raw DMI bytes are available in Linux at

/sys/firmware/dmi/tables/DMI

If you do "hexdump /sys/firmware/dmi/tables/DMI" on your
patched 32-bit kernel and on a working 64-bit kernel, do you see the
same hex data?   (send the output to a file in each case, and then
compare the two files)  If the DMI data is exactly the same, and a
64-bit kernel works, then perhaps there's a bug in the
DMI parsing code when the kernel is compiled in 32-bit mode.

Also, what is the output of "dmidecode | grep type", both on your
patched 32-bit kernel and a working 64-bit kernel?  Here's
what I get with a 64-bit Linux kernel guest on exactly the same
version of Windows 11 that you have:

root@mhkubun:~# dmidecode | grep type
Handle 0x0000, DMI type 0, 26 bytes
Handle 0x0001, DMI type 1, 27 bytes
Handle 0x0002, DMI type 3, 24 bytes
Handle 0x0003, DMI type 2, 17 bytes
Handle 0x0004, DMI type 4, 48 bytes
Handle 0x0005, DMI type 11, 5 bytes
Handle 0x0006, DMI type 16, 23 bytes
Handle 0x0007, DMI type 17, 92 bytes
Handle 0x0008, DMI type 19, 31 bytes
Handle 0x0009, DMI type 20, 35 bytes
Handle 0x000A, DMI type 17, 92 bytes
Handle 0x000B, DMI type 19, 31 bytes
Handle 0x000C, DMI type 20, 35 bytes
Handle 0x000D, DMI type 32, 11 bytes
Handle 0xFEFF, DMI type 127, 4 bytes

Interestingly, there's no entry of type "10", though perhaps your
VM is configured differently from mine.  Try also

dmidecode -u

What details are provided for "type 10" (On Board Devices)?  That
may help identify which device(s) are causing the problem.   Then I
might be able to repro the problem and do some debugging myself.

One final question:  Is there an earlier version of the Linux kernel
where 32-bit builds worked for you on this same Windows 11
version?

Michael Kelley

>=20
> [Slightly off-topic: As 64-bit kernels work fine, if there are ways to
> run a 32-bit userland containerized or chrooted in a 64-bit kernel so
> that the userland (espeically uname and autoconf) cannot distinguish
> from a 32-bit kernel, that might be another option for my use case.
> Nested virtualization would of course also work, but the performance
> loss due to nested virtualization negates the effect of being able to
> pass more than one of the (2 physical, 4 hyperthreaded) cores of my
> laptop to the VM].
>=20
>=20
>=20
> Thanks for help and best regards,
>=20
>=20
> Michael


