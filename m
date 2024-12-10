Return-Path: <linux-hyperv+bounces-3457-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A0C9EBA80
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2024 20:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3488018892A3
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2024 19:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E211226871;
	Tue, 10 Dec 2024 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QDG8s910"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010075.outbound.protection.outlook.com [52.103.2.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D88623ED48;
	Tue, 10 Dec 2024 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860724; cv=fail; b=SBipTGu1FGzwG8YOGegavEFpee+v0oksFo3ePLM3insO8y4XoPIIZNuNAOCQJk/WxRRrLX47ArhrY+B8dwBp+79Z83JIuo8Xo2kVye2nJhnLNlWiwtDex3k6JErxNd22giBYOMexPhhvuQx5Cp+wtdOOzw4rW0VJ8SVtlGsp7uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860724; c=relaxed/simple;
	bh=rsir4y9dY0qX6cx/97IfXoJrBveY32kx6i2uH3V3AKg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jnqTkpwrVu3zKWMC88US5/sH+hhZtn6bEeSsE3nlmrLdF4SvRA6zbBTsMCWRgtCfzMKypghg8vNuIl0jIbAImkQmlzipGDyVZlHZIa7gsHmpobi1tE3hpjGRDl0Kt1rmF8DwnAUqwRUb27WjFzFLXAp88kNoHG3XWnHeCCiQyCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QDG8s910; arc=fail smtp.client-ip=52.103.2.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwF0aiLSRlEwKZkvj0phQPLgZfUNecbeSY/UYOrW17lLBc0aYuV4uMT33KiBM5OGxS0UcEaaDyCEOQ1tDj91Pd6l1NECYvVz+jlaND9u5E+Mc1zYVhvniMa1IllcVuoX9cJvDDkJlVqMucEsYvNzCuDQV7y+skeNbgxTWUUp3nCNiBlGXdR5ELDYDFiCI9E2HIQtYtJuimVkXUNscZ6O6l1qIMXK7jiufgyrut+JaeHr6J4QuWQmsyRI3j3DiG67YLFELA/wmWNpgRWFc8mtbC6nNLcl5TKb9VH5ji7tANpGJN1R1vRVg0LDmLfNKGLS7tsR6YU9Pc2ObLkDgCsLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rW79KDN71mrQeWuryG5j6P2hFF73Mc+W/MLHW6rtq/U=;
 b=XCZhRxGY+wKdTvf56qfkMTpTLlAS8EoiPAEo3GxfR2npNHnhf2FgruZsWVvgY3g3oRCnmd0LFQDppzYLwFadmcIQmibC2ZXPiYcDtGe05kPdosSvNIA2xTS9HWw3acyc9GeLNs5mNu7bZb62PtoCf7bV23HH11obNbM9WaluPD8QClg+06fvHi20KnvDwiSy4uh9ZBcL757yi6/s2AprPp1G4jheYObl0bAYup4hMgSuHDnC/HkMUW4df3EJzULGyFn0MoXA5ox2Utjq76udAkovh7heAp9t/KbPB0a1dfZCJxk0ILri5CcudJR4cXsI7QBJJW95+Njvym3vLvA0vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW79KDN71mrQeWuryG5j6P2hFF73Mc+W/MLHW6rtq/U=;
 b=QDG8s910KxOoxh5oq5Z8nYe4sI7d+0wApWwmQatg1T+KfPH139Yk7yd+QFQA5gkgGuPJtixoF030c/Sp7sbCEx2GwWvd//xG8Gc8UKqCYaBsgB0NG8BgoUBtyo7dhD+d5FS8/CGg9HrISsJaElZeTbE2RlZopB2hBhPFzx1/0fHMrdS+/JLNGHHxgaGagEyNSxDdqq1yaCy77ilzcgJeCCTK2RecaV40kZj6C9Z/p/fS/DrrUxmZD79xPuCKrpITirRia5rvefYHHJyo+tIlhsRuGC7Lz84TrC9NAUf+ujdahMfBQqQaIMAUP3lYWUWDILVPQyAOZdZiLJqjup0wVg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB10251.namprd02.prod.outlook.com (2603:10b6:8:1b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 19:58:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8207.020; Tue, 10 Dec 2024
 19:58:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "wei.liu@kernel.org" <wei.liu@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>
