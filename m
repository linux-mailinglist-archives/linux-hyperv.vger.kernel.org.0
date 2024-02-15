Return-Path: <linux-hyperv+bounces-1546-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1EA856D52
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Feb 2024 20:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD951C2251F
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Feb 2024 19:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435913958C;
	Thu, 15 Feb 2024 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EioZS31x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2104.outbound.protection.outlook.com [40.92.23.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779D013959E;
	Thu, 15 Feb 2024 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023864; cv=fail; b=Cr1kuy0fJKFyDlk9KMSwufG2MDpoAc3Q4RyiXsyGqZ4ISIhQAsNplbNIfw8cLMRgiY+JVx6fLD55parfwbt/0rfPVDIlgt7BTlsNPVqVi37U7EcR5YlkKoH8yRc6IYjtByAyXbSryc/EpHFqho/1oyoIsw0D1zVzRipz9ktP5iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023864; c=relaxed/simple;
	bh=ylbo6S9RLhptQOpd09gDEboc32aSBwjQ6chPGMcthiY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ps0bBl1eJ7Be573VkzE8Ir6vOEJtnwoF7krzMiDwNTe0IdIPNL0P8pe1Iv8/UaTjSStC54V7SdLeHxCm6ORFHeyPGfR3QVdUKBjtNepw7j3M1oJjgPuVwdcPy+NFtBOFWkCb9Dmm2YH++dpzs7G8IDchLooWXThK2ArCPLkOUD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EioZS31x; arc=fail smtp.client-ip=40.92.23.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qs9+zrAg72jnNOmNxh+LxPZU6sOE4tR6NjxdbkdaWUQWnGyRPVn41FeOBkt9jQf/CjN4tvvpjmV/Ur8EHxFMTnom8sisHMWHX35KMMEoRNdNSFCuD9F3GHNEmqcFJb4gv61e383kMrLGh9ClDCsmTCe9zthkt4+bvI34agLJVfirqOXmATDlvag6TQM8L/ircMTX1AbYogrp564p5lx9FF1BxgdMufk9CBNBxzKSZoEf6B2V5mEnuYvpuNHcdOC27EzwpeLqyKGBfXB4aqOUUcrRWpY0lzXmKc2MW5vDox0AQQ1xr4x6HnpuftoG9obKcru42Gcse00YHjPw5+b3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2LMhw2QMoMory3JT58Hpz1UUTreL8GDgbKC+UcBGtM=;
 b=k5OUR+QMbGGDJKfvqjDKw0iKFhqXCEZkWbzZLCHXfUgRxf10r0LDaELHpNyNMeXPl5lBv1QTHxWc6gl5DxcLJyYgS6fNmjvkcOBlp5WdZxMrGbgdAyiPXMCZBkA9DOsrD31HvIrzXhXZb1L/WYxP8uRd9eJsIFKXD/5/Wf2FWN+ddoMvuEHO6D+VxRF8z75Ufo0fajbgCoYlanaYgscGGQaOIWYHWfGXWRbbFMFkJ8lhvGtjCVr5TK87HB7WgqxlOVgBQl4Y0A3LRs+IcFhE2PD2wZaBVv8jQnphkGLyHcc7iIQ9JcB+gTQ5n2Eww12mGKckddPeM1cAGd5zm13bfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2LMhw2QMoMory3JT58Hpz1UUTreL8GDgbKC+UcBGtM=;
 b=EioZS31xfHt1D7R0TtuZ69jNdv39+cLAzFtN6TjfuMOGG3wUh7eQy28onuGNnPkzLAeSNFhRQKS5v7nT+xY7VyZNmjFDtR3rsGWBh0rl9NlqiAwD4q/kSzbERjqjC1AEwHAH053FghbzGDNNYPmTZwW/dZ6N1FdtPr5fwCPohgrjbFzaQgPkLprjMKUuQk2CgLSWiUd2D/IGble3CUHLeCxYP/FS+ZWmNpkDBNUVBGovFrYP1KmgWyRCP8+i6hlTfrrwwGsq/OjZARnFT1UI7S5FzUr3sOKqgg3tDoxF6OKCGyaezH5bcdPRDFV1WLHYaei9Zsbtrh/Yf2rqLy7Xwg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB10135.namprd02.prod.outlook.com (2603:10b6:510:2e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 19:04:19 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7270.033; Thu, 15 Feb 2024
 19:04:18 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH 1/1] Documentation: hyperv: Add overview of PCI pass-thru
 device support
Thread-Topic: [PATCH 1/1] Documentation: hyperv: Add overview of PCI pass-thru
 device support
Thread-Index: AQHaX5zLjfItck7t3UmPns+zVTEYbrELvbYAgAAFLlA=
Date: Thu, 15 Feb 2024 19:04:17 +0000
Message-ID:
 <SN6PR02MB4157798C452BD3D01E784CADD44D2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240214232253.4558-1-mhklinux@outlook.com>
 <d75a2788-b8dc-46cc-b8ca-a740a1fb74f5@linux.microsoft.com>
In-Reply-To: <d75a2788-b8dc-46cc-b8ca-a740a1fb74f5@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [5ZycXhGFGTIpS12A/Ktbpfxo2zDQfrG3]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB10135:EE_
x-ms-office365-filtering-correlation-id: 23e1f20c-3691-4843-19f7-08dc2e58e8c4
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 T4V3kXbgZp3TPCsREdXlYmEhBENESJR+/SQCqVWujGzBhSekIpAku/ZrfR+6TGpHlnyfYBl4n6QjGV7EJd+U65fn8zRApPLbKy7A3YjEfp6qAVAXkI3KZpN9W/RQjHlSsliAR4e9LsEM9sn3q/HRA8Q4iSfBbXi20NfX08IQfXZXCJrI0p/M3F4QMsBdJePKt8Vio7WaFoc1umCo4IeId200OvE0SLgdjNOVWP1Zz2EHn0ebbbh4rTx4KKFZ8TdrjXDLG64MZd6SDceT0XFsPFLBAzlmUX7khgEXX5okxRoJIZCHwgu/FkkVfX73vYjFFxSqwH3m20Uo2QbxUHB1u+5XqpqYbLvRr21cmNDy0FEQLheJLCBoC190dpBzaE9mCJZtmqAVpM9bd2siJx5YS6MiNVudq99WU4gzI3Inwrw1OF4RlBplQ7SjVAiLT5ULn7FaJ70HVvth/rQTG6NS5o54tdB2xij2ZjnbjBMuPf0HKLXT/3XUHArOBVd8XVt2QfCCojPi6L/yN98OWQMKN2Kv5icnK3BznavSI0Eefa1RJnyIJwq46Hj7D19Bv3u9
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jMJ+R00CZ2c1nl34CSoJXwgLvnQCyQKMZUnYALqAxr00hiAhlOUHtAadelOj?=
 =?us-ascii?Q?TIF6dhfgZ34kiB+qfrUs3SH35pJVB9krLLCAa0N3YPAhPv4XsB6VDYMZ1wx0?=
 =?us-ascii?Q?KDuP8WAAmeyblnVhZU7k+R//+x/FM+BN6rD4w6WVosNSVhOSP5tyFJZsEPAE?=
 =?us-ascii?Q?gbgcfDRv31HFvLhibSLlTjx7PIlfKkSMags11tmpZtoTxPrc3sfDAGdxwzOK?=
 =?us-ascii?Q?XanBZZLQroxDQ4a8FS1NuoPVwKzRKFBRZB/UBvJuA2pnb97Bhyh10OUPPhOz?=
 =?us-ascii?Q?qB5X8I1l6Pp9K6svBhF726/eMGVmQmVGiQVQeustxQ8sHgOADGR9abKMjtnN?=
 =?us-ascii?Q?Vhw4htTHRgp15RQi49rlKqn2LhX8LpYPYCirKNNg4soMlbCB8mklkxfceMvO?=
 =?us-ascii?Q?kXVIos5BpqJxe3k7ddhPnnem7yl6KI2WwYZ/yHlTr4XroJ3SJQoo5OiwyFKR?=
 =?us-ascii?Q?lRIG0umBWXcQ4qv6BQf7HNElXSVEgn9Y8vnmdvXu7RB8XC+lpLH2R61eSO9q?=
 =?us-ascii?Q?/dz2L4K9DxMQ9V6Z0IdFpvCKi2YxIfN3Ry3chieatFwD57c31nbnBrzMrC8a?=
 =?us-ascii?Q?y0JcEPgVEzgWFtVAI8fCj/MGxa8eZV04vVNbVRua23885fD3qdeMdns+wf7R?=
 =?us-ascii?Q?WXfQ4TpAZrtCmT/U45/z8R30DL1ZGajcwgAvPwZcIClfj2ZZPiM0ILu6UCMP?=
 =?us-ascii?Q?zQQJo1KLzSJ5e1mmG3eA3UMvxLokDoins+XKIwewHS3wMk5ySLob5hsiHtnJ?=
 =?us-ascii?Q?oqwHgJr51/Rjl+K1KZJALdN2LaDD6FSYe6ohS7TPi7rr3KFX716YSLulUt+0?=
 =?us-ascii?Q?4pH3/PdBMIctqa3Oy5JjMf3HszbW00onIwbbY9WvCwR28M97njRupI1KTYeX?=
 =?us-ascii?Q?D5XFI5+vEjQZYJggU+I98SP5/zB9QFooDOhhLXUuc6Fkryoz0MpRQZV9UKmq?=
 =?us-ascii?Q?le7ZBIbUnmXyHDBRgI9bhwyrOGcmEOQ7hOaJ49hJMnV1PVujVji9l6xZdPdx?=
 =?us-ascii?Q?mFFPGIo2VNvdfsRdhXc23o1K/9jxmBxw2OvpkbN8DPyUqOyucWuTHMOofHeV?=
 =?us-ascii?Q?KGIQW4jSp3zI1YAe87pV7+M2qSXdByTnLPwCmQIQwnKkFrU8qTMvqvxfjgyh?=
 =?us-ascii?Q?+PHxE640uTFYrsFwbtSitR/azYzrl+fqiNrBTOyXLPIJNu7pQWHcJRf5o17g?=
 =?us-ascii?Q?obhJdD49Dkyav1VJ4uv8IsK3IfdK6F/xtc2wc+7qFfUVzm0dac1SPNvN3ZI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e1f20c-3691-4843-19f7-08dc2e58e8c4
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 19:04:17.6818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10135

From: Easwar Hariharan <eahariha@linux.microsoft.com> Sent: Thursday, Febru=
ary 15, 2024 10:41 AM
>=20
> On 2/14/2024 3:22 PM, mhkelley58@gmail.com wrote:
> >
> > Add documentation topic for PCI pass-thru devices in Linux guests
> > on Hyper-V and for the associated PCI controller driver (pci-hyperv.c).
> >
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---

[snip]

> > +
> > +With this approach, the vPCI device is a VMBus device and a
> > +PCI device at the same time.  In response to the VMBus offer
> > +message, the hv_pci_probe() function runs and establishes a
> > +VMBus connection to the vPCI VSP on the Hyper-V host.  That
> > +connection has a single VMBus channel.  The channel is used to
> > +exchange messages with the vPCI VSP for the purpose of setting
> > +up and configuring the vPCI device in Linux.  Once the device
> > +is fully configured in Linux as a PCI device, the VMBus
> > +channel is used only if Linux changes the vCPU to be
> > +interrupted in the guest, or
>=20
>=20
> > ..............................if the vPCI device is removed by
> > +the VM while the VM is running.
>=20
> This seems to conflict with the statement called out below. Did you
> mean to say "if the vPCI device is removed *from* the VM..."?
>=20

Oops!  Yes, that should be "from the VM".

[snip]

>=20
> Otherwise, FWIW
>=20
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>=20

Thanks for reviewing and spotting that error.  I'll see what
other comments accumulate and then send out a v2 with
updates.

Michael

