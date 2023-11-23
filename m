Return-Path: <linux-hyperv+bounces-1031-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB167F5541
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 01:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C924B20C18
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 00:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED3563B;
	Thu, 23 Nov 2023 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WWuhZCoa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2013.outbound.protection.outlook.com [40.92.22.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4158E189;
	Wed, 22 Nov 2023 16:24:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuqLcjR3Zuzl/X345MeNCTPyYI1YOBIWSPE9IfkFMf7O3PDEVDg4CHsvQqFsPVnO++qvvpN+iXiKXRL3Ag7L4Y2drx8Q0h9ZCzhl3yqr0UZOTLRDpLEEW1R7RImUI85K5WmJSoL7FunOzNoYaBGFlGVF9U3sQTVoEk/Z17LFYn67wCejG/TdqvropKA5Elv63oJQhQVWpDoPJ4nsS8QMsokxiid1v5R37Agn/OJziZ3kmz00uhOS8wZXh0w8zpYUzA13WS3pu7pZeKPMSzdwsE0aRRdMNQMOY6yjLo2Pq/OPLRJnOinL9NUQ5HZhX2/5HELVugZipx2ZZaFkO3AKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFYuMfZuF9noQQfdnQCzi87xAPOBq7FJX5YtBGl5Vyk=;
 b=fmQ56rd38+BH6I2CdxUcAKiD0iFhRKzEYZxu1sYSgahAMtsNivkclKw3zoWvxBg7nn800rzVhl9ue179ml6l9SK8jtIJJE8ejgL/exUvXHzaZitWyJSXakgNyBM5N2mluM2qP/vijznw6ZWgJvRJDUOGn3u6EuZBYyxcJaWzrlx5M8bmqUs/8cFlsrbnclNKYZEotOMgK6v5YUUnaRSVweqndwDmfUS/sF12EgqclynZjT9qmPZtVrliqc5pfumz5lqQbgI7e5/6U5vck8I9gPKyGKkQ7nuWEKbgjxOw3rTjk06wNy9U/tMEvX9E0yheEjadmPTU549rTMQDsA8ltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFYuMfZuF9noQQfdnQCzi87xAPOBq7FJX5YtBGl5Vyk=;
 b=WWuhZCoaJLy9g0gvPWlaFRU+cEiYfBFcXtGKfM6ATPGVVqbPyBd4R0orc5iFmaThrIp+nVMBo5KFflIoqbN3f8USvFAnzGc/mjubftOukPLkKS50Kw2EJMCesXGQtBht/zsDhE3f18dLWWqg6hGUvnm+xtsCONauL7I9zIjFLOhRSt+r8PKNS3UkX3yJnE0/p/SCoCFBY3B1qVMKt6QqCj8IUF3IeJxGEuRrQaODkZhFUy3TdE1GUlz+HnsyEN6l+AXu80e85oB/Lf8EuZ1uZv3Idm6ZtWk1GDwEyknIxaa+zXbaaPsoCZTrPp6hw18EZx7Pqfb3Q9hItVzgRrLo+Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7295.namprd02.prod.outlook.com (2603:10b6:a03:292::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Thu, 23 Nov
 2023 00:24:49 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190%7]) with mapi id 15.20.7025.017; Thu, 23 Nov 2023
 00:24:49 +0000
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
Thread-Index: AQHaHMCcNHra+kumRUKExlyvEEqwbLCF4AyAgAEpOhA=
Date: Thu, 23 Nov 2023 00:24:49 +0000
Message-ID:
 <SN6PR02MB41571479B921621EDE3BE2EFD4B9A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
 <20231121212016.1154303-4-mhklinux@outlook.com>
 <ZV2e/6qTJDkjYbfY@infradead.org>
