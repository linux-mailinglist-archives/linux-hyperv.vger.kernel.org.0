Return-Path: <linux-hyperv+bounces-8061-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD59CD9DD3
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Dec 2025 16:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA3EA300E7BB
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Dec 2025 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9A52512C8;
	Tue, 23 Dec 2025 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IEMDCV4R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011070.outbound.protection.outlook.com [52.103.23.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E768313D891;
	Tue, 23 Dec 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766505086; cv=fail; b=SSaI8q0QHoG5J8DA8NQ6ghoCl4c444HwmgrOTI+gCsX0olv31qunvbh4RfKRCeU70RLty+g8fs2RlemdJKm6w77hDTkYEpfZ56TwIu71bcxHmmFx9k2Yj0i5VGpemt8ie7Jbaz6fZE+pZ+5awuN01Ge+tTY4/IyDC/dNLIFnmRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766505086; c=relaxed/simple;
	bh=s2SeyY3Ye6JxRm5vFg9Nxr82fmOH56OaYCA/GDl+XL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LMPUCYdt9qTip4uRVdr9e6gh2+IaBD7daTL8PmTC4rI/F+vR55sufqKufBBxS38IY/h61luGZzW2FAX1egd7Fpnf0fBex81kmIgJO0Qrh7lOujoBFxgZD1KutF3vnLMQ2zU5HvG9pFHdYfDyf6T6E4OTu3qLsaISv2/yyX7Tm28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IEMDCV4R; arc=fail smtp.client-ip=52.103.23.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eogczvBjlKkbRn1j6J/pTfqBa8zeYa7y3JSTUDebclKiCJINHewIWPkRvLVyJi7M+s9xapu7lPOlyQ1dGtGIHBbbcd7C3ZfVk9qstfZKTSe25iOWpFqU1i0CQqkVyJACB3RyqA89cScGev2BLOoFVJHExPqmUB70SH89Gd63RuToJdKxTFLaka5DVcCaaQdagcEbmYmEXTN9k9Na2f3Uu58ksjeKMjlmlewRp8fs55y57+SGmjsMlz3Ej9VX319HHEac98Nq9iryuJPhhK5NZvfwQVcb+VlMMO/3lX3Br6j58yuPg/Rxkoiyx4msrFvQEw6SP4SZomAiwf0CR0jHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQd4XvIcUEZsPIGNR0lvwyH9Ue8wo2JwN/Qo+JphN94=;
 b=kjgV1HNHkSBLGi6OEEXq7rBBarxv5LduaqC89vD1O97hgbOImSNb/zxj0EGhLYoAT+Qu7iAXF6TZgKqxLfsoVkCyTjLYdukA23KQsLqpVWTavktIK5smjY01AxRdnogUA+zX1NZFWMAscXlKk0h1aeT4j++MuIX/I2L1eBJVhxNnUIY+RUKBEl6nVMcsSqNDYJbe8xCbklkSjq1VXL4xdAjsvQ6d5334YhQVXXj/CAgX4TrY9QSWvAnBTPEWrEvHoebBZVf4egMoPYyKtatfqlNXD85m0oeuAjsOfaDRNRcMKHQSOHtRfGdYvu4MexWW182tWrIJUz0dhjrjLuQECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQd4XvIcUEZsPIGNR0lvwyH9Ue8wo2JwN/Qo+JphN94=;
 b=IEMDCV4RWAbhq5/LnRhyz3ZhZ5NDajOj9pLkKrat1FvWNGle6mRd0zPj+VCfQAh0kwSCk4JjpOIWQ5beNRciUahUhBts9OXWO581YEX4DilKGQuvVqd6PZoPZy8xop2WxZiHHdNjRiDba5Au53gpO9DAcme+VrO6U85so5bVKev5mUOEXlQ/7WNDasxQwPVtZEtcE6y1yZvofZsSMettvyHWLqZ0C8l/27/1jNN+zyo4lu+hdtXMgE5k42ORS4ZDydMNxC9Mm/W542IGt2F9MnfBjzzxUdKQ9YV9pCQkanUwZHtS1+zrSqtgb1QPamTG5U94uUcX/ZXy+N4OAnQQmg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB9958.namprd02.prod.outlook.com (2603:10b6:408:19d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 15:51:22 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 15:51:22 +0000
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
Thread-Index: AQHcbu3m/1KRrXDdWE2Bee61xybnKLUnwn/AgAHUSgCAAZKpIIAEOHMA
Date: Tue, 23 Dec 2025 15:51:22 +0000
Message-ID:
 <SN6PR02MB4157AAFDD8BD5BDCD2D3DB99D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <176593206931.276257.13023250440372517478.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157D69A4C08B0A4FE01F9FED4A8A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUXXdjMyZ5swiCI2@skinsburskii.localdomain>
 <SN6PR02MB41578A17A4DADD9276392298D4B4A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41578A17A4DADD9276392298D4B4A@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB9958:EE_
x-ms-office365-filtering-correlation-id: 9f1b91d8-73d3-4759-1cd2-08de423b1f35
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|13091999003|19110799012|461199028|8060799015|8062599012|31061999003|51005399006|41001999006|440099028|3412199025|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2rwRnJoypnpyZt6PQjLW1eBAardWhZv40akLYL2mjrKR/8c8CMZeyi3+mgLA?=
 =?us-ascii?Q?5YwRWlQKhFtODBGsvFQKbLF0xc8w3Fbw8w8p4n7YYclJWkwHHpLHRvxIbiAn?=
 =?us-ascii?Q?ViZeww9uR0sUsX3Em1EqXLZK4Y8Glyoq/aN04eBOY/16nOP1DtYnjkiBp9fU?=
 =?us-ascii?Q?AjqBhSPiFJFq7uuO4fpjMp34HSCdXMPU79kOu50dh+cwwkrnveCcLIy/Fjsq?=
 =?us-ascii?Q?h6aShX3C9aHY+Ly5iuK+hDT6ivBh5PYhR8cSUD+BHX1bYqzkGgw8tc3tWGgz?=
 =?us-ascii?Q?LCn4wmtbMZImS3A8STBXnax04hy66EpDbShwFEvn6LXkYqt9Nt6XERTmsd1x?=
 =?us-ascii?Q?skdbH4tpHLJ3TU/Ro2XsnZH/V3oJjhynFHqSy1U12okYGV6zL4jEncHB55no?=
 =?us-ascii?Q?pfEFjNyfgboNXEAY9Wd36LEwGz/bUJZbqCX3eQgtbnVdazbVEwMseMY0DqlL?=
 =?us-ascii?Q?0JNfilGzDXLfnMPj+jiWNLK95Zb1S8jT48bLNflB8IyDfiKwk/i3KRwxDlct?=
 =?us-ascii?Q?2P8cI5FLCq/CAMgeOvmfGqvXF21d9jLBAg2uCZQT1ihkFFBGzE347zr/vgjc?=
 =?us-ascii?Q?zBN5yRqrGcxOA3o0fFK24NwJfQdI00lMQaxJDljEzc8C0AEYmfs76tJ+Bt/j?=
 =?us-ascii?Q?mGvhySKDVv4qS2mwXgkM5y1KXdSVQXOEtiWxt/V2p7QkGYE2l3SB2sIt01+s?=
 =?us-ascii?Q?kS9SALcmgd6ySiYfsE/4no31sxDMvhpb2H84Xt6gTlCeT9+5YGRxke+vfx33?=
 =?us-ascii?Q?CFDed5RImiTFS3TG7laTjFO/Mssk9ypnqxOmjJfasj/UmmdXoLE7xfj8R+lA?=
 =?us-ascii?Q?CkBlR1a9z61LwXHktUAiN9YKjmCfkfL8JXMKf5Qcwcss2JoyfnKw1jvt1Xna?=
 =?us-ascii?Q?x/A5w7YZj2BaQ79WwbQzOy/OSxC8iRnO9aOO3GcFu69/Vi9KjIzR6fpZp5sp?=
 =?us-ascii?Q?jBcUw6IosrQItfE8H8Z9W+1dumQWP846bJTjMBVrUw/hmkfiv+CHvKvdj2rk?=
 =?us-ascii?Q?yD3nXfXQUBfrIXfX5RN60Pn8etLb/cnx1jWYrtD5cSA6O0+rCN0GAMj1o0ep?=
 =?us-ascii?Q?mlZLOVqk0ILKmW/6OfJMFKj24oqxZ0HlHmcBcXVoEv+yus1pI3Pvl1zOQmPN?=
 =?us-ascii?Q?6TI+jb4lnDpCftqI0v1nG/D0m8BKUsD+GMRPaRzlZZVjn3OWR1lTsYe9Ibrf?=
 =?us-ascii?Q?qcaV/DTrhoH8Tzx8CYTtIeMw6zU7zJ8jYwQBck+r6BRgkJ8fgwbaodcyx9R2?=
 =?us-ascii?Q?oaor2az6VCChgtgPQ/Cv?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LXaLknI52MZvHE3Da8ioqVkk1Ic1Rq+q+Bp7mwxEm7I88PFj8BhFTHD8vbY3?=
 =?us-ascii?Q?xw076exazawBpPCnAM//yXFw+/IssPq9WTpajuu4FFSRLVG3zRQ3OtMHOJ+6?=
 =?us-ascii?Q?kvwqYqcnzmh45HEHcwQbJpxSjpzg6k+vOgqi3GwgDxo2QFsvK8DtZhNOjRJs?=
 =?us-ascii?Q?VuhCf1pGKbLL+0+L9+ttN9YTGR/10vKz0zFpqGByn4duHo5rZg6RKCzH/QNW?=
 =?us-ascii?Q?MbK+P7pRtn+hXgDMHGyYU7mTRmnj6Yihhbs2cQTulQMj8mb3Z/LeUvvL7tBl?=
 =?us-ascii?Q?FtSRJmSewVi0KlOpx2nOk9Igd9qlSRqHDATPVlaB+tQf+TSNarMdJv3nhEyP?=
 =?us-ascii?Q?R4Qws8IIF7AMs6D9nJFD68wVzO8+ALL9kdegBApxvCCxIIe7F8BQpadu/ao3?=
 =?us-ascii?Q?xUQ9Wv3eYldxZGhhC6F1g4EmdNGrb362idvhkcW2qr+WyMrU6LZGfMZRy5Ue?=
 =?us-ascii?Q?74Iuo8eZrPi+4Q5axgMZNrclmLhf5PMRWUlUncI6QyYcQoBYPJLeejdor4Xj?=
 =?us-ascii?Q?oGzX09gxLhtE74M5fhIXgqSehBwjcpt5oxLmpghkp0WDWZlv7wfskMrf0Z7V?=
 =?us-ascii?Q?keD9+tOeQ+fdnZ2XscOaNSyIXfZHh9A9yvZh2c7P8pnwm6Ycnj/xuZsf4Rrs?=
 =?us-ascii?Q?Orq5lbNYALq/eDQtWqlX882CGaNsEesDwj+wrzUQ62F7uwDjWb5s2Obqi/pL?=
 =?us-ascii?Q?8EyuRp2I/uyoeDB9XWCAff3OYIM46sMujmBQEVDaioruZjfSv6LIO8EUFD4Q?=
 =?us-ascii?Q?DgOkS6q79VEFuxzjG27s1BheEVBB3zKfFB+CmIycuyJJq3LUBKy8izwqCo8/?=
 =?us-ascii?Q?I3gvS7NyuPE50en2avhqrlNOs3ztdDV0ufz94JSTFAeb0r1Dv/tT5elWdj0p?=
 =?us-ascii?Q?gZfMGOBofuB+VDo2ewbqUaX9cU2i1XvWVtj3t3MrFj6A9PmJ5kIjYwf/6qtL?=
 =?us-ascii?Q?fWLXK04mraZTwm/LT2Ts/vI1G7hqxnmSUt87Ljsn53sMEchm+kEuT/jg7Ww9?=
 =?us-ascii?Q?JgR2SXkYXWLrJn0NlyHnm/RKLifOkngJLNpIRpPMq9p6jJEKy1TuEZVxAMyE?=
 =?us-ascii?Q?PK5168MnWgIS7uu2HmZxmSDnczmPPo8BY2wcJvHoog0+J6JnKTamHBe/IMI7?=
 =?us-ascii?Q?fCaokWJaWvVWbSbqaXbOKdQ9p+kbfMRNx0+2TTdDgOiRnpnF7dQYsbAUOpXs?=
 =?us-ascii?Q?strv0G//otZnmjTlbuZMI+UXnY3UZUvrMiviW9Hg5ApSWJdT4eZHY3TdrXfL?=
 =?us-ascii?Q?yijc7U4XGmB/6wWchwuRQU4ic9ko+xkhpV/+qvH6ApWJbFWISjVz5N4iq3jh?=
 =?us-ascii?Q?wisyLUDzDY+eDs/dz3Q/6GqpMvzcJ3Rn3YUsYcwhMTU7iWOGQEsAbBWfMZDQ?=
 =?us-ascii?Q?aQ+r8lk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1b91d8-73d3-4759-1cd2-08de423b1f35
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 15:51:22.6315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB9958

From: Michael Kelley Sent: Monday, December 22, 2025 10:25 AM
>=20
[snip]
>=20
> Separately, in looking at this, I spotted another potential problem with
> 2 Meg mappings that somewhat depends on hypervisor behavior that I'm
> not clear on. To create a new region, the user space VMM issues the
> MSHV_GET_GUEST_MEMORY ioctl, specifying the userspace address, the
> size, and the guest PFN. The only requirement on these values is that the
> userspace address and size be page aligned. But suppose a 4 Meg region is
> specified where the userspace address and the guest PFN have different
> offsets modulo 2 Meg. The userspace address range gets populated first,
> and may contain a 2 Meg large page. Then when mshv_chunk_stride()
> detects a 2 Meg aligned guest PFN so HVCALL_MAP_GPA_PAGES can be told
> to create a 2 Meg mapping for the guest, the corresponding system PFN in
> the page array may not be 2 Meg aligned. What does the hypervisor do in
> this case? It can't create a 2 Meg mapping, right? So does it silently fa=
llback
> to creating 4K mappings, or does it return an error? Returning an error w=
ould
> seem to be problematic for movable pages because the error wouldn't
> occur until the guest VM is running and takes a range fault on the region=
.
> Silently falling back to creating 4K mappings has performance implication=
s,
> though I guess it would work. My question is whether the
> MSHV_GET_GUEST_MEMORY ioctl should detect this case and return an
> error immediately.
>=20

In thinking about this more, I can answer my own question about the
hypervisor behavior. When HVCALL_MAP_GPA_PAGES is set, the full
list of 4K system PFNs is not provided as an input to the hypercall, so
the hypervisor cannot silently fall back to 4K mappings. Assuming
sequential PFNs would be wrong, so it must return an error if the
alignment of a system PFN isn't on a 2 Meg boundary.

For a pinned region, this error happens in mshv_region_map() as
called from  mshv_prepare_pinned_region(), so will propagate back
to the ioctl. But the error happens only if pin_user_pages_fast()
allocates one or more 2 Meg pages. So creating a pinned region
where the guest PFN and userspace address have different offsets
modulo 2 Meg might or might not succeed.

For a movable region, the error probably can't occur.
mshv_region_handle_gfn_fault() builds an aligned 2 Meg chunk
around the faulting guest PFN. mshv_region_range_fault() then
determines the corresponding userspace addr, which won't be on
a 2 Meg boundary, so the allocated memory won't contain a 2 Meg
page. With no 2 Meg pages, mshv_region_remap_pages() will
always do 4K mappings and will succeed. The downside is that a
movable region with a guest PFN and userspace address with
different offsets never gets any 2 Meg pages or mappings.

My conclusion is the same -- such misalignment should not be
allowed when creating a region that has the potential to use 2 Meg
pages. Regions less than 2 Meg in size could be excluded from such
a requirement if there is benefit in doing so. It's possible to have
regions up to (but not including) 4 Meg where the alignment prevents
having a 2 Meg page, and those could also be excluded from the
requirement.

Michael

