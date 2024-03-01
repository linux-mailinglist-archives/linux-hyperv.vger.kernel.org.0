Return-Path: <linux-hyperv+bounces-1633-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2936A86E90B
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 20:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9458A1F28A6D
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 19:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A963D576;
	Fri,  1 Mar 2024 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="j/Ek4m9m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2050.outbound.protection.outlook.com [40.92.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF43B193;
	Fri,  1 Mar 2024 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319646; cv=fail; b=ZkMajBAS/cTEJhm4miHgR6yWD9e8KRaOyQCUAsRS88ZQ2tUUD82BLcMtFx7q9y5SNPFQT7nifFaRavqi9MwtGlVsw80myPONzbnq/CtizwqGq39MXqR8hSn4yOwxfEXVfaGM/PFcqb1yzG0FfGfA54ofZEx/asX6Nzhvy5DMeLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319646; c=relaxed/simple;
	bh=brfnRUAgHiXAwRf1n2PMXTW9FfCAXZLlUV7xMg4xD0s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kAH08Iy57PkJGe1kpNntqVE+08Hp5l8BWooHp7htlkldZ8l09RCxA5oznh56eXhv1A/PWVzTXmNHk/JWKMk+gHlJRJEOTMGIVtOJVejf8C1OvTCqvniBzC+Evm+QyrGLXUjEC31vw/z8e/BylscjMwhJor8k75QlooIDg3T8yQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=j/Ek4m9m; arc=fail smtp.client-ip=40.92.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJf8P00KHnKrXEQrjnQ62Isy58l1vhN1BzpoGSNmvDdCsQ8Jqz/wMu3t+hYJRC0uQjvb7vpQeM9DRp+87DifAcKDpdUjff92gIpR4/k/hR4P1cwsAmBrZ+8NnD36cbcl08/ZcorupenDUnAPvSqc9LGx1VTJM5wo7o4k9R8lSCFb3jxW2M2EqYEvP0GDirA6Cg2XDa3dyGxBSNECkE7S+9jMeqmK3LKtvMmFrazWw3BnszR5Lqb6qTjg8p0xu15GRjqgK2ieKgunFmhqrPmj9Yw0Wzc1AvtUJG0NK6mIWlmJUdHyiNlRz2eFA/SgtRxdMAskhgnKWkBnzFzKoJ8vmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94R4QCXmyMG5QpkgTYj5o6cY3DYBjErvDwUMi5BTCNE=;
 b=NNSQgeM4AI3jvRsIZ6Gr2zJzgEuQrnpZmtyAJXBR8agZmZ0tI9wybiaGE4fJQfLMc7VCln4hok5npvBKDUclEVBfFQAhPQ2G8SbJ5V5uNeRHYBIOLtSXsMsMleBiD2aTKkwIL3k5L4u9EVclRgGcGJB+bJgHgV1/vBoy9f4/lZT7JptFLALB83RqnV6AqdvIfx98Aj461SPHbdMHBJZ+/s38oTxWXsn3vo69PQjOSS6ab3AAsSqWdzsTUjg4gDRlpHOpDl/s7iTComDVr3pdjwVT61zuJjObtmZPJGhcS6ncE0SZYH1hCpvZCJD9hoX8/q6Dr79x6kD89vGF4SdaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94R4QCXmyMG5QpkgTYj5o6cY3DYBjErvDwUMi5BTCNE=;
 b=j/Ek4m9m7PPqKs5IFBKU61iXgdKerTkdkerSyB1iWa0/GSMwKSxEFWdtmoVWsJZrz6QVNpNR9SdDjIS7w2+EPoPPE7wFJmP2FpidLwqZQeV1g8CIKrvMnlUjCgyciFgmxS8REqTHmQTbPVxFsl3M2ENH1rI1qaHc88Lxf2PoMvKnpJBBN4z5hfEIRmu/ILv//u5bgqV0x4oDTiKpAI8/SoOvj477dHfwxGArqFoD8c6JWlS5B1k2McJZVHCbdSz7igKLTcVX7B4GzYElo5iKvWANCRyGkETnUg6UGjyGdMevoqBnPMNcy2hpofJdlR6QZ8e2m2bKC+4t0DMvFQRXBg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY5PR02MB8941.namprd02.prod.outlook.com (2603:10b6:930:3a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Fri, 1 Mar
 2024 19:00:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 19:00:38 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "elena.reshetova@intel.com"
	<elena.reshetova@intel.com>
