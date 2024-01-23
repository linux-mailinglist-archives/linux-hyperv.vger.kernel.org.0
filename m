Return-Path: <linux-hyperv+bounces-1463-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61042839611
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Jan 2024 18:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860901C24A29
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Jan 2024 17:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5F680029;
	Tue, 23 Jan 2024 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ogEAn3oO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2066.outbound.protection.outlook.com [40.92.40.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1AA7FBD7;
	Tue, 23 Jan 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029997; cv=fail; b=eK2dx4mMoTGbauwoyDmgeffJBT/zowTG7UseF4tNk8AlAUqscXKg9tRL8v3Il1r9LRKpkijwTRKx/ecgeo7AiauRaV6jlfvP3pLO3aOnVX09I3ilIY+I7S4sMTuQrt8ftKHTjHtMxsi1+3AspzY+S7WnTx3JFRBY1/73B39em3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029997; c=relaxed/simple;
	bh=kaUrjFHhzsOlZolhF+PfeKVxrUOMqMXX6WXvBnlRgiE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a9KX1dxSc1TNSohcZtR5poQa080WrSrT2+YNfwVcQkEHObYpkIE3A1+qQQNMXWDh/A/TftvcR7zwwO2sFo/dR9/aDv/zd1p6AXx28nyVVmjFyE1MbD7yM6D+zHy5LfYmppoBP5dSOJA/l19bivssz2QwM8wfe02juFxqjeJ2de4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ogEAn3oO; arc=fail smtp.client-ip=40.92.40.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQv6B/X91lobf95V0xHr5WfCrF4Jn/TuRHEZpnn7/WINyvD4t01RRiCH5wYnZhPbEH5L+GqulmMXvzIfw6jsnW2swKcBv0Hg066pGhUyebsrTSc1rkS1EcgJx7lL4Sxz9PYFKOO8S5AxtWHCzHYbvoFqopxM8pASpJf5YpGkyJj6ubqWRenUO6n60kqd130ezfSuDCspKJPRLVYs3tSqE6z0BLxnFvy/ARcCUaCWp43DMmMCf6osV9UPE15M//6bTGyIft7K7GGG4NE2Hbh06C1RO+C6hWYrrei5dj0hpj0rLu/PtQBtRAtDFy+huawvUmsgd1LKybyE+1/M31k7rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg50tMxRffj8zYn9bzHc02yULaim/Qxt4FNFzOvGuk0=;
 b=azfrYx3A2nxdx3rxc5goV61rESkDa6pdyAFv3wuw4BQIfF6mjN4oiPaO4KN0ijSh0iwjEP8b53jExiYc/IZOF2rI7Ae5ism4ZKkH2lZADJg1NA7OCCX0kdxsvK5ItfsK5rFJ+4C9LBZvCPCvtoybRwxYqKXamSZCq5mmvdeMvCYHYBQNa2Yz1rJonZGSYcBU4gVURgYoi1Oj+DKn+udvH6oRAjB6E1gwiaog1C/2m1AXBQpOPcMLnNr0Urz/0L0Tkz0bsmeixdcZpS6cVNkgkTm2N0R3F+nQgDaJPd1TFhYYf9w97TMCLjr5jkHndMKZqShjAlWvsEi4rDrIbpmJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg50tMxRffj8zYn9bzHc02yULaim/Qxt4FNFzOvGuk0=;
 b=ogEAn3oOp/jOtQ/u/ma9tnEBDzoeB4/HSrtDqaQ/1ELCZGD2p9+7oAmutVCddHI53E9H4uLX8dKZxPswGJ++8mpwKEgF3YorrGl/8tMpA+Bzj9yFhHuAISxKBlYyeTMQ5c9rbMRYIcFo/pjUj1+pg+GfPNUTA7GBk8gGij9Stvep76F1HS480z4TZ9kOLK/hs+nIKTT4sEbfQOUFFcrv6uwjFWjgsjhxKwZfdIJ60/UtjhKFEOHRGEgJIssjBvpt8rQnjfMws72yroMMjwJ3qwYQHP3yFDV8QYUhiVKPpQfTMCljglKAcCooGNH/jwiIiIuECfz2QqT0jzohpGu8Gw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS7PR02MB9436.namprd02.prod.outlook.com (2603:10b6:8:ef::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 17:13:12 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%4]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 17:13:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Simon Horman <horms@kernel.org>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net 1/1] hv_netvsc: Calculate correct ring size when
 PAGE_SIZE is not 4 Kbytes
Thread-Topic: [PATCH net 1/1] hv_netvsc: Calculate correct ring size when
 PAGE_SIZE is not 4 Kbytes
