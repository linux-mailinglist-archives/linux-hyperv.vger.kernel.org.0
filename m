Return-Path: <linux-hyperv+bounces-1737-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0A4879D1E
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 21:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4D92835E6
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 20:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CD87E10A;
	Tue, 12 Mar 2024 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="c4FWcIwV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR05CU006.outbound.protection.outlook.com (mail-eastusazon11023015.outbound.protection.outlook.com [52.101.51.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D25C382;
	Tue, 12 Mar 2024 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277061; cv=fail; b=XQTtY/AHjGPlC4yHUSqSUik9flThgBxvjm4t2FCdQcFHmGHvnftxZjfDGzc8kgrmuvn/4Y4Z3GQEUs8VlDU2fsuM47A+E9cO0Rh9smwAaMVUjb/Rj35g3d/1bOIdCtselIv3yxwbOX95AJ/4Idp/ejmq5ty88mojQNX3IgESeFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277061; c=relaxed/simple;
	bh=bg3VLPL3rQ7t5ZeBes9oKsQ4iNzA3/qoc4WADmFm68Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qUck5ZJCgwo4JbsxsEVAmz1fej3xYDNz4hyfH/iohTficp0/gEjQs6vQKW7AV9ZAJgLnAdzjltk/BJu8YdcAZA51bGxkmr+dDgPNO1V3tAE32j6cYdz0Igd641QFlzL50KSBDXyFeyO1tRnjQxUfO7keVrEILjvVeu3vmTD9bmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=c4FWcIwV; arc=fail smtp.client-ip=52.101.51.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgHsVVyhNHjSRVFjVr0/92g/Pkb66suBixKxpr3rgczUrpxnIX4k7EFDMeNd+RaOHrFSpLbgeTIqcwNx5cvC/e/Vz5g+p/mgEzs2FJi6q9jPtWQTev6e6GzbAoGAfA1EZ5pCFfq5kSGvw4kHzlQYs6rthp/LAhOKRlQYIk5LzU+0FExjNDIWk078Z7Gs0Oh1RUviK3QS4QOKa1EheGn+7YsQ6swInuwz8dVSJWnseOLnD5s6XuKROsGLMW9tloawKn0AKm449lAQp6is+/cEB/PZhIpDP3CdLmRzgs4dsGypLHWRLX4pAZka4VRfodyB1UjPnKQpdaqY0DUm+aw6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwhieiwJ8ql+XEO2Z08Jij+WSgtcSCMPw6HcwAHUsrs=;
 b=Xs2ri+jwNKTpdv6XEicNcLglcV9Qsxixg02wraGmgEbhuJ/CDUR2r5R/JGWf2yCeTipv3hSLhjVEO2HyBZx53ORzgqW1EHKy9ja6uvv+feP5glILY/05cSonxnS6d+uNEh1holha7Gwj0Rv2uCvuPWuycM7zzSC2jiNxNX8RCNLBSGK0vMETX/tKIBvfvlcoC6UjmQb5QLLOl4TYVw8WEELBiZoK6Uljd7dYGwdlpHVwM5oLt40ztuuUxlerCh5zCHa+lF+/tiQPex+XFUYyhTlkTQH641ivgXxWLJ8aR0I/bTBcunIsQ80xROGUNH8QCRaFRqKmuNqwWVz6vITo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwhieiwJ8ql+XEO2Z08Jij+WSgtcSCMPw6HcwAHUsrs=;
 b=c4FWcIwVMZ6tEVuauAre5I9YlkbLl2vxVgwtKBwo7DLhYmtOxSeADC3+ubszAUn+DAB9SBmg14cGg5Fp+71iCZKe4kZJV61Qe+C1n73Vs94FJNmPo/lZPplkY2ZfJc4ydX3DZMc65jo7Ny0FMQr0h+0F9KfWF/cQ5cMFgukJd3A=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by PH7PR21MB3236.namprd21.prod.outlook.com (2603:10b6:510:1d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.13; Tue, 12 Mar
 2024 20:57:35 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7409.004; Tue, 12 Mar 2024
 20:57:35 +0000
From: Long Li <longli@microsoft.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH 1/6] Drivers: hv: vmbus: Add utility function for querying
 ring size
Thread-Topic: [PATCH 1/6] Drivers: hv: vmbus: Add utility function for
 querying ring size
Thread-Index: AQHaYcvPQWb8WXDgsUGM5pUS3fQcJbE0u2xg
Date: Tue, 12 Mar 2024 20:57:35 +0000
Message-ID:
 <SJ1PR21MB34579239AC3349F4C28EBF63CE2B2@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <1708193020-14740-2-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1708193020-14740-2-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|PH7PR21MB3236:EE_
