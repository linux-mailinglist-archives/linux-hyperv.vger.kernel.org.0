Return-Path: <linux-hyperv+bounces-1051-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5AE7F8CDE
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 Nov 2023 18:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC601C20A98
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 Nov 2023 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2D42CCDF;
	Sat, 25 Nov 2023 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GfUFeiWm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2064.outbound.protection.outlook.com [40.92.19.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3180411F;
	Sat, 25 Nov 2023 09:38:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNnk6AqB1LAzyFHkzVUal65xRiS754CpxqjsY8WV1f6KmGFb1dxFOUpQ+B1OXW+cWRx3GmLvnggQYKBTb6MFXTXeQVX5qgwYLvktv0CROCSm7dnZ6TgQbknjY0HpQ+qdgmjYULYA18F4rN4cewh3EUUpnkMGXqnjCwwS483cHaJ/ihExRRBA+VOoseskbH3kK9K16wGE+CG3ok/LEPPCfE1mjL6Fx50kpPk9fzVFqgILSdFmXDEy4NbDdMKTjtRkQQBRuoBE81DDl7r4nQ1CoqymnXRYrlULfuymR45SYBHRqw+ZrRU01UDarcQGOFQpoYSQXlcDL65OzazdtZ5+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=og4+7MZHH6R146Topj5gs5VEhSfizaxzw5Q7W7omkeE=;
 b=murnooisU5WRN5djsZ7bjX46feenZbeQBx6Heg/vp8DXWkz5aoK1tiJrnxQ//gHktoIwaIgiJUGEES+6o2YX/SDZ1kCAzxgWXzpxwLDB5WN9ex/EUz6FItCgx7DrdKo5G+ANLBZAP5uLdQfZ7WEQC8dH87oJF4RqXdaDt0tZ4ZV8WtriXDbmKYrxm4EDcxYAki+fSixYGGOx2z3mexPnsQovmdHwbYqvCvajZ0LeJE86vBDM7wNGeg3s7ZDJIJrp2V6y6jaLhpUF35arL05xqAfIaV7Jz08zybwRtyUNey+PMFEHL0Z9/7HnKQLK6E72FnYKxJjmPSHriCETAfs3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=og4+7MZHH6R146Topj5gs5VEhSfizaxzw5Q7W7omkeE=;
 b=GfUFeiWmKseXc5nXaTBGSQM90AMGcrr7X6obIvPZ3RzP05iGQ57tpezfi5e5QCxnNC+qMCVYYc/3fUbp1Y8ILXvgUSbG/TKx6DkhlUEILc1c/wdZGCH295nhwL5gSMtJgh79luzEl0zsw3bJtPozlAAemCreRLl2NVVJJ74tjIVCm2Hu4mqlQBhKCnjAmxKrQ2YRJMU7CEnRRQ7Bb1XNRrQk9bp6mz6e+hz/4f+AMlIZ9GuO+qVAPrFrzEsbjLuBgEnSfE5w1ctkt9NQdZ30MI9UW+wYzZA+gaeM98lOIU8yuFZhe4oQCzTLXXkxuSR3djXRCPDjnjVQcowaA0vTTw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB7940.namprd02.prod.outlook.com (2603:10b6:208:357::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25; Sat, 25 Nov
 2023 17:38:29 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190%7]) with mapi id 15.20.7025.022; Sat, 25 Nov 2023
 17:38:29 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Merging raw block device writes
Thread-Topic: Merging raw block device writes
Thread-Index: AdofxfWKzDnDIAxSQBW3cNh7xAf+zA==
Date: Sat, 25 Nov 2023 17:38:28 +0000
Message-ID:
 <SN6PR02MB41575884C4898B59615B496AD4BFA@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [EZXNHn8uBlR7UIUMMR8GZEdPk1eEEt21]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB7940:EE_
