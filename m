Return-Path: <linux-hyperv+bounces-2678-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4AA9460D2
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 17:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9441F21780
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C37413633D;
	Fri,  2 Aug 2024 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WkinlYf9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012058.outbound.protection.outlook.com [52.103.2.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF68175D4B;
	Fri,  2 Aug 2024 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613902; cv=fail; b=AfhLy8MOkMlOD4RKvRidTB4JSY4JIL/MffO05JftsFZyJLRvCvbyyNVvlyLwV5k2wzcXOg78qSSJWIPDkfnb1iWwTozNVix+na5q3J4MKNuEseXOQgrWRCLBA0ADBK4/j3M+O/OSRuVIwgOnlSsvzJxDDUNkPqzUSf8vgxtZWO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613902; c=relaxed/simple;
	bh=JJnND6f0MZpNQPgtmCtDmxRJYyJqDJPmAtYc6fU9kVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qeGFXAofOUAxNJF5x47a5MN9qeC2XskdtLRP4XwBlYUe1X+Qv3klG/2h//OnvFd3UCoNMbh3GQycgv5tHoc7A3YudxsqmfwuRNVaFffGat6H8tJ4mumUkF2WouZPJOebc+F6QMRj1pGz/KUtxhi82xZ3OpmaQ+UTW9htuTPs1p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WkinlYf9; arc=fail smtp.client-ip=52.103.2.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzA7YUpU4/erDv/yVXxPr8ZkdfMkK/+pzzgy9bBx/l1MH/cepDq6p9xS1BZA//I9vEfxTcdCAdhzzluHAKX5S9wsfcbNKD7yUWJAeuRdBLMj9/jEExEigwuyFy2tsO+zPKolE3MRT0ySniHHL9l0LJifAw3d8fYee84QRD3+6AqVEZSO+1OPwbjpSAv/aaoFv1Y3pjN2f5kPA9ULmoxsSfk9hJmiTxZbqPguXwFByw5FcZfQXgvjTdp/wcd9Fmu/6ofU7XasBpFJAty4RSd0ARWid3quX2ijDOQD/jlng5PJRCNgk0wFzG+LYqBMYT+G4B9fjpgPo1lxrnkakaPDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yUAgkvu6oh76BlpCh485DyRfTVbWnCAb9jhsoDtJs8=;
 b=S8oSCB+8ukV6voxlC8az9s1jJecuGUpzW5PGaXSM4+seud9/loOW9unt2qZKjA7bZ+41PBpQnxYkGpYWO/WoWVO7PGR0ZkDVrHQOvZqjNca3C8l3u/9QYyuYOjBHaoAYJqbKHqFCZjiMJAGW0aeQnZ4IRqdEnX+mvaPtEc8ca2hRXUltjddMrXzTLzL+ceFQ3UdWwoRHpdKUaOUqHiXIJhvRa9W2BSf6vWKu/JRFe48dwuKdOhqluxpf/oQiMhZ8d6CRXdxvu2kaxjLpFdYWMFN9ba7vVZ8330Gi+55X2kpQpR4K1mcWboP/WrmzFQAVHnYkgcW+9LU95K60+uFhNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yUAgkvu6oh76BlpCh485DyRfTVbWnCAb9jhsoDtJs8=;
 b=WkinlYf914laRxegcKpGaLDnId7yjRSv2e4bkaPwJ6GNmSC6X9qnnraJeQAhVOtFgjrePl/W7f4SvdDc4vW5SIczOWs++BwMCYRHdYOnNf3R+mgVHDLBqfbisCkG7qz7e6gn0rvDNrSMNhVVm1Cd6QhQ0FbKhmilNvaylDa0F63tUb9e009oKBtiqF/2yXaDiqqKdI7NiVrxOJ30rppPTRNb3qjuH1RTHqslssPcO8U0u2+hYeWms8hC5g9bVUCCqWyA2sfXMe+lm0x2HXMCP230G5TDA0NifCi9FUG8fDVDktfklI69vclODgbiS51xHd5ysttSifVuWxtUjrL7BA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6746.namprd02.prod.outlook.com (2603:10b6:5:21b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 15:51:37 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7807.026; Fri, 2 Aug 2024
 15:51:37 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>, "vdso@hexbites.dev"
	<vdso@hexbites.dev>
Subject: RE: [PATCH] Drivers: hv: vmbus: Fix the misplaced function
 description
Thread-Topic: [PATCH] Drivers: hv: vmbus: Fix the misplaced function
 description
Thread-Index: AQHa5Fj6+TFH9+m9l0yyVWb3YLIZnbIUHp3Q
Date: Fri, 2 Aug 2024 15:51:37 +0000
Message-ID:
 <SN6PR02MB41578B75E804B59A2B8A8E24D4B32@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240801212235.352220-1-romank@linux.microsoft.com>
In-Reply-To: <20240801212235.352220-1-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [Dy3VIgNr+b8YY5Bh2znBKnL6ec3hc3oN]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6746:EE_
x-ms-office365-filtering-correlation-id: d822c43c-8880-482d-ebd5-08dcb30afe39
x-ms-exchange-slblob-mailprops:
 dx7TrgQSB6elLiMRHB5H6rzWn7vhF1Vne5y3Ey0KLFZSBGqKHqgGIJR1dS4mQMp2fTQhmhvpuqMIziOB4ItfxHuRqVaq2Ih7HDNUp3Nyd7vk/zhzKwzFEfFNKPNehYPI57XWmY99lJemg5uElo2uPrtmwiuuO6cg0PcNmVL8TenFkBzlPlxOBaEwE0v6YTqLg7gDy/+o3TftSWEv2KH2DtMoOXOJZFrZhwi3FQbkxWjHSsIVf0W9QqOHSxs/sBsAHvfnsnpa6+fs3nk8pfLa6hjF9N8LIRtJ2Qhp6FwitTkR9aHZ6Wk34BKsh9/7OQdUizxu03nmeUBM66Zm9EhPt51RH6uWNBCXRW8qTrx6qFSv+TDF9t2K8t7UIx/tRdRdKsonMEzXm8ONubheS73utNFdP46kSAXNP4PjkVmEoEea62TviveUuuDWQ6X9eO9/hfneFTK2sru8mCfESGaWmttDln4nbXcP3Wxu8NzS8YX4b++8e9IBn34ycB8RuuM3F4MyCRJNjVR/Yi4nMt5GWTBK1PAlwBKDNnprhF9ADUY7YJGMuncP9aEtNjkwiUpcXYV2aaArJayvegL+Lmmdz2W9ybEGfQ7tcQ0NdDaU0T0X8QH7qdDQhsXhmVB7uLCIOujCBm5ZlMBaF6s5duvFYUKU/oD07LPSRMbKko9Cb1nvCw7z+GxtHsxyxWJ3STfVOOlcby9WhCEuZxi2pd8nnHNmRzMTQDhJuYXItVRq0ho/zfJ1b5UAPQWajBL+EgRCLRCpfR/4s9I=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 U4VRc1vItczOU6EO/WjX9ddX6/SstFjTy3uzotZxomMor5PDtUWF5D7v88mwgQcqZTZdOSnSZ6RYMcqhw5Vw1aTq8UoGMoCZFRHq6yBb07Sj/NmNlq2VLvnb7hHBkBUmp3MXGHW5xjb9ehpJinZdXnGiOb4o4+1sMCcHkso/zEt/29dIacpWk31k5SQwCVeIzVYsUtGL05g6WtSuLRUIlDFo1yssjRFbo4y/40QBvodvgHvj8cHYAEm+XBD3BVBrN39MijwVO0KhEteVyAeKkvpBq+V1SlOzaHLo+LxQd7kPSu+ANvrQr3x6CZFB0a4KQpXarRYzqXkTbSBJQxRYsHBOPFDiTlLck+YkQbqXvZ162QUFY/jYsmJ37MhwKpNWruXhwqtzCwUDKD7safDZzDM71DKkKZZ32RShrdQYVEKEr//rDlXuntk8Pc6AvhOfhcuQrt0sefkmGNTK/F7RxAn+ea5wt8vOrIsuEuf2qg4ZT4JWvbu+VTracsQj9mfrtFDvvjQ12Dqh7ONSHHX29rFc0IPbusB0TEdikazcrJ/x1Xvq9vRA30qSxZ3iEPCrR84ANszTrFPIzK5VU1WMlaMdoA2PJwV5yheaVzJPIRTn3A1WIbbm5hZqaWzDOr+P6lW1juRjbc7ID3U2x82X7Q==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gKRJBIxZXG1eC1f5ciAO5J0jfu4hhFmeyxSL81UjGIZzchy5azp4wxkABg2m?=
 =?us-ascii?Q?rQjqleF33eTIWXJ49nxMkelmbRKKiYGXCTINLwAVv5oY948UNCl0NhTl80zg?=
 =?us-ascii?Q?QXLWoNHpqw6NoaNmOE8Dd7wNLH7QTA3CztAeYs6mKatMG64EQwPbhhB4o2xD?=
 =?us-ascii?Q?xdz7ltfT+zj82lxccBwNIjBHdcns/C0qXJBzQQsoVZ5Y7HC7kisI8lvDNrL0?=
 =?us-ascii?Q?XUdJ11yWqgzc158QzygYcaCFcmvOLLsWrYrC7Cp2fnUi/brd6BJAM4gam9p5?=
 =?us-ascii?Q?KoBQEMqe24PgI3Lmw/xdL3MhGc8gVbPiZ1NFPwQdbe1P+ZmFz0QF3EHTPqFq?=
 =?us-ascii?Q?vudKQtJ7HRGxkHhaaUhuWRx2O6Vt8UGT6Ov2cE1yM7J60EGQuaaSlsazKypt?=
 =?us-ascii?Q?733UIf7z+yeqL7MndKWcGic3yuap0Xmo5BelbyhZG2LkpRXUUVbnIraZFSnT?=
 =?us-ascii?Q?G7Nq0caBd7udhJuBxwYZ0XMq40tFN50zsjUmdFkdz4zC1UEYwoRIjuTNk9sS?=
 =?us-ascii?Q?IJRlNltkutXsZd5ej1fq2YMp3CQ1Tgwmmsd2mXP2kTDbh0vFqzYXw3BVeD3T?=
 =?us-ascii?Q?iZ1L2+8/HuYVMn90JTBU0bq27dZAuHWJg7GsQa74dMsC1JqaKtp4q8FnGTUB?=
 =?us-ascii?Q?sGnVbtM/jLw4gprxYf/ZxkGbo7fgFo0roKhvPOvVO9dQy3/+iFa7j3rVED7w?=
 =?us-ascii?Q?RPf5my/Go7y5bBectYEZsoiShjgfknjU3JsiTzwdl2ug4zXTPSxQ71pOREmw?=
 =?us-ascii?Q?sBBARsu/Ea9iEAqeC4P7Ids19bKu0b1DKmzeUs1ghclC2ELNt5drWJC37EWL?=
 =?us-ascii?Q?zDvm6QJVoVxav9+2UgiOTuHxiTeCaE1AqVNjUrx6JNmW9116MGn5C6cto5M3?=
 =?us-ascii?Q?O8zwdSdRiz1JG9Kogg1rySq4fHTKRdvoNsURUXlsbTnQRpNSUbfterKV/BKe?=
 =?us-ascii?Q?v1GgtR1CQ81AbkwGrcGbEzKgzSiMmvKPxLJwsrfz/d8hxOhMHcig+6liFsvF?=
 =?us-ascii?Q?tyvxNmLv8wQ8lV+iMVvR532pJ+RExccBXlXde026mWpHXPsrLSoTZ7GyuF8l?=
 =?us-ascii?Q?pXcu52aB09Q9fIGO3QqLmr2a0Wr2vdJpjCzrj2aFPB4rll2BHtG3OByt2SMh?=
 =?us-ascii?Q?0z6d97MA7xFS7O1LPG6PArfSlAn2rOBDxPu9uhlPRS4rzll77ymsnn3xcszD?=
 =?us-ascii?Q?XolQ5jPx+OnCJP3QoU/Nv4qgjzNwUYwnP9HIIJ6iXKOn+zy24iVVCzv3ZFM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d822c43c-8880-482d-ebd5-08dcb30afe39
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 15:51:37.5919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6746

From: Roman Kisel <romank@linux.microsoft.com> Sent: Thursday, August 1, 20=
24 2:23 PM
>=20
> When hv_synic_disable_regs was introduced, it received the description
> of hv_synic_cleanup. Fix that.
>=20
> Fixes: dba61cda3046 ("Drivers: hv: vmbus: Break out synic enable and disa=
ble
> operations")
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/hv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index e0d676c74f14..36d9ba097ff5 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -342,9 +342,6 @@ int hv_synic_init(unsigned int cpu)
>  	return 0;
>  }
>=20
> -/*
> - * hv_synic_cleanup - Cleanup routine for hv_synic_init().
> - */
>  void hv_synic_disable_regs(unsigned int cpu)
>  {
>  	struct hv_per_cpu_context *hv_cpu =3D
> @@ -436,6 +433,9 @@ static bool hv_synic_event_pending(void)
>  	return pending;
>  }
>=20
> +/*
> + * hv_synic_cleanup - Cleanup routine for hv_synic_init().
> + */
>  int hv_synic_cleanup(unsigned int cpu)
>  {
>  	struct vmbus_channel *channel, *sc;
>=20
> base-commit: 831bcbcead6668ebf20b64fdb27518f1362ace3a
> --
> 2.34.1
>=20

Reviewed-by: Michael Kelley <mhkelley@outlook.com>

