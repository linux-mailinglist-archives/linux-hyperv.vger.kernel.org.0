Return-Path: <linux-hyperv+bounces-5509-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 825F4AB71F6
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 18:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F70517C08C
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A879B27E7D1;
	Wed, 14 May 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="peLh8lAx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2083.outbound.protection.outlook.com [40.92.42.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470B27CCE0;
	Wed, 14 May 2025 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241662; cv=fail; b=JIo3h1r1OFj3hLXqKxxdvhEo1suD4XKP4tmJTaQfg5q82GNKI9C5sS7Ceb4s9gw1jGNdYCy+MMuYm6EuGdnHffPp+qB3XVjCxGTZRGhh6ppw2M5tZjaOyxPExQT531NGu6ndrYKcrCWcThxAt9adTVNOZmZUo7Xg5QTpzA73yvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241662; c=relaxed/simple;
	bh=Qh/b7Yzz+VTL9HQykPdPiCA7vckUQzOZmBgSLky6bmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xsv1cpimEpED2LyWojQN2wL4jhulEibnuQDjGq0pdRMJvou/JjaVBC43lvgqW+4d/bU6RNS3mFo+fh6TOZYNmIr2ZuTRU2FHX8HywTE1oR9zuy0KXkD8oSKSqB9hKrf4g9b/1Kvh7U6nwFYhmeNBQ8VUzIxxqMflii2W+xrc+Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=peLh8lAx; arc=fail smtp.client-ip=40.92.42.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qn5jkOYwu2YGnOIwP14po4PTLFIPhAnxRP40I/5Nxu6ErxjWFKmHwyrZo6636oiFSVvTUv4GX4BlqyEyTrdKtTVredp/Sev8+4Do1bvxjUgJgQm5JwNSZKc+LoD0ssIdRvmXsIlJLue2pv1i5BBgCJ4Pn1nCa95qkUzoF6YExDjnT/7QO6DN7LG4IMJRkIAtBurw0fQUPx7eHUp+bMi5MEy0nI7ElgWsn5pm2Vqdghuie83Rh3IkQE0ETlQM2QvuIYawrRIbpChItHDMMHyfAH78kHsAWbAMTt3cDc9XwB/14q3DZ6l1MX90R/fwHewmXCNLFUb1baTGGAM9A6N1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UljDA5NOmJ4L7VGAGcVtB7/PF1pQz9o6dQiXxOkpLew=;
 b=Cnze/tq0uHqoff1BWmFM1oimtyKnxg+VF7TDiMY37KCZwz/fvOVSAvDuOjXxL6q95dKHcP0qQBsUxbAOio2+DooK21g+/IOAe2IkbAwyyVlQ+EjuTod1D52u0RvgY+V7aW9ik7A1DwJZ7ejkxdIVlXXMsV7b9bnsNgl1K+qYJ4jPb2PLO6E3lY4sjwfTypezy01+xV/bOe+8ZgSEXqubGvs3loIajJF9qCy2VkoPsGFQZXR4dUKcy+YrEnllxXuOPxOcUMlsQF7UQJfCGsF9XXor/FK+ZHzSbRzf2VTuMO8UtKgW+MGRcq6umDBG6vFwPB5JCbHyVERAIQK+fpD0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UljDA5NOmJ4L7VGAGcVtB7/PF1pQz9o6dQiXxOkpLew=;
 b=peLh8lAxKpk1Y1z6bRipWhPsERPeHId9RWu1lUveuT347XcNoUpe7rMwYbNqd0hAbRK/zB4X6GW2XtuYjbThpFTqJHFgi5ZYwuu26oQUAWWFz5I1iZFESNNwxUIiqpZ3JQl/aimflr+7HkSyFMrhbEOx12mkzldbd1CUcIx0v/duCWw5vMDaML2CGQ9I0YvidcHGJfnjj8Y/dnP++BQRYcXVT9RtYFXKZGvuZOOOiIIMOw1aq6bn8l8OeklLuQ836002nOChhZyq7cr9H/6poLVrx3Epq99l7+Q0Cgd7XVyhHqaojEw7bOUhG4dLdQC+c4aEHhh7ds6mvC93o0TKvg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9189.namprd02.prod.outlook.com (2603:10b6:8:10b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 16:54:16 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 16:54:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Neeraj.Upadhyay@amd.com"
	<Neeraj.Upadhyay@amd.com>, "kvijayab@amd.com" <kvijayab@amd.com>,
	"yuehaibing@huawei.com" <yuehaibing@huawei.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
	"tiala@microsoft.com" <tiala@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 0/6] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V
 platform
