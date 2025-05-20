Return-Path: <linux-hyperv+bounces-5565-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C87ABCCDE
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 04:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627383A4E3B
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 02:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2662561AF;
	Tue, 20 May 2025 02:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h0ccmubo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012056.outbound.protection.outlook.com [52.103.2.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5745222068B;
	Tue, 20 May 2025 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747706873; cv=fail; b=UIY9+h3i/dA3OUdBjuXZy0h2EEdD0gdosWxeRrFgLbjn5j4CW4l4i0tOA9f04WVK5jRiy53igQ1ikbUF9XIKb+9W5WJnuB2lE4Q49bk+YLCkM1DuQQNnCl98okpbzZkljs/U680VKP59Q2oAn+wJuzU8wYDk5H1DlkQEiY6tmeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747706873; c=relaxed/simple;
	bh=9FAcd9wuxmJgfR5XZQFs9dQ/SANyw22bRcM+GZLVHG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rEn990M1+RyU95kznANW/f7MU9elzlsL+oiv12NLNOcq9hHOeMufbcalC93WBRNLvk0IHWnSWw9s2QDfZ23j7H0nMPiQ2OFkELN5WgXP4uLx2pI9X1ToarDZn0n2v6TBy3NhXwsKopygp2RLQXzlnixGiOSekk5LoxrwEEj1QgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h0ccmubo; arc=fail smtp.client-ip=52.103.2.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJKbPG/AEPW+JaIkhLQPrfm+8e+hUo/PYDqGtWDCIj789zxx7P8qKRtOZHHOlAVHf7JEshXlA+J/3p9JagJq7pPh+9/7C+h5in5JL1qcJHI8fjkO0KfaTMvmZD7IsdhWygDkXYfOv2CYQadhGt73/4Gyh0A20GJ7BofdyWgliETMtIN+5aGGlEQHMmemxJ5tHdfFPDFgMJy+0axXh1hfvjAvIajNJsJfkeP3zeEz0v7dL1QWelDzqdeK+sgSXPcF/pzltRtCoVtfqdGQeaHOXrdhI1yi+dmI/gJDfjHxyoMVDGSvhLAXkQ84vps6Olbvm2qBFmzkIx2P5Q7dvqk4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqSMrRQTONs75Obmb8JJkTRHESiDIi6In7LCNp3+tk0=;
 b=u6iMoBpiRHX5jkISeVtgJaUVGaRtB19ltMatZetQ3jYfi3pgR5AXW3KRGhzVbCe88lk18s7gm32ci9kroTAMBrVFD+/uGobgtqOkJPNRgP2fOCfdY00NSbFwHhnaK4hZBYywI3sYBuviYjPpdjwe2c+ONfliQ7tFRJt8vXkGOQ0WtXB6/5AtCZnMMhoehhbXcirrNX84U0TNL5QHseyXKsVf9MgCbuDhr1OtLIY65IPAsPA1S2/j5fvSYdUU9YZRRkGSwAvmWeS5BjTjSkiwf8TAEjaFOTL+XIyXT/JtyrqRdQabWL1vLHF/Sx5T+sD78mMIFarFgP/jaUV2LzOwDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqSMrRQTONs75Obmb8JJkTRHESiDIi6In7LCNp3+tk0=;
 b=h0ccmubosUlGIIGRCTqPH1cRhln86K3+hv605csrYDDFJHwEObChRSgjSRPjyCKtzx6NryFw48b9RkeKJmMHNsxlLTLusS+hvuvmANX1skksWZhGVkYrLps1+aG+RbWWKhOI8FWZ4TJJNG1lzqloCDoqzblzr86JXTp0Nv4rkAbLfGm4H7hfagF1MJV/3YGMIRWRViQ4BkLcwQHByLpxsUsDmcELQc4DnW0sb+m/EDidCW5Xf1W0Q2ns/bqUiocZaSvCkZbUYi6m4XJx8+q3A+87JWsinG1yZC3Q6u7uXS6WqYRmkYV9ZoYK0T4nEgiqMXyejHFnJjQK21wyw1mF8g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6646.namprd02.prod.outlook.com (2603:10b6:610:a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.16; Tue, 20 May
 2025 02:07:48 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Tue, 20 May 2025
 02:07:48 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
CC: Saurabh Singh Sengar <ssengar@microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"deller@gmx.de" <deller@gmx.de>, "javierm@redhat.com" <javierm@redhat.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 1/1] Drivers: hv: Always select CONFIG_SYSFB
 for Hyper-V guests
Thread-Topic: [EXTERNAL] [PATCH 1/1] Drivers: hv: Always select CONFIG_SYSFB
 for Hyper-V guests
Thread-Index:
 AQHbxr50JRYwwviVjkKTy5BtFNRPi7PWPWqAgACTq0CAAC7cgIAAKlIwgAMFvACAAJVKIA==
Date: Tue, 20 May 2025 02:07:48 +0000
Message-ID:
 <SN6PR02MB4157FD9AB9114C8DD6FF4B82D49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250516235820.15356-1-mhklinux@outlook.com>
 <KUZP153MB144472E667B0C1A421B49285BE92A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <SN6PR02MB41575C18EA832E640484A02CD492A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250517161407.GA30678@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB41574848C3351DD1673A2855D492A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250519165454.GA11708@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20250519165454.GA11708@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6646:EE_
x-ms-office365-filtering-correlation-id: 8aa4a33d-df62-4901-c2e8-08dd97431e6e
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBu6m38okHpoNWln7NSyvc1VWe1hxfoIPGRtTkjcfRf1f6PjRxR3k6N5ZVQrqksfKaQtDjsZf+fKAg3gC7dzU8aS2a/l7aJduvqtPYuw7cX8Pcv0h682oO3FWpo+K2PITwogY1nIekWtpQo9grA5VU7JqTm6DG5rZgv/tJzgdL75a9PRrdQcG+DgtYXlyM+fFORPthLq0o0XwnaKEG+YX2HCzmK9KqLRYQW4qorzLqvPF/FRZo/tDGrICMo6IcjfWj/Ouu0pxaGCeA/iJTOFjp2p924i1BEB/otVasuoznv1EBSDLgk7/E+SwVbq2LP8F5edAXVLcFydIJ5ThD1t22ZTrrXn4RqbFNXlu2GpLOA6G9T+Xq9ilHFb7aDpEqt1VVwi/H+fJxHXL1AX+Zwh6FJKd+0RqgG56fD7om5Kv3ouoJzykkFd1STfIqlur60o+SiVUPRvCZ9dwseLWOJVOwhXD+V1IQXqfjcKASu+Ml4KHp5xcHq9P4yVbC1yTmTuBqocw3suqT3mM4IL5y3rBCzvHKq24acn4dE6jiO0awETD86PZU3i7Z5STAV1SNsFTVhGIWP1SXi+1n9pDBmRu9GbY9Y8r4PLyWOIRrZB2dsjDUtHF0PRyuIC7SvshoPuisiSsJgO3j2U1zXFDVDZUQFhfh6u48U7Xl41MVZMsAzik/e6iFCoEKjSOjTXLrVSVCE5xpfUljBBYjzlIMgSPSwIgJrrnMMD4xpXLwOaG0+avlaePlXLDoV4L2V7kdTPueOqG0BBiZpD82I1VOzihdT1
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|41001999006|15080799009|19110799006|8060799009|8062599006|4302099013|3412199025|440099028|102099032|10035399007|34005399003|56899033|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?p8cjW23vSDrJs/vT1kwqgVwDKf1mToAFcjsqPLG2QREosKzX0VtFnZ883dR3?=
 =?us-ascii?Q?zdb+uV0bLi0BHfd1Cpppz5mLY8UkWsjay/g2D3XttzQJ9cKo5dF7kSguR6UE?=
 =?us-ascii?Q?2EB3ng7ZsspJMm94fRLcmykFmoeXc1LRqAWk8zXurpYapcTINbRw5dk8J7tJ?=
 =?us-ascii?Q?6RwGIC97ffQussNjmpPFS0lzjXr8fH0Gb9WnklZxW8TUaVUNUqfYiQjvOREz?=
 =?us-ascii?Q?mgBxSspWGHsBGPgRAW8hpzLZvwgYGUml+oVejTpFG8WEVCrW6yl+O/NoJ6vZ?=
 =?us-ascii?Q?lGW7XGbjxh72KChM3mGbPiRbNZbYpz6rboj9FXGv5tmd+Q8+a5dOmgrFhe1h?=
 =?us-ascii?Q?nPEJLBMasg715HkbHPKRhvcfSE9/BnqrKdVsa/HBmSWEVbJ71qTjDrQuvQfI?=
 =?us-ascii?Q?MOeFbtV/4XgveDYFxr9XmJ3kNtu5LTMoe7wWV6HrFTRzSsfI/AetfTCPEdRS?=
 =?us-ascii?Q?9O7SlkVwQImQhjmao7OVwiHDKCFSlx5fDzLk5LWszgaGuKMMLP2cSIy+QEDS?=
 =?us-ascii?Q?fqV+lShLLLE49aeSWPF9pI12TUNAlSCub8EKS0s3P3JKHAOhZnR1ktCeBwsK?=
 =?us-ascii?Q?aBjWorIh1sAzFWIWpfE5saCSj7HMgzK6AEhpCASkBDVDuwe+7ByHCs/klGAO?=
 =?us-ascii?Q?GCSluh5Ayg0z0oY2uP7B6BsTJC/1ip1zSY1Pd/Gm8WHteQ6/2QgXCNUPkNtv?=
 =?us-ascii?Q?VXhsw6R1D6d6G/VXBpM2USE3klwfNvWEmCvvRCWmg7fmPb8gq2NTdTpKkhEp?=
 =?us-ascii?Q?19v0lr3Q11/4cI7bpsHinftwEvkzKzldjrCH7SYOnf7eqAUcQf/RsqquleCe?=
 =?us-ascii?Q?RSvHrmKURt8LZjk8bm4pCvqyW+uQuc1sMLXLzCY6a6R5YZHr9Of5pTFHgG+v?=
 =?us-ascii?Q?9YjCkRhdz9ZCsB+LhUVBj7wpW7UyT1dwvRqgCj5gtgowd8pmqKF+oyN6Hmzi?=
 =?us-ascii?Q?/IZVh7MH001qcl/BHT+4aLKdtK5GLvM9DCss4sd1ighYQiIngqGisdl8H8Zb?=
 =?us-ascii?Q?q0SUub6K9BFUFIKVAI18XU02xSKCu2bgG/qtqer5imcNFPbolzrXNiR9c2qi?=
 =?us-ascii?Q?0mOHwsix6tHM+H2dtl2NinjsuuVSX+gzdkW4WfHwSuLKjhFWJ2A4Jp2BatTs?=
 =?us-ascii?Q?d+TQxWVJlroBdyTMd7YsVwHx2LxAurPyPT8qyMved8l7JELSGrqhy0vSkz+X?=
 =?us-ascii?Q?85j/v8MmZftdJlrUG+PwoOgvX+GhtcmRssCr9rG+SEvgQJA3f27Sretas+rw?=
 =?us-ascii?Q?WkF1dHuLLaKSWBGDGrhD?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?h36d/GvOL2wmZxE93c/RaPdRY8/jeGsgGng68W5gk8P9Ol8eE7FmVIAFuubJ?=
 =?us-ascii?Q?G6ERJ4K1AN5pJG8azFahWeNb9rxqJlCFL7/bZWT1Jow6YQ06exbKQPxoIPaa?=
 =?us-ascii?Q?wfieQod4XI2HfgMprc72q29j6r4JWPJ84BvB4Yt02m9oVh0V3KaTssk5rM0M?=
 =?us-ascii?Q?fZRGxt12/6ITioWU5cgs8u9MEQSsxZOZIFfwg615Z9RfknvxQWNXfj0Qe5y+?=
 =?us-ascii?Q?14mhnCv1/T3Nvipm9eMMpGMcudawWvyIn45rpVDYv41JCujLIowMVU0HaJR2?=
 =?us-ascii?Q?IlhsR64ln7br6QTLw2j2NGkbWUB8GQ6FbQ64YmaMTAq/LXFeBhu/neQt6xcc?=
 =?us-ascii?Q?IRA+tQ5H0EZW7ilz4POd+nd/OgiBViyvhzCqtEMBWJgxyXnHN0SWoPB4L7Pc?=
 =?us-ascii?Q?Jdj4f+719CE/I83YxiMGUkg34Yz8JvLANkDfGMxB9otQXNktZ+Zn13jb15bN?=
 =?us-ascii?Q?2t+rDij2bmhZ1hcYpdIq9RXOB85baJ+epcwmhp957CPzbESDbloU2/Nzou8i?=
 =?us-ascii?Q?ZiGqRKKDBjCPmYpecGuUlfTSPEkMNdPR2zWNwCa+pL7L8J13SAFAWnN3cNVW?=
 =?us-ascii?Q?jPrFG74ExmeAzPd6EjimuB8peEG6g5pXZQ6vhMt3GR8vFEELjiODUgwl3Hwt?=
 =?us-ascii?Q?FzcxA/bZf7AV0ylr8WRJ3oynh0YDQPZFdfu/X6YWr8nCpsOD6uWzfKvFowUI?=
 =?us-ascii?Q?EYp2e2x2Pjb7IzRJJiMZKyHo3PyzPpAJctwy5MaQUFewQJlayQEG3NdmsWm9?=
 =?us-ascii?Q?LbQ4QtNenP6HAYOKRiBfzZ1iFDmxdf4oontFk6yULRD8oh1axLpK5nTAAvsX?=
 =?us-ascii?Q?lCNL84uFkqRAQ1QwMHHaklcHvck3zARtA5AQ/H/f3IgZLYdU/1dBacfP569y?=
 =?us-ascii?Q?LPbzCOph/9gzBFvfOzgbNnBSQdvVihv+HbtVOodMOEKaAP9H72VZOwTlAGRd?=
 =?us-ascii?Q?M8yd5s9ZuO1jBBtWmyyz/ixv+4f+b0nqiqyYDVc9zkO41yWUsxpswah7AKvI?=
 =?us-ascii?Q?kNrNY0wdgr1HSAmqRGt21JFODVsR1z8T2vBIKtfcVUGqSN5gn5hiZ7aoaq9C?=
 =?us-ascii?Q?vyIkn/NSchWJpCOeWLhPeXwIIZ6wfLKzgbrJDcuhX1i8e8LnrT9X/WidFV1r?=
 =?us-ascii?Q?3zEsuxi8sF84aD3ra6ig5pIz2c9u9rNI60rUNQWh8eL8na/KU2HRcVBv7E/j?=
 =?us-ascii?Q?/CUYJPMJ1zsAhGq6Oqz4qa8lp6D7o5Ba6x8Vw6k1jTLaJ6Qm3/M2SVs0X3U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa4a33d-df62-4901-c2e8-08dd97431e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 02:07:48.5569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6646

From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Monday, May =
19, 2025 9:55 AM
>=20
> On Sat, May 17, 2025 at 06:47:22PM +0000, Michael Kelley wrote:
> > From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Saturday=
, May 17, 2025 9:14 AM
> > >
> > > On Sat, May 17, 2025 at 01:34:20PM +0000, Michael Kelley wrote:
> > > > From: Saurabh Singh Sengar <ssengar@microsoft.com> Sent: Friday, Ma=
y 16, 2025 9:38 PM
> > > > >
> > > > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > > >
> > > > > > The Hyper-V host provides guest VMs with a range of MMIO addres=
ses that
> > > > > > guest VMBus drivers can use. The VMBus driver in Linux manages =
that MMIO
> > > > > > space, and allocates portions to drivers upon request. As part =
of managing
> > > > > > that MMIO space in a Generation 2 VM, the VMBus driver must res=
erve the
> > > > > > portion of the MMIO space that Hyper-V has designated for the s=
ynthetic
> > > > > > frame buffer, and not allocate this space to VMBus drivers othe=
r than graphics
> > > > > > framebuffer drivers. The synthetic frame buffer MMIO area is de=
scribed by
> > > > > > the screen_info data structure that is passed to the Linux kern=
el at boot time,
> > > > > > so the VMBus driver must access screen_info for Generation 2 VM=
s. (In
> > > > > > Generation 1 VMs, the framebuffer MMIO space is communicated to=
 the
> > > > > > guest via a PCI pseudo-device, and access to screen_info is not=
 needed.)
> > > > > >
> > > > > > In commit a07b50d80ab6 ("hyperv: avoid dependency on screen_inf=
o") the
> > > > > > VMBus driver's access to screen_info is restricted to when CONF=
IG_SYSFB is
> > > > > > enabled. CONFIG_SYSFB is typically enabled in kernels built for=
 Hyper-V by
> > > > > > virtue of having at least one of CONFIG_FB_EFI, CONFIG_FB_VESA,=
 or
> > > > > > CONFIG_SYSFB_SIMPLEFB enabled, so the restriction doesn't usual=
ly affect
> > > > > > anything. But it's valid to have none of these enabled, in whic=
h case
> > > > > > CONFIG_SYSFB is not enabled, and the VMBus driver is unable to =
properly
> > > > > > reserve the framebuffer MMIO space for graphics framebuffer dri=
vers. The
> > > > > > framebuffer MMIO space may be assigned to some other VMBus driv=
er, with
> > > > > > undefined results. As an example, if a VM is using a PCI pass-t=
hru NVMe
> > > > > > controller to host the OS disk, the PCI NVMe controller is prob=
ed before any
> > > > > > graphic devices, and the NVMe controller is assigned a portion =
of the
> > > > > > framebuffer MMIO space.
> > > > > > Hyper-V reports an error to Linux during the probe, and the OS =
disk fails to
> > > > > > get setup. Then Linux fails to boot in the VM.
> > > > > >
> > > > > > Fix this by having CONFIG_HYPERV always select SYSFB. Then the =
VMBus
> > > > > > driver in a Gen 2 VM can always reserve the MMIO space for the =
graphics
> > > > > > framebuffer driver, and prevent the undefined behavior.
> > > > >
> > > > > One question: Shouldn't the SYSFB be selected by actual graphics =
framebuffer driver
> > > > > which is expected to use it. With this patch this option will be =
enabled irrespective
> > > > > if there is any user for it or not, wondering if we can better op=
timize it for such systems.
> > > > >
> > > >
> > > > That approach doesn't work. For a cloud-based server, it might make
> > > > sense to build a kernel image without either of the Hyper-V graphic=
s
> > > > framebuffer drivers (DRM_HYPERV or HYPERV_FB) since in that case th=
e
> > > > Linux console is the serial console. But the problem could still oc=
cur
> > > > where a PCI pass-thru NVMe controller tries to use the MMIO space
> > > > that Hyper-V intends for the framebuffer. That problem is directly =
tied
> > > > to CONFIG_SYSFB because it's the VMBus driver that must treat the
> > > > framebuffer MMIO space as special. The absence or presence of a
> > > > framebuffer driver isn't the key factor, though we've been (incorre=
ctly)
> > > > relying on the presence of a framebuffer driver to set CONFIG_SYSFB=
.
> > > >
> > >
> > > Thank you for the clarification. I was concerned because SYSFB is not=
 currently
> > > enabled in the OpenHCL kernel, and our goal is to keep the OpenHCL co=
nfiguration
> > > as minimal as possible. I haven't yet looked into the details to dete=
rmine
> > > whether this might have any impact on the kernel binary size or runti=
me memory
> > > usage. I trust this won't affect negatively.
> > >
> > > OpenHCL Config Ref:
> > > https://github.com/microsoft/OHCL-Linux-Kernel/blob/product/hcl-main/=
6.12/Microsoft/hcl-x64.config
> > >
> >
> > Good point.
> >
> > The OpenHCL code tree has commit a07b50d80ab6 that restricts the
> > screen_info to being available only when CONFIG_SYSFB is enabled.
> > But since OpenHCL in VTL2 gets its firmware info via OF instead of ACPI=
,
> > I'm unsure what the Hyper-V host tells it about available MMIO space,
> > and whether that space includes MMIO space for a framebuffer. If it
> > doesn't, then OpenHCL won't have the problem I describe above, and
> > it won't need CONFIG_SYSFB. This patch could be modified to do
> >
> > select SYSFB if !HYPERV_VTL_MODE
>=20
> I am worried that this is not very scalable, there could be more such
> Hyper-V systems in future.

I could see scalability being a problem if there were 20 more such
Hyper-V systems in the future. But if there are just 2 or 3 more, that
seems like it would be manageable.

Regardless, I'm OK with doing this with or without the
"if !HYPERV_VTL_MODE". I don't think we should just drop this
entirely. When playing around with various framebuffers drivers
a few weeks back, I personally encountered the problem of having
built a kernel that wouldn't boot in an Azure VM with an NVMe OS
disk. I couldn't figure out why probing the NVMe controller failed.
It took me an hour to sort out what was happening, and I was
familiar with the Hyper-V PCI driver. I'd like to prevent such a
problem from happening to someone else.

>=20
> >
> > Can you find out what MMIO space Hyper-V provides to VTL2 via OF?
> > It would make sense if no framebuffer is provided. And maybe
> > screen_info itself is not set up when VTL2 is loaded, which would
> > also make adding CONFIG_SYSFB pointless for VTL2.
>=20
> I can only see below address range passed for MMIO to VMBus driver:
> ranges =3D <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;

I'm guessing the above text is what shows up in DT?  I'm not sure
how to interpret it. In normal guests, Hyper-V offers a "low MMIO"
range that is below the 4 GiB line, and a "high MMIO" range that
is just before the 64 GiB line. In a normal guest in Azure, I see the
MLX driver using 0xfc0000000, which would be just below the 64 GiB
line, and in the "high MMIO" range. The "0x0f 0xf0000000" in DT might
be physical address 0xff0000000, which is consistent with the
"high MMIO" range.  I'm not sure how to interpret the second
occurrence of "0xf 0xf0000000".  I'm guessing the 0x10000000
(256 Mib) is the length of the available range, which would also
make sense.

The framebuffer address is always in the "low MMIO" range. So
if my interpretation is anywhere close to correct, DT isn't
specifying any MMIO space for a framebuffer, and there's
no need for CONFIG_SYSFB in a kernel running in VTL2.

What's your preference for how to proceed? Adding CONFIG_SYSFB
probably *will* increase the kernel code size, but I don't know
by how much. I can do a measurement.

Michael

>=20
> I don't think we have any use of scrren_info or framebuffer in OpenHCL.
>=20
> - Saurabh