In-Reply-To: <ZV2e/6qTJDkjYbfY@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [pEL4nMtFZRRevAUIjVYH09Yi70BnciIL]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7295:EE_
x-ms-office365-filtering-correlation-id: f2b0e916-2c65-4bd2-9f28-08dbebba9a73
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 o8SATonuDUAy3rGIfwZeTByJVu5yjaPynZsQVldA0rbzCjYiXcxk0vLM70TeXdqBBF3cBlNH7+RgIei4WIg0KAOIwPujG3yXCESfmUQAe8SU+A9O63+jGv5cEcbiodxIFwoUKTtanhsf6FkCqk3khp11aS4s10zlk/If37bum/nOm2smWnwEDxhq6DthrBv1CO4OhKuhP/KhO3Xg549+N63sOA7bTPoAS+Yp9PmN16thN1XAM18UP/TgAhS1TGLzyxEjAol0iIf8HbWZiBZb/Z8Rd2oUWVmaFw4UtNOT9wi2+cXtUEVebHbXgKLH6BW6wGwDAKLLr1IKZ4xf5q4TQwrskO8UDupypWPRqqqZf+sBgM6BpJQw1TiHdM75ebRRM7+sfR17O1s3jvolft7wuaRosQmJODPfgbH0fgigkvG3eypqr1EakJFEoBmYMdRhY2QAGHn7887mKvSVhI8vfKIWn6rOeJxboE7XX+LRBJ6JDUdaR4V8UN7QKBO918Daws4sg+w+NSOU6mJH5lYWnBckLoNLmYyVC5wMhbcYKsPvAVS/UQge0C4XEiPGFZmD
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qUSW7lm16aQL0yw2K+cKqPTwfQaluAXqmzsoR5ApJBlwjeY20wb6d9OWywE3?=
 =?us-ascii?Q?2vdlPcix288TueDEzVRSp/t1aZ9OPNbfZQ4wT46uGWuqPIICwRGzTqR8SPxA?=
 =?us-ascii?Q?eb6Puzs1Ze5lmiSazaPUvOGeUhOt3ydgDl1JQn8NYgEYn2wyRbW2/cRdNuQn?=
 =?us-ascii?Q?RTK0t9YR5Utgc1GH1Vp24DVQX9E+FQQWlyvlVrE3oPOUX0TvBq+b/yzwvv4j?=
 =?us-ascii?Q?0Uf01ZV4ZswvpPnhZE9f1DV2rrLSWfFgUKEpSa7utW7uvJK6dOpPhIaJ91Hc?=
 =?us-ascii?Q?qF5h3PsMCgSMg1M+t4UxveLKVXuz7+UtV85w+52VGJpf+MXFvfwAPmYmN/vU?=
 =?us-ascii?Q?NDqfiUPloST9CCRRRLN9GwaC2ZUH3LvT5uPEudhFG0fjduoYPuV/gMJdadej?=
 =?us-ascii?Q?RahFMXU3FRI7Ofc2cGyO/+WZ7SUwQdP/UTR5DL2UFoU0u5ighEPS3EEe9WtI?=
 =?us-ascii?Q?N7BVSwDQ2EDRo1kx9W9JZos0SYBr6s9kxpdsPqQckD6cZToKoXba59LEONE5?=
 =?us-ascii?Q?hF4pAXW1/dO664vOBgV7TSnORdDRUX5ojJ2gMlcpNfJ5MfWRz5GYUvFREHvX?=
 =?us-ascii?Q?b8QaLYo2TFOUreNCVEqywxJ3bSx8xF6JNWh1xZXBWuAtBMsyLWJw6GzWJ1XH?=
 =?us-ascii?Q?R4t/NWqDGCDAc+DOKZfHi5RL6oAetM1TuGPdr+quN9vC3pwJBy4kAXteunWX?=
 =?us-ascii?Q?E+8wA6P9ETHwzVp1FflU2z01CJztwklHKSNe9ggWzD/g3G3GWXl0idxWsvvQ?=
 =?us-ascii?Q?uFEjVVxHNwZOexMoSTVc5D3WQDrqHe+Yy0mjvsAy6owDXkeVkqpzCPju4ItP?=
 =?us-ascii?Q?3GDxZsVmImjFO+eSNKYZQIJPdeJ9fHpLYqaQzofKA38pQYO5zZwMSAs8f991?=
 =?us-ascii?Q?c4ISM+2p5qcbYgh7gOLTGNHr43fhV60dJQiP9BmydyLXD6yfLjJpUa24Pm+x?=
 =?us-ascii?Q?NpvrVafPeO8qvxAMYJiOM++lj7d7852lZDvjSo0/WgGyahwUL05ClkuiulIQ?=
 =?us-ascii?Q?orHO5oM0Ksp+zv4IUnRARfclGr16PHUWZ9J0/Z1ts5m6NFlQB3DuBFECi7r1?=
 =?us-ascii?Q?s7kKqP2t/RKJ/cippCQ+Uu0F5n61KjUX7QVI4WM3blTpee2A0vffbZUeOy1H?=
 =?us-ascii?Q?t3EQJWHnLdWUpexzXRzEWjTmX2X4fW8HCzMzx/Dnb0HLSLHh61IDz/YzzY9Y?=
 =?us-ascii?Q?Gia3PL1pxo7W9MIOQh5qsjeBnZHODcgiTf3DtQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b0e916-2c65-4bd2-9f28-08dbebba9a73
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 00:24:49.0698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7295

From: Christoph Hellwig <hch@infradead.org> Sent: Tuesday, November 21, 202=
3 10:26 PM
>=20
> On Tue, Nov 21, 2023 at 01:20:11PM -0800, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > The mm subsystem currently provides no mechanism to map memory pages
> > to a specified virtual address range.  A virtual address range can be
> > allocated using get_vm_area(), but the only function available for
> > mapping memory pages to a caller-specified address in that range is
> > ioremap_page_range(), which is inappropriate for system memory.
> >
> > Fix this by allowing vmap_pages_range() to be used by callers outside
> > of vmalloc.c.
>=20
> I really do not want to expose vmap_pages_range.  Please try to come up
> with a good way to encapsulate your map at a certain address primitive
> and implement it in vmalloc.c.

To clarify, is your concern narrowly about vmap_pages_range()
specifically?  Or is your concern more generally about having two separate
steps as applied to system memory:  1) allocate the virtual address
space and 2) do the mapping?  The two separate steps are already
available for MMIO space.  Doing the equivalent for system memory
should be straightforward.

Conversely, combining the two steps into a single new vmap() variant
would be a little messy, but can probably be made to work.  This
combined approach will be less efficient since my use case does a single
allocation of virtual address space and repeatedly maps/unmaps the
same page in that space.  I would need to take some measurements
to see if the inefficiency actually matters.

Michael


