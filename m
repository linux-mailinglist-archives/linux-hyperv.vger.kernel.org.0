Return-Path: <linux-hyperv+bounces-7537-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D958DC5375F
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 17:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 570DD34FBA5
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935A833AD97;
	Wed, 12 Nov 2025 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GPNoLihu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012016.outbound.protection.outlook.com [52.103.11.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B822D130B;
	Wed, 12 Nov 2025 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964831; cv=fail; b=WFWLmVoS/KBEe3yM50VgH4kRdP5ZiCFqX3seaNNb1RYWeUOGoxW9m6SDCSln+ZfciEU6gXYdpY1+Wk0pOTYKQPJVP1EyR4eV5H/najqQXvNMyT5eZYhKVjzH1eHncOCHXkYYGom/yMqVxb2dd9ewZe+OFaEZYM3ghPPiQ4RHpq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964831; c=relaxed/simple;
	bh=g66GGLHFrhniJoPODkagKQFkbK48KLS330AqFW2RJhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RHJFij92KRXof86hLtC69MG3fFOQsN5BsjxKafkSoNcXC0LMHJM2bpi5Ga294U4ql+bZKiemODJWdI2CJRxTSUPOahLPGPu2K3PbMfwdtToRyrtpJ5elA6sD0jhKsoFZSQa9PgQKY7ITVIcS0+X6N1tnRvSKcLobHRElsQcS8pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GPNoLihu; arc=fail smtp.client-ip=52.103.11.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZSRHcGxC2IO0s0H3WOLdi+IHxN1p3N6M42SzPqnXuMzYdKTmmHWqiug9lz/uVvjvY6KwV3aJJbid1qUWe5TQ96bpHOAsTx6NKblUnrsWMK70cn6UOK5qhVA1/2Klcnzb9eWmU/wMI4yn8K7cDMI441HKPdvVKb8i1epx3rhzua0AmdfpIhlJZSUvx0DU2mxKgUB7nGE9042LRH6iFF60vIiw5jhjH1INP5AMIEHwyLClGJw0GxFoZkW2nyUD6Cgq+A/QK/8NusdpDhJJ2bQ92z9PEaOpKDS6TfUt6RU5x5MjUl3GF/pZMpuBILhM4k5UJ0/xc+hTwzqxDLKdzr7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsCtOgD1I1+E25+d9RxmJALIbhZ0lCT3oou76PuB6Xw=;
 b=KDLeXwX/ABY/o1JGW0THT8BkPm5qfuAQAwwFCpZy0sRD7c4zQCk7lVoebVvVX9Mf910n0H5azaw4CuVUg0yOytqmcWmMYMoIvh/X1VUuQlgNbJGBKAnbdIGRqKi1ADIs9u3xNYst9CvuYq0WgHWUETDatnu0Wfj6ik0Ww6IVwd5Tp/cERD1dRXLmk5yo/pfLHRycgZCeE5og3gwlRbl+Q3GRlnE6/UMdPTyaHrX87+2P6ONP9Xu7Wj3EwoZonnX6x8veFIehl8LQo3fY3CCFHfC7ibM7+AFbZnfOP5Sr3O8zxPlpmOW5x16jyTEq3/hPDfvIB/XkIqM3I6OBChIrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsCtOgD1I1+E25+d9RxmJALIbhZ0lCT3oou76PuB6Xw=;
 b=GPNoLihuebaAuIYr50ON4HpXTMKrn0kccjv2Kj7YJplpn3JXnvuuDzkEMqnW/x68NGKvA4UlFZNEPUiLCQwzcpeTkj4voCAnjQhUWXeXnHY9lKeUx5ZEX2ajIe5rdD6SrdddIvZjBmyDDJQMPy0MJBEX7hYbqu70X3tmkfxNd6Ea7j+/C0yS2fx1BZkxd9FxGgyapkiPV88sci02+TnSR1wQmcQn3oJQO2wnV2L3DV8BxYfNzS9M/1i7FXQivwmTfRWFZQDD10QCFUPXKIBY5v6lSR82YtFijag5R7A4hqEMzCClZi8lRI523JubZ18ylbiCUqanOkXHxaLu7DPt/g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN6PR02MB10728.namprd02.prod.outlook.com (2603:10b6:208:4f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 16:27:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 16:27:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"muislam@microsoft.com" <muislam@microsoft.com>,
	"anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>, Jinank Jain
	<jinankjain@microsoft.com>
Subject: RE: [PATCH v4] mshv: Extend create partition ioctl to support cpu
 features
Thread-Topic: [PATCH v4] mshv: Extend create partition ioctl to support cpu
 features
Thread-Index: AQHcU2G7rWcPxv5LZEKJYscue8/hM7TvNoGA
Date: Wed, 12 Nov 2025 16:27:05 +0000
Message-ID:
 <SN6PR02MB415718EF45BF1B79F2C15F20D4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1762903194-25195-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1762903194-25195-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN6PR02MB10728:EE_
x-ms-office365-filtering-correlation-id: a5d88c80-891a-44a1-bfba-08de22085141
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|15080799012|8062599012|13091999003|8060799015|12121999013|19110799012|31061999003|461199028|40105399003|52005399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mGdR6gGK5tnCHxwT4aSx+zie5di8xcrQLfGEd7pr4CjXdjpYo2Vu8Hxzlwmt?=
 =?us-ascii?Q?ChB2uKrOqk4BRzd1baAxgWHRZj53JOhtDdrya7U7jQP233iNEqZajgtnP3iM?=
 =?us-ascii?Q?DeTqJMlHv6Bj7ZwmNJxI7Allj5KCTJbXq/6X15CgkphD8ExHdrPnTW2Ssnqm?=
 =?us-ascii?Q?sOh0kJD+A/KsenWeUtVLCSziTr6qTD4wUcTMhUCJe+X3JrPMwJbY0qQYRpes?=
 =?us-ascii?Q?jstd/pfZUfeAIeJiVLHmcuZ3BkRnv8DvauVMYLn+Ob55nuF1Z1FgKxkk7bbl?=
 =?us-ascii?Q?A+Jipfad2c2sBUiTR52cH1NwN8yo8dZ1JzcJNZWcnVdOkvwZfbHUOUjVNju6?=
 =?us-ascii?Q?hGC7zTwEAuf9hdWkm4lalBMdGvZyfkmmVn1ptW2KdQvB5Btau+BFrQPH98RV?=
 =?us-ascii?Q?NpIgf0pXlZzuzoVHDw/M0svRfD9tx5UMV8nCEI/UfokWtIK9XgikxxV4OJL+?=
 =?us-ascii?Q?c6/6Kk+xjl/ogxyOIAj1X4DDLVLfRWv1OqCL+txpvIlu3PPcPmoWFsvtqp0d?=
 =?us-ascii?Q?eEW+iPMYjyJXOms2eTANZAQ/rZp3gZFgTOMd2QDKkjidqmYStGhCrCFX9aId?=
 =?us-ascii?Q?4fvP81tJYNcVTwcdr7gweST4B/oVsCugUtdy861OGtsLouNRAKQX0tAw0tI/?=
 =?us-ascii?Q?sfehFhRyeXJw4BvW0rQvSSeLy++bwuJyfXTwRKBPC67WHjMkrwK39+6WB3zl?=
 =?us-ascii?Q?bFmebsHc2JEFjMFMaayHPsMirwBZ5BsBIuCG8aB/FYiLDktnwtjP9HB+Szjh?=
 =?us-ascii?Q?gS9HCsN7tLCmbXcImdKMl8vw2ndRZKYINXFRED7ECAL25A2ff9cTDhmSDbNI?=
 =?us-ascii?Q?PgR6lPC7SEa9+nupaij2qstdcX5wAQgg8rAM69J0AwgJ29zDDtFUG1ORYbIE?=
 =?us-ascii?Q?woFy4urjBW/63SYrc+lYZi+3dEa30stvWiD0Wmsa55mSQjSj13U/GfLNEffl?=
 =?us-ascii?Q?RCrVdn+/REthIr4k7T3z8kE5zNjtT9ZJVGCwJHcWZNjQXNxYxo2u9jLyrMKU?=
 =?us-ascii?Q?MSkiQ92PB8MOz1U/Jb4aPCglLAk2ti5YNk2iJsWga+LE58gVuxMcoLFzXjf8?=
 =?us-ascii?Q?wG+PcRgB6SFtyA2yayRBUcv1EGkIeYS9S+nup6OllRvWrBGZRetflqdNtp44?=
 =?us-ascii?Q?iCq/XTtdFQ+bInsCYRRv5VLK0LWC78kOrkhN2GbBTmZR0STG9daE17Xbnp8c?=
 =?us-ascii?Q?0puJC381nvNeVYrNXHAlFQr7mzlKa1wWehk2wqhL4zQx1T3atnjfoJKjZSeK?=
 =?us-ascii?Q?AdKx91o2GeUUKp9ike0JUnWrtPmzKYwtVRAmWs/tpw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?38KS/uaNAuVK1N8e/2jm5UFNeL5oL8glZXzwQbaEFKMD09i/fr+1NpZgA30v?=
 =?us-ascii?Q?cTtlmjJ7Sx2dLXAxTSboJnNnxNFo0QJ+6YzfPS1FdidAcNRvYfL6B7HuigeY?=
 =?us-ascii?Q?fE9PLfBWHEShc0BYGYlMzSWR5YLpW08zOq2a8ZP56Dfx96T1IAU+ZeVg+xyE?=
 =?us-ascii?Q?8n54HehXYQZHyc3VwReWzGVu6PsJyBVBs5AZNdno+UCw8WginhORIddrjfeA?=
 =?us-ascii?Q?g7tz8eAvWP7XWswwN/PlZT0WKpvVKcW9/v9l1ANyAWm9dJKxUliu9qQnxDeu?=
 =?us-ascii?Q?DyJ5VyyKifVh1nClZ9uF8OJ1aMv/D/9yEUegMSKUVNQVB+ITu6MuBrcfrWIc?=
 =?us-ascii?Q?gWI+FUQOn0qRHw8bMxP1LMMNpWTPjXoZkub6VcNv3cQ9cxUSH91lWMumVpek?=
 =?us-ascii?Q?FhJEZ9ycaohjc4oItEMlq1BsI8zEIYPsJWUunQbdZJsmAeG5Rh3qiisl5O/v?=
 =?us-ascii?Q?wN9S7v1/DP3kR8zswSsu3B0mnk5gBDxEapLS85OND0C+q6lSvJNxAe3NzX9S?=
 =?us-ascii?Q?Vqe+SiA+cpxgIHWY13EgCAFdlmzpoII7TSx/FME6TqjFhKA3+F54e4RQFpTL?=
 =?us-ascii?Q?CVaBuWxkUIK4oIAGkBiMchIVzn+vMjix4/NTSkiX60TWWS11phfhkPTdYb7V?=
 =?us-ascii?Q?jyvih9drRC7w45GSDNyjJyz5OqcGsM+lBPFpIu3HB7mYbr1ohEzqjCfsC+R+?=
 =?us-ascii?Q?UlALTPXtoN833zuPEFgqaqmm6sZGT1eKFnD/jV8fYP3bTK1fyzZhQw63/Cg4?=
 =?us-ascii?Q?5zNryP0WrvoMTLLKSZLMwCk7krWOxs6KWMdzEbuUBn4lwXS0wYT2AhTGG+2J?=
 =?us-ascii?Q?Q9B7iw/dfi6T0gQnTr/lfUVLWMZOH83olz+tqDfXun98gJ/plLZ13xnwxa+C?=
 =?us-ascii?Q?3Ym9ZP/w8BxiWS5zNEfi1UtPiPg6GcMu6q+KuAKQ21ILPHa1Uzc7lcZHdYui?=
 =?us-ascii?Q?y6myL5XKL1y3AeXFwCVjXGVbHX0k08Mjo4LkHKyyZde+tdeVNPLcQ8FBEhXS?=
 =?us-ascii?Q?IJ5bFCWlDKv66uT7fB4jF4ePw5ppwH7p84gL92rAp2SOexTHn5/EmCdsCDWT?=
 =?us-ascii?Q?5vkPW6PKjZwKMct6BPIHUH1o/QSPp9G+KuvfHDCJKNiiabmpNv1PjJSobadi?=
 =?us-ascii?Q?7bbffs/MiDFzUrcOtCEMTtWlWAFZCQdeMIf88sLpefwCI/5hHrLAgGQsDYDn?=
 =?us-ascii?Q?IswunMxOcgGesd0gN7QuTqubemcP66HvG3bB1EBxf3YTNxEGrSZeZhVxgK0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d88c80-891a-44a1-bfba-08de22085141
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 16:27:05.1151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR02MB10728

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, Nove=
mber 11, 2025 3:20 PM
>=20
> The existing mshv create partition ioctl does not provide a way to
> specify which cpu features are enabled in the guest. Instead, it
> attempts to enable all features and those that are not supported are
> silently disabled by the hypervisor.
>=20
> This was done to reduce unnecessary complexity and is sufficient for
> many cases. However, new scenarios require fine-grained control over
> these features.
>=20
> Define a new mshv_create_partition_v2 structure which supports
> passing the disabled processor and xsave feature bits through to the
> create partition hypercall directly.
>=20
> Introduce a new flag MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES which enables
> the new structure. If unset, the original mshv_create_partition struct
> is used, with the old behavior of enabling all features.
>=20
> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Muminul Islam <muislam@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
> Changes in v4:
> - Change BIT() to BIT_ULL() [Michael Kelley]
> - Enforce pt_num_cpu_fbanks =3D=3D MSHV_NUM_CPU_FEATURES_BANKS and expect
>   that number to never change. In future, additional processor banks
>   will be settable as 'early' partition properties. Remove redundant
>   code that set default values for unspecified banks [Michael Kelley]
> - Set xsave features to 0 on arm64 [Michael Kelley]
> - Add clarifying comments in a few places
>=20
> Changes in v3:
> - Remove the new cpu features definitions in hvhdk.h, and retain the
>   old behavior of enabling all features for the old struct. For the v2
>   struct, still disable unspecified feature banks, since that makes it
>   robust to future extensions.
> - Amend comments and commit message to reflect the above
> - Fix unused variable on arm64 [kernel test robot]
>=20
> Changes in v2:
> - Fix exposure of CONFIG_X86_64 to uapi [kernel test robot]
> - Fix compilation issue on arm64 [kernel test robot]
> ---
>  drivers/hv/mshv_root_main.c | 113 +++++++++++++++++++++++++++++-------
>  include/uapi/linux/mshv.h   |  34 +++++++++++
>  2 files changed, 126 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index d542a0143bb8..9f9438289b60 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1900,43 +1900,114 @@ add_partition(struct mshv_partition *partition)
>  	return 0;
>  }
>=20
> -static long
> -mshv_ioctl_create_partition(void __user *user_arg, struct device *module=
_dev)
> +static_assert(MSHV_NUM_CPU_FEATURES_BANKS =3D=3D
> +	      HV_PARTITION_PROCESSOR_FEATURES_BANKS);
> +
> +static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_f=
lags,
> +					struct hv_partition_creation_properties *cr_props,
> +					union hv_partition_isolation_properties *isol_props)
>  {
> -	struct mshv_create_partition args;
> -	u64 creation_flags;
> -	struct hv_partition_creation_properties creation_properties =3D {};
> -	union hv_partition_isolation_properties isolation_properties =3D {};
> -	struct mshv_partition *partition;
> -	struct file *file;
> -	int fd;
> -	long ret;
> +	int i;
> +	struct mshv_create_partition_v2 args;
> +	union hv_partition_processor_features *disabled_procs;
> +	union hv_partition_processor_xsave_features *disabled_xsave;
>=20
> -	if (copy_from_user(&args, user_arg, sizeof(args)))
> +	/* First, copy v1 struct in case user is on previous versions */
> +	if (copy_from_user(&args, user_arg,
> +			   sizeof(struct mshv_create_partition)))
>  		return -EFAULT;
>=20
>  	if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
>  	    args.pt_isolation >=3D MSHV_PT_ISOLATION_COUNT)
>  		return -EINVAL;
>=20
> +	disabled_procs =3D &cr_props->disabled_processor_features;
> +	disabled_xsave =3D &cr_props->disabled_processor_xsave_features;
> +
> +	/* Check if user provided newer struct with feature fields */
> +	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES)) {
> +		if (copy_from_user(&args, user_arg, sizeof(args)))
> +			return -EFAULT;

There's subtle issue here that I didn't notice previously. This second copy=
_from_user()
re-populates the first two fields of the "args" local variable. These two f=
ields were
validated by code a few lines above. But there's no guarantee that a second=
 read of
user space will get the same values. User space could have another thread t=
hat
changes the user space values between the two copy_from_user() calls, and t=
hereby
sneak in some bogus values to be used further down in this function. Becaus=
e of
this risk, there's a general rule for kernel code, which is to avoid multip=
le accesses to
the same user space values. There are places in the kernel where such doubl=
e reads
would be an exploitable security hole.

The fix would be to validate the pt_flags and pt_isolation fields again, or=
 to have the
second copy_from_user copy only the additional fields. But it's also the ca=
se that the
way the pt_flags and pt_isolation fields are used further down in this func=
tion,
nothing bad can happen if malicious user space should succeed in sneaking i=
n some
bogus values.

Net, as currently coded, there's nothing that needs to be fixed. It would b=
e more
robust to do one of the two fixes, if for no other reason than to acknowled=
ge
awareness of the risk of reading user space twice. But I'm not going to ins=
ist
on a respin.

> +
> +		if (args.pt_num_cpu_fbanks !=3D MSHV_NUM_CPU_FEATURES_BANKS ||
> +		    mshv_field_nonzero(args, pt_rsvd) ||
> +		    mshv_field_nonzero(args, pt_rsvd1))
> +			return -EINVAL;
> +
> +		/*
> +		 * Note this assumes MSHV_NUM_CPU_FEATURES_BANKS will never
> +		 * change and equals HV_PARTITION_PROCESSOR_FEATURES_BANKS
> +		 * (i.e. 2).
> +		 *
> +		 * Further banks (index >=3D 2) will be modifiable as 'early'
> +		 * properties via the set partition property hypercall.
> +		 */
> +		for (i =3D 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
> +			disabled_procs->as_uint64[i] =3D args.pt_cpu_fbanks[i];
> +
> +#if IS_ENABLED(CONFIG_X86_64)
> +		disabled_xsave->as_uint64 =3D args.pt_disabled_xsave;
> +#else
> +		/*
> +		 * In practice this field is ignored on arm64, but safer to
> +		 * zero it in case it is ever used.
> +		 */
> +		disabled_xsave->as_uint64 =3D 0;
> +
> +		if (mshv_field_nonzero(args, pt_rsvd2))
> +			return -EINVAL;
> +#endif
> +	} else {
> +		/*
> +		 * v1 behavior: try to enable everything. The hypervisor will
> +		 * disable features that are not supported. The banks can be
> +		 * queried via the get partition property hypercall.
> +		 */
> +		for (i =3D 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
> +			disabled_procs->as_uint64[i] =3D 0;
> +
> +		disabled_xsave->as_uint64 =3D 0;
> +	}
> +
>  	/* Only support EXO partitions */
> -	creation_flags =3D HV_PARTITION_CREATION_FLAG_EXO_PARTITION |
> -			 HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED;
> +	*pt_flags =3D HV_PARTITION_CREATION_FLAG_EXO_PARTITION |
> +			 HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED;
> +
> +	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_LAPIC))
> +		*pt_flags |=3D HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
> +	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_X2APIC))
> +		*pt_flags |=3D HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
> +	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_GPA_SUPER_PAGES))
> +		*pt_flags |=3D HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED;
>=20
> -	if (args.pt_flags & BIT(MSHV_PT_BIT_LAPIC))
> -		creation_flags |=3D HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
> -	if (args.pt_flags & BIT(MSHV_PT_BIT_X2APIC))
> -		creation_flags |=3D HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
> -	if (args.pt_flags & BIT(MSHV_PT_BIT_GPA_SUPER_PAGES))
> -		creation_flags |=3D HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED=
;
> +	isol_props->as_uint64 =3D 0;
>=20
>  	switch (args.pt_isolation) {
>  	case MSHV_PT_ISOLATION_NONE:
> -		isolation_properties.isolation_type =3D
> -			HV_PARTITION_ISOLATION_TYPE_NONE;
> +		isol_props->isolation_type =3D HV_PARTITION_ISOLATION_TYPE_NONE;
>  		break;
>  	}
>=20
> +	return 0;
> +}
> +
> +static long
> +mshv_ioctl_create_partition(void __user *user_arg, struct device *module=
_dev)
> +{
> +	u64 creation_flags;
> +	struct hv_partition_creation_properties creation_properties;
> +	union hv_partition_isolation_properties isolation_properties;
> +	struct mshv_partition *partition;
> +	struct file *file;
> +	int fd;
> +	long ret;
> +
> +	ret =3D mshv_ioctl_process_pt_flags(user_arg, &creation_flags,
> +					  &creation_properties,
> +					  &isolation_properties);
> +	if (ret)
> +		return ret;
> +
>  	partition =3D kzalloc(sizeof(*partition), GFP_KERNEL);
>  	if (!partition)
>  		return -ENOMEM;
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index 876bfe4e4227..cf904f3aa201 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -26,6 +26,7 @@ enum {
>  	MSHV_PT_BIT_LAPIC,
>  	MSHV_PT_BIT_X2APIC,
>  	MSHV_PT_BIT_GPA_SUPER_PAGES,
> +	MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES,
>  	MSHV_PT_BIT_COUNT,
>  };
>=20
> @@ -41,6 +42,8 @@ enum {
>   * @pt_flags: Bitmask of 1 << MSHV_PT_BIT_*
>   * @pt_isolation: MSHV_PT_ISOLATION_*
>   *
> + * This is the initial/v1 version for backward compatibility.
> + *
>   * Returns a file descriptor to act as a handle to a guest partition.
>   * At this point the partition is not yet initialized in the hypervisor.
>   * Some operations must be done with the partition in this state, e.g. s=
etting
> @@ -52,6 +55,37 @@ struct mshv_create_partition {
>  	__u64 pt_isolation;
>  };
>=20
> +#define MSHV_NUM_CPU_FEATURES_BANKS 2
> +
> +/**
> + * struct mshv_create_partition_v2
> + *
> + * This is extended version of the above initial MSHV_CREATE_PARTITION
> + * ioctl and allows for following additional parameters:
> + *
> + * @pt_num_cpu_fbanks: Must be set to MSHV_NUM_CPU_FEATURES_BANKS.
> + * @pt_cpu_fbanks: Disabled processor feature banks array.
> + * @pt_disabled_xsave: Disabled xsave feature bits.
> + *
> + * pt_cpu_fbanks and pt_disabled_xsave are passed through as-is to the c=
reate
> + * partition hypercall.
> + *
> + * Returns : same as above original mshv_create_partition
> + */
> +struct mshv_create_partition_v2 {
> +	__u64 pt_flags;
> +	__u64 pt_isolation;
> +	__u16 pt_num_cpu_fbanks;
> +	__u8  pt_rsvd[6];		/* MBZ */
> +	__u64 pt_cpu_fbanks[MSHV_NUM_CPU_FEATURES_BANKS];
> +	__u64 pt_rsvd1[2];		/* MBZ */
> +#if defined(__x86_64__)
> +	__u64 pt_disabled_xsave;
> +#else
> +	__u64 pt_rsvd2;			/* MBZ */
> +#endif
> +} __packed;
> +
>  /* /dev/mshv */
>  #define MSHV_CREATE_PARTITION	_IOW(MSHV_IOCTL, 0x00, struct mshv_create_=
partition)
>=20
> --
> 2.34.1

Other than the double read of user space, LGTM.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

