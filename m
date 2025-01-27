Return-Path: <linux-hyperv+bounces-3774-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE0EA1DDAB
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Jan 2025 22:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BDB165A4F
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Jan 2025 21:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458D8191493;
	Mon, 27 Jan 2025 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eB98/4kX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19011036.outbound.protection.outlook.com [52.103.14.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C82195B1A;
	Mon, 27 Jan 2025 21:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738011748; cv=fail; b=Z11oethUd2QcfUNtCz9C3itwC8eBLPlzvYpnvgIp1+TwcggQObE7AXqnTCNuBN6HC2ociZa7nrdGqFv6T+THqbUs3aKCeWJxJ6qZ9qzxR3Wwyy3yZRtRkyFM9mUoa81g3nnBET4yb/6ocAGYDWlGdAXMjIIHyD6zUElWtMh3x7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738011748; c=relaxed/simple;
	bh=v+FNrxzOpNKTaecF6q3bqm5UBEFqcGoy5qEQ+gV3+Y4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BlkSlqbbQlV/HTFWQEoei4nFSHTd1+CluQ93CB0EfNIBnWlQpgoMvwidHO9/gvm3uVIzFW+4eCxfQ4Cm84mivUdFQhNG23vHSYmIgngrhF6VwEQnWU7RthBCKJn7K+jWJJ3AfMbUala1tLXpmdcJcJpfxK6YVft9F0b7722rHMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eB98/4kX; arc=fail smtp.client-ip=52.103.14.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBFCdN3GP9kbhn5OeS1mZMP4QuQqJmGYjtHIyZNLnBzpyLwsTCWq/0MGZF+xVzZDH3nRdDmfF1B74pi3G3DTThm2nMlBOg0/z88dBtnWJYIEFI85Q2sysnmH/fw2BuhT/IOGZgvdmk1g6SdVOPVIwnGqDicOpRiBNp+1HYCtJ8+3g5I1q1iRY5NsBa5plZaS6RPc/3eEG24A4Cze2QtoAKw/t+dn2cU+36joah6jtR/2xaPnpe+bFAD4+dedIVF/QXzk6VL5L8i8EAEgyBxQnNv68VQE8RJfX6EEsEvpUPwnY680oiR3F8GMvF6KdNGbNVMmThSH33mtB5e/00fMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDSM4zOeWoERAi/kvijXlXwG/QQ4jr3E9I0bMK1aIfg=;
 b=FyTpSlacT5jFQUsARZDyAHbD4ok/P2qlgF6Y4XH72WZ3AunVxNsfdUpKqklIZ3t9lV+Unv3ygD1lVSbAdulUUpCvYLviYjb/+oyuOQBrPd2TjuM4WYSYPHPUgNicI3JeF1h4sXjs4hlhUGZSIzHOlphxZE2M8DVRLmZ4D7XkX2YYdJiyn7eq/cP+nrlOW0kKy06e7CjO1w2cElz/LENn+E/vxHwL64RS4vmxsu8FvcIDskbutvKKm3jThWY4AAhli6HC1JOZLe+QjuVg+zR5UV7YieE1hQYs+ZSYRc5g9xFvtN76QBRA4lTPBDv9Ny1UbMQoZr2HWIPcagRJspAnfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDSM4zOeWoERAi/kvijXlXwG/QQ4jr3E9I0bMK1aIfg=;
 b=eB98/4kX0YbmqDKV8RwsKdTix9e3KyjpBOgIVSanwsxyvEc+SSi6m0Ed5eLBWwqvZwmof/YRamlP9Dj9wnOZ5DZT3G6C9vJu/D0TP/64CusQt4Bl6Hp9CWl1RE0iJ6+HAFoH7G8PdQ/reEh7GPBj9bPyP2QUj0nT6IeiJq7mh/xXY//m81hE5sYNLCsSP6vShmCUQPXX3NlpKRj+hKonNG6WXT+NZtX6PJDhtUFUJJiF/jKAD5lmYJF4TsXKmR6h03ZDZuFbBUr8ZXx8Qnf7cleQmXjsEnD+hSJh9gdFGLlEolki1GeOy0sNltV4MalweeIQq+FruwbprlHZIkJ+IA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB8740.namprd02.prod.outlook.com (2603:10b6:303:137::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 21:02:23 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8377.009; Mon, 27 Jan 2025
 21:02:23 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Wei Liu
	<wei.liu@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers/hv: select PCI_HYPERV if PCI is enabled
Thread-Topic: [PATCH] drivers/hv: select PCI_HYPERV if PCI is enabled
Thread-Index: AQHbcOa55nOVe7vfNES2bvVQptEMerMrFbtw
Date: Mon, 27 Jan 2025 21:02:22 +0000
Message-ID:
 <SN6PR02MB4157BAAEB938E7E4E849DC7CD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250127180947.123174-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20250127180947.123174-1-hamzamahfooz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB8740:EE_
x-ms-office365-filtering-correlation-id: 43c53ca6-6572-4f03-2a10-08dd3f15e538
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|12121999004|461199028|15080799006|8060799006|19110799003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CpVkkL6k9JRpFOvSRyLUHYftor/m8KcGqnan9UlUXzVOiRCdOpgB94wfv4vp?=
 =?us-ascii?Q?eHEDhI32V4pAHFfi0sJrkCbUktLMiJnI10exMFCfKagtneIQcaNzfVHpb8Qj?=
 =?us-ascii?Q?rmIb99Y7nsSK31YHNruQgkh9A+us26Le71Wdp68MO9MracaKrF2dPVUBq7dr?=
 =?us-ascii?Q?C66ar0QB90Omx+MDz8Sah7LncA8UZhziUi95HooLZekh5nk1XmrkqquBMcyP?=
 =?us-ascii?Q?V+zWsgN83XiSV5F1F9Swvj4Py775gJsGujKMcf/m71PKjYYKJkn4Tcp8iZUm?=
 =?us-ascii?Q?sAL7PGe7m8PugVFI/JIEOB5V/qidtzCb/VkLhHKdxnplZyd4SOBJmcWRPome?=
 =?us-ascii?Q?lDx79ZEcEBpea+y5eiipuXgA6Ifj+R+D/NUzIODgeoh0aUmzMWVcvhJ8f3xS?=
 =?us-ascii?Q?VsQ1GMSVP5S7iNppVzE4dq+zZijZdcutzmfiBPOpHdeODTvfwGOoj8i2pgfu?=
 =?us-ascii?Q?qC7KmZe7VSjl1jZvpWE6zQATiZxYnKo7jmXVD/itDAbbaRCbGRh42j8C9LGF?=
 =?us-ascii?Q?FwQgf9lATAWYn+MPUTDS/heyd3Kr2D0MvMravjsximfNupYLVMQEK6xDPkSJ?=
 =?us-ascii?Q?3VwXJxJ2XRYtRrjG20me2OGgD9sGCifOj6rcwIgfPXjEtgmfwvsihbwZh4JW?=
 =?us-ascii?Q?+dzIcKw3vWAU5gQKKScOMLh4AtzjkZljjYhp/FoyfLPTK7wSuXFtn+uguJjx?=
 =?us-ascii?Q?iBgBYwiFhUybAIYA/EdiT/E7advOYhALO+Po+wLdivx8pKDwutNIbAFgD48+?=
 =?us-ascii?Q?4TQ3pv70UrnRe/K69KYJFucnzJYfSLytvguKzlKGbTYn+qID1dYYAP/tZS3/?=
 =?us-ascii?Q?yBxqeAHZWA5RwPQK6onF/31SaE5XthCVZEBTPm42XbbWAvHD8yCugf+ySyB/?=
 =?us-ascii?Q?+VMzjP0vkKEkIAcegxC+5HPdlBCppkN4QOIUpVTt7XIfYZDoyiUh3vCz51BK?=
 =?us-ascii?Q?gtcaqEbSNT/+QHKndN0VLEAFzeD84V3EIpgAgZ2/PGF7RGmXS6vCu2r/lSI7?=
 =?us-ascii?Q?P+DNyey4QrtcBAEDVpirdWzJkX2hmvKY7IYjRbkT4zi4EvhFsQwwaW3cDi0u?=
 =?us-ascii?Q?UClc9S3IRV6U1ICrVgQ67a3VnrWiAw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iVV9tYqshhQDY6oInz+eL4LOJT9QB1wqB90NuqyPFNYzTz0kt3rDBqiHD1Wf?=
 =?us-ascii?Q?KOx39iR1CmGdhMVV0W5FpRL+kOogW/pfogVaaBT/4ZJMrD5e1VR78ySTwQB4?=
 =?us-ascii?Q?iixehYVH9zaSMfsXur0dvVxweOZFBDWMw3ftWJYKgwpQDhk5HMjSTib0snS3?=
 =?us-ascii?Q?Dqm7opNCuAxFyZIB9eTcPQwyVugdauY0wsEbfc9r/8WiYHnrI9MkH2cbdWqa?=
 =?us-ascii?Q?XcDbvZ7SwszWa7QCjZa2JS1dPUrUdexW/UQoplKpt5Iiku+G0Q2RjWp9FLIN?=
 =?us-ascii?Q?f72Xxrd682n3NgX/mYiJxsQKNgGpuCLmXOSjDQphqQDzdlZ7MW7KUt5yhB9Y?=
 =?us-ascii?Q?rOt9E6MgWkSwGSeMJKlyY9DdwghODU5qGgl/dLrO1L9ElDPc3CydSdB4gX/N?=
 =?us-ascii?Q?68YlIImCj68S4nfsvg0Qqofe+E1aPbyiM4x5GS4XuYHfco9QzmV7KFWJi7QF?=
 =?us-ascii?Q?MJbdB/kpjRagKBp+1AVndlufi8W4mnQ0KNsKEXAKQcGUAb7IM8b/5klUcFZJ?=
 =?us-ascii?Q?dVldE4oF/bZrBX5+nCFoIDuTpKBg1qP8lidHrJxq2awJDO9BvWqQw1QvqYEG?=
 =?us-ascii?Q?xVqZhvxzl7kXMCYwS295JP/JeMSMl5pR31Qsjqr0LSqga6CGmfUZOB1KbQ+q?=
 =?us-ascii?Q?eHMCIym50C7xncBn55wZzqZnuip+kGgxOtAq2iS+qkYE5Sd2ip5S4rDa3faX?=
 =?us-ascii?Q?oa8HV6kddWiLwIYueaVWsPVgwgS8DRsF4ejbKrxxGXXut9yl1s3HHTouN6Em?=
 =?us-ascii?Q?By3ZTZFwKBVArxBIoslMLOC8OStW78sQ+JeqczIcukBhm4QBI3+Y5r5i5jb4?=
 =?us-ascii?Q?/5InRFMcyrWGATQPQL4OFrqh1f8Bj/fFlotKQBLbcrnd+O/ES0ZloJ91te9/?=
 =?us-ascii?Q?hgNVM4bAx7aQU/JIJWOnPe0LAH4hNqZqapUCYpbDumCAs8RDb14lWZqQOtj/?=
 =?us-ascii?Q?UqAItxGv6x0nSmxE1pyh646dxAO97tQ1ROmGCUdNBy0VnjBFx6xv/AbsQcPd?=
 =?us-ascii?Q?HJe2Oq4pLZcHvBgc9v0/KfnvpPyKdzj3UjhOly0aw9EH3FVRMSx8L3B4jouq?=
 =?us-ascii?Q?FDwLe+t8rVqoo1dJh9vL2hfaVGthmzI6InfKBTnVwBbkaC17IUpIkrmfAVr3?=
 =?us-ascii?Q?qgadrhPxGZAjkeEO2HBE8MKA2oTdWTRc2Zk0Q3/pFP14y4x35sfnEbTOJI0y?=
 =?us-ascii?Q?0nR+IpMPYi9x6otXpgRSKP4OPuNvd2wnouGWJOoHgJBKpQCT4+rtxjLeZxc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c53ca6-6572-4f03-2a10-08dd3f15e538
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 21:02:22.8450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8740

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Monday, Januar=
y 27, 2025 10:10 AM
>=20
> We should select PCI_HYPERV here, otherwise it's possible for devices to
> not show up as expected, at least not in an orderly manner.

The commit message needs more precision:  What does "not show up"
mean, and what does "not in an orderly manner" mean?  And "it's possible"
is vague -- can you be more specific about the conditions?  Also, avoid
the use of personal pronouns like "we".

But the commit message notwithstanding, I don't think this is change
that should be made. CONFIG_PCI_HYPERV refers to the VMBus device
driver for handling vPCI (a.k.a PCI pass-thru) devices. It's perfectly
possible and normal for a VM on Hyper-V to not have any such devices,
in which case the driver isn't needed and should not be forced to be
included. (See Documentation/virt/hyperv/vpci.rst for more on vPCI
devices.)

There are other VMBus device drivers:  storvsc, netvsc, the Hyper-V
frame buffer driver, the "util" drivers for shutdown, KVP, etc., and more.
These each have their own CONFIG_* entry, and current practice
doesn't select them when CONFIG_HYPERV is set. I don't see a reason
that the vPCI driver should be handled differently.

Also, different distro vendors take different approaches as to whether
these drivers are built as modules, or as built-in to their kernel images.
I'm not sure what the Kconfig tool does when a SELECT statement identifies
a tri-state setting. Since CONFIG_HYPERV is tri-state, does the target of
the SELECT get the same tri-state value as CONFIG_HYPERV? Again,
that may not be what distro vendors want. They may choose to have
some of the VMBus drivers built-in and others built as modules. Distro
vendors (and anyone doing a custom kernel build) should be allowed
to make their choices just like for any other drivers.

If you've come across a situation these considerations don't apply
or are problematic, provide more details. That's what a good commit
message should do -- be convincing as to *why* the change should
be made! :-)

Michael

>=20
> Cc: stable@vger.kernel.org
> Cc: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 862c47b191af..6ee75b3f0fa6 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -9,6 +9,7 @@ config HYPERV
>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR if X86
>  	select OF_EARLY_FLATTREE if OF
> +	select PCI_HYPERV if PCI
>  	help
>  	  Select this option to run Linux as a Hyper-V client operating
>  	  system.
> --
> 2.47.1
>=20


