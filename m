Return-Path: <linux-hyperv+bounces-1995-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8573B8A9BD5
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 15:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A876A1C2364C
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 13:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8411649B3;
	Thu, 18 Apr 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="F19z3Dz3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2034.outbound.protection.outlook.com [40.92.18.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E21649D5;
	Thu, 18 Apr 2024 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448614; cv=fail; b=Fd2i59q5ZpyabdTv83xzgg+bcUQq5jbmdHCpKA3TYeYWiQN9Tdp8HG2sVnqxa5PoH44VJPaO+tPQPAANvwy3CfkyaoPszAuA7Z/p/u651s7p2Sot+wrK/SHXp+euTVtSh9XFX0m0PVNbtS0z6DbAxDXoCGYMaiu/3VZdw9VfJdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448614; c=relaxed/simple;
	bh=HlJsfb/TlgIgxwOUp5wIz0J/YhQ5isvqMs5g6JX5R3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G36UaLlgNeDgBdFXvQ9lyGx2L/fzjOvVLwa7er6WSGCGyg29YP/dI44HRnzafjngltQpepWmyv74k5p4jHkcarQqZ9HurXsNQ/s/553F2BLX2fmmIopTVTVkTJe8raWh+651DW3vqBL9P74gLiruTTmuHWtLGkmHTdFivj3Rtdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=F19z3Dz3; arc=fail smtp.client-ip=40.92.18.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeOk5jKjsiaij1wpdLehAufmdvy9owVgfeIjLXhp1fYGSNSk9zWHu6Jgg1dHEVWx6EGWggwFrblX1I3oQ6fCMNNDe7lB1s5UlvBTwRbNTyoi0i8qSvPEUzFkP2NeQMuGEUcVCY5ebpmVhvgLE8d2e8pZ4nseJmk4K4jQq/acub4asZyAeZzqNokjDDARwSwIfPYpXVkFY3kKyc8Vbq4qsutXhOwVqq3OqqWh+/YC/MaDQlvuKGjKt1kAomuvQt2c5B8K6MwQtMd54N5bugZlgkA0DF8ske5YEjL37+PFzF/G0IwXdZuQ6ckoax8eFvyFipGlU1jQXrj9Egq+VDIL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hdT+BL+ygv9itSHI08CmEC/LpBZ9n3tHg4jp3A2+0c=;
 b=V1iIBH96zFZBr2ck8snGtHlZrmxaMuPjWbiKpzMYEI1IyJb5FpHevKcS9LVOGyhYaQnuqrEyjEoJsRUohRk8uZdrBPB3cK4RJSgTw3eqvfUHSaGpP++fZUSTyD0zbvaw2FwZWq8AoH7hBuCy63UBkjIyFnlh6iHCbWPsr6DlxbDq9pL/GUjsVuus8WeCiHn+cXktIQz+SdXDa2nB+3M0hJNS1vIJAX6e1T2DMI/p3pJdTazErXeMxr9osZyWMHavSLo6Y+FecZRrfB76NzDDn+JR3J5frcOqc1iDakdju5OqMH4W4GoHvGM+I9EFuwEh1g8vRWQLXl6uFRGqsmQUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hdT+BL+ygv9itSHI08CmEC/LpBZ9n3tHg4jp3A2+0c=;
 b=F19z3Dz3gcQHLUNTVf5vk3lhx/mnvwygs5wkUY9fgjwJzDozMRJkmCppJzV+8I9ZVZUTvacHNQwXdxeP+p/Cjto+GTg1JxOQWFtskr2YUF9hh32SsDeayo+s8YkwYYdR4FSsZawkVApvC+NBz4VuDuVN6JQ1KNBnLLN5w3PN9tS6LaGNg6tEAQ2FKV1b3SXLealKupnrtk4ho4OhwYOX0xusQpOLWMaX1vMOV7+9xv/6hd2n+GsT/gMEoHyFsFLBuzCtaEyyyvh6/GeZs/kAvpI2Uw2OazaJBAxL6m7MHFMYdP6DnIN36t4FKsIFOjY5ao88mwtptJbC3qB5WUfLCA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN4PR0201MB8840.namprd02.prod.outlook.com (2603:10b6:806:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 13:56:51 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 13:56:51 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jean Delvare <jdelvare@suse.de>, Michael Schierl <schierlm@gmx.de>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] firmware: dmi: Stop decoding on broken entry
