Return-Path: <linux-hyperv+bounces-6389-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5504B11705
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Jul 2025 05:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC1CAC7764
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Jul 2025 03:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0750922F16E;
	Fri, 25 Jul 2025 03:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ht4FAAlq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2059.outbound.protection.outlook.com [40.92.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D97F2746A;
	Fri, 25 Jul 2025 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753413763; cv=fail; b=RZd2jwslhWuEPYIIMmjD3dn1QGLTfdqazG9sr19QDWLdLhMkDB1GbDAnazRihGVvXp2FrlOfaa2Ixac+Kavrjd4KFcWoVudM7bP6ippTNfWxBuCAsfTI45e1lWrqe70xWoQXY/K/WhNjSb4uBbUqpFyA9kcj52FJEuBFpXgrrHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753413763; c=relaxed/simple;
	bh=nMIAAMDIunMulcYlFqv57JG1a30eKrlsYrknJWdZnhs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YE1arrRhJ+Ay8m6Y/rsZM/O6W4VfMiewQRXFn61EUveKIlH+Cctao5UGa9SjtI8p4lPlxUqD6ZNO158RojlW8HHxmzjJ5MZKUzyIqAtzT6EGN1oK6AjwHdl89dl6QAhgr62hkG64Xt9536LQNiy79Ukol+0FdZK5s/1GQhZabIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ht4FAAlq; arc=fail smtp.client-ip=40.92.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+FMqo4M80oRbIMEXieqNYjOl3+aXdvgig2evEt5EPVVCW7H7xglPHAYezgZUFB39uRvlPU3eR/+ulgnv1AgU0ZIoSlUKqSTfcCxfaz6ylengdrsb9Dr6/gZm4/SrsynAXgdz0Ot8uQMnZffdzsLZl6mCRejEjfXgP+2jV0zqaVSsSs3yldkEa6w5gPi7ZGF/18BLAAMChbnMCjXZ38rWhzvZh0Uro346b9Eg45aisLl0+BxQNB9nhqFDyJ61SR8uX2YCGIT7+sWqbiRZQeWMo5TFTuRENOiw/HEfgkWMjpqI2sgtfOfCDFH8PlMSlMMRKNE7VtOhtApBNkqM0mwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlWWYsbz/K6NmHWfrqjphbLIxEFa1T0shYBCfdbEivQ=;
 b=OkiT7QwJR6j0Ik+HJV0OTBzugZiIJ5fuc4EAwnOMvOdBR6M0KcuFzDEix/BqwURZZXI2gY031NxqcEGGEYx91RDpRps9kaHXLU9hEvl+VLgG+pgAsQxJpq1ij5UnOdX6SW7xjBdlNf78GboyDZPiUg+pHOl+cVnkZIwczabcdxz5mNt715hSvaOCJYKE3wHhFM8zF6VWnc7RSkdKVAkR+hU1CZUfXEUz/zfEhDlzBSij3lRr9piVgbzLzDuLBHESe9RWeTv/Qfu8fhSN+Md8L+zvDq/ibpTfCEwUe6agmYJRuTSS8Hsfis+KgrZBHcnknN/NuBkO4GJYzRGxiAbo/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlWWYsbz/K6NmHWfrqjphbLIxEFa1T0shYBCfdbEivQ=;
 b=Ht4FAAlq2StOHMhLwxv6t9NCkZuakAtdOJMAQTjRE3mCMdoNSUdTfYiPLPANTTLqOpIjXWhc2OBJUy6nAvc5AY9N51Ik4DrRYDHIzUdWopK9fqpSm3B+lF0UJcSS8am7bic+9Nwia8JTm0LoDl12nbD9WYHNPw6MSsN8y6gZEh3p5mvj6yf9hjVPGXSjmiZB7ON3CA2o0iTMahQKKs65mpTizEnErMWi/yIWIZkUgVF91DCd7PsNfuTbpXQQQcq6GGgkdnOiyTL7X/P4DMJ7JkwnmClpTCw3SqSC2hPMozzRG+6PlVegEjBItHpH1W6BAN3rYypCwova3n05S+f0LA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10241.namprd02.prod.outlook.com (2603:10b6:408:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 03:22:35 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Fri, 25 Jul 2025
 03:22:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: Roman Kisel <romank@linux.microsoft.com>, Anirudh Rayabharam
	<anrayabh@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>,
	Markus Elfring <Markus.Elfring@web.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [PATCH v6 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Index: AQHb/HScy3plG5a+z0miuAOMHd2V/bRCBVDw
Date: Fri, 25 Jul 2025 03:22:34 +0000
Message-ID:
 <SN6PR02MB41571331AF61BE197F76B970D459A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250724082547.195235-1-namjain@linux.microsoft.com>
 <20250724082547.195235-3-namjain@linux.microsoft.com>
In-Reply-To: <20250724082547.195235-3-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10241:EE_
x-ms-office365-filtering-correlation-id: d93e9f6a-acec-4147-cd3e-08ddcb2a7fb6
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|19110799012|8060799015|8062599012|15080799012|461199028|102099032|440099028|40105399003|3412199025|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?q1oXgrDle7dE5J/+r24mFm/IP0aHUnQ9nfWlaAExwZvjvC9U5r/DBsRkFadq?=
 =?us-ascii?Q?ysQjEok/3NFScSpOgfc3F1pHYJRhDcr4F5LJlusdosW9q+MD5J6xMT7FhdDq?=
 =?us-ascii?Q?KzlPb2tW7XMwXz1KeY7IFmze7Q+eb8Gi/grf9Q5G6b2N4wU1xz6h08OeltCs?=
 =?us-ascii?Q?jl2M367LYYcwUQs2NwdApfL0CsFuvBJKAKC3g04OwYF+Qec7RH3K8djzhySA?=
 =?us-ascii?Q?nKa29I+PIN1ODEY2RHE3LMn1OhWa8LYSY7j6sqF4yxi88npTnXo4eGRvUhk0?=
 =?us-ascii?Q?++u9OOlKS5krW+d9QtWdiRkmhaI4m1HF2+5/FO925Xh5cJmRRayTu6WGnlFX?=
 =?us-ascii?Q?5AGRfijWnv9BGlDlBAnovm7Z6TDFtNB8XGujivb6gIKBGr8fdVVtXWENFIo2?=
 =?us-ascii?Q?Al3sa15NNTYMHPLTqaNoDsNfKVt7vQOfX8bDyVKR1IpkxGRBttY41zGZnpeq?=
 =?us-ascii?Q?+JhccM6ot612A6KY0S/V8PqEFHCcPvYIJx9eoiwUxLIpBB6YduSxhPIx6gy3?=
 =?us-ascii?Q?v7wmvGDzMIrUjyH37fC0XOlXXZRvaTZ3lmeMSSWhHhJvQf9ntsj1ZX0OYjb6?=
 =?us-ascii?Q?9siahxGq0q9H4qs/v32Rfcpu+355auhoOHVYQXNJ+rVHXcwdfLy/QRnH4/TO?=
 =?us-ascii?Q?nza0logilI4La+bvcmDY2sZzU5MZFPrFZjKDS9vcr7ggWzKjIDl1MQrgp2N3?=
 =?us-ascii?Q?Y0n97/eN90hZEmjuae04PVDFAsuVrdCexZdOTDCnB19OJxe52OVpEal2toZy?=
 =?us-ascii?Q?62doHaBFrnaMQtHuzfqua/N8b6uOYI8pmviM6s0TePnONKqextnc0wfZgJGe?=
 =?us-ascii?Q?TDcXBgY+V6HvAXjMI5BIOQ+DAzMmIrEIqoZKpHPV24iXjZ5RULcE/k4KI9Uc?=
 =?us-ascii?Q?eR98062GNu6Dz+Oz4kzYms55+Myl+qv4Xt5OeHY9rCjaF6hptxL4e/uhmyRv?=
 =?us-ascii?Q?yXr5z4hoHgHk8OdZKEW/6SEL7ZmI2IFH8gnIJPpMs8w8tVeYYHJ2G0JZtJQs?=
 =?us-ascii?Q?9jBmuPCAOpnobcJjCqa+nId30XXQr2f7io+BwZ9xqTPidkXNUlMA7lkZFwgw?=
 =?us-ascii?Q?AU6seC2CtB9uL9U8yttXCE+l0CCgY//+Qo23VE8LQLQlkLjl1bSv3Pctdcuo?=
 =?us-ascii?Q?eeIto9la/jf2GNohWNUJvgwytSlpadWAC2pxqqd+dWeeZ4KVLaqGqah4Fel0?=
 =?us-ascii?Q?pqCM+FLunI523UAm?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WRpd3emL/NtEpiQKC+uOL8soEogkGZdJRt4ahMNGluPI6r31a8VUXxw29xle?=
 =?us-ascii?Q?o8QgTcMMlfgJDQEDPhm5cw1SrSMB0oKNfEk9FYVd1SabZZEYco8ByzNrY4WC?=
 =?us-ascii?Q?QJ7oTv9gqwcBKEMwnD/ls5fkALK41HT3pdU0XnRnAMyZjjLdbmAj4S3v+lEP?=
 =?us-ascii?Q?MzqCnnZjlvy2eeGX4BihUBeQHG8dAOf6FGMJKFIcB0uAD31P3rD5w12wGKko?=
 =?us-ascii?Q?7BctitARIZNr+nTAtVlJaTcXM2YqFX1gRjKgj+h2On4idak1AOPD1q7qwKqq?=
 =?us-ascii?Q?VfdkovrdTOGpXGdoJuHJIgC9L1sXch7Zo3652HkO+BaQd7JKu+6Nr7Vabhe+?=
 =?us-ascii?Q?H+tJ5wZFX4QPA1loOvBoaxp9ZMQJlza0SZkMU79jcVgRIXFwFWxoEUcyQek/?=
 =?us-ascii?Q?M/vdoR6qjHrWi6c2IRUs5iVBCIxw5FZ61zOQunR0oakVBvGGibfeRfGxBxc+?=
 =?us-ascii?Q?5v6cv+gr4ygJj6oi/fXuf8GDdwgkCA+y+WRz18alwfWPqBpCpWjnlOuuJYBe?=
 =?us-ascii?Q?SGFko9hTH3PK8+JtBPyCXNRFwRxthLAGXN4BVXU/qO01kKmgQwynSXmLzEzO?=
 =?us-ascii?Q?9tlIE0sDbHHP9oZdnSQ/wf3LtFPFzUybbT1+0oPaKkHdWVnOkcffN2Rrv8+Y?=
 =?us-ascii?Q?M3VOElYpDCJZo6M1jWA4IZNaUAG3WnPNcQaus3+4AW4Ii4YFxDkXG+i1Vn/E?=
 =?us-ascii?Q?lkjy6kFJJMzxZ+JL4zjleqMHLlxm3Dm43hLLhGxV5ndVI3UJGRzTt9mEkt3d?=
 =?us-ascii?Q?TVy4RjcYfTOS6q6nH64dfQO1mKABnbjg8r0BSohHSbNvrzS/GBQsAVX7pA6Z?=
 =?us-ascii?Q?Uiq2hEtQWCF18PFZc8ZduWH4A7q8rOYrToQrHGIjvoE4ts+faDg5SYyvi11A?=
 =?us-ascii?Q?yDKGBDktmsCVs2G2dJCsvumi3TCtfhMsb1oKgJrZGleZIhp5SMmmayMOl21q?=
 =?us-ascii?Q?CSlh7rPM5yvaglI0vS5h449rmDtnQ4+lI2iewg9OI/aIHcHup8GpKahej7U1?=
 =?us-ascii?Q?cuUFt/wpNHDkwZTwkoRdoqhLsjL4lbIBCq4Y88ufU2pxYzpRXNublWMyZFp1?=
 =?us-ascii?Q?NhifX8rGqBxhWu/PTFBE3ViUgIAWS6IO4I4SUYn/H57cW+QbJMMSTyxrHo62?=
 =?us-ascii?Q?djXlAE3mGaNQ3klh9whrgA03BXr/EYaB1cqLpPqVUYWrYqxg8l666agFp2xm?=
 =?us-ascii?Q?7Pg0I2+3u09+D3J2i758OCI5GxkoAshJO4okMssBbqJvGatw5lfvJ3AtkXE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d93e9f6a-acec-4147-cd3e-08ddcb2a7fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 03:22:34.8167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10241

From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, July 24, 202=
5 1:26 AM
>=20

Overall, this is looking really good. I have just a few comments embedded b=
elow.

> Provide an interface for Virtual Machine Monitor like OpenVMM and its
> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
> Expose devices and support IOCTLs for features like VTL creation,
> VTL0 memory management, context switch, making hypercalls,
> mapping VTL0 address space to VTL2 userspace, getting new VMBus
> messages and channel events in VTL2 etc.
>=20
> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Message-ID: <20250512140432.2387503-3-namjain@linux.microsoft.com>

This "Message-ID" line looks misplaced or just spurious.

> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig          |   22 +
>  drivers/hv/Makefile         |    7 +-
>  drivers/hv/mshv_vtl.h       |   52 ++
>  drivers/hv/mshv_vtl_main.c  | 1508 +++++++++++++++++++++++++++++++++++
>  include/hyperv/hvgdk_mini.h |  106 +++
>  include/uapi/linux/mshv.h   |   80 ++
>  6 files changed, 1774 insertions(+), 1 deletion(-)

Nice! 254 fewer lines inserted than in the previous version!

>  create mode 100644 drivers/hv/mshv_vtl.h
>  create mode 100644 drivers/hv/mshv_vtl_main.c
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 57623ca7f350..2e8df09db599 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -73,4 +73,26 @@ config MSHV_ROOT
>=20
>  	  If unsure, say N.
>=20
> +config MSHV_VTL
> +	tristate "Microsoft Hyper-V VTL driver"
> +	depends on X86_64 && HYPERV_VTL_MODE
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
> @@ -14,7 +15,11 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+=3D hv_debugfs.o
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
> index 000000000000..00aa1d881153
> --- /dev/null
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -0,0 +1,1508 @@
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
> +#define MSHV_REAL_OFF_SHIFT	16
> +#define MSHV_PG_OFF_CPU_MASK	(BIT_ULL(MSHV_REAL_OFF_SHIFT) - 1)
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
> +/* hvcall code is of type u16, allocate a bitmap of size (1 << 16) to ac=
commodate it */
> +#define MAX_BITMAP_SIZE BIT(16)

Or maybe per my comment below, use

#define MAX_BITMAP_BYTES ((U16_MAX + 1)/8)

> +
> +struct mshv_vtl_hvcall_fd {
> +	u8 allow_bitmap[MAX_BITMAP_SIZE];

This is still too big. :-(  You'll get 64K bytes, which is 512K bits. You o=
nly need
64K bits.

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
> +struct mshv_vtl_per_cpu {
> +	struct mshv_vtl_run *run;
> +	struct page *reg_page;
> +};
> +
> +/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
> +union hv_synic_overlay_page_msr {
> +	u64 as_uint64;
> +	struct {
> +		u64 enabled: 1;
> +		u64 reserved: 11;
> +		u64 pfn: 52;
> +	};

Add __packed to exactly match hv_synic_simp.

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
> +static const union hv_input_vtl input_vtl_zero;
> +static const union hv_input_vtl input_vtl_normal =3D {
> +	.use_target_vtl =3D 1,
> +};
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
> +	union hv_synic_overlay_page_msr overlay =3D {};
> +	struct page *reg_page;
> +
> +	reg_page =3D alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL);
> +	if (!reg_page) {
> +		WARN(1, "failed to allocate register page\n");
> +		return;
> +	}
> +
> +	overlay.enabled =3D 1;
> +	overlay.pfn =3D page_to_hvpfn(reg_page);
> +	reg_assoc.name =3D HV_X64_REGISTER_REG_PAGE;
> +	reg_assoc.value.reg64 =3D overlay.as_uint64;
> +
> +	if (hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +				     1, input_vtl_zero, &reg_assoc)) {
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
> +	int ret, count =3D 2;
> +
> +	registers[0].name =3D HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
> +	registers[1].name =3D HV_REGISTER_VSM_CAPABILITIES;
> +
> +	ret =3D hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF=
,
> +				       count, input_vtl_zero, registers);
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
> +
> +	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +				       1, input_vtl_zero, &reg_assoc);
> +}
> +
> +static void mshv_vtl_vmbus_isr(void)
> +{
> +	struct hv_per_cpu_context *per_cpu;
> +	struct hv_message *msg;
> +	u32 message_type;
> +	union hv_synic_event_flags *event_flags;
> +	struct eventfd_ctx *eventfd;
> +	u16 i;
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
> +	for_each_set_bit(i, event_flags->flags, HV_EVENT_FLAGS_COUNT) {
> +		if (!sync_test_and_clear_bit(i, event_flags->flags))
> +			continue;
> +		rcu_read_lock();
> +		eventfd =3D READ_ONCE(flag_eventfds[i]);
> +		if (eventfd)
> +			eventfd_signal(eventfd);
> +		rcu_read_unlock();
> +	}
> +
> +	vmbus_isr();
> +}
> +
> +static int mshv_vtl_alloc_context(unsigned int cpu)
> +{
> +	struct mshv_vtl_per_cpu *per_cpu =3D this_cpu_ptr(&mshv_vtl_per_cpu);
> +
> +	per_cpu->run =3D (struct mshv_vtl_run *)__get_free_page(GFP_KERNEL | __=
GFP_ZERO);
> +	if (!per_cpu->run)
> +		return -ENOMEM;
> +
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
> +
> +	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vtl:online",
> +				mshv_vtl_alloc_context, NULL);
> +	if (ret < 0) {
> +		hv_setup_vmbus_handler(vmbus_isr);
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
> +	cpuhp_remove_state(mshv_vtl_cpuhp_online);
> +	hv_setup_vmbus_handler(vmbus_isr);
> +}
> +
> +static int vtl_get_vp_register(struct hv_register_assoc *reg)
> +{
> +	return hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +					1, input_vtl_normal, reg);
> +}
> +
> +static int vtl_set_vp_register(struct hv_register_assoc *reg)
> +{
> +	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +					1, input_vtl_normal, reg);
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
> +	/* vlt0_mem.last_pfn is excluded in the pagemap range for VTL0 as per d=
esign */

s/vlt0_mem/vtl0_mem/

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
> +
> +	if (input.cpu >=3D num_possible_cpus() || !cpu_online(input.cpu))
> +		return -EINVAL;
> +	/*
> +	 * Hotplug is not supported in VTL2 in OpenHCL, where this kernel drive=
r exists.

More precisely, you mean "CPU hotplug" as opposed to "memory hotplug", thou=
gh
that should be evident from the context. (Memory hotplug may not be support=
ed
either, but that's not relevant here.)

> +	 * CPU is expected to remain online after above cpu_online() check.
> +	 */
> +
> +	file =3D NULL;
> +	file =3D fget(input.fd);
> +	if (!file)
> +		return -EBADFD;
> +
> +	poll_file =3D per_cpu_ptr(&mshv_vtl_poll_file, READ_ONCE(input.cpu));
> +	if (!poll_file)
> +		return -EINVAL;
> +
> +	guard(mutex)(&mshv_vtl_poll_file_lock);
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
> +	if (old_file)
> +		fput(old_file);

Is it safe to call fput() while holding mshv_vtl_poll_file_lock? I don't kn=
ow
the answer, but the change to using "guard" has made the fput() within
the scope of the lock, whereas previously it was not. My inclination would
be to *not* hold mshv_vtl_poll_file_lock when calling fput(), but I can't
immediately point to a problem that occur if the lock is held.

> +
> +	return 0;
> +}
> +
> +/* Static table mapping register names to their corresponding actions */
> +static const struct {
> +	enum hv_register_name reg_name;
> +	int debug_reg_num;  /* -1 if not a debug register */
> +	u32 msr_addr;       /* 0 if not an MSR */
> +} reg_table[] =3D {
> +	/* Debug registers */
> +	{HV_X64_REGISTER_DR0, 0, 0},
> +	{HV_X64_REGISTER_DR1, 1, 0},
> +	{HV_X64_REGISTER_DR2, 2, 0},
> +	{HV_X64_REGISTER_DR3, 3, 0},
> +	{HV_X64_REGISTER_DR6, 6, 0},
> +	/* MTRR MSRs */
> +	{HV_X64_REGISTER_MSR_MTRR_CAP, -1, MSR_MTRRcap},
> +	{HV_X64_REGISTER_MSR_MTRR_DEF_TYPE, -1, MSR_MTRRdefType},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0, -1, MTRRphysBase_MSR(0)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1, -1, MTRRphysBase_MSR(1)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2, -1, MTRRphysBase_MSR(2)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3, -1, MTRRphysBase_MSR(3)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4, -1, MTRRphysBase_MSR(4)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5, -1, MTRRphysBase_MSR(5)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6, -1, MTRRphysBase_MSR(6)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7, -1, MTRRphysBase_MSR(7)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8, -1, MTRRphysBase_MSR(8)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9, -1, MTRRphysBase_MSR(9)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA, -1, MTRRphysBase_MSR(0xa)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB, -1, MTRRphysBase_MSR(0xb)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC, -1, MTRRphysBase_MSR(0xc)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASED, -1, MTRRphysBase_MSR(0xd)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE, -1, MTRRphysBase_MSR(0xe)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF, -1, MTRRphysBase_MSR(0xf)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0, -1, MTRRphysMask_MSR(0)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1, -1, MTRRphysMask_MSR(1)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2, -1, MTRRphysMask_MSR(2)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3, -1, MTRRphysMask_MSR(3)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4, -1, MTRRphysMask_MSR(4)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5, -1, MTRRphysMask_MSR(5)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6, -1, MTRRphysMask_MSR(6)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7, -1, MTRRphysMask_MSR(7)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8, -1, MTRRphysMask_MSR(8)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9, -1, MTRRphysMask_MSR(9)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA, -1, MTRRphysMask_MSR(0xa)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB, -1, MTRRphysMask_MSR(0xb)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC, -1, MTRRphysMask_MSR(0xc)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD, -1, MTRRphysMask_MSR(0xd)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE, -1, MTRRphysMask_MSR(0xe)},
> +	{HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF, -1, MTRRphysMask_MSR(0xf)},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX64K00000, -1, MSR_MTRRfix64K_00000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX16K80000, -1, MSR_MTRRfix16K_80000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX16KA0000, -1, MSR_MTRRfix16K_A0000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KC0000, -1, MSR_MTRRfix4K_C0000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KC8000, -1, MSR_MTRRfix4K_C8000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KD0000, -1, MSR_MTRRfix4K_D0000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KD8000, -1, MSR_MTRRfix4K_D8000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KE0000, -1, MSR_MTRRfix4K_E0000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KE8000, -1, MSR_MTRRfix4K_E8000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KF0000, -1, MSR_MTRRfix4K_F0000},
> +	{HV_X64_REGISTER_MSR_MTRR_FIX4KF8000, -1, MSR_MTRRfix4K_F8000},
> +};
> +
> +static int mshv_vtl_set_reg(struct hv_register_assoc *regs)
> +{
> +	u64 reg64;
> +	enum hv_register_name gpr_name;
> +	int i;
> +
> +	gpr_name =3D regs->name;
> +	reg64 =3D regs->value.reg64;
> +
> +	/* Search for the register in the table */
> +	for (i =3D 0; i < ARRAY_SIZE(reg_table); i++) {
> +		if (reg_table[i].reg_name =3D=3D gpr_name) {
> +			if (reg_table[i].debug_reg_num !=3D -1) {
> +				/* Handle debug registers */
> +				if (gpr_name =3D=3D HV_X64_REGISTER_DR6 &&
> +				    !mshv_vsm_capabilities.dr6_shared)
> +					goto hypercall;
> +				native_set_debugreg(reg_table[i].debug_reg_num, reg64);
> +			} else {
> +				/* Handle MSRs */
> +				wrmsrl(reg_table[i].msr_addr, reg64);
> +			}
> +			return 0;
> +		}
> +	}
> +
> +hypercall:
> +	return 1;
> +}
> +
> +static int mshv_vtl_get_reg(struct hv_register_assoc *regs)
> +{
> +	u64 *reg64;
> +	enum hv_register_name gpr_name;
> +	int i;
> +
> +	gpr_name =3D regs->name;
> +	reg64 =3D (u64 *)&regs->value.reg64;
> +
> +	/* Search for the register in the table */
> +	for (i =3D 0; i < ARRAY_SIZE(reg_table); i++) {
> +		if (reg_table[i].reg_name =3D=3D gpr_name) {
> +			if (reg_table[i].debug_reg_num !=3D -1) {
> +				/* Handle debug registers */
> +				if (gpr_name =3D=3D HV_X64_REGISTER_DR6 &&
> +				    !mshv_vsm_capabilities.dr6_shared)
> +					goto hypercall;
> +				*reg64 =3D native_get_debugreg(reg_table[i].debug_reg_num);
> +			} else {
> +				/* Handle MSRs */
> +				rdmsrl(reg_table[i].msr_addr, *reg64);
> +			}
> +			return 0;
> +		}
> +	}
> +
> +hypercall:
> +	return 1;
> +}