Thread-Index: AQHaTVdiG3+zUa/dxkiVGclpDaRpUrDno97g
Date: Tue, 23 Jan 2024 17:13:12 +0000
Message-ID:
 <SN6PR02MB415753E9E46CCC4AC809220DD4742@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240122162028.348885-1-mhklinux@outlook.com>
In-Reply-To: <20240122162028.348885-1-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [wurbzdOaYRj3i423EUXEZ3WrX/j6Gm55]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS7PR02MB9436:EE_
x-ms-office365-filtering-correlation-id: 4fb55009-c833-4db1-4696-08dc1c369493
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 06mJDifudiFs5XUpoSjjjuh+r2WDmY+Tq1czCRxwMg7m6dAzkXTVDp886rVhji2ZnkKOnL8NuQbtsndZz+QA0KyxU+VE9bw59J02P88qxNGGBdyCDF14/ZbQlos9aWXN0MRXvOSY1HOUFHC9DAuAS0C1Jf026Hlz1qTlc3QRQI0rnL7txWpKpPRuwvkZF8Tblky45pP4d5pzIljQCldVppiYUl0DBiAi9JnJcII14I+gjjDFdxwqNgfo0UbmbOP95SrRotuMJI/o1BSOFc30mEdSTvDPemcTHOTmsg4uQ+jEwKrAsmRRz+MsRi7vBBnJcW1X8pDI9/qM9iPNoA95UN+NOPBVwHUl77/y38BniNPjyAHyw/7YcpYRLYWrJc9CIo+XfAU7lj7JbxXE2rRNvcvOo0IkRP/zdV7nzGPMquUGwgja8yUxPUEan9UTx15fEx2mVzmFHdxlGjHpePR7oVZHoqSM4SQpf7DWzWEkSWzbZ/LMXujps02VR9qfgc2jMayGojjdMfGLlE9DJKuy7RIqipRUZx+ZlmE/Zw+4XZGSpmlTuvMVpn6IJJ+lqpxed7gLBLhMtObLp+rOsj7FLQEQitUd3y6/DInIu1W3FvI=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kVcn30TEnIah/Yq3L82imZnG7lqlYH9uLBHbPi4rT0358NaF4hg+wVokpRj3?=
 =?us-ascii?Q?W0swdQOaCkXsRwwvhujynLcnwYpmPkydpCEVhuC7AIMiGkH1QqsqQo0XfxQ+?=
 =?us-ascii?Q?8phHB4EEVd4NkluCZQHkLSU5+o/owIBhRwZnBs22TWXRf8P3eXi0Z0PRKtBO?=
 =?us-ascii?Q?HGBm9udU7MnMoegOTlxhiq5ZRhMcYiO2odx3x6Seeg43GmZWBdXvAAZSU5x1?=
 =?us-ascii?Q?Q10JhUDa02PrksmwCjHj4TCQVKtRgQa93qmvtvjRXO3yzv6a4zMxiVNh8fyA?=
 =?us-ascii?Q?chAMBp1MU1FEhhwuH7AUl0Ms0SqgN4T7UwMRIFdZmezISEiLEy86OzijCGj9?=
 =?us-ascii?Q?VGLMEymV2ieen81S/PTZ3Zbn4xYDLnC/HhgZh2DTL1RuCXf9eVukRlwltmON?=
 =?us-ascii?Q?jmd782EFtJJ5BFLiO82UwSDDg+owkJ6WxL2sGAx5/ZsMiiXEbUXQuPgsrPNN?=
 =?us-ascii?Q?3YxSebEnJGoPlTvvxCcErmvLdatGnRX/G+XbWAsH5QEYMEn3Zykna77rzvT1?=
 =?us-ascii?Q?dLeeR/FMs0uHJDO649jQO6wW8IZxUKzSIb+xjZ4XSx1Fj22KPW0UcTKMlUV8?=
 =?us-ascii?Q?K61eVO/yYb/z6kNq2d2B3ev9eLcoHUCusRRI+Jf3maU3IQbjabWdiREbHtmP?=
 =?us-ascii?Q?xVFMcI/rGdStOIlddDJieHo3xChthdGQaiVL0gsS909zpn4yX6EHz5/LPIdm?=
 =?us-ascii?Q?3AwUhhLJ/ZRf/uaSRfXvShqS0LOMKgXX+5zsFjDqfoJHWSOZ29dOGkJaLnYE?=
 =?us-ascii?Q?ztNf0UpopSOmafjhjtTI6lxhNFNpJE9mWJtzPEyzhj0ynN1NTAf96QZeJHuP?=
 =?us-ascii?Q?LNMgDWIx4ARnFPqjSPDrVvMAPQm9XoBGGra/VXm9NBXVLDVp+5efvueRvaH1?=
 =?us-ascii?Q?6rgAMY/m1r39yZ+zAWeC4fK4BHAzc8tqWeqWnmwIgqPpjfFm8wg1Wbg8hK7H?=
 =?us-ascii?Q?tfUuO8+nENzF7dl/ofxUGGqbDiWsyaFjU03pJT0jc3cKJ7041S2262h4yBGE?=
 =?us-ascii?Q?A7NziNXgyRbzsT86qtzd0akW01jJfO1ILLaAU7oVgz5jmCU2+RhMbGk5Trfk?=
 =?us-ascii?Q?gyD8/xRf1c9AjuHmjZmCMrHD/HlIQofbbnbYkDAbhOUSA4mOEvsq5oRHruDc?=
 =?us-ascii?Q?9KqTjqd1jEqRDTiO46t15ywyjgIi9TJmr89ttFsP/+lJye2hGxq5BaQdSwug?=
 =?us-ascii?Q?U/LyO/5/RxvVaGgjTTFbChZ8gM0V5/Vrmfk6ZQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb55009-c833-4db1-4696-08dc1c369493
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 17:13:12.6105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9436

