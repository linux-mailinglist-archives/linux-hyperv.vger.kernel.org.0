Return-Path: <linux-hyperv+bounces-6861-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F092B566C4
	for <lists+linux-hyperv@lfdr.de>; Sun, 14 Sep 2025 06:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8B4421803
	for <lists+linux-hyperv@lfdr.de>; Sun, 14 Sep 2025 04:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BA41EEA54;
	Sun, 14 Sep 2025 04:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="G0NZ40oy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012017.outbound.protection.outlook.com [52.103.11.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A51DE8A4;
	Sun, 14 Sep 2025 04:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757824043; cv=fail; b=qV4CYqFCFYafRPcKm0GuVXTh0ze/9CMDKPcFqpRMr+6cLIkAi6sniDACPhA7ZrVenupWeB8zec0HZSJoyPE/pl036a2qtyemdL85fmqXpLgShXv+D5p0LwO43qNh68OWajZAPwqESwXfTk/QGhsKQRPVEg1hj1SIlQsCJGjylHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757824043; c=relaxed/simple;
	bh=di5njWA+mNNJBZpwCbYirwJy3dNY7oaf96jg/Gv0l5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NXeLGqMmhv0fkm9klJJ6dSMHVhX11O6hezez9q2TWUdAUI86PLx/hltLGJJuoD6eH/FyhCTcJTYfeCoTj4rbwq2qQ9D7M4tJAcQABW1j9xsI4QC30NFMGNJKclAkGgwtr9gUfYPe1EoaD3NwZ4X97hVjpm7WJnUArS18XqMPlqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=G0NZ40oy; arc=fail smtp.client-ip=52.103.11.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjQ1Brt0LRDlLgGg9NvuTkuxjPSIuJvLp3i40mslbr03yQGOSYZPYLUBUgh1g58Rp7tkRpLmzWl/AbixwlUvQ05MwIt4b3Qm8Re49g7kBcJ3LZ78Tbgi0r4PAhlxtM9AMSDYlkdgBzrFvs6rNTu/X6QNTrzkwKsnRN0WAJT1lJ9uATyz0a1rAxJR5SXvrsAH3nLVvuYIJ7kUVyaYKFg408Sw7BHYWzeKVGQguYYNKJAfhkNXQjcXlFSyqz3HtsS+FLcjex9hn4pRGMNzplGndIxHWfMxVOQF2Yv3bnIV4VkoFZGclUlivyq222MVq1YCOjzAIPGYeRAYzY06ZIUINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPzZ2Htc6yC1ffZ7LopGGRCpzW2039B7gTeyV21B0Gs=;
 b=hj/GbOc/HUJb8Z2JGch+eDhc2aPU5MzmUCSuban3Ov80IQvKV8CfSd6/MgmRB9az2iLkO6OYautiBlAm4NWGfNqyrYRb7iWYh0URAunllAa3PggzkaA3tQYnDBDXaOanRX8/8h0+YRbhNg+1gvI4ECVmjdIR6rkq2BWtx0YoVkVEkLZIZ4xy/5LlxpYlKAg/vsAc0/LDRNGGf7FygQTaAhD5NN2kjEMRokWFuwrOmSrWufQITJ6ClzacziSyx+CHMapQx4li5hu6RAm4S83BwDDraRBnt5NekIo9lH+zrXgGMehOsBQiEibpzJ7VMC5Ofep59ga2m9cyDUMtVqT8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPzZ2Htc6yC1ffZ7LopGGRCpzW2039B7gTeyV21B0Gs=;
 b=G0NZ40oyIhUlo0sEaVN/6qL5H/J/Gluo8gNkXUH/YmmOebe8sq5lIpi7wdXNs0ugpUZsqAQbDbdKPRp2oT9ubRphNhMm26y8EYNECKsL7USDdt6KnR7J0cFCQS6R4lIXUtcMctVqh9wHzIy5TVagrGUaka1AIrcbpomqCobDGd42FtoGfShHJfeaisKjY9rYCm7x2vixXf7rH2ECg72b5k/q0D3D+QhSC6F08v1NvBVB947LThr8169vJxvXXz3fYCtNn2ARkNShpuvaTtlJxAbTNT5cJtDdVnU22KhK1Vodxm6llBI1y5xRR/MNh8sh8VbVwosMhjStu8M20l31MA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8061.namprd02.prod.outlook.com (2603:10b6:408:16e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Sun, 14 Sep
 2025 04:27:19 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9115.018; Sun, 14 Sep 2025
 04:27:19 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] drivers: hv: vmbus: Fix sscanf format specifier in
 target_cpu_store()
Thread-Topic: [PATCH 2/3] drivers: hv: vmbus: Fix sscanf format specifier in
 target_cpu_store()
