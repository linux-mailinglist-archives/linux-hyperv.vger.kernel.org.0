Return-Path: <linux-hyperv+bounces-8135-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 486F7CEF9E4
	for <lists+linux-hyperv@lfdr.de>; Sat, 03 Jan 2026 02:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49A7C30185F3
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Jan 2026 01:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97C321D599;
	Sat,  3 Jan 2026 01:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OmaXidKa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010022.outbound.protection.outlook.com [52.103.7.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76A3B1BD;
	Sat,  3 Jan 2026 01:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767403016; cv=fail; b=RDjpoCaRxFVG4niZFf0IU01R8mNCeZb6uY9RtnedFGRbFYxH2RmkN6WbZ0B/yyDOzV/Xf4UkR8rKs8Flpxbxhtyasi+x1MkgWto4SiM+VOA/FLwMgOIZRRX+FX51lRB7uw8xaDO+u8AAH2MNDM+Vo0bvkAosrqn6zarBLapDKOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767403016; c=relaxed/simple;
	bh=uRuki+BHAjJWd0MQeEQu8nQlR5UDnGuQaUyfQ7ZSHhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JEw0ageGoLGoR2qioMPtzozar+BvxL90RMcIba2VXHY4AIiaPc1u/rhglYNPfgLp8Su//wH4CIg2xNx2DA6oPb9lnQ5g/xNby7rPo9Cdc1hzrt/1MSxcXgvCOulIWe9lBjDfOkXBOT23K7Abbxzys6ts6GfjnTU3slYI7RmDMQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OmaXidKa; arc=fail smtp.client-ip=52.103.7.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6mxj9IYoIbJOaUox50NJftZQzNjDLI4yJPx3DRbIeHPyl000llzgZuMLvXyCLkjrax0tV7NFWKDUoOvWAkALf+blCNlgJ8rXPJJB5Totid1SRPvnzR5D177NSkZKOSw55UnQ9CHRYVp7ECjFM23rZMz/aLr+kRjbefMHBFos5ZidAbt6FrNwornQv1Ee7/7stMz4Pip4+i05OKANg3UNKbuL4iLiYHajhwCrIXHd6nxpYn6xlsHQiT8YIc5FPYd0e4VAU8FIM3c7c5ED5LZC2r69RcOmhi+C3oM47nqEDlAK9SdNAaNSkaM3SJYZAb5NlKXWE6QVzDrwG+a5bwlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr2ZFubhzmtkOYS5HK63eyucm4iLhk7Ivv75Czs2tuU=;
 b=WFenvqVIFqLDCwWw7fD5QBQeGsUkoS5eMXgjoZJy9rKUW/DPr46Hvz0OAnCvpaKgpKSwCVZICR2RCm+v/fgvNRDqqpPeToT3RWIgKrpfyLU/1vQWSK8AmKpsTjXgnp3ZTPmw0t3FgA+GqhgPrpnajjyBm3tQcVJHeO+fX4zraW15OzoIn28xgnzJWsosV74lWe/fP4uw07/BSNjKVUHjeYrTW2dmBKjNrgScVXW+02+pY2LYj16JdPoHA1Eyhi6WN9lRXzOYY81ksYNA6G+77tchOm48GmIOQVf0hrYEKHne0Wy1Vn4nwgeQIiy09WJDTwqpK5qPRYZxBjnAAXbrhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr2ZFubhzmtkOYS5HK63eyucm4iLhk7Ivv75Czs2tuU=;
 b=OmaXidKapb4zI/t0cDzwhZTulAv2h2aeXH+mLFT45yoAVo3XD0e8Ng9t12ks/exbADPc8P8qCJ2z9DAMGoi1Bxe4tI9tXLqFcFkRiY3NIvJxNkmZvuSAm+0eOsyvUOUk3kV7jncwlW9M1PnEff/AnVKS+Otf3LLYeLr8tr51hOSpgdSSnpQ3ndKTn0PtCZ7Ekgh49HUQOKJo9Crabi1WMvyz4B2QmGZfQydtvBH3sIwVaDZ9293XUJQzm0KUq5TEmvDgMkhc8/Ci/fyCnLDSJeCvhwHO6oPkbRtbEWqf2KTS/hguk0KS8FhRWMv92NP4xlm60ywMX5xSS32F4srqhg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW6PR02MB9814.namprd02.prod.outlook.com (2603:10b6:303:240::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 01:16:51 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 01:16:51 +0000
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
 AQHcbu3m/1KRrXDdWE2Bee61xybnKLUnwn/AgAHUSgCAAZKpIIAEOHMAgAASAICAABt8UIAPsSwAgAABuuCAACWUgIAAAVcwgAA51QCAABHboA==
Date: Sat, 3 Jan 2026 01:16:51 +0000
Message-ID:
 <SN6PR02MB415756A0783B634297F51320D4B8A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <SN6PR02MB4157D69A4C08B0A4FE01F9FED4A8A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUXXdjMyZ5swiCI2@skinsburskii.localdomain>
 <SN6PR02MB41578A17A4DADD9276392298D4B4A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157AAFDD8BD5BDCD2D3DB99D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aUrCr5wBSTrGm-IM@skinsburskii.localdomain>
 <SN6PR02MB41573BF52C6A4447C720CDD6D4B5A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aVgDloDX9nMH6hZH@skinsburskii.localdomain>
 <SN6PR02MB4157288D26ECC9E69240CFECD4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aVgkj4V60kddKk4o@skinsburskii.localdomain>
 <SN6PR02MB415724D13B2751F8FAA1053BD4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aVhWMoH3GvpGAR0a@skinsburskii.localdomain>
In-Reply-To: <aVhWMoH3GvpGAR0a@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW6PR02MB9814:EE_
x-ms-office365-filtering-correlation-id: 66daff32-2c82-47e5-caca-08de4a65c692
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|51005399006|41001999006|13091999003|8060799015|461199028|8062599012|15080799012|31061999003|40105399003|440099028|3412199025|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cb95nF9g5hdgps+Mf49I35V+Xe1u33e1owpxWr5Tcik7cmr5baHlPQo3Duio?=
 =?us-ascii?Q?hYjsGkkyhP3Q9x/eL3vi4cmIHa+KZQfFtokHMOfZ/9y7dag0Pi+yAmHQ9yVV?=
 =?us-ascii?Q?OiEKE3J0uuiD24B+soLTx6GUnPbi5m/CIFkq00uR8SIPph1P49Jib18xX0H9?=
 =?us-ascii?Q?XUVDqc6OtuNDdDLlefqfn+Ic5hMa4+RAS8E7uR+6d8t0FYdqAfk08DcjF4iL?=
 =?us-ascii?Q?GX3u9VHGG3REfh8jl9eKibCDNHsdOHGDRIhpZUGPdLz8XpvECasO+01pZF2t?=
 =?us-ascii?Q?jwx1YqRdOyq6of0UAFH+oUtN/IRWM/VK/gYH1rTJwTFsH0B1js+04qjZURQ5?=
 =?us-ascii?Q?OL6LBn6NNA96eH/gnKAnh8R1J4YKJ0DtKfV88AA1gff6zBehFTrQnOcjWv2L?=
 =?us-ascii?Q?XGoHjHNlaSZBYCJT+NnGiDFl0JgyuLKjLv5pa+Ya5A5g9pg054hethzMjchK?=
 =?us-ascii?Q?7aEFsHz+BhzkYZKlvoBAsvbxITQlbNlxZ/wTOYckjEcrqFlEghCV2QgpXvpH?=
 =?us-ascii?Q?Ghu8uNUrKR9lF59++SZB5tSArULW7BI3eSN3gUZon/fN1Ft00y4ziRW0EXTF?=
 =?us-ascii?Q?w1cGHCFdDWgtBVyRZJ1HYklNUHPWdclZCaDcmH5mJb9Dw+f7hoYgwwzKMeSC?=
 =?us-ascii?Q?U1RncEbVZ/HybH0h6nVjHSo4AupS4O4WUc4XU40ec/nVqxsP+viy20Vr1seK?=
 =?us-ascii?Q?O0Ah9i3hWuLWW+69ZQ3wnt61gtxsAbsG303QfUbvyW25MYahbWH0g+oQPS4q?=
 =?us-ascii?Q?PmUS2hcnnNg9yPWNSdFBO/p/YDSLFRcwHMtB9FzytqOrxx/AfKTwo853mmZb?=
 =?us-ascii?Q?LSEhX5LnJ0r8JyE5ZspdhYri9aV5QZEztepfWgF/zuLdTUXqJ6UhqMptzbMF?=
 =?us-ascii?Q?MFD0ayMqaVUXUsYL8skLBh7hoIqStsDPdaxwN3KCRpG+eHIhfpx+TjVcCkVH?=
 =?us-ascii?Q?9hPisddbiP1Cg7HQ00/lzOX6moS9ZDHJJ+scZih6NJd7Ovs7FHiQS4vVaTKT?=
 =?us-ascii?Q?+/V47o7ucH8168YLIclb4K+osf1bjVqbGiFtwhkgTRtjKO/IbAbU05nKgIXw?=
 =?us-ascii?Q?HSs/KACkF3iZVnXKq9iwTPhGTKQfnpctPSq2EXvafBBgT8BM+xxMQEp+gvcc?=
 =?us-ascii?Q?cYIBT4btsTKwN07TEcBQJNvJhZkt7WwcslDnc77ts04gRujgQzokhtsfHgEH?=
 =?us-ascii?Q?N7U0yx0WcIjDrBnkuRQW1MUeGc+PaxMTT16t7I/KqnJtNdZ7ZLi7zi9ix/fi?=
 =?us-ascii?Q?5XMjzcbL9DGCbUnOshmhjpJVDgm48fQ42a06TzvmWA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2g2wGPJZIhn2ckJjkubUjXV8XmaNWDwKp1r2uGasGz1bqwzQBTmqAHt2gjH1?=
 =?us-ascii?Q?yQl8nUtknFRUCgIzbLdAwnqu7eP61yNjJGkpmx5VgM5RhgXEDAUkoH5l+1P+?=
 =?us-ascii?Q?desLn+GHEDGiYTdCkSiIJREtZjoQ1L2vo5j0klwq3qHndApdWRuTMtq/KoCm?=
 =?us-ascii?Q?OIczNmSD+B9z3kXHgK5NwkyYRc5PK/33BLbjyh2OB9ZVh32rzqLEzEGg0bCf?=
 =?us-ascii?Q?11RPqVfaZbOGkU+QNOiQ1g6wjtgHLcBfpv0B5eNYwwSMljC4Yuz00b5Jygc2?=
 =?us-ascii?Q?3INAdISoKpx5ldJ4NsuuFzwkDcJzrjowdVNYIIJ+BXbFLeGjZe3lzQt4kVD9?=
 =?us-ascii?Q?Q4UFxMEsYlbHg8T30i8m3VlBUp0y7hn82BLBzacA06kIgrjI3lnUh+rRposr?=
 =?us-ascii?Q?CXUE8nlG/S2xbNofIELvyQ3xgBA7IpLvWO50WzRZMfEWlz4oc7bJRILQgYK7?=
 =?us-ascii?Q?nIHD+ZifB7rEN7z5DyZ3FeEsczDv20qAv+vjuzLp8NWLa9uCcyLe1lNLBWPh?=
 =?us-ascii?Q?M1KEtajzq0oSlxYxxzXt8iVz6vWGgb3ZfHAqtmuV9pghNzwoes6lj4YaMiq4?=
 =?us-ascii?Q?245CqE0NTZRGcS6wnhv1lVPUQ9weNXfHwPVsgNsRCgqd7LmLp+8HaaT8adBo?=
 =?us-ascii?Q?PQgFy1VfzE+Ga7dNa5pfz+1ISuhq7sXnnP+dtGsBdS+xdQtcMRqUnFg42ohv?=
 =?us-ascii?Q?BM1X2vHIZ95J8i6vKG5hz+5vLEy4ypo2Z4aHJ9R3pCNh6n6S7vzRiLznH8PN?=
 =?us-ascii?Q?ztx4r4hD8QiKV2Ha0Gr/leh7JZ1ph/a1AoxQUSV6f5mAeBIA023tHJGxp2SS?=
 =?us-ascii?Q?oWapkLmgR76/G+xZL/jrbdeiUNrSjEgHStPC9phFAmhNCTb1l2n2EuIbopeV?=
 =?us-ascii?Q?J8Js1PGqlJKmqu545lwDrI522ozuLqMBH+6+xb2ia6jB9Xm2XubfKZOGYOyt?=
 =?us-ascii?Q?BZ5lkXWR/R9Tj9eMhyy4A/WAwVBQDsVqqsUHyEjAvLgObqFI3TQDHQrbLJCK?=
 =?us-ascii?Q?GEt1zjSOUi9hrkLYrBBBWnP11CBvpHpCQH5G848vn4Tiu6IwcAhYk0e/3Jck?=
 =?us-ascii?Q?C813ynS6vNZvM0wDbdE8m64LDVQmDkZzr2BIwIBuc713qRZ9Aq+PA6bPe1Fl?=
 =?us-ascii?Q?1l7hPjDKzhfFCLcW35nimOkT7lBB6nLeFZs1lxAYKNgl5YaHDzP449ycFz6R?=
 =?us-ascii?Q?RjRerGZJ5A4/odVoxXyXbyitdK9YcodFoUfO5UXLheR/pTrSJIKP8K5/WUk3?=
 =?us-ascii?Q?pzLNqCTCspD/2D21N76jakB9XyLE5NRlC0COrKMql99LCNDxclqKBToahudb?=
 =?us-ascii?Q?7TauJkH9Rh3kQdoNaOzvSlaZPC8+QnCc3FCTyW1EJtXeVYiyDiYKrjZ4ZN10?=
 =?us-ascii?Q?pTPDUK4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66daff32-2c82-47e5-caca-08de4a65c692
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2026 01:16:51.6412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9814

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Friday=
, January 2, 2026 3:35 PM
>=20
> On Fri, Jan 02, 2026 at 09:13:31PM +0000, Michael Kelley wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Fr=
iday, January 2, 2026 12:03 PM
> > >
> > > On Fri, Jan 02, 2026 at 06:04:56PM +0000, Michael Kelley wrote:
> > > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent=
: Friday, January 2, 2026 9:43 AM
> > > > >
> > > > > On Tue, Dec 23, 2025 at 07:17:23PM +0000, Michael Kelley wrote:
> > > > > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> =
Sent: Tuesday, December 23, 2025 8:26 AM
> > > > > > >
> > > > > > > On Tue, Dec 23, 2025 at 03:51:22PM +0000, Michael Kelley wrot=
e:
> > > > > > > > From: Michael Kelley Sent: Monday, December 22, 2025 10:25 =
AM
> > > > > > > > >
> > > > > > > > [snip]
> > > > > > > > >
> > > > > > > > > Separately, in looking at this, I spotted another potenti=
al problem with
> > > > > > > > > 2 Meg mappings that somewhat depends on hypervisor behavi=
or that I'm
> > > > > > > > > not clear on. To create a new region, the user space VMM =
issues the
> > > > > > > > > MSHV_GET_GUEST_MEMORY ioctl, specifying the userspace add=
ress, the
> > > > > > > > > size, and the guest PFN. The only requirement on these va=
lues is that the
> > > > > > > > > userspace address and size be page aligned. But suppose a=
 4 Meg region is
> > > > > > > > > specified where the userspace address and the guest PFN h=
ave different
> > > > > > > > > offsets modulo 2 Meg. The userspace address range gets po=
pulated first,
> > > > > > > > > and may contain a 2 Meg large page. Then when mshv_chunk_=
stride()
> > > > > > > > > detects a 2 Meg aligned guest PFN so HVCALL_MAP_GPA_PAGES=
 can be told
> > > > > > > > > to create a 2 Meg mapping for the guest, the correspondin=
g system PFN in
> > > > > > > > > the page array may not be 2 Meg aligned. What does the hy=
pervisor do in
> > > > > > > > > this case? It can't create a 2 Meg mapping, right? So doe=
s it silently fallback
> > > > > > > > > to creating 4K mappings, or does it return an error? Retu=
rning an error would
> > > > > > > > > seem to be problematic for movable pages because the erro=
r wouldn't
> > > > > > > > > occur until the guest VM is running and takes a range fau=
lt on the region.
> > > > > > > > > Silently falling back to creating 4K mappings has perform=
ance implications,
> > > > > > > > > though I guess it would work. My question is whether the
> > > > > > > > > MSHV_GET_GUEST_MEMORY ioctl should detect this case and r=
eturn an
> > > > > > > > > error immediately.
> > > > > > > > >
> > > > > > > >
> > > > > > > > In thinking about this more, I can answer my own question a=
bout the
> > > > > > > > hypervisor behavior. When HVCALL_MAP_GPA_PAGES is set, the =
full
> > > > > > > > list of 4K system PFNs is not provided as an input to the h=
ypercall, so
> > > > > > > > the hypervisor cannot silently fall back to 4K mappings. As=
suming
> > > > > > > > sequential PFNs would be wrong, so it must return an error =
if the
> > > > > > > > alignment of a system PFN isn't on a 2 Meg boundary.
> > > > > > > >
> > > > > > > > For a pinned region, this error happens in mshv_region_map(=
) as
> > > > > > > > called from  mshv_prepare_pinned_region(), so will propagat=
e back
> > > > > > > > to the ioctl. But the error happens only if pin_user_pages_=
fast()
> > > > > > > > allocates one or more 2 Meg pages. So creating a pinned reg=
ion
> > > > > > > > where the guest PFN and userspace address have different of=
fsets
> > > > > > > > modulo 2 Meg might or might not succeed.
> > > > > > > >
> > > > > > > > For a movable region, the error probably can't occur.
> > > > > > > > mshv_region_handle_gfn_fault() builds an aligned 2 Meg chun=
k
> > > > > > > > around the faulting guest PFN. mshv_region_range_fault() th=
en
> > > > > > > > determines the corresponding userspace addr, which won't be=
 on
> > > > > > > > a 2 Meg boundary, so the allocated memory won't contain a 2=
 Meg
> > > > > > > > page. With no 2 Meg pages, mshv_region_remap_pages() will
> > > > > > > > always do 4K mappings and will succeed. The downside is tha=
t a
> > > > > > > > movable region with a guest PFN and userspace address with
> > > > > > > > different offsets never gets any 2 Meg pages or mappings.
> > > > > > > >
> > > > > > > > My conclusion is the same -- such misalignment should not b=
e
> > > > > > > > allowed when creating a region that has the potential to us=
e 2 Meg
> > > > > > > > pages. Regions less than 2 Meg in size could be excluded fr=
om such
> > > > > > > > a requirement if there is benefit in doing so. It's possibl=
e to have
> > > > > > > > regions up to (but not including) 4 Meg where the alignment=
 prevents
> > > > > > > > having a 2 Meg page, and those could also be excluded from =
the
> > > > > > > > requirement.
> > > > > > > >
> > > > > > >
> > > > > > > I'm not sure I understand the problem.
> > > > > > > There are three cases to consider:
> > > > > > > 1. Guest mapping, where page sizes are controlled by the gues=
t.
> > > > > > > 2. Host mapping, where page sizes are controlled by the host.
> > > > > >
> > > > > > And by "host", you mean specifically the Linux instance running=
 in the
> > > > > > root partition. It hosts the VMM processes and creates the memo=
ry
> > > > > > regions for each guest.
> > > > > >
> > > > > > > 3. Hypervisor mapping, where page sizes are controlled by the=
 hypervisor.
> > > > > > >
> > > > > > > The first case is not relevant here and is included for compl=
eteness.
> > > > > >
> > > > > > Agreed.
> > > > > >
> > > > > > >
> > > > > > > The second and third cases (host and hypervisor) share the me=
mory layout,
> > > > > >
> > > > > > Right. More specifically, they are both operating on the same s=
et of physical
> > > > > > memory pages, and hence "share" a set of what I've referred to =
as
> > > > > > "system PFNs" (to distinguish from guest PFNs, or GFNs).
> > > > > >
> > > > > > > but it is up
> > > > > > > to each entity to decide which page sizes to use. For example=
, the host might map the
> > > > > > > proposed 4M region with only 4K pages, even if a 2M page is a=
vailable in the middle.
> > > > > >
> > > > > > Agreed.
> > > > > >
> > > > > > > In this case, the host will map the memory as represented by =
4K pages, but the hypervisor
> > > > > > > can still discover the 2M page in the middle and adjust its p=
age tables to use a 2M page.
> > > > > >
> > > > > > Yes, that's possible, but subject to significant requirements. =
A 2M page can be
> > > > > > used only if the underlying physical memory is a physically con=
tiguous 2M chunk.
> > > > > > Furthermore, that contiguous 2M chunk must start on a physical =
2M boundary,
> > > > > > and the virtual address to which it is being mapped must be on =
a 2M boundary.
> > > > > > In the case of the host, that virtual address is the user space=
 address in the
> > > > > > user space process. In the case of the hypervisor, that "virtua=
l address" is the
> > > > > > the location in guest physical address space; i.e., the guest P=
FN left-shifted 9
> > > > > > to be a guest physical address.
> > > > > >
> > > > > > These requirements are from the physical processor and its requ=
irements on
> > > > > > page table formats as specified by the hardware architecture. W=
hereas the
> > > > > > page table entry for a 4K page contains the entire PFN, the pag=
e table entry
> > > > > > for a 2M page omits the low order 9 bits of the PFN -- those bi=
ts must be zero,
> > > > > > which is equivalent to requiring that the PFN be on a 2M bounda=
ry. These
> > > > > > requirements apply to both host and hypervisor mappings.
> > > > > >
> > > > > > When MSHV code in the host creates a new pinned region via the =
ioctl,
> > > > > > MSHV code first allocates memory for the region using pin_user_=
pages_fast(),
> > > > > > which returns the system PFN for each page of physical memory t=
hat is
> > > > > > allocated. If the host, at its discretion, allocates a 2M page,=
 then a series
> > > > > > of 512 sequential 4K PFNs is returned for that 2M page, and the=
 first of
> > > > > > the 512 sequential PFNs must have its low order 9 bits be zero.
> > > > > >
> > > > > > Then the MSHV ioctl makes the HVCALL_MAP_GPA_PAGES hypercall fo=
r
> > > > > > the hypervisor to map the allocated memory into the guest physi=
cal
> > > > > > address space at a particular guest PFN. If the allocated memor=
y contains
> > > > > > a 2M page, mshv_chunk_stride() will see a folio order of 9 for =
the 2M page,
> > > > > > causing the HV_MAP_GPA_LARGE_PAGE flag to be set, which request=
s that
> > > > > > the hypervisor do that mapping as a 2M large page. The hypercal=
l does not
> > > > > > have the option of dropping back to 4K page mappings in this ca=
se. If
> > > > > > the 2M alignment of the system PFN is different from the 2M ali=
gnment
> > > > > > of the target guest PFN, it's not possible to create the mappin=
g and the
> > > > > > hypercall fails.
> > > > > >
> > > > > > The core problem is that the same 2M of physical memory wants t=
o be
> > > > > > mapped by the host as a 2M page and by the hypervisor as a 2M p=
age.
> > > > > > That can't be done unless the host alignment (in the VMM virtua=
l address
> > > > > > space) and the guest physical address (i.e., the target guest P=
FN) alignment
> > > > > > match and are both on 2M boundaries.
> > > > > >
> > > > >
> > > > > But why is it a problem? If both the host and the hypervisor can =
map ap
> > > > > huge page, but the guest can't, it's still a win, no?
> > > > > In other words, if VMM passes a host huge page aligned region as =
a guest
> > > > > unaligned, it's a VMM problem, not a hypervisor problem. And I' d=
on't
> > > > > understand why would we want to prevent such cases.
> > > > >
> > > >
> > > > Fair enough -- mostly. If you want to allow the misaligned case and=
 live
> > > > with not getting the 2M mapping in the guest, that works except in =
the
> > > > situation that I described above, where the HVCALL_MAP_GPA_PAGES
> > > > hypercall fails when creating a pinned region.
> > > >
> > > > The failure is flakey in that if the Linux in the root partition do=
es not
> > > > map any of the region as a 2M page, the hypercall succeeds and the
> > > > MSHV_GET_GUEST_MEMORY ioctl succeeds. But if the root partition
> > > > happens to map any of the region as a 2M page, the hypercall will f=
ail,
> > > > and the MSHV_GET_GUEST_MEMORY ioctl will fail. Presumably such
> > > > flakey behavior is bad for the VMM.
> > > >
> > > > One solution is that mshv_chunk_stride() must return a stride > 1 o=
nly
> > > > if both the gfn (which it currently checks) AND the corresponding
> > > > userspace_addr are 2M aligned. Then the HVCALL_MAP_GPA_PAGES
> > > > hypercall will never have HV_MAP_GPA_LARGE_PAGE set for the
> > > > misaligned case, and the failure won't occur.
> > > >
> > >
> > > I think see your point, but I also think this issue doesn't exist,
> > > because map_chunk_stride() returns huge page stride iff page if:
> > > 1. the folio order is PMD_ORDER and
> > > 2. GFN is huge page aligned and
> > > 3. number of 4K pages is huge pages aligned.
> > >
> > > On other words, a host huge page won't be mapped as huge if the page
> > > can't be mapped as huge in the guest.
> >
> > OK, I'm missing how what you say is true. For pinned regions,
> > the memory is allocated and mapped into the host userspace address
> > first, as done by mshv_prepare_pinned_region() calling mshv_region_pin(=
),
> > which calls pin_user_pages_fast(). This is all done without considering
> > the GFN or GFN alignment. So one or more 2M pages might be allocated
> > and mapped in the host before any guest mapping is looked at. Agreed?
> >
>=20
> Agreed.
>=20
> > Then mshv_prepare_pinned_region() calls mshv_region_map() to do the
> > guest mapping. This eventually gets down to mshv_chunk_stride(). In
> > mshv_chunk_stride() when your conditions #2 and #3 are met, the
> > corresponding struct page argument to mshv_chunk_stride() may be a
> > 4K page that is in the middle of a 2M page instead of at the beginning
> > (if the region is mis-aligned). But the key point is that the 4K page i=
n
> > the middle is part of a folio that will return a folio order of PMD_ORD=
ER.
> > I.e., a folio order of PMD_ORDER is not sufficient to ensure that the
> > struct page arg is at the *start* of a 2M-aligned physical memory range
> > that can be mapped into the guest as a 2M page.
> >
>=20
> I'm trying to undestand how this can even happen, so please bear with
> me.
> In other words (and AFAIU), what you are saying in the following:
>=20
> 1. VMM creates a mapping with a huge page(s) (this implies that virtual
>    address is huge page aligned, size is huge page aligned and physical
>    pages are consequtive).
> 2. VMM tries to create a region via ioctl, but instead of passing the
>    start of the region, is passes an offset into one of the the region's
>    huge pages, and in the same time with the base GFN and the size huge
>    page aligned (to meet the #2 and #3 conditions).
> 3. mshv_chunk_stride() sees a folio order of PMD_ORDER, and tries to map
>    the corresponding pages as huge, which will be rejected by the
>    hypervisor.
>=20
> Is this accurate?

Yes, pretty much. In Step 1, the VMM may just allocate some virtual
address space, and not do anything to populate it with physical pages.
So populating with any 2M pages may not happen until Step 2 when
the ioctl calls pin_user_pages_fast(). But *when* the virtual address
space gets populated with physical pages doesn't really matter. We
just know that it happens before the ioctl tries to map the memory
into the guest -- i.e., mshv_prepare_pinned_region() calls
mshv_region_map().

And yes, the problem is what you call out in Step 2: as input to the
ioctl, the fields "userspace_addr" and "guest_pfn" in struct
mshv_user_mem_region could have different alignments modulo 2M
boundaries. When they are different, that's what I'm calling a "mis-aligned
region", (referring to a struct mshv_mem_region that is created and
setup by the ioctl).

> A subseqeunt question: if it is accurate, why the driver needs to
> support this case? It looks like a VMM bug to me.

I don't know if the driver needs to support this case. That's a question
for the VMM people to answer. I wouldn't necessarily assume that the
VMM always allocates virtual address space with exactly the size and
alignment that matches the regions it creates with the ioctl. The
kernel ioctl doesn't care how the VMM allocates and manages its
virtual address space, so the VMM is free to do whatever it wants
in that regard, as long as it meets the requirements of the ioctl. So
the requirements of the ioctl in this case are something to be
negotiated with the VMM.

> Also, how should it support it? By rejecting such requests in the ioctl?

Rejecting requests to create a mis-aligned region is certainly one option
if the VMM agrees that's OK. The ioctl currently requires only that
"userspace_addr" and "size" be page aligned, so those requirements
could be tightened.

The other approach is to fix mshv_chunk_stride() to handle the
mis-aligned case. Doing so it even easier than I first envisioned.
I think this works:

@@ -49,7 +49,8 @@ static int mshv_chunk_stride(struct page *page,
         */
        if (page_order &&
            IS_ALIGNED(gfn, PTRS_PER_PMD) &&
-           IS_ALIGNED(page_count, PTRS_PER_PMD))
+           IS_ALIGNED(page_count, PTRS_PER_PMD) &&
+           IS_ALIGNED(page_to_pfn(page), PTRS_PER_PMD))
                return 1 << page_order;

        return 1;

But as we discussed earlier, this fix means never getting 2M mappings
in the guest for a region that is mis-aligned.

Michael

>=20
> Thanks,
> Stanislav
>=20
> > The problem does *not* happen with a movable region, but the reasoning
> > is different. hmm_range_fault() is always called with a 2M range aligne=
d
> > to the GFN, which in a mis-aligned region means that the host userspace
> > address is never 2M aligned. So hmm_range_fault() is never able to allo=
cate
> > and map a 2M page. mshv_chunk_stride() will never get a folio order > 1=
,
> > and the hypercall is never asked to do a 2M mapping. Both host and gues=
t
> > mappings will always be 4K and everything works.
> >
> > Michael
> >
> > > And this function is called for
> > > both movable and pinned region, so the hypercal should never fail due=
 to
> > > huge page alignment issue.
> > >
> > > What do I miss here?
> > >
> > > Thanks,
> > > Stanislav
> > >
> > >
> > > > Michael
> > > >
> > > > >
> > > > > > Movable regions behave a bit differently because the memory for=
 the
> > > > > > region is not allocated on the host "up front" when the region =
is created.
> > > > > > The memory is faulted in as the guest runs, and the vagaries of=
 the current
> > > > > > MSHV in Linux code are such that 2M pages are never created on =
the host
> > > > > > if the alignments don't match. HV_MAP_GPA_LARGE_PAGE is never p=
assed
> > > > > > to the HVCALL_MAP_GPA_PAGES hypercall, so the hypervisor just d=
oes 4K
> > > > > > mappings, which works even with the misalignment.
> > > > > >
> > > > > > >
> > > > > > > This adjustment happens at runtime. Could this be the missing=
 detail here?
> > > > > >
> > > > > > Adjustments at runtime are a different topic from the issue I'm=
 raising,
> > > > > > though eventually there's some relationship. My issue occurs in=
 the
> > > > > > creation of a new region, and the setting up of the initial hyp=
ervisor
> > > > > > mapping. I haven't thought through the details of adjustments a=
t runtime.
> > > > > >
> > > > > > My usual caveats apply -- this is all "thought experiment". If =
I had the
> > > > > > means do some runtime testing to confirm, I would. It's possibl=
e the
> > > > > > hypervisor is playing some trick I haven't envisioned, but I'm =
skeptical of
> > > > > > that given the basics of how physical processors work with page=
 tables.
> > > > > >
> > > > > > Michael

