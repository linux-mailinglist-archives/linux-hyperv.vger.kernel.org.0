Return-Path: <linux-hyperv+bounces-7255-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D1EBEB61D
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 21:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AF01AA81FD
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 19:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35B82E8B81;
	Fri, 17 Oct 2025 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BK4hmuKg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010027.outbound.protection.outlook.com [52.103.23.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D6624DCE5;
	Fri, 17 Oct 2025 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760729147; cv=fail; b=nzTvAi1CTeSi9UTljHTXJ4BmSgsvlANcRq2mft3c1DouFBXmIKiDCGMAteYEZ2j9U73j39Jv6qzZ5HS17VnspUYCtu3x95bSqwC21UyXWGfVznJQxC5fBPH4ucPcjOtbUIzFgcMF0r6/XZmAMdVsGE7mC2NQIbaiZGzQ1khrop8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760729147; c=relaxed/simple;
	bh=j222y4dgp/MtR6Q+EaQGvENKCUEylpWYdg0Xjn3QBBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KPzespL6s+TdEwbCn1PR05NqAunTTbY1eR05zHxiKWMzzH/3N0nv00fWiUZfz83XXmzvPxf1vUGGeGc2hBOpfmajMY28LAUK5E7kDjRHsfqld441hCDaG0KzynybHoLYM14oYYe0hsqoK61E6pieZBuitXELXP10Uv36NI2Jgrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BK4hmuKg; arc=fail smtp.client-ip=52.103.23.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMBQJVy57p6H1GE6EhXTLmDrquRLk+8r1EoT/Y/yYyxz3rMghkIK0Gu0Wjpb9/znwllw4cLpMLvLO5xKcUAosJx9htZDqXya2VlkpmJnNIEnUrELRansj9tDzuoTRJvBNGzjcH3DR/8sP209OXY2Dxmi5xDbq6d2TKmIaTyFe9O3G3c7GpXtKbqRf3kepGRZurEYhkIeQE6qRab67BsQm48ZRdj/4qsiAWuUCJq1Ar345CghjhyorlbsMksgAgj+VObLV3K70kx4TwreoyQhko/IW31+R7b2Cuy+wkQ/C+1nYgfq9Fppx8fMdQD2wy1fAmQUAcexpk6e6HBSxHDqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XguS66W0Kh94u4fje6fc6tLdghvZec3cYBdvg0dPBfQ=;
 b=ii05dajCiV2n3/C2oc8zeL6YaSCkuyKhRrDgLOehEn8Ek9n2KyGsnXcRJ8wYCuaOVfNunv4G9/e+eSVEPaiWPp2WbWjvB9X17kSpJgdFz9pkbHR6fF8JpWsA/moFH2ihcHrEsWauActj0vrCThKVMkks0Kx+rRo2wchWZK2/FebWkI4p1ZEWVv9RWtCAJrGzcC8O02FC5DMm3DjRPXTAyq6S+zmT2tCx9sLpyWQv42oQqrnpDfW69plfg3jKzE3Uf4pLA0xrxUaBdLw+xiHpyG5kR1wsiATTvzP54Fup2xRZxA6QC+q+XkEP2yUBtNvbfE1714abH4vKNB4RYyg6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XguS66W0Kh94u4fje6fc6tLdghvZec3cYBdvg0dPBfQ=;
 b=BK4hmuKglS4t5VSAiwpunMyyRxwgeYRAEPyEwR3WrcLEoQ3kAUOkl9DGPtpxGJx6FGcL6FEAdDdJ+6JUokbCoGNFXIwfAB8djWx+HUAsVGWYvfj04JmJHL5CgMprWRyAe8H/7Uf0iWR8Zp7kVM9b0xp4eQV/PXbUxAx9fclQQYTMK8tVUogqGqA21nw3Q7bHdZFkRMPgLIwQ2Gn16MCknw4FaFLO2Euod2gsnGfXqgwcv9HemIxASebTePfXZRR73ybIoH6T+R2kXh4wWBBHUhoqSaJv0uzzs1fgveS5RbtZkfFOxYFIMHiyxlgiXJhnK8P2LBUrIuG7GD8w41UL8g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7358.namprd02.prod.outlook.com (2603:10b6:a03:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 19:25:43 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 19:25:43 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
Subject: RE: [PATCH v2] mshv: Fix deposit memory in MSHV_ROOT_HVCALL
Thread-Topic: [PATCH v2] mshv: Fix deposit memory in MSHV_ROOT_HVCALL
Thread-Index: AQHcP5gCuKni/3xxG0GYp2bxQKrT8LTGuDBg
Date: Fri, 17 Oct 2025 19:25:43 +0000
Message-ID:
 <SN6PR02MB4157F795F3AA71F437347709D4F6A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1760727497-21158-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1760727497-21158-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7358:EE_
x-ms-office365-filtering-correlation-id: 4ad1404d-e94e-484f-53d6-08de0db2f731
x-ms-exchange-slblob-mailprops:
 ScCmN3RHayF0bP0FcI6aESyZnZAIXMvqVKDVSUfWzVLNB+CWxVKbPFzrzMFd9KH3t4vOqFcS467uBn6B9CpabMzZalfO06vNwpfCqWtWdjnWSgMU7we3Tmpw0gZW1rBN9EYkH/eJBIKegIq6+y5GE6OK7yMpUxrr2hxX9kAJar0VwsI6/GRsqKZVsLv1WmW6fxJBwsRA/lSW02WfXjdsI+EQGOViV1mkTZZW8jgC7kwmb/mSxqEy3P78kKZcA3bSCvI7vSIKc8GGMRGliCd1msXVLGL4/CbwhzHTy3Q/VqFA+H7NG4I9OLh8vtxpRE8BCEuj4qfh+t0TFSM1Bey6ySNV5vJt55uXdW+T+KBCz31L9ORNi+Qd3MhVBr4mZETN29H+q8UqOqMzuK2cO/F3pTIp06iVV+AqoVfi+ciCBZ4YZrnrvLJQdV+6uT4Cb6bxpoG0l+h/CcJuK5DW5K2pzheaFCopo6xxmVD7ywsxh8HkROkXMydnoujVcyHZzLy6MojZk8LaiFxEBoEBwqsaMBHaUimRMfFX566gLvZyLy3A7kE8ZW7WdPUQpSkazZqUKVBJS2CDuEFmtt0iTfcB8+DkgwVqez8fHweR3BAUYu82S/L+GBzmjjpCwOLJIkohoTeOytd8tZoY7xhUa/xxH6aZlNsifS8TvxJgqf65bPFEQDcY1181ZvQlGn3LXpyE6bjrqtHwvkaZjv6tn4OGvHpwVg7iYTT4qvyReo15rno=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799012|13091999003|8060799015|8062599012|12121999013|15080799012|31061999003|11091999009|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3/Yym4q8LGrEZ2JKrsznVYGsh+T9VK2gEX2mIiHRxSuaSjV+RMSsDq2bH0A5?=
 =?us-ascii?Q?V2g1w4fhVD57I0Xa0//ZkKAa5fIqbgc7XV/H6+IxeUYG8ymAihVAIY9dfC8K?=
 =?us-ascii?Q?rFXCmWNvpjidSjV5giKTXHchmBv5sdR0/TD33mIkgmRZTHCw6TdNYRlcXpe0?=
 =?us-ascii?Q?GxtRScnJ+zyyYBxXiorWxHNOWENmMGqWVSV4+F60veTKz2bM60oR/oKHJb//?=
 =?us-ascii?Q?G4BpOOzZPEIOpvDMXJA8n4FiV08u6euYUyzO715nQiY1Oyscf31Se2VNWWns?=
 =?us-ascii?Q?LD3fboBAJqi9qyQxkp2Tx80HaFyif+zw+34HkzBUECaxiHvVD/YaeUm3mu1j?=
 =?us-ascii?Q?mtQe3hyjXeO82bDlcw1x4bHedmPqIbkP7emLGiEImeH3Dn5dvBKJwj9fb+ib?=
 =?us-ascii?Q?OnT9nxz0k7rTR8cZyhvhHsVezOibhohAttymrbmMrL4mjx0aztdOHs8sKGTY?=
 =?us-ascii?Q?hzjDnyn7Zyea3zYTSSp5CXd8FYxRtm2KHd3q03MBRjKTX296pPQDVNMiNdr/?=
 =?us-ascii?Q?mWKcqlDsqqu2JkF292YfVVRDm/fhH6XKuqA46jkIVDN3TZ/aGhGabGW+GheO?=
 =?us-ascii?Q?DV8RAlcp+xJQ4RM+hU+Dl/z1qkqTUuDxGsw57VsRe7qnGJtnQ6VSiEhsGpqx?=
 =?us-ascii?Q?p/XT2sKjAT5MtY2T0Hloql1MIa/3lMPKhGgG44cg6WqQwh1dabyCA7rUHAx9?=
 =?us-ascii?Q?bQen5QgiB6E4/CWzQERk4WbAJ3zdj4bPeca32WFDvfpwQ/Ca0Tk5kyf3mczi?=
 =?us-ascii?Q?gvg559/QpmSQPwrTcfiWb77Klf5/fJuZvyASq1L47dcG5VdMz0Mh3dUDBnQE?=
 =?us-ascii?Q?rOCOMZDPfZTvfbYT/X2Ae5EdDr+lldDm/khcJRyRSXp/AtaRLDfQoahqW2OZ?=
 =?us-ascii?Q?gaVoispJpej9tThwuyvaYcL2FPljHYrrtq+Lo3cC8Dfq6YsAvTDmsXMt5c0W?=
 =?us-ascii?Q?R97DpOpvk2NMzk7AG6PAzqvbxEr3ECaa0+sEljJ+1JcJWrnRwzL7Mm2swswh?=
 =?us-ascii?Q?odBwFxrwtQyZepfsFrfer74qzyIXYSczDZbnOeKP6YT05Crmx4cV2vlSTGeV?=
 =?us-ascii?Q?uJInhO/1OVSnGzmhMiBQw0u/BIpEUePPL3vnZgZwbX2J/ibmZQaf6lb7Dp/4?=
 =?us-ascii?Q?pR7Nbmxk0PT+7L/j5weFxSKhCGKgcKQo7ZOLsdi54xSr8OxwR5CVdQIOt84p?=
 =?us-ascii?Q?7e6OcxeHemN6pO17MsMTQg+3POscTzBvOKpbx2xm1OaXH8gp2zMLd097wxbk?=
 =?us-ascii?Q?NoFKlfQXlMirMZr9zD2j?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?U79FnnlHm6DgKAeQc8qdpKWurKg9FtAGFLMLTypUx8DA3juSKEUtP7ocZqwt?=
 =?us-ascii?Q?UbwYECjspbpH9SErPRH7SfSCwJOCTX3VUh+bjVgK8unVk8KAWzzsZvWO9N6W?=
 =?us-ascii?Q?vz6M02RQvRdOl6kRj8CnncPwX4n6dx8AfTWd2WkMBRypoALBmq1sJooB6d/Z?=
 =?us-ascii?Q?9zdcBQ58rBoWeIdfWmw2UocIZFcvqHRMbXOEqQIuWH/CkHqDQb4Lj4MkNnr9?=
 =?us-ascii?Q?B1BfuSmZ+UgieGJzggULCONKEmbKQuEaWe8q9e+GjSdeUZ1FbnwdrYNU227d?=
 =?us-ascii?Q?lqrY7s8DFiZM1DNWivdO5q7DWL0fSYDZ16mE/3Hjvq61xmZMOvzsnGMWYPQE?=
 =?us-ascii?Q?g5dGUgQY4pczhwtIVYi0LFwKn7/zkaRYZ+N1WSfwSlY4wqlbgPlPGF0ciLDY?=
 =?us-ascii?Q?RuOk0uKMPioGgPZUSWs8cLiJMKk7YZrK2IcUHKCPkFCh62z/7cLHGT9ew2Yh?=
 =?us-ascii?Q?E0o+GfB8LrR1VVpHKUlXAj3BEDVT7uK3ZrgtTf46gU+a5uGKol90yrSnKcwu?=
 =?us-ascii?Q?ASj7eMVaAovqxjBkTzFEoKTi+NAsyE9eyJmuajAePMPhqeZmBIVf4hrN0xZu?=
 =?us-ascii?Q?aa1vcs+EY0O+zQJr8eRt/pnBtjK5h6nfjSv71LafZ38aztdGd8AwdtwPWJvk?=
 =?us-ascii?Q?rzY0x+qFf4FYdpJUdbvWAQWS5JVWuwZZkp52erw/lPMoxboyvwOuJBBT8JvH?=
 =?us-ascii?Q?DUOlwTVzvq+VwsmHFD8qYI1WNNxsOBlH0bY76173tLbV4nDNBwix/zyOPgd2?=
 =?us-ascii?Q?c4mfHBjYsPXMh/mTfyqh9P/4esrieOg9ttJmJFco/iNt8AjoLFeI5+cag9Av?=
 =?us-ascii?Q?6r0+2jdfMHqfH4PO/YiSQM/vzJGVKBPQ/NmzMBRXm0VEfwDXmPy9eE/HG7HB?=
 =?us-ascii?Q?nm8mtnT6ahYG63qUmXC+O9VFuVdgJW4tJARe5Gxt905kTi6wwgmDNDodjPuz?=
 =?us-ascii?Q?ivZ6ohN1DZ+ACTXT3gFx1cPZn2c+sFPyLnL+VBoq1piseI0s6wkRh7gKSoRn?=
 =?us-ascii?Q?2/WRs32k0bySmKtTzG+lRT5qnMvE751lHKSd6RCBAU9TwL79MikTffFaLQPJ?=
 =?us-ascii?Q?4AtHhsimk9hyvVcQBTNW4ckT7EP3ECp2NyfXTdfGiakN2s9jczTp7bGRrlAt?=
 =?us-ascii?Q?aNfG5yoS33rMBfu6dU7f+MgdOej+VEx3yNOx8DvSFQio5vdac9rVGkN+p4ue?=
 =?us-ascii?Q?TwehCD1rb3agx9lxJSveFRQrEpuWPF+mFQB4qwvtO33GJmpco0xF/KGqzLM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad1404d-e94e-484f-53d6-08de0db2f731
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 19:25:43.5299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7358

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Octob=
er 17, 2025 11:58 AM
>=20
> When the MSHV_ROOT_HVCALL ioctl is executing a hypercall, and gets
> HV_STATUS_INSUFFICIENT_MEMORY, it deposits memory and then returns
> -EAGAIN to userspace. The expectation is that the VMM will retry.
>=20
> However, some VMM code in the wild doesn't do this and simply fails.
> Rather than force the VMM to retry, change the ioctl to deposit
> memory on demand and immediately retry the hypercall as is done with
> all the other hypercall helper functions.
>=20
> In addition to making the ioctl easier to use, removing the need for
> multiple syscalls improves performance.
>=20
> There is a complication: unlike the other hypercall helper functions,
> in MSHV_ROOT_HVCALL the input is opaque to the kernel. This is
> problematic for rep hypercalls, because the next part of the input
> list can't be copied on each loop after depositing pages (this was
> the original reason for returning -EAGAIN in this case).
>=20
> Introduce hv_do_rep_hypercall_ex(), which adds a 'rep_start'
> parameter. This solves the issue, allowing the deposit loop in
> MSHV_ROOT_HVCALL to restart a rep hypercall after depositing pages
> partway through.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>=20
> Changes in v2:
> - Improve commit message [Michael]
> - Fix up some incorrect/incomplete comments [Michael]
>=20
> ---
>  drivers/hv/mshv_root_main.c    | 58 ++++++++++++++++++----------------
>  include/asm-generic/mshyperv.h | 17 ++++++++--
>  2 files changed, 44 insertions(+), 31 deletions(-)
>=20

