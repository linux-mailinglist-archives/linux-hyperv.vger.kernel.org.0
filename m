Return-Path: <linux-hyperv+bounces-1389-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C76827494
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 17:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26EC0B21B60
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A70524C7;
	Mon,  8 Jan 2024 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fVN/dhz2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB39524BE;
	Mon,  8 Jan 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MP9eQ13U746KkFQa4lZTXAO9slnUiQfJUVnGeJiNHhjprhjUsIt36o0nuiHWbd0R4uXbC1nEhMUa5XVWFRWP0Pw3Jj9RPw+TVEq/cBNfRotVK4UK5b+zZeciOEsr4lmVcPk4c+mnrJLw4WPPYl6jNS+/T8cLwbfgJ+It/Otk4K2FQBCK6FPOPE0gTBB4PU0UdMnKmsjfTIkwTLGVW6vju5/ZBNfzLdu4eJ/4MCWyeYCAk7ApE7eA6QWo93PQe9JoSpT8Y3CCUxvAjW0vkpqQTCvZLz5CyuA8d4SbqrLQQ51Baq3f/21lE3w3c5UJmq6WezSQGdLzzoB1wt3tPmQJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRhZwUho6yokaoT/tGsceDsw5mmh6A/HmkdX23k+XfE=;
 b=YmuLiX3uu1tXXM2Xpd/9jdyC6MXtbdccLjoWHmzA4nQcOn7c++LGiujstwth4nZY7EbOk7yNKaiugkmg1b/D0CY8adnOtrx4bbgK3Wuf2kDwFAFXkecosNofEnVsdIxV2wZHJ0tcaN9lPmwgAP5gXSDkJjdrwFpsKdG0Fi/2v7YeYJigBgqCacLJteYgIX67MR8bOpmoa8wecnZiZ+iivtVMXp9G1gae+0FWCcqRyYO1LcNmrowwTNxhv/8q34a2Rm/3GbeIBhT2NQMCdl/us6A1DfxPsIz9X/UoszMFDEJyS2pMEE2pEbqjVHOsE0zY5OlqPw+OnYLzU9kHbvEAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRhZwUho6yokaoT/tGsceDsw5mmh6A/HmkdX23k+XfE=;
 b=fVN/dhz2FmDj2TtI5tYrXaDeYBA/XxZHzg6UzX4mVndTisp17vP7HK7e26MPu0nSvD6W+PUuW24Ud4qQDtAG0mwOwDy1aHBCgxh0Rs5f9gVYEqGyiw/8q2yaW1SHKCbfgy+FA9SFzujCDGJg/62iVpKeyuJxTWXwY5uvTQg0fcRZZ95vWkG8RnND3TPfM9o5JYOTcM+BpcCyuTjcQzPjTw/kKUwpHT90oR3xcA+VnZc4Gzob89Jhnvai5M7AjbXCir7OATB2ZwPD7F4SQ1RieL/Z/v4BQ765S3dY0W4gqCARuYH9uihwc3c145gFCxhybB1tX/8remjtk6Y62TUd7Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA3PR02MB9970.namprd02.prod.outlook.com (2603:10b6:806:382::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 16:00:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 16:00:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "luto@kernel.org"
	<luto@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "urezki@gmail.com"
	<urezki@gmail.com>, "hch@infradead.org" <hch@infradead.org>,
	"lstoakes@gmail.com" <lstoakes@gmail.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "ardb@kernel.org" <ardb@kernel.org>,
	"jroedel@suse.de" <jroedel@suse.de>, "seanjc@google.com" <seanjc@google.com>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v3 1/3] x86/hyperv: Use slow_virt_to_phys() in page
 transition hypervisor callback
Thread-Topic: [PATCH v3 1/3] x86/hyperv: Use slow_virt_to_phys() in page
 transition hypervisor callback
Thread-Index: AQHaQAVimv7uqsPUukqF0M02BKDa3rDP51qAgAAvjfA=
Date: Mon, 8 Jan 2024 16:00:34 +0000
Message-ID:
 <SN6PR02MB4157369A252497FEEEBD5B83D46B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240105183025.225972-1-mhklinux@outlook.com>
 <20240105183025.225972-2-mhklinux@outlook.com>
 <20240108130757.xryzva4fkmgeekhu@box.shutemov.name>
