Return-Path: <linux-hyperv+bounces-6162-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 970BBAFEFAE
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 19:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F051C470E2
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 17:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB8A224256;
	Wed,  9 Jul 2025 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YdSVe6V1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2063.outbound.protection.outlook.com [40.92.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F7F1E5B6A;
	Wed,  9 Jul 2025 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081564; cv=fail; b=JWwbK0qJ0Hb2Z+cDCNq52cw2lfAkrCzRokVesA/wtqM9WWOZwhYLwkAhPilrESvg4rtI7xS8MYT9vmYn1y5M1At+eHSqDuEwpK13yyVLKMZdmR4EtOja/h6GHuOe8rBKy19kL6JizqaB0pZHFLLMusmasJuIGoxVigL+tr6GAio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081564; c=relaxed/simple;
	bh=rwIlpFbTHLRqg0fNlkVF2SmUwRvlD4lvv3d2t8RXr9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nEQeQ95sMogqR/EqvNjw2JYbxpLJF6e9qBIyMqf4Ff+Qz10oJDWnJzYyjUlxeX2fK5qCmypCL/TZlgHIXSVskCl76uW6qAZqyiBDnce6QLBOkI+lJfkY6tUPqyLmd+F8C05V2DQMEmF0js6hfC9vxchdFdCSFvj1lGmogrFrSLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YdSVe6V1; arc=fail smtp.client-ip=40.92.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heIRPe/Oc4FyBNMiAdkJTg6dJ9TyfgkfeQ1xfLWBSCICCDRPynSSh5k3qtWrCZnU+jMHdY/EF38IVFBIHhbQMAYn9gMeXRokcCul7qxKVYMZnV4onob2CxSSuKKn/Vhv35HOqR+iH0afNbw/Lvm4jkY1DmO1pyP7vPp2PCOqnMo5RxvcwmAvhXvuWCmhXg2/ujWoGPTbUjYZ5Wz4EG729+jmA7q4aKCj99GtAVxNxjljhkZ2wSPtkIuO6lLmfATqSrGW2zQ8EhMLvgeo/OMeBk+xuOgLjutihOP1HyDekrI6L5Y3ZARgRZLTWdFalwzxsv5vLNr9z8P8CXpB90pclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuW+AbmAnm1fk5U7/LDvfpinrNtqn+qd+r2azV3VzKc=;
 b=Z8T9mSmSEOZ69Nu49h/shdL7Xz/9pgmxf/srq5py1d0b8lSESt/v5RMLkcjcbTR4BfIk6b/bLRYhldadrRwIg4oOFqCsq5XoSl4UN9UnnNFWRhbEVZdqfcfYpWfY/yO6glW45P8lYmexqBlNT90QjquIDSAgPWYecJMQ12Nphe7LVfvZUBsRyvzZho83qN6bSM0breAM10Jxfcbq8WRMoRDkOSfcZvTsvZ4PbgQkC2m+j+UbVvQhAUpMzf5tYgArphD5yeQrgVPgkr7hi1Sgy4HmTKz9R8EzSz/kd4ruRC6hAXcQG7TXhk3GFe2TfErHUxGxNwFBP5g7J3YK3QKGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuW+AbmAnm1fk5U7/LDvfpinrNtqn+qd+r2azV3VzKc=;
 b=YdSVe6V1ua+fqgqY0fMJyi5PL5tmhuTuLCVSQ6jbHLyJVNhSkAMq+iYcVJ1B9iD7OQJ46/b6r9IY9BW8E/vibSBal1jbvSPafhzJ8pldVqb42i3tPfpxRLhaxdNn9TxSfn2c3BBJ4uDeLE4dGrjBugs1J3V3hi2WrbdQyQEnbTjUuaR/JzIpPh1/TyVQCHIP00t64zdktUpD1fah7BXEISBktsj7fI+orNKrMhc3W9tfm89/DMnWRmychvCcfhM4Bf9xjJLIMyeUzOgilSnnXQNn+VnPowFN/mr7LDKVkZWRVTSI3r0dbdXcYrsGlGQvnIZ2toJTopESjJ1xBSJ3Yw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM3PR02MB10276.namprd02.prod.outlook.com (2603:10b6:0:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 17:19:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Wed, 9 Jul 2025
 17:19:13 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: Roman Kisel <romank@linux.microsoft.com>, Anirudh Rayabharam
	<anrayabh@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [PATCH v5 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Index: AQHb2qJWl9MJjouTb0Sl2AaDU/QSG7QN8ajQ
Date: Wed, 9 Jul 2025 17:19:13 +0000
Message-ID:
 <SN6PR02MB4157F9F1F8493C74C9FCC6E4D449A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250611072704.83199-1-namjain@linux.microsoft.com>
 <20250611072704.83199-3-namjain@linux.microsoft.com>
In-Reply-To: <20250611072704.83199-3-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM3PR02MB10276:EE_
x-ms-office365-filtering-correlation-id: 031fd8b2-110a-4b39-7c5c-08ddbf0cba09
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|41001999006|40105399003|440099028|4302099013|3412199025|10035399007|12091999003|102099032|1602099012|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pTFLGA31A+LNkdP3G5lIIbEmsG0CAIayLOsIiSnol+tehryDSqBya+9UG+ae?=
 =?us-ascii?Q?NVmw9U02VAIubxUmrWBA3VKJ7V8URVKM6X6nO1jQ51O0vmqDmPRsZq+06QSi?=
 =?us-ascii?Q?3gUMZcsGT2jNGqtwC3BaFW/p3hMPXlXBMtHPj90AeywdouU6wlnjji+aaF8Y?=
 =?us-ascii?Q?gQ2AxzU9MlmkQC80o+kJB433aSKlEmekS8NkB9Vda0IMAvxK4rXvuVsk3eE5?=
 =?us-ascii?Q?R5jhO47UifrSTMTPnmECxbY5cG1mqqgXIw1+zGE6N0tBqvJEact/qQutN977?=
 =?us-ascii?Q?w/rfRSgT4Uj8vT/CjnJP2ECj3FAANpdS/jMN7qYjWIa6rat1vXw5BASzAjDP?=
 =?us-ascii?Q?eD/yDaG95G9DUnwgubQJaDOJy8LC+Cr09KcqbSzYiVDXQrgE+BdGZdTq7TjC?=
 =?us-ascii?Q?zR8pAXew/cQRrzHL4M3hnbasZ+YwHVVnT6SbUXVxsMna46zKWyK4+RB3bqmY?=
 =?us-ascii?Q?itAolp61l0nv0wR2nHanaa4usJaIH+PC62939SOs6FBi3zpWauou2+nNaGyb?=
 =?us-ascii?Q?x8NnR0xdqSRGBAN0k9ggnsrvyyyIzimF6q0it4OCIH1XjVZJTMPSabrexm0k?=
 =?us-ascii?Q?VYTm1mcFCmdeqx/DVPg0bKzrYDCmD49/RtWWErOdf5ZCSvKB6QeSxp/Y9ay/?=
 =?us-ascii?Q?kaaDFqmbtSCKhQ89vDCc1v0FCaCP+AQTDRAZZuI29kjp/Rl04wYVZfNmw2bB?=
 =?us-ascii?Q?B62B9zZ+fJyty1w4+/EevBI5BsqnR/ifuwYsH3iRzKNx6AbzcOfop/fa8CJy?=
 =?us-ascii?Q?B2k5MvPJcZGqauwofBa2HqoAT8yMqun5SppFqWkxjiU/mjDLDKzwYAuithSx?=
 =?us-ascii?Q?bs0C0SP4V3sVQXqLjzNdc/NvsVZWGruSHM9Su/IesHT+XK+H1o5J/TltnCeb?=
 =?us-ascii?Q?7Uxf27WV5hx7Gav7tNnsJE1AnJvxjGs6C2jRPr2sr8Egys+lkkHISu1gm0nD?=
 =?us-ascii?Q?6facUXNn8kl1zdJpsxK0fcHM5aF7ZZfZpKJ3w1UEjE4/XOqsof5sKt2yApGv?=
 =?us-ascii?Q?I8wEks3ePR0UAZNS1lfRVHxRXQ9o+YzjSMhkzpVYKfK/SWSew4yL0DTK1a9I?=
 =?us-ascii?Q?aYzoKpWI9U7b5nK8T5WDpEBNAnJkPefMN4P9T8/n91eEO4waJQmGtIR06XO2?=
 =?us-ascii?Q?lXYrM5g2esoh8902uWMG5uhT0NQLMoDL/2ES+WatKvX6J1beppYr29jJVoBq?=
 =?us-ascii?Q?7x4b0VzvCsHjVclEqSo22FeqzrSPrsVf17VlRQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rE5wIFUXDhCyNUvFSeRd+fVY1nClsU3EN+P9NhWgNz19yhEb3hMhyF0XHSpS?=
 =?us-ascii?Q?sQ7KXTa6K7xKnKADRznZYhyNaJZLtKp3T8feNfdAQy6PuW5AUyVMczqk7d/3?=
 =?us-ascii?Q?i+yVRt63nnEPxBytZgOUhyY3Hl6WtxFB8ncyj/PgamTZK1Z+C7e+YT2MXrqw?=
 =?us-ascii?Q?I2st3oI/D9YX5I/imzLT0Hp/idGn+NSRDIZ32e9F+CfYeOlKyB1aEafW58Ui?=
 =?us-ascii?Q?8Om1pHsSYay9lVWIuybr24zHcnqnBB5LQGPY8KEqQqPXbA4LCH9euBf4nEvW?=
 =?us-ascii?Q?Iin0emQ7dsySss+np0Ato1ttdEa4+FPQQVb6+1K7REnK1cHuvKLvXobeXDi4?=
 =?us-ascii?Q?wP/mYEKgCjYMuuvCdubdrCMDDVJYAZfqx1C6gd6G1cxQgdnVxev9zsR/TTOX?=
 =?us-ascii?Q?KNuecS9+CZlKf1LM2JV0Wz+XxGm629qkdiVTg9I7k5yAoFBQ7voMKmW+RESe?=
 =?us-ascii?Q?tlGeMf3JR9Ank6zWM/iVUnk/csjXFReeSR8/pubDiuZf4lpZuqbqDhLN5YH6?=
 =?us-ascii?Q?xOlpR1TiGZJjeiA70jiDN2qSJscPtcVcAgj1/FsrDwb976B01T67ukaorkr/?=
 =?us-ascii?Q?eeTjGwCXlZvzaKytLL+mZc9+U4t2090HloXHYINd+e9+1C5jyqbfCvUdQM1y?=
 =?us-ascii?Q?4Vv3fiJ83izpkr3H5pfQKpYl9Yq0FCfzO/rwbmQK7W+4KIKZVuQ1saQsQK8I?=
 =?us-ascii?Q?JVyIgvdntvLE6LL+HvIWoLm/45vbLrOKdXA4323VEH1bMhlq4LQ8Xi++gCGy?=
 =?us-ascii?Q?kBYoqAWs/jx2NerwY3Ra6/pj/LLOQIhqePOrJK0ZRcvbNzq6s424qOkyuSpj?=
 =?us-ascii?Q?qkubSS6MHKHjitv9z6ReZGPHyZfZyp921QG5sPaSDaaD4MHOm9bWqHlB8Y2F?=
 =?us-ascii?Q?IxiWZltJGMMbXolS+D4jQwepDajErm8Gky02CLQ1L8aChUXUP4kss/jDgTL1?=
 =?us-ascii?Q?s3yfVk4ri0uBrhvEcax/PgwujnRq7Os1h48NVOQGCxsmU25OcpLyBkkEQ4Lb?=
 =?us-ascii?Q?iDnSsK3jhoaD5U4ZsS0SYUKnRhbe06sYot+nQCIMboNG8zW45kh8OdCNd2aL?=
 =?us-ascii?Q?sKaiMLVz1VvW8Y0N8A+WNGbryyW+P7YWbpmIfS1qkrrKa9U+YOmFjGSL/2Az?=
 =?us-ascii?Q?8kd4tE4QCDKW2H/KRloMj5sOnNoWZWiDH253JMWThlMx+rFUi926xB+UNthU?=
 =?us-ascii?Q?rKvx0j9ZWHd45f2KeT/lVIJ/ddNHQHHkfPXMn/Eip9qgH6LWFYuxYOgKZ38?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 031fd8b2-110a-4b39-7c5c-08ddbf0cba09
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 17:19:13.7727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR02MB10276

From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, June 11, 20=
25 12:27 AM
>=20
> Provide an interface for Virtual Machine Monitor like OpenVMM and its
> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
> Expose devices and support IOCTLs for features like VTL creation,
> VTL0 memory management, context switch, making hypercalls,
> mapping VTL0 address space to VTL2 userspace, getting new VMBus
> messages and channel events in VTL2 etc.
>=20

I know it has been 4 weeks since you posted this patch, but I'm just
now getting around to reviewing it. :-(

I've reviewed most of it reasonably carefully, but there are some
parts, such as entering/exiting VTLs that I don't know the details of,
and so just glossed over.

> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Message-ID: <20250512140432.2387503-3-namjain@linux.microsoft.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig          |   23 +
>  drivers/hv/Makefile         |    7 +-
>  drivers/hv/mshv_vtl.h       |   52 +
>  drivers/hv/mshv_vtl_main.c  | 1783 +++++++++++++++++++++++++++++++++++
>  include/hyperv/hvgdk_mini.h |   81 ++
>  include/hyperv/hvhdk.h      |    1 +
>  include/uapi/linux/mshv.h   |   82 ++
>  7 files changed, 2028 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/hv/mshv_vtl.h
>  create mode 100644 drivers/hv/mshv_vtl_main.c
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 1cd188b73b74..1403b4abbece 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -73,4 +73,27 @@ config MSHV_ROOT
>=20
>  	  If unsure, say N.
>=20
> +config MSHV_VTL
> +	tristate "Microsoft Hyper-V VTL driver"
> +	depends on HYPERV && X86_64
> +	# Mapping VTL0 memory to a userspace process in VTL2 is supported in Op=
enHCL.
> +	# VTL2 for OpenHCL makes use of Huge Pages to improve performance on VM=
s,
> +	# specially with large memory requirements.
> +	depends on TRANSPARENT_HUGEPAGE
> +	# MTRRs are controlled by VTL0, and are not specific to individual VTLs=
.
> +	# Therefore, do not attempt to access or modify MTRRs here.
> +	depends on !MTRR
> +	select CPUMASK_OFFSTACK
> +	select HYPERV_VTL_MODE

I think "depends on HYPERV_VTL_MODE" would work better here. Kconfig
allows you to "select" something that has dependencies that aren't satisfie=
d,
with the result that the kernel probably won't build. HYPERV_VTL_MODE
has dependencies like "SMP" that you would need to duplicate here. If
you change this to "depends on", then you don't need "depends on HYPERV"
because that's covered by HYPERV_VTL_MODE. It looks like for now this
is restricted to X86_64, though I'm guessing at some point in the future th=
at
restriction will go away.

> +	default n
> +	help
> +	  Select this option to enable Hyper-V VTL driver support.
> +	  This driver provides interfaces for Virtual Machine Manager (VMM) run=
ning in VTL2
> +	  userspace to create VTLs and partitions, setup and manage VTL0 memory=
 and
> +	  allow userspace to make direct hypercalls. This also allows to map VT=
L0's address
> +	  space to a usermode process in VTL2 and supports getting new VMBus me=
ssages and channel
> +	  events in VTL2.
> +
> +	  If unsure, say N.
> +
>  endmenu
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 976189c725dc..c53a0df746b7 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o
>  obj-$(CONFIG_HYPERV_UTILS)	+=3D hv_utils.o
>  obj-$(CONFIG_HYPERV_BALLOON)	+=3D hv_balloon.o
>  obj-$(CONFIG_MSHV_ROOT)		+=3D mshv_root.o
> +obj-$(CONFIG_MSHV_VTL)          +=3D mshv_vtl.o
>=20
>  CFLAGS_hv_trace.o =3D -I$(src)
>  CFLAGS_hv_balloon.o =3D -I$(src)
> @@ -14,7 +15,11 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+=3D
> hv_debugfs.o
>  hv_utils-y :=3D hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
>  mshv_root-y :=3D mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o=
 \
>  	       mshv_root_hv_call.o mshv_portid_table.o
> +mshv_vtl-y :=3D mshv_vtl_main.o
>=20
>  # Code that must be built-in
>  obj-$(subst m,y,$(CONFIG_HYPERV)) +=3D hv_common.o
> -obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) +=3D hv_proc.o mshv_common.o
> +obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) +=3D hv_proc.o
> +ifneq ($(CONFIG_MSHV_ROOT) $(CONFIG_MSHV_VTL),)
> +    obj-y +=3D mshv_common.o
> +endif
> diff --git a/drivers/hv/mshv_vtl.h b/drivers/hv/mshv_vtl.h
> new file mode 100644
> index 000000000000..f765fda3601b
> --- /dev/null
> +++ b/drivers/hv/mshv_vtl.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _MSHV_VTL_H
> +#define _MSHV_VTL_H
> +
> +#include <linux/mshv.h>
> +#include <linux/types.h>
> +#include <asm/fpu/types.h>
> +
> +struct mshv_vtl_cpu_context {
> +	union {
> +		struct {
> +			u64 rax;
> +			u64 rcx;
> +			u64 rdx;
> +			u64 rbx;
> +			u64 cr2;
> +			u64 rbp;
> +			u64 rsi;
> +			u64 rdi;
> +			u64 r8;
> +			u64 r9;
> +			u64 r10;
> +			u64 r11;
> +			u64 r12;
> +			u64 r13;
> +			u64 r14;
> +			u64 r15;
> +		};
> +		u64 gp_regs[16];
> +	};
> +
> +	struct fxregs_state fx_state;
> +};
> +
> +struct mshv_vtl_run {
> +	u32 cancel;
> +	u32 vtl_ret_action_size;
> +	u32 pad[2];
> +	char exit_message[MSHV_MAX_RUN_MSG_SIZE];
> +	union {
> +		struct mshv_vtl_cpu_context cpu_context;
> +
> +		/*
> +		 * Reserving room for the cpu context to grow and to maintain compatib=
ility
> +		 * with user mode.
> +		 */
> +		char reserved[1024];
> +	};
> +	char vtl_ret_actions[MSHV_MAX_RUN_MSG_SIZE];
> +};
> +
> +#endif /* _MSHV_VTL_H */
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> new file mode 100644
> index 000000000000..b1717b118772
> --- /dev/null
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -0,0 +1,1783 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Microsoft Corporation.
> + *
> + * Author:
> + *   Roman Kisel <romank@linux.microsoft.com>
> + *   Saurabh Sengar <ssengar@linux.microsoft.com>
> + *   Naman Jain <namjain@linux.microsoft.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/miscdevice.h>
> +#include <linux/anon_inodes.h>
> +#include <linux/pfn_t.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/count_zeros.h>
> +#include <linux/eventfd.h>
> +#include <linux/poll.h>
> +#include <linux/file.h>
> +#include <linux/vmalloc.h>
> +#include <asm/debugreg.h>
> +#include <asm/mshyperv.h>
> +#include <trace/events/ipi.h>
> +#include <uapi/asm/mtrr.h>
> +#include <uapi/linux/mshv.h>
> +#include <hyperv/hvhdk.h>
> +
> +#include "../../kernel/fpu/legacy.h"
> +#include "mshv.h"
> +#include "mshv_vtl.h"
> +#include "hyperv_vmbus.h"
> +
> +MODULE_AUTHOR("Microsoft");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Microsoft Hyper-V VTL Driver");
> +
> +#define MSHV_ENTRY_REASON_LOWER_VTL_CALL     0x1
> +#define MSHV_ENTRY_REASON_INTERRUPT          0x2
> +#define MSHV_ENTRY_REASON_INTERCEPT          0x3
> +
> +#define MAX_GUEST_MEM_SIZE	BIT_ULL(40)

This definition doesn't appear to be used anywhere. I was curious
about what the units are, but with no usage, maybe that's moot.

> +#define MSHV_PG_OFF_CPU_MASK	0xFFFF
> +#define MSHV_REAL_OFF_SHIFT	16

The above two definitions are related. Perhaps define the CPU_MASK
as "BIT_ULL(MSHV_REAL_OFF_SHIFT) - 1" so the relationship is
explicit?

> +#define MSHV_RUN_PAGE_OFFSET	0
> +#define MSHV_REG_PAGE_OFFSET	1
> +#define VTL2_VMBUS_SINT_INDEX	7
> +
> +static struct device *mem_dev;
> +
> +static struct tasklet_struct msg_dpc;
> +static wait_queue_head_t fd_wait_queue;
> +static bool has_message;
> +static struct eventfd_ctx *flag_eventfds[HV_EVENT_FLAGS_COUNT];
> +static DEFINE_MUTEX(flag_lock);
> +static bool __read_mostly mshv_has_reg_page;
> +
> +struct mshv_vtl_hvcall_fd {
> +	u64 allow_bitmap[2 * PAGE_SIZE];

Having PAGE_SIZE here begs the question of what happens on ARM64 if the
VTL0 guest has a page size other than 4K?  Does VTL2 always use 4K page
size, or must the VTL2 page size match VTL0? The Kconfig file is currently
set up with VTL2 supported only for x86, so the question is moot for the
moment, but I'm thinking ahead.

Separately, "allow_bitmap" size is 64K bytes, or 512K bits. Is that the
correct size?  From looking at mshv_vtl_hvcall_is_allowed(), I think this
bitmap is indexed by the HV call code, which is a 16 bit value. So you
only need 64K bits, and the size is too big by a factor of 8. In any case,
it seems like the size should not be expressed in terms of PAGE_SIZE.

> +	bool allow_map_initialized;
> +	/*
> +	 * Used to protect hvcall setup in IOCTLs
> +	 */
> +	struct mutex init_mutex;
> +	struct miscdevice *dev;
> +};
> +
> +struct mshv_vtl_poll_file {
> +	struct file *file;
> +	wait_queue_entry_t wait;
> +	wait_queue_head_t *wqh;
> +	poll_table pt;
> +	int cpu;
> +};
> +
> +struct mshv_vtl {
> +	struct device *module_dev;
> +	u64 id;
> +};
> +
> +union mshv_synic_overlay_page_msr {
> +	u64 as_uint64;
> +	struct {
> +		u64 enabled: 1;
> +		u64 reserved: 11;
> +		u64 pfn: 52;
> +	};

Since this appear to be a Hyper-V synthetic MSR, add __packed?

> +};
> +
> +union hv_register_vsm_capabilities {
> +	u64 as_uint64;
> +	struct {
> +		u64 dr6_shared: 1;
> +		u64 mbec_vtl_mask: 16;
> +		u64 deny_lower_vtl_startup: 1;
> +		u64 supervisor_shadow_stack: 1;
> +		u64 hardware_hvpt_available: 1;
> +		u64 software_hvpt_available: 1;
> +		u64 hardware_hvpt_range_bits: 6;
> +		u64 intercept_page_available: 1;
> +		u64 return_action_available: 1;
> +		u64 reserved: 35;
> +	} __packed;
> +};
> +
> +union hv_register_vsm_page_offsets {
> +	struct {
> +		u64 vtl_call_offset : 12;
> +		u64 vtl_return_offset : 12;
> +		u64 reserved_mbz : 40;
> +	};
> +	u64 as_uint64;
> +} __packed;

We've usually put the __packed on the struct definition.  Consistency .... =
:-)

Don't these three register definitions belong somewhere in the
hvhdk or hvgdk include files?

> +
> +struct mshv_vtl_per_cpu {
> +	struct mshv_vtl_run *run;
> +	struct page *reg_page;
> +};
> +
> +static struct mutex mshv_vtl_poll_file_lock;
> +static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
> +static union hv_register_vsm_capabilities mshv_vsm_capabilities;
> +
> +static DEFINE_PER_CPU(struct mshv_vtl_poll_file, mshv_vtl_poll_file);
> +static DEFINE_PER_CPU(unsigned long long, num_vtl0_transitions);
> +static DEFINE_PER_CPU(struct mshv_vtl_per_cpu, mshv_vtl_per_cpu);
> +
> +static const struct file_operations mshv_vtl_fops;
> +
> +static long
> +mshv_ioctl_create_vtl(void __user *user_arg, struct device *module_dev)
> +{
> +	struct mshv_vtl *vtl;
> +	struct file *file;
> +	int fd;
> +
> +	vtl =3D kzalloc(sizeof(*vtl), GFP_KERNEL);
> +	if (!vtl)
> +		return -ENOMEM;
> +
> +	fd =3D get_unused_fd_flags(O_CLOEXEC);
> +	if (fd < 0) {
> +		kfree(vtl);
> +		return fd;
> +	}
> +	file =3D anon_inode_getfile("mshv_vtl", &mshv_vtl_fops,
> +				  vtl, O_RDWR);
> +	if (IS_ERR(file)) {
> +		kfree(vtl);
> +		return PTR_ERR(file);
> +	}
> +	vtl->module_dev =3D module_dev;
> +	fd_install(fd, file);
> +
> +	return fd;
> +}
> +
> +static long
> +mshv_ioctl_check_extension(void __user *user_arg)
> +{
> +	u32 arg;
> +
> +	if (copy_from_user(&arg, user_arg, sizeof(arg)))
> +		return -EFAULT;
> +
> +	switch (arg) {
> +	case MSHV_CAP_CORE_API_STABLE:
> +		return 0;
> +	case MSHV_CAP_REGISTER_PAGE:
> +		return mshv_has_reg_page;
> +	case MSHV_CAP_VTL_RETURN_ACTION:
> +		return mshv_vsm_capabilities.return_action_available;
> +	case MSHV_CAP_DR6_SHARED:
> +		return mshv_vsm_capabilities.dr6_shared;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static long
> +mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> +{
> +	struct miscdevice *misc =3D filp->private_data;
> +
> +	switch (ioctl) {
> +	case MSHV_CHECK_EXTENSION:
> +		return mshv_ioctl_check_extension((void __user *)arg);
> +	case MSHV_CREATE_VTL:
> +		return mshv_ioctl_create_vtl((void __user *)arg, misc->this_device);
> +	}
> +
> +	return -ENOTTY;
> +}
> +
> +static const struct file_operations mshv_dev_fops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.unlocked_ioctl	=3D mshv_dev_ioctl,
> +	.llseek		=3D noop_llseek,
> +};
> +
> +static struct miscdevice mshv_dev =3D {
> +	.minor =3D MISC_DYNAMIC_MINOR,
> +	.name =3D "mshv",
> +	.fops =3D &mshv_dev_fops,
> +	.mode =3D 0600,
> +};
> +
> +static struct mshv_vtl_run *mshv_vtl_this_run(void)
> +{
> +	return *this_cpu_ptr(&mshv_vtl_per_cpu.run);
> +}
> +
> +static struct mshv_vtl_run *mshv_vtl_cpu_run(int cpu)
> +{
> +	return *per_cpu_ptr(&mshv_vtl_per_cpu.run, cpu);
> +}
> +
> +static struct page *mshv_vtl_cpu_reg_page(int cpu)
> +{
> +	return *per_cpu_ptr(&mshv_vtl_per_cpu.reg_page, cpu);
> +}
> +
> +static void mshv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu=
)
> +{
> +	struct hv_register_assoc reg_assoc =3D {};
> +	union mshv_synic_overlay_page_msr overlay =3D {};
> +	struct page *reg_page;
> +	union hv_input_vtl vtl =3D { .as_uint8 =3D 0 };

This is the first of several places in this module where you need an input_=
vtl
value of 0.  Rather than declare and initialize a local variable for each u=
se
case, I'd suggest declaring a global static at the top of the module, and r=
euse
that global whenever needed.=20

> +
> +	reg_page =3D alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL);
> +	if (!reg_page) {
> +		WARN(1, "failed to allocate register page\n");
> +		return;
> +	}
> +
> +	overlay.enabled =3D 1;
> +	overlay.pfn =3D page_to_phys(reg_page) >> HV_HYP_PAGE_SHIFT;

Could use page_to_hvpfn() here.

> +	reg_assoc.name =3D HV_X64_REGISTER_REG_PAGE;
> +	reg_assoc.value.reg64 =3D overlay.as_uint64;
> +
> +	if (hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +				     1, vtl, &reg_assoc)) {
> +		WARN(1, "failed to setup register page\n");
> +		__free_page(reg_page);
> +		return;
> +	}
> +
> +	per_cpu->reg_page =3D reg_page;
> +	mshv_has_reg_page =3D true;
> +}
> +
> +static void mshv_vtl_synic_enable_regs(unsigned int cpu)
> +{
> +	union hv_synic_sint sint;
> +
> +	sint.as_uint64 =3D 0;
> +	sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	sint.masked =3D false;
> +	sint.auto_eoi =3D hv_recommend_using_aeoi();
> +
> +	/* Enable intercepts */
> +	if (!mshv_vsm_capabilities.intercept_page_available)
> +		hv_set_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
> +			   sint.as_uint64);
> +
> +	/* VTL2 Host VSP SINT is (un)masked when the user mode requests that */
> +}
> +
> +static int mshv_vtl_get_vsm_regs(void)
> +{
> +	struct hv_register_assoc registers[2];
> +	union hv_input_vtl input_vtl;
> +	int ret, count =3D 2;
> +
> +	input_vtl.as_uint8 =3D 0;

One of the places I mentioned earlier where you could use global value
instead of having to set up input_vtl here.

> +	registers[0].name =3D HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
> +	registers[1].name =3D HV_REGISTER_VSM_CAPABILITIES;
> +
> +	ret =3D hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF=
,
> +				       count, input_vtl, registers);
> +	if (ret)
> +		return ret;
> +
> +	mshv_vsm_page_offsets.as_uint64 =3D registers[0].value.reg64;
> +	mshv_vsm_capabilities.as_uint64 =3D registers[1].value.reg64;
> +
> +	return ret;
> +}
> +
> +static int mshv_vtl_configure_vsm_partition(struct device *dev)
> +{
> +	union hv_register_vsm_partition_config config;
> +	struct hv_register_assoc reg_assoc;
> +	union hv_input_vtl input_vtl;
> +
> +	config.as_uint64 =3D 0;
> +	config.default_vtl_protection_mask =3D HV_MAP_GPA_PERMISSIONS_MASK;
> +	config.enable_vtl_protection =3D 1;
> +	config.zero_memory_on_reset =3D 1;
> +	config.intercept_vp_startup =3D 1;
> +	config.intercept_cpuid_unimplemented =3D 1;
> +
> +	if (mshv_vsm_capabilities.intercept_page_available) {
> +		dev_dbg(dev, "using intercept page\n");
> +		config.intercept_page =3D 1;
> +	}
> +
> +	reg_assoc.name =3D HV_REGISTER_VSM_PARTITION_CONFIG;
> +	reg_assoc.value.reg64 =3D config.as_uint64;
> +	input_vtl.as_uint8 =3D 0;

Another place to use the global input_vtl.

> +
> +	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +				       1, input_vtl, &reg_assoc);
> +}
> +
> +static void mshv_vtl_vmbus_isr(void)
> +{
> +	struct hv_per_cpu_context *per_cpu;
> +	struct hv_message *msg;
> +	u32 message_type;
> +	union hv_synic_event_flags *event_flags;
> +	unsigned long word;
> +	int i, j;
> +	struct eventfd_ctx *eventfd;
> +
> +	per_cpu =3D this_cpu_ptr(hv_context.cpu_context);
> +	if (smp_processor_id() =3D=3D 0) {
> +		msg =3D (struct hv_message *)per_cpu->synic_message_page + VTL2_VMBUS_=
SINT_INDEX;
> +		message_type =3D READ_ONCE(msg->header.message_type);
> +		if (message_type !=3D HVMSG_NONE)
> +			tasklet_schedule(&msg_dpc);
> +	}
> +
> +	event_flags =3D (union hv_synic_event_flags *)per_cpu->synic_event_page=
 +
> +			VTL2_VMBUS_SINT_INDEX;
> +	for (i =3D 0; i < HV_EVENT_FLAGS_LONG_COUNT; i++) {
> +		if (READ_ONCE(event_flags->flags[i])) {
> +			word =3D xchg(&event_flags->flags[i], 0);
> +			for_each_set_bit(j, &word, BITS_PER_LONG) {

Is there a reason for the complexity in finding and resetting bits that are
set in the sync_event_page?  See the code in vmbus_chan_sched() that I
think is doing the same thing, but with simpler code.

> +				rcu_read_lock();
> +				eventfd =3D READ_ONCE(flag_eventfds[i * BITS_PER_LONG + j]);
> +				if (eventfd)
> +					eventfd_signal(eventfd);
> +				rcu_read_unlock();
> +			}
> +		}
> +	}
> +
> +	vmbus_isr();
> +}
> +
> +static int mshv_vtl_alloc_context(unsigned int cpu)
> +{
> +	struct mshv_vtl_per_cpu *per_cpu =3D this_cpu_ptr(&mshv_vtl_per_cpu);
> +	struct page *run_page;
> +
> +	run_page =3D alloc_page(GFP_KERNEL | __GFP_ZERO);

Nit: Using __get_free_page() here would avoid having to deal with struct pa=
ge,
and having to translate from struct page to a virtual address.

> +	if (!run_page)
> +		return -ENOMEM;
> +
> +	per_cpu->run =3D page_address(run_page);
> +	if (mshv_vsm_capabilities.intercept_page_available)
> +		mshv_vtl_configure_reg_page(per_cpu);
> +
> +	mshv_vtl_synic_enable_regs(cpu);
> +
> +	return 0;
> +}
> +
> +static int mshv_vtl_cpuhp_online;
> +
> +static int hv_vtl_setup_synic(void)
> +{
> +	int ret;
> +
> +	/* Use our isr to first filter out packets destined for userspace */
> +	hv_setup_vmbus_handler(mshv_vtl_vmbus_isr);

Will the normal vmbus_isr() already be setup as the vmbus_handler when this
is called?  If so, then this will overwrite vmbus_isr() with mshv_vtl_vmbus=
_isr().

> +
> +	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vtl:online",
> +				mshv_vtl_alloc_context, NULL);
> +	if (ret < 0) {
> +		hv_remove_vmbus_handler();

But the error case won't restore vmbus_isr(). It will set vmbus_handler to =
NULL.
I'm not sure if that's OK or not. Maybe it doesn't really matter.

> +		return ret;
> +	}
> +
> +	mshv_vtl_cpuhp_online =3D ret;
> +
> +	return 0;
> +}
> +
> +static void hv_vtl_remove_synic(void)
> +{
> +	hv_remove_vmbus_handler();
> +	cpuhp_remove_state(mshv_vtl_cpuhp_online);

Unless there's a reason otherwise, for symmetry these two steps
should be done in the opposite order. The "remove" operation should
typically do things in the reverse order of the "setup" operation.

And again, note that this won't restore vmbus_handler if
vmbus_isr() was overwritten in hv_vtl_setup_synic().

> +}
> +
> +static int vtl_get_vp_registers(u16 count,
> +				struct hv_register_assoc *registers)
> +{
> +	union hv_input_vtl input_vtl;
> +
> +	input_vtl.as_uint8 =3D 0;
> +	input_vtl.use_target_vtl =3D 1;

You can also setup a static global for this case.

> +
> +	return hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +					count, input_vtl, registers);
> +}
> +
> +static int vtl_set_vp_registers(u16 count,
> +				struct hv_register_assoc *registers)
> +{
> +	union hv_input_vtl input_vtl;
> +
> +	input_vtl.as_uint8 =3D 0;
> +	input_vtl.use_target_vtl =3D 1;

And reuse the global here.

> +
> +	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +					count, input_vtl, registers);
> +}
> +
> +static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user=
 *arg)