x-ms-office365-filtering-correlation-id: c41cd010-af14-450d-f30b-08dbeddd5608
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qOU5eqMR+FJphk/R28qwbDgtiv9nFaX3FSzBxmKXyAjUlUotH2t//XgsxJnG6/v2HcMg6G9KQDLSV8k6RaCjec0NdrKJdR52Io8bJnFzvCaYGxoPlFg3NeuJPMgdjQXw0oFOPi1lOpy1WCQLIA/aY6F02IAbgKOqNvyWA+/bPxQfv0OCk/QMp7zakWFH+1pNdO9wTRV3im0+YlVQ9bi+vZGP5ODWLpU6SiR+cNTsWS7ba8F7XG7aAGK6ZBs0vUhY+NfnxO/RpTA3jeCDF/hRgULCVudQT/w9v+IHvHIMNCraaX//xZhAYQ6T84TpCLATb8xe7SAhPeVbzs5tDPh8j3TFAzD3TzpcO/IJEYTe8Pqx9RCO9scVLObE7jrFpUzAyY2mp67Z66/ANznsrM5JghT3bOUdYQ36gfP1dz47jJ9HIFEL7GH9+8Pb6Lpztzub8WDdVHbK2ZFE6fa5fbgtRcLnSIXfYpeadKqIMxj9gr0tpOuQV5mlNU4UnmLvMhFdaxk7SXmkppdZ6/ITz5I81BR4Uyq1S8AQIgSaGCHDRFO8uhZCp3JFGhsoKe29F+ANm9WIg0iZjrzEFSihQP6zgBDHXcb8CtrRG+VqENeZZ5Y=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PmpS1RXDOa/ImRJkTW2PeTZzKWU5O6B2WtvgTZq1yqOc8K2Nbh0UVW9MzxVl?=
 =?us-ascii?Q?rAY2Pxt71tQJxoAyqDmHFWFgxJMrFpvURhICUgNOLEjezYzCQis2Zrc9E2+7?=
 =?us-ascii?Q?in2/oWHTY+9LvorgTvxTPfWKYlhg/Dh4ymKxibKPeiD41I+/M1HCeaF865il?=
 =?us-ascii?Q?OCd+AsDfBwYvTcNMx7QKk6PafwM5TGhhG4+/hg7n7ss4FHYj0RAxBHkiKpp7?=
 =?us-ascii?Q?S+NunizuZtiG3IxwYv44muH3ET+3aS61d7WhuZ7h1pfcHVdtQfqMNxilIRrz?=
 =?us-ascii?Q?oV1d1+PNtKOWWSWQg5eQixXdUDF+nld7/m1i7dQGssdYoEO/BUMAGewCrTFr?=
 =?us-ascii?Q?0DlQb1nybRNFgOmIUQ3YB/QGx89CsnuSQhVUr8q7HCXwIAvpuZrAfiK0xIA6?=
 =?us-ascii?Q?hV1ex8R32vDyLeuo14F/Bh0T4UhUiEzjs6LMAEd1ftAAe9OlNTVrjOtrQUTI?=
 =?us-ascii?Q?6e2WEpYohVJqZU+kbkgQp4WxD/detg2k7MqB6Vly51dLUrIOhnbg0ivOM6qe?=
 =?us-ascii?Q?U7kl4upbigoTFiDu80s3xwZKcntdg3BYLQZ9PW5YuVcNzfco40evpWvnEyF+?=
 =?us-ascii?Q?c9p+dp/76AMnX00VSUs+/A/fRya7ONNU/TrG5+J6D+lhxh/rLscqvfH/Pxnl?=
 =?us-ascii?Q?KBY4rcHbTAIN+/L3i8oVL72bYJy4UNF1ENPpa9fjcxB9NhWb8hXe3SYM2A5e?=
 =?us-ascii?Q?kKmq3FD0sfiJA0MSXUZq63SsqhhjYIu4Zdk6G8H6xuAM3Kl6dNIRMA4GVbbk?=
 =?us-ascii?Q?nDRfMZhOufIsh4mKUov9H4Vu/Vw+MuaPF5aMJroY5WLH1A/zOLzrd0u4G5is?=
 =?us-ascii?Q?0bQX09tXqGfr1mVcf4Qk5XG+l/YGnKAB38fj5v6YefZk2bK7XnI0XWB3zcxe?=
 =?us-ascii?Q?8HX2Y6LW1S53vf4H1vpxeNsBEwmV8MwQxxWtA/WnRppmXqixDvq2MM7qTn9g?=
 =?us-ascii?Q?7JEARYbctqIrp99LgD6H6eVJneTGD2HWXKDam3DjU6xI4tNWFAxZlIFcy9jN?=
 =?us-ascii?Q?801+QkfpBgMwiKSlQEhiJRIfvlskee4QvOGY/t7y09oXRIOzmuHytnif4eXz?=
 =?us-ascii?Q?Ml1AmuFjQEq6yKcbBcaP97GoA5S339viLFo84JDFnxc/jj5/2e0O7JtEofSB?=
 =?us-ascii?Q?SPSf4kk0pNS6qKekmrE1sYPF+Bj2wKucIiV3lAiazH0RRspVIXwJND9c3rKx?=
 =?us-ascii?Q?1kwflvcP6UcsXvN2Efk8DfR+E3Okb180XfH8gg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c41cd010-af14-450d-f30b-08dbeddd5608
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2023 17:38:28.9811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7940