Thread-Topic: [RFC PATCH 0/6] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V
 platform
Thread-Index: AQHbvofT0eaEnMu9cUC3mt17zM6corPSU5Zg
Date: Wed, 14 May 2025 16:54:16 +0000
Message-ID:
 <SN6PR02MB4157DD818BB2269809AEBBC0D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250506130712.156583-1-ltykernel@gmail.com>
In-Reply-To: <20250506130712.156583-1-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9189:EE_
x-ms-office365-filtering-correlation-id: b75742b9-6ff7-4072-7f53-08dd9307f63e
x-ms-exchange-slblob-mailprops:
 5R4zPSLKzf7ugi86ZILSHEUPLgXlm+5T6Ac5ggjPm9wlItdDbRklzb5a5Mi8UJmwL5vd+nYVWYZxbaXfwihbJYi0pRjJpqMbaosRmV+FF5M5LiQn0gFWdfqHpwx/vE7nVSM4fRVaSMBO0Q8dhBKRfjGMrMexonQ4g+7dkBeDxZGUdh4HprsEI4c5mg6eEIVuci9subZutj1hifo1SvMd2GenlZH6XKe7rOKuz2oYdfqfQO3i05K55k9KILNOCTfYPvrEtSVH4dw0F06/qEHWwKkzZj+6V4ci0UMdv2dreuJg2cLR372UFLSv8LbVAa/78zBl8m8OFoM4wgGpmEm1yNHVPRqaSMWS7HsD6je/BYxb6QL7XqQjfCncK6DSH4L3MkwC3/PtgMqH6FqDWTSxtsZBm53w4aOR/kQWKnzAPtVRuhF57BWoSZ2Xu812uSNg1upg7RPTMSZxe/wl52w9PRGRZ5UiNIlu4Cn8dy2oLhWakylwK6U5810PzuUkvLj7DtkLn0h8G7vzGXwncBq3+MDgF7KgAen28ClxDwjGgUavSY1wGPv9uwSUa4czpL1xR2iQJyofcMYvlCg3HUyyD99mi4h7aDgZ1275oVNv9gNdCEjldtPE6PwHjCF5PMuNRazGGHkxcXsyERqn6TLN0OdvAfpsJ7jj7prqxBC0NMVN7BJcFcRzXPNxSbFz8tD/4H+WFLQ18KIbM5IkL8lSIvQSMmgw2256HHVoXXv5Bc86Nqctyy7RWimyxSJ2d43zM0s1xMMICEnXNv2A5C0HUZIoT6jkTTqpbH7CbX/+EOh2fzLR63M2Y9IEUyvOwlBkrxJTLVu7CSbyY6DsWC4TphW4J1WYMSmu
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799009|8060799009|19110799006|8062599006|1602099012|440099028|3412199025|4302099013|102099032|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OrJCx19DP0NzhT4GlFYs1Eg9xM0G0ptSz6O/KpUELkueYASsbQL3Gj66twui?=
 =?us-ascii?Q?M84bLLFQ5c46fMuX60/pgUKmQeSXZsQ2GBtheKcar6WDC0MxTU0nM0HnH6EG?=
 =?us-ascii?Q?QUWExMl+Tx+fCYWhRoesq2HEJptxva1bKaYpmGNX9+NsTFhj0upslQ2hKyja?=
 =?us-ascii?Q?pDhpEfGJU3nNNAaHiOQvp5u3KdTXei8T42ytxZZ+3BtqubHJb7pVWKAALfT7?=
 =?us-ascii?Q?AQf2nV3wmj+k5sO6CAj+mysRtXYKxiqsLxN/rR5sRc1gO/y9UmFm2NuXo+DN?=
 =?us-ascii?Q?aQVgTpD+bLUqlcOT5ED5HGyokS9Qw6FZMUWA0wNYN+h8VZPVt8E54l+1YJ6+?=
 =?us-ascii?Q?tYEmOF15+zqXVGzrawIbA1m4V4jUWhITKbKHKifNtWO0nzQsygyZlvbLnOBN?=
 =?us-ascii?Q?GBcnpFPFt82OAGG9SnmERZ46+muPQ6kMgUAT6yEIy3i+e7+SfctkoJy4/zgN?=
 =?us-ascii?Q?hKiVliUnFhW0Vr10vwi4xurhtPQBBy0LcLw+EIeGu73i3BRUVMa/X6h1P5pG?=
 =?us-ascii?Q?+QOZerBfuMjrFDdWoGS87/FvTWYsLs7vUhIM+49zcN9Qvjq6EEbuJOxp4bB4?=
 =?us-ascii?Q?C5mNmJRcNacdhUVk5R/3GMW7JGtAmVYbjXyCXHkXAbDCQiJoDh3b+m+7Wn1r?=
 =?us-ascii?Q?FWhU0i/+fBeSnhZwwP9/mDLawmASGRsnS60VqJHdj5wm7123mBPDOes68zGX?=
 =?us-ascii?Q?gHkKzI2I/+A8F+MnmjuGOczIPoojc3fYVuZoOfPnGvo0319XqhB+hIjVak/K?=
 =?us-ascii?Q?PX14PdkgMQ6SBDHnkNaI9rjgSw8+FbflaFB1ruMIkhTZM6Qu0MxFVZb57BwV?=
 =?us-ascii?Q?2z7NezRXjuq6FtCfoT6V/6CSfoptMJ/BZqs+R8UvBfD1Dy153HTpK9BHFEfo?=
 =?us-ascii?Q?TNl0prjjkUDLN8eNUDooNkYp8BMWDE8BxO/iVV8AXEwcIBVYh8iscUdxfaQy?=
 =?us-ascii?Q?h0qPs/EcTU1DICLx32xy0o2hA+4TZFYe4ItWR0LNjopBIVW1gIRXowIaDgfn?=
 =?us-ascii?Q?fzdiRyS09IOSr8AxwnfdqIChgJlyY+cgdR+3svAL0p7D1V5S1B8Y5fqFoOiy?=
 =?us-ascii?Q?ctNwsLGfykBVgkNsCS2ykbZmrfU6hqYCyUgj4SuF85Tbfwrm/J6RWDlaZSov?=
 =?us-ascii?Q?5l1yTndGZm4bku8BxcfitzoQHjLDYcQzxm0NuKqos52G16UZS0Kit0j4kno8?=
 =?us-ascii?Q?3xqn03EWmIor8Yoi?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dmTfaeK2q9uNiX0/P8qoRnlpDo/SlMlo3g+pGgujpvzUVWi1a8hioGTyRWSi?=
 =?us-ascii?Q?cjEtaQYYtG8HgbgBBryoG5q7ZRWdxWtGa7YpmTUWu2oQFsO+dsT2kI1pdyDd?=
 =?us-ascii?Q?tvZHPHb69HMjZHZ7WfQlfIpXrdEPhK3AxZh0hm8tdHuoSkkPPLEFK7rRZI6c?=
 =?us-ascii?Q?8u3N517Jkm/l1Kdzrftb2ZI3AFhWz1o4vIHe5uh2asYTdzbWzwUAPc/vvx+7?=
 =?us-ascii?Q?sECk05JRFrTdnmuoqEeXvJpGzAOKM3RwruyRbNp6PRvEw3iF0g1qvz1cJpNA?=
 =?us-ascii?Q?B0NBDbfB+dK3kiMnLBsWhyPFy3LnHy7e551/hQQnSZg+uu0nmMAf/AAdCfVt?=
 =?us-ascii?Q?Hsg60PCR44naxhTxYGIkFI2R6iAvUMQJa5W2PG2iQrB1gqKa9zjIE4YnDs8x?=
 =?us-ascii?Q?A37DaWGosW+frjMjDv9iB2QsXtRF1XLG7K5nxxFhuAD7OjE6ok3Dq8wrkIu6?=
 =?us-ascii?Q?OmhTMOU7eV5pKkvE+ACVE8HXQJ3T0jK8BoRMUgVscfoc6NTlXAXFR/jGjGEk?=
 =?us-ascii?Q?uGUth00Re9rDCW6Gd7O44nFl4NrIxceV/y0UvfmQLIygfBXVkaXjZJCW6peh?=
 =?us-ascii?Q?GIIi3oHAiGuy/2Qoxe6ltcGw+XlTIBi0mVDXyLJpkvOvspY51WG24Xz+zeTv?=
 =?us-ascii?Q?92Vbdo7um7xH6dp1xbDycnR5DTQfFQYEqd8g+C8l2namaW6Ucx3YnKaHktqG?=
 =?us-ascii?Q?/mrEq6O+rpKmVyAxNmbTILPmbS8iUmTLk0SDDyBxaE8hGJTgoiv6/mcFVJBV?=
 =?us-ascii?Q?TffW9t4Te7/Kckh6FkMZEbyCGA3QFY6C9Q7w4WTGDlKKdLudqj1EkyZmB7pJ?=
 =?us-ascii?Q?TC99IiZDk9OnFQqs9kDNet37pXev7/z9bZTIuyliLckoa2OnyO3/fkSwdZf6?=
 =?us-ascii?Q?XadpCBCDPLuYr3O1OUY8WsqMsnYlvE5NW6vLvyQ7GKP+rRpHmmRpMRxfUPck?=
 =?us-ascii?Q?3OWIvhBQYoKKNisntQMAmutYIsrYNoSdNRi9ygJ02mA8RfUjPNbR7zg62dio?=
 =?us-ascii?Q?8KxmhhC4rviaL2k5kxCFHL0CzRb+oAbJSZRUztZsIas8kdDeCx4t8GPBqpM5?=
 =?us-ascii?Q?F+t+ZoNF/U/a1KDCe/ClbcI3+snAk9D6tl93fWSGkElk/DR+ZwzzJVkO/Khn?=
 =?us-ascii?Q?LgN2uD5CRBbVmR2GItATrKCgWUVpe9OI53fb1Ejg88ESW7UumVhS61Ix0Z49?=
 =?us-ascii?Q?2AdI16QzzTfmjcFCsfF7JxAB3wEOQRVtqrX2ZUFO+NOkh05A4xTv8Xx8ayE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b75742b9-6ff7-4072-7f53-08dd9307f63e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 16:54:16.1608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9189