Nice! You incorporated the debug registers as well into the static
table and lookup functions. I count 224 fewer source code lines.

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
0) */
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
> +	struct hv_register_assoc *reg;
> +	long ret;
> +
> +	if (copy_from_user(&args, user_args, sizeof(args)))
> +		return -EFAULT;
> +
> +	/*  This IOCTL supports processing only one register at a time. */
> +	if (args.count !=3D 1)
> +		return -EINVAL;
> +
> +	reg =3D kmalloc(sizeof(*reg), GFP_KERNEL);

If handling only one register, there's no need to kmalloc. Just
declare the struct hv_register_assoc directly on the stack
instead of a pointer to such. Then the error paths are
simpler because memory doesn't need to be freed.

> +	if (!reg)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(reg, (void __user *)args.regs_ptr,
> +			   sizeof(*reg))) {
> +		ret =3D -EFAULT;
> +		goto free_return;
> +	}
> +
> +	ret =3D mshv_vtl_get_reg(reg);
> +	if (!ret)
> +		goto copy_args; /* No need of hypercall */
> +	ret =3D vtl_get_vp_register(reg);
> +	if (ret)
> +		goto free_return;
> +
> +copy_args:
> +	if (copy_to_user((void __user *)args.regs_ptr, reg, sizeof(*reg)))
> +		ret =3D -EFAULT;
> +free_return:
> +	kfree(reg);
> +
> +	return ret;
> +}
> +
> +static long
> +mshv_vtl_ioctl_set_regs(void __user *user_args)
> +{
> +	struct mshv_vp_registers args;
> +	struct hv_register_assoc *reg;
> +	long ret;
> +
> +	if (copy_from_user(&args, user_args, sizeof(args)))
> +		return -EFAULT;
> +
> +	/*  This IOCTL supports processing only one register at a time. */
> +	if (args.count !=3D 1)
> +		return -EINVAL;
> +
> +	reg =3D kmalloc(sizeof(*reg), GFP_KERNEL);

Same here.  Declare struct hv_register_assoc on the stack.

> +	if (!reg)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(reg, (void __user *)args.regs_ptr, sizeof(*reg))) {
> +		ret =3D -EFAULT;
> +		goto free_return;
> +	}
> +
> +	ret =3D mshv_vtl_set_reg(reg);
> +	if (!ret)
> +		goto free_return; /* No need of hypercall */
> +	ret =3D vtl_set_vp_register(reg);
> +
> +free_return:
> +	kfree(reg);
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
> +	/*
> +	 * Hotplug is not supported in VTL2 in OpenHCL, where this kernel drive=
r exists.
> +	 * CPU is expected to remain online after above cpu_online() check.
> +	 */
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
ize_t size, loff_t *offset)
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
> +
> 	READ_ONCE(vtl_synic_mask_vmbus_sint_masked));
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
> +	u64 input, status;
> +	struct mshv_vtl_signal_event signal_event;
> +
> +	if (copy_from_user(&signal_event, arg, sizeof(signal_event)))
> +		return -EFAULT;
> +
> +	input =3D signal_event.connection_id | ((u64)signal_event.flag << 32);
> +
> +	status =3D hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, input) & HV_HYPER=
CALL_RESULT_MASK;
> +	if (status)

