Return-Path: <linux-hyperv+bounces-6116-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDAEAFAA01
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 05:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463A93B8239
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 03:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A60E1BBBE5;
	Mon,  7 Jul 2025 03:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MvxdRD3O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2023.outbound.protection.outlook.com [40.92.23.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D73615E8B;
	Mon,  7 Jul 2025 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751857960; cv=fail; b=bVgSHvTV/5hvLjzHwgpIgBbOtAriZH4YwEUSlTZZ7D0H//T/TlB5plD1Uyaa2MDjKjSM7UHdPUjubb9eU2sOXUVblcZcBYcV4VFGRRHOaClZ9++GvscNK2RuAItE4VCD3Qs7bfWWbJJkYXqULDXp8RXi/YiDt6dImf23Bqp6RMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751857960; c=relaxed/simple;
	bh=drrEulSNbGFxkN2EfIgl+8ti1xAHDmrLTChItypT4b8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YjJzG7Fih1nid5U2KEgmU9RbOHJntVu1HE5uhOxDMX5o1Ohvyy5XxEjwaBTs+u0aYwvCEreQ/RL5q/KfC3DjT8uQrl+YWAcrKB/ztLmS5WcG/IMWIIO7bjy8+p0Vj4v7ymF8oDPHxzRo7B8rlG5LbGdTCVqIs2mHWAO/CTVk2o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MvxdRD3O; arc=fail smtp.client-ip=40.92.23.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jX3on9XzNppTiobf/x84QTG+TDkMkDs4cP5+iLRGPQkwKotWM7eMZROXtv8ENYRbVe2/A174k7TWd052RwHJvl52QsydX0zt7vSnvdZYIlEXKn9mrbdcTHqxAgbBGchJ1kh4PGewDi86tZkVYVhFce7la9HB9ZhhUR5KxRuotE1gZThRBBFfgo/d6N96KM9jRykRSJ8ZOLjZm4JPB96btOyfe0sesTk2PQ8BtXoyDeRKzo58+OSR9Lr95BzvT/L6TBzjBxXZ7HukY24EXDj6PaDNfnxnpapstmn1cWhV5fNN8amUiq4ELw1SWKfoFsxg+7ieQM+v5+Liu4X637udDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjUuZy2Yd7k0ca9wUDNS3wmtGTmqlceEjmOPbDwjzfs=;
 b=WipF3zwbXNtfut19783Sxzr6H8tY3m76BUPk0PRCDzndjzAZDgumH7TZX64MPG7ncdnUw7j64xTI+DM+RpORtDjy+EbIfrrI0lpQLQY3yawP4N9oRT9cUROIKL6jhA+R73J4au3vEMmj4vgqxV0LdWjvuRmNxCLHWfxmBvNXR+aXn74Y7xyl3Ry14HFqcDpc9FlG+ykbjdrzaTSMNWflYertp3kUxOur3x2/xdVThS/Sg0Btvq3qp6UhWG8N63U2hBqGeIZQhwuLBJXS87YgG4qNp8h6WCXNsQjnmh0dSKAS5r3OimGeaYQ/ITk1SdwfTWWjtqKgxklESXki+Q1oGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjUuZy2Yd7k0ca9wUDNS3wmtGTmqlceEjmOPbDwjzfs=;
 b=MvxdRD3O94L+XlGHyg/tv3tzzr3Lmv0xbqOohs1e2D8ibEez1IKMkH+hCGAFIE+whvrbFrcP/4KyGhQwjaFyYzMcyJvmGKnh97v8LS6vE+WaOUmL+u/AIeHo8DiUOIyCfGHoNP0PSlzGRZiyrTKXjlDwXucIczuJbFmwXjlFEl5/YzTCX7+j2usCT4TcRmakZ5AXe7/f6Vby7hHhjrFT6xHSAeTMiRlcWbIY8jFiJ7yq/aL3tvWBzcV2bPL2TNRDu6Hd1zZ1VjJoAVKM8wCHn0Qty2fD8rWgJRpXnOACiLMTAUlvd3Ao0aaS/xz5z7k2SUPkWn33LXs39ApXZukmOQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8543.namprd02.prod.outlook.com (2603:10b6:806:1fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 7 Jul
 2025 03:12:36 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Mon, 7 Jul 2025
 03:12:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "romank@linux.microsoft.com"
	<romank@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: RE: [PATCH v2 1/6] PCI: hv: Don't load the driver for baremetal root
 partition
Thread-Topic: [PATCH v2 1/6] PCI: hv: Don't load the driver for baremetal root
 partition
Thread-Index: AQHb7GwXSZg9jiVZRUGJ4GhkwEVxsLQjmGgg
Date: Mon, 7 Jul 2025 03:12:35 +0000
Message-ID:
 <SN6PR02MB4157A58B94F1F04E839B86B6D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1751582677-30930-2-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1751582677-30930-2-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8543:EE_
x-ms-office365-filtering-correlation-id: 8e75ea47-f259-49df-c14e-08ddbd041f35
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|8060799009|41001999006|19110799006|15080799009|461199028|40105399003|3412199025|51005399003|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GotMwTZckVMeG+9izI51D2q6B/RV/tszrDaxNfYmbmL3AHcc1o8mv/cRyWTu?=
 =?us-ascii?Q?o1cTRKk2NQ2WuXpSv8lSClvH+Wrda9QYR3tPskQ5bOxnbaD7t/wzva6IYBXV?=
 =?us-ascii?Q?QlLZK3cbRcPh4mNu8SBlm2IPOkO24OffrgwAFrp1J7IgMrJIyI/ZtgrMFDn1?=
 =?us-ascii?Q?6VKCHeWwf7znKE9Y0dS76zOsWa88EOQTp8YRBE8VsZWm04wa1ElxLKTs9W+j?=
 =?us-ascii?Q?6i63jImC3okJaAje2Ie37/OOk5djaWlXqFBUAFHhWI5H58osq318CEsb+DB6?=
 =?us-ascii?Q?AXtGIQ+eErAubt6/FqL6jCsU/08AA4WP3ca2h20xDTwao5ekgqXLNzJD7DhI?=
 =?us-ascii?Q?LB05eCoCirTCJMoVHw6JF07t4bx1LR+67R4awAqmSKoACNKr+jov4h+T030t?=
 =?us-ascii?Q?qOpdey4KLRAHEUQ2lcWGrWf5afZHeDPiwlXdR8CzGpbzb5GAtM+0xEPIldJS?=
 =?us-ascii?Q?lOj/nWb6xwWZMEb0yH+cdD7OUjVVSE+kfxnJKwAmID8K+vjETvy3eydzDPsG?=
 =?us-ascii?Q?r6PSi8GQdwhbBSqgUqwByvN+5qT2Yv+XoWcyB1F+vaBC9Z44KFO72+ltFL0U?=
 =?us-ascii?Q?cRvYHcEL4lbE5n2T9OMxuwQGw8X1fQhYD3N54deCrp7j8jhITmJ8wwqU6ZXY?=
 =?us-ascii?Q?GWRimqCfUCl7TZEI23C+AAFiQSAGI6N2oNP57t2wUV5YqAm66LZwlV/IfPQL?=
 =?us-ascii?Q?ZZCwId+fjz6FgkFO/zn1x49moXzcIi4ACIA7voiStqfLkP4BO+1JPrjAe0eg?=
 =?us-ascii?Q?Xi8PZUA45sRwc/46mpNo/kmF77/i/DBbtSaue0QBnaZE9O3LdgVag6FT0vdQ?=
 =?us-ascii?Q?xY9mGpzXlAI6D83dEi6wYhqgvtc9SLbxgw3vCnguv3wr6QpcYOuWzd9PWs7Q?=
 =?us-ascii?Q?6vBty3d6Itzeu5X/izvZq8j19PMCbAmzXr1aoFZ0E5sj3Az9N9zCTPpayv08?=
 =?us-ascii?Q?5VBUJrc9coMcNz+gD/F/Rsqd3C0RO7gdcaS6yMRfbqNcVONK/OhQDV1+GN/g?=
 =?us-ascii?Q?pK6nbVHv9JxKLpJ9RNSjoBhItxcdQIPWIbJkrzBBpwUirqJZ1PYSZkqFJulb?=
 =?us-ascii?Q?0NIXqoOR48ilAw+KOHYTCudXIv1pjZdw4kh6XnPc5XJCk8UE0e+UBEPRx5gA?=
 =?us-ascii?Q?dn+cngsDr6CTRNsXeFsAExjCMH82u933Zt208CPoyuS/YSpIwVZmzPQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aSyNsNoCs0UDd0fPa/BohUE3Wn5ITy5SAa6C3Egz7FV0ZipFdf7wk6p4bqQw?=
 =?us-ascii?Q?AywH3ceVr2V26zjiNaZwR08YHOmTPaDkMhuCQAS0HHc6P2YSfZdi2hUNxzQX?=
 =?us-ascii?Q?mWS27IWPsHtfhpOVOVS8CPyXgbVGl6L2Jus39eKiYnTEthTF+/AHOVFiN6Gp?=
 =?us-ascii?Q?XagCUPKdGj/xSOME7hmsIv/QlEZgMbko6pL06/UwmwAcmN5DnEcgpHGB/WYX?=
 =?us-ascii?Q?A4N0dFDp5wBPu7AnNPsPqL3FkrRf2L8BtHCsWyut5Ats7DUcYVpEqGo8asR1?=
 =?us-ascii?Q?gWbwypsmZJL9dUFFeeW/6ckcBcv6DgUQHlbJHmhUUQsh2q9BmUShoSoQwcbz?=
 =?us-ascii?Q?ZqZ/a1WOmp9acjqPQhND0AohXqYpSeQbEPC/K7rJ6p79uPWcSZV7C5c+BZkj?=
 =?us-ascii?Q?Odq336WazmrYZ5yNZN1UKxHekqK+i2uaooXPCyjs3UT7jXrW5EpT591jXlAe?=
 =?us-ascii?Q?5gY9D5H57yfl4sQtof8DMA2T8uEaCZtuLo5KJWGwoTTztTlk1wx8GEA31nP2?=
 =?us-ascii?Q?PnrmcwevDDyEanXkNmNhrg9BmRBT9irPoLD1rMqx1TrTMybtF5/IG9bZ9bfC?=
 =?us-ascii?Q?TecyzQZtzmz83MyLk5H+yYJHjAxIq7L0nNOFNFj/2S3s4TSLljORjlvriDXw?=
 =?us-ascii?Q?Uoy0bOJWdFbySGBjvOv8JRLvh46mLsJOayk8pO29pr9nZbxAQG1Mg+g+Uye2?=
 =?us-ascii?Q?3Pwu2oP3R73qHyXwRX3ybRxC+cWzheplNkTwp+yprWqYI4n1e/9FQVVcOal7?=
 =?us-ascii?Q?b8MGTTvE6uz/jrKV/Hq1nhTZqR4vE1kH255WUUXB8xHWzhn+XuWBxPzhFPCg?=
 =?us-ascii?Q?OkglDvjkAVxc9vjfrLuIVGceqNjDclPQfEhl99UtalfTYct5Tp2MGL5j5lw+?=
 =?us-ascii?Q?Tsq/lTaZ2OCj7LziSNMKLQnxJKhWj76RJoJA/Owj8X0d9MCpIfVSJbk3ux87?=
 =?us-ascii?Q?xqx0o+LBGHsTPe0gxN5I0xLRI/8wsc9ePjR3hnN+e8IDQmF19HfUg4sNb5nv?=
 =?us-ascii?Q?40wL/IU3GzYAHThP6clt8w88n8Y08SrrZT1A4u3TFA+BYVN6Qea+o+2c8NK0?=
 =?us-ascii?Q?8S80MSKu7y39Arl49j7NsynATWkqMu2H/4JBh2++2ubj/qQ8udghY4YUr2B7?=
 =?us-ascii?Q?ZlVKQu9cqzUBeaEOq2kSPoEQvohhNhfCIXF89gCM/XdhUd6h70S7EzavrInV?=
 =?us-ascii?Q?rSWLwXcovxT8XDmabcsSu4/0Y8Kr7OxMzl+31IDeq4xx+NStAz75YKNiTKA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e75ea47-f259-49df-c14e-08ddbd041f35
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 03:12:35.7257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8543

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Jul=
y 3, 2025 3:45 PM
>=20
> From: Mukesh Rathor <mrathor@linux.microsoft.com>
>=20
> The root partition only uses VMBus when running nested.
>=20
> When running on baremetal the Hyper-V PCI driver is not needed,
> so do not initialize it.
>=20
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index b4f29ee75848..4d25754dfe2f 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -4150,6 +4150,9 @@ static int __init init_hv_pci_drv(void)
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
>=20
> +	if (hv_root_partition() && !hv_nested)
> +		return -ENODEV;
> +
>  	ret =3D hv_pci_irqchip_init();
>  	if (ret)
>  		return ret;
> --
> 2.34.1

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


