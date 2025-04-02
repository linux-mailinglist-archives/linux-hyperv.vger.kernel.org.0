Return-Path: <linux-hyperv+bounces-4770-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1F1A78723
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Apr 2025 06:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC6816D3D1
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Apr 2025 04:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE1213E02D;
	Wed,  2 Apr 2025 04:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CGdh17MM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010012.outbound.protection.outlook.com [52.103.10.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C1139D;
	Wed,  2 Apr 2025 04:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743567309; cv=fail; b=c1zsyfs6v7Yy63A0zwEV90+m1+4UVdpb2Z/4Kw279Ispex1drH2VXmbFAktJTWd9ubXDePYOFSto2Oty72JKbqUz71sfBCNbKi+fz0CCwCzWbQRDeSZ1Q6UfVCsJlbtGuChJ/YLK1u3ZEh0yL9+h4U+I2zgGYGcnuUTA036KAC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743567309; c=relaxed/simple;
	bh=rQYgSnIGWOcj2lFumnJpI6x4oQ/COt/favCezJEJSbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lI7ouqAhnwGY3PtrxQipjZYNLz77RYMo+LOZCf35hg5d0WpqkIYQ/YJMRLbimSoCi7/LiFaKo5lphytokRCQ1L4TbEs1eaNKHHLWSUaPCb9lAVln69WHFZ8N9sMenObymKXnbrRTo/5vK1Z34YRI8cvFTnSyQehJLgVxVf+V3ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CGdh17MM; arc=fail smtp.client-ip=52.103.10.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDO8Se7AvlTL5cUrZnVfYYBKKdHv6HdrLDJQ7tQeJTIGzNhyNB7anhwsjZ1+JHhQie5v71s0Z4xa7jhr5zgswwaERS/Nza+1/AsLvomZsmJbfgdgQWKx0orP0fmKrsXzQaI0csDzAgNpzf9+Ilz17NntifXmQSaH0JjsJ3yIpasZ4zQW5ftKVvmV93FMlnGw7tFGnOhktjpOhksucxqN/qAqhtEa1Pvi2R5XqtXk1PvqH/ff7iFMXyp8wri9lQofGj/SfT8maRuU9v8aY7U/30hWexAWBtfS49Je0dYzc/K49YFbrMMps2ukC9jHFUacTExhHvPi1Jy/ZEYHyiKygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omhMNeyOPbx3tKtysrTde/e+cWflJapAxnO4RShvfd4=;
 b=N9wpvX2DLy+cwQY3de6JyDlZRqVjuQxOTP4IF+FEKI/4wyIq9ysMdwXVIoW2ViiCma0li7MjA5EIQOQw39YWbStLhKjv0gzN+q/+O8rjJTE1zIjYPjHsrerWkiZY1EvTSmQsO0N/q6vvCiiSddCcVT6lmGcsp2ecfgGO3tY+6srNSiCXb7FkvEsYvvNtZ1Ujq9ajuIdWBsnykRTuSx2IeNHQunqFV6wsDpIG1o1b1wbb9URXqu8NdAEGiP9PePLrFR/uKH1hcInNkNm1eJ4d8EFsCvQhqVUwMYJJDCmIFCFGh1YJzghyJQwd4BQil+PdKzCeUqiJwv6FfldmDvwtjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omhMNeyOPbx3tKtysrTde/e+cWflJapAxnO4RShvfd4=;
 b=CGdh17MMXQayPiCNPcZN+Unh2yTJG8UDNlBzemvh3e5OPbgx4kXEm7+oCfHE+1/YsFL9nz29EzEaJxtmagW+I11s0IBYlAj0M6kzV6MXpcs+DRMHSvbb4Do9i0AKmKKrHWjchM+K++30NnsjBG7jIKhqP/kCwHYOb9/Efbgl+51zy1faL6aNPaCa5bbSPtvuMH4QboeH32sKC+oRbQjzixeK7FEiy2IpY28UW0auspv2rngTx0EwVWszj/SCKITB4vZ7DE2tNlzDMft3NLDabg3U7/4WZqsvK8DEsmCZ/VbfLyG/tz8rKbK5RoYK+SJbZJYVK1Ej350LZ+eEQtLjAw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB7571.namprd02.prod.outlook.com (2603:10b6:303:a0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Wed, 2 Apr
 2025 04:15:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%5]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 04:15:04 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: Fix bad pointer dereference in
 hv_get_partition_id
Thread-Topic: [PATCH] Drivers: hv: Fix bad pointer dereference in
 hv_get_partition_id
Thread-Index: AQHboywJJwFX1YkkOUaKkdv1CQ4xzLOPxJyw
Date: Wed, 2 Apr 2025 04:15:04 +0000
Message-ID:
 <SN6PR02MB41571B9409E6A7B3A27846D3D4AF2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1743528737-20310-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1743528737-20310-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB7571:EE_
x-ms-office365-filtering-correlation-id: 2b0ea524-87e7-44a9-7ebc-08dd719cf229
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8062599003|8060799006|15080799006|461199028|440099028|3412199025|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?f2DuJOYOd6kJFxyzrBJVOycVYKJc0eytHFtORUduSfQm8Jm5MRuKS0V9lWny?=
 =?us-ascii?Q?bkGxXgWLUTmgBHa+1q5vuyZsX0PZxrVJsVtN4r+G8KPTv55GMuBFD17MdkoV?=
 =?us-ascii?Q?d/ed0OPfD18J+YQiaoIfpdLT8HUt1N4vs9cLh2aMKz9YWhN8nL4/ujxXK50z?=
 =?us-ascii?Q?7DAhF159J+nMp4CQJ27W3L6J5sTyKWz/0oZMg59BEweBKKCCEpNSj2JS0OW3?=
 =?us-ascii?Q?XRMQYrfTEZt3EkS0+OBL4CwnSQNeQuGGSTp9KH+njW6BaLu2u+vHsOMm8E+m?=
 =?us-ascii?Q?ngNljOfywZmpg9j8uZ2RneElSPVDGKwHuEKOvUcfRarQewTwEobQaNN0qy3W?=
 =?us-ascii?Q?Ogx/7deqd3bNxHuJf2NOvis1Wbm4nF/Yc/C/OCHJW5bAdLEpwFrOgMNRxYoc?=
 =?us-ascii?Q?aUBmUf7czwNIlNA4Eos2pZPIbbWVQvZWuWi6nPw+zRYbARM56w5p6hXaVE/n?=
 =?us-ascii?Q?Z1M9Dvc7Ci9eiAW7T8xzxIDZdqyUgqSmXxeVe8WJK2tghc58BT6mDlmf342h?=
 =?us-ascii?Q?kt6/OUVWjQEvAq5kfBVeyyiJJZb4jcznVqsVt5KjYZ+l7RjJH/NQgQVNdN15?=
 =?us-ascii?Q?dECuWY7LHdXfIa82K9pdBKTGBg4O8YGqlzqnZnJdntHgaBr51hbwXUI/ZvrY?=
 =?us-ascii?Q?eE6j5q2abFAsOcsoHtdyx8y9B1GxImemtArm3hheOSJk5t/+8/OJ8nXyHxVM?=
 =?us-ascii?Q?ZNZbShIkE68PWFz1gn0EB9Hem3rDhXcyYSFsTvyYbDOaNvDBPEkN2/KrbtRz?=
 =?us-ascii?Q?DojFiu2L4e9kX9GSTw+sPjEJ5Si+OZ+gJ81vPPj+/NL9lQS3uozq+UpgQbaW?=
 =?us-ascii?Q?dItLjPS0nEkSE2Gwt/k4cJU8Y/m0Yo3djSlfcC0dXRqa8GwtYj9lrOqMQbSM?=
 =?us-ascii?Q?UV9rERMILVehowdY1RitYz+FMMB5yUPhjbrvv4VGjHW035OD2tuivgnH9rvg?=
 =?us-ascii?Q?JkLjnNYo29dOzIcAN/MAm9b38x8IjYy+P+9cxpZ+yag/XXGCI+nn/dEDKA9U?=
 =?us-ascii?Q?iMY0vlo3qf/cwUJoMca0VT6Aa++bniY/2EApFqHdwYWsoyqWwCWWoCs+naTm?=
 =?us-ascii?Q?nGw8Kfz9c12a4/nql1K3Kz8LldQDpMdl1ikcT2MyVQuRbvEdGCM2kYLLXhu2?=
 =?us-ascii?Q?h29RlD+6frxo?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sM1d+g9bgtwg2UURKQZAaSuWffqzAvk7hS4DRD2Fh26rTASqLOVPWikn1Nu2?=
 =?us-ascii?Q?tWWRw4mTv9fI0XvMOoRzUzlIBsISzKEVoz5aDAs45EgaPaRpZTNooGenA7NK?=
 =?us-ascii?Q?rj7l/jBW7JbuW0wqjeGULFrygeISgiRxC/fSl1XohgTbJCCvLKgz/dIZAg5S?=
 =?us-ascii?Q?w7UsQeTtbRyfRx1DpZxQJQkW7K4lm/NCNTORFDqckGpd/090hWBCZ8SQVaBy?=
 =?us-ascii?Q?u0B0uW/8NAubiYTSJyYGLY0+OJItexuwyeCnayer9rThosVdfTvGFm70ayv+?=
 =?us-ascii?Q?lL33fJtOJZMJYrz0iBzfaiVjE1hPIn6t8cG0RxdnKhB09Q/fdKrThLuDIt24?=
 =?us-ascii?Q?tq83RhJ1G3H3W+YhDGvN7NTkOJ2lzXlktqppzfOZM0W7gIdZEUfl/rXGOjdI?=
 =?us-ascii?Q?YFmPIIGktHgR4RKjZvOTxsV/fpwqDychgrQq2CjUrO4EWxpUJ3C8In9+0iq6?=
 =?us-ascii?Q?jCq0+bY4Jwfe/Y0Z2m+ZwJUTukSYrgUcE0TAITIeOIGKMUtV3lhb1IMFUlqE?=
 =?us-ascii?Q?bjKCiTDInsaSyv/YD/MhnJSnzHMK3RC0F0PxkYPrtZFI+QYS+ws7caV5X5j0?=
 =?us-ascii?Q?NGq+Px+ti9tNKVm+DLQP4CCDzxrWtUzwtqvot18BeyNnrZ7Urzw/ZOrYJxTi?=
 =?us-ascii?Q?VuVjlNWsGX8d2aBLpZ+ACalEPZfyRrKHn+RHoNetSOPTijK7Cmh3kDcP+Ad+?=
 =?us-ascii?Q?JSZoDTQ8rPB8ZLwRR11/g2cPHmBtkjtEI0sXPSsfzmKTUfC1QchdhGUeUHJI?=
 =?us-ascii?Q?qWfOAwqMGI8RwC2iEj9YJVdqKDFxkHL7i52v7Oesbk0cZTJymE/KPbS+TZxY?=
 =?us-ascii?Q?Yy885iSwTweq+huzQj1z9FOwOpMFRnelOSDGRRaLrR9O6978kJxn0KfedDAA?=
 =?us-ascii?Q?RSuMISb5Ph7SGmSwpmzhZprMG6PGwwIsqdgkJt1gccGLxslMDUC3OqfcjVQt?=
 =?us-ascii?Q?JzlnZL37hrcskTmPcQzgGCydUn3qXMMB17ZRhWls9BUm0BKtIRDNwLpzm0gF?=
 =?us-ascii?Q?9xn2zB9MxtWO6CkeLMswAzCoNtYBZGkxH2bmA2EqPpn9VNztmnPTK1lCwifY?=
 =?us-ascii?Q?fCmEXJTO+vF3UEtUk/T7BzWrO8+Aj4VUmZEX32w0Wqh8lT0IADOoY+HIKomq?=
 =?us-ascii?Q?VsK3eJJWLYdtHg0jnQBsJm7MXb5EHhWCuTLnuTVxXxggc08eyxwqqNFe/0xO?=
 =?us-ascii?Q?9M7NGdXlFgXstoy7HuAGBb8wM9t2Nz3sIVoOIPsPzfHVAxk7zSo8jTBEUyA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0ea524-87e7-44a9-7ebc-08dd719cf229
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 04:15:04.7857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7571

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, Apri=
l 1, 2025 10:32 AM
>=20
> 'output' is already a pointer to the output argument, it should be
> passed directly to hv_do_hypercall() without the '&' operator.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
> This patch is a fixup for:
> e96204e5e96e hyperv: Move hv_current_partition_id to arch-generic code
>=20
>  drivers/hv/hv_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index b3b11be11650..a7d7494feaca 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -307,7 +307,7 @@ void __init hv_get_partition_id(void)
>=20
>  	local_irq_save(flags);
>  	output =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, &output);
> +	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output);
>  	pt_id =3D output->partition_id;
>  	local_irq_restore(flags);
>=20
> --
> 2.34.1

I should have caught that when I reviewed the original patch! :-(

Trying again,
Reviewed-by: Michael Kelley <mhklinux@outlook.com>