From: Tianyu Lan <ltykernel@gmail.com> Sent: Tuesday, May 6, 2025 6:07 AM
>=20

For consistency with other patches, use "x86/hyperv" as the Subject prefix.
I'd suggest being slightly more precise and saying "Hyper-V guests" instead
of "Hyper-V platform". So,

x86/hyperv: Add AMD Secure AVIC support for Hyper-V guests

> Secure AVIC is a new hardware feature in the AMD64
> architecture to allow SEV-SNP guests to prevent the
> hypervisor from generating unexpected interrupts to
> a vCPU or otherwise violate architectural assumptions
> around APIC behavior.
>=20
> Each vCPU has a guest-allocated APIC backing page of
> size 4K, which maintains APIC state for that vCPU.
> APIC backing page's ALLOWED_IRR field indicates the

s/APIC backing/The APIC backing/

> interrupt vectors which the guest allows the hypervisor
> to send.
>=20
> This patchset is to enable the feature for Hyper-V
> platform. Patch "Expose x2apic_savic_update_vector()"

s/platform/guests/

> is to expose new fucntion and device driver and arch

"is to expose the new function. Device driver and arch"

> code may update AVIC backing page ALLOWED_IRR field to

s/update AVIC/update the AVIC/

> allow Hyper-V inject associated vector.

