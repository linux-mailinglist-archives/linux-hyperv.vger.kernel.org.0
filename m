Return-Path: <linux-hyperv+bounces-4975-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2068FA949FB
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Apr 2025 01:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A7E188E8B0
	for <lists+linux-hyperv@lfdr.de>; Sun, 20 Apr 2025 23:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721AF1D63DF;
	Sun, 20 Apr 2025 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DRcO5DHT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013079.outbound.protection.outlook.com [52.103.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F417A302;
	Sun, 20 Apr 2025 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745193430; cv=fail; b=RXwlaKKXyGxNRVFe+skWoAAyl8sdvdfCmSd2QnCiTZFQHNinSK0eOAYwkxDXRwo6sx2e26QtJqjO/MWej0f+MwqQdhaChLJAbiw529bTiYX7o2SsoBYYYuBc8PbjWOA3r47ZBiGy0sKkYhjuWTUryZ9H1WVOAbNu49LzVUhcZno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745193430; c=relaxed/simple;
	bh=CKS+VOIk/ZlM5uMLA6CyMZxPBL9xAP6n4e5QvUkTYtM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nT4WVdENi3RgoQoutOMufx19s4eBueEXV5u1xc16AKiad9iktBgCj21cQPYI/iKjPrgY77HMgF0Gi2Tgmm6+T0EZG2zo1wESjOhV92o5mQ27pCrF7rcCPoSAFV09X9njqA4q12p00FedYERua2wt1V4HyoKN/Apdkj4ZkdMa2o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DRcO5DHT; arc=fail smtp.client-ip=52.103.20.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fo+LGGsY2VNrGGoipnk/clVS+2VJrkEOVm+X/xK/OmzFJ6ZwWmuaJtoMUbuW7OgQlODPrklR8qw9rfw05rLBwToKx6JvgYiWQkJFR4bmLkxr1d4k86Cvhdxrq0Tnr8m6YCGGQag6MEeuJvA2Hl7s0nwEMs1hm7ehzNkxCvj7MtH26UyVsBHOxdpQ9X4U9W6s77843w4XJHX2m0P4hXgOaTQtFVyL4wSEebCmZA7jWQqpJBEzfZt+uC2YeELsie5Auw251O5+QmJrn8TnwuG/HQ26g9UcX//514F9wYSYcbMFlb6nFr776qubxp5mLQD4NGWPmPdEPzklgZM99HIP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/UpWQKv52CkI9JplA9f0yLhzH+ZqhoGFax5X4VMjXA=;
 b=LYYHiNMblVQmY5PttgAO/leg1tX21eUVXFjZhqYz39WCp0jOogc8F2x9zbiH76e0C5qDKtqLSauVgeIjXInWAl61pjnqiZon/LJHgKMXXJH1ekpDgDefN1tKUfAWdgBexVxwa3XR7RZA15Snran935l79bYT5Jhrn+uPxmj3rQ0BNjuS+QB51MxuieDuIKsVsuIhsy8zTvPTbqDIDJA8YNdSVfQKTLC25E8xUJH0Pjh3MX8Nsd0kbuoEVCIKp6goaFZDaWd8Q7o2afl9404cICSGxtrPWCHeFGzyEWFxnp3OXNHX9mm+cvctjNMSOYKp/cWPq6748fuwzjAw9+PE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/UpWQKv52CkI9JplA9f0yLhzH+ZqhoGFax5X4VMjXA=;
 b=DRcO5DHTZfQokJ5yZVGIM1O08VLv85BHp9GFaXge0nC7vmm4fc3+rqmszHD4pV1Dn6qQm/3XGsyZhHquc4vL/5f5DMcJphAbNwp8nWxqH7kBxBnoPu2vzrbsryFXgcRG/B6E1lsCB6mXqUQI6bC6yyCYDdXvyAYpSe6covRUuR9iRCU2auWVdWSZad8WLGIY6yXgpmKOfxDsIrAlqYY4KDv9vjbwwxCKuJLgGSkY8gjdnVl5teWmMgyGgmc6u1U4XmW5vv1XoQ7R75zNoBA4Rpnk4VXmN+x3s7gDSUR60oMCe2ZEnQHqN1di5/q3PqOlC+0Nic7+GyY8MiwmG0LLfg==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SA3PR02MB9326.namprd02.prod.outlook.com (2603:10b6:806:319::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Sun, 20 Apr
 2025 23:57:04 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8678.012; Sun, 20 Apr 2025
 23:57:04 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>
Subject: RE: [PATCH 0/2] Fix uio_hv_generic on 64k page systems
Thread-Topic: [PATCH 0/2] Fix uio_hv_generic on 64k page systems
Thread-Index: AQHbr/rrrZqQWTLl5U2aQW25I7v0d7OsnEAQ
Date: Sun, 20 Apr 2025 23:57:04 +0000
Message-ID:
 <BN7PR02MB4148A6C1A29019D9B016D1FCD4B92@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <1744936997-7844-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1744936997-7844-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SA3PR02MB9326:EE_
x-ms-office365-filtering-correlation-id: 656f1516-4cd8-4c96-b7ef-08dd80670cf2
x-ms-exchange-slblob-mailprops:
 9IecXKUgicA7+VuJlYgio7csxP7RAb93EtSoAWZCAq55iQwy7LaKbiAV+RABvY4kX6aALiS5/U7oKTvvC26d/dOnBWBc3mc6ufO/YLp33aoanAL8GS5V5w2Q702+btMkFXMsaToJShiIMavqyTMN09A3QJE05l9954sZ/poDMAw0piDztt4wzwaTR20OO/AwJ59FhyM4fK3E7QeaSpZqcYEEN1nPlaYxn8t9GdpSBVM9Qk1JK1FU182rDxHjC4rzPzj2FxpO5SaLwZYuSupTip+pmFSPeW8NJQGwCF2wI/rs4/aHS4+xGfZJbJYQtiU7U3FAUCM1qj3dG1LMIKEW36IkTQmApUPTGEoFnU10BEin7uLKStQrGcE5/EIV6IT2kV322KtudRV+K6xj0oTtL0y9t8LAeJrjAjaASt28HDv4z0t23BdL8YuKigtcR5cxFIEF/9OeqUOYQgPUg0ot9rPWPrV34TQCkJz1BDTN82gtcMSPHnPj0y6cd8sqe7AXeiBrw6EqGPEm1eev+Em9pdMTQAii6lnRyp+++Yj0IsUZAHucQAHSoFbOQOgF8Bbqt9cKsLOEz/ttYKqPaepHcE8Aam+n9dlt375LW3M4KaH3mQkhbqCjSGySQeqP+prb1WaUDS8t4XX1BA17xcgnB/ADUPx5RjqAEXVmKYN0blu25+VnhLmyTqNOtqNCq+zbJeFTUJAAsgO2symwKYF6nWPK6IPAomuYJEGAVAgNM6E8sEaE/GcR/g==
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|15080799006|8062599003|461199028|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2LpE7yC773aURlxxIwCuk1VwXi4SAvf7++hvKl+nmpJdbBog+rPooOmud7PF?=
 =?us-ascii?Q?CoAJfbMF04lkF3lmRpj/isVFygpQPbjseDMTIdqLvtRuwf9u2W+lQ9m5n5FA?=
 =?us-ascii?Q?4V6mzhOAEO5V4PEzQuDttW3doCiO5ULya9kH2zJoxJLHto/2V+rSbkFaSFfx?=
 =?us-ascii?Q?IObGeQXteaAp/C39TCecyhAsCaYWv1QoHX6R4dQlBO8vFoQubH4Cc/8ERDxK?=
 =?us-ascii?Q?HTRdBhWCl9Hzuen1DifQaeAN2aWhxAPWldPGqD5MFpscDUbmI9nfDWf5RRZw?=
 =?us-ascii?Q?TeYVmUOlFNoe4PvdlMloaKZJyQwhmFFXM0IpbNC0nKXxLyxhAicFCj+fqEc3?=
 =?us-ascii?Q?Iemh9sKON/JluvELjggCImHj44pJ7Fdnmpxyw4ABhSLUz/i3fwZmH77doDHd?=
 =?us-ascii?Q?XiP+98TFy+OjYoOMMt7a+ShWHAQrQMvKkRVyC1L5gfxrcYAP4BFeHclfE6vq?=
 =?us-ascii?Q?No7K6Yxvoy5Vq0t6Dh8U+urgSF1cl1vlKInEatrteuQbgL/BPd6EutvOl0RW?=
 =?us-ascii?Q?sNpZTuXX6rxmw8WOHSvrREUia61EQd5B0oWBO12YbTo+wrNgRQBFkzevgANc?=
 =?us-ascii?Q?M6Kosa8wBjKW7M0RFRdnufMnMdh5wNR7dT0dZgp7aPgb1aVejZwATjke1Uwu?=
 =?us-ascii?Q?LAakYz8IJQGbK89tlWExlXcn3HQmq2TLz5LprzO/lT5w/c3j5bJu3hnpbe6M?=
 =?us-ascii?Q?UkMEHbFdKTSM0QAaAapGiZoThLhRzZ6gGik+572iHCA8dxVHtG95AZtGmduC?=
 =?us-ascii?Q?TqVs+9gPniIEI4o7lcZqq++W3vQbCduBfO6H9ORwg5zVSy4GIkXnsyxcIxhu?=
 =?us-ascii?Q?KD8uyEDHeUnArwtdAhNXhxoYs/kelE/hILeKtOA/4bbBOnLT73OCvoSEeFZH?=
 =?us-ascii?Q?zqbDLcpT2+90ofZC906grp6OrGRX7le+J7iYSg+k7e81xx+jwbyrfVXge51C?=
 =?us-ascii?Q?zSb2HQ7I43HXHc1EcToad1REJ3kUw3H2TQl5svR98Yg+D6yjbInNvxQ+TBAb?=
 =?us-ascii?Q?hP4BqpsyHLKByj+p6rTK7+t3jpX9UWzAf3wfjtIxWK3Yi7hdv/s0zj0w8POu?=
 =?us-ascii?Q?399iIciQGvqQ0yMnpClaVF0HNfywpQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D04SiA3VR12+pP6GXi2uvkkKnFObDKJowygLMeUEGebZjbFAK4dg70vt/NKw?=
 =?us-ascii?Q?31MdhJykdGTg4AGc++uFxx0JMlCgvUOQKElAPRNVYg+StpTr89LadnBP4h5V?=
 =?us-ascii?Q?iJS1f05gi3kD61yMWOOJpjXZndJRpcrekzfgMe0+rS5hJ0muWRoWSjiLww1e?=
 =?us-ascii?Q?0INc9koNa/I7bpbw8x9ABXBq4li1JWla5yUjIhMBdY8aQ26qkP8bHR8eKHsM?=
 =?us-ascii?Q?6qTndWX9nLZG2srFhy++1QVQgMlB5ym3ep7yDSHeJdY2+7s7G52wwFoj6eKE?=
 =?us-ascii?Q?4hJuH2+O14IrDXxuLu7TQJUt/I4FZtuYkpzxS/jDabv7yE6y95nm/JI2cQZo?=
 =?us-ascii?Q?R+LzPRG1qsViD+HKsFoef4v0OSxGThapsTGuO8UuJTcPbgCwb0PFjOwAdAEh?=
 =?us-ascii?Q?DzK6aa9v4CnRV/Y0IjX67XS44MDBhn+6WJXQ6S2OPNArHPOjmbL7mxi1RO5B?=
 =?us-ascii?Q?wrvFI2vQRr9dE8I8tg4YesED/t/cSm+XtJEQAg9SxRoGuiSkgVfQzO78Size?=
 =?us-ascii?Q?as5HIgRfOuT7OK1JOLJ1DtgYGd3ys75rb8sPsqMRWsKc9k+z7zxPDSdUrCRO?=
 =?us-ascii?Q?VV90NsPyd1ayVf2y1Q7epeeQIaKOPctaZQofFccrPjN5t7Gn6T4xwGdSXme9?=
 =?us-ascii?Q?K3Pjnue4rzQQ7sstCqy75oNdOijj4aF4Kwvkc3GoI20ah5b40eDhyfrAIPW+?=
 =?us-ascii?Q?6A01HwotiFo7Tr8XN4UbyZPNJ+Rn0pSoqh8KGkkWk57q2HccXh7SSYTUPqWe?=
 =?us-ascii?Q?6EZtLQj5aLCdoWcsYpTEWLH+wFyBWbL+XhULYctBBqGuG4ALOhdeeZPi2vnX?=
 =?us-ascii?Q?ZCq5VcjLOp4q+9A7ld+Yuolc0POKRpm8rVthgmeslGLwXnb3WDh7OWXUa0Gi?=
 =?us-ascii?Q?tsDfH3nRhASVM19d99DRXZ02/9ZNxBfWMmkpT/F9sszzmEAojBN2TdkEHuFH?=
 =?us-ascii?Q?75+Wld6Nnlp11LH1A7ALCRTn2Gp2MuaUC6NDSjDwv5Zde4CMjtHGvhXl9DFL?=
 =?us-ascii?Q?iZhmu5fAK6dkzNh6oqQuMOmmrOge44ZqqDMfKZogiXRDPOe3jdLIVTvERzF2?=
 =?us-ascii?Q?Y9jctWLlY6Tofbyzg+IYeVFjnpJ0yjpjuxAJsNOZW9VRjhyF9UQr0dK5FyB+?=
 =?us-ascii?Q?B7+068OrYOGT+ojGA+mHJLN4VvXhQVePa0bQPVQmvxecI0WLm7SHPYmNdPAh?=
 =?us-ascii?Q?2QtTI+waIqA3SqnWtedeVQpExSkA3Ql+xZ7jAx5vGJxcfv6IL1VuZmXqmGI?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 656f1516-4cd8-4c96-b7ef-08dd80670cf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2025 23:57:04.3062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9326

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
>=20

The Subject line of this cover letter is a bit too narrow in scope. The sco=
pe
should be any page size larger than 4K. For example, the arm64 architecture
permits a page size of 16K, and Linux kernels built that way work just fine
on Hyper-V arm64 hosts. Perhaps:

    Fix uio_hv_generic for guests with page size > 4 KiB

> UIO framework requires the device memory aligned to page boundary.
> Hyper-V may allocate some memory that is Hyper-V page aligned (4k)
> but not system page aligned.
>=20
> Fix this by having Hyper-V always allocate those pages on system page
> boundary and expose them to user-mode.

Also within the scope of making uio_hv_generic work with page size > 4KiB,
there's an issue with the ring size. When hv_dev_ring_size() returns 0,
hv_uio_probe() uses 2 MiB as the ring size. That works OK with the larger
page sizes. But when hv_dev_ring_size() returns a specific value, it might
not work. The fcopy device returns 16 KiB, which will fail. hv_uio_probe()
needs to use the VMBUS_RING_SIZE() macro to increase the ring size if
necessary to handle the larger ring header that results if the page size
is > 4 KiB.  You might want to include such a patch in this series.

Separately, tools/hv/vmbus_bufring.c needs work to operate correctly on
arm64 and with page sizes > 4 KiB. But that's probably a different patch
series.

Michael

>=20
> Long Li (2):
>   Drivers: hv: Allocate interrupt and monitor pages aligned to system
>     page boundary
>   uio_hv_generic: Use correct size for interrupt and monitor pages
>=20
>  drivers/hv/hv_common.c       | 29 +++++++----------------------
>  drivers/uio/uio_hv_generic.c |  4 ++--
>  2 files changed, 9 insertions(+), 24 deletions(-)
>=20
> --
> 2.34.1
>=20

