Return-Path: <linux-hyperv+bounces-6435-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF56DB150EE
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 18:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523F0174A79
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 16:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFDB298CA2;
	Tue, 29 Jul 2025 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UTyCFXGg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2031.outbound.protection.outlook.com [40.92.22.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C052222A3;
	Tue, 29 Jul 2025 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805290; cv=fail; b=SFAd3j8OgIjVNKBQ3xxd9Unrp/UjYdIzBVvhesF4JjoNEyFzQ1fhzd5C8a9XchhLc9wpstx+TyEXikzfjlDhzFdxVXcPSQHTeI+1niCLJToaliozlOv8fVJvjwZacRZ1V0VVfM3DD1yD8cq9KEXN0C6jsSwFGOq+4GhdcdF9kw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805290; c=relaxed/simple;
	bh=xRxOIbpHb38qmtg64soQ3InbDo4b3Q93PZdcxvJO/T4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DL5/65QiTgsvDpbfVYNAiP/zzSopJjDVzc5geAH8iFcDUW6GRItGbLsqUmDcAeqp6VRXw6rLFJIMMI+S5Nm/3/q2CV143huqqz5U7W1Hgt8OvVsQDQSaUtobYEpuHzN+wQRWzJZvUMYHDYkuyMczF3N4ufXGEwx1IOAARCZcJcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UTyCFXGg; arc=fail smtp.client-ip=40.92.22.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aglnApMmZWhIu4+WfEfkKDXjgq8hE7JwWDqYBcYq/uqbMSp7FO2mvUjzW7udQwtdlF6lcOt1OhJgZbts6l3pyxK3Dm53Fd80h/mquxt2KM6sWnc/SL6HwvhJm2OzJaIAat9tzmO2zY9wXb/S4iNsWrmcgaXNkO3YlMYiN0xCu3PubzUaIsTI/5OZfln2+c4NRwe5ur+/VCGygmWFZf7yeiqad+HQhfK0Ja0sDdJiw7ElPkJfB7ZviGg2xEw2/ozoJ+PZmc91pOFe06GBtpF2k8eDMzQOSm+uQz+nZnimug4FoJXM6NhOYvuWgpXa4JJK+3Wg/nQBeR+fKxg+JcMnNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akojdZxtkSBoEdTSTJ0sS1Goypw1DS3lY7MKwi+7I6c=;
 b=A4yhPbGQ54ulzaZLyLIKxfSOoy/S9p8iAmS0fKvjXNjJ/nQCvMj0vs3pouCGMewU02Z5JqhVCZaMmNE+q+U4WBU8pXvYTYNot/PDvrftngz0G4cO9EyoK9kWFA3LjrJpZu0cZSHjzQJsusOIB6iMOxOuNtJ+kjlicFDtYzyd78wiMvDGQCjBa0gKgJwJC4g0FYhGg6a3EHQvqX4iVFo2bvF9Bes5S379/b9hAzadeZL58PxOlZb2PbGm/bF8TZc50xyl6xRDx2Wb9PusPEnfmQAuSJmEioyTDhCunnIyLk56J1f6SpfJyUaFjuXHBcbqYNsChImaqWVFMv4PnnZh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akojdZxtkSBoEdTSTJ0sS1Goypw1DS3lY7MKwi+7I6c=;
 b=UTyCFXGguQTaUQuGttlrgwD40smepy2dI4Uf+CAaVTln4ORvR3k+BOiKJE+dpmbuvDpeH7b92giZ6P+rU0UlVTqHFB3nXRxjMFbcHwadkbcqYtxDjstQR40tYSGuu8bgFDLkqW8qzy22n3ulFMn4BZr8gkrv1zk3i7d87NBca+zI6xAtTOyV7qwqzI1Zs3fZe4pHYQFmknrWPWNbHRnZ63OoNdhK7Ovwa+eVXWeQzbZvDXjOOTZlhMGon9aN7ga+XqsHB/MysIpvwQlw4mcttxaVrtDpV9HpVpryB56nqpjKLoZoKtPL6O2CsApvodEnXgA76P7kuqzdwYDXZy6WJA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7606.namprd02.prod.outlook.com (2603:10b6:510:5c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 16:08:06 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 16:08:06 +0000
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
Subject: RE: [PATCH v7 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [PATCH v7 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Index: AQHcAEe7BCycNzS65EWgBS558cVtR7RJRO7w
Date: Tue, 29 Jul 2025 16:08:06 +0000
Message-ID:
 <SN6PR02MB41576C39BA1977F0BBA406F4D425A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250729051436.190703-1-namjain@linux.microsoft.com>
 <20250729051436.190703-3-namjain@linux.microsoft.com>
In-Reply-To: <20250729051436.190703-3-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7606:EE_
x-ms-office365-filtering-correlation-id: 39ce7378-de7f-42b5-3898-08ddceba1aac
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|8062599012|41001999006|461199028|15080799012|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HaCtrUZOhEe/RflS9b7LgSDBRdQpj+t4Gj9WktrCyo7RPqjWv5pO7vAnaLo1?=
 =?us-ascii?Q?79DRUi7JZhhmL5NsMSHQz/MAzavEXNeDq9ICSLDf0TCnBfENwCtfDX5kKMOr?=
 =?us-ascii?Q?Y4b7L4Wcxo8CaB7G/yqugMOIBNvRo9ueVzJBPEyyKP0MycbGBMF1LzPUuFj2?=
 =?us-ascii?Q?kzHvNlBukruuDNPbhWpnIVj+GWtsBvO+MFAzLJWcrZqVlkD/wkL1zquIc+Yk?=
 =?us-ascii?Q?qQ6ILt6gEg5r/sY2ZTkCoKf8wBjf24oROOc3QDOqYjN94oB6lrW/hBIew1i/?=
 =?us-ascii?Q?pzlzkGen+YA+XWfVMNVJk2ggvSzwsmQ43V9Dn4lU+W77ZLblFWcDkWew1/+l?=
 =?us-ascii?Q?hFJNXAaR65VbpwX1ElRHmxz6IW3B6K5P/h7r5WHlx8gggmdOTKNwsw4fjF62?=
 =?us-ascii?Q?t1NaQdlGDK/Yete3FMPmr6Mvjz1/yPf/6qmX2L9lnXkl8w0A2o9SNuLyFrLF?=
 =?us-ascii?Q?WF+3h9hTaAg6ktV3r4axnHar1Zt5BlIpnsWiesRYAqqHrRBXHE4q5pND6IwH?=
 =?us-ascii?Q?GYmAU05gFFXXzCn+mx0Up/uenRym5FhGc9bowPDGez2eVuUqRoULAiPLGRIu?=
 =?us-ascii?Q?Q/KI9IrxwLCU3Cu1ZmFQAlyFT+3fc0XUPU/ueWy+UGiAKIL27ChmTUXRnku0?=
 =?us-ascii?Q?xHj3QEHmITFZHYTG9hqjhRDcDmCWUCbqvTfv8F2IsOoViNwrLGv+NGIodFo0?=
 =?us-ascii?Q?U5bpwZF/THu0ygnhRlkKcPclbYPzsWkcyJIk85g0ByRB4nqeo1uCY3kgzmDw?=
 =?us-ascii?Q?0SoG8vQLM/vfAUO3xbbMd7FZW7OyNhm2U5QvNuD7tX7zsWDtq+IcmAUqrGd3?=
 =?us-ascii?Q?Brd8VxCnKTqagTYaZalgf1poNEXcI3JShvUNx5sp7hJA7WIBdiODVYtPCKgR?=
 =?us-ascii?Q?EkzGORZTotMkxuyoSNuHIoe1GF3GalpUAt+4ahoyNYhOY2hgsRs4TYbbdNa3?=
 =?us-ascii?Q?Y7PGPzZcqdIU4X875RVL0np6PiFNLFY7+KcQcvbuHNXfAxewbwEaVFjcdULg?=
 =?us-ascii?Q?ijq3WdJ3CCAlRsCy2SLZZ2dCBY4r2UWs2xaJKuWseGX5jdhS/ZK0oVSfPyGx?=
 =?us-ascii?Q?f6mvoasQP5updID8Ye+h8kGGW7M9sUQlupXPZQwe0l8URtgJundkmuF9/m60?=
 =?us-ascii?Q?hjaWvwU1XR66aGXuFLTCAOd8MGbyo89whw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kI2TWSKd3U8iWr6zGaUWR38uMtKGfuq9OnzlZRtv8CpscCNbMVODK6gY1Nn9?=
 =?us-ascii?Q?RHvXhoNG5xCWbrKM/hr9q5Dg6k0QT+31NAa46MDbmfehygvo0g1JASC4X76t?=
 =?us-ascii?Q?UaTxLonTRfOIoWikMQV3SMwTJUSMtwumKcexe/OqHiCObIPWzgZp2sx8uZ/Z?=
 =?us-ascii?Q?koa+jYD+ycb7/qmzPMZQ55xR1TSxoz6bMmoxLVNOaMmJ1Gu7Dree8fzhILMf?=
 =?us-ascii?Q?sdARfPOxmnVTyEDixO3afH4ka7MnXNtASQ81L5IAut96TIMy/xFVDr8OLMEk?=
 =?us-ascii?Q?Fgo69g4X34p396EIyMTybt2qSjaBySngZ1Ebwx6pFFYG76QgdGLWX/TLI2uW?=
 =?us-ascii?Q?5QEUAGIn5ztP6i8aWO9mKMlOSrY/MqBQPz465rAEAFgx+AwjOy7MjxRRojek?=
 =?us-ascii?Q?et7W0XNaDOnVMjCo92dJZU6whdDD7AF925MCkV/NjOTFHiVbakJ+27FI9qo/?=
 =?us-ascii?Q?g8uCMcEuCAEPXfQRI7Q7toywyzc3eMhLuh9JP9n6LaL/SyWOWcq9C1az4x1G?=
 =?us-ascii?Q?cA6xwQHpJmDC+nd0usduPInqhgnck0BKXpSR1hGcb3Fa8OU3NINs/c5rsdJ0?=
 =?us-ascii?Q?FdhErZ7iRFbets1Pf/cF6eCZTCdu/HgXkYv+0A7un4TmauTEvhQ+nIcmx93c?=
 =?us-ascii?Q?/5toVWom3HYnBK69QBbM09dHo0E7aXxcpGoie98Nk0PYs5FL50l6Rei7b0LK?=
 =?us-ascii?Q?uWq2F7mKS/cW//vf86ujYJGxThfg5sErD7KLoFKuZ4F2D11wqS+LlcDyfLC/?=
 =?us-ascii?Q?qGm8a61K15Q3dgAsNX/OxkPDeAPC3z5uZa6eUdyKia7tlcz/U+fEFJhocQ5c?=
 =?us-ascii?Q?cXS9SXGz0F3xnRM7xYv+ui9DsUN6hKEbxPzfTJMjuQCffwSLVX10EmKr7Dnz?=
 =?us-ascii?Q?n1FmAIMSbiW3+v05cYAO41rLm7CFysnA3iez/hE+PPlQS1F8iSDQldDO9S9O?=
 =?us-ascii?Q?mLkiKUqQlq5upm9WK7G04N0aPI3OJoBfExoGmFRxj/L4Jj5k1jrlMPBeYopS?=
 =?us-ascii?Q?vePzJncUUQ3kCmmjZKymgsklVXoeMxSPRbHNnqM3+fhNW3beyCVh8QEHgP8t?=
 =?us-ascii?Q?O1csc2ZDlWxfJVLCjejkndJF7YLbfSzcRAJ44H1KFLze9vHIa23+tJ72a73r?=
 =?us-ascii?Q?ybL3R/8vXaGIvJMG7RKh9tgGwCyuKFFhy5jgmywDmshk/VWd8D1Zkn3kw/oS?=
 =?us-ascii?Q?hSXoUxcNgfV70hkz6nSZ+iHwCkdvz/f8szUgVRzWSr2vJtGk0XjaF8ZJlp8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ce7378-de7f-42b5-3898-08ddceba1aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 16:08:06.2813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7606

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, July 28, 2025 =
10:15 PM
>=20
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
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig          |   22 +
>  drivers/hv/Makefile         |    7 +-
>  drivers/hv/mshv_vtl.h       |   52 ++
>  drivers/hv/mshv_vtl_main.c  | 1468 +++++++++++++++++++++++++++++++++++
>  include/hyperv/hvgdk_mini.h |  106 +++
>  include/uapi/linux/mshv.h   |   80 ++
>  6 files changed, 1734 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/hv/mshv_vtl.h
>  create mode 100644 drivers/hv/mshv_vtl_main.c
>=20

Looks good!

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

