Return-Path: <linux-hyperv+bounces-4381-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FEAA5B771
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 04:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4AE16F40E
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 03:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C38A3594B;
	Tue, 11 Mar 2025 03:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="drnk5nmI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2010.outbound.protection.outlook.com [40.92.47.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299D51CA84;
	Tue, 11 Mar 2025 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741664864; cv=fail; b=TlPI0uDjIC5/Q8C18rtr+HjjRCwSbP3TCmgl28fmZyPkCtC6PWxMNfo++15ZpVaRfNU5BuKmhv/Bdo2PXPDU+JcNsLKTrtZCxzNAGhZrMartoPf89ue8jKcM4N+Q5fymJqafpgwplCSgeLaFPh+wmQEuJIPYbKBbpuHXXK5eCSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741664864; c=relaxed/simple;
	bh=VouRhnMI0sRUd3LWFkeQn8eT19d5dp1MDif+Ke6x4nk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RuWasdIs2VT6HMqYU6tRkaY1ZWxMiX74O8Q3qmxs2g1G/sLAzCs/0WH2z8f19jpRVq5R5cufrsglfNJ6m39P4jbymqFFwlJq9nbkt/ff0kaSqq5pejoglmmb9Mf0WY1PUMGETKRG1DpGZFz73ZHjg1iW+7p+cLcW0A3x6+yHiwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=drnk5nmI; arc=fail smtp.client-ip=40.92.47.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCPs+moJgzf4XWsgpjvz9GP8GZRa6ig1lQF9xy7YAc2a0xEDaFrOVm8OCwsEFW88OsMSC1dHQxqzlAEK96BhldgyXS6RPg7HAnoH1xoYv1Qm+BPQ4ItBgBxmzyJyM2NhrJcD4EqDTtTLV4ukPpgms+fWBwFjyKpTUVUIWVXdNvWBKa/0t9au2JwtM3KT1DeP2Sz4Bps8lid2eW9NyN0MekkhhySLG1TkFUysttU7Nr/MUdDhQ+PmMb0NfmKqGLyS2e1nY69GpLsl47/tB7TLf0DZgt3KOSwcGgc0iKlxJ46Yly4UUBASmKm7Mt1mBHeFAuh2Y0nA0E2TbkzwwNqjUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlMu3dGjockcmYldggg1woJxdbsF/xh0x9nEkaaLZWc=;
 b=m0R/PW59LiqAGXdMo0C/F0uQ9h+cectw5DcdKF8JGwLJaTeDwfT1gxHeHFmzrjlk9siEVFPyfyaX8n8f64r19rc2qz0zrzKosyTQf8H99hVxyhROCfo8lbn4VEY192iSe4aO8NWXK1Gul0P5Q1H9/MSwELU2fluxgNBq2to/ny52zmHTwnCzzmaNk50BfgsZHGCy7gdKAP4zOU7GDOII66zpE8Yhfjxnir3DDQwm7oAEnAcFwPSujvYhSEHpYUlCPvtcOVUkS53NTp4eqe5bddrtTeTOopZozmbo/Qa+ks2aOXzwV4OaZjw6nZ6hgxcBl8v76mR7Y0Y8OqBAyZ19mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlMu3dGjockcmYldggg1woJxdbsF/xh0x9nEkaaLZWc=;
 b=drnk5nmIZ3ehOUAs07GchLafViBf56MHQ8XUzmyL2Vp34qqjxTZHwcMYM+0Axin478SLdefH+bmiWm+gY3HhBfCoFtD82dctUVIYHLLi0JaATZJAypoZjpo4qVkl78Hyf5kFP4s+78RK3BViTEWiO0NcD4GI4o0iD9YlO1q14oiMIfX5rBOMHI/RukWoRHB+Q0Bz8wjlamJRb75LfhQe//L40xZevtp3lYsD/b/WppvBb17VHCpl1M87qEJQLC6droyxtpgQ2wAiVKbhGSYagSj29zIqfEW8pz+ZHVIGt5h6rpK0c+WXzY92JXgOS9KtGToeg0I78I8+sgL2EDy7iQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8636.namprd02.prod.outlook.com (2603:10b6:303:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Mar
 2025 03:47:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 03:47:38 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>
Subject: RE: [Patch v3] uio_hv_generic: Set event for all channels on the
 device