In-Reply-To: <20240108130757.xryzva4fkmgeekhu@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [g7uEn8TXauyDOZeM+uRv7fnF6qV+Fjdq]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA3PR02MB9970:EE_
x-ms-office365-filtering-correlation-id: b9f1c699-f464-4563-c59a-08dc1062f284
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HcasiCYIc5bN7miXsW7yv7EtOG5dCXhww8/r8XJZTUuvfkCMFwiui8mc84yzEhrvNeU4JLK8U+IMnArdyzF5314pz7vHEWMFO739u4+Sxkqb5LVMv0Mzx0o2c9qCSd2ef9sBcrdhBPm2/1eZ2gJo2J24JKKXc8J8HPTmRM9xOi6w+CfQxcoGgpgJbUnvc5vtmDqx01JYRofSaOfbSOR5ofox0FqVSdYhqLzAKErpUB6PGeCWEfNZe5KB/+/a08gDkKhNRRVCN94QEvDlgwJG6emPa+uxS1b4mB1ExMfXY0bORI5X1H4Idjyse954AvwExN4VyUbJA6Og3nJnRC5dnNqBOAyw5lm0uyYTAs/8fpEaeRpTC5kUUvXfl1faDMv2ELs5ktnVCf9uGXRo87U8r/yxdO6ar6C6WalPwLV3FB0/p85gPDXT0XwvwdgKaTJOfyOmUIMDu9dCx32pHj5ImMcDr0W2+Kvq1tcdzFY3X8OtUnwtLhdKKOMWCjU2BXq8vqu/LwsIeUeQTQqz4XhqZBdvrG7/z9Y5RNp4ZnzmJX8s0qEJpo1NBLxOD4P1yzcU
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o6mTGdGDfMO+r4Y2QGOvqTMd6dFeCVvVwP+4jlOy60NcLccOt5iV09lxKWYV?=
 =?us-ascii?Q?bGfNauX0Anl8EGmX+GB9EerusjMiVwf6nQOQrhQDjSBtVu2SbvpwCZ/O2gFm?=
 =?us-ascii?Q?lc/r+xfR30SKqhvR2geLTBXZlKuYGS8Ktm7KdVpel9WcnXkc+u2FWgiSitAr?=
 =?us-ascii?Q?FaZfyBBBsul2YlhMkRawuAp6g+9qGic09U3Cv2mH0KckuTSrULyWhCeEWrCk?=
 =?us-ascii?Q?FboQxO/zkb6XB2ABeBsxjv4EvR9HbF9TuJNTcx/VLl9FDzO5w8BoTn1zDnuo?=
 =?us-ascii?Q?KGjWYHG23uazcYIdBD4L1wSYn428Upix/6MIdOXuDKYVM4b35crv4NRox1Uh?=
 =?us-ascii?Q?NoZZLfv8L7Ci4fC31Ony2RA8j63mEW5Ry8GIzmxOhsEkuEj73SsI1534qyH4?=
 =?us-ascii?Q?Rpzs5+ThKHi35WEnCg8p/E29sEO5AyRFiQqfhQ5blAYk/CEMDTQ/u4WXvoju?=
 =?us-ascii?Q?aYnuTQBUEc19WK0RgeGaCXQFB1kaB0cuSy1BQO+QtRO+Bq8cL5aGTptvekS/?=
 =?us-ascii?Q?8N6DkvOFwE4kL9mE3MMJmpyrukD+LRZ/zm7zK9RVq9OLFoesyFh0JmLL1WZN?=
 =?us-ascii?Q?r9X5ue/VUQPU7vFK8dBLwSWu8RJgHFO182N7aOIvq0lA/GY8CBWneSe6jCVn?=
 =?us-ascii?Q?AQl+42ycWyiS5aZjcMBLhTOP9b6KnU0O760U41ypt/U3MRW29ryuAdNdxYYz?=
 =?us-ascii?Q?OkCWZaugbilR5DS1q1YaZhHUKnuqNjIIGgycnfZeiNx/x+1mg6SQXWMrcS/9?=
 =?us-ascii?Q?YwPry3Odbdq4B4ffiRP17ZLXVC8waojBlftiuQPB1LKOzNUajhyGBFnXBy7i?=
 =?us-ascii?Q?U6b3TGiPCsnnhexY/Lnl581Ud6ioLTHr4YT8wd6xGY1v4KVo+CdJzcpl9RzR?=
 =?us-ascii?Q?Ek5y5CJVi0bwuELBZGwyqhtulQZr6BVClIhlRearE+99Kq1wwxSgigzzZG62?=
 =?us-ascii?Q?5DNnXaKHB6xwkcBULp5FA6j21ERULo+qho95Sg1SQYytd6nW3zb3VrWQHQYX?=
 =?us-ascii?Q?yaqNH5APiU2Edn6t9zQ6BMernwmNH9wRgLNTgVLgy1WKcuJVLMhF8tEDDMzT?=
 =?us-ascii?Q?S/jiLajm7wCbEMtcls+toal0ZvwseTxRNuUFKzxu4tVtBudTgoj2By25vAQ/?=
 =?us-ascii?Q?rGBKumWqde8JaxhoxTNooboQYKOUjpJk48jBucK1mK5Ne6Ik9Z7E3ossxUUP?=
 =?us-ascii?Q?4X0Yb83rd0kP3thnYij8CXyqVPv3+ubPnYWRsQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f1c699-f464-4563-c59a-08dc1062f284
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 16:00:34.1180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9970

