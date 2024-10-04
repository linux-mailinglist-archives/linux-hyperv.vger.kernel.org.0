Return-Path: <linux-hyperv+bounces-3128-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4558B991313
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Oct 2024 01:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08050282B5A
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2024 23:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16EC14F12D;
	Fri,  4 Oct 2024 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pGCjffl4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012052.outbound.protection.outlook.com [52.103.14.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FBA14C59A;
	Fri,  4 Oct 2024 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084900; cv=fail; b=K3qCIS0sXQgpcOerQHFrd8mZI80ticCsvONrN8pp/c2Cq9ppL6DtVJgPYVEyrHNk4Zvk0CkwxkcPK1gpiRzGZ97qS8rxgKTIH6+ijBEr3tl11LXDLu5wTjdGWcpqU+gEjq5nXUzUu9RVsqzAPTbmkojKwlcCRniOBsfQGnJbdGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084900; c=relaxed/simple;
	bh=1Jm3M/w/qJJcmiiYEy1rql4/z4fn/2aScn+ySSzi76E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dUTGAQ3DzVIlJ0Yk3t8vDYzyrj5ycPZUMlv1mv5dHPMGgJbDg3sfPEjhjLErw/Wj5vq0J3DklQBYk6jxdvPJuSRXKlgfqpBAIUNCL1a1d8xTNGcf6fgFsr8Fqf5bRPrclwJM1C4XUjc4cDP8nOtIxL6YOk2lNN3jOZ3j7Y9RMlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pGCjffl4; arc=fail smtp.client-ip=52.103.14.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TR7xEqJA7G5SibYiGR8opLB8jO99F3aTT2mi7FVcbJI2sH6ErpfJ7jdybdnLIxD7ldOlp6KlX/wwGMEcPr2FHa8MPOWjQVy9E+7Q70JP1MreYoXJp6qaia9lR7VgVL8ngVysIJ8rMTY/I9APLCQSwkTCFzPUJg0nLEKLOUm5+E3LClwlpqZvlhA3pVoTEoyO7cboc+5sSN8Ywz2PSWEgFeichdy9/TNHWIW1aah2NgpLIxCWfmrGMIOpjxE/5zE1dg1znr7uadX1ljNfXvxZIW1p1Qk/xATQ+2LT0/rn21IfbxpOBoxeSXl10bVgJ5X/eI4QJMfk4mQ1iYKDW3KfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMLewG4sX0BpJehAjdER/q0fR3ruLakodWHEoIqUHVk=;
 b=rCRqYyfBzYCvvw1IrOX73bH9Kqm4ZR/u0CYjYQuwtsji6/BltsE09T5h1qLFqWm/JyTa8xuRC/bQ8V55OCh7TqVQwAQx/lN0nZGvctiNrjg+mMiCF3ojZD5gHrMJGK/hWHk6MCjDmwJR+tTGFCaLn73CGKxosCw+u2LehGv7jTVmFcG6jO75vd+4nbX1uJ70190j5+nwJ7RnRoBm+CnNRKnAUoMJp7kJ7U52/LHQLClvkIorGu4LSCjPkVwKutx345OQYDWHWz7pNbVVEGkAIEBKv86ps6wrsYAVcIo04nJf6sGB03AjJSfjUp/EAoG5tQkQg2Mc80ZUCstt7ih3cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMLewG4sX0BpJehAjdER/q0fR3ruLakodWHEoIqUHVk=;
 b=pGCjffl4AXDYz8EGcR5ki1OYeeqp8PEqdxaC+EYYd7tIySuqunM+s7pzimLEM0NmW7nM3p4N8vbnQMmEQWH0CHvBQ0dXJ6WqdG9LhPXtsZjPOWsJSGz08xYGtY3Cf8C46YjReSDErXwNn8zltFMNPshKtg5msQTH9hsCDH6o13AZaIt2NYVbqBk/VrF3cYOByx3HnUbqOYEGzqGKyanEF6D4nwigpVfyI1z8Qusnd+APqvoWgKqcrfwbp/oVv1AipsLQ3pButna8+scA+ipUvRCLxh22Ztj22r0N7U7FRFmmagW+4cLOGtHOQG5DODyPS8hvbziG9QWOSiWlbdxSzg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8674.namprd02.prod.outlook.com (2603:10b6:a03:3fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 23:34:48 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 23:34:46 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jakub Kicinski <kuba@kernel.org>, "patchwork-bot+netdevbpf@kernel.org"
	<patchwork-bot+netdevbpf@kernel.org>
CC: Michael Kelley <mhkelley58@gmail.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 0/5] hyper-v: Don't assume cpu_possible_mask is dense
Thread-Topic: [PATCH 0/5] hyper-v: Don't assume cpu_possible_mask is dense
Thread-Index: AQHbFUf6M+mdOKKgFUaLQXc7WEQESLJ3PX0AgAABXgCAAABBsA==
Date: Fri, 4 Oct 2024 23:34:46 +0000
Message-ID:
 <SN6PR02MB4157B9D2128314E34E2F646DD4722@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241003035333.49261-1-mhklinux@outlook.com>
	<172808404024.2772330.2975585273609596688.git-patchwork-notify@kernel.org>
 <20241004162534.6680f91b@kernel.org>
In-Reply-To: <20241004162534.6680f91b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8674:EE_
x-ms-office365-filtering-correlation-id: 230dd006-ff26-45c2-bae6-08dce4cd21b9
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8062599003|461199028|8060799006|15080799006|4302099013|3412199025|440099028|10035399004|102099032|1602099012;
x-microsoft-antispam-message-info:
 6iE4MOXFyQfL354WQyDv/0wYbaNfdx82H9nLTcEvhpL1YYaqEK1uTLbV8qVZaFDgf8XKY3HQQ/RYCK+sVedLqb/XFH8sS6pWUbf1C1H0tRB9kphi1YTMDNGdcSWufdG9k9FXpI+NIUeDzGFa1OfdNnH5L+0Gihd6I4gxX16QnIHw/2T8oEa+9y0SFlp1hzr4RhsG07oZrwOG81TEWWnqofD59ASJ+T4UWUrnS0FBiDIDbfaW4NNhz4epOFhNl+NNXGYtnbgonqywikWfhYRxafF+SU/6XTNhwHkvH65u4bOQj/SgnHqcQDXlSNRUOdJvs/JKPEihCONu8duSqdEKW+pqfyE/8VJAnDjjBHnCe3p4/hB6LT6KmF4AJ6o9FIlXgTjclmaaPPsO6FCTiTEJG+FFL8dLo5wpI54L4q3nI/Rgph5b2QYh04lHLKrlDrXvpy/Nfa+l7HHPbZcvtPu6lxH0JT1PD+vanXLeGt0W9xzaaRLT1uYmlrfQCGOcRU7wHcOzdMTaT7Pmr+mS2SdujqL7iY21FOt3WGtSvYQjnreeSJR75j1t3/p5Id70mn9//fSVBpQOTYrbv1r5gNnJjs/Yvgla0dgLc2HeCTp6Q181sWWYd3OEY3DDvzH6ozRqp3TiNy65uYD54C9M+3PxBJncbJQdX68LKB0mGGaKyqv5Z5ekX+6y8pxAZJb4aAZ2pQpNUWpYKnUzyOJxTojYtpLkxtx0e8E6VIh7RJo+w2pWb2dXSi65xz5NlWhPeQKkOh7BbIyGgpvl4aDmgO9c0LmzwL7uGWdk8BByuJyOpEVRx2Ng5ZO9sFLRrKzMeaXWCq8G/GBtZrDPhM+ipbneGWJAYJiTt28poEhMs9G4xpbLdGjmD1mDu1cNqvplkPwe8sXk77fMwH9yAEXjFq7eBg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PBka90Xf0LXfi4RS/F5/JR8/gEeLZLa6wurkAleA0EQy82aVfuxYeBvctEWK?=
 =?us-ascii?Q?O3HoPA2mQj9IwRejOqSAAQnlT+Uwc/eN5+8o3QtPZ9/SsKHiRZyGVweEe4/z?=
 =?us-ascii?Q?WJ4bsyKFdEtKa3LBD8119Y0nU3jJyEowOTkzzLY/4oIGxLbbkgOuEfp1Zmzi?=
 =?us-ascii?Q?SvPRUvudbb9oPbBMPSyoTwmB2zcpBRBh/WQ9G62b2vWb3piKmatqSvq9BYnW?=
 =?us-ascii?Q?DN4LADrffMMIQ4jLMcEeUzE3N64YqLxhHgD4FZGBWed6qlpVFoQcaUbZ3bTc?=
 =?us-ascii?Q?/7tCTTZDTOIcDMOCPQjzIpPPAJZZ60eRDvU2EziNNM4vjNS096o9af6qAsXh?=
 =?us-ascii?Q?vSEqmMNpI0VGwV4mJT3Y1c9qfPIWeudmNBWVyIfUlghrbQfZKzU6bUtBPXcE?=
 =?us-ascii?Q?bNHOIQcw3KzGYnBG5iD9/eeknLRXoYkXg4K8HAvZ18RoPgY0j2QW4TQbh3b9?=
 =?us-ascii?Q?uj/DqWLoLOGR+qIo08s7Q28d9junkNAgO8mZDAJRmg2njuyDuxaxEkrnjucN?=
 =?us-ascii?Q?rBGboRtF3VsrfW5NaVgGGUaEnB/ND7EpSLPTn2PEVdKJptDyIfOcOAzhEcgq?=
 =?us-ascii?Q?kTmZMJ+XUWIa3yBz4rv80R84Pv5Q5HE0ykXrZcfjky2xwy8UdCRLZBpCJZpz?=
 =?us-ascii?Q?ad/5WmzkRRjYVLjf0Uq7YV/3VFPgdrJL/Ew4EtjcHJmLUOKIqmzJU1ODf6e+?=
 =?us-ascii?Q?8AVgzQhvc/kSm6U+oqxS9i/JfJrM0KcultXjfmKB+UZf7TXetW/kwNZN1dqR?=
 =?us-ascii?Q?facYZ1ex8jQuMNzQwrWkAMRWUsdSD1fytYVC9wikOeGPzhZk5KavF50gbfOG?=
 =?us-ascii?Q?HR0NmD64w30xeiEKhshEclK1YueFCMGC1FdBfSeRgLMmh6ILavLqkhuCtfMM?=
 =?us-ascii?Q?PMV3yyWP6QQlJGpy3awVTIj0o1S+XgihXSGp28BTeCjZtpP0XzEzA+EgroAH?=
 =?us-ascii?Q?1n42jM2vu7aA5c+l5VNrZiolHX/N/Wl1tNmib0eXPcE9HHVh7ZwsBUDmJHqO?=
 =?us-ascii?Q?kC8Q5YOyxIQ7XrbejbSUSsClKHooli09fGyUFSpyOJVwqpXvsapAqnI/u0Bo?=
 =?us-ascii?Q?xKoGKJNh0EZwSKuM676wogfUmcUYdpLuXXlA43JhJKtuU4SxDFeW8kVRQGse?=
 =?us-ascii?Q?lo/5JDxF9z0pzphFKEsJFDKYa5tHjsthUqwPld2Nyl6eABbsfNrS6+aUMlk7?=
 =?us-ascii?Q?4FXBcweSqeHWWQtwe/tb34T+JNuCh/SxlMUoItps7ToAT2ZPcNaxiRp4oaU?=
 =?us-ascii?Q?=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 230dd006-ff26-45c2-bae6-08dce4cd21b9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 23:34:46.4787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8674

From: Jakub Kicinski <kuba@kernel.org> Sent: Friday, October 4, 2024 4:26 P=
M
>=20
> On Fri, 04 Oct 2024 23:20:40 +0000 patchwork-bot+netdevbpf@kernel.org
> wrote:
> >   - [net-next,5/5] hv_netvsc: Don't assume cpu_possible_mask is dense
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commi=
t/?id=3Dc86ab60b92d1
>=20
> On reflection I probably should have asked you for a fixes tag and
> applied it to net :S  Oh well.

I thought about including a Fixes: tag, but decided that since current and
past builds don't exhibit a failure due to this issue, it's not necessary t=
o
backport. The patches are more for robustness against future changes.
I've heard differing views on whether changes that aren't fixing an
actual failure should be backported ....

Also, patchwork bot email says that the *series* was applied to net-next.
But appears that's not the case.  Only the network-related patch from the
series was applied.  Still need the SCSI maintainer to pick up the SCSI pat=
ch,
and the Hyper-V maintainer to pick up the others.

Thanks,

Michael



