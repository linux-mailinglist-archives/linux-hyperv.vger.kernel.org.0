Return-Path: <linux-hyperv+bounces-6926-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F499B82CD4
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 05:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33171893124
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 03:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0386C23BF9C;
	Thu, 18 Sep 2025 03:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LKPW1a69"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011009.outbound.protection.outlook.com [52.103.1.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27599213236;
	Thu, 18 Sep 2025 03:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167464; cv=fail; b=DqiHuahbBxBKUTgWCsAZKY+gPC1gY7rZA1LEy3pwN6NcOUhFfsmGBOwYINt1z5JQlwUw/61ndVIFCPV98rmmchvgnZKn0WdSlM6fqBIXB+7NQS3Z7X7eXlLSVku99OS1xXSL4nD3b8PXYr6uKgYzsqhDSrUjEtxm50PmIR13lu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167464; c=relaxed/simple;
	bh=qbR8UsSb4SQzM+I5EyfOsAlHKFIE2UE+ieVZnfIMWkE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hbj4oE51vXdizfni9y+cOwBKF0jwzFkphpKTodU33j/+w02ekHECziFwTT7SPdr5jmDQdi5pBzd6ZD9WFE9qjWDj8kaPZVE7nAH9GOW0gPBpQa/n/VXCO/MjQFSdHGbMU8LZVxtZLAU2N53S4NO794OoM3b4cfj+lZdMjnZF1mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LKPW1a69; arc=fail smtp.client-ip=52.103.1.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2YR0n9ZhVo+HXT35r90d9yBxvSsML3jDAQh1Kg2vo+4UHoRqzdMzVMJqD8g6BzIZTjoXg0CZWnLtST1MurkTswNokZHJpO3QjHvE0L4tZCVg/Wq0W6ILRO+DLnui8lkX0mQYBwu1Ge4awh9RDlsEKArATasqtzAUQPKfNizcon2jCYytNswIkcsEXmrOXnWhgIi6RLsSvCafZta7m7KGWy/cczayR8+my29CUiG9bih8OSHUzSoLwLFRZPCJSay74niW983PLKSr2sAOjrj4lJjPSJBGB/Y2BTr1cXVWhCAfPstK7T3dwaSNvfFYa1DBtANNgwHRt7rnZDv/cIjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJnKqbDwcfOiXVvKIF++tVqvECjuPc8uRkRd0gZaqek=;
 b=kMbjdwCWwj4QKSNXOpHFNiboXv6Qmqz1+VXTkIKO/tHXDXQtyCJtYwmcev5mHEu20mctvf9TP3C+NBeeZtz7UOHSp5UN3qgWQHN12MT2AQs5ve7sbl2d+xGaK2Za8ejJ/3sAvYU5GTBS46MN5Okq0uzI2R2+wc5IOX2FOOsus3r3szcTPuLwJEPqZD2rKd+Mu24iOiJmnsv8TLyAphHlpynUEw+R0iAprnOwwRyHVrv9QmwWkIriovje/1+dup2kGj6obrYdvzNosAEsXIRknhzrneYxgbPEx1CDSw5+PaBf4Ivb+Xv3+OpkOEKNJ+NsvcXf0q5L9d9ozbos6RHKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJnKqbDwcfOiXVvKIF++tVqvECjuPc8uRkRd0gZaqek=;
 b=LKPW1a69fJ9O9HuLDy/iLMzk8Arg/hRFe5DxeL+rf8pZSIqbRwRVZu80q96eQtPl8zLcgspiScEPofnk+cRMwwSVHjcAlSitvwuiviykwRc0wlo0usVhDWxvAlv7LLZ2jhv6aEJS/AsHcieqU1mRLmVmuoFwrFiyOvg7+tQkmrG5X5lszFTgZAZyCKfSLaK5NzXFPdagfjHk8FxrLKNrkXUfW+kCZfJDiQEbKN3JmMdi+9zqVDTuj3VeH8CvfNY73P5QNbfd0SMKXyiosQ9rxB9EAMy54qWjiBm7sl4Dg4OrKMNkV/U6zrcRRZdBk5/u+2II04i8grsLFANfWMN/0g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW6PR02MB9862.namprd02.prod.outlook.com (2603:10b6:303:24c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 03:51:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 03:51:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] drivers: hv: vmbus: Clean up sscanf format specifier
 in target_cpu_store()
Thread-Topic: [PATCH v2] drivers: hv: vmbus: Clean up sscanf format specifier
 in target_cpu_store()
Thread-Index: AQHcJ7FpU0YacqmfuEaSdV/CuXFz3rSYTylQ
Date: Thu, 18 Sep 2025 03:51:00 +0000
Message-ID:
 <SN6PR02MB4157E58381C62CCC2681A20BD416A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250917085933.129306-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250917085933.129306-1-alok.a.tiwari@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW6PR02MB9862:EE_
