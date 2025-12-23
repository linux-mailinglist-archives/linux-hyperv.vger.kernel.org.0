Return-Path: <linux-hyperv+bounces-8064-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C220FCDA54E
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Dec 2025 20:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB093301876D
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Dec 2025 19:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F6D34888A;
	Tue, 23 Dec 2025 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GtzqtJ3T"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013085.outbound.protection.outlook.com [52.103.14.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CB83081CA;
	Tue, 23 Dec 2025 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766517448; cv=fail; b=Jeq4a1xw3zIUWTHzjhIyUaJqMqhUfcaxgMZlF4bII0dVg8rAgUjlE3qDmcW8SluGF2B1bG8Cd6OloaYnRKKI2wMdRn8Sn6WwZQUZILuhSCXuDM9MH+HoH2IVQE0g07ZnMsBF88+csPgIxLoML8yFSUVT7M1NRWRufUkxTDXsn3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766517448; c=relaxed/simple;
	bh=VDEnm5/wUZUbJFpDo1EXaAnYC+WIehrrRPzoNECKc3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BC4izt2JTvkssk8nyMseDZEaLDYIy/Fwjptser7pBKZ4Qj5YJpUfU3eYsqvWPKBU7K4AcPkEObRyHLl74bsmzMtyxuiHOBEKhm7PX/K2vZ86VfRs0dmELuwmHfDiUhkEgyOJbFWOtfcu4Oyei5jFbhV3v826qLbBESvx9K/YjGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GtzqtJ3T; arc=fail smtp.client-ip=52.103.14.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwAwNQ1JAYZ0sCGZ1nvO6re7O8f43LkN5Zlo9Kb0+D5te5uJoL21A3r6M/XCf6sC9IZzIGqPodmyh5cfpZKWruLU1Hvyzoy1pyffkOqlY4EDEF5p8bCzJpAlwZG/6Qcbaj99yTr2zqZO0CBZQlBOMZTCl5IYy60f0DysZ+kz13NjnCraa36UMYfhEil9dhU9kT1/fhQv1etcWq3lCci2T41nIEP6vV4ND+FOZvXdupayk3FL3V99Ov7oUdKn9Jv+c4Dd120uzvbro0Qp4f5Q6cLQ1o0tytvIZURyrnC0qEJJkJYoOVRksQUNUlgh5PhCY+mM8gj8aksuR9N1ZDavvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GudDURiXohcoNVKHFTEMvhRyUZrR2L+0V4PWabTrRC8=;
 b=igKmsq1bHZrelMZPiI/sIwCt/Qb51zgjh3QrthBs5LlQRpACNummGT+BXownluLBYRcTNj9+wf/FcjrGWU7mgr/XsYut0LWk/h51S7ZFVGpChls9TZ5SaGODrYRfvl0yg04G6+2sv7ielA8LiOuwbbJehLY6zUNGw1S7DYXYYyMcmfSn91L8619DH8MDnVwTvW6LZWNJb4vCH1WgjKJPIr0tzri/dcJQk+wsbFdNb/05DEi5883wGV3k9VCrR3JwzMuK/IOvx6NuHOK7s3Hg/B21OUBowmnzJfUhNJE+n1o0jd2ianSBEpju+OYQxweAT7SORjqLN7Tphw/LkMCI+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GudDURiXohcoNVKHFTEMvhRyUZrR2L+0V4PWabTrRC8=;
 b=GtzqtJ3TKZ9/H+LAjKPSQNvvz1n1iFZaQ/UtMDsudBgPr3/q+TTdmn+kaePOQ5M5GEDQcKMPNVTFtVIH4VQ5NqFEGOyoxJrSf8O4usonEVfksTqelnaLWgDriEW0KGFrvY9uOx6luql4l7PSyCHPayl0PeCeVqLahh1qx8aSncEH+OlY6voNjCkq9tgrqmnW/BnZR5OummbERo7ljQyGpydF8nzcjAksB1gOAejM6VGkvddrmHPS4JfEgVrh5mqrejWNx8Srd+hTQp+FTX8kUsk7VhtrETbfTmVOHxP/intVpiqbYKpYQcecQP/P1hTpG9atw6ke/7uvUBrOyJlo+Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM3PR02MB10230.namprd02.prod.outlook.com (2603:10b6:0:b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 19:17:23 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 19:17:23 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mshv: Align huge page stride with guest mapping
Thread-Topic: [PATCH] mshv: Align huge page stride with guest mapping
Thread-Index:
 AQHcbu3m/1KRrXDdWE2Bee61xybnKLUnwn/AgAHUSgCAAZKpIIAEOHMAgAASAICAABt8UA==
Date: Tue, 23 Dec 2025 19:17:23 +0000
Message-ID:
 <SN6PR02MB41573BF52C6A4447C720CDD6D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <176593206931.276257.13023250440372517478.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157D69A4C08B0A4FE01F9FED4A8A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUXXdjMyZ5swiCI2@skinsburskii.localdomain>
 <SN6PR02MB41578A17A4DADD9276392298D4B4A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157AAFDD8BD5BDCD2D3DB99D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUrCr5wBSTrGm-IM@skinsburskii.localdomain>
In-Reply-To: <aUrCr5wBSTrGm-IM@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM3PR02MB10230:EE_
x-ms-office365-filtering-correlation-id: d9c0815e-edde-4649-949b-08de4257e708
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|41001999006|13091999003|19110799012|8062599012|461199028|8060799015|51005399006|31061999003|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZwvZ1cgLfVrYbjHZ/Z3Focjm1rxGtmTw/5itmx1GAPNys5h97FAs2LD6FoPh?=
 =?us-ascii?Q?3bFIT6MsCnAT8zTW4WHFPzF4h+wf3h9KZlQ7eawDVjC4pCnN6SAeoQ6So6XZ?=
 =?us-ascii?Q?pXjhKIU6MunAcGeomjWxzem+GiSslJuGnURcFHAWKyWsBn72JDiSbm7IZ/Hn?=
 =?us-ascii?Q?+iWLsOlQtolxtnKy52OfoQd8HHJpxnV5pwF2pk/debEY2RKRqpu2bydsIm0L?=
 =?us-ascii?Q?r8qLJo0i4UpQgf74SvyaSWknaCfSKV9CKJqO5mm15pvb7TplzDvEz8oQBaLT?=
 =?us-ascii?Q?M7CCXg6PoPMKkFfLZrrHH1igUkB0Dz6QDqt3FpMlPDqz4q6iB/90lSclevK0?=
 =?us-ascii?Q?cBbaL9tVSmfy/PB6Awt3w1KCuitw50ntsheq7mMRo2TpMyQQVusFgMjIQDzu?=
 =?us-ascii?Q?K5Yfc/hLpDmzeQuRWTsnRy7JdK6E7TmpP+1aL9OZgubA/EKgro7xFGYmkaAf?=
 =?us-ascii?Q?GgA8o70Nc5tvAxcgUXwlH5AaV2ucX6N+7kpnlqtGdJaRpZ84usBFhT9Im+tM?=
 =?us-ascii?Q?Sls1y0olxP9yiVqRfv7XjmyhHqtEtSsCM6PRrVGn4nL4uhgp8RADHOomxrB+?=
 =?us-ascii?Q?Lw/0BOoBSLzKhwxakKFUoUQ+izjYjT730pyv6j9emlSpL6NXuta2xcF6LWDX?=
 =?us-ascii?Q?AtrrPkHAGF4siqItGUoJGpU8cwJ9tS9UaS1XR2peeRYT+1WSuUwJx2Qx+XlQ?=
 =?us-ascii?Q?wiFJF/5j7di8D8gKijTloyDoAzSQ/fzLACv0pqk95UoEZvwThfzar14xNYbL?=
 =?us-ascii?Q?SKnyO/Kj2jXP/FYAv8dH8jippgFdsLpvJIFpSAb3j6V7WNCa40OblfXHPmF7?=
 =?us-ascii?Q?SErAWswOkZxDcL7bRfjGWt+fHe+E5KcnltyHd+08cn3eRV12/HgV6DZwp5/g?=
 =?us-ascii?Q?T8uaj3j4oTjkpJPHauZfvuCWYjxSzU4yqntRXANFsAsft4OFmvigx8uqu6hB?=
 =?us-ascii?Q?AyZUlUcyUtVCFpdFHT27cYRfZG6mDkILugGCS6+1h7dLRxv0JaQB1WZbprcF?=
 =?us-ascii?Q?PugjuMsEJHOUWyXu+slnq3INiIClyY0PLhmfoPVnQj8uCob9xWv0m+oguVfB?=
 =?us-ascii?Q?58XebFeXXDyGJU2t8lUnS50zMA8Rku65rUvfzVWx5qSgDhxKWNa/+G9HXxQB?=
 =?us-ascii?Q?aCWpGTKQNps/cvjdKWj1Zf0HKm5eE935Yt7eneUmdOoLXtG3NdAHPRjGScS3?=
 =?us-ascii?Q?djCdKM1IQI9Hi5BCw6uDtEwCFEykf/U2M7WLn4BS/wARqHPk7DrEm6GGsG5k?=
 =?us-ascii?Q?LoroQE4IuhgnCDXNbXB0?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SYP6cfn9PhiO9d6zyojTVXfF4JxEUdUM/AVROZaHRJk7m/Xqz8PM/dAP4jJe?=
 =?us-ascii?Q?dtLhBxjERCrMS65KIS7zhnOVB4b9UkyXQ3xk9wKGo9ZvN6C+wJBrwh9Gy68b?=
 =?us-ascii?Q?UUjn/Dp2HxrGDW+kuIWSfgp+dWgNhQx0Wn5/k7x2qTVHHDB38x4Y0h1iNaHM?=
 =?us-ascii?Q?ThekCOLBkFsndkuJEDr4pWz0IoTTecnAh7KhFZLjS6fT+VYe5uU1HC/gq/xW?=
 =?us-ascii?Q?+kwAxWK/KmQad1YTg4XHX9cCQmt2zTBzv7zY9gwAmR3PMuhodJ4ayU9I/mV8?=
 =?us-ascii?Q?GKCpgN8hglizPRqW8gOfVNcBzzajGFVu0HIaS2FZnkzxsZu4y13Tv6c3mPN7?=
 =?us-ascii?Q?H+3gvFK+d1bhvmSdhoMKDy3GSHok+/1ZPVy+/t0gPWMav4oMWMN8fWfQe9+c?=
 =?us-ascii?Q?yf5c93pjTNWRiz0BuZEN/KjKFYc0XILOlXI97uXG2qqf4vePwAvGeU7JYNWa?=
 =?us-ascii?Q?tM4mbX7SaTAvtIJNjEJ3SOBKTmxFZMch6CYex1pMNjzKdyhPrmnQaNPRleMA?=
 =?us-ascii?Q?6Q1ppiD/OHN7LjlGuGwDhx28OOtN2ZHgRjWO+lLuX1GpQ24QBFO1hOMs849Z?=
 =?us-ascii?Q?lge+hdzrYLIwF39pZXsndlSd7QUH9p69aliNP5OgEen5Kjsrc/ItbQprcZGp?=
 =?us-ascii?Q?y+Bd39wapTVnEu6uluabkkiD2iUGrnYzs9blqySXHaTQQOIxqG5VHoscGz+Z?=
 =?us-ascii?Q?eVjWdMv3OxZj2jbgp4tjNMgwfr3W//wvgasmufWiLKOmkLrtsQnYEhMhNUv6?=
 =?us-ascii?Q?locRuaFIhBewAecTC1vxktSJL+ggHr2iaNOwtZcI4mJ34NN1s9qNwIDihZFi?=
 =?us-ascii?Q?UsHNj3M2MTEVP3x2S1VkAlrNVc5Ha3iuFqmbGxRDT5NHZsSvSp0moyIo6h49?=
 =?us-ascii?Q?sdCAedPoDmIgGtKTjrCNEzxPmlxpWGpMMydV9vXE8fht/ImG+/Zx2iUJi/cx?=
 =?us-ascii?Q?/I2xu/qsye3SO6zheBmXR3cuUMK4dgcns+RYFlyxxOfwz0Np7vUqFqAm/CWM?=
 =?us-ascii?Q?B7+fKqlJQUx5uvDH+mp8Ku9QoSFAYoZpfowjo1h6/HUiM3HewzSwCKrrsd/Y?=
 =?us-ascii?Q?+q9cM/mHDbLLOY2jUAmSSOM7duvpwTjucGgHArfLNUDJwLs5fjjbDYGoYmJA?=
 =?us-ascii?Q?fTPx4Bbcuf2uXtuKvRqQpnin7m6leBBf0k8s9Yp193JKo4ZGS8jYhtZk9rCb?=
 =?us-ascii?Q?fBJdVQ6r0WBotYKTx2tVueWhph+ZYwJcsWoiogcynhFiY5pFvxCSuoTbyNct?=
 =?us-ascii?Q?YnA7p6pEx8kbhPUmbkXHgzwiu0EY8U4Q7t/0jAzJEAVz5uBiUxjY8jYt1j3E?=
 =?us-ascii?Q?Y5MHEI7NFTtiVyBh+TEBnB/z+QSQb+zvAXCr82NuYAs/3rZW07sHli+sZQa1?=
 =?us-ascii?Q?ySXr6f0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c0815e-edde-4649-949b-08de4257e708
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 19:17:23.8362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR02MB10230

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesda=
y, December 23, 2025 8:26 AM
>=20
> On Tue, Dec 23, 2025 at 03:51:22PM +0000, Michael Kelley wrote:
> > From: Michael Kelley Sent: Monday, December 22, 2025 10:25 AM
> > >
> > [snip]
> > >
> > > Separately, in looking at this, I spotted another potential problem w=
ith
> > > 2 Meg mappings that somewhat depends on hypervisor behavior that I'm
> > > not clear on. To create a new region, the user space VMM issues the
> > > MSHV_GET_GUEST_MEMORY ioctl, specifying the userspace address, the
> > > size, and the guest PFN. The only requirement on these values is that=
 the
> > > userspace address and size be page aligned. But suppose a 4 Meg regio=
n is
> > > specified where the userspace address and the guest PFN have differen=
t
> > > offsets modulo 2 Meg. The userspace address range gets populated firs=
t,
> > > and may contain a 2 Meg large page. Then when mshv_chunk_stride()
> > > detects a 2 Meg aligned guest PFN so HVCALL_MAP_GPA_PAGES can be told
> > > to create a 2 Meg mapping for the guest, the corresponding system PFN=
 in
> > > the page array may not be 2 Meg aligned. What does the hypervisor do =
in
> > > this case? It can't create a 2 Meg mapping, right? So does it silentl=
y fallback
> > > to creating 4K mappings, or does it return an error? Returning an err=
or would
> > > seem to be problematic for movable pages because the error wouldn't
> > > occur until the guest VM is running and takes a range fault on the re=
gion.
> > > Silently falling back to creating 4K mappings has performance implica=
tions,
> > > though I guess it would work. My question is whether the
> > > MSHV_GET_GUEST_MEMORY ioctl should detect this case and return an
> > > error immediately.
> > >
> >
> > In thinking about this more, I can answer my own question about the
> > hypervisor behavior. When HVCALL_MAP_GPA_PAGES is set, the full
> > list of 4K system PFNs is not provided as an input to the hypercall, so
> > the hypervisor cannot silently fall back to 4K mappings. Assuming
> > sequential PFNs would be wrong, so it must return an error if the
> > alignment of a system PFN isn't on a 2 Meg boundary.
> >
> > For a pinned region, this error happens in mshv_region_map() as
> > called from  mshv_prepare_pinned_region(), so will propagate back
> > to the ioctl. But the error happens only if pin_user_pages_fast()
> > allocates one or more 2 Meg pages. So creating a pinned region
> > where the guest PFN and userspace address have different offsets
> > modulo 2 Meg might or might not succeed.
> >
> > For a movable region, the error probably can't occur.
> > mshv_region_handle_gfn_fault() builds an aligned 2 Meg chunk
> > around the faulting guest PFN. mshv_region_range_fault() then
> > determines the corresponding userspace addr, which won't be on
> > a 2 Meg boundary, so the allocated memory won't contain a 2 Meg
> > page. With no 2 Meg pages, mshv_region_remap_pages() will
> > always do 4K mappings and will succeed. The downside is that a
> > movable region with a guest PFN and userspace address with
> > different offsets never gets any 2 Meg pages or mappings.
> >
> > My conclusion is the same -- such misalignment should not be
> > allowed when creating a region that has the potential to use 2 Meg
> > pages. Regions less than 2 Meg in size could be excluded from such
> > a requirement if there is benefit in doing so. It's possible to have
> > regions up to (but not including) 4 Meg where the alignment prevents
> > having a 2 Meg page, and those could also be excluded from the
> > requirement.
> >
>=20
> I'm not sure I understand the problem.
> There are three cases to consider:
> 1. Guest mapping, where page sizes are controlled by the guest.
> 2. Host mapping, where page sizes are controlled by the host.

And by "host", you mean specifically the Linux instance running in the
root partition. It hosts the VMM processes and creates the memory
regions for each guest.

> 3. Hypervisor mapping, where page sizes are controlled by the hypervisor.
>=20
> The first case is not relevant here and is included for completeness.

Agreed.

>=20
> The second and third cases (host and hypervisor) share the memory layout,=
=20

Right. More specifically, they are both operating on the same set of physic=
al
memory pages, and hence "share" a set of what I've referred to as
"system PFNs" (to distinguish from guest PFNs, or GFNs).

> but it is up
> to each entity to decide which page sizes to use. For example, the host m=
ight map the
> proposed 4M region with only 4K pages, even if a 2M page is available in =
the middle.

Agreed.

> In this case, the host will map the memory as represented by 4K pages, bu=
t the hypervisor
> can still discover the 2M page in the middle and adjust its page tables t=
o use a 2M page.

Yes, that's possible, but subject to significant requirements. A 2M page ca=
n be
used only if the underlying physical memory is a physically contiguous 2M c=
hunk.
Furthermore, that contiguous 2M chunk must start on a physical 2M boundary,
and the virtual address to which it is being mapped must be on a 2M boundar=
y.
In the case of the host, that virtual address is the user space address in =
the
user space process. In the case of the hypervisor, that "virtual address" i=
s the
the location in guest physical address space; i.e., the guest PFN left-shif=
ted 9
to be a guest physical address.

These requirements are from the physical processor and its requirements on
page table formats as specified by the hardware architecture. Whereas the
page table entry for a 4K page contains the entire PFN, the page table entr=
y
for a 2M page omits the low order 9 bits of the PFN -- those bits must be z=
ero,
which is equivalent to requiring that the PFN be on a 2M boundary. These
requirements apply to both host and hypervisor mappings.

When MSHV code in the host creates a new pinned region via the ioctl,
MSHV code first allocates memory for the region using pin_user_pages_fast()=
,
which returns the system PFN for each page of physical memory that is
allocated. If the host, at its discretion, allocates a 2M page, then a seri=
es
of 512 sequential 4K PFNs is returned for that 2M page, and the first of
the 512 sequential PFNs must have its low order 9 bits be zero.

Then the MSHV ioctl makes the HVCALL_MAP_GPA_PAGES hypercall for
the hypervisor to map the allocated memory into the guest physical
address space at a particular guest PFN. If the allocated memory contains
a 2M page, mshv_chunk_stride() will see a folio order of 9 for the 2M page,
causing the HV_MAP_GPA_LARGE_PAGE flag to be set, which requests that
the hypervisor do that mapping as a 2M large page. The hypercall does not
have the option of dropping back to 4K page mappings in this case. If
the 2M alignment of the system PFN is different from the 2M alignment
of the target guest PFN, it's not possible to create the mapping and the
hypercall fails.

The core problem is that the same 2M of physical memory wants to be
mapped by the host as a 2M page and by the hypervisor as a 2M page.
That can't be done unless the host alignment (in the VMM virtual address
space) and the guest physical address (i.e., the target guest PFN) alignmen=
t
match and are both on 2M boundaries.

Movable regions behave a bit differently because the memory for the
region is not allocated on the host "up front" when the region is created.
The memory is faulted in as the guest runs, and the vagaries of the current
MSHV in Linux code are such that 2M pages are never created on the host
if the alignments don't match. HV_MAP_GPA_LARGE_PAGE is never passed
to the HVCALL_MAP_GPA_PAGES hypercall, so the hypervisor just does 4K
mappings, which works even with the misalignment.

>=20
> This adjustment happens at runtime. Could this be the missing detail here=
?

Adjustments at runtime are a different topic from the issue I'm raising,
though eventually there's some relationship. My issue occurs in the
creation of a new region, and the setting up of the initial hypervisor
mapping. I haven't thought through the details of adjustments at runtime.

My usual caveats apply -- this is all "thought experiment". If I had the
means do some runtime testing to confirm, I would. It's possible the
hypervisor is playing some trick I haven't envisioned, but I'm skeptical of
that given the basics of how physical processors work with page tables.

Michael