Thread-Index: AQHcJOQv78dOCXABFE+L55SXXyeBO7SSEYVw
Date: Sun, 14 Sep 2025 04:27:19 +0000
Message-ID:
 <SN6PR02MB41577DBA5D2C981ACEC4D9DED40AA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250913192450.4134957-1-alok.a.tiwari@oracle.com>
 <20250913192450.4134957-2-alok.a.tiwari@oracle.com>
In-Reply-To: <20250913192450.4134957-2-alok.a.tiwari@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8061:EE_
x-ms-office365-filtering-correlation-id: 0dea6b0f-c82e-4dc3-2922-08ddf346fe1e
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|31061999003|41001999006|8062599012|8060799015|8022599003|19110799012|13091999003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+zzaSt10o8XvO3ZkwahJFEgRB+/uoEp/BnmyaqhDSybuMVgoHfRx17YCQjzk?=
 =?us-ascii?Q?IWlaZlwRi/qb4cP+RkkNTmyaXkQ5T+Vy/w0ETuSXKHXvp8+vSHElhuvbkkHs?=
 =?us-ascii?Q?fKeo27c7q33a/syK2TONkjiPSYvoYr5c77GMfAyRknqbF9pWLvhOOL6S2YCs?=
 =?us-ascii?Q?ch1ay6JWKD2rI4k6lRL0nlCMRsknQl1RTiXkyGJLXod31YNvqSuoYfntHwFv?=
 =?us-ascii?Q?UDP0tvf996Dgedx/FU7Cy7/hyoZDBuYOgufcJ8L90TdZ9KKcHrUtEK9a0VZR?=
 =?us-ascii?Q?swheydR4aDt2asIUxTH3A4XjfooO3lYCdyqT1E/YXH7Uj1oVe8K/jzdQ7U8C?=
 =?us-ascii?Q?2FKflo1qHWE19Q43FMHEyA8FwAaitxoZ/idOjAqkKJ6fnC3G1PeeY70QuImB?=
 =?us-ascii?Q?GAEBp6qStl4a02RchBHrRYiS9/dKaU/OCyKd5IgOsJmgZ9XNUMCF9bVSRUdD?=
 =?us-ascii?Q?8OyXojWxaVz+NzLTpTyPC5ryrU3XNAo0pnl8Bv77if7u+Y567aLGPO6iXPHG?=
 =?us-ascii?Q?NW61Od++UMnqxE0Hoi0qCqjty0fPkm5R500gz9VkHroRvR0GmRoBtlwXSBGF?=
 =?us-ascii?Q?TKuEQt9ymBV4sBld1T8fbQCMRgCS2wlMjrujLVoUvRtHmFDohEo87r92gZZ7?=
 =?us-ascii?Q?VkhkDY+qpOMQ8hJy16pbA8s/OU5kS2/PPp/Gaee0eCLm3O2g1SeprELng0IW?=
 =?us-ascii?Q?Q3G8GfbOTmSBr4NN+mP2G/5w1/cTd5sDCxB2TQiYImbbB0f9NR+r1TXnT+Ea?=
 =?us-ascii?Q?KiyHrR8JIv9Xggyc4amxvvPm4vb9hCmWS7KmlBZA8S0ZARAKje4tzuXyQIgZ?=
 =?us-ascii?Q?3PJgqVjxLdf/0DDXXbbvXhjpmomkzQjE/r8uQiGjh9SoIfllD9zb6kWkHjhF?=
 =?us-ascii?Q?hBmuo/W4tpvlxR8ZfNRhEfWNW7jKvGEjTfZT0SNoAJGxgJKtN9nNM5uEFIvR?=
 =?us-ascii?Q?Z+WeEoU89E+AX1xCYhXxjVQ5Z5eazAl4Qv35es3/Ilr1Y9ids5Yu3k01WGFF?=
 =?us-ascii?Q?DJU11ajdwhYV7jSfWtCcseq4lwsBNvn6XzJJ2DW9m822DMyDeZxttTJs9Vwa?=
 =?us-ascii?Q?D/7PFvwsx0t1HYEeOWjyd7cywuMaDptPW9hd8MyBPofV4S3wGdMYypvDUaRn?=
 =?us-ascii?Q?714njY2z002FIUdyRDprpcbB3UkKk+y/9OlpjpiStabk+h670p5JV11eRkot?=
 =?us-ascii?Q?wxd7mq4dZaQt4+fXlISs/M/l/KEANBLwYRG2gA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?peZQ1psLnuK+5coB1pcryFLbrKTon5YpGDunL44fvbPV6hAvR00zPdCmxJcp?=
 =?us-ascii?Q?cc5VFCbxxo1X279j1+bl+3kE9eIunrqB0f5OjlmVmyBkUZXt0CEEGCFKL9Fj?=
 =?us-ascii?Q?JgsxEAGCxE2uUFCXL/yBVNYFDq2q3ZKG5oVLTxgZdEdobAZn2PT3VDv0d+8U?=
 =?us-ascii?Q?lTnaFhRW7TsX9/MVS4qdmEUN7Cw+AZZskPxc2JB1vNIcTo9RRzg5NCxWRD0G?=
 =?us-ascii?Q?5WzZshK1+/uBA8sZe7GsS/xQusWDQt8UbhBL2T3erebjoSaZgUv/v78BB/vF?=
 =?us-ascii?Q?826T0F1z8blbew0Y5Swoj9aOvHqQIA0G63jV3wUcMypU6MsxTNaCUrvKQNTH?=
 =?us-ascii?Q?0nF4VOJ3KcAZPiG05keBS+avAaOh8Iieq5GCTUfpiGc2I4gSOUX9hMjCtj5x?=
 =?us-ascii?Q?GLFwMR0Rj1SyubzVPyj0Dg1kEBnuQQDxzZGLhrblFXKfyvXV7/CJlWnaZWtH?=
 =?us-ascii?Q?PH6pJTxeuS2TfSpNjXPp4jyaWRpnVZDke7nsab9U1zKxS4SYUNwcXQQUWhdQ?=
 =?us-ascii?Q?SKxAOP2xbw4rbdAGx36RT9qPuhYAiXPZc5z9+dnEmevc6TRcuRzEKUp1lLnz?=
 =?us-ascii?Q?PUFynf/FAL0df1DaKsWRKWZqCukZjngILv4smmmY4U3XbklcQp42x1IiKG+H?=
 =?us-ascii?Q?8i4qz/kz/2u28mRqLvxlfA58JcCO8kfixAgad0XDJ4yDAIJKB1iBodKqgDyx?=
 =?us-ascii?Q?DBPq/N1xHzMIPZyw700P1BEUlkBAPqELmRxk8o6eCSAf4rY5EpoxZy+wszdZ?=
 =?us-ascii?Q?oJhBcDII0D/+FU1MySl2zSALWTbVWzd76kVC/taWr6e4xsXBiMdrc90m1ARA?=
 =?us-ascii?Q?vj8rvwsriEpE/1z+EPHBDdzHSVA5OkMb7vFtb3WG1s2mMSExj5/e7dkLKZUj?=
 =?us-ascii?Q?3pr780jvDGT3OJxzZYDFOhQU/INNFOLTICAcCGj+Pd1/8p8WbVh2mg/61hl4?=
 =?us-ascii?Q?oF73DZOfr9ezt8eGKMTkApIqIu3fuy0I9a29lkxhjiqkgNJL2rNjXwasXvpu?=
 =?us-ascii?Q?Q8FE7m5O6v+njBqPVZzDCEpejcniyMSKXrFKDyWbNU7DRsjMmR2bdjCPEetb?=
 =?us-ascii?Q?+m2YwLLh2IKyIgwH+dtohzKcGY74EKBZojtiGQ74vim/BPgFLCx2tQD8FsB4?=
 =?us-ascii?Q?O8SEvdvtZgpt03jbxU6kl0c1ImBEe+SrbD+XlnfrDBsIGMwM2Qe0rfMn+Sew?=
 =?us-ascii?Q?otSlt17oU/z5cP3SKgLGzoli5CBYt1rAHFqalIIp4g4RQbRziNqMnBdYtY0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dea6b0f-c82e-4dc3-2922-08ddf346fe1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2025 04:27:19.3084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8061

