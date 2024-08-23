Return-Path: <linux-hyperv+bounces-2826-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8105695D7E7
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 22:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732D11C21C87
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 20:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41A81C174A;
	Fri, 23 Aug 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZxgpF3ro"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010001.outbound.protection.outlook.com [52.103.13.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E851925B9;
	Fri, 23 Aug 2024 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724445683; cv=fail; b=klciWa6Swdvb/G60+OpNu+5xK71MLO4La8vFb81r5lRPa01IKn0dH/bXzEHr2+Zg8D/dj7/+hDJJ8l+NgMBNZ5vZz6SPtvImcm/5bTM2YQ0ThGTq7cTFwdBVe8JN/jSRI/jCfwCP/9DjOepz3uaivpurV06Xg2udICevEeoMGBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724445683; c=relaxed/simple;
	bh=out1fCi5a6fxoVcxQxFUn+XnPalgpziQb+qCmqUPO7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iTJq/X5VdOv47vSFdWNcBo84ccoNbY3eKVR5zbjcejF4e5unrN0WEqyCaJtvbKDR8vZpdh4DLGWQY1d1OhBdgNxe2kb8iA0r0RVm2k0AXuzk4JcZ1di90fCR1FmnQG8rmmG1MNxJ6iGJa44shmmf+FKoX4fdIlsmuzZCiXcn4QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZxgpF3ro; arc=fail smtp.client-ip=52.103.13.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDDPerl6j6pzVGz10JFBag37ikgGXqCm3743Pm/YwVgrOlxLZFYpolxEZLArXic3tbtEKPQTT9Iv08L/1djCHoGhyrBH4Sc99KL33UWtVA7Iu9q26d1H49MSzGX+k7EOvVRZFBiT9cKb5KrOvwls1hwEqr842ZdX0yFDNsaEPj9lvjBahaksvnRmuq4ix3sFR7VnW1GP34euJj8YCbvEN56jxoQIlju7iXiMMD35Vc4F++yHlnJPvB9JIK7CfgN1xh5va3MbWKcEzhvkXjbBlI8qN+SwEb2SC3Z/pSqLgd/Ejhq0KbMVeBUa7z1fqOhHlxmpK3Z5I2bILdSQ57uFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CLbdKsmETj7Zjme/QgRHe3eCRFhXy5UlK/rodZ7ujE=;
 b=eavhxMn963M8tAi34eVihwiiV/+AlZI+m3TQvz2qlRA/TiSmposSHgOjVpJ6sPBDRp6lJTfeAa+2azVmaXUliIDGGkJceLofkDHDbVuHuKwc0fybcntMAgyO0BzyWrXEikhWiYxW+oSJclLfBbSpH1QoSqulR4G+9aeAC00R9n+om6njSvXdANejkhxE2k1NPzLGdugENaGz1Tmfn0D4wn8f4VETReHgmXJkdW/IxhvUajrYhOfRWE5TaAjz5Vv+o7ousF3m8P8UNa+xTmzJR+iO1bjIEi6QeMd/PJTaBlQjrvEoYoGlLTzTCT93hKUKuYrySr9T3r+PntkDieXDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CLbdKsmETj7Zjme/QgRHe3eCRFhXy5UlK/rodZ7ujE=;
 b=ZxgpF3rofKec1L0JTBzpPGQyP9eRCGo91oHv8Z++UAPqKuZ1ZN7ndKTdN3bA+W7wXcfmuBgp6vVa4o29OPqVh1RljG468UQoiV33u0QNghSam/ojVEW63gWBkDe1+pJ122v/UnNvm5kBQgIMKihL8RiQwomTNeUnO02MvcxgvtvDOynjHdLweZv/4LGNTqb3i1L8MCVcEjQ9RjnrwdTF6GgWj83WhRgtkI2bpGXJg5f16ktgKyhgRNMVpkJwgOGPAtdDz7rPlTnWw0B9ICmCoZ9tWahu6gzON/JUsFjS45TxXcKlcjyYy2oVLGIBdZAbJcTugCCA+5y8n+T5y8zxEw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6962.namprd02.prod.outlook.com (2603:10b6:a03:235::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.22; Fri, 23 Aug
 2024 20:41:15 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Fri, 23 Aug 2024
 20:41:15 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>,
	"mhkelley58@gmail.com" <mhkelley58@gmail.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: RE: [RFC 1/7] swiotlb: Introduce swiotlb throttling
Thread-Topic: [RFC 1/7] swiotlb: Introduce swiotlb throttling
Thread-Index: AQHa9MKM26mfOAwU3Uynu26GRjjevLI0dhSAgADGoEA=
Date: Fri, 23 Aug 2024 20:41:15 +0000
Message-ID:
 <SN6PR02MB4157AE3FA2E0D2227CC94CC0D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240822183718.1234-2-mhklinux@outlook.com>
 <20240823094101.07ba5e0f@meshulam.tesarici.cz>
In-Reply-To: <20240823094101.07ba5e0f@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [SDi9jDitXVNmDNt2jwur3fZw2PQlNotp]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6962:EE_
x-ms-office365-filtering-correlation-id: bcba6a09-d250-478d-fd28-08dcc3b3eeeb
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|15080799003|461199028|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 EnmWFbQmu0JqJyxI/WMbb0eoVif+59BQeeSQA82nze9HX2tfMPsT/5ud/i1Mnh5PiHPD2mwX+IxWBZLxA777N6RANrwfMcehhg48KXLuMMt/cBoAgGm+3HETcqSAzI0tZO4KM4A3eFszadLzKh3SBOXyc7bAJ6xuiWMt6V7CZj2gJmwoTZPN2KxuaQlAa1k+9NzGvjNKAovGRi80Alv7PYpl5QntikGSclvUhb0nGRMag4qW1Z4f7/pT4eo9RIBqrAsevjjm6t5y9+aqZ1jrVnfieRzK+jPwdzBqmjlSO4jxTPUmV7Aj3H7FOKTqKkKFQYPHpM2kZS3LTifACuslpoy62SXVW1VbXJg//Ro/sU5CtVhCJGLA57SvX1kSPYDk8gF07aF/PV6kJ/FULcFvIVZzRMVqitZLyy3XzkmnzVKL13NG1HibQjqOuy/YOTdYuZikqcetuCqhOMWQpMM5IzTxjfAZrnsk/yjjvJXEQ6uCKQPEna/4MhFYN9wpVxU6Q/cL0NXBJ6iLJEoePuI4m/Yc0AwoBWLacgZd+COGZFyKfbfZo/LlB14s2wsHag3bgqDb+Z93MDfXAC6YK60abDVqocrkgwb60z0O5LloxHskd37zfuM6fkWaSpUwuOR4MNF9WlpAt1nmjP+lQUIuSib3lFbPLEKeo/+GsrsNYnFQyFm8BcxmhJTeBv2TMJB8
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?8aZ1RrbIx1c9zq+Z7zNbNmQfMB2jYc7k3sN3sD3fhIdoCowT571FmMoCR8?=
 =?iso-8859-2?Q?nnrx1Vz9F42jqmH7sV7mdYntXATNasQI+HVx7zaXeRpFfnT93nfrZR0UwG?=
 =?iso-8859-2?Q?8CJz3Ry/gdZ2ut0swGc+Q9iWb7oQDOGvtXc028QW1uc+DeOQvlyfyzsUYg?=
 =?iso-8859-2?Q?Y14/DxxGDzFTMh6JDdwBrkzdiWw9RjlzUph/RROIRgyvfOH3UNn1onx4Il?=
 =?iso-8859-2?Q?sb4wpFJNGp+Qh7nyqCUhL36G1B1FPj2QB1RGy/DfqM2Sk9DqmmUVSmTeSk?=
 =?iso-8859-2?Q?67PYa/lHFeaBWBmCBlQkNm6w1wwI8A47v4J1whh8iT/8QJ5J25oWQooown?=
 =?iso-8859-2?Q?QbfHOfFCoXn5C6MbEIbbYeAUSzrNAlIMT+bSDU/3F+zoDVcmFzVPBzZKwh?=
 =?iso-8859-2?Q?GUDmyM2HKsI0a+40ge1CDbYiOlqSegph8/Ip83SWekZ1ZSCMC6lO7NovWQ?=
 =?iso-8859-2?Q?PHiSqXza/gg631EsKn6t1tc+JyBCno93WIp2vSbZkEwDif5Nl3igS1Bsu0?=
 =?iso-8859-2?Q?eHTVrisvUs10/NkFB3tdz4W6xnXOx/QupweDYPqKX77LhC6/qgKWevJ9/m?=
 =?iso-8859-2?Q?MpdvWKMPMGM1tfo4a2hoCpznTV6FFPo0KINyV7t75CV2jqItB2VfRyHGWH?=
 =?iso-8859-2?Q?E/O5gHW6eqaMmT103TQHT96Xl8k9nC1g0eY8rVP1+EzQ0PIzo+rWMooMg2?=
 =?iso-8859-2?Q?JxcazGovXe61CqpiufhWR+atW/lSIyQFjJ+CBlLtT06t+vmXv1hi7vK1Fb?=
 =?iso-8859-2?Q?7x1nbCryNpf1YneAyIobImpCyf5ZdcdcHsOjGrGLfPWSJAqFjDFJGqN80J?=
 =?iso-8859-2?Q?h0wfec1mSxQNQyJ23elX/oTEpuInvklKJrsvT/SR3hyjTa3A8SfKTmC1nc?=
 =?iso-8859-2?Q?No31xDdNQsvjVVtnGHDfr0Q6oXof0Cu6YmQektC8LpP+knlkhxl2mcoObl?=
 =?iso-8859-2?Q?2Geynx5d0M1rNdGUFGXsILhGYgzgGPYWFfH2loKsdRg72sFVYbOeQNEdR3?=
 =?iso-8859-2?Q?E8K4F4lmS8XaydxAhenXr1XWlKzRw4toNKab9lRmCON32H/tzEndN8FEIX?=
 =?iso-8859-2?Q?nLOHUAkoHiebei5aRkekLn2BDYg4I/b6Km36ZR7nals48KYWJHwCP3ud2+?=
 =?iso-8859-2?Q?r+i++xNkWFPsFgG48w8FJpJp6HGsHYTzqVCG6pLWXSjSKc58tpHOY1TdNO?=
 =?iso-8859-2?Q?J1CzkrW9gdUkTV3hrtDWX8k0ZtcDVInA0EVk+C3krS8OyBfPRiVQlXAb8W?=
 =?iso-8859-2?Q?UCAZ3fq0bDk02o+1oxSm6Q6AUYzTbCWEgJ+L8fyD0=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bcba6a09-d250-478d-fd28-08dcc3b3eeeb
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 20:41:15.4551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6962

From: Petr Tesa=F8=EDk <petr@tesarici.cz> Sent: Friday, August 23, 2024 12:=
41 AM
>=20
> On Thu, 22 Aug 2024 11:37:12 -0700
> mhkelley58@gmail.com wrote:
>=20
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > Implement throttling of swiotlb map requests. Because throttling requir=
es
> > temporarily pending some requests, throttling can only be used by map
> > requests made in contexts that can block. Detecting such contexts at
> > runtime is infeasible, so device driver code must be updated to add
> > DMA_ATTR_MAY_BLOCK on map requests done in a context that can block.
> > Even if a map request is throttled, the corresponding unmap request wil=
l
> > never block, so unmap has no context restrictions, just like current co=
de.
> > If a swiotlb map request does *not* have DMA_ATTR_MAY_BLOCK, no throttl=
ing
> > is done and there is no functional change.
> >
> > The goal of throttling is to reduce peak usage of swiotlb memory,
> > particularly in environments like CoCo VMs which must use bounce buffer=
ing
> > for all DMA I/O. These VMs currently allocate up to 1 GiB for swiotlb
> > memory to ensure that it isn't exhausted. But for many workloads, this
> > memory is effectively wasted because it can't be used for other purpose=
s.
> > Throttling can lower the swiotlb memory requirements without unduly rai=
sing
> > the risk of exhaustion, thus making several hundred MiBs of additional
> > memory available for general usage.
> >
> > The high-level implementation is as follows:
> >
> > 1.  Each struct io_tlb_mem has a semaphore that is initialized to 1.  A
> > semaphore is used instead of a mutex because the semaphore likely won't
> > be released by the same thread that obtained it.
> >
> > 2. Each struct io_tlb_mem has a swiotlb space usage level above which
> > throttling is done. This usage level is initialized to 70% of the total
> > size of that io_tlb_mem, and is tunable at runtime via /sys if
> > CONFIG_DEBUG_FS is set.
> >
> > 3. When swiotlb_tbl_map_single() is invoked with throttling allowed, if
> > the current usage of that io_tlb_mem is above the throttle level, the
> > semaphore must be obtained before proceeding. The semaphore is then
> > released by the corresponding swiotlb unmap call. If the semaphore is
> > already held when swiotlb_tbl_map_single() must obtain it, the calling
> > thread blocks until the semaphore is available. Once the thread obtains
> > the semaphore, it proceeds to allocate swiotlb space in the usual way.
> > The swiotlb map call saves throttling information in the io_tlb_slot, a=
nd
> > then swiotlb unmap uses that information to determine if the semaphore
> > is held. If so, it releases the semaphore, potentially allowing a
> > queued request to proceed. Overall, the semaphore queues multiple waite=
rs
> > and wakes them up in the order in which they waited. Effectively, the
> > semaphore single threads map/unmap pairs to reduce peak usage.
> >
> > 4. A "low throttle" level is also implemented and initialized to 65% of
> > the total size of the io_tlb_mem. If the current usage is between the
> > throttle level and the low throttle level, AND the semaphore is held, t=
he
> > requestor must obtain the semaphore. Consider if throttling occurs, so
> > that one map request holds the semaphore, and three others are queued
> > waiting for the semaphore. If swiotlb usage then drops because of
> > unrelated unmap's, a new incoming map request may not get throttled, an=
d
> > bypass the three requests waiting in the semaphore queue. There's not
> > a forward progress issue because the requests in the queue will complet=
e
> > as long as the underlying I/Os make forward progress. But to somewhat
> > address the fairness issue, the low throttle level provides hysteresis
> > in that new incoming requests continue to queue on the semaphore as lon=
g
> > as used swiotlb memory is above that lower limit.
> >
> > 5. SGLs are handled in a subsequent patch.
> >
> > In #3 above the check for being above the throttle level is an
> > instantaneous check with no locking and no reservation of space, to avo=
id
> > atomic operations. Consequently, multiple threads could all make the ch=
eck
> > and decide they are under the throttle level. They can all proceed with=
out
> > obtaining the semaphore, and potentially generate a peak in usage.
> > Furthermore, other DMA map requests that don't have throttling enabled
> > proceed without even checking, and hence can also push usage toward a p=
eak.
> > So throttling can blunt and reduce peaks in swiotlb memory usage, but
> > does it not guarantee to prevent exhaustion.
> >
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> >  include/linux/dma-mapping.h |   8 +++
> >  include/linux/swiotlb.h     |  15 ++++-
> >  kernel/dma/Kconfig          |  13 ++++
> >  kernel/dma/swiotlb.c        | 114 ++++++++++++++++++++++++++++++++----
> >  4 files changed, 136 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index f693aafe221f..7b78294813be 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -62,6 +62,14 @@
> >   */
> >  #define DMA_ATTR_PRIVILEGED		(1UL << 9)
> >
> > +/*
> > + * DMA_ATTR_MAY_BLOCK: Indication by a driver that the DMA map request=
 is
> > + * allowed to block. This flag must only be used on DMA map requests m=
ade in
> > + * contexts that allow blocking. The corresponding unmap request will =
not
> > + * block.
> > + */
> > +#define DMA_ATTR_MAY_BLOCK		(1UL << 10)
> > +
> >  /*
> >   * A dma_addr_t can hold any valid DMA or bus address for the platform=
.  It can
> >   * be given to a device to use as a DMA source or target.  It is speci=
fic to a
> > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > index 3dae0f592063..10d07d0ee00c 100644
> > --- a/include/linux/swiotlb.h
> > +++ b/include/linux/swiotlb.h
> > @@ -89,6 +89,10 @@ struct io_tlb_pool {
> >   * @defpool:	Default (initial) IO TLB memory pool descriptor.
> >   * @pool:	IO TLB memory pool descriptor (if not dynamic).
> >   * @nslabs:	Total number of IO TLB slabs in all pools.
> > + * @high_throttle: Slab count above which requests are throttled.
> > + * @low_throttle: Slab count abouve which requests are throttled when
> > + *		throttle_sem is already held.
> > + * @throttle_sem: Semaphore that throttled requests must obtain.
> >   * @debugfs:	The dentry to debugfs.
> >   * @force_bounce: %true if swiotlb bouncing is forced
> >   * @for_alloc:  %true if the pool is used for memory allocation
> > @@ -104,10 +108,17 @@ struct io_tlb_pool {
> >   *		in debugfs.
> >   * @transient_nslabs: The total number of slots in all transient pools=
 that
> >   *		are currently used across all areas.
> > + * @high_throttle_count: Count of requests throttled because high_thro=
ttle
> > + *		was exceeded.
> > + * @low_throttle_count: Count of requests throttled because low_thrott=
le was
> > + *		exceeded and throttle_sem was already held.
> >   */
> >  struct io_tlb_mem {
> >  	struct io_tlb_pool defpool;
> >  	unsigned long nslabs;
> > +	unsigned long high_throttle;
> > +	unsigned long low_throttle;
> > +	struct semaphore throttle_sem;
>=20
> Are these struct members needed if CONFIG_SWIOTLB_THROTTLE is not set?

They are not needed. But I specifically left them unguarded because
the #ifdef just clutters things here (and in the code as needed to make
things compile) without adding any real value. The amount of memory
saved is miniscule as there's rarely more than one instance of io_tbl_mem.

>=20
> >  	struct dentry *debugfs;
> >  	bool force_bounce;
> >  	bool for_alloc;
> > @@ -118,11 +129,11 @@ struct io_tlb_mem {
> >  	struct list_head pools;
> >  	struct work_struct dyn_alloc;
> >  #endif
> > -#ifdef CONFIG_DEBUG_FS
>=20
> I think this should not be removed but changed to:
> #if defined(CONFIG_DEBUG_FS) || defined(CONFIG_SWIOTLB_THROTTLE)

Same thought here.

>=20
> >  	atomic_long_t total_used;
> >  	atomic_long_t used_hiwater;
> >  	atomic_long_t transient_nslabs;
> > -#endif
> > +	unsigned long high_throttle_count;
> > +	unsigned long low_throttle_count;
>=20
> And these two should be guarded by #ifdef CONFIG_SWIOTLB_THROTTLE.

And here.

>=20
> >  };
> >
> >  struct io_tlb_pool *__swiotlb_find_pool(struct device *dev, phys_addr_=
t paddr);
> > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> > index c06e56be0ca1..d45ba62f58c8 100644
> > --- a/kernel/dma/Kconfig
> > +++ b/kernel/dma/Kconfig
> > @@ -103,6 +103,19 @@ config SWIOTLB_DYNAMIC
> >
> >  	  If unsure, say N.
> >
> > +config SWIOTLB_THROTTLE
> > +	bool "Throttle DMA map requests from enabled drivers"
> > +	default n
> > +	depends on SWIOTLB
> > +	help
> > +	  Enable throttling of DMA map requests to help avoid exhausting
> > +	  bounce buffer space, causing request failures. Throttling
> > +	  applies only where the calling driver has enabled blocking in
> > +	  DMA map requests. This option is most useful in CoCo VMs where
> > +	  all DMA operations must go through bounce buffers.
>=20
>=20
> If I didn't know anything about the concept, this description would
> confuse me... The short description should be something like: "Throttle
> the use of DMA bounce buffers." Do not mention "enabled drivers" here;
> it's sufficient to mention the limitations in the help text.
>=20
> In addition, the help text should make it clear that this throttling
> does not apply if bounce buffers are not needed; except for CoCo VMs,
> this is the most common case. I mean, your description does mention CoCo
> VMs, but e.g. distributions may wonder what the impact would be if they
> enable this option and the kernel then runs on bare metal.

OK. I'll work on the text per your comments.

>=20
> > +
> > +	  If unsure, say N.
> > +
> >  config DMA_BOUNCE_UNALIGNED_KMALLOC
> >  	bool
> >  	depends on SWIOTLB
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index df68d29740a0..940b95cf02b7 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/init.h>
> >  #include <linux/memblock.h>
> >  #include <linux/mm.h>
> > +#include <linux/semaphore.h>
> >  #include <linux/pfn.h>
> >  #include <linux/rculist.h>
> >  #include <linux/scatterlist.h>
> > @@ -71,12 +72,15 @@
> >   *		from each index.
> >   * @pad_slots:	Number of preceding padding slots. Valid only in the fi=
rst
> >   *		allocated non-padding slot.
> > + * @throttled:  Boolean indicating the slot is used by a request that =
was
> > + *		throttled. Valid only in the first allocated non-padding slot.
> >   */
> >  struct io_tlb_slot {
> >  	phys_addr_t orig_addr;
> >  	size_t alloc_size;
> >  	unsigned short list;
> > -	unsigned short pad_slots;
> > +	u8 pad_slots;
> > +	u8 throttled;
>=20
> I'm not sure this flag is needed for each slot.
>=20
> SWIOTLB mappings should be throttled when the total SWIOTLB usage is
> above a threshold. Conversely, it can be unthrottled when the total
> usage goes below a threshold, and it should not matter if that happens
> due to an unmap of the exact buffer which previously pushed the usage
> over the edge, or due to an unmap of any other unrelated buffer.

I think I understand what you are proposing. But I don't see a way
to make it work without adding global synchronization beyond
the current atomic counter for the number of used slabs. At a minimum
we would need a global spin lock instead of the atomic counter. The spin
lock would protect the (non-atomic) slab count along with some other
accounting, and that's more global references. As described in the
cover letter, I was trying to avoid doing that.

If you can see how to do what you propose with just the current
atomic counter, please describe.

Michael

>=20
> I had a few more comments to the rest of this patch, but they're moot
> if this base logic gets redone.
>=20
> Petr T
>=20
> >  };
> >
> >  static bool swiotlb_force_bounce;
> > @@ -249,6 +253,31 @@ static inline unsigned long nr_slots(u64 val)
> >  	return DIV_ROUND_UP(val, IO_TLB_SIZE);
> >  }
> >
> > +#ifdef CONFIG_SWIOTLB_THROTTLE
> > +static void init_throttling(struct io_tlb_mem *mem)
> > +{
> > +	sema_init(&mem->throttle_sem, 1);
> > +
> > +	/*
> > +	 * The default thresholds are somewhat arbitrary. They are
> > +	 * conservative to allow space for devices that can't throttle and
> > +	 * because the determination of whether to throttle is done without
> > +	 * any atomicity. The low throttle exists to provide a modest amount
> > +	 * of hysteresis so that the system doesn't flip rapidly between
> > +	 * throttling and not throttling when usage fluctuates near the high
> > +	 * throttle level.
> > +	 */
> > +	mem->high_throttle =3D (mem->nslabs * 70) / 100;
> > +	mem->low_throttle =3D (mem->nslabs * 65) / 100;
> > +}
> > +#else
> > +static void init_throttling(struct io_tlb_mem *mem)
> > +{
> > +	mem->high_throttle =3D 0;
> > +	mem->low_throttle =3D 0;
> > +
> > +#endif
> > +
> >  /*
> >   * Early SWIOTLB allocation may be too early to allow an architecture =
to
> >   * perform the desired operations.  This function allows the architect=
ure to
> > @@ -415,6 +444,8 @@ void __init swiotlb_init_remap(bool addressing_limi=
t,
> unsigned int flags,
> >
> >  	if (flags & SWIOTLB_VERBOSE)
> >  		swiotlb_print_info();
> > +
> > +	init_throttling(&io_tlb_default_mem);
> >  }
> >
> >  void __init swiotlb_init(bool addressing_limit, unsigned int flags)
> > @@ -511,6 +542,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
> >  	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
> >  				 nareas);
> >  	add_mem_pool(&io_tlb_default_mem, mem);
> > +	init_throttling(&io_tlb_default_mem);
> >
> >  	swiotlb_print_info();
> >  	return 0;
> > @@ -947,7 +979,7 @@ static unsigned int wrap_area_index(struct io_tlb_p=
ool
> *mem, unsigned int index)
> >   * function gives imprecise results because there's no locking across
> >   * multiple areas.
> >   */
> > -#ifdef CONFIG_DEBUG_FS
> > +#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_SWIOTLB_THROTTLE)
> >  static void inc_used_and_hiwater(struct io_tlb_mem *mem, unsigned int =
nslots)
> >  {
> >  	unsigned long old_hiwater, new_used;
> > @@ -966,14 +998,14 @@ static void dec_used(struct io_tlb_mem *mem, unsi=
gned
> int nslots)
> >  	atomic_long_sub(nslots, &mem->total_used);
> >  }
> >
> > -#else /* !CONFIG_DEBUG_FS */
> > +#else /* !CONFIG_DEBUG_FS && !CONFIG_SWIOTLB_THROTTLE*/
> >  static void inc_used_and_hiwater(struct io_tlb_mem *mem, unsigned int =
nslots)
> >  {
> >  }
> >  static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
> >  {
> >  }
> > -#endif /* CONFIG_DEBUG_FS */
> > +#endif /* CONFIG_DEBUG_FS || CONFIG_SWIOTLB_THROTTLE */
> >
> >  #ifdef CONFIG_SWIOTLB_DYNAMIC
> >  #ifdef CONFIG_DEBUG_FS
> > @@ -1277,7 +1309,7 @@ static int swiotlb_find_slots(struct device *dev,
> phys_addr_t orig_addr,
> >
> >  #endif /* CONFIG_SWIOTLB_DYNAMIC */
> >
> > -#ifdef CONFIG_DEBUG_FS
> > +#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_SWIOTLB_THROTTLE)
> >
> >  /**
> >   * mem_used() - get number of used slots in an allocator
> > @@ -1293,7 +1325,7 @@ static unsigned long mem_used(struct io_tlb_mem *=
mem)
> >  	return atomic_long_read(&mem->total_used);
> >  }
> >
> > -#else /* !CONFIG_DEBUG_FS */
> > +#else /* !CONFIG_DEBUG_FS && !CONFIG_SWIOTLB_THROTTLE */
> >
> >  /**
> >   * mem_pool_used() - get number of used slots in a memory pool
> > @@ -1373,6 +1405,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device =
*dev,
> phys_addr_t orig_addr,
> >  	struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;
> >  	unsigned int offset;
> >  	struct io_tlb_pool *pool;
> > +	bool throttle =3D false;
> >  	unsigned int i;
> >  	size_t size;
> >  	int index;
> > @@ -1398,6 +1431,32 @@ phys_addr_t swiotlb_tbl_map_single(struct device=
 *dev,
> phys_addr_t orig_addr,
> >  	dev_WARN_ONCE(dev, alloc_align_mask > ~PAGE_MASK,
> >  		"Alloc alignment may prevent fulfilling requests with max
> mapping_size\n");
> >
> > +	if (IS_ENABLED(CONFIG_SWIOTLB_THROTTLE) && attrs &
> DMA_ATTR_MAY_BLOCK) {
> > +		unsigned long used =3D atomic_long_read(&mem->total_used);
> > +
> > +		/*
> > +		 * Determining whether to throttle is intentionally done without
> > +		 * atomicity. For example, multiple requests could proceed in
> > +		 * parallel when usage is just under the threshold, putting
> > +		 * usage above the threshold by the aggregate size of the
> > +		 * parallel requests. The thresholds must already be set
> > +		 * conservatively because of drivers that can't enable
> > +		 * throttling, so this slop in the accounting shouldn't be
> > +		 * problem. It's better than the potential bottleneck of a
> > +		 * globally synchronzied reservation mechanism.
> > +		 */
> > +		if (used > mem->high_throttle) {
> > +			throttle =3D true;
> > +			mem->high_throttle_count++;
> > +		} else if ((used > mem->low_throttle) &&
> > +					(mem->throttle_sem.count <=3D 0)) {
> > +			throttle =3D true;
> > +			mem->low_throttle_count++;
> > +		}
> > +		if (throttle)
> > +			down(&mem->throttle_sem);
> > +	}
> > +
> >  	offset =3D swiotlb_align_offset(dev, alloc_align_mask, orig_addr);
> >  	size =3D ALIGN(mapping_size + offset, alloc_align_mask + 1);
> >  	index =3D swiotlb_find_slots(dev, orig_addr, size, alloc_align_mask, =
&pool);
> > @@ -1406,6 +1465,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device =
*dev,
> phys_addr_t orig_addr,
> >  			dev_warn_ratelimited(dev,
> >  	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu =
(slots)\n",
> >  				 size, mem->nslabs, mem_used(mem));
> > +		if (throttle)
> > +			up(&mem->throttle_sem);
> >  		return (phys_addr_t)DMA_MAPPING_ERROR;
> >  	}
> >
> > @@ -1424,6 +1485,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device =
*dev,
> phys_addr_t orig_addr,
> >  	offset &=3D (IO_TLB_SIZE - 1);
> >  	index +=3D pad_slots;
> >  	pool->slots[index].pad_slots =3D pad_slots;
> > +	pool->slots[index].throttled =3D throttle;
> >  	for (i =3D 0; i < (nr_slots(size) - pad_slots); i++)
> >  		pool->slots[index + i].orig_addr =3D slot_addr(orig_addr, i);
> >  	tlb_addr =3D slot_addr(pool->start, index) + offset;
> > @@ -1440,7 +1502,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device =
*dev,
> phys_addr_t orig_addr,
> >  	return tlb_addr;
> >  }
> >
> > -static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_=
addr,
> > +static bool swiotlb_release_slots(struct device *dev, phys_addr_t tlb_=
addr,
> >  				  struct io_tlb_pool *mem)
> >  {
> >  	unsigned long flags;
> > @@ -1448,8 +1510,10 @@ static void swiotlb_release_slots(struct device =
*dev,
> phys_addr_t tlb_addr,
> >  	int index, nslots, aindex;
> >  	struct io_tlb_area *area;
> >  	int count, i;
> > +	bool throttled;
> >
> >  	index =3D (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
> > +	throttled =3D mem->slots[index].throttled;
> >  	index -=3D mem->slots[index].pad_slots;
> >  	nslots =3D nr_slots(mem->slots[index].alloc_size + offset);
> >  	aindex =3D index / mem->area_nslabs;
> > @@ -1478,6 +1542,7 @@ static void swiotlb_release_slots(struct device *=
dev,
> phys_addr_t tlb_addr,
> >  		mem->slots[i].orig_addr =3D INVALID_PHYS_ADDR;
> >  		mem->slots[i].alloc_size =3D 0;
> >  		mem->slots[i].pad_slots =3D 0;
> > +		mem->slots[i].throttled =3D 0;
> >  	}
> >
> >  	/*
> > @@ -1492,6 +1557,8 @@ static void swiotlb_release_slots(struct device *=
dev,
> phys_addr_t tlb_addr,
> >  	spin_unlock_irqrestore(&area->lock, flags);
> >
> >  	dec_used(dev->dma_io_tlb_mem, nslots);
> > +
> > +	return throttled;
> >  }
> >
> >  #ifdef CONFIG_SWIOTLB_DYNAMIC
> > @@ -1501,6 +1568,9 @@ static void swiotlb_release_slots(struct device *=
dev,
> phys_addr_t tlb_addr,
> >   * @dev:	Device which mapped the buffer.
> >   * @tlb_addr:	Physical address within a bounce buffer.
> >   * @pool:       Pointer to the transient memory pool to be checked and=
 deleted.
> > + * @throttled:	If the function returns %true, return boolean indicatin=
g
> > + *		if the transient allocation was throttled. Not set if the
> > + *		function returns %false.
> >   *
> >   * Check whether the address belongs to a transient SWIOTLB memory poo=
l.
> >   * If yes, then delete the pool.
> > @@ -1508,11 +1578,18 @@ static void swiotlb_release_slots(struct device=
 *dev,
> phys_addr_t tlb_addr,
> >   * Return: %true if @tlb_addr belonged to a transient pool that was re=
leased.
> >   */
> >  static bool swiotlb_del_transient(struct device *dev, phys_addr_t tlb_=
addr,
> > -		struct io_tlb_pool *pool)
> > +		struct io_tlb_pool *pool, bool *throttled)
> >  {
> > +	unsigned int offset;
> > +	int index;
> > +
> >  	if (!pool->transient)
> >  		return false;
> >
> > +	offset =3D swiotlb_align_offset(dev, 0, tlb_addr);
> > +	index =3D (tlb_addr - offset - pool->start) >> IO_TLB_SHIFT;
> > +	*throttled =3D pool->slots[index].throttled;
> > +
> >  	dec_used(dev->dma_io_tlb_mem, pool->nslabs);
> >  	swiotlb_del_pool(dev, pool);
> >  	dec_transient_used(dev->dma_io_tlb_mem, pool->nslabs);
> > @@ -1522,7 +1599,7 @@ static bool swiotlb_del_transient(struct device *=
dev,
> phys_addr_t tlb_addr,
> >  #else  /* !CONFIG_SWIOTLB_DYNAMIC */
> >
> >  static inline bool swiotlb_del_transient(struct device *dev,
> > -		phys_addr_t tlb_addr, struct io_tlb_pool *pool)
> > +		phys_addr_t tlb_addr, struct io_tlb_pool *pool, bool *throttled)
> >  {
> >  	return false;
> >  }
> > @@ -1536,6 +1613,8 @@ void __swiotlb_tbl_unmap_single(struct device *de=
v,
> phys_addr_t tlb_addr,
> >  		size_t mapping_size, enum dma_data_direction dir,
> >  		unsigned long attrs, struct io_tlb_pool *pool)
> >  {
> > +	bool throttled;
> > +
> >  	/*
> >  	 * First, sync the memory before unmapping the entry
> >  	 */
> > @@ -1544,9 +1623,11 @@ void __swiotlb_tbl_unmap_single(struct device *d=
ev,
> phys_addr_t tlb_addr,
> >  		swiotlb_bounce(dev, tlb_addr, mapping_size,
> >  						DMA_FROM_DEVICE, pool);
> >
> > -	if (swiotlb_del_transient(dev, tlb_addr, pool))
> > -		return;
> > -	swiotlb_release_slots(dev, tlb_addr, pool);
> > +	if (!swiotlb_del_transient(dev, tlb_addr, pool, &throttled))
> > +		throttled =3D swiotlb_release_slots(dev, tlb_addr, pool);
> > +
> > +	if (throttled)
> > +		up(&dev->dma_io_tlb_mem->throttle_sem);
> >  }
> >
> >  void __swiotlb_sync_single_for_device(struct device *dev, phys_addr_t =
tlb_addr,
> > @@ -1719,6 +1800,14 @@ static void swiotlb_create_debugfs_files(struct
> io_tlb_mem *mem,
> >  		return;
> >
> >  	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslab=
s);
> > +	debugfs_create_ulong("high_throttle", 0600, mem->debugfs,
> > +			&mem->high_throttle);
> > +	debugfs_create_ulong("low_throttle", 0600, mem->debugfs,
> > +			&mem->low_throttle);
> > +	debugfs_create_ulong("high_throttle_count", 0600, mem->debugfs,
> > +			&mem->high_throttle_count);
> > +	debugfs_create_ulong("low_throttle_count", 0600, mem->debugfs,
> > +			&mem->low_throttle_count);
> >  	debugfs_create_file("io_tlb_used", 0400, mem->debugfs, mem,
> >  			&fops_io_tlb_used);
> >  	debugfs_create_file("io_tlb_used_hiwater", 0600, mem->debugfs, mem,
> > @@ -1841,6 +1930,7 @@ static int rmem_swiotlb_device_init(struct reserv=
ed_mem
> *rmem,
> >  		INIT_LIST_HEAD_RCU(&mem->pools);
> >  #endif
> >  		add_mem_pool(mem, pool);
> > +		init_throttling(mem);
> >
> >  		rmem->priv =3D mem;
> >


