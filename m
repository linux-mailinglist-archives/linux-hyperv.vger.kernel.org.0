Return-Path: <linux-hyperv+bounces-4179-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 452E9A4A6E8
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Mar 2025 01:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112F23B761E
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Mar 2025 00:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A2A4C98;
	Sat,  1 Mar 2025 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mg4H+6uz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19011035.outbound.protection.outlook.com [52.103.14.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1C257D;
	Sat,  1 Mar 2025 00:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788383; cv=fail; b=GB5CX1HpSkEU5B5FyjgoRV/vB/+aTlMaY7ml6heqzi9Cbz/CEz9k/sHQqa9anwxKLMHDQgWBm6OM8OJghJ+q+lwvnE8PANOQBCbOx5BdsV4+F9+flEKx+Y+FmzIPnWaqm/7Jt7usG1x18Y3LQ1bbmiLssLgCxC9NtFEgBU4E3Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788383; c=relaxed/simple;
	bh=H+Nu4S61zQ5nAJmp+kj26J+Sip6qjN/MT64AhairXOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aN4WaPU6WYIRjDy5vVgiMDwPxMHHLt2vBT3PQlWT1nLoci0AvkRXmGU4A8+YEmVbuIxW/SHK2YrYhRKX9jKtf3uML6rKYNvSGpZUkbZlao3uM9lH0aClceu+NyC9rs+IkpQ1jc17fyWh4xAoDMPvtXCmPlct+67pWK3+LLFgWBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mg4H+6uz; arc=fail smtp.client-ip=52.103.14.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlcVTAR5bE8NS6I97TEnPo4VnMODk210Bd6GTvdogbXjyAcPlWBS0VP1eB1Si7zRQ4ckjY1V4cQllw5xaVJOlzrFZ4Z20PKy8uqJ+KJ2PKGr67ADBq8V0e1ucpAgyf5CkKqBQiu8RgLjWzhttlg72fUCY+Sj+pjcrAEDInoMfg90Isf2PYTGtAMGm+7zzjOqPbezS5nh0xPe6gyKSDcGQNuif6FsSXFgg9F6zVO56v/kOHNbWIZR0eQeDPpZd99ZhIsVNs03qu4vd6dw/fh211pegf8n8i7nKp9XkhLTnbTVIn6jIzhxWmjYWSSNQauW9mYfqsHA3RcsPCUauCuZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh0dggLnoVfpGhPbd/Rw3kp/2RSYY8yxhOMD8fLLgfk=;
 b=k9WTOYff8TJ+kkrdCBL3xyjiTdlM0Iy24tC0gkJLsCpgWdWabQcpxXMciiFf7oxZZADd3x3mw7eZfbSrJIYTanBVHJ1r5M4NOD7yvzs/j7OhPw9DV4sUx6ZOag8NdzEI55EVQAEQ3MDA58OrojHTMycrIOgRUQ2HXPa3iE40beHu9kFJWatGYnh1ZC8bz6wpO+UfD4+WbvyC11THGyhEOxuX2o0LUVIObvvKBdJl6wNlWZkOyXEGPFgKU4GfeDtbm2Zx4dqI+nYT1rJfNtW3zF9PXVSE9PK8VWZ8Eq+2fiVdYF0K+McENQB1D1PusxgQXTUU6+c8HkLSknDd1Lq29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh0dggLnoVfpGhPbd/Rw3kp/2RSYY8yxhOMD8fLLgfk=;
 b=mg4H+6uz84mV6V4moKO3mpppjuJxwY9nL7UYukdCfXkLoqS0XtVZzAEZwR8IRAbT/Nzye8bQGLZPDywXw8TTarBenx8Caxehsj+hi57gb68v47JsTuRNrQ01e781BRVl0Ie02bLSlGFe/ZmsgufasFMeGAsA9gYy1FswRM1icZfKaMhxnMAs4U5oYW4dUN/ecVcjXAj0DqJ/iX1qe4Q0fMmrhJYS+WyHLBZSIrIfW0spUBV3nR6etpjOrLHnp7ZxIFZ4D+FlyzCYL2+on/xd5RemHWZ1izHPM0DJXq+F1HYHAZ1tKr+cPb4SpVGWO/a1/WNE5WRhxY+5PzNdFWBVIQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10079.namprd02.prod.outlook.com (2603:10b6:408:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.23; Sat, 1 Mar
 2025 00:19:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8466.020; Sat, 1 Mar 2025
 00:19:38 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>
Subject: RE: [Patch v2] uio_hv_generic: Set event for all channels on the
 device
Thread-Topic: [Patch v2] uio_hv_generic: Set event for all channels on the
 device
Thread-Index: AQHbii4+MWo8tbiaFEi6bPS++jfWNLNdao1g
Date: Sat, 1 Mar 2025 00:19:38 +0000
Message-ID:
 <SN6PR02MB4157BD8F32EA78ED83EFB520D4CF2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1740780854-7844-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1740780854-7844-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10079:EE_
x-ms-office365-filtering-correlation-id: 03b68e00-a8a7-47ac-354d-08dd5856c13e
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|461199028|8060799006|19110799003|8062599003|56899033|3412199025|440099028|102099032|12091999003|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?r4XX3gDjsyvUzdAYQYwtQyxwsCLDjrpHqG15i39NTmJuMVHMIGze5YcyIBKT?=
 =?us-ascii?Q?hdw40f4dXd2DPE7QDjKF30/CktkyrpeL0HVy6Ub04OHh5P0SjAEtikZ9TF8y?=
 =?us-ascii?Q?Gl5azb1CMKUKckXoRLtJXRKuVXOnE1qfeqbPcOi6EUOGYJIcAu0gUULf7lSb?=
 =?us-ascii?Q?l4zKYunTDexj1W76VqnO5cJckDin9yQXWJfpCZZhO5hXq/G54UH1pmvWj1gt?=
 =?us-ascii?Q?iUVt7d3W8pDyTlqpt777w2M3WaFgfSJK70vUft6f331UyUMa+q5iO1nYmOCG?=
 =?us-ascii?Q?p2zpFgVSFIaDgK2tEOS0OJuqYrHlbAZvyezyH6BhqMZwcP9jG//Arw07mjor?=
 =?us-ascii?Q?Tvyu989YTA/wZzbGngqgGKM6JNU1XY+I8z1RrtBMA7C2vKRBC9kIMfh42Eqy?=
 =?us-ascii?Q?qN2riR9pnrC6Q1/tAguct/m3m1z2mizo2wS5E9MGiLpSNoTxongvV5Zb+bhj?=
 =?us-ascii?Q?pgTPIfKVk7A13VBNaDDnBLgiYNWuHzxMW+hdpmIzhNmMA8Fp0S8PUw55i+1u?=
 =?us-ascii?Q?4GhJHeoh92T7A9/lvgOvNCCPl5MFf3MGsZ9LKlzdh6w8BdFAomEC2lxyz4nE?=
 =?us-ascii?Q?7KK4PmNuA+U8xNQFCrXIwUqfyweY7DDmNnLiBs+cvHVFzTYBGTCuZTLCHeWK?=
 =?us-ascii?Q?7kg4Wk/Htk4RHt+zebH2WguM9U3vQmrqh6N8lZbtCIgtqE3Kj7cjOxfyEtGv?=
 =?us-ascii?Q?3+fh3WzgkgF8oGdew0MnLk41TydXDdWwH8LxgqjmdeMMFhCcc4pod894cTLf?=
 =?us-ascii?Q?ZWR2MvFf6IMo1MMb3uwSm4vNhOAfYxzt8qipDJKx1462WgBVvmlhDIalRcGT?=
 =?us-ascii?Q?JmOhi/2EiU26Q2BMbKkRB2rTMJWaRq3Rmg2w4WfDkQ2IY1whX4cWaa+uMf9D?=
 =?us-ascii?Q?7uOhHsX2kj8lNdzk/Hp+RI7y0JhiTD/C6XVyYpiBJrz3ox9RepnxqLYQ3ud3?=
 =?us-ascii?Q?fvEz84UrwB1/hGvjQkOf+NNN/H6VF9HFA3/KxNS73PNCbdEDx3Q2g7PcUxvI?=
 =?us-ascii?Q?/2W//DBBRbUpDx9eJTSlStDhgzMhkIfwPS/plGh0aHLPLotReV1lpOExqa4z?=
 =?us-ascii?Q?lVXapLzD/Wz+7Us6byM6GC1qn0rBgjy9+2xcBx87JbZIG/ekKrs=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Hxv4lXH+frEDqTIXDhONddIj+ewu9ZudA0P2obiPUjbMfK+qbgLJ+4MPKuWs?=
 =?us-ascii?Q?EmkekTnHBZrFfIpVMh8m9U5aw64iF995sbeNbvhE5N0+JlaeeAYzj8AnJUS9?=
 =?us-ascii?Q?9UPaghDR3RTdUcAOdBVpzTFekvv+sjgZAkHPBo7lpf7UTnV5NmvH0eXNXm+m?=
 =?us-ascii?Q?lHOSoIYkOA9umhVjMQck4tuXtrWHnX13GG09gQGzMCCW6NDrefr3D+0g3v+z?=
 =?us-ascii?Q?1jUF9s/gBp+8PtsmgWeitSc6rasv7WgRVaVFWKD1t1mgZTiJa8pGjb01MPSx?=
 =?us-ascii?Q?BpXsV4oLwQKG670nujyPOI/kKujE32TmZPB0mmBlrhVcnm5Toh6iXs29mVTj?=
 =?us-ascii?Q?YlFoJRFXlIb7yB5vlRMlRk5rTUtFVd2+Zhk9rfKfZ5xN4YYtdB4YMoe4EiYt?=
 =?us-ascii?Q?NIVdBySU6NE0mgy8eo3hU9GryFlo3xRSCimzsZ533adarwuNwPJmI5qnBl8D?=
 =?us-ascii?Q?J05WOVeDBQoEAtkNCr66VaPfv5PdlZkV/LOI7gzvfZ0JBsPJ4zGJoMpwn+pR?=
 =?us-ascii?Q?f7p3ukF+trAi+VjZHbPZFRxDlN5Ea6MIr9Nt/pf1uM8JvkuoJdxBfK2vo+Mo?=
 =?us-ascii?Q?xRZgD/MUQM1cR33sNc03WC2e2iaq3DAJ4/SwVBFEHGYvbyiLEIiuMQwkL6sw?=
 =?us-ascii?Q?jiKFMSsBRKoZ3osI7HMOjOq8PPudZF8Ri+F46coUXww6O/HOImrWrvJ3RWQc?=
 =?us-ascii?Q?bVO+z9eQHzbc7xQdRwy36/nAddrrv0XW+wo4NHqQGM0e5buehB7g2Gce/h4p?=
 =?us-ascii?Q?Iayw2ypZVJ+X5pavZtZo84y88Nd2Vnkwh9SGhd6GFq1TRIpe3XcAMcrirPqR?=
 =?us-ascii?Q?jsxTUejfqtXBH9hLCwJJK44+QOGUYwJ+gZUqNWhLkyTIKXC+KB/+GaiTVzrD?=
 =?us-ascii?Q?xQThTQOU17iUCoIZfenBqldIjS1QQUyNv85zNkTcsxXwwR7M6s/Yt2fTJi88?=
 =?us-ascii?Q?mzZM7tMu3tYphn3SAwvwCT+4vMOZiAZSKsLL5EJ/YZhA9RttdSBQuqwdOGTC?=
 =?us-ascii?Q?s3TR8EE0p3cj371zltyDn6/Ygf1wMk3NXcURbPCkLMv1KgLVvmHBRn6unUo1?=
 =?us-ascii?Q?v6R4eXE051PKkqo7/ceT9JaPHIPnvl2du2bXW/wj9wxtW0mbMVAzCDpj6KEv?=
 =?us-ascii?Q?6pQWMz9XoLCpJVBggzMMCPojlD5EDH6QU5OeEVR9UYJVXxRqu7DujqTGlYxv?=
 =?us-ascii?Q?myhevG3TiaAwwIn5hOdvvI2nf9Z/NHPwubf9VzLCHnV09fhcmcVpgLB76mc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b68e00-a8a7-47ac-354d-08dd5856c13e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2025 00:19:38.8914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10079

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Friday, Feb=
ruary 28, 2025 2:14 PM
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
> Change log
> v2: Use vmbus_set_event() to avoid additional check on monitored bit
>     Lock vmbus_connection.channel_mutex when going through subchannels
>=20
>  drivers/uio/uio_hv_generic.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 3976360d0096..45be2f8baade 100644
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
> +		vmbus_set_event(channel);
> +	}
> +}
> +
>  /*
>   * This is the irqcontrol callback to be registered to uio_info.
>   * It can be used to disable/enable interrupt from user space processes.
> @@ -79,12 +89,15 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_stat=
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
> +	mutex_lock(&vmbus_connection.channel_mutex);
> +	list_for_each_entry(sc, &primary->sc_list, sc_list)
> +		set_event(sc, irq_state);
> +	mutex_unlock(&vmbus_connection.channel_mutex);
>=20
>  	return 0;
>  }
> @@ -95,12 +108,19 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_sta=
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
> +	pdata =3D hv_get_drvdata(hv_dev);
>  	uio_event_notify(&pdata->info);
>  }
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