Don't AND with HV_HYPERCALL_RESULT_MASK and then test the result.
You can just do "return hv_result_to_errno(status)". The function will
return zero if there's no error. See other uses of hv_result_to_errno() for
the various patterns. We want to get away from AND'ing with
HV_HYPERCALL_RESULT_MASK and instead always use the helper
functions.

> +		return hv_result_to_errno(status);
> +	return 0;
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
> +	guard(mutex)(&flag_lock);
> +	old_eventfd =3D READ_ONCE(flag_eventfds[set_eventfd.flag]);
> +	WRITE_ONCE(flag_eventfds[set_eventfd.flag], eventfd);
> +
> +	if (old_eventfd) {
> +		synchronize_rcu();
> +		eventfd_ctx_put(old_eventfd);

Again, I wonder if is OK to do eventfd_ctx_put() while holding
flag_lock, since the use of guard() changes the scope of the lock
compared with the previous version of this patch.

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
> +	guard(mutex)(&vtl2_vmbus_sint_mask_mutex);
> +	on_each_cpu((smp_call_func_t)mshv_vtl_synic_mask_vmbus_sint, &mask.mask=
, 1);
> +	WRITE_ONCE(vtl_synic_mask_vmbus_sint_masked, mask.mask !=3D 0);
> +	if (mask.mask)
> +		wake_up_interruptible_poll(&fd_wait_queue, EPOLLIN);

Doing this wakeup is probably safe to do while holding the lock.

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
> +static int mshv_vtl_hvcall_dev_open(struct inode *node, struct file *f)
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
> +static int mshv_vtl_hvcall_dev_release(struct inode *node, struct file *=
f)
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
> +static int mshv_vtl_hvcall_do_setup(struct mshv_vtl_hvcall_fd *fd,
> +				    struct mshv_vtl_hvcall_setup __user *hvcall_setup_user)
> +{
> +	struct mshv_vtl_hvcall_setup hvcall_setup;
> +
> +	guard(mutex)(&fd->init_mutex);
> +
> +	if (fd->allow_map_initialized) {
> +		dev_err(fd->dev->this_device,
> +			"Hypercall allow map has already been set, pid %d\n",
> +			current->pid);
> +		return -EINVAL;
> +	}
> +
> +	if (copy_from_user(&hvcall_setup, hvcall_setup_user,
> +			   sizeof(struct mshv_vtl_hvcall_setup))) {
> +		return -EFAULT;
> +	}
> +	if (hvcall_setup.bitmap_array_size > ARRAY_SIZE(fd->allow_bitmap))
> +		return -EINVAL;
> +
> +	if (copy_from_user(&fd->allow_bitmap,
> +			   (void __user *)hvcall_setup.allow_bitmap_ptr,
> +			   hvcall_setup.bitmap_array_size)) {
> +		return -EFAULT;
> +	}
> +
> +	dev_info(fd->dev->this_device, "Hypercall allow map has been set, pid %=
d\n",
> +		 current->pid);
> +	fd->allow_map_initialized =3D true;
> +	return 0;
> +}
> +
> +static bool mshv_vtl_hvcall_is_allowed(struct mshv_vtl_hvcall_fd *fd, u1=
6 call_code)
> +{
> +	return test_bit(call_code, (unsigned long *)fd->allow_bitmap);
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
> +static long mshv_vtl_hvcall_dev_ioctl(struct file *f, unsigned int cmd, =
unsigned long arg)
> +{
> +	struct mshv_vtl_hvcall_fd *fd =3D f->private_data;
> +
> +	switch (cmd) {
> +	case MSHV_HVCALL_SETUP:
> +		return mshv_vtl_hvcall_do_setup(fd, (struct mshv_vtl_hvcall_setup __us=
er *)arg);
> +	case MSHV_HVCALL:
> +		return mshv_vtl_hvcall_call(fd, (struct mshv_vtl_hvcall __user *)arg);
> +	default:
> +		break;
> +	}
> +
> +	return -ENOIOCTLCMD;
> +}
> +
> +static const struct file_operations mshv_vtl_hvcall_dev_file_ops =3D {
> +	.owner =3D THIS_MODULE,
> +	.open =3D mshv_vtl_hvcall_dev_open,
> +	.release =3D mshv_vtl_hvcall_dev_release,
> +	.unlocked_ioctl =3D mshv_vtl_hvcall_dev_ioctl,
> +};
> +
> +static struct miscdevice mshv_vtl_hvcall_dev =3D {
> +	.name =3D "mshv_hvcall",
> +	.nodename =3D "mshv_hvcall",
> +	.fops =3D &mshv_vtl_hvcall_dev_file_ops,
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
> +static bool can_fault(struct vm_fault *vmf, unsigned long size, unsigned=
 long *pfn)
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
> +		*pfn =3D vmf->pgoff & ~(mask >> PAGE_SHIFT);
> +
> +	return is_valid;
> +}
> +
> +static vm_fault_t mshv_vtl_low_huge_fault(struct vm_fault *vmf, unsigned=
 int order)
> +{
> +	unsigned long pfn =3D vmf->pgoff;
> +	int ret =3D VM_FAULT_FALLBACK;
> +
> +	switch (order) {
> +	case 0:
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
> +	ret =3D misc_register(&mshv_vtl_hvcall_dev);
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
> +	misc_deregister(&mshv_vtl_hvcall_dev);
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
> +	misc_deregister(&mshv_vtl_hvcall_dev);
> +	misc_deregister(&mshv_vtl_sint_dev);
> +	hv_vtl_remove_synic();
> +	misc_deregister(&mshv_dev);
> +}
> +
> +module_init(mshv_vtl_init);
> +module_exit(mshv_vtl_exit);
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 1be7f6a02304..79b7324e4ef5 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -882,6 +882,48 @@ struct hv_get_vp_from_apic_id_in {
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
> +	} __packed;
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
> +	} __packed;
> +	u64 as_uint64;
> +};
> +
>  struct hv_nested_enlightenments_control {
>  	struct {
>  		u32 directhypercall : 1;
> @@ -1004,6 +1046,70 @@ enum hv_register_name {
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
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index 876bfe4e4227..44821814aea8 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -288,4 +288,84 @@ struct mshv_get_set_vp_state {
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
> +struct mshv_vp_registers {
> +	__u32 count;	/* supports only 1 register at a time */
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
> +	__u64 bitmap_array_size;
> +	__u64 allow_bitmap_ptr; /* pointer to __u64 */

I don't think the comment is relevant. The unit of
memory allocation in user space doesn't affect kernel
code. And perhaps add a comment that bitmap_array_size
is a *byte* count! :-)

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


