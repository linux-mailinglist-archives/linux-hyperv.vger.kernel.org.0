Return-Path: <linux-hyperv+bounces-6537-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C871B26F67
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Aug 2025 20:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D573AD10E
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Aug 2025 18:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E9F22B8D9;
	Thu, 14 Aug 2025 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LU/tSOUr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010010.outbound.protection.outlook.com [52.103.7.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EBE319855;
	Thu, 14 Aug 2025 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197846; cv=fail; b=MIeJ6nnKCPiz/cgDXon8lDMx+Pr9CT/xSmbxDoUyUh4Y80tJ0fLQlz2dUq3MPvoRRgrP6v+jo/oLI6XxiIdL0xFr2iOVDcxc7Ye2zY/qbzSFTXeawfptuTxHZValzBxcjE+p2lT9B/jwnkRxWjyFCO/sySTiYhPpjyKnt5RJ2W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197846; c=relaxed/simple;
	bh=RTaVdzeS5B3pdwp7IfTSSIsJndsGuUvLfzUc5I1Nl1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o/qQLdP8oJMsrRP2h7NZXw74wpyOLAnB2+Ii4SAhlMGEDGtdIVdWRDHdkNFpDftlxRuKXbmTUQ0X6mXhfQNN/md1DSI2QUD5tIQWfS6DoSiE5N8ppSh8UeDNbidAh1B0yAb3ScXaZJ6kiiiW8iDfSdBlQEMHH/kxYsos0ZEoxrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LU/tSOUr; arc=fail smtp.client-ip=52.103.7.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlF+WYTmNK9A9OdJROWkNUx3pORPKivsKtQfGktZm8y3L5R2vkEpVhc0OuFVMZZ4Nggjpicb/vq5r2M3A9toSZfpShlBOb6wto4fXXx4SvviD2rNofKIeVmVflYONVnxgd7PzitQkt+ZWKXj/410dT5r1uJ9vIetoLyXunpGIk8qEr90EgF5a1fKZrDbfruid++QKFQiCL6hgdUwmMVQCbKzhQSx4PJ5qwQBSnpgGo4AKbGgERW1r72Bx93xR9vFkYkPM30t6cykfRYCRNtwSKtah3IYuN66hTVPHvem0MUVFNMVZ/1YP6c7IA/pN80yTC+yZP7/FGoq5z/iG8NA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVAl5487S/oQdjln+jpaqc8W0+OtYnJzEG8CzZ95HBw=;
 b=s/02fB199YNfTc0MwAGRlOWmnPYIQ2NkgODhD795V4P4/idUuE7NkMwMgLqE4UDfRA0NTBgNthKx+msSAiLSBRI4jWwU4GPbcQGWMFF49FAW3xvMfiU4zQg0qmy+HH/2WmA3LxJj897qHPtk1XyTSq4PMp18Bd4bGb0TdeTfCzPE+/dfKPT2pThd6vg/K2jqUxMpBlRW6J83k3/sOMlH+WjNmpsF70QBV6eVpyTTS4decT90MWemyn3kMic6rxOKO1nGNmEMN2zaiaLi6bazvH07tS5EnjMVjyqXBWuJTzjTK0051XxBTcklQte0FwQxdO1oWz9gb3cwXlqUTCIbLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVAl5487S/oQdjln+jpaqc8W0+OtYnJzEG8CzZ95HBw=;
 b=LU/tSOUrLi1rcnWiQ/dIGABeF+MRTTGNM+eu3aWvTuNrkbINUMCojPJQgU6gc/Qh7eg6+mHd+n1/Anl9VeBlDYIYE213mnpxNha50tcS1dp76uGYI1/OsZVkj0O9DRpw/uQvwPOI6PvlXhfBgR9iY3dyjnl+pz8NLedXVmPoIS1+tSGeuKijG9TyuB4Yn5ram9wWZz724CkTPYjULOYiOreVguhj476TDczGpRTyH4PQonzrFxdmziHPKofAqldjVRGyMt3k2kUGy/GF61IHyDfFJVJmAsKvMr6/qEuARqtK6kLuhw04lUW9QJWHpTB20+YvPmnxk23zJjMEuiF9cQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9565.namprd02.prod.outlook.com (2603:10b6:930:71::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Thu, 14 Aug
 2025 18:57:22 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 18:57:22 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>
Subject: RE: [PATCH] hyperv: Add missing field to
 hv_output_map_device_interrupt
Thread-Topic: [PATCH] hyperv: Add missing field to
 hv_output_map_device_interrupt
Thread-Index: AQHcDH8HLgAqmBHbDkC3QPVdLVk9zrRifxMQ
Date: Thu, 14 Aug 2025 18:57:22 +0000
Message-ID:
 <SN6PR02MB4157B75073B1E6ACDB6405C1D435A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1755109257-6893-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1755109257-6893-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9565:EE_
x-ms-office365-filtering-correlation-id: 98a36184-88b2-4546-93c6-08dddb6466e5
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dc43FlQvP2yewYSt45NTkBZ+tb0QS5FOldQtgeyPyfJ5llnTbNhttW8p2uW2XsmJ9PSysLxdob79flyM9HuK472N/udME5CEpLozg9tReWafBXGnczF0GXL5uxM1DELj7HcoO2bsbm+X6DfNVYq2R56a7VDmoIO5GK53YY4hbWq7pi/rdEOM5Rhp8lF8NQEDSFRPZTu0btBdOg+KTRndYY6GQQDzdZl/Ip3X/YNuta+MsbHbpJ0BvmsgzUdgRx90/yaEqEeAfC1cuQzYuY03C1on1X2YL2CWnASgP0yKvxkiBuBgZQdYOTjyB+i4KYkOxwW4QHbpTrYeeNYCoGpTKC0ubGv8DgDHCi4c65YpoMPlqlkVS8G5ad3A++wVxlP2HJjTkJjI6YWXADKpYcjFAXhbjiwBXWdvfLkOyYarKMXXE7XWx2cijSnRtwUi9NSU+z0/KiXtU5+EaFmAJDIscOvPsspV9zSNQsHmxAsIyxpN222Uk2iM7IR3GVLsSVBjZ+7+oy8xlS2ypJQB3ZMh+BR/vfw5/6KB17qw0RkmTeW0+YF1vLwl43Nt4yhS2BcRB9m+Qp4kX/ZjTAV6XyM58roUOCxjiFEbclSu08KPCxhyA4yGNqSjhXUiYvVdcRgdwEMXYINEuUwdzNo41jst0QtP4shOFKyKQskuYZbZLVIOUfMLHT4jEBsevlfKWUUusouDNNVnxynq8h5zcfgkFXzL13+ZKhn4UPBAkSwOhDBlO5Tp45qJEDC
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|31061999003|13091999003|15080799012|19110799012|21061999006|8060799015|8062599012|440099028|3412199025|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3LsWAeWu1g6QW6Ss3ZMncndA9lC+DOwTi3b9PikrpJNwADoktLbe4GHStZB1?=
 =?us-ascii?Q?F3DIGUp1qMGQlmN1bbDEWtt4SEqSOr3F6pMT7mRjHTDkvh9jIOT8L1s6i8XM?=
 =?us-ascii?Q?4kQ0UJHKItgDunk+Xdr02oypQTBPYk0b++8Y85UGXzJ8f6gy7ItS9MEMAEZz?=
 =?us-ascii?Q?1OFuP8JV2Q014KfSocedOsp3G0zXvAbFdWj/DgpgOQSAn2DpMDiHT5cUxZev?=
 =?us-ascii?Q?1hpgxHaqavJMq6NwBC2WjUIDhTN8A3W4ckEqsqBC/yfKazDKDwiI4Og13dx+?=
 =?us-ascii?Q?Pl/IAWOxo8E6JS+3GnRakJFntCOZCseTCPFok04/RohGmtoO9rnqrUHhiI6X?=
 =?us-ascii?Q?O2U8nsaCWow8j/6oweuVCLpdsH2luc9pMGjBqZVnYdJ1sSUa2KZ+6rIUPpFy?=
 =?us-ascii?Q?nXrf3pD+W6qHpUu2dbzUEZpW67fR+ury37UjbfccrwcJh/i588AZqNvn8f3e?=
 =?us-ascii?Q?6dCfhFp56mJsVrXq8Sm9SfsJ3TFM7GDAAX3g/+qmSOFDLSxZOGaPiX6vM7Xb?=
 =?us-ascii?Q?REG4NWvouAKQKj2iHvYs+fBPjz2736BgHR/xEXjR3Ye95I2dKp4jBXqAfT+4?=
 =?us-ascii?Q?C06orbE+4sqRtY7NvNDG8yIa44qF8Ku3UXN6FHmHJxAtQCUfEmSec9QDvAQz?=
 =?us-ascii?Q?ZOCl/rb3th/zMLHnJnvE1gS5E/HQV3dnX8L2MzXnI7gdzK/I6WG7D3flqEgj?=
 =?us-ascii?Q?eE+yk0qgHLLgYMi1w9FaU4hcqKnKEEbkJ8mOQ02rMG8rQpYlL5NFkDurLxq/?=
 =?us-ascii?Q?n9geoD/SwpnsPD0YUpx9FgfxOXC6fpYBze0rfsdpvf8JkcstQFsjGPGq04Re?=
 =?us-ascii?Q?cnRgkz6kZYeAVdsJsJU5LQT7Q7OE5rM9LmZ/PFve7Y25LCSlrEb8CoYCa8ic?=
 =?us-ascii?Q?+S9yPUO9oD2FQ9b+xsDhoCDGGtLQ3oOMzhIuf6J4R/Rl7WLvE2HOoohnQkCf?=
 =?us-ascii?Q?RbPT88qp5WAIR1lokg+BXnDQz+qbzv8IOF0XSZEVP5u8f7m9uWTyICF9OdFh?=
 =?us-ascii?Q?bRrfbkpBwXCfP+qGGPE7wR5BxgpYmgVllq6OHtxlTjd+P8Jd6KsA8ymWSgc1?=
 =?us-ascii?Q?8D9Sc1+UM3ddqGJm0DrqzFgMOFNgm21Owa0WGDb76acaOZ2coZL4XI/JhJT6?=
 =?us-ascii?Q?Skus8KiSs3IcNWWeorDpElE1IKBUYgeDLeJrfV5bJyZRiWgnsR+cQb9hk+Az?=
 =?us-ascii?Q?S0Gz1JDn4cSKRdeMH6sDPnEVJy+KduCIiGJXFw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Pj7eW+ENoBnQsiNdyXz32afmg2Mggk22TSaW519ZBXG0gqSlkVw8WtTwtS4L?=
 =?us-ascii?Q?iETD68zf3WEHBPVzpgCO+eEwxdL6vk/73VFqiUazqU8PlcNwIvSqvJY0k7Zo?=
 =?us-ascii?Q?AlbMBZxa1d/WPRS48/yLEdOlc+j7xy8iClSa87EiEUiUBSZDh931Nda963kM?=
 =?us-ascii?Q?ATCICKfiA/ZNMynGT0l8EL9CX2DPFGFf+BVlyrXB5fA9x7+wdGa2dgjKRspo?=
 =?us-ascii?Q?MzrgStogEWv70ZeLTa+vtyuO1qHP1Nt98ABvDu1WUdbUKnAz3Fobs1U4qljL?=
 =?us-ascii?Q?d6FVbOvEAtBH59qrhqRtuuAJ3qBHlbSV08ML2/0GwLRXo7dTm7K12rY6rYBX?=
 =?us-ascii?Q?7Owqe4/f28s8Y6Hjc23LmJNbLDB5H0gYvxXOaLKWUdLx+2dUfYa31+oEiTI6?=
 =?us-ascii?Q?RD1OhKTdeHSkN+3wAB21+ANckNVO8Nxi/+B6gdurX2wEIQDMxnDRBniJBXCY?=
 =?us-ascii?Q?p7L3Ab3AD3F742PNZjxE3FONgM6CjztYcmA9ZdwB2cgRLi0KiiNtupAYU8KW?=
 =?us-ascii?Q?RDivt2JqigaqcbK8+KAFFbSRzmXstcR7c+AtPBdiqzlBGLyAyWaU7jZVE2q3?=
 =?us-ascii?Q?H72g9mPG5r7A+do0J1ndvjh+rswkrW36hZSfDOUtY+Pk8MsjDvZZCFXjqkGb?=
 =?us-ascii?Q?0s1nj1IEQiU+px5sVkB62qcbAaEBW0XQwZc3Ez4grd3wT0EXKuRfgMbQ0+uc?=
 =?us-ascii?Q?3XpBDY7G5yOcjiXx57T2NthkQI5FYu3Nw5fGVYiI9cYkNi8XB1RMBjVIZMGV?=
 =?us-ascii?Q?YyNFH8RmlKLKymfbbbZpFw2beVhdipWjUByBT0uyoHlKEDmp1eSEe4cQMXjP?=
 =?us-ascii?Q?klsi5/HkxTgOerb4C6F8GEyHRxWM/pugOKPzncXDQuxDJCi4RJdOI49HHSik?=
 =?us-ascii?Q?J9gw4+2ytBM049NpF7HIgs8uD0yDsiAR9HF8y8FHnI4KpKGfyQ/R5ZCsqYMN?=
 =?us-ascii?Q?hHDG9vI41k6qgOfOHE5Zrc0HeJG/CEGSMVkBW08f29HAJiq7iHJg6iRj0asM?=
 =?us-ascii?Q?fxnqMcbqqzjR8csPYPvIwRGIopXeWkpVkyzCRMSvxAA2rl51B0eMlLWQWhnc?=
 =?us-ascii?Q?FRx6RmWNw+/3QJ/iSDFxZtFN3H/H1eMdLi1TTT+3iFy2kmOKD4XSXKkZHNiI?=
 =?us-ascii?Q?i28NJxkPzazD7ccOh0wK2uFfBvsiDDP1BjAqJOD4Ua7s6ffLQPmx40TbRNaP?=
 =?us-ascii?Q?pkGKJMtD/YxhpnT86JysTnz2azajAS8c6kEF8jv4djKvb942Ka2A0CaHQGQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a36184-88b2-4546-93c6-08dddb6466e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 18:57:22.5393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9565

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Au=
gust 13, 2025 11:21 AM
>=20
> This field is unused, but the correct structure size is needed
> when computing the amount of space for the output argument to
> reside, so that it does not cross a page boundary.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  include/hyperv/hvhdk_mini.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 42e7876455b5..858f6a3925b3 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -301,6 +301,7 @@ struct hv_input_map_device_interrupt {
>  /* HV_OUTPUT_MAP_DEVICE_INTERRUPT */
>  struct hv_output_map_device_interrupt {
>  	struct hv_interrupt_entry interrupt_entry;
> +	u64 ext_status_deprecated[5];

Your email identifying the problem said that without this
change, struct hv_output_map_device_interrupt is 0x10
bytes in size, which matches what I calculate from the definition.
This change adds 0x28 bytes, making the struct size now 0x38
bytes. But your other email said Hyper-V expects the size to be
0x58 bytes. Is array size "5" correct, or is there some other
cause of the discrepancy?

Michael

>  } __packed;
>=20
>  /* HV_INPUT_UNMAP_DEVICE_INTERRUPT */
> --
> 2.34.1