> +{
> +	struct mshv_vtl_ram_disposition vtl0_mem;
> +	struct dev_pagemap *pgmap;
> +	void *addr;
> +
> +	if (copy_from_user(&vtl0_mem, arg, sizeof(vtl0_mem)))
> +		return -EFAULT;
> +
> +	if (vtl0_mem.last_pfn <=3D vtl0_mem.start_pfn) {
> +		dev_err(vtl->module_dev, "range start pfn (%llx) > end pfn (%llx)\n",
> +			vtl0_mem.start_pfn, vtl0_mem.last_pfn);
> +		return -EFAULT;
> +	}
> +
> +	pgmap =3D kzalloc(sizeof(*pgmap), GFP_KERNEL);
> +	if (!pgmap)
> +		return -ENOMEM;
> +
> +	pgmap->ranges[0].start =3D PFN_PHYS(vtl0_mem.start_pfn);
> +	pgmap->ranges[0].end =3D PFN_PHYS(vtl0_mem.last_pfn) - 1;

Perhaps this should be

	pgmap->ranges[0].end =3D PFN_PHYS(vtl0_mem.last_pfn + 1) - 1

otherwise the last page won't be included in the range. Or is excluding the
last page intentional?

> +	pgmap->nr_range =3D 1;
> +	pgmap->type =3D MEMORY_DEVICE_GENERIC;
> +
> +	/*
> +	 * Determine the highest page order that can be used for the given memo=
ry range.
> +	 * This works best when the range is aligned; i.e. both the start and t=
he length.
> +	 */
> +	pgmap->vmemmap_shift =3D count_trailing_zeros(vtl0_mem.start_pfn | vtl0=
_mem.last_pfn);
> +	dev_dbg(vtl->module_dev,
> +		"Add VTL0 memory: start: 0x%llx, end_pfn: 0x%llx, page order: %lu\n",
> +		vtl0_mem.start_pfn, vtl0_mem.last_pfn, pgmap->vmemmap_shift);
> +
> +	addr =3D devm_memremap_pages(mem_dev, pgmap);
> +	if (IS_ERR(addr)) {
> +		dev_err(vtl->module_dev, "devm_memremap_pages error: %ld\n", PTR_ERR(a=
ddr));
> +		kfree(pgmap);
> +		return -EFAULT;
> +	}
> +
> +	/* Don't free pgmap, since it has to stick around until the memory
> +	 * is unmapped, which will never happen as there is no scenario
> +	 * where VTL0 can be released/shutdown without bringing down VTL2.
> +	 */
> +	return 0;
> +}
> +
> +static void mshv_vtl_cancel(int cpu)
> +{
> +	int here =3D get_cpu();
> +
> +	if (here !=3D cpu) {
> +		if (!xchg_relaxed(&mshv_vtl_cpu_run(cpu)->cancel, 1))
> +			smp_send_reschedule(cpu);
> +	} else {
> +		WRITE_ONCE(mshv_vtl_this_run()->cancel, 1);
> +	}
> +	put_cpu();
> +}
> +
> +static int mshv_vtl_poll_file_wake(wait_queue_entry_t *wait, unsigned in=
t mode, int sync, void *key)
> +{
> +	struct mshv_vtl_poll_file *poll_file =3D container_of(wait, struct mshv=
_vtl_poll_file, wait);
> +
> +	mshv_vtl_cancel(poll_file->cpu);
> +
> +	return 0;
> +}
> +
> +static void mshv_vtl_ptable_queue_proc(struct file *file, wait_queue_hea=
d_t *wqh, poll_table *pt)
> +{
> +	struct mshv_vtl_poll_file *poll_file =3D container_of(pt, struct mshv_v=
tl_poll_file, pt);
> +
> +	WARN_ON(poll_file->wqh);
> +	poll_file->wqh =3D wqh;
> +	add_wait_queue(wqh, &poll_file->wait);
> +}
> +
> +static int mshv_vtl_ioctl_set_poll_file(struct mshv_vtl_set_poll_file __=
user *user_input)
> +{
> +	struct file *file, *old_file;
> +	struct mshv_vtl_poll_file *poll_file;
> +	struct mshv_vtl_set_poll_file input;
> +
> +	if (copy_from_user(&input, user_input, sizeof(input)))
> +		return -EFAULT;

Seems like input.cpu should be checked to make sure it's less than nr_cpu_i=
ds.
cpu_online() uses the value to index into a bit array without doing any che=
cks
unless CONFIG_DEBUG_PER_CPU_MAPS is set.

> +
> +	if (!cpu_online(input.cpu))
> +		return -EINVAL;

Having tested that the target CPU is online, does anything ensure that the
CPU stays online during the completion of this function? Usually the
cpus_read_lock() needs to be held to ensure that an online CPU stays
online for the duration of an operation.

> +
> +	file =3D NULL;
> +	file =3D fget(input.fd);
> +	if (!file)
> +		return -EBADFD;
> +
> +	poll_file =3D per_cpu_ptr(&mshv_vtl_poll_file, READ_ONCE(input.cpu));
> +	if (!poll_file)
> +		return -EINVAL;

Testing poll_file here confused me a bit. per_cpu_ptr() just does some poin=
ter
arithmetic and doesn't return NULL from what I can tell.

> +
> +	mutex_lock(&mshv_vtl_poll_file_lock);
> +
> +	if (poll_file->wqh)
> +		remove_wait_queue(poll_file->wqh, &poll_file->wait);
> +	poll_file->wqh =3D NULL;
> +
> +	old_file =3D poll_file->file;
> +	poll_file->file =3D file;
> +	poll_file->cpu =3D input.cpu;
> +
> +	if (file) {
> +		init_waitqueue_func_entry(&poll_file->wait, mshv_vtl_poll_file_wake);
> +		init_poll_funcptr(&poll_file->pt, mshv_vtl_ptable_queue_proc);
> +		vfs_poll(file, &poll_file->pt);
> +	}
> +
> +	mutex_unlock(&mshv_vtl_poll_file_lock);
> +
> +	if (old_file)
> +		fput(old_file);
> +
> +	return 0;
> +}
> +
> +static int mshv_vtl_set_reg(struct hv_register_assoc *regs)
> +{
> +	u64 reg64;
> +	enum hv_register_name gpr_name;
> +
> +	gpr_name =3D regs->name;
> +	reg64 =3D regs->value.reg64;
> +
> +	switch (gpr_name) {
> +	case HV_X64_REGISTER_DR0:
> +		native_set_debugreg(0, reg64);
> +		break;
> +	case HV_X64_REGISTER_DR1:
> +		native_set_debugreg(1, reg64);
> +		break;
> +	case HV_X64_REGISTER_DR2:
> +		native_set_debugreg(2, reg64);
> +		break;
> +	case HV_X64_REGISTER_DR3:
> +		native_set_debugreg(3, reg64);
> +		break;
> +	case HV_X64_REGISTER_DR6:
> +		if (!mshv_vsm_capabilities.dr6_shared)
> +			goto hypercall;
> +		native_set_debugreg(6, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_CAP:
> +		wrmsrl(MSR_MTRRcap, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_DEF_TYPE:
> +		wrmsrl(MSR_MTRRdefType, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0:
> +		wrmsrl(MTRRphysBase_MSR(0), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1:
> +		wrmsrl(MTRRphysBase_MSR(1), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2:
> +		wrmsrl(MTRRphysBase_MSR(2), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3:
> +		wrmsrl(MTRRphysBase_MSR(3), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4:
> +		wrmsrl(MTRRphysBase_MSR(4), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5:
> +		wrmsrl(MTRRphysBase_MSR(5), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6:
> +		wrmsrl(MTRRphysBase_MSR(6), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7:
> +		wrmsrl(MTRRphysBase_MSR(7), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8:
> +		wrmsrl(MTRRphysBase_MSR(8), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9:
> +		wrmsrl(MTRRphysBase_MSR(9), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA:
> +		wrmsrl(MTRRphysBase_MSR(0xa), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB:
> +		wrmsrl(MTRRphysBase_MSR(0xb), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC:
> +		wrmsrl(MTRRphysBase_MSR(0xc), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASED:
> +		wrmsrl(MTRRphysBase_MSR(0xd), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE:
> +		wrmsrl(MTRRphysBase_MSR(0xe), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF:
> +		wrmsrl(MTRRphysBase_MSR(0xf), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0:
> +		wrmsrl(MTRRphysMask_MSR(0), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1:
> +		wrmsrl(MTRRphysMask_MSR(1), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2:
> +		wrmsrl(MTRRphysMask_MSR(2), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3:
> +		wrmsrl(MTRRphysMask_MSR(3), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4:
> +		wrmsrl(MTRRphysMask_MSR(4), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5:
> +		wrmsrl(MTRRphysMask_MSR(5), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6:
> +		wrmsrl(MTRRphysMask_MSR(6), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7:
> +		wrmsrl(MTRRphysMask_MSR(7), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8:
> +		wrmsrl(MTRRphysMask_MSR(8), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9:
> +		wrmsrl(MTRRphysMask_MSR(9), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA:
> +		wrmsrl(MTRRphysMask_MSR(0xa), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB:
> +		wrmsrl(MTRRphysMask_MSR(0xb), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC:
> +		wrmsrl(MTRRphysMask_MSR(0xc), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD:
> +		wrmsrl(MTRRphysMask_MSR(0xd), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE:
> +		wrmsrl(MTRRphysMask_MSR(0xe), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF:
> +		wrmsrl(MTRRphysMask_MSR(0xf), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX64K00000:
> +		wrmsrl(MSR_MTRRfix64K_00000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX16K80000:
> +		wrmsrl(MSR_MTRRfix16K_80000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX16KA0000:
> +		wrmsrl(MSR_MTRRfix16K_A0000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KC0000:
> +		wrmsrl(MSR_MTRRfix4K_C0000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KC8000:
> +		wrmsrl(MSR_MTRRfix4K_C8000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KD0000:
> +		wrmsrl(MSR_MTRRfix4K_D0000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KD8000:
> +		wrmsrl(MSR_MTRRfix4K_D8000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KE0000:
> +		wrmsrl(MSR_MTRRfix4K_E0000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KE8000:
> +		wrmsrl(MSR_MTRRfix4K_E8000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KF0000:
> +		wrmsrl(MSR_MTRRfix4K_F0000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KF8000:
> +		wrmsrl(MSR_MTRRfix4K_F8000, reg64);
> +		break;
> +
> +	default:
> +		goto hypercall;
> +	}
> +
> +	return 0;
> +
> +hypercall:
> +	return 1;
> +}

To me, this function and the follow-on mshv_vtl_get_reg() are just
begging to be implemented using a static table that maps from
HV_X64_REGISTER_MSR* to MSR* (at least for the ~45 entries that
are not debug registers). Each of the functions could then search
through the table to find the HV_X64_REGISTER* and get the
matching x86 MSR value, followed by a single invocation of wrmsr()
or rdmsrl(). The generated code for mshv_vtl_set_reg() is about
1550 bytes, and a table search would be a lot smaller. The size
of mshv_vtl_get_reg() would be similarly reduced using the same
table. You'd probably end up with at least 100 fewer source code
lines as well.

> +
> +static int mshv_vtl_get_reg(struct hv_register_assoc *regs)
> +{
> +	u64 *reg64;
> +	enum hv_register_name gpr_name;
> +
> +	gpr_name =3D regs->name;
> +	reg64 =3D (u64 *)&regs->value.reg64;
> +
> +	switch (gpr_name) {
> +	case HV_X64_REGISTER_DR0:
> +		*reg64 =3D native_get_debugreg(0);
> +		break;
> +	case HV_X64_REGISTER_DR1:
> +		*reg64 =3D native_get_debugreg(1);
> +		break;
> +	case HV_X64_REGISTER_DR2:
> +		*reg64 =3D native_get_debugreg(2);
> +		break;
> +	case HV_X64_REGISTER_DR3:
> +		*reg64 =3D native_get_debugreg(3);
> +		break;
> +	case HV_X64_REGISTER_DR6:
> +		if (!mshv_vsm_capabilities.dr6_shared)
> +			goto hypercall;
> +		*reg64 =3D native_get_debugreg(6);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_CAP:
> +		rdmsrl(MSR_MTRRcap, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_DEF_TYPE:
> +		rdmsrl(MSR_MTRRdefType, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0:
> +		rdmsrl(MTRRphysBase_MSR(0), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1:
> +		rdmsrl(MTRRphysBase_MSR(1), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2:
> +		rdmsrl(MTRRphysBase_MSR(2), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3:
> +		rdmsrl(MTRRphysBase_MSR(3), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4:
> +		rdmsrl(MTRRphysBase_MSR(4), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5:
> +		rdmsrl(MTRRphysBase_MSR(5), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6:
> +		rdmsrl(MTRRphysBase_MSR(6), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7:
> +		rdmsrl(MTRRphysBase_MSR(7), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8:
> +		rdmsrl(MTRRphysBase_MSR(8), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9:
> +		rdmsrl(MTRRphysBase_MSR(9), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA:
> +		rdmsrl(MTRRphysBase_MSR(0xa), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB:
> +		rdmsrl(MTRRphysBase_MSR(0xb), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC:
> +		rdmsrl(MTRRphysBase_MSR(0xc), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASED:
> +		rdmsrl(MTRRphysBase_MSR(0xd), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE:
> +		rdmsrl(MTRRphysBase_MSR(0xe), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF:
> +		rdmsrl(MTRRphysBase_MSR(0xf), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0:
> +		rdmsrl(MTRRphysMask_MSR(0), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1:
> +		rdmsrl(MTRRphysMask_MSR(1), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2:
> +		rdmsrl(MTRRphysMask_MSR(2), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3:
> +		rdmsrl(MTRRphysMask_MSR(3), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4:
> +		rdmsrl(MTRRphysMask_MSR(4), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5:
> +		rdmsrl(MTRRphysMask_MSR(5), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6:
> +		rdmsrl(MTRRphysMask_MSR(6), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7:
> +		rdmsrl(MTRRphysMask_MSR(7), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8:
> +		rdmsrl(MTRRphysMask_MSR(8), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9:
> +		rdmsrl(MTRRphysMask_MSR(9), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA:
> +		rdmsrl(MTRRphysMask_MSR(0xa), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB:
> +		rdmsrl(MTRRphysMask_MSR(0xb), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC:
> +		rdmsrl(MTRRphysMask_MSR(0xc), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD:
> +		rdmsrl(MTRRphysMask_MSR(0xd), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE:
> +		rdmsrl(MTRRphysMask_MSR(0xe), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF:
> +		rdmsrl(MTRRphysMask_MSR(0xf), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX64K00000:
> +		rdmsrl(MSR_MTRRfix64K_00000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX16K80000:
> +		rdmsrl(MSR_MTRRfix16K_80000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX16KA0000:
> +		rdmsrl(MSR_MTRRfix16K_A0000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KC0000:
> +		rdmsrl(MSR_MTRRfix4K_C0000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KC8000:
> +		rdmsrl(MSR_MTRRfix4K_C8000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KD0000:
> +		rdmsrl(MSR_MTRRfix4K_D0000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KD8000:
> +		rdmsrl(MSR_MTRRfix4K_D8000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KE0000:
> +		rdmsrl(MSR_MTRRfix4K_E0000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KE8000:
> +		rdmsrl(MSR_MTRRfix4K_E8000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KF0000:
> +		rdmsrl(MSR_MTRRfix4K_F0000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KF8000:
> +		rdmsrl(MSR_MTRRfix4K_F8000, *reg64);
> +		break;
> +
> +	default:
> +		goto hypercall;
> +	}
> +
> +	return 0;
> +
> +hypercall:
> +	return 1;
> +}
> +
> +static void mshv_vtl_return(struct mshv_vtl_cpu_context *vtl0)
> +{
> +	struct hv_vp_assist_page *hvp;
> +	u64 hypercall_addr;
> +
> +	register u64 r8 asm("r8");
> +	register u64 r9 asm("r9");
> +	register u64 r10 asm("r10");
> +	register u64 r11 asm("r11");
> +	register u64 r12 asm("r12");
> +	register u64 r13 asm("r13");
> +	register u64 r14 asm("r14");
> +	register u64 r15 asm("r15");
> +
> +	hvp =3D hv_vp_assist_page[smp_processor_id()];
> +
> +	/*
> +	 * Process signal event direct set in the run page, if any.
> +	 */
> +	if (mshv_vsm_capabilities.return_action_available) {
> +		u32 offset =3D READ_ONCE(mshv_vtl_this_run()->vtl_ret_action_size);
> +
> +		WRITE_ONCE(mshv_vtl_this_run()->vtl_ret_action_size, 0);
> +
> +		/*
> +		 * Hypervisor will take care of clearing out the actions
> +		 * set in the assist page.
> +		 */
> +		memcpy(hvp->vtl_ret_actions,
> +		       mshv_vtl_this_run()->vtl_ret_actions,
> +		       min_t(u32, offset, sizeof(hvp->vtl_ret_actions)));
> +	}
> +
> +	hvp->vtl_ret_x64rax =3D vtl0->rax;
> +	hvp->vtl_ret_x64rcx =3D vtl0->rcx;
> +
> +	hypercall_addr =3D (u64)((u8 *)hv_hypercall_pg + mshv_vsm_page_offsets.=
vtl_return_offset);
> +
> +	kernel_fpu_begin_mask(0);
> +	fxrstor(&vtl0->fx_state);
> +	native_write_cr2(vtl0->cr2);
> +	r8 =3D vtl0->r8;
> +	r9 =3D vtl0->r9;
> +	r10 =3D vtl0->r10;
> +	r11 =3D vtl0->r11;
> +	r12 =3D vtl0->r12;
> +	r13 =3D vtl0->r13;
> +	r14 =3D vtl0->r14;
> +	r15 =3D vtl0->r15;
> +
> +	asm __volatile__ (	\
> +	/* Save rbp pointer to the lower VTL, keep the stack 16-byte aligned */
> +		"pushq	%%rbp\n"
> +		"pushq	%%rcx\n"
> +	/* Restore the lower VTL's rbp */
> +		"movq	(%%rcx), %%rbp\n"
> +	/* Load return kind into rcx (HV_VTL_RETURN_INPUT_NORMAL_RETURN =3D=3D =
0)
> */
> +		"xorl	%%ecx, %%ecx\n"
> +	/* Transition to the lower VTL */
> +		CALL_NOSPEC
> +	/* Save VTL0's rax and rcx temporarily on 16-byte aligned stack */
> +		"pushq	%%rax\n"
> +		"pushq	%%rcx\n"
> +	/* Restore pointer to lower VTL rbp */
> +		"movq	16(%%rsp), %%rax\n"
> +	/* Save the lower VTL's rbp */
> +		"movq	%%rbp, (%%rax)\n"
> +	/* Restore saved registers */
> +		"movq	8(%%rsp), %%rax\n"
> +		"movq	24(%%rsp), %%rbp\n"
> +		"addq	$32, %%rsp\n"
> +
> +		: "=3Da"(vtl0->rax), "=3Dc"(vtl0->rcx),
> +		  "+d"(vtl0->rdx), "+b"(vtl0->rbx), "+S"(vtl0->rsi), "+D"(vtl0->rdi),
> +		  "+r"(r8), "+r"(r9), "+r"(r10), "+r"(r11),
> +		  "+r"(r12), "+r"(r13), "+r"(r14), "+r"(r15)
> +		: THUNK_TARGET(hypercall_addr), "c"(&vtl0->rbp)
> +		: "cc", "memory");
> +
> +	vtl0->r8 =3D r8;
> +	vtl0->r9 =3D r9;
> +	vtl0->r10 =3D r10;
> +	vtl0->r11 =3D r11;
> +	vtl0->r12 =3D r12;
> +	vtl0->r13 =3D r13;
> +	vtl0->r14 =3D r14;
> +	vtl0->r15 =3D r15;
> +	vtl0->cr2 =3D native_read_cr2();
> +
> +	fxsave(&vtl0->fx_state);
> +	kernel_fpu_end();
> +}
> +
> +/*
> + * Returning to a lower VTL treats the base pointer register
> + * as a general purpose one. Without adding this, objtool produces
> + * a warning.
> + */
> +STACK_FRAME_NON_STANDARD(mshv_vtl_return);
> +
> +static bool mshv_vtl_process_intercept(void)
> +{
> +	struct hv_per_cpu_context *mshv_cpu;
> +	void *synic_message_page;
> +	struct hv_message *msg;
> +	u32 message_type;
> +
> +	mshv_cpu =3D this_cpu_ptr(hv_context.cpu_context);
> +	synic_message_page =3D mshv_cpu->synic_message_page;
> +	if (unlikely(!synic_message_page))
> +		return true;
> +
> +	msg =3D (struct hv_message *)synic_message_page + HV_SYNIC_INTERCEPTION=
_SINT_INDEX;
> +	message_type =3D READ_ONCE(msg->header.message_type);
> +	if (message_type =3D=3D HVMSG_NONE)
> +		return true;
> +
> +	memcpy(mshv_vtl_this_run()->exit_message, msg, sizeof(*msg));
> +	vmbus_signal_eom(msg, message_type);
> +
> +	return false;
> +}
> +
> +static int mshv_vtl_ioctl_return_to_lower_vtl(void)
> +{
> +	preempt_disable();
> +	for (;;) {
> +		const unsigned long VTL0_WORK =3D _TIF_SIGPENDING | _TIF_NEED_RESCHED =
|
> +						_TIF_NOTIFY_RESUME | _TIF_NOTIFY_SIGNAL;
> +		unsigned long ti_work;
> +		u32 cancel;
> +		unsigned long irq_flags;
> +		struct hv_vp_assist_page *hvp;
> +		int ret;
> +
> +		local_irq_save(irq_flags);
> +		ti_work =3D READ_ONCE(current_thread_info()->flags);
> +		cancel =3D READ_ONCE(mshv_vtl_this_run()->cancel);
> +		if (unlikely((ti_work & VTL0_WORK) || cancel)) {
> +			local_irq_restore(irq_flags);
> +			preempt_enable();
> +			if (cancel)
> +				ti_work |=3D _TIF_SIGPENDING;
> +			ret =3D mshv_do_pre_guest_mode_work(ti_work);
> +			if (ret)
> +				return ret;
> +			preempt_disable();
> +			continue;
> +		}
> +
> +		mshv_vtl_return(&mshv_vtl_this_run()->cpu_context);
> +		local_irq_restore(irq_flags);
> +
> +		hvp =3D hv_vp_assist_page[smp_processor_id()];
> +		this_cpu_inc(num_vtl0_transitions);
> +		switch (hvp->vtl_entry_reason) {
> +		case MSHV_ENTRY_REASON_INTERRUPT:
> +			if (!mshv_vsm_capabilities.intercept_page_available &&
> +			    likely(!mshv_vtl_process_intercept()))
> +				goto done;
> +			break;
> +
> +		case MSHV_ENTRY_REASON_INTERCEPT:
> +			WARN_ON(!mshv_vsm_capabilities.intercept_page_available);
> +			memcpy(mshv_vtl_this_run()->exit_message, hvp->intercept_message,
> +			       sizeof(hvp->intercept_message));
> +			goto done;
> +
> +		default:
> +			panic("unknown entry reason: %d", hvp->vtl_entry_reason);
> +		}
> +	}
> +
> +done:
> +	preempt_enable();
> +
> +	return 0;
> +}
> +
> +static long
> +mshv_vtl_ioctl_get_regs(void __user *user_args)
> +{
> +	struct mshv_vp_registers args;
> +	struct hv_register_assoc *registers;
> +	long ret;
> +
> +	if (copy_from_user(&args, user_args, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.count =3D=3D 0 || args.count > MSHV_VP_MAX_REGISTERS)
> +		return -EINVAL;
> +
> +	registers =3D kmalloc_array(args.count,
> +				  sizeof(*registers),
> +				  GFP_KERNEL);
> +	if (!registers)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(registers, (void __user *)args.regs_ptr,
> +			   sizeof(*registers) * args.count)) {
> +		ret =3D -EFAULT;
> +		goto free_return;
> +	}
> +
> +	ret =3D mshv_vtl_get_reg(registers);
> +	if (!ret)
> +		goto copy_args; /* No need of hypercall */

I'm puzzled by the functionality here. The input to this function may
specify up to MSHV_VP_MAX_REGISTERS, which is 128. But if the
first register in the input is handled by mshv_vtl_get_reg(), then
no additional register values are retrieved. But the full set of
register values are copied back to user space, all of which
except the first are just whatever register values were originally
copied in from user space.

> +	ret =3D vtl_get_vp_registers(args.count, registers);
> +	if (ret)
> +		goto free_return;
> +
> +copy_args:
> +	if (copy_to_user((void __user *)args.regs_ptr, registers,
> +			 sizeof(*registers) * args.count))
> +		ret =3D -EFAULT;
> +free_return:
> +	kfree(registers);
> +
> +	return ret;
> +}
> +
> +static long
> +mshv_vtl_ioctl_set_regs(void __user *user_args)
> +{
> +	struct mshv_vp_registers args;
> +	struct hv_register_assoc *registers;
> +	long ret;
> +
> +	if (copy_from_user(&args, user_args, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.count =3D=3D 0 || args.count > MSHV_VP_MAX_REGISTERS)
> +		return -EINVAL;
> +
> +	registers =3D kmalloc_array(args.count,
> +				  sizeof(*registers),
> +				  GFP_KERNEL);
> +	if (!registers)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(registers, (void __user *)args.regs_ptr,
> +			   sizeof(*registers) * args.count)) {
> +		ret =3D -EFAULT;
> +		goto free_return;
> +	}
> +
> +	ret =3D mshv_vtl_set_reg(registers);
> +	if (!ret)
> +		goto free_return; /* No need of hypercall */

Again, I'm puzzled by the functionality because only the first
register value is set if mshv_vtl_set_reg() handles that register.
The other specified register values are ignored.

> +	ret =3D vtl_set_vp_registers(args.count, registers);
> +
> +free_return:
> +	kfree(registers);
> +
> +	return ret;
> +}
> +
> +static long
> +mshv_vtl_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> +{
> +	long ret;
> +	struct mshv_vtl *vtl =3D filp->private_data;
> +
> +	switch (ioctl) {
> +	case MSHV_SET_POLL_FILE:
> +		ret =3D mshv_vtl_ioctl_set_poll_file((struct mshv_vtl_set_poll_file *)=
arg);
> +		break;
> +	case MSHV_GET_VP_REGISTERS:
> +		ret =3D mshv_vtl_ioctl_get_regs((void __user *)arg);
> +		break;
> +	case MSHV_SET_VP_REGISTERS:
> +		ret =3D mshv_vtl_ioctl_set_regs((void __user *)arg);
> +		break;
> +	case MSHV_RETURN_TO_LOWER_VTL:
> +		ret =3D mshv_vtl_ioctl_return_to_lower_vtl();
> +		break;
> +	case MSHV_ADD_VTL0_MEMORY:
> +		ret =3D mshv_vtl_ioctl_add_vtl0_mem(vtl, (void __user *)arg);
> +		break;
> +	default:
> +		dev_err(vtl->module_dev, "invalid vtl ioctl: %#x\n", ioctl);
> +		ret =3D -ENOTTY;
> +	}
> +
> +	return ret;
> +}
> +
> +static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf)
> +{
> +	struct page *page;
> +	int cpu =3D vmf->pgoff & MSHV_PG_OFF_CPU_MASK;
> +	int real_off =3D vmf->pgoff >> MSHV_REAL_OFF_SHIFT;
> +
> +	if (!cpu_online(cpu))
> +		return VM_FAULT_SIGBUS;

Same question as earlier -- what ensures the CPU stays online
after the above test?

> +
> +	if (real_off =3D=3D MSHV_RUN_PAGE_OFFSET) {
> +		page =3D virt_to_page(mshv_vtl_cpu_run(cpu));
> +	} else if (real_off =3D=3D MSHV_REG_PAGE_OFFSET) {
> +		if (!mshv_has_reg_page)
> +			return VM_FAULT_SIGBUS;
> +		page =3D mshv_vtl_cpu_reg_page(cpu);
> +	} else {
> +		return VM_FAULT_NOPAGE;
> +	}
> +
> +	get_page(page);
> +	vmf->page =3D page;
> +
> +	return 0;
> +}
> +
> +static const struct vm_operations_struct mshv_vtl_vm_ops =3D {
> +	.fault =3D mshv_vtl_fault,
> +};
> +
> +static int mshv_vtl_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	vma->vm_ops =3D &mshv_vtl_vm_ops;
> +
> +	return 0;
> +}
> +
> +static int mshv_vtl_release(struct inode *inode, struct file *filp)
> +{
> +	struct mshv_vtl *vtl =3D filp->private_data;
> +
> +	kfree(vtl);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations mshv_vtl_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.unlocked_ioctl =3D mshv_vtl_ioctl,
> +	.release =3D mshv_vtl_release,
> +	.mmap =3D mshv_vtl_mmap,
> +};
> +
> +static void mshv_vtl_synic_mask_vmbus_sint(const u8 *mask)
> +{
> +	union hv_synic_sint sint;
> +
> +	sint.as_uint64 =3D 0;
> +	sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	sint.masked =3D (*mask !=3D 0);
> +	sint.auto_eoi =3D hv_recommend_using_aeoi();
> +
> +	hv_set_msr(HV_MSR_SINT0 + VTL2_VMBUS_SINT_INDEX,
> +		   sint.as_uint64);
> +
> +	if (!sint.masked)
> +		pr_debug("%s: Unmasking VTL2 VMBUS SINT on VP %d\n", __func__, smp_pro=
cessor_id());
> +	else
> +		pr_debug("%s: Masking VTL2 VMBUS SINT on VP %d\n", __func__, smp_proce=
ssor_id());
> +}
> +
> +static void mshv_vtl_read_remote(void *buffer)
> +{
> +	struct hv_per_cpu_context *mshv_cpu =3D this_cpu_ptr(hv_context.cpu_con=
text);
> +	struct hv_message *msg =3D (struct hv_message *)mshv_cpu->synic_message=
_page +
> +					VTL2_VMBUS_SINT_INDEX;
> +	u32 message_type =3D READ_ONCE(msg->header.message_type);
> +
> +	WRITE_ONCE(has_message, false);
> +	if (message_type =3D=3D HVMSG_NONE)
> +		return;
> +
> +	memcpy(buffer, msg, sizeof(*msg));
> +	vmbus_signal_eom(msg, message_type);
> +}
> +
> +static bool vtl_synic_mask_vmbus_sint_masked =3D true;
> +
> +static ssize_t mshv_vtl_sint_read(struct file *filp, char __user *arg, s=
ize_t size, loff_t
> *offset)
> +{
> +	struct hv_message msg =3D {};
> +	int ret;
> +
> +	if (size < sizeof(msg))
> +		return -EINVAL;
> +
> +	for (;;) {
> +		smp_call_function_single(VMBUS_CONNECT_CPU, mshv_vtl_read_remote, &msg=
, true);
> +		if (msg.header.message_type !=3D HVMSG_NONE)
> +			break;
> +
> +		if (READ_ONCE(vtl_synic_mask_vmbus_sint_masked))
> +			return 0; /* EOF */
> +
> +		if (filp->f_flags & O_NONBLOCK)
> +			return -EAGAIN;
> +
> +		ret =3D wait_event_interruptible(fd_wait_queue,
> +					       READ_ONCE(has_message) ||
> +						READ_ONCE(vtl_synic_mask_vmbus_sint_masked));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (copy_to_user(arg, &msg, sizeof(msg)))
> +		return -EFAULT;
> +
> +	return sizeof(msg);
> +}
> +
> +static __poll_t mshv_vtl_sint_poll(struct file *filp, poll_table *wait)
> +{
> +	__poll_t mask =3D 0;
> +
> +	poll_wait(filp, &fd_wait_queue, wait);
> +	if (READ_ONCE(has_message) || READ_ONCE(vtl_synic_mask_vmbus_sint_maske=
d))
> +		mask |=3D EPOLLIN | EPOLLRDNORM;
> +
> +	return mask;
> +}
> +
> +static void mshv_vtl_sint_on_msg_dpc(unsigned long data)
> +{
> +	WRITE_ONCE(has_message, true);
> +	wake_up_interruptible_poll(&fd_wait_queue, EPOLLIN);
> +}
> +
> +static int mshv_vtl_sint_ioctl_post_message(struct mshv_vtl_sint_post_ms=
g __user *arg)
> +{
> +	struct mshv_vtl_sint_post_msg message;
> +	u8 payload[HV_MESSAGE_PAYLOAD_BYTE_COUNT];
> +
> +	if (copy_from_user(&message, arg, sizeof(message)))
> +		return -EFAULT;
> +	if (message.payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT)
> +		return -EINVAL;
> +	if (copy_from_user(payload, (void __user *)message.payload_ptr,
> +			   message.payload_size))
> +		return -EFAULT;
> +
> +	return hv_post_message((union hv_connection_id)message.connection_id,
> +			       message.message_type, (void *)payload,
> +			       message.payload_size);
> +}
> +
> +static int mshv_vtl_sint_ioctl_signal_event(struct mshv_vtl_signal_event=
 __user *arg)
> +{
> +	u64 input;
> +	struct mshv_vtl_signal_event signal_event;
> +
> +	if (copy_from_user(&signal_event, arg, sizeof(signal_event)))
> +		return -EFAULT;
> +
> +	input =3D signal_event.connection_id | ((u64)signal_event.flag << 32);
> +
> +	return hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, input) & HV_HYPERCALL=
_RESULT_MASK;

The return value is inconsistent here. It might be a negative errno if
copy_from_user() fails, or it might be a Hyper-V hypercall result code. The
caller is mshv_vtl_sint_ioctl(), which is called from vfs_ioctl(), which
expects a return value of 0 on success, and a negative errno on error.

You can use hv_result_to_errno() here to translate the hypercall result
code to a negative errno.

> +}
> +
> +static int mshv_vtl_sint_ioctl_set_eventfd(struct mshv_vtl_set_eventfd _=
_user *arg)
> +{
> +	struct mshv_vtl_set_eventfd set_eventfd;
> +	struct eventfd_ctx *eventfd, *old_eventfd;
> +
> +	if (copy_from_user(&set_eventfd, arg, sizeof(set_eventfd)))
> +		return -EFAULT;
> +	if (set_eventfd.flag >=3D HV_EVENT_FLAGS_COUNT)
> +		return -EINVAL;
> +
> +	eventfd =3D NULL;
> +	if (set_eventfd.fd >=3D 0) {
> +		eventfd =3D eventfd_ctx_fdget(set_eventfd.fd);
> +		if (IS_ERR(eventfd))
> +			return PTR_ERR(eventfd);
> +	}
> +
> +	mutex_lock(&flag_lock);
> +	old_eventfd =3D flag_eventfds[set_eventfd.flag];
> +	WRITE_ONCE(flag_eventfds[set_eventfd.flag], eventfd);
> +	mutex_unlock(&flag_lock);

The above looks a little weird. Generally, if you are using READ_ONCE()
or WRITE_ONCE() for a field, you should use them everywhere the field
is referenced. I see that there is a READ_ONCE() in mshv_vtl_vmbus_isr().
For robustness, I'd suggest using READ_ONCE() above to read the old value.

> +
> +	if (old_eventfd) {
> +		synchronize_rcu();
> +		eventfd_ctx_put(old_eventfd);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mshv_vtl_sint_ioctl_pause_message_stream(struct mshv_sint_mas=
k __user *arg)
> +{
> +	static DEFINE_MUTEX(vtl2_vmbus_sint_mask_mutex);
> +	struct mshv_sint_mask mask;
> +
> +	if (copy_from_user(&mask, arg, sizeof(mask)))
> +		return -EFAULT;
> +	mutex_lock(&vtl2_vmbus_sint_mask_mutex);
> +	on_each_cpu((smp_call_func_t)mshv_vtl_synic_mask_vmbus_sint, &mask.mask=
, 1);
> +	WRITE_ONCE(vtl_synic_mask_vmbus_sint_masked, mask.mask !=3D 0);
> +	mutex_unlock(&vtl2_vmbus_sint_mask_mutex);
> +	if (mask.mask)
> +		wake_up_interruptible_poll(&fd_wait_queue, EPOLLIN);
> +
> +	return 0;
> +}
> +
> +static long mshv_vtl_sint_ioctl(struct file *f, unsigned int cmd, unsign=
ed long arg)
> +{
> +	switch (cmd) {
> +	case MSHV_SINT_POST_MESSAGE:
> +		return mshv_vtl_sint_ioctl_post_message((struct mshv_vtl_sint_post_msg=
 *)arg);
> +	case MSHV_SINT_SIGNAL_EVENT:
> +		return mshv_vtl_sint_ioctl_signal_event((struct mshv_vtl_signal_event =
*)arg);
> +	case MSHV_SINT_SET_EVENTFD:
> +		return mshv_vtl_sint_ioctl_set_eventfd((struct mshv_vtl_set_eventfd *)=
arg);
> +	case MSHV_SINT_PAUSE_MESSAGE_STREAM:
> +		return mshv_vtl_sint_ioctl_pause_message_stream((struct mshv_sint_mask=
 *)arg);
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +}
> +
> +static const struct file_operations mshv_vtl_sint_ops =3D {
> +	.owner =3D THIS_MODULE,
> +	.read =3D mshv_vtl_sint_read,
> +	.poll =3D mshv_vtl_sint_poll,
> +	.unlocked_ioctl =3D mshv_vtl_sint_ioctl,
> +};
> +
> +static struct miscdevice mshv_vtl_sint_dev =3D {
> +	.name =3D "mshv_sint",
> +	.fops =3D &mshv_vtl_sint_ops,
> +	.mode =3D 0600,
> +	.minor =3D MISC_DYNAMIC_MINOR,
> +};
> +
> +static int mshv_vtl_hvcall_open(struct inode *node, struct file *f)
> +{
> +	struct miscdevice *dev =3D f->private_data;
> +	struct mshv_vtl_hvcall_fd *fd;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	fd =3D vzalloc(sizeof(*fd));
> +	if (!fd)
> +		return -ENOMEM;
> +	fd->dev =3D dev;
> +	f->private_data =3D fd;
> +	mutex_init(&fd->init_mutex);
> +
> +	return 0;
> +}
> +
> +static int mshv_vtl_hvcall_release(struct inode *node, struct file *f)
> +{
> +	struct mshv_vtl_hvcall_fd *fd;
> +
> +	fd =3D f->private_data;
> +	if (fd) {
> +		vfree(fd);
> +		f->private_data =3D NULL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mshv_vtl_hvcall_setup(struct mshv_vtl_hvcall_fd *fd,
> +				 struct mshv_vtl_hvcall_setup __user *hvcall_setup_user)
> +{
> +	int ret =3D 0;
> +	struct mshv_vtl_hvcall_setup hvcall_setup;
> +
> +	mutex_lock(&fd->init_mutex);
> +
> +	if (fd->allow_map_initialized) {
> +		dev_err(fd->dev->this_device,
> +			"Hypercall allow map has already been set, pid %d\n",
> +			current->pid);
> +		ret =3D -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (copy_from_user(&hvcall_setup, hvcall_setup_user,
> +			   sizeof(struct mshv_vtl_hvcall_setup))) {
> +		ret =3D -EFAULT;
> +		goto exit;
> +	}
> +	if (hvcall_setup.bitmap_size > ARRAY_SIZE(fd->allow_bitmap)) {

This implies that "bitmap_size" is in units of u64.

> +		ret =3D -EINVAL;
> +		goto exit;
> +	}
> +	if (copy_from_user(&fd->allow_bitmap,
> +			   (void __user *)hvcall_setup.allow_bitmap_ptr,
> +			   hvcall_setup.bitmap_size)) {

But this implies that "bitmap_size" is in units of bytes. So something is w=
rong.

> +		ret =3D -EFAULT;
> +		goto exit;
> +	}
> +
> +	dev_info(fd->dev->this_device, "Hypercall allow map has been set, pid %=
d\n",
> +		 current->pid);
> +	fd->allow_map_initialized =3D true;
> +exit:
> +	mutex_unlock(&fd->init_mutex);
> +
> +	return ret;
> +}
> +
> +static bool mshv_vtl_hvcall_is_allowed(struct mshv_vtl_hvcall_fd *fd, u1=
6 call_code)
> +{
> +	u8 bits_per_item =3D 8 * sizeof(fd->allow_bitmap[0]);
> +	u16 item_index =3D call_code / bits_per_item;
> +	u64 mask =3D 1ULL << (call_code % bits_per_item);
> +
> +	return fd->allow_bitmap[item_index] & mask;

See earlier comment on the size of "allow_bitmap".  This code implies the
size should be 64K bits, but the size is actually 512K bits.

> +}
> +
> +static int mshv_vtl_hvcall_call(struct mshv_vtl_hvcall_fd *fd,
> +				struct mshv_vtl_hvcall __user *hvcall_user)
> +{
> +	struct mshv_vtl_hvcall hvcall;
> +	void *in, *out;
> +	int ret;
> +
> +	if (copy_from_user(&hvcall, hvcall_user, sizeof(struct mshv_vtl_hvcall)=
))
> +		return -EFAULT;
> +	if (hvcall.input_size > HV_HYP_PAGE_SIZE)
> +		return -EINVAL;
> +	if (hvcall.output_size > HV_HYP_PAGE_SIZE)
> +		return -EINVAL;
> +
> +	/*
> +	 * By default, all hypercalls are not allowed.
> +	 * The user mode code has to set up the allow bitmap once.
> +	 */
> +
> +	if (!mshv_vtl_hvcall_is_allowed(fd, hvcall.control & 0xFFFF)) {
> +		dev_err(fd->dev->this_device,
> +			"Hypercall with control data %#llx isn't allowed\n",
> +			hvcall.control);
> +		return -EPERM;
> +	}
> +
> +	/*
> +	 * This may create a problem for Confidential VM (CVM) usecase where we=
 need to use
> +	 * Hyper-V driver allocated per-cpu input and output pages (hyperv_pcpu=
_input_arg and
> +	 * hyperv_pcpu_output_arg) for making a hypervisor call.
> +	 *
> +	 * TODO: Take care of this when CVM support is added.
> +	 */
> +	in =3D (void *)__get_free_page(GFP_KERNEL);
> +	out =3D (void *)__get_free_page(GFP_KERNEL);
> +
> +	if (copy_from_user(in, (void __user *)hvcall.input_ptr, hvcall.input_si=
ze)) {
> +		ret =3D -EFAULT;
> +		goto free_pages;
> +	}
> +
> +	hvcall.status =3D hv_do_hypercall(hvcall.control, in, out);
> +
> +	if (copy_to_user((void __user *)hvcall.output_ptr, out, hvcall.output_s=
ize)) {
> +		ret =3D -EFAULT;
> +		goto free_pages;
> +	}
> +	ret =3D put_user(hvcall.status, &hvcall_user->status);
> +free_pages:
> +	free_page((unsigned long)in);
> +	free_page((unsigned long)out);
> +
> +	return ret;
> +}
> +
> +static long mshv_vtl_hvcall_ioctl(struct file *f, unsigned int cmd, unsi=
gned long arg)
> +{
> +	struct mshv_vtl_hvcall_fd *fd =3D f->private_data;
> +
> +	switch (cmd) {
> +	case MSHV_HVCALL_SETUP:
> +		return mshv_vtl_hvcall_setup(fd, (struct mshv_vtl_hvcall_setup __user =
*)arg);
> +	case MSHV_HVCALL:
> +		return mshv_vtl_hvcall_call(fd, (struct mshv_vtl_hvcall __user *)arg);
> +	default:
> +		break;
> +	}
> +
> +	return -ENOIOCTLCMD;
> +}
> +
> +static const struct file_operations mshv_vtl_hvcall_file_ops =3D {
> +	.owner =3D THIS_MODULE,
> +	.open =3D mshv_vtl_hvcall_open,
> +	.release =3D mshv_vtl_hvcall_release,
> +	.unlocked_ioctl =3D mshv_vtl_hvcall_ioctl,
> +};
> +
> +static struct miscdevice mshv_vtl_hvcall =3D {

Unfortunately, this global variable name ("mshv_vtl_hvcall") is the
same as the name of struct mshv_vtl_hvcall in include/uapi/linux/mshv.h.
Even though it works, could some other name be used here to avoid
any ambiguity?

> +	.name =3D "mshv_hvcall",
> +	.nodename =3D "mshv_hvcall",
> +	.fops =3D &mshv_vtl_hvcall_file_ops,
> +	.mode =3D 0600,
> +	.minor =3D MISC_DYNAMIC_MINOR,
> +};
> +
> +static int mshv_vtl_low_open(struct inode *inodep, struct file *filp)
> +{
> +	pid_t pid =3D task_pid_vnr(current);
> +	uid_t uid =3D current_uid().val;
> +	int ret =3D 0;
> +
> +	pr_debug("%s: Opening VTL low, task group %d, uid %d\n", __func__, pid,=
 uid);
> +
> +	if (capable(CAP_SYS_ADMIN)) {
> +		filp->private_data =3D inodep;
> +	} else {
> +		pr_err("%s: VTL low open failed: CAP_SYS_ADMIN required. task group %d=
, uid %d",
> +		       __func__, pid, uid);
> +		ret =3D -EPERM;
> +	}
> +
> +	return ret;
> +}
> +
> +static bool can_fault(struct vm_fault *vmf, unsigned long size, pfn_t *p=
fn)
> +{
> +	unsigned long mask =3D size - 1;
> +	unsigned long start =3D vmf->address & ~mask;
> +	unsigned long end =3D start + size;
> +	bool is_valid;
> +
> +	is_valid =3D (vmf->address & mask) =3D=3D ((vmf->pgoff << PAGE_SHIFT) &=
 mask) &&
> +		start >=3D vmf->vma->vm_start &&
> +		end <=3D vmf->vma->vm_end;
> +
> +	if (is_valid)
> +		*pfn =3D __pfn_to_pfn_t(vmf->pgoff & ~(mask >> PAGE_SHIFT), PFN_DEV | =
PFN_MAP);
> +
> +	return is_valid;
> +}
> +
> +static vm_fault_t mshv_vtl_low_huge_fault(struct vm_fault *vmf, unsigned=
 int order)
> +{
> +	pfn_t pfn;
> +	int ret =3D VM_FAULT_FALLBACK;
> +
> +	switch (order) {
> +	case 0:
> +		pfn =3D __pfn_to_pfn_t(vmf->pgoff, PFN_DEV | PFN_MAP);
> +		return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
> +
> +	case PMD_ORDER:
> +		if (can_fault(vmf, PMD_SIZE, &pfn))
> +			ret =3D vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
> +		return ret;
> +
> +	case PUD_ORDER:
> +		if (can_fault(vmf, PUD_SIZE, &pfn))
> +			ret =3D vmf_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
> +		return ret;
> +
> +	default:
> +		return VM_FAULT_SIGBUS;
> +	}
> +}

There's an 'mm' patch set currently in linux-next that eliminates pfn_t, PF=
N_DEV, and
PFN_MAP. Assuming the patch set goes into 6.17, the fault handling code her=
e will need
some rework. See
https://lore.kernel.org/lkml/cover.176965585864cb8d2cf41464b44dcc0471e643a0=
.1750323463.git-series.apopple@nvidia.com/

> +
> +static vm_fault_t mshv_vtl_low_fault(struct vm_fault *vmf)
> +{
> +	return mshv_vtl_low_huge_fault(vmf, 0);
> +}
> +
> +static const struct vm_operations_struct mshv_vtl_low_vm_ops =3D {
> +	.fault =3D mshv_vtl_low_fault,
> +	.huge_fault =3D mshv_vtl_low_huge_fault,
> +};
> +
> +static int mshv_vtl_low_mmap(struct file *filp, struct vm_area_struct *v=
ma)
> +{
> +	vma->vm_ops =3D &mshv_vtl_low_vm_ops;
> +	vm_flags_set(vma, VM_HUGEPAGE | VM_MIXEDMAP);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations mshv_vtl_low_file_ops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.open		=3D mshv_vtl_low_open,
> +	.mmap		=3D mshv_vtl_low_mmap,
> +};
> +
> +static struct miscdevice mshv_vtl_low =3D {
> +	.name =3D "mshv_vtl_low",
> +	.nodename =3D "mshv_vtl_low",
> +	.fops =3D &mshv_vtl_low_file_ops,
> +	.mode =3D 0600,
> +	.minor =3D MISC_DYNAMIC_MINOR,
> +};
> +
> +static int __init mshv_vtl_init(void)
> +{
> +	int ret;
> +	struct device *dev =3D mshv_dev.this_device;
> +
> +	/*
> +	 * This creates /dev/mshv which provides functionality to create VTLs a=
nd partitions.
> +	 */
> +	ret =3D misc_register(&mshv_dev);
> +	if (ret) {
> +		dev_err(dev, "mshv device register failed: %d\n", ret);
> +		goto free_dev;
> +	}
> +
> +	tasklet_init(&msg_dpc, mshv_vtl_sint_on_msg_dpc, 0);
> +	init_waitqueue_head(&fd_wait_queue);
> +
> +	if (mshv_vtl_get_vsm_regs()) {
> +		dev_emerg(dev, "Unable to get VSM capabilities !!\n");
> +		ret =3D -ENODEV;
> +		goto free_dev;
> +	}
> +	if (mshv_vtl_configure_vsm_partition(dev)) {
> +		dev_emerg(dev, "VSM configuration failed !!\n");
> +		ret =3D -ENODEV;
> +		goto free_dev;
> +	}
> +
> +	ret =3D hv_vtl_setup_synic();
> +	if (ret)
> +		goto free_dev;
> +
> +	/*
> +	 * mshv_sint device adds VMBus relay ioctl support.
> +	 * This provides a channel for VTL0 to communicate with VTL2.
> +	 */
> +	ret =3D misc_register(&mshv_vtl_sint_dev);
> +	if (ret)
> +		goto free_synic;
> +
> +	/*
> +	 * mshv_hvcall device adds interface to enable userspace for direct hyp=
ercalls support.
> +	 */
> +	ret =3D misc_register(&mshv_vtl_hvcall);
> +	if (ret)
> +		goto free_sint;
> +
> +	/*
> +	 * mshv_vtl_low device is used to map VTL0 address space to a user-mode=
 process in VTL2.
> +	 * It implements mmap() to allow a user-mode process in VTL2 to map to =
the address of VTL0.
> +	 */
> +	ret =3D misc_register(&mshv_vtl_low);
> +	if (ret)
> +		goto free_hvcall;
> +
> +	/*
> +	 * "mshv vtl mem dev" device is later used to setup VTL0 memory.
> +	 */
> +	mem_dev =3D kzalloc(sizeof(*mem_dev), GFP_KERNEL);
> +	if (!mem_dev) {
> +		ret =3D -ENOMEM;
> +		goto free_low;
> +	}
> +
> +	mutex_init(&mshv_vtl_poll_file_lock);
> +
> +	device_initialize(mem_dev);
> +	dev_set_name(mem_dev, "mshv vtl mem dev");
> +	ret =3D device_add(mem_dev);
> +	if (ret) {
> +		dev_err(dev, "mshv vtl mem dev add: %d\n", ret);
> +		goto free_mem;
> +	}
> +
> +	return 0;
> +
> +free_mem:
> +	kfree(mem_dev);
> +free_low:
> +	misc_deregister(&mshv_vtl_low);
> +free_hvcall:
> +	misc_deregister(&mshv_vtl_hvcall);
> +free_sint:
> +	misc_deregister(&mshv_vtl_sint_dev);
> +free_synic:
> +	hv_vtl_remove_synic();
> +free_dev:
> +	misc_deregister(&mshv_dev);
> +
> +	return ret;
> +}
> +
> +static void __exit mshv_vtl_exit(void)
> +{
> +	device_del(mem_dev);
> +	kfree(mem_dev);
> +	misc_deregister(&mshv_vtl_low);
> +	misc_deregister(&mshv_vtl_hvcall);
> +	misc_deregister(&mshv_vtl_sint_dev);
> +	hv_vtl_remove_synic();
> +	misc_deregister(&mshv_dev);
> +}
> +
> +module_init(mshv_vtl_init);
> +module_exit(mshv_vtl_exit);
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 1be7f6a02304..cc9260c37c49 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -882,6 +882,23 @@ struct hv_get_vp_from_apic_id_in {
>  	u32 apic_ids[];
>  } __packed;
>=20
> +union hv_register_vsm_partition_config {
> +	u64 as_uint64;
> +	struct {
> +		u64 enable_vtl_protection : 1;
> +		u64 default_vtl_protection_mask : 4;
> +		u64 zero_memory_on_reset : 1;
> +		u64 deny_lower_vtl_startup : 1;
> +		u64 intercept_acceptance : 1;
> +		u64 intercept_enable_vtl_protection : 1;
> +		u64 intercept_vp_startup : 1;
> +		u64 intercept_cpuid_unimplemented : 1;
> +		u64 intercept_unrecoverable_exception : 1;
> +		u64 intercept_page : 1;
> +		u64 mbz : 51;
> +	};

Add __packed since this is a binary interface with Hyper-V.
All the other register definitions have __packed.

> +};
> +
>  struct hv_nested_enlightenments_control {
>  	struct {
>  		u32 directhypercall : 1;
> @@ -1004,6 +1021,70 @@ enum hv_register_name {
>=20
>  	/* VSM */
>  	HV_REGISTER_VSM_VP_STATUS				=3D 0x000D0003,
> +
> +	/* Synthetic VSM registers */
> +	HV_REGISTER_VSM_CODE_PAGE_OFFSETS	=3D 0x000D0002,
> +	HV_REGISTER_VSM_CAPABILITIES		=3D 0x000D0006,
> +	HV_REGISTER_VSM_PARTITION_CONFIG	=3D 0x000D0007,
> +
> +#if defined(CONFIG_X86)
> +	/* X64 Debug Registers */
> +	HV_X64_REGISTER_DR0	=3D 0x00050000,
> +	HV_X64_REGISTER_DR1	=3D 0x00050001,
> +	HV_X64_REGISTER_DR2	=3D 0x00050002,
> +	HV_X64_REGISTER_DR3	=3D 0x00050003,
> +	HV_X64_REGISTER_DR6	=3D 0x00050004,
> +	HV_X64_REGISTER_DR7	=3D 0x00050005,
> +
> +	/* X64 Cache control MSRs */
> +	HV_X64_REGISTER_MSR_MTRR_CAP		=3D 0x0008000D,
> +	HV_X64_REGISTER_MSR_MTRR_DEF_TYPE	=3D 0x0008000E,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0	=3D 0x00080010,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1	=3D 0x00080011,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2	=3D 0x00080012,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3	=3D 0x00080013,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4	=3D 0x00080014,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5	=3D 0x00080015,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6	=3D 0x00080016,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7	=3D 0x00080017,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8	=3D 0x00080018,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9	=3D 0x00080019,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA	=3D 0x0008001A,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB	=3D 0x0008001B,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC	=3D 0x0008001C,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASED	=3D 0x0008001D,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE	=3D 0x0008001E,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF	=3D 0x0008001F,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0	=3D 0x00080040,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1	=3D 0x00080041,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2	=3D 0x00080042,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3	=3D 0x00080043,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4	=3D 0x00080044,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5	=3D 0x00080045,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6	=3D 0x00080046,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7	=3D 0x00080047,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8	=3D 0x00080048,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9	=3D 0x00080049,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA	=3D 0x0008004A,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB	=3D 0x0008004B,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC	=3D 0x0008004C,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD	=3D 0x0008004D,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE	=3D 0x0008004E,
> +	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF	=3D 0x0008004F,
> +	HV_X64_REGISTER_MSR_MTRR_FIX64K00000	=3D 0x00080070,
> +	HV_X64_REGISTER_MSR_MTRR_FIX16K80000	=3D 0x00080071,
> +	HV_X64_REGISTER_MSR_MTRR_FIX16KA0000	=3D 0x00080072,
> +	HV_X64_REGISTER_MSR_MTRR_FIX4KC0000	=3D 0x00080073,
> +	HV_X64_REGISTER_MSR_MTRR_FIX4KC8000	=3D 0x00080074,
> +	HV_X64_REGISTER_MSR_MTRR_FIX4KD0000	=3D 0x00080075,
> +	HV_X64_REGISTER_MSR_MTRR_FIX4KD8000	=3D 0x00080076,
> +	HV_X64_REGISTER_MSR_MTRR_FIX4KE0000	=3D 0x00080077,
> +	HV_X64_REGISTER_MSR_MTRR_FIX4KE8000	=3D 0x00080078,
> +	HV_X64_REGISTER_MSR_MTRR_FIX4KF0000	=3D 0x00080079,
> +	HV_X64_REGISTER_MSR_MTRR_FIX4KF8000	=3D 0x0008007A,
> +
> +	HV_X64_REGISTER_REG_PAGE	=3D 0x0009001C,
> +#endif
>  };
>=20
>  /*
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index b4067ada02cf..c6a62ec9f6da 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -479,6 +479,7 @@ struct hv_connection_info {
>  #define HV_EVENT_FLAGS_COUNT		(256 * 8)
>  #define HV_EVENT_FLAGS_BYTE_COUNT	(256)
>  #define HV_EVENT_FLAGS32_COUNT		(256 / sizeof(u32))
> +#define HV_EVENT_FLAGS_LONG_COUNT	(HV_EVENT_FLAGS_BYTE_COUNT / sizeof(u6=
4))
>=20
>  /* linux side we create long version of flags to use long bit ops on fla=
gs */
>  #define HV_EVENT_FLAGS_UL_COUNT		(256 / sizeof(ulong))
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index 876bfe4e4227..a218536eaec1 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -288,4 +288,86 @@ struct mshv_get_set_vp_state {
>   * #define MSHV_ROOT_HVCALL			_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_h=
vcall)
>   */
>=20
> +/* Structure definitions, macros and IOCTLs for mshv_vtl */
> +
> +#define MSHV_CAP_CORE_API_STABLE        0x0
> +#define MSHV_CAP_REGISTER_PAGE          0x1
> +#define MSHV_CAP_VTL_RETURN_ACTION      0x2
> +#define MSHV_CAP_DR6_SHARED             0x3
> +#define MSHV_MAX_RUN_MSG_SIZE                256
> +
> +#define MSHV_VP_MAX_REGISTERS   128
> +
> +struct mshv_vp_registers {
> +	__u32 count;	/* at most MSHV_VP_MAX_REGISTERS */
> +	__u32 reserved; /* Reserved for alignment or future use */
> +	__u64 regs_ptr;	/* pointer to struct hv_register_assoc */
> +};
> +
> +struct mshv_vtl_set_eventfd {
> +	__s32 fd;
> +	__u32 flag;
> +};
> +
> +struct mshv_vtl_signal_event {
> +	__u32 connection_id;
> +	__u32 flag;
> +};
> +
> +struct mshv_vtl_sint_post_msg {
> +	__u64 message_type;
> +	__u32 connection_id;
> +	__u32 payload_size; /* Must not exceed HV_MESSAGE_PAYLOAD_BYTE_COUNT */
> +	__u64 payload_ptr; /* pointer to message payload (bytes) */
> +};
> +
> +struct mshv_vtl_ram_disposition {
> +	__u64 start_pfn;
> +	__u64 last_pfn;
> +};
> +
> +struct mshv_vtl_set_poll_file {
> +	__u32 cpu;
> +	__u32 fd;
> +};
> +
> +struct mshv_vtl_hvcall_setup {
> +	__u64 bitmap_size;

What are the units of "bitmap_size"?  Bits? Bytes? u64?

> +	__u64 allow_bitmap_ptr; /* pointer to __u64 */
> +};
> +
> +struct mshv_vtl_hvcall {
> +	__u64 control;      /* Hypercall control code */
> +	__u64 input_size;   /* Size of the input data */
> +	__u64 input_ptr;    /* Pointer to the input struct */
> +	__u64 status;       /* Status of the hypercall (output) */
> +	__u64 output_size;  /* Size of the output data */
> +	__u64 output_ptr;   /* Pointer to the output struct */
> +};
> +
> +struct mshv_sint_mask {
> +	__u8 mask;
> +	__u8 reserved[7];
> +};
> +
> +/* /dev/mshv device IOCTL */
> +#define MSHV_CHECK_EXTENSION    _IOW(MSHV_IOCTL, 0x00, __u32)
> +
> +/* vtl device */
> +#define MSHV_CREATE_VTL			_IOR(MSHV_IOCTL, 0x1D, char)
> +#define MSHV_ADD_VTL0_MEMORY	_IOW(MSHV_IOCTL, 0x21, struct mshv_vtl_ram_=
disposition)
> +#define MSHV_SET_POLL_FILE		_IOW(MSHV_IOCTL, 0x25, struct mshv_vtl_set_p=
oll_file)
> +#define MSHV_RETURN_TO_LOWER_VTL	_IO(MSHV_IOCTL, 0x27)
> +#define MSHV_GET_VP_REGISTERS		_IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_re=
gisters)
> +#define MSHV_SET_VP_REGISTERS		_IOW(MSHV_IOCTL, 0x06, struct mshv_vp_reg=
isters)
> +
> +/* VMBus device IOCTLs */
> +#define MSHV_SINT_SIGNAL_EVENT    _IOW(MSHV_IOCTL, 0x22, struct mshv_vtl=
_signal_event)
> +#define MSHV_SINT_POST_MESSAGE    _IOW(MSHV_IOCTL, 0x23, struct mshv_vtl=
_sint_post_msg)
> +#define MSHV_SINT_SET_EVENTFD     _IOW(MSHV_IOCTL, 0x24, struct mshv_vtl=
_set_eventfd)
> +#define MSHV_SINT_PAUSE_MESSAGE_STREAM     _IOW(MSHV_IOCTL, 0x25, struct=
 mshv_sint_mask)
> +
> +/* hv_hvcall device */
> +#define MSHV_HVCALL_SETUP        _IOW(MSHV_IOCTL, 0x1E, struct mshv_vtl_=
hvcall_setup)
> +#define MSHV_HVCALL              _IOWR(MSHV_IOCTL, 0x1F, struct mshv_vtl=
_hvcall)
>  #endif
> --
> 2.34.1
>=20


