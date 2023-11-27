Return-Path: <linux-hyperv+bounces-1053-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8474C7F9707
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 02:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67740B209AF
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 01:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60C6807;
	Mon, 27 Nov 2023 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kV4YxyQ/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2089.outbound.protection.outlook.com [40.92.21.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B949C;
	Sun, 26 Nov 2023 17:06:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxkJdp0QRv/hMqZecdVzYfhXFjUlCUoY4cQn3np5omlij+F1431t5kPC0Cm4sakgbGkR2BUQCGTvacyqjkgmiSxlnQ/SGk+40Q/0xe5/rh2+uQpfPEDq8GrC2YRLZLbO4VGYXobeUTP7sd40zWS26ocSQq6Zgh8gQ5IwmECSWC5IRd7bDnLVu/TRujGsaVAsuxY81w0ZCQ4rMNBJM4SUIyVv4NBnq6MKYEXDA3ovS15fGbX0TqamKq0h+x9/uSyAnc6JVKD/M3ig14w/bw9QuoD/a3kdZAWA2lpjuLg8xk42AvJRPeoxrJtmn2HsLZhU2UhMYKDlqW4sDTZUje0PWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFYAwb2uHkRzfJiUT3Q5WIZy/cuNKmc5tHQfzHPzR1M=;
 b=aqXWnduc3ZtEsDsNDZ1VPkHomTSXiy2wDOnZqAXsrdXFobPRJRY5rZLmMTzSXz2fgLk/AHHlZTP2QI1scS7bTDK3mNfia9rtj1fL+oYv1k+eCsxBIylI23A30FFSsMuzEzlPleqI6YiNKUMXMZceLK4kB+l1pb4wnOWr6UBtvuU8YPrJbScYSTf2pL10vCJBvI06v3rNwOzJPM+BP8qx90B6KHg0o2b1g+GUWUEPUV0aDHFRfT1J90EeXJuxT9PWSBHr+IgjTf/xtF1fEUCc45rmQnc7ZXAyMGWxRh50qjYqTRdKASZ9nINCssYscD7GJceAh0LKjxIHotFWDva1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFYAwb2uHkRzfJiUT3Q5WIZy/cuNKmc5tHQfzHPzR1M=;
 b=kV4YxyQ/vQuFMxkfKtody0jFeObI8OkJDLGfF7J1D7uhlxnGr0esC9YmT9k+pp9oLpb5YUUGfJoXrQrl+fh9Q5jc//Zkm5O7uhRH02wpB0HTMFpN1ewNh0Oh8LFLKIoNqJUp6hSjHVBpRkEhmMaTtRo6v6yFqqT3hMlZJJskzxBqZ3gguuo8UEJEy2hSdM6SXKiYVhsLkDxrtcIQPQANU7GJsH2SfZDh6L5IIzHyWvi2bLx1qC5B5GFz3cFOrHXC+R9j7j0cKRGiMowct5s4xXTvwb+HRMR67y20kXNlz2erWPB3NfONn+LKpVGXY7Lve5dUWLGLcpAZ2ybo75LHog==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6859.namprd02.prod.outlook.com (2603:10b6:5:211::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 01:06:06 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 01:06:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "luto@kernel.org"
	<luto@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "urezki@gmail.com"
	<urezki@gmail.com>, "lstoakes@gmail.com" <lstoakes@gmail.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "jroedel@suse.de" <jroedel@suse.de>, "seanjc@google.com"
	<seanjc@google.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v2 3/8] x86/mm: Remove "static" from vmap_pages_range()
Thread-Topic: [PATCH v2 3/8] x86/mm: Remove "static" from vmap_pages_range()
Thread-Index: AQHaHMCcNHra+kumRUKExlyvEEqwbLCF4AyAgAEpOhCAAHuSgIAF2cCA
Date: Mon, 27 Nov 2023 01:06:06 +0000
Message-ID:
 <SN6PR02MB4157CF2A7C5064889843D79CD4BDA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
 <20231121212016.1154303-4-mhklinux@outlook.com>
 <ZV2e/6qTJDkjYbfY@infradead.org>
 <SN6PR02MB41571479B921621EDE3BE2EFD4B9A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZV7//Yjx6ngKSf0M@infradead.org>