Subject: RE: [PATCH 0/5] hyper-v: Don't assume cpu_possible_mask is dense
Thread-Topic: [PATCH 0/5] hyper-v: Don't assume cpu_possible_mask is dense
Thread-Index: AQHbFUf6M+mdOKKgFUaLQXc7WEQESLLgTs7Q
Date: Tue, 10 Dec 2024 19:58:34 +0000
Message-ID:
 <SN6PR02MB415740B41A34B1468BC6AE28D43D2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241003035333.49261-1-mhklinux@outlook.com>
In-Reply-To: <20241003035333.49261-1-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB10251:EE_
x-ms-office365-filtering-correlation-id: df333536-2459-454f-a6f6-08dd195507a0
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|19110799003|8062599003|461199028|102099032|10035399004|440099028|4302099013|1602099012|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jBf+DqfS2VsHJe9vrGb8dR2RikHyxnyznSKXWYhuYcoYp16bFh+woV1I4un8?=
 =?us-ascii?Q?DDQ/+xE9n7QaNFl1aQSPTfNOVfMyN7nN4AkdLIrkajjoJLsjw39IVuZoswni?=
 =?us-ascii?Q?v5LFBaTckn6t/ENCMFvixvVjTGDhBxC80Wsy+TfAB3RFbQIjt9R9/d+1UBy8?=
 =?us-ascii?Q?xPzK6NrNxwFleQmJk3zdaPZ85YWOaHUIHWmeMTJI0gxlXiEEGQOYwLMAvEcm?=
 =?us-ascii?Q?bLR/72KFfQ9jYE5hU+xA0iZey6ocQtfIID7AMTHfW50pdfGfRPx6OS5Q9tuU?=
 =?us-ascii?Q?Qt1+oyE9qm6W9sbTliwXfQdve9y0b3q6vyigaJ6evU16w4/DlTh8v6mxwjJ8?=
 =?us-ascii?Q?Zutg8PRXnFH887jGe76NXMhj9nfpBAUBbNLV1R4bKxgZCXu+89f7BOadRXdk?=
 =?us-ascii?Q?bB0XDiqkq2SH1DehCby31j8ys65nxdK/04HlXKor3qgEBA61XIwCT3Yi3muD?=
 =?us-ascii?Q?7BZLsqeCHVRQ26CKFlbl6ph2ks8BfrphQ0gwlxUhC5dcwt0mmDnbnCXbnyQa?=
 =?us-ascii?Q?KCyitrzSVkxlaIk1yOPXGp1341ZtXJrVFvOM8otNW0ygIsefUwzb9LI3Mr4K?=
 =?us-ascii?Q?BKrU75R1JFx9ZblOpIfLK+MIWTUWxAyMxGlP1H0v+NGKt0GJBGQJcb+a+JID?=
 =?us-ascii?Q?1cxSXoP2vZZI584ubEamT/fyKDzNDIp33ZRzXf26Ji8iSNKRoVwP2quKCXSw?=
 =?us-ascii?Q?1UCsAqy27MUQKkTVsLFlFhU0Xff0ouylX+wE9v1uj5bYvnNec6Wk6OAjiah/?=
 =?us-ascii?Q?p90ZtHcafkuQJFs2EbClAsESx6GXlHoxQ6G5bzy6iIM/TYGt/rg+y+6kFeRc?=
 =?us-ascii?Q?PXx/8+x6pyQTE1kO4Hgw8aYqfUaV1KZvnyLqRkJV2LRt1F7XFuivgaF5OPld?=
 =?us-ascii?Q?uYGjxxR5zqWoolCvQLuZTEc/HVTxzCzQGhP4j6nJMOGZAFmAsJdJ/QUwuCol?=
 =?us-ascii?Q?8xUZ9/lXq4GoiyXQ29ALn1Akvg1DabLqExpfe9M1Zkre0JFsDXwnO7r/G/3Q?=
 =?us-ascii?Q?rNr4+O8PoAGhh5eNS3YEDi2GeZ5xd7ij7xCkdyHjNTxTSZAOSsuZqdQ5ucGL?=
 =?us-ascii?Q?JaohJjY2ZFt5Ar+LLaWVixJ85OgIC9czL+L4c+Cq8kZGSor9j5ZB0tL7oYd4?=
 =?us-ascii?Q?O6W8xz6L/Fyv8BxlwrLPxj13wi9QyGbbu6IpxyK8bRWqh9ITVG9L8Bl+Jfos?=
 =?us-ascii?Q?JuFpIs6FHhp29xJGXC0rJjXuyhE2hNnyWhS47Q=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kys+2F4RNOG5wrfqf5xmmbPsvKAil8AuZQ6zt6ao2bwgMrevA8JADLG+jk6i?=
 =?us-ascii?Q?PJHRGcnYUvmAtOBQMV7u6ZtozTxlJy2gHk1CGt1Fxx7IDlsbMQsou6+jb5bp?=
 =?us-ascii?Q?SiKkxVGZgkwDJZ1A8njn91n6wmC/GBLkcmRrUgUG0C7Qvyk2FjEVP9akWV1e?=
 =?us-ascii?Q?VvAM79owWDcSBCIO10wJpW2FQIHQY7gpnxpIysjwB9Dfj8k8SDwm3K1CMgPG?=
 =?us-ascii?Q?P4K8QpSqZbK4HNP6XoAJqwUZLOlDudlR7Yi1DpUx/h/fMSMW9KriKyqeDH8H?=
 =?us-ascii?Q?0Fphw2xc4y2TksuSgUACzoKZIaK/BnL3JMEKS9htYitIY9psU8SGNPBx4FuF?=
 =?us-ascii?Q?EGZ2XmGVa+q2sOPa/Rk19p7Nh+DRr9K4lzKy2o9+FbKhCRBmbL1Gak0oHq8P?=
 =?us-ascii?Q?kKhPLyjZwPztuTAF+YRPkruQ7dgVrEQLWYW4krimKiiliwBdVjExYLqE5iL/?=
 =?us-ascii?Q?0bH8TQk00oa91WO3EOkzYHiCIJW7nSO/qCjlHS2bJGyBo+hSxFH8/JuPzr5x?=
 =?us-ascii?Q?49SC9Qjm9P3+8G6P9NB1APvGI1Hc9yGEKTx4cDKq46kzAEYLCvi3qsQdCJy9?=
 =?us-ascii?Q?OKQaFNnbnZrTiyZiIqbFmWV8U1ok9i048xMY0kJZo8JX3SvKh45SDfsrhkbm?=
 =?us-ascii?Q?GRyHl00uEaGT41inPE0etZe3FnECuhZCdi61R5FhiJ5wiYSVIrQqux5jWAid?=
 =?us-ascii?Q?G9M7fLIV9mDqyTquniyZ9MB+H/oOMtQS2Y4pPXKW8VZnMRECpe++TmoRyzyd?=
 =?us-ascii?Q?uF1ijsHZnYz7r0PfI5puij1cKYfI50n4OWKuufbzLWrIawpkYbNrgeKYco/0?=
 =?us-ascii?Q?4BXa+stpMb+TZGHFDgwRitddy2hbB20F+/fR38JoEIQODParEG3rlATXVhsk?=
 =?us-ascii?Q?oA0R+1avtzOeyCQdYFfYRtqnLnSEmXSlpNL5k24IAKKxJzhPwl/CDBII8Ykh?=
 =?us-ascii?Q?Nr5MogIEJ4Nq2L/jMgikWzGk+iXnFZzoxhGlUhoYi7uEpYJdT2fecJ/E9fh+?=
 =?us-ascii?Q?I0ehX4alfIMexcZ85d8pA/uuDkuyBF8NUeC4wdRo4NuHeMg9tURADROwf+Yt?=
 =?us-ascii?Q?Tx/LScDExpjVWr1Ew8SjnNQsZPTbMWbBQy2Y7F91jS0Iqe7yKe+R05AOhivW?=
 =?us-ascii?Q?jAUOalmGtoVSse6F7x8A5psPEsnqCVIv2/HE9Dhs3sI8g0Uo70dYdslglXC4?=
 =?us-ascii?Q?jatLNPRdlYFtE/rMUY5aAu2+8j/PQK8KhVeavMUY3JoYZESuSAvRjjD6lsM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df333536-2459-454f-a6f6-08dd195507a0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 19:58:34.7083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10251

