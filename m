Return-Path: <linux-hyperv+bounces-4166-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47B9A4A27C
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 20:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958D93A1892
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 19:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446251F8729;
	Fri, 28 Feb 2025 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qDfEU1il"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012071.outbound.protection.outlook.com [52.103.14.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E08D27700D;
	Fri, 28 Feb 2025 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769908; cv=fail; b=kICOipHEDBgpEcCOOJPsMeLUBzo8jb+UWd8AOgiQUHttbvk9udcUoQ0KBv4nDBK35F/9k7cnwiMjv+gSgi4Me/Eziyuqg/Z66CjHCA9583R9KgZg/LF4EqAz/sEDzC4CGiaTn61svjalB1d8uPER98aCkG1x/Dss9v89q6SMwBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769908; c=relaxed/simple;
	bh=SFokLpIBrNmsLdbEeQ+azGxpW5NWh5j+Z7FbOmJ8Ed8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A9k/nNFL/KvsBfeNk1pgmDW1NjvoDFI9jxud3d8wrDNRMyROdFNRf6xoAo5BQ1yhaJg+za3Mw9ZMQqAfc1lTEtcQkVu6T80i6+CRFbH3873bsXzypcYOY8OLARLF7fofuqujXpkayZDsw4JFblL4hQ/C7PVOugCjPnPrhUvAvTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qDfEU1il; arc=fail smtp.client-ip=52.103.14.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+skGBUOgfnW+G2OZ/S/mmDnu6yjd/sGlx2yvLyK5DZ9XFbBjBw0dHaYiPInbkwtZSRpCVDCjPKzYGCf9fnxeltcoTMsM+jBVQngR0valDiQ5Pk1epik8ipP0m8VYYE5r+LuFCs6UU2fBWWI1La16YmEaYKa6iiB2nWm0lSVWj449R7UfcoO/72zsM/OIrXm2m20s93aBGYgRZ5e/Le/wW3uKtvXbUWWX63QWZiF+nUv02UKB5rLR1yJwiEiSPXx0xcvjsON8dTD3yMG5u3WZwW9iwa4ZikXxK5q4HgI7XkUurlozn4GsTImlBzhwNXMq0HTNHTL3sXiAQHN9iyupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QuEuDxMgNEW5QhiXJ07GYTHrBv+1QU2TyQ1AyPmInU=;
 b=T+kKiIadOU/dZoh1yLGJDMpWc0v0+Z8IMtMkYQ459Gqu1eP2USwUJccCr7b9eLQk1CR54Dkk23KYo0MDKskHHfaCW122jrNIi8NyMIn82I4RchZAR20LlcaEbqNgf1I3vu8zSsQ1lUdylKww8rPt9AGle5sYIJ7kmPkRFAPMPRDULuo3KFOWOgsgXR081Vl0Kru+J8EUZn553+FqQMoOrOCCkh69SQV10iXOPC6u6DyINVSQPrSMk6wqToJzq96HId+LcEFtUDPxrGxDE8Hnrp1tSUnxEd8+uWRRaZ5x+I7Etcm8BFUUvaiwwY30yMookXDdUGe8yo1j+LbzDGJ0Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QuEuDxMgNEW5QhiXJ07GYTHrBv+1QU2TyQ1AyPmInU=;
 b=qDfEU1il9uJiICmdcd6Gwf2kbF8f99zVnYYk/islDkK54FB0LxAU7/nY2lVNu2+Xqof4U7HGvLwpAuTqjEmJDHtzvzxN+O6r56NpEb907GUYakeYoTHMKYthm3wB2A/ccYeahJksPgufqsL6bz6Lqqjb46jAd7xyH3SHNydkSsavqTjg2vZarnoQNZerTelxFDMNRK5PMK8AvaZkHGTy1ZK7bmZUYtdToaBmCk97r9ZdBLLgB0flAMpwzTQ3/zijQi+w7mQw0L1bVJgyTVteNmEuA27VZFtWq2kdf0RaiLtxtelOiN/L5PZBmeS+SimfbZEmqBrgHjwFNzSNoIWsuw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM8PR02MB7878.namprd02.prod.outlook.com (2603:10b6:8:21::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 19:11:44 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8466.020; Fri, 28 Feb 2025
 19:11:44 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>
Subject: RE: [PATCH] uio_hv_generic: Set event for all channels on the device
Thread-Topic: [PATCH] uio_hv_generic: Set event for all channels on the device
Thread-Index: AQHbiLEONmJ0LaTVDE27zBJ6w1ZcUrNdEAHw
Date: Fri, 28 Feb 2025 19:11:44 +0000
Message-ID:
 <SN6PR02MB4157E89BBF2C3707D52CD5DED4CC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1740617158-15902-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1740617158-15902-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM8PR02MB7878:EE_
x-ms-office365-filtering-correlation-id: 9e9c400d-cdb3-44a0-aade-08dd582bbda9
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|461199028|8060799006|8062599003|15080799006|3412199025|440099028|12091999003|41001999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/x1jg/0Jnkf0bf0nYNvdlHZiWtV4uk44OWgM4xcJkPbChz7D1oHEwaTJSnEP?=
 =?us-ascii?Q?CeOIrfiLULcI9/PnbkQ1JyPwNdphCkn4BoHzpIHHet4iIflUmcDn5oPC3HUE?=
 =?us-ascii?Q?Y+xazQmQcVbIhdEzfb3SVawppbv3cZlv0U2c7bxNOzjpEMjSbUa82j+VWhyn?=
 =?us-ascii?Q?yr20mSQD9M2UkB8hxTI5QwLCgUG0aWeUNsUA1ORaCwtE1dqhjUROU7bO3h5I?=
 =?us-ascii?Q?zLRdKLCfn0pMaJHzPIf6Wqi392DDZmVRFhEUdfX2AWXkA9iYzpLyk2Eiacx2?=
 =?us-ascii?Q?QnqbRrvazejeCzEDQqlgyXUps2LtSfxmyBaZ5sPc2Upfs3VTIRIVUAewix9e?=
 =?us-ascii?Q?w0IJkJcA6HXBCJoHc5bvrDYB2AcQkO2UyH41vb3lBukChqDOrY1cDczMT3JT?=
 =?us-ascii?Q?yVvsUCpJ1RT2g9m5AocyG1ISqvx51MokUJDaN035zuek9A1kpd0phRF+Gfud?=
 =?us-ascii?Q?s0C343KRYRkfyqyNw64b/S/OwP1uSlgihyZqXRA2JtXmetPnSvPwckZRxhvV?=
 =?us-ascii?Q?fG2fJrRMmmm4ismbvcSyNgbpV0+kVir6p9sbFX6YeiallLFuCFfRBYoWiqZC?=
 =?us-ascii?Q?/zgEWLh4MkYFHvOxjAIROLThPvGJ/UFY8Qji9r5+yqmOQgzaLWrulDs27yrH?=
 =?us-ascii?Q?EuT8gSlAC7L+mGsuUscTSU8mnC5boENgWOSdsaflzYebUS09lSxxq7ilhkCC?=
 =?us-ascii?Q?sytANlI1S+n7y2j4QfSVyM9pse6lxvaxQwL4moJykbplvBTw1kdHrXECzgKj?=
 =?us-ascii?Q?hXeVXor/SUnX2CEnqSARVlAdU5Hn77J9aqCGCd8ADz4bkbpXnkRP3TQo43sl?=
 =?us-ascii?Q?bAH6EnygHORZYap2ruu2ilKjT3mfnZKxePs6GkywSQ+3MSXAWWTDBiHjLGkV?=
 =?us-ascii?Q?ublB0T68I5raa5uY7WLWF8OTix3/J3HB9pRAYkN+XcZ7TOp6kVpUlxg3w4dp?=
 =?us-ascii?Q?2IAgE/M/R22YXjp9yWGMeZVIKluyBIAf9bVkBoLxXxmiILOY8HKbgGGZDfsV?=
 =?us-ascii?Q?LxJtz1utJbBhww89PP1CFAJ6BF3OtVAzk30jXizzW8SdXNSquXOmQ7KMETY5?=
 =?us-ascii?Q?WVlxBFGUFahqQfuwTOZF1WWk+q1iAEic0OF8eEuldB/CK/XiWgY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wmd1VI/vngKTBoOMsujRM6TqVBwGl9GaTtVm09YjVvV3zy/4/4roW147ApS/?=
 =?us-ascii?Q?67cKJCn/4okfVzF70RuEwCb7xt6khoMc4Fag/0z6aeXW8AdA6RHe+H15t3uM?=
 =?us-ascii?Q?V9Ml0uNBTtdrl3lpJziroNkbKAyj7GnqtSF7SACsdTVNqqJNFfrNPuBkRqtw?=
 =?us-ascii?Q?QLJoUxSZCuGZnaQF1KpC4jDVldfJlphFyaHRVC5rrR33h7mdu5vPv0mA5aTM?=
 =?us-ascii?Q?2gmUX4wPclwXGHO6+2bp4T20DKXSxSm0mcoWGlrRzB8azHiwW6Yqd5YPt2cM?=
 =?us-ascii?Q?Y47FqcuPSbPlQV9x7f59wF1hGDX3RX3drZmhTxpbtTh2KgKSyreyKH9GGMAR?=
 =?us-ascii?Q?6nILgzGHQynnV+U/28OLB8dYtdLMoSqnPS4VzOjiPNwU2+kMbFTSdt8l3KSb?=
 =?us-ascii?Q?UWMBQfcBAVhfAuCrXKlEaOsVzl69NKWu3N+xYMQ6Ddo6AN0Bw1yvjiD1yaBQ?=
 =?us-ascii?Q?hDS6RxcTl7uM6gAfyueZ8L7aKjVWJk6GzK1oi658hLxcMa9fp/Cbnxz/iDnZ?=
 =?us-ascii?Q?KJ8Kr9yE5Xui2PAAM3gB13Jk9KNvi5TBthIYXBADea9Zbkt6OIgyGAg1z2TE?=
 =?us-ascii?Q?EWYKAWWgb7660lGAqD3ThhYC6Nit+VK0ExcdUwOcGXhW/Uj1Z0JQODLvz2Ki?=
 =?us-ascii?Q?Fe8tDFTzi438Q9+MNajiobkfZSOKhelRosAu5Ot24Qi6Gnp4KlgPvdNT+Yvl?=
 =?us-ascii?Q?6LA0D+IDrxVWRCxrN8ycp+INz9djuWifZhXwi0+zC65tSHTCHjb+4Rikd8Ao?=
 =?us-ascii?Q?jB6//3aFzUtKVYmNB6SOdexdwnFdzFbNmOZkOYal4dkWkk9TYvUvH+LBP9Sv?=
 =?us-ascii?Q?1b/RZ+DZMgBGLrhhfWP12rRGvhtqSz2WuW/L+AUzyYAe7CRYViAeXfTEn9ZN?=
 =?us-ascii?Q?8BfskXqRLqbXuwY0aqHKEeh7idJJRKdcj+PfnjjA4UAbZsjhdBphac5L6Dge?=
 =?us-ascii?Q?SFrzHyF/3Bpo6S9zFCwypnybByYWesnZshR2Qp5ruDANsTbkTIeWN+07jvcK?=
 =?us-ascii?Q?DmzfyUsucVfYsrwqeW7WbHkE0oKnUMNXlAUGRFpKh/+04N3A3I7ubBxIhkJf?=
 =?us-ascii?Q?9ujB6trtYdfTVNApeqcLTB6VjRtH+ofD1le2stcH8UcS/TdHTsUmR45z10h1?=
 =?us-ascii?Q?TSUBUVHMeE8mQC8ETog36+iNdT6LxZGHRATN+6TQbodA8YW/1m39Cr5vJE7b?=
 =?us-ascii?Q?AH3gaOfEvHG2QWGCI9qXr/irK+MklBOwPojoaC43b9mRKALj9snWsyDi2Ug?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9c400d-cdb3-44a0-aade-08dd582bbda9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 19:11:44.5088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7878

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Wednesday, =
February 26, 2025 4:46 PM
>=20
> Hyper-V may offer a non latency sensitive device with subchannels without
> monitor bit enabled. The decision is entirely on the Hyper-V host not
> configurable within guest.
>=20
> When a device has subchannels, also signal events for the subchannel
> if its monitor bit is disabled.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/uio/uio_hv_generic.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 3976360d0096..8b6df598a728 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -65,6 +65,16 @@ struct hv_uio_private_data {
>  	char	send_name[32];
>  };
>=20
> +static void set_event(struct vmbus_channel *channel, s32 irq_state)
> +{
> +	channel->inbound.ring_buffer->interrupt_mask =3D !irq_state;
> +	if (!channel->offermsg.monitor_allocated && irq_state) {
> +		/* MB is needed for host to see the interrupt mask first */
> +		virt_mb();
> +		vmbus_setevent(channel);

A minor point, but vmbus_setevent() checks the "monitor_allocated"
flag, and if not set, then calls vmbus_set_event().  Since
monitor_allocated() is already checked here, couldn't vmbus_set_event()
be called directly?  The existing code calls vmbus_setevent() so keeping
vmbus_setevent() is less of a change, but it is still doing a redundant
check.

> +	}
> +}
> +
>  /*
>   * This is the irqcontrol callback to be registered to uio_info.
>   * It can be used to disable/enable interrupt from user space processes.
> @@ -79,12 +89,13 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_stat=
e)
>  {
>  	struct hv_uio_private_data *pdata =3D info->priv;
>  	struct hv_device *dev =3D pdata->device;
> +	struct vmbus_channel *primary, *sc;
>=20
> -	dev->channel->inbound.ring_buffer->interrupt_mask =3D !irq_state;
> -	virt_mb();
> +	primary =3D dev->channel;
> +	set_event(primary, irq_state);
>=20
> -	if (!dev->channel->offermsg.monitor_allocated && irq_state)
> -		vmbus_setevent(dev->channel);
> +	list_for_each_entry(sc, &primary->sc_list, sc_list)
> +		set_event(sc, irq_state);

Walking the sc_list usually requires holding vmbus_connection.channel_mutex=
.
Is there a reason it's safe to walk the list here without the mutex?

>=20
>  	return 0;
>  }
> @@ -95,12 +106,19 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_sta=
te)
>  static void hv_uio_channel_cb(void *context)
>  {
>  	struct vmbus_channel *chan =3D context;
> -	struct hv_device *hv_dev =3D chan->device_obj;
> -	struct hv_uio_private_data *pdata =3D hv_get_drvdata(hv_dev);
> +	struct hv_device *hv_dev;
> +	struct hv_uio_private_data *pdata;
>=20
>  	chan->inbound.ring_buffer->interrupt_mask =3D 1;
>  	virt_mb();
>=20
> +	/*
> +	 * The callback may come from a subchannel, in which case look
> +	 * for the hv device in the primary channel
> +	 */
> +	hv_dev =3D chan->primary_channel ?
> +		 chan->primary_channel->device_obj : chan->device_obj;

This certainly looks correct and necessary. But how did this work in the
past? Wouldn't DPDK running on a synthetic NIC have gotten callbacks on
a subchannel?  I'm just trying to understand whether this a bug fix, or if
not, what new scenario requires this change. I'm not understanding how
this change is related to the commit message.

Michael

> +	pdata =3D hv_get_drvdata(hv_dev);
>  	uio_event_notify(&pdata->info);
>  }
>=20
> --
> 2.34.1
>=20


