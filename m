Return-Path: <linux-hyperv+bounces-5274-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D172AA597C
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 03:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92C23BAF99
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 01:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8F922D7B7;
	Thu,  1 May 2025 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tkLMO2SD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012013.outbound.protection.outlook.com [52.103.14.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF811F541E;
	Thu,  1 May 2025 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746064545; cv=fail; b=WccCQCdgASNbjNKvWqyI7MIKOHkVQccOBhN7MNnFG73T697vRIOSMNhGhddmLF9caXmZYraJ1NNP+iX6emsv9R0B3LXSd7wCeqLP1kfgeBRR1+CvMiqDpbWGk32VPHXTYG7Y99qLkWXGJT523HY+r+xWPy+yBi1+JUVuCOwj3wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746064545; c=relaxed/simple;
	bh=3m8y+9fBQMxX8F3vwQdSoe1TKdCb0Ih/Bp2RbI7IIZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZ5/nBQBLbRV73T4Cl9DSj3XREy9CvgNBvWYJuXYThlXG7zWNirm4XSGzn8hrPxSE8c8JOtwgG+dhfld1ptuRCr3rraad+QAF7NxTseGvjKwxL1fq+f3vhDLDOTurXBNbKgnPoqS/8etvGv4GG8y9Q1fZ082FuCyBdZ5U109vmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tkLMO2SD; arc=fail smtp.client-ip=52.103.14.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3B/97HSpcD4sRuUjvBbMTIPAa0+slexsKkQnJLcF4KhEvYBKVnZ/jgqErnrkpPb+acOSe3NIjIpbXb7myZsj/4sK1aNIIlKY4V2eDmf/JQjO+RP1qtvONq69bz9xazL1pkOA8mJInkEtjqtI96NIvVaQ3iVzDuRo7MxZBXEF751U+JYLUHnG80feyoATK3GsHcY8//S6LYIj6EXIao4AM3C5xNBd8rwtDZN9eGiIz2uqJ/66oPwsFe0ge3srbTl0FgzoGWwOciG5wj/MoJAXvB5oqh6DQ+TOh5PK2JSrkX5Dac/y1rPoiU1f/ebN58gtS0zSj8L23pWWr+MGCU0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GO3N1OTZNdQ8EXdIHWj/NMglt5MVRQM8QoZuJoTBelY=;
 b=yC5qP51CjkhAQK0pfuD69ba7prOwQvDgleLUfBbk0Hn+cVPZkh6qj8X+cSdYiW00lRU+eBYlAleS7zNmgGC22rRNbEL/PahU6fvL06Wwa8uKLyMskoonwS45XzrSYDT+CzrYtfjy0gJNHIItgqeFaf8LnU6nSnZIef2ROOSqrbwEUQup/PW6Z5lwNAN8y8C7IzrTRpM0w8GfXablUJqcsB/F7NkvrWE34JPdF3kJagjUQBEPQetIfH/H3z+koN6OxWnfCNKAZAw3+DQroUQ7+KjNuVPLJwdTkCtkOdtoLAOkChnYybAfDT3Cm2Dvysaw2CZ1s0C6Wd55IG1E7+bvzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GO3N1OTZNdQ8EXdIHWj/NMglt5MVRQM8QoZuJoTBelY=;
 b=tkLMO2SDrNmlQUvv28zi6feHZB7dYIK14w0es0yU8lM5F1n3pZek44TlDA/3KyecNNM1bdIqwToqXXpobtashHC+uOALvSV5M6CqJZFha9vzwP+i0o3AZNME8Z1hxrGTs2C0ejJnj0/gVv0PlRM6FeheXqGKz3AAsNDARJl1g/DbrRAUnyjMBrjt8aSYCdhTihghUszkitDPREjK9TdBbsq0ONc9VJAaU66sbU4dyZpqrKjLNUEgAQzLOzEe84aHtGVDuQzOvRtkI3c3/hkWGNuaRZdadhwN4pzxyWECVwR1YNtHWOnVVlM4DY9bRDUHE2laO94YQEAuzJFUWoeqmw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9568.namprd02.prod.outlook.com (2603:10b6:930:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.15; Thu, 1 May
 2025 01:55:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Thu, 1 May 2025
 01:55:39 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [Patch v2 1/4] Drivers: hv: Allocate interrupt and monitor pages
 aligned to system page boundary
Thread-Topic: [Patch v2 1/4] Drivers: hv: Allocate interrupt and monitor pages
 aligned to system page boundary
Thread-Index: AQHbuhxVeYAuaxq8CUewO1KLhPQkmbO9AAeg
Date: Thu, 1 May 2025 01:55:39 +0000
Message-ID:
 <SN6PR02MB41574E031668E0F27AABB978D4822@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1746050758-6829-1-git-send-email-longli@linuxonhyperv.com>
 <1746050758-6829-2-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1746050758-6829-2-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9568:EE_
x-ms-office365-filtering-correlation-id: d8a8d426-b535-4e61-a910-08dd885345ff
x-ms-exchange-slblob-mailprops:
 dx7TrgQSB6dEoOZOj4tPAZubvlSTC8VXCrl2lhZ+IonwJlRy0oyBl0+C7Ga/APLV/LCj0Ey2QXW0BfEUtvH5Kk1DZw3G+pBC/Tk2YltWHyzVxCDc4vf35GapdC3/Z1zrvn6xUK3qObv2Mxfu2VCwKlW0Xb3GIVg3JRqnH4zwQ8qCnkJIe1l5Nhghc+Z74898lBU9kZDJnX3quFyy1F0thYwyh5dDRwvThkIr8T75WuWKcwa1p0XSDTf6ZQRrgAlqBJV9kRTM0PdvNVar+WovDl143H6dJnxAwvCpp8ULj3Uuo6dqcBQIjUrtLoMTaaqZIpSEE+LmBvxcWyu2w29eHIYmQqzgyMFSnCmOm1rPtYYuSkniuYr0ODJ4u8srm9ugQUNvgQI8mwxHXlPK/EaRMVz7ECUdU3pZc5M1rx2RoxaJpywy299xRng3cwmFaJev8BrFPG4dopoaPjaVUpD43Fwc3AxiwAlTYn6Mz3eRs5iMfGuG8Ge8tPU7MjGRn1cxH22tVj8ZKxnPYX45D/9CYwTPfLkgKZaEQlX3ebhGKRd6b+547riW8/PkGcL41cFEIbxaMZwoJsPJFZbZgrGj1jWBSfD/EZxVLjPZ2Pz+DrldQJwOeivU/OQwZnf/17mLwblbtKECRdIKulY9vH30lxe2ZcMGJgyY2Rdn12K53mJXVjEiKKEqzu/PE5PmF+znjqIolL05bmj8VkQxVuS7pXYcwBuwGGdd8jLPqP3iUkLRKSNorSHzY3N+oU7PtM7Sve5ss9DFSZE=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|15080799006|8060799006|8062599003|41001999003|12091999003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rMyW4VEqM985q9vmh+t9w2hxiGNPnqypA+IeyBOjxw3yvyfzFv8KnA0HkmiC?=
 =?us-ascii?Q?cK8TjZjfZzzulK96ZwqA15hd1ItHXGlK31UdFMx+OExVnvuI1kbDdu1kTOyP?=
 =?us-ascii?Q?2MKIntIfuU4gWqBNWPYEZLGR+eVxdOPRMKLCTCCgsoekmcj0KC7VrV36UdCN?=
 =?us-ascii?Q?o33WdCworcvAUfOkk/KIfeeUfQudcZo/V6APYwswD5V5e4h4ZfcJgzY//4uW?=
 =?us-ascii?Q?Tt8v4GNYDHbZsYTp6tMc/T78CBfZ70itAoh2FQ5qUEwpB7XQNTZJgCtJM7S8?=
 =?us-ascii?Q?3nWRnm8USNRw3fqsHNA3dnnxTFMJk0LknuNm8FuGAgq1bLhArNEIxoCpwoIP?=
 =?us-ascii?Q?lE7mFzreINHS45dVqbmje1ZvJ+1VAh6gytsT+D7WviKPt4j2l0SduKrRxPV0?=
 =?us-ascii?Q?odPWxia77NxZ+MybGexXcdTpkUHc8h3QVcEL3i7EpH2KPdr2vNYL6AQaOSPn?=
 =?us-ascii?Q?0AIK9XI0fqHjXyjVaycjSQczX4qqM9uNWH8JtDWdsK+3Nb/j8LisWCJd7fZi?=
 =?us-ascii?Q?r78GYpMrR8yHVRBzqr2B/CXdiuq2KgLQzqigYjqxx8giJBsA/KTNS9vcjhKt?=
 =?us-ascii?Q?wJbEMnBqSYnbZj+vGpX8HFM3MWe4L4M47CRY3vQd6skXh1iWA1rY0JYdgz/a?=
 =?us-ascii?Q?naqx4/cNyCpNVYP7e8rBFcsBk3XZgFLPqnRxJlBb3f4sY0A0Ncbfh+8FBhlp?=
 =?us-ascii?Q?KNH4DmsV/mi6i+Z7KrgmZLZQIQd3AJKWi4YMVpmWw0QeZKzVPxnqEFyJX6Ym?=
 =?us-ascii?Q?A6rwoTMXE7S5kTicNyG7Y5PM3CZrBRYvZf4c+LLWgFgWRB2AfQtlIwo5v2wx?=
 =?us-ascii?Q?lvhugQhNqpx/+0vGAP2xy1TGqmuqEQGreDuFI1XbgN3mh8JFwXsvv22PeuSH?=
 =?us-ascii?Q?u63EWxdOYfcMLLkqI7dHPpUrXEPoXp14lQLrWwQyAGLRXw361ylZWhSFWdMW?=
 =?us-ascii?Q?ZO2/buKlrgLK/2HrCB8+ZotsjCQ4YhEgL5RFeNXVoPDUY9HGTk1/MwJhhG2k?=
 =?us-ascii?Q?GHs0SVWKRoxUQ0bkG6wftzyPi1AapyauTNc0Yb63xInMtiW34t4biAPJUVDZ?=
 =?us-ascii?Q?2jgRhJrLLTHwPZWzTxXOLfbVEPj1HPJrksI0mitLnWgA0RFbDTleJrJGG62R?=
 =?us-ascii?Q?gMS/XVdBmjeHUwh1M3ElXXaIWj9RJxf6gg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RgIXze+4hkwD9re+iH/lx/Hl1cOBW93CgCIdJB8IUTQgrUWNbNupFuCV6qvg?=
 =?us-ascii?Q?3Mzl5lcwHNfJo3T8Fj0E9CpE+tQCsHQMrIdcik7eGBa40+aw0dbtfsVT+4MG?=
 =?us-ascii?Q?p1bgm8dQEpBGq9bYl0ElN4LvCKES6IE3RwivX7fGoFo9Z1+sqKvkbhOgcD/C?=
 =?us-ascii?Q?CpHFLF8sqpU3IoXbEIdKzlQmrQcVC9bTtoxjQ1tGht9xYzEnle7SLXD+V96j?=
 =?us-ascii?Q?MLlw4NbFOkj3e1cOKP/0BGTrEiQA+yCz9ZiprMO2X230XrNfdkpj0TIIwqPA?=
 =?us-ascii?Q?yCUYOoot5QcKW8bm0FONjvW/W4vUezsW1llNHX3PFj5gqNwh/gjVEEHHyZr5?=
 =?us-ascii?Q?MtvUmivZvPsQJPanDAzrnB1dOuuci+hvhWurbtqVZeKDGaj/z7sM9BRRqXQV?=
 =?us-ascii?Q?W7SGvwyfcb5FI4RadDjIVTYWTxBMICgKfGQJqcNTtJSjgrCdqxi9X4KrJJGV?=
 =?us-ascii?Q?X1CcHXW5OtCwa7I3xEYnnN0zd/slwaKhRhpwQOzVNV6En792ar9h2UwLy6sX?=
 =?us-ascii?Q?I7+RydeHIkbcQX3V+Q7OJhZZefetQ4/Ye7UJ6mw/PEdZjtyU+aX9jtYzxFPu?=
 =?us-ascii?Q?ADNVk722D8ycI8xR5pdfzctONlePgQ5d0PfIdZkkA+GoXqa+WBo7UHkpj7VR?=
 =?us-ascii?Q?tcbKPx9XPvzh310wRrYwh3fd9D7NRliGqPW+MBmS2vCRTyULjlgoAxaaGNXt?=
 =?us-ascii?Q?/j263SPtUxTSe8zTpdthya27Voevz0e5XIePYy8rbxcbX4a5GE9DO8jnCe+6?=
 =?us-ascii?Q?BRpixXX0vJOvXSqP6sx1v1Ulbry9lW0uK7GCHPfWSofYvmP9g5vA48FAPnGE?=
 =?us-ascii?Q?tT2uxnX+6bVA0nWXwLoJou8En/x9tMX7jKpRZH6J3WuP9HjkibTUC/0DSSdW?=
 =?us-ascii?Q?q142K5T+0Q8kGMrz0rHsdVjHWnK9gB/i27tL9WS1TjF35xEScd6bXiag9Vzz?=
 =?us-ascii?Q?ccVzcua1Locv46g/uRsMUBp3RwiF6jPdNX0wmC2Qz3a8NHHjSad6BBILVH5g?=
 =?us-ascii?Q?4QEXQWBBNQcO6h/KDftrLsGtEOSNwahneOeDK/G3nxiMsc9tNRMpChf2bKiH?=
 =?us-ascii?Q?GE8jne5eJr29vLsHconne1bNnR4s0heshzqQOXubG3NBwCatm3KikYQW1mGL?=
 =?us-ascii?Q?GPDtVoLmKdEI3kxfBSZPob+P/4bu9l0aemIpLrm61nepLFVy5K2+okEVGhdD?=
 =?us-ascii?Q?HgjwSfKUNDY8bgaif2MRCUvnIr7AMX+BxljySOF5KssrmuhGZzYl4c2zeP0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a8d426-b535-4e61-a910-08dd885345ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 01:55:39.4424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9568

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Wednesday, =
April 30, 2025 3:06 PM
>=20
> There are use cases that interrupt and monitor pages are mapped to
> user-mode through UIO, they need to be system page aligned. Some Hyper-V

s/UIO, they/UIO, so they/

> allocation APIs introduced earlier broke those requirements.
>=20
> Fix those APIs by always allocating Hyper-V page at system page boundarie=
s.

This patch modifies hv_alloc_hyperv_page() and friends. Then Patch 4 of the
series deletes them, including the modifications. It would be less code mot=
ion
to do the first part of Patch 4 (i.e., the use of __get_free_page directly =
in
connection.c) here in Patch 1, and leave hv_alloc_hyperv_page() and friends
unmodified. Continue to make the change to hv_kmsg_dump_register() here
in Patch 1 as well.

Then have Patch 2 simply delete hv_alloc_hyperv_page() and friends
because they are no longer used. The modifications to hv_alloc_hyperv_page(=
)
and friends would not be needed.

Patch 3 and 4 would be the additional changes in uio_hv_generic.c.

Michael

>=20
> Cc: stable@vger.kernel.org
> Fixes: ca48739e59df ("Drivers: hv: vmbus: Move Hyper-V page allocator to =
arch neutral code")
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/hv/hv_common.c | 35 ++++++++++-------------------------
>  1 file changed, 10 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index a7d7494feaca..297ccd7d4997 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -106,41 +106,26 @@ void __init hv_common_free(void)
>  }
>=20
>  /*
> - * Functions for allocating and freeing memory with size and
> - * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> - * the guest page size may not be the same as the Hyper-V page
> - * size. We depend upon kmalloc() aligning power-of-two size
> - * allocations to the allocation size boundary, so that the
> - * allocated memory appears to Hyper-V as a page of the size
> - * it expects.
> + * A Hyper-V page can be used by UIO for mapping to user-space, it shoul=
d
> + * always be allocated on system page boundaries.
>   */
> -
>  void *hv_alloc_hyperv_page(void)
>  {
> -	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> -
> -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> -		return (void *)__get_free_page(GFP_KERNEL);
> -	else
> -		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
> +	return (void *)__get_free_page(GFP_KERNEL);
>  }
>  EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
>=20
>  void *hv_alloc_hyperv_zeroed_page(void)
>  {
> -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> -		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> -	else
> -		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
> +	return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
>  }
>  EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
>=20
>  void hv_free_hyperv_page(void *addr)
>  {
> -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> -		free_page((unsigned long)addr);
> -	else
> -		kfree(addr);
> +	free_page((unsigned long)addr);
>  }
>  EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
>=20
> @@ -272,7 +257,7 @@ static void hv_kmsg_dump_unregister(void)
>  	atomic_notifier_chain_unregister(&panic_notifier_list,
>  					 &hyperv_panic_report_block);
>=20
> -	hv_free_hyperv_page(hv_panic_page);
> +	kfree(hv_panic_page);
>  	hv_panic_page =3D NULL;
>  }
>=20
> @@ -280,7 +265,7 @@ static void hv_kmsg_dump_register(void)
>  {
>  	int ret;
>=20
> -	hv_panic_page =3D hv_alloc_hyperv_zeroed_page();
> +	hv_panic_page =3D kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
>  	if (!hv_panic_page) {
>  		pr_err("Hyper-V: panic message page memory allocation failed\n");
>  		return;
> @@ -289,7 +274,7 @@ static void hv_kmsg_dump_register(void)
>  	ret =3D kmsg_dump_register(&hv_kmsg_dumper);
>  	if (ret) {
>  		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
> -		hv_free_hyperv_page(hv_panic_page);
> +		kfree(hv_panic_page);
>  		hv_panic_page =3D NULL;
>  	}
>  }
> --
> 2.34.1
>=20