From: kirill.shutemov@linux.intel.com <kirill.shutemov@linux.intel.com> Sen=
t: Monday, January 8, 2024 5:08 AM
>=20
> On Fri, Jan 05, 2024 at 10:30:23AM -0800, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > In preparation for temporarily marking pages not present during a
> > transition between encrypted and decrypted, use slow_virt_to_phys()
> > in the hypervisor callback. As long as the PFN is correct,
> > slow_virt_to_phys() works even if the leaf PTE is not present.
> > The existing functions that depend on vmalloc_to_page() all
> > require that the leaf PTE be marked present, so they don't work.
> >
> > Update the comments for slow_virt_to_phys() to note this broader usage
> > and the requirement to work even if the PTE is not marked present.
> >
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> >  arch/x86/hyperv/ivm.c        |  9 ++++++++-
> >  arch/x86/mm/pat/set_memory.c | 13 +++++++++----
> >  2 files changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> > index 02e55237d919..8ba18635e338 100644
> > --- a/arch/x86/hyperv/ivm.c
> > +++ b/arch/x86/hyperv/ivm.c
> > @@ -524,7 +524,14 @@ static bool hv_vtom_set_host_visibility(unsigned
> long kbuffer, int pagecount, bo
> >  		return false;
> >
> >  	for (i =3D 0, pfn =3D 0; i < pagecount; i++) {
> > -		pfn_array[pfn] =3D virt_to_hvpfn((void *)kbuffer + i * HV_HYP_PAGE_S=
IZE);
> > +		/*
> > +		 * Use slow_virt_to_phys() because the PRESENT bit has been
> > +		 * temporarily cleared in the PTEs.  slow_virt_to_phys() works
> > +		 * without the PRESENT bit while virt_to_hvpfn() or similar
> > +		 * does not.
> > +		 */
> > +		pfn_array[pfn] =3D slow_virt_to_phys((void *)kbuffer +
> > +					i * HV_HYP_PAGE_SIZE) >> HV_HYP_PAGE_SHIFT;
>=20
> I think you can make it much more readable by introducing few variables:
>=20
> 		virt =3D (void *)kbuffer + i * HV_HYPPAGE_SIZE;
> 		phys =3D slow_virt_to_phys(virt);
> 		pfn_array[pfn] =3D phys >> HV_HYP_PAGE_SHIFT;
>=20

Agreed.  I'll do this in the next version.

Michael