s/Hyper-V inject associated/Hyper-V to inject the associated/

>=20
> This patchset is based on the AMD patchset "AMD: Add
> Secure AVIC Guest Support"
> https://lkml.org/lkml/2025/4/17/585
>=20
> Tianyu Lan (6):
>   x86/Hyper-V: Not use hv apic driver when Secure AVIC is available
>   x86/x2apic-savic: Expose x2apic_savic_update_vector()
>   drivers/hv: Allow vmbus message synic interrupt injected from Hyper-V
>   x86/Hyper-V: Allow Hyper-V to inject Hyper-V vectors
>   x86/Hyper-V: Not use auto-eoi when Secure AVIC is available
>   x86/x2apic-savic: Not set APIC backing page if Secure AVIC is not
>     enabled.
>=20
>  arch/x86/hyperv/hv_apic.c           |  3 +++
>  arch/x86/hyperv/hv_init.c           | 12 ++++++++++++
>  arch/x86/include/asm/apic.h         |  9 +++++++++
>  arch/x86/kernel/apic/x2apic_savic.c | 13 ++++++++++++-
>  arch/x86/kernel/cpu/mshyperv.c      |  3 +++
>  drivers/hv/hv.c                     |  2 ++
>  6 files changed, 41 insertions(+), 1 deletion(-)
>=20
> --
> 2.25.1
>=20