From: mhkelley58@gmail.com <mhkelley58@gmail.com> Sent: Wednesday, October =
2, 2024 8:53 PM
>=20
> Code specific to Hyper-V guests currently assumes the cpu_possible_mask
> is "dense" -- i.e., all bit positions 0 thru (nr_cpu_ids - 1) are set,
> with no "holes". Therefore, num_possible_cpus() is assumed to be equal
> to nr_cpu_ids.
>=20
> Per a separate discussion[1], this assumption is not valid in the
> general case. For example, the function setup_nr_cpu_ids() in
> kernel/smp.c is coded to assume cpu_possible_mask may be sparse,
> and other patches have been made in the past to correctly handle
> the sparseness. See bc75e99983df1efd ("rcu: Correctly handle sparse
> possible cpu") as noted by Mark Rutland.
>=20
> The general case notwithstanding, the configurations that Hyper-V
> provides to guest VMs on x86 and ARM64 hardware, in combination
> with the algorithms currently used by architecture specific code
> to assign Linux CPU numbers, *does* always produce a dense
> cpu_possible_mask. So the invalid assumption is not currently
> causing failures. But in the interest of correctness, and robustness
> against future changes in the code that populates cpu_possible_mask,
> update the Hyper-V code to no longer assume denseness.
>=20
> The typical code pattern with the invalid assumption is as follows:
>=20
> 	array =3D kcalloc(num_possible_cpus(), sizeof(<some struct>),
> 			GFP_KERNEL);
> 	....
> 	index into "array" with smp_processor_id()
>=20
> In such as case, the array might be indexed by a value beyond the size
> of the array. The correct approach is to allocate the array with size
> "nr_cpu_ids". While this will probably leave unused any array entries
> corresponding to holes in cpu_possible_mask, the holes are assumed to
> be minimal and hence the amount of memory wasted by unused entries is
> minimal.
>=20
> Removing the assumption in Hyper-V code is done in several patches
> because they touch different kernel subsystems:
>=20
> Patch 1: Hyper-V x86 initialization of hv_vp_assist_page (there's no
> 	 hv_vp_assist_page on ARM64)
> Patch 2: Hyper-V common init of hv_vp_index
> Patch 3: Hyper-V IOMMU driver
> Patch 4: storvsc driver
> Patch 5: netvsc driver

Wei --

Could you pick up Patches 1, 2, and 3 in this series for the hyperv-next
tree? Peter Zijlstra acked the full series [2], and Patches 4 and 5 have
already been picked by the SCSI and net maintainers respectively [3][4].

Let me know if you have any concerns.

Thanks,

Michael

[2] https://lore.kernel.org/linux-hyperv/20241004100742.GO18071@noisy.progr=
amming.kicks-ass.net/
[3] https://lore.kernel.org/linux-hyperv/yq15xnsjlc1.fsf@ca-mkp.ca.oracle.c=
om/
[4] https://lore.kernel.org/linux-hyperv/172808404024.2772330.2975585273609=
596688.git-patchwork-notify@kernel.org/

>=20
> I tested the changes by hacking the construction of cpu_possible_mask
> to include a hole on x86. With a configuration set to demonstrate the
> problem, a Hyper-V guest kernel eventually crashes due to memory
> corruption. After the patches in this series, the crash does not occur.
>=20
> [1] https://lore.kernel.org/lkml/SN6PR02MB4157210CC36B2593F8572E5ED4692@S=
N6PR02MB4157.namprd02.prod.outlook.com/
>=20
> Michael Kelley (5):
>   x86/hyperv: Don't assume cpu_possible_mask is dense
>   Drivers: hv: Don't assume cpu_possible_mask is dense
>   iommu/hyper-v: Don't assume cpu_possible_mask is dense
>   scsi: storvsc: Don't assume cpu_possible_mask is dense
>   hv_netvsc: Don't assume cpu_possible_mask is dense
>=20
>  arch/x86/hyperv/hv_init.c       |  2 +-
>  drivers/hv/hv_common.c          |  4 ++--
>  drivers/iommu/hyperv-iommu.c    |  4 ++--
>  drivers/net/hyperv/netvsc_drv.c |  2 +-
>  drivers/scsi/storvsc_drv.c      | 13 ++++++-------
>  5 files changed, 12 insertions(+), 13 deletions(-)
>=20
> --
> 2.25.1
>=20

