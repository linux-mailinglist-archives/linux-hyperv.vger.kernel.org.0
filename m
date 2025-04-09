Return-Path: <linux-hyperv+bounces-4844-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AFDA8273C
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Apr 2025 16:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC0FF7AEF9F
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Apr 2025 14:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E68265616;
	Wed,  9 Apr 2025 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HnM0UxxB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2090.outbound.protection.outlook.com [40.92.41.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE5264FAE;
	Wed,  9 Apr 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207832; cv=fail; b=XV2m4wH0L5WQT1hp6xsRB+0O3sYjaDzgdxfGPmU4p2DxT/hpdjlQbhCjyG3tRiQNl0nYXqR8LPEwkvzfINtIdofIpNZMdz8B6RGqyvzwjz9cqlsKjGfEVzE95fWHDlGJSSpslu/8ZoPAvFH1HSDXILQdx1yrMvPbQERqez2hGXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207832; c=relaxed/simple;
	bh=uY04//eVifJFoyZOhOTQo5LLhMxaZWNRqF8xyjvPYYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iqhn6zT6QiE3LSdln3X38d63upsL5nZE8RP/J6qDae/add8a5vplh+QqEM4+dFn1Ei6KnoarQn2WOG3Xtn0tSh2JfqmUvDooYNFTK9B9Kluy4PiU/Kz8F3nskWN95SwjWbE4drPIOB6Y0hW2YhncRcLLXvqmrMKg5Kw+k1FzZwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HnM0UxxB; arc=fail smtp.client-ip=40.92.41.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/1hx4tAj4w/27pwJMMWfuj3hfQ4BhQTHnHP9Y89qtE4C5KyCfVAyfvCVeYqAQNac2kPhN7FSDbTdPlo2AKEVAQq0CBxS2jN3lT9vVExghUgSg86aukTQEzm/bVxL5VjrqS7zwihY5Ltm523PyuOAHGqc5bZTamYYE/kcKNEukG6766pdmKadC/+/EGPua8mrVeeU11YwLuSFNhFz/KuUb2E8bquwGAJNHuj8HLLDTonzLAql9iCC243X9y6ZroreB2cj04fUFz8bkSmwMDWsG7pFgmFYW0G8p+b9QIkmlYtt+Ll9Jtc/hnnEmq+MJ++b4mhbMAJa+Vvy7ByB8X3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCMVoxbSXvNe4V8irsUyfTQofTXU5s8vGUTcVGNuzwo=;
 b=wlAR+552+5/tasu9oFDsaBTTwJehd2IILJxn5V4PpIYgOA17ade3qLVw5etxkij720it31qVHkIlND3GvWIs0eBnUW+YOhIXIrYEN0sHZoRNQpMgYOkO8ysaL40zrykCm2VnX7WQh0O9sBn8V9hG4xJgtSwo8B5pVNQTzU5AilgqjHEI/E4DmqgAhVdcUNTIrAuRfgiQjBDyM423A22XtMWUTzMam/8aB8ssdHEQ6m2XwdZniDYtszpiRpZZco5oxNGLHmIsgA/de0W1qpDXqQt/nYz0CmXcRe1XBoZzd1kHv6uAFlDbDiGrwkUAiTIUTKI0yMb8NLnfWzLtYuMwdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCMVoxbSXvNe4V8irsUyfTQofTXU5s8vGUTcVGNuzwo=;
 b=HnM0UxxBEZuw8D1F6dcz5xcFAHr7Eyds4GT+fT7WcwHcLJsnuxDU6ukZVEVgTRWfZuJepqpzzfO7zPlEHEoQmfGSNpj6m/QbCxAAKxrVrx9nUmEIZX/zrIWlFuZempEKRoJ666yccIfCBnSVyLf4OQnvPuKOjYQ1G1N8L/C7tSRno1y/EoEVRQORGCcaOF6NupBu129r4jJ+QaQew/JUFdcYx81zS4hJwjPvsj6jXvwehs+Cw8C1pJCHczwi1PmQEiet0lfJBioE46c9K8CMNl9y51lHrkXZQKSa9F8/wda4cOkF8noNI9KGvEu4dAyOUzb603+y1a6A5AVwGX1VzQ==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by CY8PR02MB9105.namprd02.prod.outlook.com (2603:10b6:930:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 14:10:27 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 14:10:27 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Christoph Hellwig <hch@lst.de>
CC: "jayalk@intworks.biz" <jayalk@intworks.biz>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "deller@gmx.de" <deller@gmx.de>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "weh@microsoft.com" <weh@microsoft.com>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 1/3] mm: Export vmf_insert_mixed_mkwrite()
Thread-Topic: [PATCH 1/3] mm: Export vmf_insert_mixed_mkwrite()
Thread-Index: AQHbqLVG4gQYXeGx+0WuiyyYTOsIQrObKMgAgAAqdVA=
Date: Wed, 9 Apr 2025 14:10:26 +0000
Message-ID:
 <BN7PR02MB4148597D0495C631F6E3F8C0D4B42@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250408183646.1410-1-mhklinux@outlook.com>
 <20250408183646.1410-2-mhklinux@outlook.com> <20250409104942.GA5572@lst.de>
In-Reply-To: <20250409104942.GA5572@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|CY8PR02MB9105:EE_
x-ms-office365-filtering-correlation-id: c41ed9ca-c6de-477b-d3cb-08dd77704729
x-ms-exchange-slblob-mailprops:
 rYPt1fhvLTXc97ntej+WqDiQNM+UKxVkD/My9b8fGtqW5qsB6FnaRSISBlktcWvw/pGisxktPWO4kd7D78Aa0/bdHhE/TvrYGAPLK1AZ8QWCBsdceene8+jksbCZCLtptkXa9ncNElrLm/xgSD3GRFnE2WfdFDWI+NuT1/xXwUdyV/CqFM4e5wXCFnxWLc6Py1wGyC9fOvYO1ZPmRLpdg4IlrHGPb2l6n34tuB/w/gIVPKpvd64BRfpIKrs7T3724pMRgHei89AA9/wGZkUIes/VOTsN5KhGaeU/g5BxF4cvh5UBDjWEMJ+7mDl4x0TJ9O/q+tUD85K3UNCCwPr+7+IARQcopM9al4qc9zHuEbK2n7i3qIKDTORjXMiaUGGgH5LwmZEooxyPi6+nZgWARadpWOgTvNIRZSfozOBc+3BIWcYwoI/RzDjj+l/al851Ff4b3LFMp7modPm9Fq8XU93IsPbTaKghk+7UETN3t2X1+Uaj6jajuio/5+CUDiE9vDOv2HgGxZa8MG5L6BQn7PVEy9bReHDsZsaT0WtZyg3DTvySrrSmOrp7gMXOFWgTsfA6rKlTtZfK0yuqMOmdM/P+Yb88XoL4j25+ulO/1h6Mu6o5Em6m7JZGZT8JlWOtvceVu9ruGo81vG6WNW+pYHDRt2dXh1pHjg5bP1SHLpgj/4Rob1D6CfUqvD8w0gv78EYHTNfW2xDuzXsi5Vqjfw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|19110799003|8062599003|15080799006|3412199025|440099028|30101999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wHaLZrq0GgCAYEZM/dwaIkTPI/iDuBwNKMxVzHPAqrok86njgPSTZKJHFWy8?=
 =?us-ascii?Q?FnnVSAiCoH2ZSJx2ZZIlXQrGp6cXKmwyZoxccWohsRjP7CXp5YRRjjBljb0Q?=
 =?us-ascii?Q?leFdpa8Q3L3sdjasNrcWZDRSoQ7oiByUl4j8w59SHspQtdwm/0e3h+ZpaQ1J?=
 =?us-ascii?Q?MOw0k3Lo5KK4058bvSu+2UCJA/cAImJwFhOqv8KlSHiQ+o6wz6AxHZTJ9ELJ?=
 =?us-ascii?Q?8R06sr7HH/vBpbPGoW5z8lhvVGwzoxrxJTU7AuMsikoxR4rPCtOISveV8YYq?=
 =?us-ascii?Q?FvVDM00fMDuD9eJGDsZ7F6qT7JZgSEYx4SUNCwhrDsdWaOvYM+jTI9tXXqDI?=
 =?us-ascii?Q?I4E/fKBax368kG9MrPsfzg26M1hIB17hoVgZtqaULuG6LJfs31zAq9HP7pP5?=
 =?us-ascii?Q?2ZwIh0J3Hjj/vzGTCDKLLEysWb1lBHwHt98CwoVC4JSPWx/gWjQr7fnIKsmk?=
 =?us-ascii?Q?oPKadfz8AODlGbOxwgW/bgV99fTHSGju5pbHfkwpi+OXER1jEcovrMABZIbw?=
 =?us-ascii?Q?dTOKzVmVi6KXTtz0m7R5+zFiLMSt7mgpTFGhU/vN0fPWQ58P0Hicl7PhItJU?=
 =?us-ascii?Q?q6WolpX9WrMryZuhAzT7CxQ/YDR7urWxw/MJRXwFuxlLbOjp7VKQFpb/L0pN?=
 =?us-ascii?Q?STgSW6Npnv8BvrPURgZ++/+DU5xiytyXYq75+POd7nQg+iXfxjPBEET9yhWj?=
 =?us-ascii?Q?sskRg3b72YayXdUlhFeClXz2g6gdRCfQYYx/iqC5CV0WT3T8ipnQWSl42e73?=
 =?us-ascii?Q?spfuRZFuGZO5CmhAm7u1PgcL1dqmsjYyDkc15gf3fxu31fY72Qs42cVEg8/N?=
 =?us-ascii?Q?RkpC2zCFyglwORRCKhdYMiOxOuxVGJB9/nFKQok8qHpA67Ya/tSoT+XjLrrm?=
 =?us-ascii?Q?pZ2vW54pIrOm3lCPO9Vqy7ZETysaJNUmlL9IRqrqNmpuEBXZoUFra/BkUJpn?=
 =?us-ascii?Q?pQj+/kFys2w5HGM08INo3ASP5yiwXyPWsfHnRxFvpd0uhyhkrbNAPprYA8ax?=
 =?us-ascii?Q?2l0vRlq+hToSdxAlCQe+8scZqowsPWiWwuVHkKC3P/aPQUWewoQU0gRpeuTv?=
 =?us-ascii?Q?CAF5mPg1L+rIbrzqd9FqHU5UVDI+1UhN64enV+V1uRDNNJFl4Kw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?w+DsA+vtyVg8+F2BWb8d6X8LSybH0tpqN8UE++6QHB1vAn2kHNN0UsJ495zC?=
 =?us-ascii?Q?mgvhNO1oSZ18VAb3D2puYjGrVE3abVt4QgaaYbhuJqRY7oJHDCZ3zfK0cl99?=
 =?us-ascii?Q?Mt51Vfeb7fESvagZREGh1VUtSfYkNVq6SwucyKk+ljfIF75EJ+00Hc7Kzu6K?=
 =?us-ascii?Q?VZwFVUlq+PRfIfgEROwJ+reTUF9GDPE7WmsaLaHfvU3scU5QlU0aXzyoyekH?=
 =?us-ascii?Q?hKmjPJ16R0+9DgHVToMzPJSOMSKiFAY1512m2jWUy05+nv7hXggeM491q61M?=
 =?us-ascii?Q?VvlvRIQpNIKSM60iP5GcAa8BPhifRoRbesNydTZAYspN5ySR2KwjAEZMqgVx?=
 =?us-ascii?Q?d5FDL8IIT1IRkKaUrVBVVwntnvJ0P8QlNHXjhQLM7oL8DmoJCAjPiIdO49PE?=
 =?us-ascii?Q?XRK8SekkOKMjgZvxkbEo/onxFIZ1PpfKgR/yEFWgLe1u7ieCkqdvON9GY5KF?=
 =?us-ascii?Q?L7uYwlJQD9P9z7c2lZqVQXAztb+SnMKWjcQiR9BdwW/B+7RPOS3z7g1noYCG?=
 =?us-ascii?Q?lqP78ARs7IwTF6Hi5EUaaf1/aZPh6NqvpyCiuv1W3wvia0k15xYDVmbRNvgR?=
 =?us-ascii?Q?HMEOTrRxHHBUnKLJPuGvDFFHou1Lfp6QIvPht03L/8E09sbtq5bkZekrQuU4?=
 =?us-ascii?Q?1/sEFw+xd8YJCl4idOaq4dRvKK/Y9JbCfrSNChzd7W0SAehzKF8nZTaWavEV?=
 =?us-ascii?Q?H009K658UxwUxWs7jze/AF+X2b8iB9WvjEJAS+wb7QMUakr0ZWUM+McXMCwW?=
 =?us-ascii?Q?LwJE/BlZMEs3wRSPyuPZg6IbRjQf8B+Jf4hdJTGmnDDmqVL9XKfuDpu2+HhZ?=
 =?us-ascii?Q?0VqilOGHPU43Rkcbzl9K+CHG2Izn73GepsuKq/XiS+9T8K2j0+ENGhmVqDIN?=
 =?us-ascii?Q?D9H3jy5q4DGo6tMss3QXqZNAuAYcH1wJobUZ5k2Yy8JGTz53xvheVo74HodO?=
 =?us-ascii?Q?hDLDR8FuRQRokHhg0ls4tIOR/nQUERpnbHe6M7Do6Kizc+diiWCsqOI56TjH?=
 =?us-ascii?Q?ysrqmRnBCptT7rVZZkEuIoycbl1Nc47736bZxSRyfB1S3vFTEyrgGwPPhixd?=
 =?us-ascii?Q?MpzjPGtPUrUlKP3VZ//EduUiCiPko0VR0XQVtNcOAaWV72A5YGXX5a4Sxq18?=
 =?us-ascii?Q?YKo0FvBD52EyoIZPxG4kmcE/8lgANv6qFUEslrGmeR2RQ/hprL5JxXTCyGZQ?=
 =?us-ascii?Q?4GzP/ZCNTv9ZjDhE2BDg5eKz+ZeQWTPFoA8hCde7iHzi4TOrIfWAL3E9XyA?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c41ed9ca-c6de-477b-d3cb-08dd77704729
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 14:10:26.9867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9105

From: Christoph Hellwig <hch@lst.de> Sent: Wednesday, April 9, 2025 3:50 AM
>=20
> On Tue, Apr 08, 2025 at 11:36:44AM -0700, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > Export vmf_insert_mixed_mkwrite() for use by fbdev deferred I/O code,
>=20
> But they are using this on dma coherent memory, where you can't legally
> get at the page.  As told last time you need to fix that first before
> hacking around that code.

Hmmm. What's the reference to "as told last time"? I don't think I've had
this conversation before.

For the hyperv_fb driver, the memory in question is allocated with a direct=
 call
to alloc_pages(), not via dma_alloc_coherent(). There's no DMA in this scen=
ario.
The memory is shared with the Hyper-V host and designated as the memory
for the virtual framebuffer device. It is then mapped into user space using=
 the
mmap() system call against /dev/fb0. User space writes to the memory are
eventually (and I omit the details) picked up by the Hyper-V host and displ=
ayed.

Is your point that memory dma_alloc_coherent() memory must be treated as
a black box, and can't be deconstructed into individual pages? If so, that =
makes
sense to me. But must the same treatment be applied to memory from
alloc_pages()? This is where I need some education.

>=20
> > which can be built as a module. For consistency with the related functi=
on
> > vmf_insert_mixed(), export without the GPL qualifier.
>=20
> No.  All advanced new Linux functionality must be _GPL.  Don't try to
> sneak around that.

No problem. Just trying to be consistent, not sneak around anything.

Thanks,

Michael

