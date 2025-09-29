Return-Path: <linux-hyperv+bounces-7013-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7BEBAA3C8
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Sep 2025 19:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7707C1922EA2
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Sep 2025 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0FC221739;
	Mon, 29 Sep 2025 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Fc7PdIy/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012081.outbound.protection.outlook.com [52.103.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984DE33086;
	Mon, 29 Sep 2025 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759168568; cv=fail; b=VUxpMdYg/nGMnEqHGBlDrFU+XEXP6+Z3lcNgT+Gj/tUL3EoKItEoI/PIie6QR09CTOVMFBbt03AZNqkBjVNC8KerezmkgW6E6R87x8KrKZIcv9mjXs9R0XmhtZXTtkD5dkNaDpwtAAxi/9IZ5cdWDIxCqNzqM6U2a9KjzeAcLe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759168568; c=relaxed/simple;
	bh=aQqRewcgJmZyhvcZcx0Rp/e5Pe6ddtXK9boCyBGjVFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YarkUOX32BDPrfzqA9KSGk4/g/x4odLx9bKitJnhkw4Lx1Hfmcd06Am+6tIO01Sj0xfbqohblEgANURi/NxBwKmBvTn0oT7gz7k4g7SF4t4aH6xbq1WThiJrB3POUQVVyLzQjKJmDAFHUi26YuQnR509PQ/z+7sM9Dt+rAuf7Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Fc7PdIy/; arc=fail smtp.client-ip=52.103.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxJNQgs5HjVITe1qlSgCiuW6962N/Ij6ZSIRZIwwxOXr0o1e84BEeI+lvygcYYyoH0tivtb7WaQm0qmQdmGi+U+J5pfXwJ5G9QnJ377xGdufyks142OAyTnrsuQ6+UuvdAO+TCHb6gnpgQZWaDT2PNN84Iz+OXC8KDiYxJyntmqxGBaPsLxzDk5fNzhvgqhe05B8Q3EYUEyOXC7JrYz+ppackPflRiJGSDOutixzWTyIg+yyANYI0JkdF8uZPIxVPzvooYsL/uQxlYSpZOEJM6r+nSZO6f2rvUFH3+N18CFnE8sGvoJK15Mk6CQ7/WCc0oBr1Ff+tvoEqU/1Ntdw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uzx5sMLu/hb7tMlcOFl8KfnBmhkgvaI6KbJlcDs2qY=;
 b=CqEfnQvAfXmvHEHX8uVWhGprxD03e6hBrlpC5trDy4fR+/DmsIb6OPJnT2kg+Qqre4X+o08J5nZcT+xe25MvYB//lKGiCw2p+Pc3AHv40ILwAnWQHxQRxKo3R+T3AY8zRLinro2XUWLRzfSrYRUeJHD5dlGljJh9YjZ8wbNYMmG86qAe87fC7PeVZ7Q6BdWHXXpUfZpO6sLDUp8d3+fi2WXJC+YJNWN6IIR6EDZTs2KaRNf1JNItGbTuS/feOvYoKnB5NwwRQKGoM0TuMczeTx3YKvXb0CUi4aCWSCNFF5cCVXH2Ek4Gfj0daVu+r25bj1xQir5bhMrUbQBIUHDUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uzx5sMLu/hb7tMlcOFl8KfnBmhkgvaI6KbJlcDs2qY=;
 b=Fc7PdIy/xASLWrt/NuQayUBS5QQ9hZ+0wOp+sJHiiaxSBUKbJXRTJYL2WXMw1aPtygJqt3e5Pf3reY8ikiXSAi7vzgh2F3dQo7qrFK1j75+MVBbuqpRNFzFIFYMQ4wfxa5oL6ftym+7ixGY2I/Xo2DTeWQWHN5uW14ZA2jQuyWtzZY+EPIpElvO6Yb+S1tQX41QyN1QUMVIAYXrw5OqVxOos5YiRf0ouct6S2o+DwXfXOUgaGSEQRg/mNf0jIqduKvmqvb94F29JfND1h9TT4zPtmXIQ1CGbHbminvufBZWxVERCQG8sk41M/FBw0qnSBz2ZF9c798VBkGO3nIt+nw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA0PR02MB9897.namprd02.prod.outlook.com (2603:10b6:208:489::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 17:55:57 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 17:55:57 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "tiala@microsoft.com"
	<tiala@microsoft.com>, "anirudh@anirudhrb.com" <anirudh@anirudhrb.com>,
	"paekkaladevi@linux.microsoft.com" <paekkaladevi@linux.microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>
Subject: RE: [PATCH v4 2/5] mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX
 hypercall
Thread-Topic: [PATCH v4 2/5] mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX
 hypercall
Thread-Index: AQHcLwH6n8rMNUlRBEyCsepRDQ0gnbSqcQGw
Date: Mon, 29 Sep 2025 17:55:57 +0000
Message-ID:
 <SN6PR02MB415781A21E3F8CF52AB2A579D41BA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758903795-18636-3-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1758903795-18636-3-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA0PR02MB9897:EE_
x-ms-office365-filtering-correlation-id: 265e69a7-e146-46de-3d38-08ddff81715a
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|19110799012|13091999003|41001999006|15080799012|12121999013|8062599012|8060799015|3412199025|440099028|40105399003|52005399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GDLBiyGIPe+CQZFqLWhFp+7V6kPFh+cOT90lIavtj2BJxu4TPPkNJ7uVtDBA?=
 =?us-ascii?Q?Ow1KHt1n54wy1zaR+ttHTk8EccZVKmYFt0AfkKabcqMxP9ObWfUPEwUPHqoE?=
 =?us-ascii?Q?cJD/eEL65ZyB9yEX14cFa79wdzEWXrix3ya731SUOv9gtyMr9xVC+/YfCrxe?=
 =?us-ascii?Q?td/pr+Kn9UrX6+LDnWrSm8Js3lOtCQ2tXSlLVvHWAEJ1axm8nw45Xd76fssU?=
 =?us-ascii?Q?bE3JQtU7LO0O6ti9gRug6qGBIu0IsdXULtFbNTxrfougcyneOGkTLu/oUaJM?=
 =?us-ascii?Q?3o1LoYh0lq0+Jl3vtW+msFeNkR9rjSvVpLmvBAttzn08rVwLOhbigSEQ2YUY?=
 =?us-ascii?Q?vDKnE9rFt4HrQJWVt+8jURWrnpARQpCuEd/7/ckoSQX51FCsBPChZfrMMWoE?=
 =?us-ascii?Q?aclELSLXHnZuKrflB5sYtRtqjPDh5lrJ3v3XdntUCSNXaJ0o56ArlKTTWn51?=
 =?us-ascii?Q?S9riMY9cDik9LSCDJ/D5I6o8SV+ydqNXoalg42lOU6kuPMJ/2Dt9dZ8w2CEC?=
 =?us-ascii?Q?jer7nQsJYTC+8UX5+r0NpeC5NrKTFzBRsOUoYIH8FBk8iFVne1rS8LfNP2yy?=
 =?us-ascii?Q?9Ny1cZntH2mmbIdv7kn8B2azf/bK6bdwHZCxNoH1AhMeGFQuV8xOAkwSqNGr?=
 =?us-ascii?Q?gufINCHOJg1KVL4dP0VUu7CM0bE21bgKAIDyzUyYMGuLjGsEuGEOXttSRn0N?=
 =?us-ascii?Q?tYnBK3VMn8LFxW/V2cmG3xpl7x5/Bvm06umP9hr44qy0W2j2mHgo/UKPC79K?=
 =?us-ascii?Q?8ivrqooS2GgD32hTefSc7XI95EPRu2c4o/kbgF0HjRUgArfVw6sQmIlGSx8u?=
 =?us-ascii?Q?8FHVOu0/PvBtjbFza569svu2W9ehWdhnwbMqEKRel4EFvRYGOxPJug1WCend?=
 =?us-ascii?Q?g4EXI0XHPB3IYLCj0SX+XuJPpnewfnULmWkXie81xgmRis6Dx/iiM2H9Unpi?=
 =?us-ascii?Q?ICDLNCVYNN681iUwv0LjGHyltsFOZc5bQcHRXhlyc6YJ6MOu4Q5m1ic9fsAt?=
 =?us-ascii?Q?L/9vx/YzM9NC6D+1nad7nPSQlv6WK4/KtQiNDm6z7IptriMIoBVQY2qIIfhy?=
 =?us-ascii?Q?uivhP8WhskeRKvZl463qf650zLXj+RfV6XoGA8CNPPJ/hyP0YElSUjDEr2AG?=
 =?us-ascii?Q?e3RVbUOXDanqwFvUYEjZrSQ65pzCqoDP8re5hm37zQ76Fpg/dmvZh10yUTtc?=
 =?us-ascii?Q?Z53ZBsYlD+7DQk9e9WIkT50FfBviG8UdBTtvfHughoOyNhgvS74B936IC0Uw?=
 =?us-ascii?Q?49yf/qOP3R44r2ilcltxialZYyJqnGKrkDcnheIp39RC7FWobKnMoHfV9//c?=
 =?us-ascii?Q?yTlXoyj17CtYiy/fHWjA8eSQ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nzKerWfUMpojMNv2I2jWzpuq11EnYlleqmE1MXvhddmSuuyUscJX5fE4xfx8?=
 =?us-ascii?Q?oLv0OxffhOqrqqPcnr6z6mL2hY8J+GUaeXN+potc0quK+27Nu8dIs8tBAZg/?=
 =?us-ascii?Q?JYoJ67XE2cYDeBAG17uqFTkVYwsw4wJwWcUYJIS7N5Rpb3rqupaMgrfpgGt8?=
 =?us-ascii?Q?aiAG5fdOgvMydE1SAFnjXZs/pTU6ldJrITn8qKsxuTto3Jp0KgXhOM3BODAf?=
 =?us-ascii?Q?3dUbYPg6k7EpQHTZ1W89ufk5TqabAcO1DUQb4qXPR8XVPpHdH0x1IDHixFh8?=
 =?us-ascii?Q?51KpKrq6dTqaN+dNUkb2qM3KUN1upBGB0pyjqmcQQ50el6AgOxoxwK+LpeTT?=
 =?us-ascii?Q?psAdMwKFVksX/aCeeujS6gMSnVCW3k6dPbN8AD70W5dsuX8eJQYWWPCiAb5/?=
 =?us-ascii?Q?MZitFoI3c0SNfAITHTNTwbiFZoHRq9bVRoZ7vM1q7Vn6TYJplEoJSq+73ArK?=
 =?us-ascii?Q?yeSbx22KCGPHwEGbFn6B2ABCotGX9p29VowCBMSYfBPr6DYwVhYcW+ONw+oO?=
 =?us-ascii?Q?gQSQrGGzXRRu87FxlLDInZwXCXNteIDsnYK9TVzqzOiHRBWCLTHgtqFic735?=
 =?us-ascii?Q?qWYC0ZgFWAaEumfqhc0v1UAmqtYlXpNaOl0a/Pr0OnJww0HHUIhjrKxjDJhp?=
 =?us-ascii?Q?EJbEsIP2BK7syh1ltRGZoocQ/oQXOZIisGVq0Gn6gcBcEf59QwpCzkVN8sw9?=
 =?us-ascii?Q?gWkYtvm/DA94bKHJFkwG77CrzfrhkTkcWllpbuGpAFVszEcaYLT3GYQqN2hj?=
 =?us-ascii?Q?oY6rV74md7HoRL4dTVvLBUZlIQEsFjz6LZMWR0ocShgC6bNRypaJaIL9fxAS?=
 =?us-ascii?Q?1nfom6G9TGnLzuhRi02/AP5vzWjwkjP93QTuMkWUmLV0sU5trGalLUQKGRbm?=
 =?us-ascii?Q?cPug3kmRvo9VZitBZYIeC2T6BT1GyslgiclJ/S2Xdu0KoF2RsucmK6xV77Rs?=
 =?us-ascii?Q?mfS0hgNrBVdc2D3sIp6Cp46YwpHSTYaahqrOCraaUlOrRgye58AllNr3Ghh0?=
 =?us-ascii?Q?lJcfqcL15IJZd0N8AW3bhCy7fzGlz2dYpV76/+OpvQ9/xnyfsTqg0gyjxxtT?=
 =?us-ascii?Q?rJE2XWbShsqODhEPC0ZKhTQ/VsJk/KFsa9DKzd+VQTrnofcdg796OXsczymq?=
 =?us-ascii?Q?1JZe9H8mUH0Gbqrbt5jP562lOlPQ+QhD+tbJPfK8y8z1yMk8DT4WGBjDL8sW?=
 =?us-ascii?Q?/lnPYACbjSjOE5dVTMIJmi06u7X3D4xJ0Ia7RO+u79AdRiG/mEggecWXmCk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 265e69a7-e146-46de-3d38-08ddff81715a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 17:55:57.3695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9897

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Septe=
mber 26, 2025 9:23 AM
>=20
> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>=20
> This hypercall can be used to fetch extended properties of a
> partition. Extended properties are properties with values larger than
> a u64. Some of these also need additional input arguments.
>=20
> Add helper function for using the hypercall in the mshv_root driver.
>=20
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.micros=
oft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Anirudh Rayabharam <anirudh@anirudhrb.com>
> Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         |  2 ++
>  drivers/hv/mshv_root_hv_call.c | 31 ++++++++++++++++++++++++++
>  include/hyperv/hvgdk_mini.h    |  1 +
>  include/hyperv/hvhdk.h         | 40 ++++++++++++++++++++++++++++++++++
>  include/hyperv/hvhdk_mini.h    | 26 ++++++++++++++++++++++
>  5 files changed, 100 insertions(+)
>=20
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index e3931b0f1269..4aeb03bea6b6 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -303,6 +303,8 @@ int hv_call_unmap_stat_page(enum hv_stats_object_type=
 type,
>  int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages=
,
>  				   u64 page_struct_count, u32 host_access,
>  				   u32 flags, u8 acquire);
> +int hv_call_get_partition_property_ex(u64 partition_id, u64 property_cod=
e, u64 arg,
> +				      void *property_value, size_t property_value_sz);
>=20
>  extern struct mshv_root mshv_root;
>  extern enum hv_scheduler_type hv_scheduler_type;
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index c9c274f29c3c..3fd3cce23f69 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -590,6 +590,37 @@ int hv_call_unmap_vp_state_page(u64 partition_id, u3=
2 vp_index, u32 type,
>  	return hv_result_to_errno(status);
>  }
>=20
> +int hv_call_get_partition_property_ex(u64 partition_id, u64 property_cod=
e,
> +				      u64 arg, void *property_value,
> +				      size_t property_value_sz)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_get_partition_property_ex *input;
> +	struct hv_output_get_partition_property_ex *output;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D partition_id;
> +	input->property_code =3D property_code;
> +	input->arg =3D arg;
> +	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_PROPERTY_EX, input, out=
put);
> +
> +	if (!hv_result_success(status)) {
> +		hv_status_debug(status, "\n");
> +		local_irq_restore(flags);

Nit: It would be marginally better to do the local_irq_restore() first, and=
 then
output the error message so that interrupts are not disabled any longer tha=
n
needed.

> +		return hv_result_to_errno(status);
> +	}
> +	memcpy(property_value, &output->property_value, property_value_sz);
> +
> +	local_irq_restore(flags);
> +
> +	return 0;
> +}
> +
>  int
>  hv_call_clear_virtual_interrupt(u64 partition_id)
>  {
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 1be7f6a02304..ff4325fb623a 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -490,6 +490,7 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_GET_VP_STATE				0x00e3
>  #define HVCALL_SET_VP_STATE				0x00e4
>  #define HVCALL_GET_VP_CPUID_VALUES			0x00f4
> +#define HVCALL_GET_PARTITION_PROPERTY_EX		0x0101
>  #define HVCALL_MMIO_READ				0x0106
>  #define HVCALL_MMIO_WRITE				0x0107
>=20
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index b4067ada02cf..416c0d45b793 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -376,6 +376,46 @@ struct hv_input_set_partition_property {
>  	u64 property_value;
>  } __packed;
>=20
> +union hv_partition_property_arg {
> +	u64 as_uint64;
> +	struct {
> +		union {
> +			u32 arg;
> +			u32 vp_index;
> +		};
> +		u16 reserved0;
> +		u8 reserved1;
> +		u8 object_type;
> +	} __packed;
> +};
> +
> +struct hv_input_get_partition_property_ex {
> +	u64 partition_id;
> +	u32 property_code; /* enum hv_partition_property_code */
> +	u32 padding;
> +	union {
> +		union hv_partition_property_arg arg_data;
> +		u64 arg;

This union, and the "u64 arg" member, seems redundant since
union hv_partition_property_arg already has a member "as_uint64".

Maybe this is just being copied from the Windows versions of these
structures, in which case I realize there are constraints on what you
want to change or fix, and you can ignore my comment.

> +	};
> +} __packed;
> +
> +/*
> + * NOTE: Should use hv_input_set_partition_property_ex_header to compute=
 this
> + * size, but hv_input_get_partition_property_ex is identical so it suffi=
ces
> + */
> +#define HV_PARTITION_PROPERTY_EX_MAX_VAR_SIZE \
> +	(HV_HYP_PAGE_SIZE - sizeof(struct hv_input_get_partition_property_ex))
> +
> +union hv_partition_property_ex {
> +	u8 buffer[HV_PARTITION_PROPERTY_EX_MAX_VAR_SIZE];

It's unclear what this "buffer" field is trying to do, and particularly its=
 size.
The comment above references hv_input_set_partition_property_ex_header,
which doesn't exist in the Linux code.  And why is the max size of the outp=
ut
buffer reduced by the size of the header of the input to "set partition pro=
perty"?

> +	struct hv_partition_property_vmm_capabilities vmm_capabilities;
> +	/* More fields to be filled in when needed */
> +};
> +
> +struct hv_output_get_partition_property_ex {
> +	union hv_partition_property_ex property_value;
> +} __packed;
> +
>  enum hv_vp_state_page_type {
>  	HV_VP_STATE_PAGE_REGISTERS =3D 0,
>  	HV_VP_STATE_PAGE_INTERCEPT_MESSAGE =3D 1,
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 858f6a3925b3..bf2ce27dfcc5 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -96,8 +96,34 @@ enum hv_partition_property_code {
>  	HV_PARTITION_PROPERTY_XSAVE_STATES                      =3D 0x00060007,
>  	HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE		=3D 0x00060008,
>  	HV_PARTITION_PROPERTY_PROCESSOR_CLOCK_FREQUENCY		=3D 0x00060009,
> +
> +	/* Extended properties with larger property values */
> +	HV_PARTITION_PROPERTY_VMM_CAPABILITIES			=3D 0x00090007,
>  };
>=20
> +#define HV_PARTITION_VMM_CAPABILITIES_BANK_COUNT		1
> +#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	59
> +
> +struct hv_partition_property_vmm_capabilities {
> +	u16 bank_count;
> +	u16 reserved[3];
> +	union {
> +		u64 as_uint64[HV_PARTITION_VMM_CAPABILITIES_BANK_COUNT];
> +		struct {
> +			u64 map_gpa_preserve_adjustable: 1;
> +			u64 vmm_can_provide_overlay_gpfn: 1;
> +			u64 vp_affinity_property: 1;
> +#if IS_ENABLED(CONFIG_ARM64)
> +			u64 vmm_can_provide_gic_overlay_locations: 1;
> +#else
> +			u64 reservedbit3: 1;
> +#endif
> +			u64 assignable_synthetic_proc_features: 1;
> +			u64 reserved0: HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT;
> +		} __packed;
> +	};
> +} __packed;
> +
>  enum hv_snp_status {
>  	HV_SNP_STATUS_NONE =3D 0,
>  	HV_SNP_STATUS_AVAILABLE =3D 1,
> --
> 2.34.1
>=20