Thread-Topic: [PATCH v2] firmware: dmi: Stop decoding on broken entry
Thread-Index: AQHakYvPrt/ylfUZoUy5VQ48m3QhGLFuDMKA
Date: Thu, 18 Apr 2024 13:56:51 +0000
Message-ID:
 <SN6PR02MB41578A69B87041B9EEFF983BD40E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240418142734.56e1db4b@endymion.delvare>
In-Reply-To: <20240418142734.56e1db4b@endymion.delvare>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [74kwStrky6nlzCZAGxbNYrNxrL1hxx4B]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN4PR0201MB8840:EE_
x-ms-office365-filtering-correlation-id: d811348e-5fd9-46f2-d208-08dc5faf65e4
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NUGHu5onA7av6ENJEtZLlGa6hhQdiEWMG8sDjBsgH9WbfcFxiuyS4Adg//U3L0ZPVjnh5Y7+gtTgvzS/3ClRt3qzkx4iWjo2X4DB8AXx/JW4DzcivJuTLm0aaiKMBgCo+FSi6Ks9ou18qResUPHoHyO9oHyL8QY+RsIaiGy8oooYbMLjB9EBhnurlZetS6gadjK2VnAis0OTaKkjIG7biQWgr3l8duWfeJSdzmncym1sykdF3s/iVsc9q+EubbriMLHfIQwHp3hI2zq1ZqkbZ7Z8n/WEMbHizG1VgLBfDavdSLqBilzzDdMt+pgTZgjSKII+y8FeFcp+98EZBChqJBDei1+qCZYTktoIPIKPlY9+QWJr58476pwnJ3v/QEZcKGqn0XWgu8PLSuERBg41obNSxgjmf0pV5d9QqL3kskS7wzIdiaRGJjdNIkCQGuGTqVRl/ZfWNCJHePZsTTlMTF4/bkG1p/eJRX2SJYjskCSW9TelFDwB0gDwngr+64fWKv8hELat5dCfs+QZF+MW+KGYZl2Bt9n0oNChY7/vUDoiR0p+rsxBEH6xpuJoEidZRyMNsYBV/aRIrucRF0nGDeEV3ip3h1Sb0POsfF3dmY/Qcg8hw3AQlamOkfN0JS/0IZRZHQFi9e+EgY1MoRa8nQb9yOUkYGOq6IP0u8Veu9w=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Gx0PIyryYMVcAmYLnWWIss4jnqJU/emBfDjbJUWeQ9dHHJ7wXhkufCAa9BCb?=
 =?us-ascii?Q?LKARJmHzkQgvGHMAnwICRcmv3hHeWkP6KBDfFFpA2LxAJyWL0b2EQClTd7ds?=
 =?us-ascii?Q?vClm15Qr16zhL+NMzNrY6i7QvPlvcBJoWIsOI3EQtO8vmfGfa09nF4j1d0Q7?=
 =?us-ascii?Q?3K4plgoWWFH6h3Yr0dvi9pEmXcIYPdJfIZWU3bDIFC6NZ2k0+MWWE46K6dBA?=
 =?us-ascii?Q?8tqxtR25hAKVD13h0gMpVVV4q8oxHHCWFFSUpMdPVpLuQTn6Gr88isbmpexk?=
 =?us-ascii?Q?HkXBvQjwYHMmlAdTJxxa5mQ9ojhPORGuQrN2JlopByCymf5R6OwfTku3P5NY?=
 =?us-ascii?Q?VKECW4fNpuiQoPBAdLbBznMAaVop/3mX1CczoGW12rY4Xf0Mkh64vVg0IvQb?=
 =?us-ascii?Q?406Vc2s4PTUmkm+oysHwYjHhMsFD+tdJYRgbwQN7bQiUvKMVXW8Dw3c7g2og?=
 =?us-ascii?Q?4FolEmi56xk74T1EWqg1nhNrP4EqbCR8wenS8D0s3WZuTdpv3tx6LrZJ45wy?=
 =?us-ascii?Q?QE+yvtF+ilmTc8PDVFY5MLWXLJqkylwxROvnaUrVldIrunQY5J8064fSl403?=
 =?us-ascii?Q?BF0dqOjKOaHpBKPM/MMrqGvz5aV4JHEAanENDNrPHTig5Ys69nMuw1UyaoMg?=
 =?us-ascii?Q?XhWGh3CjzvYad2hnRbMPq1yeAddjz1BI/3e6Hu6jPbNOAjIXliq6MmQQlwdI?=
 =?us-ascii?Q?cXiY5iPNQSaBtMi18tHbtxgRs4Vum344TP2Nld7pRMfIaBAa4QthtF9uAnWd?=
 =?us-ascii?Q?Rt/s9VdPqdnnjL6Na0HOb3jb2dndOfWrCG4U4suXke8QArUwHzFLOA2NLk+x?=
 =?us-ascii?Q?y2dhUJ44TxyGwdOH7qSVzK0xLvMdiPOkdiGmjAnOKstNw8ucLGcbmkxpy5Ss?=
 =?us-ascii?Q?EQ4Y7C5GMgvJdB+nwhDoZjFmmYm0c7jjkqDe5XwMQckE4dDfeIc3NpsBli84?=
 =?us-ascii?Q?7wGllP7FRxV0Qxm9V62oY98a3qk6zqyocKwtvEacPtTRWHkvF9rIVYMV8mkx?=
 =?us-ascii?Q?8omKqoe7ZX6Np1y4rmL7fGqV333BR2pQHZ+rmJd5ziugFG8h9+xImYOhfMKt?=
 =?us-ascii?Q?hqMIapEyVNBZlbNQHuepkybkIjhxt/g7P+x3T77U0967KkrTp1KoCju0hA5o?=
 =?us-ascii?Q?uEors6B7ZBV07owC2h57RcKBuWNmFI0hMYjGbKMVIt+xcq8+nzRShjvkXu/8?=
 =?us-ascii?Q?4X5LcYM3cuoxMnZME2NftGcIc9MId3WrIPrNdQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d811348e-5fd9-46f2-d208-08dc5faf65e4
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 13:56:51.2963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8840