Subject: RE: [RFC RFT PATCH 1/4] hv: Leak pages if set_memory_encrypted()
 fails
Thread-Topic: [RFC RFT PATCH 1/4] hv: Leak pages if set_memory_encrypted()
 fails
Thread-Index: AQHaZTRYDcNuyb66Gkm4wm9TLGb/jbEjO5pg
Date: Fri, 1 Mar 2024 19:00:38 +0000
Message-ID:
 <SN6PR02MB4157B2E6EC690B11AB334522D45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
 <20240222021006.2279329-2-rick.p.edgecombe@intel.com>
In-Reply-To: <20240222021006.2279329-2-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [7CZhr/JyRTqjS4FTIlyPVL5P6KYwgv2c]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY5PR02MB8941:EE_
x-ms-office365-filtering-correlation-id: b60ac30e-baa6-40cb-0ece-08dc3a21e22e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Y563gPXPIO9rhpg3Mtq4HkJgvWHZgVtKAHDGYwPj0v1P0ZKE+xytw9LqmLcxAdoryfsaV6gB75drvdH7JXkVqupFWqVuGWo/mbw5vbyyVXU17CCF6Dxv2+vMDvFwwnGqGfxXcu4MVaGkkVfR0GM6QQKITxmG1OfsOwrN2BMtB8d/ZKjxv+IjdqJ5NcLGhBCi1/PshT5A4S3qvsT9ON0ewetV4EPJw9F+XhAL65h/aOco5uSbJywKW5A3izXx9Kk8jeINHLv1m8O+UmosTHML3od0nkhyt8gYgYaQpin0AkyNhQtJJ7ve+nkxZit/0GXE/ACjoQHx996USZGHtI43YI3AdXgwRJ4wmnwhqadNVjIjzq0RgO7fFixwVaShtvubgU/XH+506o5l9+ZMobMUa6PQxeJnED65vfRMoo1xOP8mrENxqisTADp+7LRusLHLxox5UL6Go3stM6+v0HtNvo82GRup8oJlpgPlsi4ffsBuIAxegEsrsdnYvXs43CmWznQfmuAI9ZjfenYbtgP6jK+X45Y1Wh9kL9vmePrhlovhO9RRVfksnq4RhG8bpFb7
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?B8vFaNELlKMwP/JYczfrlaV/jjfIvdfpzZfsWFCQE+HmtgTQ/YBAdXid+yax?=
 =?us-ascii?Q?spf1HTa15/LW3i8+E5QnSAEK+FHah6U/kevqBn4wBXbuG8hyTgc7oKDF87hF?=
 =?us-ascii?Q?awsJicLMwRDqsmMvyzWSW2IOkTDvkHjXW6zmWVBy7oua2Ck2VX3XWiBRzBKA?=
 =?us-ascii?Q?MguSQTqvAWv1zIc7RziShNw3ATBb/zdYy/WzHiEa/nm4xrwX46LcEGZhWBDf?=
 =?us-ascii?Q?dmzLE433rny+QY9zgpQMG8ZcIJgf7oR0Uw2lA+a5LpJO4kybN2NDZJwYeuCO?=
 =?us-ascii?Q?P6x5LJEIaGXl7eSXN4IdfwGIOQJwZqrlZAA4q/gKfm1Ox+WCZ7RjSKb9a0XW?=
 =?us-ascii?Q?EZLOZBOzotk2AEEYukWSI3Oz8i/ER4DOLPgOKji+V1JppNkjrgo7ZIWn6lhl?=
 =?us-ascii?Q?qbrnY2wHScvi/yuOLRkqwu2/bAOS7rG8GyyZCKi7Rof9Z19fmCl3jfTeZ686?=
 =?us-ascii?Q?Xq6G6qW0tSZBwVT/TFr+FNm/hqTPqVtOAma3s/OayQ1/rxEX2rLpL6HrOYYQ?=
 =?us-ascii?Q?xNnCPHznN3/dH3vKGVaMoYvM6fseaaYKrfzLBhQwX25X8fh0Wo62q/mRPGdD?=
 =?us-ascii?Q?UmSCgHCtzPuD+8IZXeLu9SagGdBShzmebHGAtb6T5f+Cj3YgSpzPWugrOaPU?=
 =?us-ascii?Q?W0HCFicsb0lvYgKetrXiDfd0VxZpvLtOQMELGGXV/SZB2+BSbs3HLRXn1Vvn?=
 =?us-ascii?Q?PlP853Bzx4Pi63igVRK6YfrNILYJ2q6mlHi2dO4t2pU0eqeoMRRg1Mxq7fEw?=
 =?us-ascii?Q?KugWKi9DPKf9xtoOXEd2d6ubjU3CXYyiuQq/A00uJCnXBdBg0l+kNBv9NOTL?=
 =?us-ascii?Q?teQJFQgANqB/ltSxONZyVlaQdvfjmBCq7HD7be1pTgfyPEJWL+NNtgaQ/T36?=
 =?us-ascii?Q?kvoYDvBkjvTiGJAmLHhiKdF6XU869AncLEj2mJz8Lys8bvhw8Xv+iPmIKfRA?=
 =?us-ascii?Q?I2QKV6Zjp8Ik/bH6IEebmxNyRND7GqLMowIvZH1TLWXgKBYHJty/s2AhCAqg?=
 =?us-ascii?Q?MFrxpDuP34c4LCp7j/tPegkAKcyvXvyPiK8qipOxl/rYHooa15lD8wkE6NQE?=
 =?us-ascii?Q?hkFkMz9pTfNS1abzIiE7PZX3NLWeh2Id+jtDpvRRNbSbcYrLy68IMrY+AVAf?=
 =?us-ascii?Q?ozkJ/7YUvU6dWBBvBwYwdLHHlCI0rDxF1UJ33Z2vQqLMpB/Rh0RsP/LKOAQ7?=
 =?us-ascii?Q?un9KcFYDWxZ5SvMXSn1496jEcLfTh5KglmYwHw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b60ac30e-baa6-40cb-0ece-08dc3a21e22e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 19:00:38.2352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8941

