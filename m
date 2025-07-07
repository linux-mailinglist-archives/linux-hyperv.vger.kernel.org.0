Return-Path: <linux-hyperv+bounces-6119-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7CAAFAA0B
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 05:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98A53B8303
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 03:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495DD22759D;
	Mon,  7 Jul 2025 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="V9sTlSb7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2095.outbound.protection.outlook.com [40.92.23.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD21C6FEC;
	Mon,  7 Jul 2025 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751858045; cv=fail; b=SO/On2J0JOef5Py17og1DaNBCUuHh+HDcDLHJPXJFVHwhS8QBJXQLIwEyCRsi4eRPQeI8OFhxwltjociNhkMPG1e6An+dmvroBx8HBtRKf47OVHXvmwfokg06mYKRvDcOgfR3iWMv3H6u+VHnV9Z6g7z+77e9OklJTu4mgsUMPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751858045; c=relaxed/simple;
	bh=w3leaTdqGgVLRmXCKdXtNtYwIxzzvYySkBklis2hRys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AQ8rW8kgcAChZIoPSRcH823mfCuiQjFcxGQO4UJwi5T9P/El1uKlOIBUbUUp3BUajuirDFxe7t3R+n0WgStdoCMGdbuilUi7HHR+MTX0s1kibeZzmrWuFiqKu75rf4tn9LU3Nk7jeQbjN94y6O1Zd0zgIP11Ehw1zvAhu6kebiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=V9sTlSb7; arc=fail smtp.client-ip=40.92.23.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBNGEvPr1eJUMfnV3X/wA7ZtxP0S6PpjMIKsKI/RmyrnvUmjT7i8VBVxHBCjQtcqmIWpgtTTJ4R/qDwbvGB2F6zPvD2zNv+5XGJ6TMOdwbwvqRccmJI/epc5Imcj55rqq8wBJldLTuQKpL8lt/TqbL7NRSz8Fqyu5x5fDumbk9Ta9i9vcZI3+iXervO8HNbyrstfaT/0A6CnqNU1jxglTA9TkMMUMSFQa1KSDroaDkYr47ODat66wf+bsbYgzpTZMnXR0Idd5tJ64nINvFUlgj7VWkn3Xjz1R3/ZetMM8Oo6CrTAPEsHqF6K1kaC9D7NhCJhjUF/1MsPWioN97Atrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rGSdPBWqcFI7AIEM6yicEDmGbRWNzX+8tsybmUimm8=;
 b=P+wZA3zdgh0nlP287FJWYd+Tu8HazecRuXVbyZrCj8ZfIzlxTgH18O2Ooo0eelYNLpoB8thfkyxW27fwRw0Rk2b0jMjdtqBMflzYu4d7QrkQArKSSW9Af9KQhZoEotfiJ0qV557v/FNh2hVLUCpingMGqUlGBEFGbg7rnynDGXlPiclrZekN2R6ujcNWydzk7biUO59hxFWioGBAZkMoUyjbJu3QPicm9O6jYIc/Oekb92CwT9yrSHhHMFd0gRtVyT9s4DZNt7EASFMUfdDoZWLurq30333pjcSl5DaICoHHRGRXcRUmN6uqWGKfxv4wdL6cW2PGnc6nzf1+IATJyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rGSdPBWqcFI7AIEM6yicEDmGbRWNzX+8tsybmUimm8=;
 b=V9sTlSb7isZdvCZyTzOa+yXw1+kZUH0cXtVd3g5sxyRjycY+yHE0SnfZhEjahdoqitR04GOLzCN022P/m+COqUDUPDDKu6VCIDJmbwnY6xQ5dVlhWnpVXiLU4X88VNIbgq2UBDezswBUEy2VLn02JbBKQiy4KY4IXTuPdCr4wjXnbGpjAHj/jgf/KcNWJGlj87KgZ2GZdpuyVK0GYIFqFCBZrDpyd1pXEhgEFw91HkEHrST+snV+4LKaQAYSnQy6NU0IR21/143/n+JmEKXGvVyCamMqfuJ9imM7ieT3OI3jLH0U7kv3wVxGsASIaNMkmw4UqtkfnrBnqsYeEgyPZA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8543.namprd02.prod.outlook.com (2603:10b6:806:1fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 7 Jul
 2025 03:14:01 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Mon, 7 Jul 2025
 03:14:01 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "romank@linux.microsoft.com"
	<romank@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: RE: [PATCH v2 4/6] x86/hyperv: Clean up hv_map/unmap_interrupt()
 return values
Thread-Topic: [PATCH v2 4/6] x86/hyperv: Clean up hv_map/unmap_interrupt()
 return values
Thread-Index: AQHb7GwY5Vwihv5940qdvDB2sv1NorQkGkaA
Date: Mon, 7 Jul 2025 03:14:01 +0000
Message-ID:
 <SN6PR02MB4157A319239DDC7245DF9B35D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1751582677-30930-5-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1751582677-30930-5-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8543:EE_
x-ms-office365-filtering-correlation-id: 7987803b-9092-46c2-3138-08ddbd04523f
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|8060799009|41001999006|19110799006|15080799009|461199028|13041999003|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5DxRwCswMQoIhgsoB6utjzwsrMB7MNqVp908MxXOsZ5ME3KNOtrDx3PxPP0e?=
 =?us-ascii?Q?NuAQIhu80HfanEFsu5pNL9HWdpVcx3ISQE8htI1BtubtS+24aO+FlSk8BFHu?=
 =?us-ascii?Q?4choCvsV9qmsmdMpjXHDLFiJJ/ZHUXzlf/aaQD5P0QuDCQt9Q+1ub+P/cqHz?=
 =?us-ascii?Q?mntlfG6wDO+9MJwhjp49IakK9TpIfp2B38EYSj4RJ3vGBfytqNRE5hN+LFCF?=
 =?us-ascii?Q?z57O7NDPqdGMUlwLi/yhhN35ecLcUt1Xke1T5M+c4xvNUMj8ceKliqo6rQxK?=
 =?us-ascii?Q?R8gNbAv9ZQzZVk+V+W9cUDnHHIrvWWkaY4zTCkGFw+/OVt2pqwq2INRf/UbJ?=
 =?us-ascii?Q?2OWv35UjU7Qui5kiK/VahP00KItlQI+DchpKEuNih+V0tFOV8r+9IgjZBqFc?=
 =?us-ascii?Q?b9Fbl1iMmmX4ZvM2k59Azt98YiSgFr0zMNl/tpz65z2bTkn7irAdwvfzhjWR?=
 =?us-ascii?Q?ACKfK7o/IdADOOK7Pu+hFpBFz3wjnLIZXrHmLJvnBohMhf/zaZrXvm7pgKtd?=
 =?us-ascii?Q?K0K+QfSM8vAKD5psaHHw2rQHc7jnYPVt6YAt+v3bfXAl6Bo2UmV8cTElKDcm?=
 =?us-ascii?Q?UBYVcrAifwarKjJU0vE0b+bsUFw69NbP0D4a08Oi28x2vFyKzGnJnYnOps8y?=
 =?us-ascii?Q?HIQmxzvjvlf5e3gpZr06zumJUuRmFk4UO6vM0Jy78Ylf5eM2tji50LU0noa8?=
 =?us-ascii?Q?D8pIiHJFMOBi7URsi184Fh1OoNRZjVi8vA/E3c0Wycjom59r+z9qEpGZ9tAP?=
 =?us-ascii?Q?5p76589oBVlDisx5yi4lCWlwklNlCWYI55mnAOMNqDoMmG230US+LTkz0qm6?=
 =?us-ascii?Q?4LW8KhR01GXCZi1EevD65U8dHqnA0g6vlT2648rSk38cvBNdRqKeOLPyQKvE?=
 =?us-ascii?Q?m9GFOKcIozH19xmsjroW6rIHm013bB//da9UFh2jy44D5q/3TdJUWo3RKAfi?=
 =?us-ascii?Q?lV+gFX3XcO2OoULKZQxQoZqJVQdlU4K1l5U5nWEK5jAQT5WojWTcbaHrvp5v?=
 =?us-ascii?Q?2v64E+cKnMgF8FbLT25A2+W6Q6FVAVLvkutqH1b5pT/vva7ZxvWr67O3B06c?=
 =?us-ascii?Q?CDBu4WNVvMKBNzOMRtiB0O2D/+GoajIMW+tgb4fF1Div8O/1L7kgHe497NfX?=
 =?us-ascii?Q?UC5boCqjXIKZKQbeis/V+Cf3EY+o/4c3zqvojwpE00urQkB9leXhk1DJvGnW?=
 =?us-ascii?Q?8Rd3ZrwMVTL7bhgi?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1/cTaGnVUILfY48QBOO4eO8mEyy/YytYxq1CiIo4C4hnxFDFyxQo/y0PHPyM?=
 =?us-ascii?Q?Xki9XjN2zkOAOl60qBPTuJLmTx3GDWyf0EyWSAnnDsBKd1NCBP0xxqjmLGfO?=
 =?us-ascii?Q?lnXCUtVwO9YFMqGyu6dDh8cJFjx8mCHEDCD4PPx4IDcdIBjYkEjtLwd21w3F?=
 =?us-ascii?Q?RclYQjv9RlrqhDejZvgjF3OhKHB50J06sXqKcb2mlOigX+bafEDzqAnIgg+J?=
 =?us-ascii?Q?qTLKrPslWk0pEivziCiJA6SXjT954vyVezbn1iC69VscJoAYrdjUBG2pkoGU?=
 =?us-ascii?Q?LXkaxeXwDmOjAFtbcQHk+SWJ823h6Gy9FMVq9y2pU81vt5+idUNNvXCZXdvH?=
 =?us-ascii?Q?D9nr5Rvp1yvvLROv2qSwJ5K5wUlYVrgVHRXpc/AP2WIEW/QOnMm8jI4jWr30?=
 =?us-ascii?Q?zY/mntJinuXeYs2Ci57a1sNlusxUMH5pueK+epx1+rgYT632uEqNoEcw2FOs?=
 =?us-ascii?Q?6qXg23A8wRvWBVxa+USWkpjDzqHKp1VdNSqiivo3cF5m4va0Rmfor3mjO5V6?=
 =?us-ascii?Q?ArGheImyeb5UnPNrMl4IvpvCblgKN6d3yz0yiYljsqegSvLTzUuOmWGv1BjV?=
 =?us-ascii?Q?yWd8Hk8aS3WSfCkFnQo2tx99b3AINDdvQgEWTf+CSDA0+nlgynrBx/HQBzAn?=
 =?us-ascii?Q?6/tapMUyKYG0Jgo1rIiNtpalz7IncUdsfCWAIinJ0tCb/bxE02eNWYJFqafW?=
 =?us-ascii?Q?hIbGHCn7EKv6fOuR0eX+2T6rxjShWG6kXOq8xyedEtOx2HR/y8od+J60D3VQ?=
 =?us-ascii?Q?E+WltCnBU4let+ceGqZAopB/m0RmTQupINZfYSdUqbVHPORBeTCGk90PBhQa?=
 =?us-ascii?Q?5mCiGmAQkL/G7BKrs9HL1fJjb5PnnK3/c2Ff+huplI/rbfDrS1eyL8JgATRd?=
 =?us-ascii?Q?buhhCR9Ot3Dd5zdvemxl8B5Ryt5RURLIA5zEEDIVY0EuJQLuyNQlrsJEuLWK?=
 =?us-ascii?Q?uv5tKcrprPStG29BAxmXwIy9GvE286NuDRQc5Fv9VFIG9WsX8PG2QhHPrJlb?=
 =?us-ascii?Q?e6s92cGYPiFSeIkmX+3jPXbFwRk1gHOB8JLErCWL34Jd3lDoADQRVqVcqldN?=
 =?us-ascii?Q?Dwfgv5Fwzjoz+DGUqohsxh0lKjWM0Wa/74g3yRVeJZJj5hUEGkD+3DSKM5TJ?=
 =?us-ascii?Q?yJ3YEV/R9NKVHq/+IldRar+WDuX71Mi281BShgpWrELXC/BcToFf/2MT1hI4?=
 =?us-ascii?Q?h3UHgPQ9asIC/lWvux9qdpf7F1cUtB8yJuPIXv2rar2Qf0a7TE39qmUFcHE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7987803b-9092-46c2-3138-08ddbd04523f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 03:14:01.3257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8543

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Jul=
y 3, 2025 3:45 PM
>=20
> Fix the return values of these hypercall helpers so they return
> a negated errno either directly or via hv_result_to_errno().
>=20
> Update the callers to check for errno instead of using
> hv_status_success(), and remove redundant error printing.
>=20
> While at it, rearrange some variable declarations to adhere to style
> guidelines i.e. "reverse fir tree order".
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/x86/hyperv/irqdomain.c  | 32 ++++++++++++++------------------
>  drivers/iommu/hyperv-iommu.c | 33 ++++++++++++---------------------
>  2 files changed, 26 insertions(+), 39 deletions(-)

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

