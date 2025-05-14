Return-Path: <linux-hyperv+bounces-5506-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88FFAB7021
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 17:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600BE3AE1F1
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 15:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A7B1EA7DE;
	Wed, 14 May 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LRcG7b+n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2108.outbound.protection.outlook.com [40.92.20.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8994617C21E;
	Wed, 14 May 2025 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747237344; cv=fail; b=WCfZ1kiSEwE48oBjr3h5jlaBn/T6SbrXymNsD2CtpC9PKx/s2NLsCFrKOgdOh9JXsWZN0EP+O9yiBNJTzLuj5OTjpN29I8E0Q3yYep3XgBHFjJkHINB9NrmEEHG0+35G5QzEC2X9o1FIt1rv7/5rdNPy0NIK0ZM3pK+i4jm0VgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747237344; c=relaxed/simple;
	bh=PhU49QGd/7bKKL9h57THuh6fh+qX8oMQ8BELRWoeEN0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JkKCeHqihfBdRECRg6EHN2cjtQSOs/mCgX2RgEYgESV5RI6HsF/0crLevfn9xT+kuQdnuqdOXOInv9bb/jlb69KtGpjiQORXixn1xmUdIcpDHw8OU1AqPBd2UakZnzEEea8FftWFInNTFP4ulwFfWqQ41MiUjGhUs8l4QXdfAXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LRcG7b+n; arc=fail smtp.client-ip=40.92.20.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s548A/BtncuFuNZSN8NLGOkESIrMvAOMQ6wjIG2WI2M81DYnN4cwHyveK5xizhrQngK3ZTSk7bvtMJYwC5l8juKAheyBI9wltGSRHwmfpJX7wOV2SD7LhATkpRcXnLX91BWm7YniaWCWSBA9NWgbx1mx5gpKiRi+fe9RSt1rsLXQ7lk/BkVXOIXold35v9V5+CIC98VXvXMUSABZXQOSjrDD31ILEOoAidgMvJjSzKL+5vQHQVNCiX/fleHkNW9vDMPAZVrythr/c2SVb6kbIQzxuvZk+WUIm4/NNnIxLNCc3VK0hD/bT6DciaMf2JVcoSFkANd/vmkPHRTqNDLywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feyqKtYJpSd/4UEOX1pnCH5LX2rWDmIL8R28MhllMx4=;
 b=vWcQS9Ud6scqGVKIUjWP+n9xRCPvkMVmUmv+rEca3t11mTMj7RCppjT0zY3IilqXHN/0DZej3aKvTrDVr+YucybjO1sJ5N4L2LnsoSZoU+/EhEo/yaUfjCfSDnO8dPbR5N9IfGxEhWpY2eyInWiOuxiJEABS6gWiUxP4NeIVJW/jKv1NZidwguFqB4erl7BlMjpgZh44UkI+L92pVJq4yPE5D0FLcnTVnUOt8mawFK7FMM6Bs9h1R7V2OS/fUXG853v+kZzKTX0VEhrglcMuxLxJxqc/Zh3p8GYV3y3mHd0gguSWDlr59BldkJmQLoBrGSSVExEDo/wKTfmhODHjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feyqKtYJpSd/4UEOX1pnCH5LX2rWDmIL8R28MhllMx4=;
 b=LRcG7b+n9Tp1NIMFwDxpEYcU1isJ2S/7lBpFBAJfaFH638KAXWOtc2enD0inFxE2dv8mCYSP21L+DGjhNZtKDEunSo0IT0mcTJlpxRaBBlJLswZ3SAVqwxiLtsHnXUlhwIpX02MfP9ARRhPPpo/+rx2JPoqUzrLTpybiSb0IRExvJgbIUV0yqIAeKd6ydI7uqZl7ldbXxJ3zW/KnvrV7Lwn9J8fySpd9hUWt+4XycUzvMaunLBZLwewsdeWA9b0g/+ZYEvzSXa0YTWKM45j9HTlw2V8z/R8L5+0j4HPt1tfVJzDvkz+QqCzcW00F/WMhj7+Gb2Jq7Um4emiqFwG1JQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8393.namprd02.prod.outlook.com (2603:10b6:303:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 15:42:19 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 15:42:19 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Simon Horman <horms@kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"James.Bottomley@hansenpartnership.com"
	<James.Bottomley@hansenpartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net 3/5] hv_netvsc: Preserve contiguous PFN grouping in
 the page buffer array
Thread-Topic: [PATCH net 3/5] hv_netvsc: Preserve contiguous PFN grouping in
 the page buffer array
Thread-Index: AQHbw5s6pVOwKNSPmUmsDiMAFhvuCbPR35iAgABe3wA=
Date: Wed, 14 May 2025 15:42:19 +0000
Message-ID:
 <SN6PR02MB41573F3B4A06DA86758F59F0D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250513000604.1396-1-mhklinux@outlook.com>
 <20250513000604.1396-4-mhklinux@outlook.com>
 <20250514093435.GE3339421@horms.kernel.org>
In-Reply-To: <20250514093435.GE3339421@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8393:EE_
x-ms-office365-filtering-correlation-id: fbf87bcf-d13f-4714-9eda-08dd92fde922
x-ms-exchange-slblob-mailprops:
 7J/vb0KDx3hRy7lV+CYJkolW21Iq60BXub8ndW+KJeQJxQUH4zNFPyfJc3JSe+tQ6/TDhP7DK7BFBF7saMjQV9vrOUU5o9Yfq0czisRQofwsgvC/VoAamILmnnsFhtxeooVdHxGyN7EWCmUSBkhK8J2f/t5i+WqWRyYg19ZfOia7sJ9UYuRWJNlzGhoLdRIEDYimdlkYyIvHevpNP+bLbc+amcCwmapBGhUkNoFjdAY2PQ5MowcCr2FfnHWSf2wJWedPm6M8M1S301lsRiRzRjdlgidQWVj+zMWX2RB4S28cwDyTrSJnr8SGmVhP+gUivHuwkn6oRKSswCPR3RV24uUWasl2mHPO6NR4XZ/TFgiXnJ8N0MwrpEORNKKmXrWqWB3ufkjqwAZRm9LQpAF1yVcLh8X00ImF3hFfiCI5VEeyIlsJl9GPRWYhrZbpKTfphDfSK5NU2jcO8rUe1lyqaSP3/6BXIxDun8SGpeqzHw/2dKVVsKu1099RLBv8B6Bj1wbH1tABGiXqR/UmmrqHE+Fc3oUv1umYW1he2uZxz9/lrYBODhDrNAhgBpM6ErwMrFaXS/zzVao9os1uGaxZklcfO+S7TD/iO9Y9zeIRJs3Lfnapw7GhGTN+2X/51lpin91Apld2OfvOZH5z+e51CnWMBgRlyX2xwp4XFF3rSXX8kaNs+w/2tNvRWhts4Oh2P4VTNpR75RUwoZxVqnduKkEumIxB2b1Hm9aQyVFxwkhgwsMMOp8ucddSS1DJmRwIq9PN6vfeFYlQ9UR8DXFvmfAhM/6vmFG8YWDbqw99wHc=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799009|461199028|41001999006|19110799006|8060799009|8062599006|1602099012|102099032|4302099013|440099028|3412199025|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AAJJZXDuXP54CJJvZyDQwP0x9HSU9n6O8lthvbYUm0mlfdkQHKYzLzgPQ+oP?=
 =?us-ascii?Q?DAZrCljnSoIn7gzp2QvzY1FWVQPKCkgUCVZ56y/yt4Bx7J0HhqEtkiD4+bV2?=
 =?us-ascii?Q?CZmwjuMfYdJ0IMwK/rR8hirSQ7czxZm6VgKOoF/ajyIaERCV1RlCJo2YxzQI?=
 =?us-ascii?Q?/oZMSH6Elo243POkidHO4+ONVVOTt/myFO4ei/aIvi65cAZgdA5cu1jZiDc3?=
 =?us-ascii?Q?v4SGauQ7GOqnOrH3IT9OlRAWTBATkPbkdE3IphgSY9I9JoSY5eCiebidYmCF?=
 =?us-ascii?Q?KCsktVzK77H0L7ClYjYNK7dKartirISvyXK411rnYBaBMup6eXVBbCrfLyJf?=
 =?us-ascii?Q?inRRCQd0oa+Lo6pYSoPagZDOoIn2FFDVgrixH9BXFu9EwA+59uuH0h9zzkKe?=
 =?us-ascii?Q?+RU8kPQ3hbdG1Ztgp/qOZie7gaWDft/uj7XoHYS16pIkg4WTHkS5dFkq4D9Y?=
 =?us-ascii?Q?2ECVIlU9SB8XuLa4OeZo6IegrqdjtOdFamSvtdat15IO31VZRZugRBHIjvXX?=
 =?us-ascii?Q?yNW5nSAVX16LWMPQqrW9JZRQrMc6R9IF51FuJ+eF1MCmr28Zsv/3oL8KM+2O?=
 =?us-ascii?Q?faCJGb7ExepEz0EtNF86UeXHNGS1caIjbB0aFQLjOkk9DRad3raQxIdWLb/R?=
 =?us-ascii?Q?Y5uRWw108gEJvcZ8lxQm78S7CFb4mxFLujxebbTayq1Zxkm1FP0F+x1ctuYk?=
 =?us-ascii?Q?oikwxIGFDWySV/LXhbBq3HJ6SpBykQYqoEHO9yG7YWDFzexiWUH+QJ58i/82?=
 =?us-ascii?Q?nY1nDsPb6WREqxCnkfhto73U0gueGaWwARSMu4NuO1iOjmzahToWZmwvwiZ5?=
 =?us-ascii?Q?HKxAXRzf5GR91Zic/ZTFSuWGzT/vaDiC34HeP3XCpcncFwQaVyPh6nIsF4WU?=
 =?us-ascii?Q?bbXtpUS2rVlE6bhfBX7198ex+BwRT3jzVIkgLeB+S2/kSaMo2vlKOFf6q4Zt?=
 =?us-ascii?Q?02LRnW83zU+WZHp5YGKqE9IrLotelm9lMTtgIE88kumUqeZPCeIyFBbUVbV8?=
 =?us-ascii?Q?x3Xwf19XMWGsub4WTYgXMuAF7RDLpENugtkx0kjll8bkMGb5h73ewhauPu+9?=
 =?us-ascii?Q?ierJSIJHATeWIHbvq9MmWSfIyG/SjfVfORRE1ae8D9s1ykJlXw1ZxWJ+aaVc?=
 =?us-ascii?Q?eZBLB8UUD/JKP01o/9I/r6JbhLF2FwrYAztbNLNZZ7DgvCr/h/UAFh1D+FU8?=
 =?us-ascii?Q?8nPkFsc/A7RAEIlI8kvm2AJD/tPtNmHNJIdOWA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lzW3Wk24/payXNVT5skyXF3sYawrgxhzAqv5Nygmi/R2VGGQ2rKOgpYwj71f?=
 =?us-ascii?Q?QYkV4Q4bCRpJ+aRqos+1MntiX7WZRIW66AZFFaonw7GpcBOv2BVKdEYWU7JP?=
 =?us-ascii?Q?eE0SFksdhFcrmK3Nftmmm8klAyWvqkSfcNGIyMXKdj37tRxMiaAJvUWNBJNw?=
 =?us-ascii?Q?DS90+RDvY3i/5oUgWaFaT32Y6gdKlmXaXZlU0zFPKlqowEIptWD38ZWeNwjo?=
 =?us-ascii?Q?Is4jtpoKFRXJ/gml4Pb3YO5/QtzHoK35SCzQmlW17evIl7mnLixgyu+flKCJ?=
 =?us-ascii?Q?12xRQRSO/GYXQZSr8Pp96pi1nF52S2wyP1RVOyurDAysOPf8NS1vJ+1NsFu2?=
 =?us-ascii?Q?nz92H/8qOJnk4e9L53vy0uFHnqdqvw1SlHlLdD/4PYGB8eh2inTjy/ECblJ1?=
 =?us-ascii?Q?eNOkGSuJwoYKuo5A5Bc7EIirwH3BhcaWiB2MGq3qQPklTUJuvULwwPU5CpmN?=
 =?us-ascii?Q?iVPRYjcZqZLOCvZcQqkFBLclfLjuvFDaHlX2kF9apLWV2u5hM93XJFTP95H3?=
 =?us-ascii?Q?4cYSSRS5XSIhp//Mvph+0y+gN4VHVwXVonyWLgmE6lw+tisgrtM79jp/8CLM?=
 =?us-ascii?Q?Y0j6Cf8ivpHx5eDMwgixoIKqERHE0wvuoYnhP1bVbZF1DHQO82fUdr76S4kv?=
 =?us-ascii?Q?QVlk/y6+e8643gv1dCjjbY6d74NVHQoRknhe6Sf1xXMZ0FjF9ONzPYI9zUNt?=
 =?us-ascii?Q?SyNKiikEN3AfNmJKEG+Lj/vkuDWGo6WAAthUH2dm1hfh7G3kDFEbo2EOEIE8?=
 =?us-ascii?Q?+0tNHn9zZ8cuGZTouXLvSO0Z8X+jT6SKI5CqFlMFUnwnX+3whj1yE9RSk5U9?=
 =?us-ascii?Q?UoYyxRJP4fLuXIcCOxaKU5UYwKSRm3ivt9u6nbjGsMYU91E5DkBt5j/qu1cQ?=
 =?us-ascii?Q?t+G5Mu3IJwXh/6TPg82udAGSKxUkZHnLbtuGtTA301wjGVFNJqandmQJngah?=
 =?us-ascii?Q?e6Z4xRZI7Dtl8Xe3iR3vc95tymEojX58ckf0YSTYOgycIXk0kzrJt9oLrOKn?=
 =?us-ascii?Q?z+z0NJN57cRzcqmKHnvx+dj0djPl9G8Wv+HnY+S+8UOpbaxQ+c9cO2dEw25U?=
 =?us-ascii?Q?Jyful86rRUQI5HEXOxz0nVSDgS7cbwUReFTgP9Ze0EnBGdY2yyGTPX8Mi3IZ?=
 =?us-ascii?Q?gIdc5hfZydkw6iOLemq/21W+/jBMOWMbx0FE2Vi+XZz063GG/+ZukUZ23ZXd?=
 =?us-ascii?Q?Oh4jktlN7kvxUuPgi4EG8GCGpsrm32uMNwH2yqolVzDxZpZqtjsXvyIAJDc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf87bcf-d13f-4714-9eda-08dd92fde922
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 15:42:19.1940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8393

From: Simon Horman <horms@kernel.org> Sent: Wednesday, May 14, 2025 2:35 AM
>=20
> On Mon, May 12, 2025 at 05:06:02PM -0700, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > Starting with commit dca5161f9bd0 ("hv_netvsc: Check status in
> > SEND_RNDIS_PKT completion message") in the 6.3 kernel, the Linux
> > driver for Hyper-V synthetic networking (netvsc) occasionally reports
> > "nvsp_rndis_pkt_complete error status: 2".[1] This error indicates
> > that Hyper-V has rejected a network packet transmit request from the
> > guest, and the outgoing network packet is dropped. Higher level
> > network protocols presumably recover and resend the packet so there is
> > no functional error, but performance is slightly impacted. Commit
> > dca5161f9bd0 is not the cause of the error -- it only added reporting
> > of an error that was already happening without any notice. The error
> > has presumably been present since the netvsc driver was originally
> > introduced into Linux.
> >
> > The root cause of the problem is that the netvsc driver in Linux may
> > send an incorrectly formatted VMBus message to Hyper-V when
> > transmitting the network packet. The incorrect formatting occurs when
> > the rndis header of the VMBus message crosses a page boundary due to
> > how the Linux skb head memory is aligned. In such a case, two PFNs are
> > required to describe the location of the rndis header, even though
> > they are contiguous in guest physical address (GPA) space. Hyper-V
> > requires that two rndis header PFNs be in a single "GPA range" data
> > struture, but current netvsc code puts each PFN in its own GPA range,
> > which Hyper-V rejects as an error.
> >
> > The incorrect formatting occurs only for larger packets that netvsc
> > must transmit via a VMBus "GPA Direct" message. There's no problem
> > when netvsc transmits a smaller packet by copying it into a pre-
> > allocated send buffer slot because the pre-allocated slots don't have
> > page crossing issues.
> >
> > After commit 14ad6ed30a10 ("net: allow small head cache usage with
> > large MAX_SKB_FRAGS values") in the 6.14-rc4 kernel, the error occurs
> > much more frequently in VMs with 16 or more vCPUs. It may occur every
> > few seconds, or even more frequently, in an ssh session that outputs a
> > lot of text. Commit 14ad6ed30a10 subtly changes how skb head memory is
> > allocated, making it much more likely that the rndis header will cross
> > a page boundary when the vCPU count is 16 or more. The changes in
> > commit 14ad6ed30a10 are perfectly valid -- they just had the side
> > effect of making the netvsc bug more prominent.
> >
> > Current code in init_page_array() creates a separate page buffer array
> > entry for each PFN required to identify the data to be transmitted.
> > Contiguous PFNs get separate entries in the page buffer array, and any
> > information about contiguity is lost.
> >
> > Fix the core issue by having init_page_array() construct the page
> > buffer array to represent contiguous ranges rather than individual
> > pages. When these ranges are subsequently passed to
> > netvsc_build_mpb_array(), it can build GPA ranges that contain
> > multiple PFNs, as required to avoid the error "nvsp_rndis_pkt_complete
> > error status: 2". If instead the network packet is sent by copying
> > into a pre-allocated send buffer slot, the copy proceeds using the
> > contiguous ranges rather than individual pages, but the result of the
> > copying is the same. Also fix rndis_filter_send_request() to construct
> > a contiguous range, since it has its own page buffer array.
> >
> > This change has a side benefit in CoCo VMs in that netvsc_dma_map()
> > calls dma_map_single() on each contiguous range instead of on each
> > page. This results in fewer calls to dma_map_single() but on larger
> > chunks of memory, which should reduce contention on the swiotlb.
> >
> > Since the page buffer array now contains one entry for each contiguous
> > range instead of for each individual page, the number of entries in
> > the array can be reduced, saving 208 bytes of stack space in
> > netvsc_xmit() when MAX_SKG_FRAGS has the default value of 17.
> >
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217503
> >
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217503
> > Cc: <stable@vger.kernel.org> # 6.1.x
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> >  drivers/net/hyperv/hyperv_net.h   | 12 ++++++
> >  drivers/net/hyperv/netvsc_drv.c   | 63 ++++++++-----------------------
> >  drivers/net/hyperv/rndis_filter.c | 24 +++---------
> >  3 files changed, 32 insertions(+), 67 deletions(-)
> >
> > diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyper=
v_net.h
> > index 70f7cb383228..76725f25abd5 100644
> > --- a/drivers/net/hyperv/hyperv_net.h
> > +++ b/drivers/net/hyperv/hyperv_net.h
> > @@ -893,6 +893,18 @@ struct nvsp_message {
> >  				 sizeof(struct nvsp_message))
> >  #define NETVSC_MIN_IN_MSG_SIZE sizeof(struct vmpacket_descriptor)
> >
> > +/* Maximum # of contiguous data ranges that can make up a trasmitted p=
acket.
> > + * Typically it's the max SKB fragments plus 2 for the rndis packet an=
d the
> > + * linear portion of the SKB. But if MAX_SKB_FRAGS is large, the value=
 may
> > + * need to be limited to MAX_PAGE_BUFFER_COUNT, which is the max # of =
entries
> > + * in a GPA direct packet sent to netvsp over VMBus.
> > + */
> > +#if MAX_SKB_FRAGS + 2 < MAX_PAGE_BUFFER_COUNT
> > +#define MAX_DATA_RANGES (MAX_SKB_FRAGS + 2)
> > +#else
> > +#define MAX_DATA_RANGES MAX_PAGE_BUFFER_COUNT
> > +#endif
> > +
> >  /* Estimated requestor size:
> >   * out_ring_size/min_out_msg_size + in_ring_size/min_in_msg_size
> >   */
>=20
> ...
>=20
> > @@ -371,28 +338,28 @@ static u32 init_page_array(void *hdr, u32 len, st=
ruct
> sk_buff *skb,
> >  	 * 2. skb linear data
> >  	 * 3. skb fragment data
> >  	 */
> > -	slots_used +=3D fill_pg_buf(virt_to_hvpfn(hdr),
> > -				  offset_in_hvpage(hdr),
> > -				  len,
> > -				  &pb[slots_used]);
> >
> > +	pb[0].offset =3D offset_in_hvpage(hdr);
> > +	pb[0].len =3D len;
> > +	pb[0].pfn =3D virt_to_hvpfn(hdr);
> >  	packet->rmsg_size =3D len;
> > -	packet->rmsg_pgcnt =3D slots_used;
> > +	packet->rmsg_pgcnt =3D 1;
> >
> > -	slots_used +=3D fill_pg_buf(virt_to_hvpfn(data),
> > -				  offset_in_hvpage(data),
> > -				  skb_headlen(skb),
> > -				  &pb[slots_used]);
> > +	pb[1].offset =3D offset_in_hvpage(skb->data);
> > +	pb[1].len =3D skb_headlen(skb);
> > +	pb[1].pfn =3D virt_to_hvpfn(skb->data);
> >
> >  	for (i =3D 0; i < frags; i++) {
> >  		skb_frag_t *frag =3D skb_shinfo(skb)->frags + i;
> > +		struct hv_page_buffer *cur_pb =3D &pb[i + 2];
>=20
> Hi Michael,
>=20
> If I got things right then then pb is allocated on the stack
> in netvsc_xmit and has MAX_DATA_RANGES elements.

Correct.

>=20
> If MAX_SKB_FRAGS is largs and MAX_DATA_RANGES has been limited to
> MAX_DATA_RANGES. And frags is large. Is is possible to overrun pb here?

I don't think it's possible. Near the top of netvsc_xmit() there's a call
to netvsc_get_slots(), along with code ensuring that all the data in the sk=
b
(and its frags) exists on no more than MAX_PAGE_BUFFER_COUNT (i.e., 32)
pages. There can't be more frags than pages, so it should not be possible t=
o
overrun the pb array even if the frag count is large.

If the kernel is built with CONFIG_MAX_SKB_FRAGS greater than 30, and
there are more than 30 frags in the skb (allowing for 2 pages for the rndis
header), netvsc_xmit() tries to linearize the skb to reduce the frag count.
But if that doesn't work, netvsc_xmit() drops the xmit request, which isn't
a great outcome. But that's a limitation of the existing code, and this pat=
ch
set doesn't change that limitation.

Michael

>=20
> > +		u64 pfn =3D page_to_hvpfn(skb_frag_page(frag));
> > +		u32 offset =3D skb_frag_off(frag);
> >
> > -		slots_used +=3D fill_pg_buf(page_to_hvpfn(skb_frag_page(frag)),
> > -					  skb_frag_off(frag),
> > -					  skb_frag_size(frag),
> > -					  &pb[slots_used]);
> > +		cur_pb->offset =3D offset_in_hvpage(offset);
> > +		cur_pb->len =3D skb_frag_size(frag);
> > +		cur_pb->pfn =3D pfn + (offset >> HV_HYP_PAGE_SHIFT);
> >  	}
> > -	return slots_used;
> > +	return frags + 2;
> >  }
> >
> >  static int count_skb_frag_slots(struct sk_buff *skb)
> > @@ -483,7 +450,7 @@ static int netvsc_xmit(struct sk_buff *skb, struct =
net_device
> *net, bool xdp_tx)
> >  	struct net_device *vf_netdev;
> >  	u32 rndis_msg_size;
> >  	u32 hash;
> > -	struct hv_page_buffer pb[MAX_PAGE_BUFFER_COUNT];
> > +	struct hv_page_buffer pb[MAX_DATA_RANGES];
> >
> >  	/* If VF is present and up then redirect packets to it.
> >  	 * Skip the VF if it is marked down or has no carrier.
>=20
> ...