About 18 months ago, I raised an issue with merging of direct raw block
device writes. [1]   At the time, nobody offered any input on the issue.
To recap, when multiple direct write requests are in-flight to a raw block
device with I/O scheduler "none", and requests must wait for budget
(i.e., the device is SCSI), write requests don't go on a blk-mq software
queue, and no merging is done.  Direct read requests that must wait for
budget *do* go on a software queue and merges happen.

Recently, I noticed that the problem has been fixed in the latest
upstream kernel, and I had time to do further investigation on the
issue.  Bisecting shows the problem first occurred in 5.16-rc1 with
commit dc5fc361d891 from Jens Axboe.  This commit actually prevents
merging of both reads and writes.  But reads were indirectly fixed in
commit 54a88eb838d3 from Pavel Begunkov, also in 5.16-rc1, so
the read problem never occurred in a release.   There's no mention
of merging in either commit message, so I suspect the effect on
merging was unintentional in both cases.   In 5.16, blkdev_read_iter()
does not create a plug list, while blkdev_write_iter() does.  But the
lower level __blkdev_direct_IO() creates a plug list for both reads
and writes, which is why commit dc5fc361d891 broke both.  Then
commit 54a88eb838d3 bypassed __blkdev_direct_IO() in most
cases, and the new path does not create a plug list.  So reads
typically proceed without a plug list, and the merging can happen.
Writes still don't merge because of the plug list in the higher level
blkdev_write_iter().

The situation stayed that way until 6.5-rc1 when commit
712c7364655f from Christoph removed the plug list from
blkdev_write_iter().  Again, there's no mention of merging in the
commit message, so fixing the merge problem may be happenstance.

Hyper-V guests and the Azure cloud have a particular interest here
because Hyper-V guests uses SCSI as the standard interface to virtual
disks.  Azure cloud disks can be throttled to a limited number of IOPS,
so the number of in-flights I/Os can be relatively high, and
merging can be beneficial to staying within the throttle
limits.  Of the flip side, this problem hasn't generated complaints
over the last 18 months that I'm aware of, though that may be more
because commercial distros haven't been running 5.16 or later kernels
until relatively recently.

In any case, the 6.5 kernel fixes the problem, at least in the
common cases where there's no plug list.  But I still wonder if
there's a latent problem with the original commit dc5fc361d891
that should be looked at by someone with more blk-mq expertise
than I have.

Michael

[1] https://lore.kernel.org/linux-block/PH0PR21MB3025A7D1326A92A4B8BDB5FED7=
B59@PH0PR21MB3025.namprd21.prod.outlook.com/