x-ms-office365-filtering-correlation-id: ff20b9f2-f548-47c2-0bde-08ddf6669523
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dc43FlQvP2yewYSt45NTkBZ2hTOBjAB6fQdknXxq/Dy2BqyAhI/cLTOp6WB0bzcQPKtiJxnblrPEPvp/M3RNQLxJMYP+GoKse7w9yztPmn9BXdGv2Qc8K4GMq4EO99Gd+7JAC+xBni3gl07wSN3wLKR96iiz31DZuNjR8y9x6ZALA4aK12L1O/AZbBpMX49wnyKRnvS9c184ucnzL1lvvcUtJcQ3pOlY8AiXLHWq4gokMrYgikw7WC4cOD1Nq8ilWtKuBwJURQj2xeN3y81ycfkOOhKqZZoHFQ05Vos8UYhUPby5IG/vYkZq7Lk8IDJP5addZonmzTWVZUm4DtaCzAqFJRB+pmmdOC68YkGWt3zwvGVDgBCpOPsrGTC/TUOyAhgmTeHQssmH4tauD8v0/WxrOvdszmReIRR/QQZpe2X6xSjbP7cBc/hb6dlrocZZbm4K+4c1iSiyedLLSZfDoqJYwKBMC6YhvOx8MhdDdhjoZAlKBeOhX5FgsNvYOqiwtizB6EDX8tkeOn9rWrg2qIazax0xxSsh3Wxs47uQB0jaN5z7mjD+O/mZ0NAva7Vd7/Hqm9tKkgIuMn/AtnUKav/lgPhW2+LWRhOU0pBeNH8/vxTaLWJlN95++b3UlVjf5PRwkKc2OKPazWn40Sf6bd4NK7jRGoDgb9mjgp7Nq0xfPHh3sMwggZVorWFk1EDWbzglwna27Z/2+WHUmneAmhQvifakValwutqvDLsFok6x+u0gOJoRGVS
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|15080799012|461199028|19110799012|8062599012|8060799015|31061999003|13091999003|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7zvy1NgQSX1ezO9LormvU5Gn0QXUHyI0yvInJk6YEQjrMek3HbZIXEPyXhXq?=
 =?us-ascii?Q?aPVfBnCeHQUH4aCpZ1v8bmVXsZq2dm63/Ljb/CUVdeOngRhVAbNB+NS8pC0t?=
 =?us-ascii?Q?RReh5cjQmhoMeFok02BPWwZf7SlqzOCIAJQMnHMXylpPB3eMLiMKECuEf3sj?=
 =?us-ascii?Q?LAjD8Bj5sAxcOmR8ANn4d6SouLpWx15XdkNmFzgBPpuXoomUiuKfg31Xpcbx?=
 =?us-ascii?Q?21rhFcUSr58acNO3g8QiPf0z8uAMXHWz7lRqBocL95CXLKOuBNp8qoptcnhK?=
 =?us-ascii?Q?rr9qBaK6hSwmbzw32m3Y/L/lkTDuAiNkP9XsSSRYYDZ0WSlRIxtD10d8NdeK?=
 =?us-ascii?Q?KsbB+dnyV5TDf8+r226ojKTg72XI4td88VLLkJqc3uKY3se+b0NUswgv2ULS?=
 =?us-ascii?Q?vvF7ZOE5YS+LF6wgPqpZ2dXMRF10HcP1y6pmnP0PLvdu3V4Iv3Kjc1jCTpix?=
 =?us-ascii?Q?Gjrnv+Aj50WwUhTxLpCKUpQUfYGWkQSMfe3yvJZfZaQzy2PIzaMdiRUnRcqX?=
 =?us-ascii?Q?Qu68SHUJL1kYtP9pN+Dk0r+phmUWFA+39Hvt9Z7hqRi+JkxANmfLMSRk8Rl8?=
 =?us-ascii?Q?8mmDycJw4X2NrZF6BHu0uMECzLCH8zSnR6a3NszmxBuUpKHndrOl4V1hHz2K?=
 =?us-ascii?Q?nI2KEvdJx+r6tGc/BM5ATsXrr4I3S/cJMPcDE7ZMIkmuTGIwt2Gf7Bl9i+Pz?=
 =?us-ascii?Q?dZugJcgpSZtuC7znC3mzajW+mZgCe1+h9oqSY5fgU2sQKIPzqxOf68ldcqYX?=
 =?us-ascii?Q?GohTpjKHKzDt8FUgodv6HtNSWbLFB8dFGhPfhIFXsAFsEPA3cYBm3Y0i0KAr?=
 =?us-ascii?Q?8T5OvGu6iT/BRkdiQoZk+vANGSU6HfQGltDbFyewYPBRWe6tKYIXjLoSJ4L/?=
 =?us-ascii?Q?jmPIdbjHc9Wuijlkv2W+fZVn8JKNA7a8q5vS0nLjVEMT0vFZb8fCuCdemHmG?=
 =?us-ascii?Q?Q2jOCAU1/8aB6yhAAdQIz5KH2cCtJwImW3vVagoh5c9+oLX7dUNTWdtHtRbn?=
 =?us-ascii?Q?bjQCHO2ZUrLlOGJUG43N4N8ZG/95KNiuf50pQXNZMbAKFoschoYrKRAvyYhp?=
 =?us-ascii?Q?48ssi9UkLaZwopqwbGHFamoj/H0iS8jwgCTWNRnlh9Yh4KqhP6K/2aQslRZG?=
 =?us-ascii?Q?ja5OpBon9FoZJhiBUIdGQJksaR6KvhKjP1bW2IEBR3oOd/gqfbFpebUPe/ei?=
 =?us-ascii?Q?6gp2VGE2CjxjnBX+SS67gdrbafVXZtMwABegpw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LUZFZW2y/2u6FdVGFebDo0z741Ls/WjKXzrgdsef0HYHjx6yS8RB0HZad2zg?=
 =?us-ascii?Q?NAjjQjvXM/xHiDX5936osYsjcJ4t4Dn62f/fDF5YN51Ka7AFrKHT1WWlEapF?=
 =?us-ascii?Q?CPjF0cBIkqW34V2dAbffy8kCSzbPt3w5XG9P5JkfT3HL0SQ2w4SPy/pnZEqj?=
 =?us-ascii?Q?piuUO7nd7yE1IphTiVlIFtS0Vdeo2pgvZpnJvWhX++AfZqQLMvotu39cK4NS?=
 =?us-ascii?Q?gp5BqQZxpmn68NNyvSMDaJNDQ9zyNKZIziWUOcSt19Eb9smTaLO5+CARmHtu?=
 =?us-ascii?Q?/S81Mb3Kf1i6oFeD0Pi/6Sj4Nhz393fEVjT5ij1y+3d6LQDOMkOFHddwaeav?=
 =?us-ascii?Q?Jnn4pTKjoN1aWQrrt99G7wreCT+EmwNIP6D3VxS3Ao5CaUDqBENlW8NF5sRT?=
 =?us-ascii?Q?dA4BsKvKYr947T9yXqfN8/usR64NyObxXymaAFI5cd1GOqo06COHw3KDly1C?=
 =?us-ascii?Q?QwCDoK+WJye/T7wo6mZIO0Z0ExdaErY/dufvPjZn9A9aKsff0oYciauIQojV?=
 =?us-ascii?Q?8MqLQWc490ldl+Biiq7Eb4VdZM1V8CS2TOjp8m5qxdvIglue7x5zI7kncfXL?=
 =?us-ascii?Q?D/2enVkmhZpQt7Z+EqMR7kn868/VKXeX3TYk3c77B2Z4/HIt3y/iqWZp07TW?=
 =?us-ascii?Q?AMq/VDpgwIxm1OXZP6fL0D/++YG18XrUnIInq0UxY2yy3jUHdvQdDbMQQi8q?=
 =?us-ascii?Q?5bMAGmsd2r1Tnjn/irBeHUJHyHeA8w4tDBRvCZnmW811aCHFEm3645AQhA1Y?=
 =?us-ascii?Q?3lJKFIFNLo+QrYkF5lDJkYvk41TKSruBcOFIuUgZZKJco9ilpB8TVQJ8ruef?=
 =?us-ascii?Q?qxCHJJxc6OWv9qiGx3RQEErBTJbogj9AwfEP2X3dRKQVNy2GoIeUpD2o7Fg7?=
 =?us-ascii?Q?l89Xbm4vC1uyIeJttgI6+9XwIzCsmGXYIfhg74bzk6PnDODaK8/dtLb+ViyA?=
 =?us-ascii?Q?x7xI4CNhAphdkmmW0UYvMQwSF6DxtcsXbQTw2uW36Bbu4mbCJ4Y/mvDKQ/rc?=
 =?us-ascii?Q?omHjYuyHYSzoV9CZoC7kXeXpy/Too7mXBP9yV92QI7E7ri1geaD7CxtwlgN5?=
 =?us-ascii?Q?ptaOKGa92HXNaLPrkekitKadVkdpDId81tBX+dBjy2Qbaun05skzWN+WJIqT?=
 =?us-ascii?Q?Yj3f4N0adDCeEofQkm5zwxxyOtq95BktfnkBcT/ERNjf9rjI4m+yNgxSAb/4?=
 =?us-ascii?Q?a+Pc5Hd2u30uOhMEo8ue/Eo9C8i1G3FC6PfK45MU8Qey4flxZG27pc3reuc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff20b9f2-f548-47c2-0bde-08ddf6669523
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 03:51:00.5484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9862

From: Alok Tiwari <alok.a.tiwari@oracle.com> Sent: Wednesday, September 17,=
 2025 2:00 AM
>=20
> The target_cpu_store() function parses the target CPU from the sysfs
> buffer using sscanf(). The format string currently uses "%uu", which
> is redundant. The compiler ignores the extra "u", so there is no
> incorrect parsing at runtime.
>=20
> Update the format string to use "%u" for clarity and consistency.
>=20
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> v1 -> v2
> Rephrase commit message and subject to clarify
> that there is no incorrect parsing at runtime.
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 5b4f8d009ca5..69591dc7bad2 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1742,7 +1742,7 @@ static ssize_t target_cpu_store(struct vmbus_channe=
l *channel,
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

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

