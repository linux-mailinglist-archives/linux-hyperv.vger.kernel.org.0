Return-Path: <linux-hyperv+bounces-5427-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B24EAAF217
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 06:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E19986576
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 04:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE092010E3;
	Thu,  8 May 2025 04:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qWlHeqfZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazolkn19011033.outbound.protection.outlook.com [52.103.7.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A5146D6A;
	Thu,  8 May 2025 04:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746678185; cv=fail; b=mswmq8pseFzhNd48kwrCB0Mp6Z5lTP4R/spDUWWY3i3JjLZq5yQMfuDHxTeL7sBsT1FgpWYTKe5bLuoqr4uzLQW6zaY8gB4nld5v+rYbi76sWSOkxvqyx0oz3sYWd5i6eRg/FUPMXcuIFGOzC8ew1cYMtDq77R1qvomgLw0Rjl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746678185; c=relaxed/simple;
	bh=MoQ9IEFQvMnZVO4a7nmuZvOldROliE1e+JCy+OgG7lM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sHz7mAwMB8mgmQobAPBDqtA6y774pRnM71CV4/wiT5azHTiVJxADedTeb/7ettJ+dH3vo7IEwJRQiCUV6FY7rmmVkRiiCSQEMAk3DxS+v3/lWX/yLPBTiQPU+AadZtXfbgWF5S7ziuHRDTbsCOt5XUHx/T9TuWWlyJdITS+K17g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qWlHeqfZ; arc=fail smtp.client-ip=52.103.7.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwK2e1CthMz9pqI43xlGD285WlSb2dwvSlV+/G3cfjxQYc8EBP75x9KaVm5OGKhg80NyquhZ9KTS9/JCG0kp8pF6BMubk4tHrHy6RMLpmJ0k8UX1z4YS/KRIyBwOBzfM1AlWxbthNZuQW8EI9GZbHYJXIsU8gd5OuXbfdM/NkssKNA5OCV+/hE0NetNE3FXQjnF7oCTi16Fs0IAbr8uWfx3YB1Lchr3HdENJMmLLDG9nFGLyfwx17y606ITKm70DlUL/oukarzlynlhO0VNrBEIT7olWqQmSjFQ5FxxyFaL5JFwEyrAw9Unf0+S5mZhakf5Zz4VurZoGOmdaX2uxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX/xPt4NkNY132TfWtzSOAR6/3/zIc0DnOlnDXdY+ok=;
 b=LHxN/TeDnHyn8xWWmO8LmG27/QcsyD9dVJDJc8neVJUaTrXRneK63BRMeN+C68qk4vTP8lA17Bi4KJ4GkilN3KpD9TlGxyPv3gXOZP52FQpb1LUjoQuruMOm3AuTDDupz/Y3MycUHPT4qJeLQuofb2HrvQsatjRBME/JHbiaIoXORgOXzSIDFrRqfm8TY+s+yR43tyvRdGoNkK6uu2BAmTm4yu1KixABvourLe8FPrTiVaquv2bRwXtEPT59J32TaSVNdzbU2j9Xbt1ul7bac8zLUvM9S1T8i33dXgJv2IFspJORL1SlJJkHPg7FUAtrE9CBi/dtdbofLpKkUHAuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oX/xPt4NkNY132TfWtzSOAR6/3/zIc0DnOlnDXdY+ok=;
 b=qWlHeqfZr/UtxNrotExnidanWscdxhfvXcmFvI9w9kmj49VjsINjXZacxhMpgtBnL8RD3hGBhH510Nz/JF9J990dGMRp5wWYHNIDUomORVRTPhQO7bwfgkeVYmq3ZVkBXc8vmhfy9ohHUTIUwVBeA1aZW7ZbJXxfysIu1M8gX2PdEbpU9M2UQhuenKF9yeMYokpieLSQNoOj6L9EA+rbx94mj5G20z/BJLC+yZLOtvXaTF4udfxNf28Wtev93ZoLTIB2FLYnrac0Z5fCv2OQ7IVsk1/0VEjjzntxPNb2dMkn0svoLQb+soGz4WBvv/tZ/N5+nDq5P4TBI+tVtmOL/g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH4PR02MB10730.namprd02.prod.outlook.com (2603:10b6:610:237::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Thu, 8 May
 2025 04:23:01 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.022; Thu, 8 May 2025
 04:22:54 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "brgerst@gmail.com"
	<brgerst@gmail.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"dimitri.sivanich@hpe.com" <dimitri.sivanich@hpe.com>,
	"gautham.shenoy@amd.com" <gautham.shenoy@amd.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"imran.f.khan@oracle.com" <imran.f.khan@oracle.com>,
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "justin.ernst@hpe.com"
	<justin.ernst@hpe.com>, "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"kyle.meyer@hpe.com" <kyle.meyer@hpe.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "lenb@kernel.org" <lenb@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "nikunj@amd.com" <nikunj@amd.com>, "papaluri@amd.com"
	<papaluri@amd.com>, "patryk.wlazlyn@linux.intel.com"
	<patryk.wlazlyn@linux.intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"russ.anderson@hpe.com" <russ.anderson@hpe.com>, "sohil.mehta@intel.com"
	<sohil.mehta@intel.com>, "steve.wahl@hpe.com" <steve.wahl@hpe.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tiala@microsoft.com" <tiala@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "yuehaibing@huawei.com"
	<yuehaibing@huawei.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next 0/2] arch/x86, x86/hyperv: Few fixes for the
 AP startup
Thread-Topic: [PATCH hyperv-next 0/2] arch/x86, x86/hyperv: Few fixes for the
 AP startup
Thread-Index: AQHbv30AvFlZiQVtK0O6zBxge8ha7rPIHzVw
Date: Thu, 8 May 2025 04:22:54 +0000
Message-ID:
 <SN6PR02MB415715B9BE06E5B505F6DBB4D48BA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250507182227.7421-1-romank@linux.microsoft.com>
In-Reply-To: <20250507182227.7421-1-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH4PR02MB10730:EE_
x-ms-office365-filtering-correlation-id: 1b2aed28-d2b3-4071-48c1-08dd8de80118
x-ms-exchange-slblob-mailprops:
 0wLWl8rLpvtDJkhNY0/IVOpfW0xPqUJOTk7zwylWV3htrpHFbmggHdz+OmfMVkJmPPvx90vtn3TtvQlMMINqncXA6pOnUQpufcHk7zjMjBfAtG/qOmt5pIqJbqyfzhJ61asIkwLAgST0500wVSaApjXAQaHtoIJIfXcZjm3FVTxM0+H7sc3y2jgpXX8clNT3lHopVPyikzk0Hxh/vm44saLyqphIxzQ5leZVtWOp7RZv1ihdN9mFTAf0CHNn0P9qYY26mG/ruu5L1GciuURFd66aAdwLf9kuL9/iFC0nL198TnM2uKze2FGE3a1p+kbFzaPQcmBwr2BVXAGpeHNu81okGH4rSeBdhSaDX5hPkMClhzyhh4OL4LW0kJULavXA6XiQYD25QjAqTHxJzpQUHbj2W7YZGUeZ4W2DOXd8L324gbMxvD9yLmPQiCKnvsOsGX3kEjXerRElRfJNwuGcsoWao+f1VGKhkomKS9TjBv8a9SpIiynwVlfcwF4dEWFGNDTmhBeu8VAIjFrLmNLdh59/gMA1r9DlsVg04+hqDJYLNiDb1pWpaKjw9ipLKq+nvu9oRTqGEWgv7TPGCjn3kEozmf/Q21ivM68V/GG67BP6vW31pUoyFbYTQ0NG5+wFBSus5ukbRSpO+Jhch9+DKnUnC+hSsZige/MhmQMjtH9dCEv/hA0snZsLPhpKFo1VL8vj3qMrAkBYJd0OKqXhClYrIztqz+lU6+yyvOUOOBWD/1fhUHp9dNE4qQnXZO7FBSajbOEi4MY=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799009|8060799009|8062599006|19110799006|3412199025|440099028|4302099013|102099032|1602099012|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FIW6lTb1PoBU27ahCoqu4pVDpzFQBemFBKSasTbnWfTNxiqs0ssCsh6T+bKg?=
 =?us-ascii?Q?LHUIWMz1JeCZcB0PR2NHvfHBBnB0jhloRe3DvqDDJBCSDWhlfEVTLZkiZWya?=
 =?us-ascii?Q?Qkhi+L6hpuLhrAZwhlqHLfFSE89UHki3/qeOxwExYuilsumCBnLCI8rVcqO/?=
 =?us-ascii?Q?3Zc77ViQfkNQq0BfTBelrxpnnSvGKbNZhpdRY6YndID8DSAOuU7svooq+e52?=
 =?us-ascii?Q?OdsL+TrStTHTVtIP5fZ9WJQusDfmlk8ak5HUXkpZ4geqbD529NLYIKUe6mec?=
 =?us-ascii?Q?kQSEdfiEZoTvTZlPaysMZ512PF+RmXR+3X0D+b/DJzx5oBu3lrRzhYEMpXua?=
 =?us-ascii?Q?Chh015sOitaXiHGbhP+YnQRiz69XvJ7u7YDnxnqq/qCxlH58YeR5Z69nhlAj?=
 =?us-ascii?Q?nMGWDtIkC6wZnKlWsoVmONkV6DMXdRTYKgt5bn0cAXCeZS/bsC7djfC4cCkz?=
 =?us-ascii?Q?khjDYpBPeOd0hkzbUaP62kf/5oqwPWv4z0wu1/TafmEQXrtKl2Knra05cpu1?=
 =?us-ascii?Q?pAjdjFoeBMbOVMAJd8fQ/9MtIw076vas5q1olTDr/ElzJn5W6UpTNz8FpWE9?=
 =?us-ascii?Q?gS0gELXO9LGCw+UDELDaurl7esL1LZn1b3VmjzJP4RrF87Xc41HNzniCPk4E?=
 =?us-ascii?Q?ubKA32bmBn0QSdTTKx+xtb4Kmrf7FjAt49jVTrVubcJE1WrjqoMa5/50c3zd?=
 =?us-ascii?Q?3302U08VYzaP86DLarDjJKFbZ4+WftIdF3gc4k1Fno9Sfy9TZnJQ0z0ALiVc?=
 =?us-ascii?Q?pn2mgYGMVzw3j3UmXSYpKu1rmqM03JtfTTK19Y+zWX8hSjPC4dILEae8sWCx?=
 =?us-ascii?Q?nkOI/Kb5nCJOJlEeTQMN44pgmwbrzdMsTW4ETw8Y+idG9WTfsoE8YMZHNTZP?=
 =?us-ascii?Q?g/FLCDop3UlaW2kOBPHC0q70YR9JknD6dcpABQDMKYTlWzkxrYgzFUa6Me3u?=
 =?us-ascii?Q?gsfsCdsmG2wNTjPaqIRBZQXw+tdjOh9lVeJeyODJW79y0M/q+WQSDhGVo0E5?=
 =?us-ascii?Q?rLC1ppkbsiV88J45ejaR00rzLLf7FLo48bfsLu/aWf7S0mxDH5t3dNjqI0Mn?=
 =?us-ascii?Q?UbqQaugv3kbseu/wMJvsd9XFWIdBLw9wi3nH6qEVdY1M5LBlnxs0OvI3CPsP?=
 =?us-ascii?Q?alXRSpWU5bZVE4GdoWxTDv2Dt2Qgvm549LAxYCmyoGywJexdwmqNRCpQl249?=
 =?us-ascii?Q?noO595AzUplmMt/82ya4UTVI6App1O1gAAJUiwkSY6HUrPcTOMFoaUOBBTao?=
 =?us-ascii?Q?g+da8q6tltu73UI0UBgk?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gG+m9gDz0qFuApJ+S4AtZgfWF74ZfbaLjW6B7FieudSCCL+2PXrNFJ3zoCXz?=
 =?us-ascii?Q?QSF5JDPA9s/XKUj1P5PZFpE2pFSpuWitkGw56vhmwuUVlS8q9sL7prV98NA4?=
 =?us-ascii?Q?znU2jrRLul+19b1MUBM1xhe08txljF2aCrBix5lIrgPHZm8NwigRPfepyInW?=
 =?us-ascii?Q?k90cnzz0Byo+pbQgat/5rGz3Cafxm8OtsYGvCaeImhosEUQek1B+xweqdfJL?=
 =?us-ascii?Q?KNXALPTnzjl1kYNSXpOnGyhUQyo3YB8AY3r5dciSQtE6vyKE75ISTn9FL7fX?=
 =?us-ascii?Q?OB3KZlXqpyLEk5SII0Akf+0ait3pNOzjRDAhd7zXDwmP0GqD/NQZClLTK4mk?=
 =?us-ascii?Q?7pxftU2TucfZ4TZFYOcCsUBVoZr5CWrSitFMAM5DoxzoY8zPHgQ09GO5+BA7?=
 =?us-ascii?Q?R3PwBrr1xYzDPiZclgYlXA+0Nx1kZY5ca/VzwYirxh38U4BW1nVtDRjzv1+Q?=
 =?us-ascii?Q?5H/6UuS++gGkrX4dkNifxx6buYZnJFMHBTyoIo0KuhylD27vJhXv2v/c2d6j?=
 =?us-ascii?Q?xjmKCKXnkv639bTvtotR9IvCMd6CsZoi4hFViRdz440nc/uz7OMBfc20qHVe?=
 =?us-ascii?Q?iH7nT99mjXdOcKA7chNqi81MaBDD9jqHQeFqDye6fG1ddJ+ZIclUNCmKMCmL?=
 =?us-ascii?Q?0v3lflBgmyRMG7pSL+J2TZmCvOFdHY8HHygwMT49hEK0EnARCIRXllRRX7Et?=
 =?us-ascii?Q?91gtuEQSlSPb3AeQmR4izTzOyv1RBvDPLBriJHm0rtRDXc1Np4lbHxFBtJLD?=
 =?us-ascii?Q?nzOBq2lDYmo9nVao2QnSI0KiKVcgQJ5p0+2B4LY67PMgtgHqRQE649bxweoF?=
 =?us-ascii?Q?Eqr4AVigm5zBvbDA2oLKH9SbUQGRVMHmwGYprZrL1GMA3tCYXYiHduezYGg2?=
 =?us-ascii?Q?GyKPQWn36h+oN6kNiAvdxBkfjsoiCTfNMx10TD/+HeoWvoygSBMeHG1l5UG+?=
 =?us-ascii?Q?pjBHNnoDjNcbaiBblsZ3BUzKMPI/1T3w5cC3IrMBY9i9ntu6hrrUlAx8JxGx?=
 =?us-ascii?Q?mVjilkeWzW9TTFmJJ3tMzLKCmHJi45bdml17gSQ36+3+JeJ3cgxnxwOrGKj3?=
 =?us-ascii?Q?Xjn/HAAaQSM8wstI+TViod/iZgGW0A3ZSQEn6AOyf91rBpM2DHHoJvtNQ5W5?=
 =?us-ascii?Q?EPLJuwpNut1Zg7SMibBhMQGOsIPAPqIPdSIiL1YikbgH2lX4fy7B/9AbKMj4?=
 =?us-ascii?Q?Nkj3JT6yMVG0gWhm1vXzL0E4fjpuyscxmZE8brS44etGtn0/VPZRpkmlIv4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2aed28-d2b3-4071-48c1-08dd8de80118
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 04:22:54.6191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10730

From: Roman Kisel <romank@linux.microsoft.com> Sent: Wednesday, May 7, 2025=
 11:22 AM
>=20
> This patchset combines two patches that depend on each other and were not=
 applying
> cleanly:
>   1. Fix APIC ID and VP index confusion in hv_snp_boot_ap():
>     https://lore.kernel.org/linux-hyperv/20250430204720.108962-1-romank@l=
inux.microsoft.com/=20
>   2. Provide the CPU number in the wakeup AP callback:
>     https://lore.kernel.org/linux-hyperv/20250430204720.108962-1-romank@l=
inux.microsoft.com/=20
>=20
> I rebased the patches on top of the latest hyperv-next tree and updated t=
he second patch
> that broke the linux-next build. That fix that, I made one non-functional=
 change:
> updated the signature of numachip_wakeup_secondary() to match the paramet=
er list of
> wakeup_secondary_cpu().
>=20
> Roman Kisel (2):
>   x86/hyperv: Fix APIC ID and VP index confusion in hv_snp_boot_ap()
>   arch/x86: Provide the CPU number in the wakeup AP callback

I think this works. It's unfortunate that Patch 1 adds 11 lines of code/com=
ments that
Patch 2 then deletes, which seems like undesirable churn. I was expecting a=
dding the
"cpu" parameter to come first, which then makes fixing the hv_snp_boot_ap()=
 problem
more straightforward. But looking more closely, hv_snp_boot_ap() already ha=
s a
parameter erroneously named "cpu", so adding the correct "cpu" parameter is=
n't
transparent. Hence the order you've chosen is probably the best resolution =
for a
messy situation. :-)

Michael

>=20
>  arch/x86/coco/sev/core.c             | 13 ++-----
>  arch/x86/hyperv/hv_init.c            | 33 +++++++++++++++++
>  arch/x86/hyperv/hv_vtl.c             | 54 ++++------------------------
>  arch/x86/hyperv/ivm.c                | 11 ++++--
>  arch/x86/include/asm/apic.h          |  8 ++---
>  arch/x86/include/asm/mshyperv.h      |  7 ++--
>  arch/x86/kernel/acpi/madt_wakeup.c   |  2 +-
>  arch/x86/kernel/apic/apic_noop.c     |  8 ++++-
>  arch/x86/kernel/apic/apic_numachip.c |  2 +-
>  arch/x86/kernel/apic/x2apic_uv_x.c   |  2 +-
>  arch/x86/kernel/smpboot.c            | 10 +++---
>  include/hyperv/hvgdk_mini.h          |  2 +-
>  12 files changed, 76 insertions(+), 76 deletions(-)
>=20
>=20
> base-commit: 9b0844d87b1407681b78130429f798beb366f43f
> --
> 2.43.0