From: Simon Horman @ 2024-01-22 20:49 UTC (permalink / raw)
>=20
> On Mon, Jan 22, 2024 at 08:20:28AM -0800, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > Current code in netvsc_drv_init() incorrectly assumes that PAGE_SIZE
> > is 4 Kbytes, which is wrong on ARM64 with 16K or 64K page size. As a
> > result, the default VMBus ring buffer size on ARM64 with 64K page size
> > is 8 Mbytes instead of the expected 512 Kbytes. While this doesn't brea=
k
> > anything, a typical VM with 8 vCPUs and 8 netvsc channels wastes 120
> > Mbytes (8 channels * 2 ring buffers/channel * 7.5 Mbytes/ring buffer).
> >
> > Unfortunately, the module parameter specifying the ring buffer size
> > is in units of 4 Kbyte pages. Ideally, it should be in units that
> > are independent of PAGE_SIZE, but backwards compatibility prevents
> > changing that now.
> >
> > Fix this by having netvsc_drv_init() hardcode 4096 instead of using
> > PAGE_SIZE when calculating the ring buffer size in bytes. Also
> > use the VMBUS_RING_SIZE macro to ensure proper alignment when running
> > with page size larger than 4K.
> >
> > Cc: <stable@vger.kernel.org> # 5.15.x
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>=20
> Hi Michael,
>=20
> As a bug fix this probably warrants a fixes tag.
> Perhaps this is appropriate?
>=20
> Fixes: 450d7a4b7ace ("Staging: hv: ring parameter")
>=20

[This email is cobbled together because for some reason I didn't directly
receive your original reply.  So it won't thread correctly with yours.]

I thought about a Fixes: tag, but the situation is a bit weird.  The origin=
al
code was correct enough at the time it was written in 2010 because Hyper-V
only ran on x86/x64 with a 4 Kbyte guest page size.   In fact, all the Hype=
r-V
guest code in the Linux kernel tended to assume a 4 Kbyte page size.
During 2019 and 2020, I and others made changes to remove this
assumption, in prep for running Hyper-V Linux guests on ARM64.  The
ARM64 support was finally enabled with commit 7aff79e297ee in August
2021 for the 5.15 kernel.  Somehow we missed fixing this case in the netvsc
driver, and a similar case in the Hyper-V synthetic storage driver (see [1]=
).

As a result, there's no point in backporting this fix to anything earlier t=
han
5.15, because there's no ARM64 support for Hyper-V guests in earlier kernel=
s.
So picking a "Fixes:" commit from back in 2010 doesn't seem helpful.  I cou=
ld
see doing

Fixes: 7aff79e297ee ("Drivers: hv: Enable Hyper-V code to be built on ARM64=
")

But the connection between that commit and this fix isn't very evident, so =
I
opt'ed for just putting the 5.15.x notation on the Cc: stable@vger.kernel.o=
rg
line.  That said, I don't feel strongly about it.  I'm just trying to do wh=
at's best
for the stable branch maintainers and avoid generating backports to kernel
versions where it doesn't matter.

Michael

[1] https://lore.kernel.org/linux-hyperv/20240122170956.496436-1-mhklinux@o=
utlook.com/T/#u