x-ms-office365-filtering-correlation-id: d9faf91e-07dc-4fc3-b906-08dc42d70b65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xwvjVYibIMKMw974KVRAPGqU6rMkGAHt4kzRqjkV04e9GI4sMzMz5VqfStNHLjTXBtMIngkLVP7qRsbGUc+xB+1Ofvxhv2W837KNoW3DV/zU043kVuuBYgstEFlFuPNfFLg2hCvRF68ZViOP7EmPEbOQyGuaIy5mtHroQp4qKlseJysSoLiLLOWRYLx+qna8hvMisb6dteGKIIiJbdPza7AGvAeDE6x+eyFXiPAGrJUUbAHPL02vWdQfGzXNvQIg6DdQQPgrucL0BnCfFEgtr4idu4rEzoHoLIHzR3EOh0fiO14dPbj3ijs+lgFCAKIm+JMWBdpcMc+OL3to3Vv4K0B972Oyqaw35DaUWTpb2SO/mCS4gSr6o4o/0qR7xyaa+7agBpeaeWLL8DO+rSrss02GNmO7mumv4gBBXvyl6CjvYcoGwgeSkpSvFlwo5yaci16c6RghJfUdhhS2ghEX/xba6pxBf9z+wRSDp6qYQn37Oj2d4FnlageoHMtIVYRP+xOCa3WRuC78Ylwc94bym/ZShmqT56pU5IZ221aEArbxfm4b1oSWHrDXyOz27q/pT+CaJ1ZeDBTN/t5kM91Rebkdl3gPP8Ets5e11QSF7VJomTrBjxLt2ZgCBV+l8nig1sGSgDS4h8qUCm2c7OIamnKeAehoTiLpgFwf4NHJ/nSVYLNRx9rA615YXo3Nn7KQH6WHcX0gqdBiWcNuXGMhIzcrj7TtegSm9WnEPG5dRgQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pZvmAfMPyBDxrOCXc6KSoRckbGVOrq8Ew+BXFwumpuWYpaa1c/pNo3/2kHSM?=
 =?us-ascii?Q?rPM30qBaWkOQRzGgpvuZfZxXsdLLl1k9yv11/vD6p6DQL9nmClOKpiUoCObY?=
 =?us-ascii?Q?xc5KgFFacGdYG2P+50Q9lFrGl9ba1LYW75gzF9u1wHa9RWWRuiIXgtwrbzf6?=
 =?us-ascii?Q?bzuvPj5Ezis+B03K0/psZ0EOFCG5uRPvxkXAnj2ZqPQ+kL7vnQhb17pnd77O?=
 =?us-ascii?Q?++3lX2+R+hEpiuBdeQodWyd/ajYmQ0xEFuxpCjLVbwycqQGwA4+fqo9yMpOm?=
 =?us-ascii?Q?veUEZkzHrkS7cA52bVEbh0KwbnqBDt0sLdBbthz7LssJEokyjSQQ7bt/yiuy?=
 =?us-ascii?Q?F1JgdJ0iIzBYUB7uSUIOs4Atfb79/DwfPu1ual9uTMjfv4V2ek3FYZEG9rwk?=
 =?us-ascii?Q?D6hIKXGr/N80vEBaHbsKrohVA6dAN6WCzUCgFpdqUkD9jvAabLmLapTmVfHu?=
 =?us-ascii?Q?mk1TCyUpI+E6lRvkwy8YFLXSXIYxwvdaoiFd37VIq52Rnh/WR10+P0y2KsbC?=
 =?us-ascii?Q?DBpvcJrJmj1fJfQd+2K1MKg6azr9QNQ29NbcutpkxfLQEMeRvKPs5oCHDSwK?=
 =?us-ascii?Q?ujdyLZ6p95a125C20ldayXEGrZktT+hO+Kobe4FBmdZhCQvSM04lToxRC1FZ?=
 =?us-ascii?Q?oJ9DXex8cz+AoHQA595cvQzgHlgaeoIj1Jk2cEp8YyYfseGvWAeUdVVipDCX?=
 =?us-ascii?Q?b5OzIfyNMyFELuVO4Kfv+lLqxRugPnUDneQffs268//x9oOpZ4/jK5wzl+jC?=
 =?us-ascii?Q?SxE8BZKzF+VoqGFRt9hZxHa72rOaFWmS6x37GJM2roXnvVJqBYO4r5EkE0tk?=
 =?us-ascii?Q?frp7T/MTqH91JsffaSFWhM2bev3ahT5TJ57J6X8cbD4LlV/ZjpV7HKw7kmL/?=
 =?us-ascii?Q?DAGD8SEC6uSeZzHM0q3+bHt1a9AdrCi63+FHQsGDfrw1SKoVCVutfX+oNuym?=
 =?us-ascii?Q?ALVIIWgTef7OTTn3QjCFxv9ZfJ4jfIAe+MTMLZJafg3V5yVf5nrol2YHlJmV?=
 =?us-ascii?Q?xPIZvZOYCbTfheGxvUlRB9KQr3m0K/dd6qwULstawLEJAORtzAzo0NlNRNri?=
 =?us-ascii?Q?0EQSJhV1QaddAXkMHvtJh2s1cDvqEpsm3r8lan1m+AdPp65kTcc8ecYDSBCF?=
 =?us-ascii?Q?ZEKf5IWgzn8+cJyUVRrU+dCDRpXpqTT41TG+KJGpNeBq0Ib4TeamFxWaCgz/?=
 =?us-ascii?Q?m7D/NIpaJnbY7KXujXnYMPGuZ1b4eNokX+EKxK+ffH9QE4hFlR2EUuSjxZfS?=
 =?us-ascii?Q?aB5bAaYwSzTcCDGKXr79Qe+0vzsQiXWEIpl98KkpJZcguxFsuBoRrrvUUwIp?=
 =?us-ascii?Q?w4IAlRUlgay0k3S4Qr2x8pw1XeQZggT7EDjOlNsVqFTcwJG0o6khixPFZwOh?=
 =?us-ascii?Q?zl2l6GcIde3aOfdYhCdcHD9FfAP3qaSVmJGTZ4e80C7ytP1DY7LLgBI39krW?=
 =?us-ascii?Q?AtVAXu0ZS++TlL0yC5TOb99jIkw9Cd2jGpbpBzn8UAVYCo99CBbUe7WJpiJe?=
 =?us-ascii?Q?rdRyrc0mD5ya8n9Iyg0vQ8PTA1PUuDDYN2pe8C/P5Uhi+5G7D6EbxYi+tjUB?=
 =?us-ascii?Q?s1jMpgJAYqN3AREoyQsL1zeLQe2y0FRTJlqZq8RB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9faf91e-07dc-4fc3-b906-08dc42d70b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 20:57:35.6155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nTuRw/UsP56GSSgIAwHn1LUBWSSRDDUt7EUNRO1xr8o3p91ZzaZjiOmUhnf22l/965rvNLS32fpI8eRqTovr8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3236

