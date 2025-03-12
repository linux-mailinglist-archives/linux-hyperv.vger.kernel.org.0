Return-Path: <linux-hyperv+bounces-4451-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1445A5E82C
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 00:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D14179643
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 23:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4971C1F12EC;
	Wed, 12 Mar 2025 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UGbjQX2F"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021130.outbound.protection.outlook.com [52.101.57.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25761EE7A5;
	Wed, 12 Mar 2025 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741821406; cv=fail; b=iS0mDVK3G59wHn6bMPLIyh1Ra6q9RqKx409RyWYhmjX0cRrSo8BbKeU2TLYpS2I8yKp5HXzVkve3opkmwBrkOjwVdvZ4uH/Z/HEBOyfmlYftXNo+B+GUZz9t8erylQx7Iqt3h1Z2YSJCLzUFruCtw2dzMnIe54LHoT5jrKRZT/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741821406; c=relaxed/simple;
	bh=sv37KScW3myhiOyL+oZYz0MF7r5h3OVklAMrvY39QKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FA7IdfxH3I1lBFmBD9vL5LATyEUTH1MxJsjMj3kpD+hrF8I/co8fJjLDzRqK9IhRYhD+G+bUkZEDcaeiam+e06/CmOsrTqL2vDFeEGnyl6BlaM6HW2qVqJIVLx9IwkrGfYQGfMt/8m09fehZprQRVoBLqJjZH2cLV8jM7luYJSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=UGbjQX2F; arc=fail smtp.client-ip=52.101.57.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRFfRZhu30ijxxFx1Gk8VFLUsT0wqSq2/XDGnCgC7Fafqo1ntrL9ibdsSX57vnN4vCimHjeEaN/xyuEGP/c47CgNPclbnsrPEWAr2NVXsr0JOkBEAqSBlteh5xZrweE6KhB42emmluCU0YND19SXa6dNpc1Eb4wfcfA9Rafta7d2cD/VpCkdQ8nOCWBi+Y0YQeglUpZ4HsEw0/GCkQT71ivSPMZi8haEYvlzLGo1b0j3w3BdCi5610O5y5HSKGM66rkU74RdU68o7IKGF9s4ovD7uZzhDuEAh5yzGXkTA0HgcRruQBQT9BTDMNB/9juaNVbK+vXfGC5S6k7Pmnti2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sv37KScW3myhiOyL+oZYz0MF7r5h3OVklAMrvY39QKE=;
 b=E+AM4dDRhDuKlkcBaGVJ4RkBUTktUKkuHvidX65yS0sRPjNXDxyB4xK3IwPP4qp0vVxXwUrQefMdyzHuHzmeqa7gPJM4yJ2l4yWEkdbLUvDQJvBo8KiSoKGgKm0Er5xeDwN/p9VL3PXwHtrCgQAiszPU4RMwClyieIqJlPQjJ2z5tHpMWOC6Mt7sff9x4JL0gDC9xZyYCGh/mMd+wl26XhuiZQ2DwIIwbV2zKxLA+dOpfBH5Ev4UaHQchjoIzR1XohsBUl9g5e0O5vH8NMFaF6OxvXhhx0SY7kC4u1OsECoQMgDCLfJRUbLoPBDvkeCynuOlAQYFZ36KeCaQc6yfLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sv37KScW3myhiOyL+oZYz0MF7r5h3OVklAMrvY39QKE=;
 b=UGbjQX2FbTpltjQdk+UQLBTXji2mNPa//vJqqtFqVdtDmuQASFelUeaz/vMFB9CyFZPsl4Ust2GlVqNE3GgfOcELl+W9ISYEx8b1axfWLskRNqTN2rVqBQhz3K0EWPr/lwSzj/Abb3AagvCna2uGSFVoQyxk42sm0H6F8Tj8i7Q=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SN7PR21MB3937.namprd21.prod.outlook.com (2603:10b6:806:2e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 23:16:42 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8534.012; Wed, 12 Mar 2025
 23:16:42 +0000
