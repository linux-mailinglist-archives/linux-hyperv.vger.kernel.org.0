Return-Path: <linux-hyperv+bounces-3400-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F819E5B79
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Dec 2024 17:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859FA162D07
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Dec 2024 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033C2192B63;
	Thu,  5 Dec 2024 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Pi0bGds9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2071.outbound.protection.outlook.com [40.92.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1914A8B;
	Thu,  5 Dec 2024 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416298; cv=fail; b=G5SefSjlbGZc1lQSBqmvp86BUT8tRIME8zBoPzi69v9Yvrur1OIYHI8S/lIrKbwVNUNnXduGqaNqmmcMuDOZxSXhg5vRa8vJ5WiK0Br8egdHXrOohTOhBYz/GQu0PNyVnsRw+35ala5PqfuZuKgxTRsS5QdpgRoobROtWQBT4ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416298; c=relaxed/simple;
	bh=0Wii6W9kmDPQAW1oqeueJ6hSApEBouwZePjNEeYBRYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DwY9ZweyxdUk8tHgVuZACjgtL///MKy8k7RWaAo2M+xnKj1/qdC2hAA7TG2Zg6uHtoDx4rA7ruzRoA6kdyZgFru3401dykRNjGFugF31HP9jrWqOV9l219sPyRgvViTBVn8pA9UYKDo1Ys/24740deUWr/G4Epoi9iPZCl3E1q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Pi0bGds9; arc=fail smtp.client-ip=40.92.21.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=racGtdZgLYlDWe16GE1ftplA1R7NafFnpcU8UyRgBx9sFUishvftem2yMQSyUb53IpTuUv0nzxQ0O8wv8wpXF1ReOlZBsGLs5HaPAM68ehALd84J2D4SiU2rPblmaBlNKlJvGKyirEFmHuoeMUD5tF1SOq+IJi5Lm7VbM68sSYUCftIDTdLQZBawtV3A7hYyDCT5RexwhPM3mR1+Rfb3XLczU+UZtIuKsMCb+hw0jL83BkygU296hmh9vhOgPbt92fSHpsZBoFAr3VrNqJjZ3L8Kc42yaawjvAMXV20SfTRQYNCXvIlwScWtd+QIWlq8vkqWsIFY5wZioj/LlPLU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71G4DtRffbtKIMCwkj09Hibh2u3dRKdqbwTlUwANpKE=;
 b=GQO+qZoA+Ri983b5ild71u1CxJ+p4/JqooOQFyHbD85K6XHbbPegYs5nvRcDJQdTCHI9WwL3cKdlLHfDGqZtI3WbzlvBDSbkV5QwtudHwlMhFIqPRAKAsDCJfVduCiwGpvmfmoHV7KURrIzaO9jOygOaYmNjWx2y9Z97Bl9ZSJYGxfXTOBAH4W0Y80DduhlwhQllMz6iUpEjE/umYgKhNqfIIkylfusfooSKqiJqWKVPWZktnMH7m1PlF5rTOtOxaBk2nHPnuIE6fRuD0gF/w7IwSfWT3CmKolXVtVfPMozsEUGnoizk8+zpD6UaiZqUxtgZC5wCY3p3jKGD+oTAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71G4DtRffbtKIMCwkj09Hibh2u3dRKdqbwTlUwANpKE=;
 b=Pi0bGds9UcdoP85ZjmdzeQJmc9GbSUSMBEfXXGU4OLyNPeX7JOzCB8Mgt83ug7bxqn7XtWA3b9ESkQ40ccRC8iJAUAefFy5PrBzYUEPgGcJSvYNzLdoYBwYOpwrVCxB0pqCZL1Sn0Q754XDHUmkRRYXX4eleXSOuwpvMaCRUaoXBN7y0K8LvLUwWNA2nU6LNz94qKDfedxD9dFNQckPA41kYnKayuGsX7EBVoy4cnbziIGrQi7t5epOxPkg+Nq0+P54DWnUmDTvp0HyRXo4U8zBCfHieukD2GbH44GtkLjW1ffIhtOHJxVo4m6PBYQFK9xJA9zzDUKsetdzH7mHcgQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB8982.namprd02.prod.outlook.com (2603:10b6:8:8a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 16:31:33 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%7]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 16:31:33 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Starks
	<jostarks@microsoft.com>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, Easwar Hariharan
	<eahariha@linux.microsoft.com>, Saurabh Singh Sengar
	<ssengar@linux.microsoft.com>
Subject: RE: [PATCH v3 2/2] Drivers: hv: vmbus: Log on missing offers if any
Thread-Topic: [PATCH v3 2/2] Drivers: hv: vmbus: Log on missing offers if any
Thread-Index: AQHbNaigs0+AhVSZKE2uEMRTuVGAgbLX+rIg
Date: Thu, 5 Dec 2024 16:31:32 +0000
Message-ID:
 <SN6PR02MB41579D449B5AEBD4E29F86ACD4302@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241113084700.2940-1-namjain@linux.microsoft.com>
 <20241113084700.2940-3-namjain@linux.microsoft.com>
In-Reply-To: <20241113084700.2940-3-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB8982:EE_
x-ms-office365-filtering-correlation-id: 3397885c-573c-4051-cf3c-08dd154a4798
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|8060799006|19110799003|15080799006|440099028|3412199025|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Qo2cPvPaxjFYMdZHBp+TByJK/KK47kj5yhDOJVSZrzhQTSQH7cbp85fdD5Zs?=
 =?us-ascii?Q?H0DqJCanBQInlmgvtnj47OWrC4PBNicBLsLSKHi9wn1BbHNWuD96OxXGk+IP?=
 =?us-ascii?Q?8YE2g43u6uaHyTU0DHOal6g44WdJ7XLdJpb9niTLcZcDPFFY18ZTV7GDh4yl?=
 =?us-ascii?Q?d4izCmOhIfRZVSApv1a+XeJpkGT08m1SR6eM+HswZOq6Gj0IqhVLTnJjfPpi?=
 =?us-ascii?Q?tqf7cbQGE9No32hf1yJF7gL74M0o9bLYdPv4eJ7LW+zUVWrcsU7yuwWqtpFP?=
 =?us-ascii?Q?/7GVuwWlJFbmvPhWoSGM0IHSyCSS0V1PYnYEb+o251CL4TSPo6n+eDc0i7o0?=
 =?us-ascii?Q?mfPiIcdkd87SLibEDEwzwAJzYmMdhlbNn2NokDiUk3Y3fJfJbQpfrhuupNVW?=
 =?us-ascii?Q?6MJyV/JpjcH+WRPTNlfOndReFte3ba7vZjjpZu3zl2fqkGuWGBLpxxO3oXLU?=
 =?us-ascii?Q?9T8sgpMQIFfzuk3BvuFcCpN1wn2JaLzMG6eUqfCpUTGEcZ9ytBsxG0rcpA+L?=
 =?us-ascii?Q?2mMqZnKDemJHybP4R/WpXT8c6b4ypRO+hmEVtLliEHoWvLy8b4DTP9h1UNq9?=
 =?us-ascii?Q?oa8ryaw2IrNM8GZ3tKMxajIC0EliZYFEoxmdrIvTLedkAWAKu0Sw3TlTNCrx?=
 =?us-ascii?Q?Nr7RdG/ef24paQveCRIS2tSKhcBgSr2qU9ElmvJYW9M8ysdfAUt7ClASoJKC?=
 =?us-ascii?Q?m5P8fObc2p5dpf0qA1DqLsPQBLqv4hwSgbQh00lGnjhxI9QM+i2Ws9kWd5eR?=
 =?us-ascii?Q?8CK9Tkj/Slro+giPW9WEEF1TARhNfvVazBPdw/Qg1iJzhWiTkuABZ+I00/pW?=
 =?us-ascii?Q?0knncCpKeL02YFbB+iKbqAg2IuMr6Mv8C6cU4B7YZsI8nY/Ol9umTWuw2b5b?=
 =?us-ascii?Q?p7RS1DWXaCOyx9MB1fwnyPUYb9jCSt0LCXM+YwpXfTHH7qrayxKJ37warnMg?=
 =?us-ascii?Q?8rUAEeqReliO0YjoS7ItYZbKcSa43x9If4+WToejLHJDmlE1sTJAcL5SkRXP?=
 =?us-ascii?Q?hKMG?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zlhYJHkb9j3f4UcE2wftFqKt4RdtLrri1GnwZ3RlIXoG6wpGFOe3ZZ63U1ki?=
 =?us-ascii?Q?OHyCWGZy/z2TjaWkE0ogM2fyMqr0zt9gno2nZOl12EncN8RaOxEhx6SbPfjF?=
 =?us-ascii?Q?oQgzEgtrl+zVNVtN7rLEEXamDSNMGhAm5qZw9fBIYZMfesac8Zy0+3G+FXFQ?=
 =?us-ascii?Q?rsL5iiLbEp1CNOw6oZjfcrtebFt5vrPv7IQEAbnFU6BqNyIYy6eOAnAHxq30?=
 =?us-ascii?Q?ha4lwuSh27c+R+WisrrFBzs59cXP4qxw0P1g3dhtXPts2qt59CcCvYr840/Z?=
 =?us-ascii?Q?wxRE6TjCtYV3grHh1vRoeIPfs4/UzOQWL+K2wJerY8CQ7+QfKZGPExG0ulcq?=
 =?us-ascii?Q?paRnZtb4ipo6oRxaOGx49RkSHrsrs3tTyQaJ7+Q8Fntb4YxjF0c6J4FMON4W?=
 =?us-ascii?Q?KA4msbV3UbTpFsUq83fxtt31nr2gHAnwmugsD6EwLZ40Ydk/ApPYDTulHj1z?=
 =?us-ascii?Q?rf9+sXVCfrO3JS6WM+HJWsu9Xl/Tmvpc1g3C+ELCF2JSoiOSh7sfabCitcR2?=
 =?us-ascii?Q?LiS/uyxpryvCjgHtkpFgioh0DwRGxX4FmrOoJXnX55sM9ufj5ALdKdRX8Fle?=
 =?us-ascii?Q?YuFLkiSx76cS/LiyLRGwuTM61EqV/9FuilOULqWXdJt12sSxfDF19ux/s7M9?=
 =?us-ascii?Q?3NjvYieSKTNHUaQICF2rWvWYb+HbLtCyXqXfspy/Zxh6ImLH5F97bQA7eDFJ?=
 =?us-ascii?Q?xquU/0D1iE/L+E7cOMoyfxWnKb7N/u0McWIrzMv6WXWhPaF8JwSK2ltkyTzx?=
 =?us-ascii?Q?SPKk1zEMqdeuSbuMuYD/y0MNRgMn0zXhj2zhKKdZ8DB8Pl6gswRpsb6K6iMC?=
 =?us-ascii?Q?b+1PeERh2GwPjOxLcoCU23P/+cWhw1xhjfbswMOkhDYvQS/LeTaMD9NL0ggK?=
 =?us-ascii?Q?VEBRpBl8MC5KUCgHBKObXvOZvPuKCg8p0jjPLgmA/tm6u8qYeF3Ssj8gBIkv?=
 =?us-ascii?Q?/5BBq5iobXU5cTDp0khEDnaj5BIf4vqGpCoC5qLV2gPIFNxKOZ8zeYjA/DHK?=
 =?us-ascii?Q?ggy+gad9SGtaczVf9l9SW10WcJd1EvkYLeDZ3AenQHhVdmQZnZuVRV2rCeNk?=
 =?us-ascii?Q?LBwCE86QZwX3UM0GYOUGRRIp+oQEoPSJMqkLjJ6KVRqQRhzDMcWD0KUR8kss?=
 =?us-ascii?Q?4TdepZncydne2WS12dP0kdDs6lzTi5EsmUjeV4jFvTQEycxvm4MD449qy857?=
 =?us-ascii?Q?v3w8I1fjUMf7X3BE7hOgVX8E3yooHtT4TUt53CB0U2mHiVwA+g0ekiNZYsY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3397885c-573c-4051-cf3c-08dd154a4798
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 16:31:32.9125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8982

From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, November 13=
, 2024 12:47 AM
>=20
> From: John Starks <jostarks@microsoft.com>
>=20
> When resuming from hibernation, log any channels that were present
> before hibernation but now are gone.
> In general, the boot-time devices configured for a resuming VM should be
> the same as the devices in the VM at the time of hibernation. It's
> uncommon for the configuration to have been changed such that offers
> are missing. Changing the configuration violates the rules for
> hibernation anyway.
> The cleanup of missing channels is not straight-forward and dependent
> on individual device driver functionality and implementation,
> so it can be added in future with separate changes.
>=20
> Signed-off-by: John Starks <jostarks@microsoft.com>
> Co-developed-by: Naman Jain <namjain@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
> Changes since v2:
> * Addressed Michael's comments:
>   * Changed commit msg as per suggestions
> * Addressed Dexuan's comments, which came up in offline discussion:
>   * Minor additions in commit subject.
>=20
> Changes since v1:
> * Added Easwar's Reviewed-By tag
> * Addressed Saurabh's comments:
>   * Added a note for missing channel cleanup in comments and commit msg
> ---
>  drivers/hv/vmbus_drv.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index bd3fc41dc06b..08214f28694a 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2462,6 +2462,7 @@ static int vmbus_bus_suspend(struct device *dev)
>=20
>  static int vmbus_bus_resume(struct device *dev)
>  {
> +	struct vmbus_channel *channel;
>  	struct vmbus_channel_msginfo *msginfo;
>  	size_t msgsize;
>  	int ret;
> @@ -2494,6 +2495,22 @@ static int vmbus_bus_resume(struct device *dev)
>=20
>  	vmbus_request_offers();
>=20
> +	mutex_lock(&vmbus_connection.channel_mutex);
> +	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
> +		if (channel->offermsg.child_relid !=3D INVALID_RELID)
> +			continue;
> +
> +		/* hvsock channels are not expected to be present. */
> +		if (is_hvsock_channel(channel))
> +			continue;
> +
> +		pr_err("channel %pUl/%pUl not present after resume.\n",
> +			&channel->offermsg.offer.if_type,
> +			&channel->offermsg.offer.if_instance);
> +		/* ToDo: Cleanup these channels here */
> +	}
> +	mutex_unlock(&vmbus_connection.channel_mutex);
> +
>  	/* Reset the event for the next suspend. */
>  	reinit_completion(&vmbus_connection.ready_for_suspend_event);
>=20
> --
> 2.34.1

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