In-Reply-To: <ZV7//Yjx6ngKSf0M@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [8sq0PsiZIh4OiZxFtOxeEFKLYajZBv4t]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6859:EE_
x-ms-office365-filtering-correlation-id: f9e86026-9ebc-435f-1284-08dbeee508ad
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uUczENZUO9tU8KLD4eO5/4JTMPNPddsExLkMHuBmza2d0sTIjV5lHDUU9QhIACQS9iJqsnDv0dZNNEgIGcRYua+SczxeXNBJWUxTVqdTVL5Xcz/LT9dlwt1OBspKO5vHaqsnrpYDNFLacYWtK/s1lK+i9fIMTP7kVHnRF0wfq1dmeqd1pZQ6S3h+oTvw2BX2C+DSrKEEsXulytpzwHgfiupEz71p/jeL38K/YwrZinqf85qOt31PKAZ6gUzh2WlVa1uJfiClVd8VHxqxqZZyxEHTF7hCChaK/qjQuu6jRt326GfyK0C/1gzgFh2Ij2QhkRHUtf5V6oY2mbQ4zVw05Hj/bfZjiddZwS0V8pPAwjrSSlZDw/HilQ8aKWxAqS0YUqpnYlbOgpE5rTtdCDP35UX0yeo3ha2FfKX5OsfezyRzyJ6PmirFW6S687Aq+uY7RYrE9/728Xe2Br6h8yTES4PMosxj2TkKyLYXSczOP5/oiOB4nPTqg7SH2hPTFPISsDKOfyIrU0/DnNiNFKRfuKq7iXGIRnG2WyaimK55jh/CkAbElyuR13R0c0PxpeWt
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QNm+2Y/9H9BB7qvg69Bb9JgxlHERT+21UEB0/HpEFAXEo0hkBMglPFWxaF02?=
 =?us-ascii?Q?UvXvy1gXsspLeE7Xx9k4DSv6T616ezIh+ynd831TTZLP57MGdAAR+ThXdF3f?=
 =?us-ascii?Q?9pML6cwrjbXn1+bhINM8Vf/87elx1aieCm/99bAwRiAN964h4Coep2t/qxpa?=
 =?us-ascii?Q?H6Z61MZ4t9xITThEVWYyyH4Xn8nBG5DMEkhjhn3dJlvMFIK8cyLPWpKDx7jp?=
 =?us-ascii?Q?FV41DSbkupMfJDHd/18I0jdijD2/SL4OefrIcRHUtn3Tij+sWT+1tcBtQcw3?=
 =?us-ascii?Q?v2p7jlS/jk1hEdA/2tuINH/tYRCTF6z0NA07/bcnKDgQrHpKjh/Xf6p0AxLG?=
 =?us-ascii?Q?olluCCnfqLHg1l1OyopHNItcLtsL5GGXLZcGLI7EYqlWmnmeA/CFO4LbADBb?=
 =?us-ascii?Q?neKYuDYlrn/z/sHmZCvPILk0elP8I9kESegKwT/13XS3QaCJaLFINJSlUt4j?=
 =?us-ascii?Q?RFR5WXys6Mxd/PyJ6vf5RWqyXxKybEPMMgB6wVcKJMAemB+Nef+4Zmusd2eb?=
 =?us-ascii?Q?GKQGkBHuxWp51pXshzXOjPI34a5RAEqO6ZTDDNeNCiwfRAt+akATzloks98x?=
 =?us-ascii?Q?Cn66onciJwI2MTKnZ2KWz/5BDy6YCANQm7RckIDYgzZnq0QBtXamnar3y3ny?=
 =?us-ascii?Q?AvEVHTq0UoDMaaDY8IcjySsojwTe+vcaYcFR2uS6RgGZA1HI4S1FsSsvbBhj?=
 =?us-ascii?Q?XFb5CbXxJygUBjP0D4fD+nja4A0YL/4fbWSVSFE+FPKC1eWBE/KTab8elza5?=
 =?us-ascii?Q?GUXBUyGfzt5bugQNSap8LpetHPvbeX7bLGkYvl6qfzt5IiNN8BS59qiWhQ7p?=
 =?us-ascii?Q?/z96y1zwxZd/G6Y+FrEummobaO6/Tjw0hka9GWo1oa+PSb5yIVCDLz/AQFsj?=
 =?us-ascii?Q?Eg6jeb8mbiBT73rc2jrBSGQ+eOEVwzR6AGUzfofmInM5mKvlKW81Spf7wcIb?=
 =?us-ascii?Q?Ymc5FUuacM2P2/BIgKHCaOJE4Udew1tFDvysXjZ8Y7enEED+ZzjhYgt6ejm4?=
 =?us-ascii?Q?3ClWJtCi29F5PeZs2o+5PF05pOGZyNDhwOIgBOd0bmP+jQNxul8O3JYRc5sA?=
 =?us-ascii?Q?OqoLOSg8QrFpyeVnjZECoBVNcEAghPuOBG7QKTI+r8l7chThz5xhp2MVMJ7g?=
 =?us-ascii?Q?/NbT196UaWh9r6SHmdlxkY50J3RsZQ0YUNcjtCOdr16vV93/ZudJewsjr8Yc?=
 =?us-ascii?Q?bmkRKH9EkQLE0er71pDjY1RiCa0lYY+7822PSA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e86026-9ebc-435f-1284-08dbeee508ad
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 01:06:06.3058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6859

From: Christoph Hellwig <hch@infradead.org> Sent: Wednesday, November 22, 2=
023 11:32 PM
>=20
> On Thu, Nov 23, 2023 at 12:24:49AM +0000, Michael Kelley wrote:
> > > I really do not want to expose vmap_pages_range.  Please try to come =
up
> > > with a good way to encapsulate your map at a certain address primitiv=
e
> > > and implement it in vmalloc.c.
> >
> > To clarify, is your concern narrowly about vmap_pages_range()
> > specifically?
>=20
> The prime concern is that it took a lot of effort to make
> vmap_pages_range static and remove all the abuses.  I absolutely
> object to undoing that.

OK, so I assume that means a new variant of vmap_pages_range(),
such as one that always sets the page_shift parameter to PAGE_SIZE,
is also disallowed because of the same potential for abuse.

So the only way to map a system memory page to a vmalloc
vaddr is via vmap() or some vmap() variant, which always
creates a new vmalloc area via get_vm_area().  I've done the
perf measurements, and that approach won't work for this use
case.  Independent of the alignment requirements, the churn in
creating and removing a lot of vmalloc areas has too much perf
impact.   The use case needs to create a single vmalloc area, and
then repeatedly map/unmap a page in that existing area.

I'll have to handle the top-level problem in this patch set in
a completely different way.

Michael