From: Long Li <longli@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [patch rdma-next v5 2/2] RDMA/mana_ib: Handle net
 event for pointing to the current netdev
Thread-Topic: [EXTERNAL] Re: [patch rdma-next v5 2/2] RDMA/mana_ib: Handle net
 event for pointing to the current netdev
Thread-Index: AQHbjtGAHu5I1ObjAEGtSbYSnlR/rrNmhdBggAZnwsCAApzAAIAAoXJQ
Date: Wed, 12 Mar 2025 23:16:41 +0000
Message-ID:
 <SA6PR21MB4231E1DFC1A47A6C1C89D073CED02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1741289079-18744-1-git-send-email-longli@linuxonhyperv.com>
 <1741289079-18744-2-git-send-email-longli@linuxonhyperv.com>
 <20250306195354.GG354403@ziepe.ca>
 <SA6PR21MB4231E9B17697BFE4857A7E55CECA2@SA6PR21MB4231.namprd21.prod.outlook.com>
 <SA6PR21MB42316CA1E7C6CF083A89ECE4CED62@SA6PR21MB4231.namprd21.prod.outlook.com>
 <20250312133804.GC1322339@unreal>
In-Reply-To: <20250312133804.GC1322339@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dd2ad366-8a5f-4087-8df9-4a87647c65e3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-12T23:15:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SN7PR21MB3937:EE_
x-ms-office365-filtering-correlation-id: 71f4cfc8-3711-45c4-5b79-08dd61bbf2e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7Gxm2IPShtwyS9bsAcui8aQRTIGPQosdjQxWWj6/25o+PhQ/kHnGq4GKzduR?=
 =?us-ascii?Q?ndSBcgq4wjRRfDy1Skew8lzqUKl7p+nfCCEl750tgkzSEBpjaIAjS6udt2HQ?=
 =?us-ascii?Q?vjKpZn/Rtf5efgPI3uKrye8QeEK18fVkfLdY0q+72U3RaLJKr6Kw6xjW2cr2?=
 =?us-ascii?Q?Yt5prhkOKmEwrwNvXpz5HlqlceYcsSWn+yBIuPd4ZacNPu6tbdL/PUk3yvy1?=
 =?us-ascii?Q?SmlKFDJ5T4HFmlx06tKsKignyeot7QTT1o1WsuVIFp6anakOrW3qTLr9KbCW?=
 =?us-ascii?Q?QF0xyj8kyy8R4KYikkHwrasF0ptYATSr8WXmSxL31iAdOpQhHZZbHiKuYLLI?=
 =?us-ascii?Q?0qUjgRhePya2P3WQVlo6Nkkf+lNyuaGJ8cPgBGlx66L2sOmbm+iKWJ5nlmnL?=
 =?us-ascii?Q?kA2+7kSt4RhlhmZ2pWn5sBab/00NpUKFNtvAxhBZPHv7k3Rtn0vcVr69N4ty?=
 =?us-ascii?Q?2uH125iC8uNHOiyMzgy4WIQEJmBD9XKCUYJUUnyvIyTL8e9/L8v6FSfcTK1l?=
 =?us-ascii?Q?hYYRh5XLAEKy0o5hCrc77ZX+QuIUhceuB9ysqWVonpZRADGyNofNzgo5TlID?=
 =?us-ascii?Q?sYy50eE6u4ekoF2fYxSxwwmxr19f96lW2UIiN4pA0vNBrBcyTv/1d7gIjNGn?=
 =?us-ascii?Q?/dO6trfJNdx7qaVvaG53UREosPPHY+EcgOPMwT5b67/9Qa1hHRo9dlKj98Ix?=
 =?us-ascii?Q?+OPp52HWd/8OityuLmXxNUhqku7TB2nSFEn8uNyRcLooUoNVBopq6vZUtCww?=
 =?us-ascii?Q?uaiSH/BaCrI6AIOrHF7D6neKUTSodDcs8MYpGtxPpc3C6KBk8Hc3pLiTqY/T?=
 =?us-ascii?Q?GgDgVTAg83g8PkeGe/7mCFOMc0rLFrwHdCgVRVtLN7RODxVWr2OJAhYXsgbw?=
 =?us-ascii?Q?0mk8uvlEPjvELX+RzmX4fU3d4IKVnqqvmd7Ln84qIX6VanE2g2UanxM//Gaj?=
 =?us-ascii?Q?95NaJDMRlPJ6ZT78e2Lh1obGH9rghWO6k684X22a2ZJWNTrp2c3FRS/BZlK4?=
 =?us-ascii?Q?3NSweCPpo0bmoHQzpRPfpY8bC9WCN4FKdfLmjCYrtBmw+Idvmg2omnvhGBoZ?=
 =?us-ascii?Q?Gnv/ZIBRzl53YQLqAxujF7+4zZV4aaXycxK2QqUtvPSCAC0h+VHwsohIeMNY?=
 =?us-ascii?Q?tSoMnQ9RFVVZ5Ql3i+b8tCRkQ0s3xvGwciDs1lAL55rRRQT3XMnlZGiYR6xd?=
 =?us-ascii?Q?/q3U7Yrnl6BohggNIG5ESuU3V5Wqe0uUmCqVjPuu2x++oUT67lL/InT/kISm?=
 =?us-ascii?Q?7M3OX0ZUPlGrg0SOF35/vpm9+mNk3BQQXUdP6RpJ+myCVDQdw48utxax6xO/?=
 =?us-ascii?Q?JQYFHrFzYAhJZWEUu/SmOGHhpH7KK8HYe7lVIgaFAQNHL9ngIboLa01LXiGM?=
 =?us-ascii?Q?KnhLwZgndR68IEVK6zDoKWHyTWsezU2ag/dLy0IxVJkE5qkf01cdZvU88OrY?=
 =?us-ascii?Q?DKyFHRl4VFBhobBuceE6ih7LftDh15KI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bOhBqgAgSWhVNRA/lcj14GAQF6KvKWYx2Um7p0dGE6nPeeHNEW4/MSraM+tm?=
 =?us-ascii?Q?h5FtZXLyj66vXtbblYCePcjy0rcVx26Vts5vyrD78FbpOQXbpJC7ZmrINl6G?=
 =?us-ascii?Q?7gPYnAs4OtfVFa/7svkxCMrXDjZ4AnRdzUmeo86lCt34xfn/dOAQq8iFwmxf?=
 =?us-ascii?Q?dLZ/l4htdrUX0vkrJqvnfm2Mv+LeBCcbb/XnhiRGMc6/26QNcZhOkzuBr2C7?=
 =?us-ascii?Q?8yZT+XunNEdCFmk9jXoDGjOP7ZiFFLKBKhIQfzA5+OW4OHKIwCJjxB910EC5?=
 =?us-ascii?Q?Cb7s8DXYiJOPQoNP+2ezCGP2UCeTwqvB2vixANivepYn683lqdsoiUf3k5yd?=
 =?us-ascii?Q?Llpzhfmx36W9TM4OmnhxjNp3c/ErusndSAS5PjJWSSjPW9mrHgTf2pM7fQ7R?=
 =?us-ascii?Q?+8voApH7R2nK31IuYp0HR7WDgKh4powkNFtliSDqrJCLd2W0zzEWminUCBEh?=
 =?us-ascii?Q?LhjY3N3cnxKdAxjaKW6sRsMNRDb61m0l4AyciBIHFzPhMnEl+iqeHYtp9GR+?=
 =?us-ascii?Q?LatWkV5BtvrEY3EwEoOGJGqcopof+0uSRcCYd5+2ugSeN/YoQ3JI6AYHOc+Y?=
 =?us-ascii?Q?5alBgywJA9GnQAcVA85orTGpwpQ2B5pAsOdjR5w4p43Zd7XUJrr/DQ3XQPVO?=
 =?us-ascii?Q?syUvBj3tOYBs/S3UUE34cuTrKUS6GoiqnsJ9TN4NKkSLfbp/6E/VVABa8V5n?=
 =?us-ascii?Q?vkWYa/J6eI0vglnLDguAB+uH/1A+kaTJULEtN+3NQDCewxGbbMqGJbb2ekhN?=
 =?us-ascii?Q?8pShPqglry1nKd6tkoMLEYxHVYTSjviVEmj5r1DPIWuPwnDXSeuTYp78rvyn?=
 =?us-ascii?Q?XXvBAE9Bw7qj1s2QqzVJ2ih0zXtPlkB4+BzEdQoaPr/Ebu0Vn5ls2m9tSRh8?=
 =?us-ascii?Q?pfDhRTckoLS+GNxNSL+LIWpyoVrZdf2eOBV0K8Nyw2JWXTCwtKE1GplxuDyd?=
 =?us-ascii?Q?qHHZLtn9qxcKJdKTHDJSHOt46EDuEfmGhSjIgW132lgWj5pYm57ZjXlXKEX6?=
 =?us-ascii?Q?dm7WXbDUYsaBHUtvidV1WVzNUIgRhVpl/tlRnH1qpdQa/KnDgJ29bx5RZ6aV?=
 =?us-ascii?Q?ieBLGHEXmP51JpKiVDxpOLgdxb1tgSODXMnzbMecZaYbMNZzzxPPyfBbAW5e?=
 =?us-ascii?Q?OUwbiJYIV8kwOXse5lnvN/jI4zyBr8jjJnF1XqI+iCrYDb6fW+yE4pfsIs61?=
 =?us-ascii?Q?E4SETmPPLRUKKAdFct6VXQkerOpxMLrQELJEPTbpYwKMgo9mCCr7Sxf+A3cW?=
 =?us-ascii?Q?sqnQgG3K1BKlYOJ7rvG9+IIZrQcRiX25fayBDtfvN1eGtpb70dzwL4d0JDBZ?=
 =?us-ascii?Q?k13sUNPLe2E74ri47k9kkqLvedw0oIl9BW+WGkGcKiS7a5Y9D6WdMcGn/x9n?=
 =?us-ascii?Q?oD0vlB0y0LwdJp5ZiY08tR1iCYorNZZb2Jb7kpezfuwfIVruXCSJ3QQuLZBN?=
 =?us-ascii?Q?z/+6dfI25zYZkmHuyWbrKVxpXzkMo6QPIvKQstuTJNpQBKhxtA79dBYoHANE?=
 =?us-ascii?Q?jSMGo8ZdDhA6GPe3hytUQYW/48TC86rOSWs+Dq32O3lWABDXIqJlQCAyadeJ?=
 =?us-ascii?Q?6A79ZXThZ38amMyW8yocMN4A7IhrOXmwvoY1smYJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f4cfc8-3711-45c4-5b79-08dd61bbf2e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 23:16:41.8244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5YuN+LyfAhxFx1v0ZMoDha5/XMxPN+EkIdfx5nrhClLoGJlLTIEma3HFabxBvQNI6qcY+pp9RK7uQWNfGi/bEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3937


> > Hi,
> >
> > If we don't want to use a tracker, can we take the v4 version of the pa=
tch set?
> >
> > Otherwise, please take v5 (this patch) if a tracker is required.
>=20
> Let's use v5 version as it is more complete variant, however the series n=
eeds to
> be rebased as it doesn't apply after Konstantin's changes.
>=20
> Thanks

I rebased the patch and sent v6.

Thanks,
Long