From: Rick Edgecombe <rick.p.edgecombe@intel.com> Sent: Wednesday, February=
 21, 2024 6:10 PM
>=20

Historically, the preferred Subject prefix for changes to connection.c has
been "Drivers: hv: vmbus:", not just "hv:".  Sometimes that preference
isn't followed, but most of the time it is.

> On TDX it is possible for the untrusted host to cause

I'd argue that this is for CoCo VMs in general, not just TDX.  I don't know
all the failure modes for SEV-SNP, but the code paths you are changing
are run in both TDX and SEV-SNP CoCo VMs.

> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to tak=
e
> care to handle these errors to avoid returning decrypted (shared) memory =
to
> the page allocator, which could lead to functional or security issues.
>=20
> Hyperv could free decrypted/shared pages if set_memory_encrypted() fails.

It's not Hyper-V doing the freeing.  Maybe say "VMBus code could
free ...."

> Leak the pages if this happens.
>=20
> Only compile tested.
>=20
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  drivers/hv/connection.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 3cabeeabb1ca..e39493421bbb 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -315,6 +315,7 @@ int vmbus_connect(void)
>=20
>  void vmbus_disconnect(void)
>  {
> +	int ret;
>  	/*
>  	 * First send the unload request to the host.
>  	 */
> @@ -337,11 +338,13 @@ void vmbus_disconnect(void)
>  		vmbus_connection.int_page =3D NULL;
>  	}
>=20
> -	set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[0], =
1);
> -	set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[1], =
1);
> +	ret =3D set_memory_encrypted((unsigned long)vmbus_connection.monitor_pa=
ges[0], 1);
> +	ret |=3D set_memory_encrypted((unsigned long)vmbus_connection.monitor_p=
ages[1], 1);
>=20
> -	hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
> -	hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
> +	if (!ret) {
> +		hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
> +		hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
> +	}

Of course, this will leak the memory for both pages if only one of the
set_memory_encrypted() calls fails, but I'm OK with that.  It doesn't
seem worth the additional complexity to treat each page separately.

>  	vmbus_connection.monitor_pages[0] =3D NULL;
>  	vmbus_connection.monitor_pages[1] =3D NULL;
>  }
> --
> 2.34.1


