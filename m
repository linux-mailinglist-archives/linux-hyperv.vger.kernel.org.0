Return-Path: <linux-hyperv+bounces-2898-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CE3962AB0
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 16:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0862831AF
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77327199FB9;
	Wed, 28 Aug 2024 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AgWCcvpC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010012.outbound.protection.outlook.com [52.103.11.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168B175D28;
	Wed, 28 Aug 2024 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856483; cv=fail; b=HiRv1Nl+DncNseVVObVYM4fYahYxtf8me5NNz9/EldT7Tb/fPwjFc3F7ez2mpq3bZ7IItLwNz/X9xmXDZIrDSX0wdWnlVH3nmfByYeKku0+8WlExKY3Xr8OXZEqaRuFozjmwTL+ZqgjPPmGOA8zPYQvOGgBKPmzF241MrY8/it0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856483; c=relaxed/simple;
	bh=iJvliiQjpVGbHdaoZSUayATqJOcJX2LixYyA81+UMDc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z9hsg1QXW8osk9k7t3TF/NEfqsQzlp4x7smuPU+P5jNvatVqCp7Vk0wz0H1H7y402LVnLyJAZcVEK8rOaw1VxTK/ny6CEPWMBerieYY12n1mJOobed8ZEoBVk0+73yp+P/0/gwHZdNzECseiKqkDMt/ua8UiaW+4dMiU4E15o0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AgWCcvpC; arc=fail smtp.client-ip=52.103.11.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDtxUYFu3TyHrzhQEhPmtdGsISbnuTPZNIq3Nr35+rA+wkOkwI4EdIucMV0LeDu5SdKELbT8c3mXlOSRdAjCl0WaM5tgou2zi6tMPiFtJHUHyELyvWMj0/0pHLrWgavyBsaK48eEu3FByVCT7FHVgZkWgzuS5ly/gwn8vm9P3cFtEcB09EG93eGVsToHr7t5+pBnS+nyHn+WkTIt72dKpXO/VeWaysz4u0+B0djLklVbNQ+G4TUdBiy+U3JTZEjlHTB64jXQSWMohGXEjAsvUXcQTH3fRK08333rcdySZ3G6IZ2nmwKNg80NQRggqiVqJJ2aGK26/XBRCwrmmsuYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJvliiQjpVGbHdaoZSUayATqJOcJX2LixYyA81+UMDc=;
 b=jxXaJGI/O3TOQcqR444Rnqu1OvcY6tOOZeazzD2Kcw4qJJfOfUXjO7dsoO/FABipPq/SGKEJvjG/KYZ/J9wVebwL9sjoSC6Uu4JF7N3KJv121cOnfTtvKo0RGIIc+ENwvuK4WFPHQe8ZruKCH4X99AdBcI0yPjS8rWdv9VtvF0OzTneudfUhFEo4uqKURVf/F4yGc3IYg2GT1iCVagU67IUrpTZj4v3Vi+W7do/hM+CgcBW0OqdIt1XPfn2lenRa3/RTM595Kqn3Vwc03IzsbbDEegVhnfMWJTsUuo525NofX5eXYEzDdf+59aSTdaoA+9b5tFHkyBTxJrMgMVS7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJvliiQjpVGbHdaoZSUayATqJOcJX2LixYyA81+UMDc=;
 b=AgWCcvpCO5pH4/G/Zh6oL2310Gyem0rTSE3Rg5bPGplEEPUQGi6FJdwzGltYPf/6PvU05NQ5DJvFzkrVO1Z7jGSMTYmZKYjEXrJzrsjkNWH57qilu1NPbDAuWmZpMM0fMOVu94o8rbAoSgu9P9bDb6Cb5nBnrUkrmpX7wbFxsfsWyOTQHCSe0LNU9yK62aqinb/OF+eNnCJLm+3I7sGP6OHMoavnuRLGOWG8CdnD6r+cQvBN/L/LPvjh8XWWhvWawG1zPKEgAUvxjxUjn4F69gO42cUUo+Bhko9h9FcAGre341UWhSicDo08+8dpstYrmMDTHpGfiWQGbZgeZ4j6ZA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8194.namprd02.prod.outlook.com (2603:10b6:610:ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 14:47:59 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Wed, 28 Aug 2024
 14:47:59 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov
	<vkuznets@redhat.com>, Michael Kelley <mikelley@microsoft.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] x86/hyperv: fix kexec crash due to VP assist page
 corruption
Thread-Topic: [PATCH v2] x86/hyperv: fix kexec crash due to VP assist page
 corruption
Thread-Index: AQHa+TymH146oPCIsEikrG8bTi6q/7I8v5WQ
Date: Wed, 28 Aug 2024 14:47:59 +0000
Message-ID:
 <SN6PR02MB4157E80B8050CBFD02E3077ED4952@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240828112158.3538342-1-anirudh@anirudhrb.com>
In-Reply-To: <20240828112158.3538342-1-anirudh@anirudhrb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [cYQ+jgdNVG6WU9FC/xUVD4PGMhA/sVgo]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8194:EE_
x-ms-office365-filtering-correlation-id: 9bc08db3-1c28-4aae-69fa-08dcc77068ff
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|461199028|8060799006|19110799003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 U9dtjzARcxKqorR3W28/tbvXecvwtiTctHoxLgfVwPG/hdCrUkAOh9NWXltEywpO5l54NoQtVMYXweghs81jtjPqd4AGGxZBRGicJLgAccJMs6+4mhYwoLxAxWy7UTfftNiJoontauj9hHnwBS5PXWmvdTfCLvxn1KKPMtllxZLZWIZAvbj8Rn+hLIlgeuOukrsXEHEiY6BJnioPG4575wfkh0mjv+f8/3UR2Q0TWlbNqmZD4SQX+N6RhxmNfRkTkzGnOm2cWciXUMAF14S7DNfnz7g0I0X/xWiOG+/KpnKswHT3s1Z7YOOYPzATB0W5a0pdknLXNIznQctr0nU0t7SwTbGVlTAmXnubLM0/sFpxOaJxiV9Ai3kc4ypokeMtMIaY1ia8YmiIjful1+LGxlBypb5FzurFVNNanNhschLI63AmL2F1OoeWqhRIIfZaILxzA8SgKXqmYG5wTSHQJNd+E/kq43mkVEmbCWkz3nNbmnLNM5Rne/y/JbOec/ZmnUOZENa34ud4nA4oMbZ4lW4xBx7ghfVElcUPe/U+AIiiIE4vHYuVOF9sNvFOfa65GcIC5COy9A+zbKVjR6CimCiza1D0sIfl9Eya9UOYnLg/8bZYIWqwxll7vg+EVqPlE68uNSX9dsVAKGvwWBmjplKu7FFG5WFp1T9cXHhD4Mo=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DXP2g5pNIwOjikt0C9c26WuJQtN2nA0P+JoY+nqWRPaRVRm/Vd5LzO7P1X6p?=
 =?us-ascii?Q?sL26F0BGdMNV+WWuNewF3XWQYFMOVV5nAPz33lm9AKK6ewpEOPn6+qMYiZ5Y?=
 =?us-ascii?Q?xPp8uQcMfr6oi5Fq8mBlrwSBx7wZxC9iGT5n/y08fAclY2CSP57GrxF9WXe8?=
 =?us-ascii?Q?Tn3AadWA3FBLalUDcbAGG0fhvK3L6/VXNNiI/7fmE9fsWT6hCPmOu7qln+GE?=
 =?us-ascii?Q?1rKZJpn7LjVkCwvmgdjHqsp5r7nv2F8qj99SzGwx11njGPc42ZM7XzY1w3Ec?=
 =?us-ascii?Q?fzgA/pewgg2k3xomkUt6Vz3nMUSnWnPdRGcMoTDzxWtdlpFfNEs0XAiKyN15?=
 =?us-ascii?Q?SoFSc8m16SKe31Z5pw5mbRpWT/2Omc1Ewquh3VqpmumTeBRlxvlDUp5sWUHh?=
 =?us-ascii?Q?j2TP60mF++D1erClIQ4A8hB+e7V7ZtQ7A+JZeuWfcf+OeTHEGI+rTRE0d8gE?=
 =?us-ascii?Q?rp3kO7AsRQ4SXptt/vw7n790KNkhpvKyLMg1VulxG+52Co6ZNPpL75Zml+sB?=
 =?us-ascii?Q?61I+P6Zrwh4kbr8U8nHqK/bp9F8z62mf5kP1x10D0RzYeJMqhd+UGwl/+EOf?=
 =?us-ascii?Q?cp4H88sA8VSYxsSqkukBAAuDzr7d0V5j9T6mCS7JUZ/Ph+fXBKtD5bs1ylgE?=
 =?us-ascii?Q?pMxyoVvOHiCBk/zMTQEaT198pqspv+3EJC8+eif0hZKZeYo+nB6IJAfFQgDo?=
 =?us-ascii?Q?TKSsasfGS9TwXiKkVN+fWWCn1qv2a4qfIIlQkMhgDv8XzgKob+5tbjtuEzsS?=
 =?us-ascii?Q?+13KoaEzuTEa0Dj2NZ34xctzfXqmPamNtjF+ZMD/IZ+vPfgw6SXkCZ/qnagT?=
 =?us-ascii?Q?+HLXQ3ASFmRRO5uCRJyLUsXUnxUs46R4xc8KSwgjSs870KAzAIAQcPirSFyw?=
 =?us-ascii?Q?vs9P8EZB9f9bksuRGT3QsRKM3YJQc6NTxED/JU/8pACsvA5s9HTQtuci5HjV?=
 =?us-ascii?Q?stS0fKBSX35lml9lU86ED5X1xXrhzpVumr/Htbp07qq/mXv51NgaHcnO12jg?=
 =?us-ascii?Q?1PQmI6lHT8tSgFbSh68Xd5Jsl7KKYlUjaH17BnzSQ0+YBgnmKJE4Zyzo/JK3?=
 =?us-ascii?Q?vPjcaoFnL6SQ1qVB3OAbQcfKnItX8QemC9Jwe0Vc4YHNB3FFLQQF9SgOMWoh?=
 =?us-ascii?Q?2bytmvjAEAwGkOwH6cISsEzHMeIQcekSrkyYCTOjwcKX43lC0ft9lJxNRpN6?=
 =?us-ascii?Q?LZ/hhrkQO/LUKhxh9ryNZI1nLCXd5erxuno2v3+T90Jt85O/TjPdZLtNfGA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc08db3-1c28-4aae-69fa-08dcc77068ff
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 14:47:59.1376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8194

From: Anirudh Rayabharam <anirudh@anirudhrb.com> Sent: Wednesday, August 28=
, 2024 4:22 AM
>=20
> commit 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when
> CPUs go online/offline") introduces a new cpuhp state for hyperv
> initialization.
>=20
> cpuhp_setup_state() returns the state number if state is
> CPUHP_AP_ONLINE_DYN or CPUHP_BP_PREPARE_DYN and 0 for all other states.
> For the hyperv case, since a new cpuhp state was introduced it would
> return 0. However, in hv_machine_shutdown(), the cpuhp_remove_state() cal=
l
> is conditioned upon "hyperv_init_cpuhp > 0". This will never be true and
> so hv_cpu_die() won't be called on all CPUs. This means the VP assist pag=
e
> won't be reset. When the kexec kernel tries to setup the VP assist page
> again, the hypervisor corrupts the memory region of the old VP assist pag=
e
> causing a panic in case the kexec kernel is using that memory elsewhere.
> This was originally fixed in commit dfe94d4086e4 ("x86/hyperv: Fix kexec
> panic/hang issues").
>=20
> Get rid of hyperv_init_cpuhp entirely since we are no longer using a
> dynamic cpuhp state and use CPUHP_AP_HYPERV_ONLINE directly with
> cpuhp_remove_state().
>=20
> Cc: stable@vger.kernel.org
> Fixes: 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when=
 CPUs go online/offline")
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

Good find, and thanks for fixing up my mistake. :-(

Reviewed-by: Michael Kelley <mhklinux@outlook.com>