> Subject: [PATCH 1/6] Drivers: hv: vmbus: Add utility function for queryin=
g ring size
>=20
> Add a function to query for the preferred ring buffer size of VMBus devic=
e.

Patch looks good to me. It will be helpful if you can document the ring siz=
es for each device and put it in the comment. (e.g  use a new ring size, or=
 keep using an existing ring size)

>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 7 +++++--
>  drivers/hv/hyperv_vmbus.h | 5 +++++
>  include/linux/hyperv.h    | 1 +
>  3 files changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c index
> 2f4d09ce027a..7ea444d72f9f 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -120,7 +120,8 @@ const struct vmbus_device vmbus_devs[] =3D {
>  	},
>=20
>  	/* File copy */
> -	{ .dev_type =3D HV_FCOPY,
> +	{ .pref_ring_size =3D 0x4000,
> +	  .dev_type =3D HV_FCOPY,
>  	  HV_FCOPY_GUID,
>  	  .perf_device =3D false,
>  	  .allowed_in_isolated =3D false,
> @@ -141,11 +142,13 @@ const struct vmbus_device vmbus_devs[] =3D {
>  	},
>=20
>  	/* Unknown GUID */
> -	{ .dev_type =3D HV_UNKNOWN,
> +	{ .pref_ring_size =3D 0x11000,
> +	  .dev_type =3D HV_UNKNOWN,
>  	  .perf_device =3D false,
>  	  .allowed_in_isolated =3D false,
>  	},
>  };
> +EXPORT_SYMBOL_GPL(vmbus_devs);
>=20
>  static const struct {
>  	guid_t guid;
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h index
> f6b1e710f805..76ac5185a01a 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -417,6 +417,11 @@ static inline bool hv_is_perf_channel(struct
> vmbus_channel *channel)
>  	return vmbus_devs[channel->device_id].perf_device;
>  }
>=20
> +static inline size_t hv_dev_ring_size(struct vmbus_channel *channel) {
> +	return vmbus_devs[channel->device_id].pref_ring_size;
> +}
> +
>  static inline bool hv_is_allocated_cpu(unsigned int cpu)  {
>  	struct vmbus_channel *channel, *sc;
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h index
> 2b00faf98017..5951c7bb5712 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -800,6 +800,7 @@ struct vmbus_requestor {  #define VMBUS_RQST_RESET
> (U64_MAX - 3)
>=20
>  struct vmbus_device {
> +	size_t pref_ring_size;
>  	u16  dev_type;
>  	guid_t guid;
>  	bool perf_device;
> --
> 2.34.1
>=20