Thread-Topic: [Patch v3] uio_hv_generic: Set event for all channels on the
 device
Thread-Index: AQHbkgl80f13qpMfKUqxol7QwW6Sc7NtTDgA
Date: Tue, 11 Mar 2025 03:47:38 +0000
Message-ID:
 <SN6PR02MB4157661442A98BFB28855B49D4D12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1741644721-20389-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1741644721-20389-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8636:EE_
x-ms-office365-filtering-correlation-id: ece7126d-f62b-476f-b902-08dd604f77dd
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|15080799006|19110799003|8060799006|440099028|3412199025|12091999003|102099032|41001999003|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/kFZmh5Zuw7jG2ADrKRlK2TG7rpcYVGL+ZwtEaVVZ8k+tCmpWrJQDwP3IaZU?=
 =?us-ascii?Q?oJffWVaLMZxkYXYQj6nLTcY4K49un7DitpkB8n/fwGZ198wWC+WHWxWfP1jj?=
 =?us-ascii?Q?VP1/I3iN3iPvYXooPXAVlUmZoC2m8SIXkld1S2CYl2RwQdOIfWgmSCANNusW?=
 =?us-ascii?Q?2pLnfzG8725iocvCssLDLNEiA8yxeHQIJrtJ98SamaUR2C7zVZOjg5pNHAU+?=
 =?us-ascii?Q?5ra+QIuzWuAquUVobpT/JTvntFEVglHmzf6G2PPk0mfmpTKSC8TR9EMj6x7J?=
 =?us-ascii?Q?nYoAS3s9Amyr3d+ULr2OVoPDeOi9XDuDxnKNP95AixHrpxVI01TEmwO2Yb0i?=
 =?us-ascii?Q?gdkRlUDsGa5/GTCrqTwIgaMcvy3+VgwnW/QMyzmfqlEbPB1mqhGJel7I7X6h?=
 =?us-ascii?Q?mahmuxDupFDV+mzsIuTj8AkitzgXL6xM6oa6EuUD3V2Rsq0GosBesYhtQxnY?=
 =?us-ascii?Q?d69yJb3gn/22kCg9rQYu7sEYJE0r8bpYaPR1ikynkXf8N/n8QuWhBMggBj4Y?=
 =?us-ascii?Q?2yAijRmCEaWSETszcLXjH/a8j+3n8Dj2Z/thTyN3IbQL3r7Ut+0EtUfBDrqD?=
 =?us-ascii?Q?J46gUwF+6UXMD8rlAxCVHCppYmhbkvE8lEJXd+B3zQJWjSoxJ+FQa7o5nuJP?=
 =?us-ascii?Q?6UOANJlodmnrqvVRCEQ3w0gKvg0jSevr1AjkDaPXVTnSdinnSS4CzjFGSuBj?=
 =?us-ascii?Q?RxG+e/peS8mBiUxx5Eq4cefex7WpQ/mV1awTpeT7rwWGd4SRDML05tfyPUaV?=
 =?us-ascii?Q?0XOL+xacUtopGbIuE/W7R/jlUrKs68myufTMqobFLimtgph3vRXXL7AaxHjC?=
 =?us-ascii?Q?63/DY/EZm/wPJgm9xD/iRVlf28Z4QeGuxlSZAXj3K3+YIyK9lHJvP6fKjEmx?=
 =?us-ascii?Q?tNXvVH7pn5xd5/CSmg/pC44YC8Q/6PzY+qzdCis6+ezEQ2PYfagj4MPO/Zd5?=
 =?us-ascii?Q?VFv8cdH0MEr2+v5mUdyy4oSKKjLTGOgyk0844qOxPrM2vQwBaKSEZyFos3CH?=
 =?us-ascii?Q?0H+GtufmNdFn89daMxLBoxfrCxDqD5wWPqFjewjtg3DPFbnIe/OWdJPyyMSU?=
 =?us-ascii?Q?2AXHuuI6E9nWaVNOwkWtubZphIWzkrCC1pD/UwfMTXGgorpTMU4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f/2Ppy/xVApLA1zdlkdgbgapxlvfD2bBw2G2eetJrtdsiMWgyPF4TTfNn8Le?=
 =?us-ascii?Q?sFxEL1YWygpuezz9iuQLG6kK5AF8+/UnteByjcM8XNzvP/yQ1eYnJ7FXSS9/?=
 =?us-ascii?Q?WvClgS8ytoi++Lt2J7UjcXnSXc5ZSad956rOCKWMufEdWZfbZ0YH2DkRR5ZP?=
 =?us-ascii?Q?UOtUhSS+bckMq1od8CH9TofMZ8YC87FtGwH16OhUqbGRA4lky8wANKXJoIMH?=
 =?us-ascii?Q?dKgrUFqBS83y0xVZbmZ4vssTCjy8UHezTZqiNMrNNapFq2nOIIHUV/1hlS77?=
 =?us-ascii?Q?6Y3DxCCpHGZWuJyDuzBGRGIx+5vra75VmNUT9VLYNJ5WjnVJCdxUj1v+qS0g?=
 =?us-ascii?Q?t/gEVjPGs+tnZLzlqUnvfxORwqypDm9C1P7LJuYXWxQmDKlI6SQn3F806alS?=
 =?us-ascii?Q?ys2IgG5EByektsHwPP88I2QbZokCEBsSB6LpntopePHU7F4RjdYeJJcnTSq8?=
 =?us-ascii?Q?PW0NNcQCQDnqLUcHqdmWf+hlLTfzSIbaH/ZqfN4fdIgB5Bblocl6fYgsRIOf?=
 =?us-ascii?Q?9jnff+un6hDIfWcUFGlS25B/zPr0hyxLUD9c1cMJihr4vNBRmelWtizBrkzr?=
 =?us-ascii?Q?+BUdzgMJIXNvOfAuG7WAHW0/IlICOYcluLLCtmn+BlJuoL2JGqTG53EZoZU9?=
 =?us-ascii?Q?NYpExm85+1kYwYxdPE9kgT+gfzFL5ICiBsKfQImCnJN+rluOcXqY7SDc9SfK?=
 =?us-ascii?Q?HICwRsEO7Xhosl3y+uPs0WrtXEmQO92h9VNGB4GzhYBkG8N+GbUadvZiB5IJ?=
 =?us-ascii?Q?XoovKa/VJZUD/GOjxNNoTb+t3edGvHu9IQ3dS0Yz0nSS/8A3NHpFSYiRZbhp?=
 =?us-ascii?Q?p8lrUNalZM12QesDgSHNnSWGC0K/muVgg6VtP5o/Vly78EhGKCimtcDHncZh?=
 =?us-ascii?Q?HAsiop2OCdk2xMKg4eV50xTKblLFnIP03ZELZoSAa8VI1DiCFVzvdxAppJG9?=
 =?us-ascii?Q?2W3r4gyqKb7RkkhlLROrMqahs5uNSIPmPYsltSk+bIHe26xlyetUgpARqQNX?=
 =?us-ascii?Q?/mWv7fe7MF+z1UG2PgBJ/xb05MGIkHKue8atZ8O8aBjszfsI0+NClRaP4iGe?=
 =?us-ascii?Q?RnxQfPs21qnanKH0UMy+x5pWpjf4NMdMHvEnFXvp5KsphA2eHISQGwATAEWv?=
 =?us-ascii?Q?96Ji/IaSt+CKuVP5E7eiucwPWA2vCN/YwLD/b/cqbQRIfUm80TGz2wkp1Izq?=
 =?us-ascii?Q?rMolBL/ncaMx+ozzI08bHHU5FAMgtjHfJEHeVMkoTvJAddTXMQF5HW4xTKE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ece7126d-f62b-476f-b902-08dd604f77dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 03:47:38.5910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8636

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Monday, Mar=
ch 10, 2025 3:12 PM
>=20
> Hyper-V may offer a non latency sensitive device with subchannels without
> monitor bit enabled. The decision is entirely on the Hyper-V host not
> configurable within guest.
>=20
> When a device has subchannels, also signal events for the subchannel
> if its monitor bit is disabled.
>=20
> This patch also removes the memory barrier when monitor bit is enabled
> as it is not necessary. The memory barrier is only needed between
> setting up interrupt mask and calling vmbus_set_event() when monitor
> bit is disabled.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
> Change log
> v2: Use vmbus_set_event() to avoid additional check on monitored bit
>     Lock vmbus_connection.channel_mutex when going through subchannels
> v3: Add details in commit messsage on the memory barrier.
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
> --
> 2.34.1
>=20