From: Jean Delvare <jdelvare@suse.de> Sent: Thursday, April 18, 2024 5:28 A=
M
>=20
> If a DMI table entry is shorter than 4 bytes, it is invalid. Due to
> how DMI table parsing works, it is impossible to safely recover from
> such an error, so we have to stop decoding the table.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Reported-by: Michael Schierl <schierlm@gmx.de>
> Link: https://lore.kernel.org/linux-kernel/Zh2K3-HLXOesT_vZ@liuwe-devbox-=
debian-v2/T/
> Tested-by: Michael Schierl <schierlm@gmx.de>
> ---
> Changes since v1:
>  * Also log the offset of the corrupted entry (suggested by Michael Kelle=
y)
>=20
>  drivers/firmware/dmi_scan.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> --- linux-6.8.orig/drivers/firmware/dmi_scan.c
> +++ linux-6.8/drivers/firmware/dmi_scan.c
> @@ -102,6 +102,17 @@ static void dmi_decode_table(u8 *buf,
>  		const struct dmi_header *dm =3D (const struct dmi_header *)data;
>=20
>  		/*
> +		 * If a short entry is found (less than 4 bytes), not only it
> +		 * is invalid, but we cannot reliably locate the next entry.
> +		 */
> +		if (dm->length < sizeof(struct dmi_header)) {
> +			pr_warn(FW_BUG
> +				"Corrupted DMI table, offset %ld (only %d entries processed)\n",
> +				data - buf, i);
> +			break;
> +		}
> +
> +		/*
>  		 *  We want to know the total length (formatted area and
>  		 *  strings) before decoding to make sure we won't run off the
>  		 *  table in dmi_decode or dmi_string
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