From: Alok Tiwari <alok.a.tiwari@oracle.com> Sent: Saturday, September 13, =
2025 12:25 PM
>=20
> The target_cpu_store() function parses the target CPU from the sysfs
> buffer using sscanf(). The format string currently uses "%uu", which
> is invalid and causes incorrect parsing.

The %uu format string definitely looks invalid, but I'm not seeing
incorrect parsing.  For example, this command works:

# echo 5 >/sys/bus/vmbus/devices/<uuid>/channels/<nn>/cpu

and the target cpu is indeed changed to "5".  A two-digit value also
works:

# echo 14 >/sys/bus/vmbus/devices/<uuid>/channels/<nn>/cpu

What are the details of the incorrect parsing that you are seeing?

Michael

>=20
> Fix it by using "%u" to correctly read the value.
>=20
> This only fixes the parsing format.
>=20
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 8b58306cb140..fbab9f2d7fa6 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1742,7 +1742,7 @@ static ssize_t target_cpu_store(struct vmbus_channe=
l
> *channel,
>  	u32 target_cpu;
>  	ssize_t ret;
>=20
> -	if (sscanf(buf, "%uu", &target_cpu) !=3D 1)
> +	if (sscanf(buf, "%u", &target_cpu) !=3D 1)
>  		return -EIO;
>=20
>  	cpus_read_lock();
> --
> 2.50.1
>=20


