Return-Path: <linux-hyperv+bounces-5984-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F461AE1FC2
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 18:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315487B06FE
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 16:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7EC2D3A6A;
	Fri, 20 Jun 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ya8EeN3s"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19012047.outbound.protection.outlook.com [52.103.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1691993BD;
	Fri, 20 Jun 2025 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435517; cv=fail; b=Xk72IBfChlXDlHvNKTSzw4+JcJCk4PVeaiKUmukWCISfci0JTwJzYzQEalg+RhQRbKF92EBypkpcT2stLT9XnznQtDVerCAnU+RxCEm3qcmz8lMthsE6f7z2uNIx/wTNM4lqy3b04rYsNEeKP5a93cVW3qMgRUglaVXpYzSmwcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435517; c=relaxed/simple;
	bh=LFWRF0c3o8FP5gUJZIlInfT+3Kkb8Y/hfoEkNutedAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QC1CWPrmtmUfrvBWFx/1/Yq3onC4g3oxctxZbf6EzeChgVDf3tklqFbIHAEEJzD50Md/o6p8ktpGR3zMM52EMBQEqiP4eeWsVysrP7kpua4h0G2MJtb+Rv4qV7nRr1JQFaoAYtyvOkzil1VONykKlSYV9M+3OFffA2U9UppI8Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ya8EeN3s; arc=fail smtp.client-ip=52.103.7.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGOT/SC7gfnNcIsvBvPmFGTuQcH3zSA1z92YilBGtKtsrdIBXdskoqxzxMIPVNgbATOX8/mR0KUoXzqxMcG97h/rQH8OcynIMegsb+zTqkMK4qHhFr+BfeTaRoF9xLcMqpTSGGUWec00jaHqNpXDL3jIjy3gC4410GSH+0t6LU97Tm0rTKc5Eij4JY0K6W+2IRYPzLTQxbCe8ttr7T2p/DGWuflIi1ZO+rh71EVAMBj9h5nM8nV6iqJKsPe7txBFKLhHXul2XFHns/FgDPvv1EKmQeoUK7j0bPZZIB3W/lHXH6aLQF6KcMd+RASZIH4jnQlI0efrm2nc8084Fr3l1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0goYAXhffL32HRo1en4LQ3q2/GqztsQgliwVERr3nk=;
 b=FenPfyMOzHoWMWVp03vG1QRn9HwBDtGJdV4HMPAE71QWFyd1yXUrbbZQqqGVKjWxvng3YXT63q8A8LA0gkVq+m9XS6ur53kQf57+i9aQIjsubUoi758HmfTBPFGUp6CFRjverQPkt4WFFrXEV8RX8AoNUK28IMaeZEoRfiCR0ur66PQHE4zSsbPNirLguUP3qq2AG/c39acMxBAs/vqqijTUK9OS+rKm/+FbV65pSQcml8t3XlAX3s4paf/tpj+/t1a3GZlbiVlgDPO9zR3FTMUu9IO02S0o5ASoGb3SlbtSFdY77kJ2ICwse1pRxUgA4jOo2F46ygmB4q2zg+GdZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0goYAXhffL32HRo1en4LQ3q2/GqztsQgliwVERr3nk=;
 b=Ya8EeN3s4Adu82bCyBcUUKpn0ieMjKCL6yK5mv2rY18Y0uOHuoSyq/qHpqX12d+6oYy4ru+8V9gmhRy0hekR/8yuXyS8OZHLOv6wXiY3/Du11oFYnzb0CxyZfTBrxG4QPTiApoOvGWaSTXVVp7cypFHST01HaD7IGqdRh2yspwuKTpJXefDBueF7pHLM2UHFDfCr+D+Dd5aIlcmub5MGFE05ye16B18z9M+lY21O70xv9t3nA9YCn2ZBgTDtt0TsYf4CACLwuYkw+8HU+swOU0hnex/BiHTRvChOd7lrhCGi+D9VTmUprtO/fi/I8UiktVo6fkWwy2EoZ011dAch7Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7333.namprd02.prod.outlook.com (2603:10b6:510:1c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Fri, 20 Jun
 2025 16:05:13 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 16:05:13 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] tools/hv: fcopy: Fix irregularities with size of ring
 buffer
Thread-Topic: [PATCH] tools/hv: fcopy: Fix irregularities with size of ring
 buffer
Thread-Index: AQHb4bHmzA7RWc6sw0e084SYV6icObQMMm2w
Date: Fri, 20 Jun 2025 16:05:13 +0000
Message-ID:
 <SN6PR02MB41574C54FFDE0D3F3B7A5649D47CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250620070618.3097-1-namjain@linux.microsoft.com>
In-Reply-To: <20250620070618.3097-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7333:EE_
x-ms-office365-filtering-correlation-id: 8e4e171e-5e79-4dc0-344e-08ddb0143d50
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799009|461199028|8060799009|8062599006|41001999006|19110799006|3412199025|440099028|102099032|51005399003|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6A1bV7CEz1Q3p22VBvphnNrX4BHSLkRtrIZRaR8KjQ/r//arW+8P+2EVjKDM?=
 =?us-ascii?Q?rGzcwaf1fx2GyQLmH54L+IppESuqZd51VaKs9LTC80G7pj7qdTcZxt4wE1XX?=
 =?us-ascii?Q?P5szhySb9Go5QXI3H3TOsowJfFKAYzlvxUMOwOecGwTyDXliGWBMfcWeqcj0?=
 =?us-ascii?Q?wQhOVywY85ScS3RDpt2+SUKDxDcpX/BF2rKgZgXu3fqTMf5byClxI6tn51aq?=
 =?us-ascii?Q?8HOtVfx0fFHoPefxw2DfY7dkHJlNy250qE0QNykwGsbPofh/86iPTys0Sk1z?=
 =?us-ascii?Q?lWnRvG3rrWfmhdv0girznqBbeW8gRW3xsvOE6dB4+g9rZUEQgAORyKwdt/NV?=
 =?us-ascii?Q?nEKBe9gRXmzKjzoDLIur8pQqBzKBZnvnbLB/cSJhYgkv/IcrhxTbZNQn+plY?=
 =?us-ascii?Q?WNW7laKuo7NuNGhlqGiUn+ZQVSDAJn5y2egfS0ceYnbmw/XMHKT0sE3ksB6y?=
 =?us-ascii?Q?s4BuXpwLUmOSZNK5BeUF99zpq9uz0f30pB7zQoiBOwzElpIrSmtjM4RlvWiG?=
 =?us-ascii?Q?GreVSJIEQ+LGA/pVymrmAkya31f3oFrxF7Ko6W+Q+mhUg0WwT3m13s5xzDm1?=
 =?us-ascii?Q?xDlXGb2KfElGEwF+vr8DujXZ4LpIMtDbrc5QW8lrHNwOaZxC5oFjyp3ldgDf?=
 =?us-ascii?Q?tY8qTc8jf3iooZLT8nzu9qtZS3ivdm/33YNK6FZ32fCtYGnyhgjA9s1X0fRb?=
 =?us-ascii?Q?rQmZ8KpKJF8N9Z5OfTE4hxhyxTRal00FxAkO/gQ996RCgn1tyZrXtTN/0hGk?=
 =?us-ascii?Q?LYL/RgVQlmgc6z+mr6qa67DqsZ3ozip3fVvndmndn9X0PM/gKFthVG7pg4zx?=
 =?us-ascii?Q?2SfX43rP1fc7Mre+a9tKzSu1VbjagpvthVbX0BNJNalyn9ne/qu/751zCI/6?=
 =?us-ascii?Q?EhslkjL7xU80lE24Exo4lotKqI+h9utzodCdJkUK9Wmq9Dq+ZdOiDpinQadz?=
 =?us-ascii?Q?VEb6NwZbU2WkSFze6sAWM4qSkXSwtG27TQGa7WFVdMgo9gxXrTSccaZEVKfi?=
 =?us-ascii?Q?741XZGR+5Y8QfUu2N5hkiqbZwTRoasSm3C7DkXsV6Tiy6CNZVVLCpdpEbjib?=
 =?us-ascii?Q?Nbft6l/E6UpNhinVuKATeZavYQvC3Au3nvBB+xYy43x/lFBXVLgdLr5qpHDG?=
 =?us-ascii?Q?Ak2YIodn7UvvO4L2EjvbRg7jWlOX2sjUv/rFu0rpv+sAawf4kuMrp37S1Lfz?=
 =?us-ascii?Q?dyba2W+juq3OoUoc?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tWU3/1oH3wImTmz/6NGwImckoXqnCnmDBZZJtQGeYmziOJOQI1IrEhL+ZxBL?=
 =?us-ascii?Q?+n3QO6SCs3OY9OHwadyFNZNuhLgtAejP5/oEM/wh2R0v5cYf1Yv9WtvLunZ0?=
 =?us-ascii?Q?qArmGvd03Oq5ycVX9Hc1rYTsfIZNzUaZDdxv3JQuH117xw7KpD4INKl/Z96A?=
 =?us-ascii?Q?zmgIoChefoFpNGvT9LUx2Gq+OHmkIdGLYOv0k2ISc/Ox+2yZCT7aWW58trqK?=
 =?us-ascii?Q?R5VPhdkSl5t2aumHFc1EQFz7nSseIqYW2TJ3/4rvd93IUOes+nYtrc+NTu6r?=
 =?us-ascii?Q?c4PJCGiWafuDGo6d6uGkpqitXCAyOj4eNTHGb37FHoB6YHxZ7tqGSyIDkaTK?=
 =?us-ascii?Q?mDHnRMrWdBwysYp2IYrK6a56MetkznW7x7++Ln4o6CZB5Esvi6wv77+CnaCO?=
 =?us-ascii?Q?dMlxn2/0jntEdg1/98XT0MhRzRa6w8lVelSCZSGLLY+55phrsM5irbKAoZrF?=
 =?us-ascii?Q?wnAyW9kHlvb88s/kft4nZ6AImfgzMxeXiV5r0n5b/bDAyxFIe7OfQWAlTAV+?=
 =?us-ascii?Q?CzqwZT+cs1I2U14ykb6Jj+0K2P/tKkN09QraATPYsMKCvdSNlBatVEnUC4L5?=
 =?us-ascii?Q?nvGJm32N9yop/zHCtG/gk2fNCppATPmhuP9nXawZ9FB+KLQtC7hTecGnLdgN?=
 =?us-ascii?Q?YXxgru76DksdcDZtxeTiau/tRxI7wCMOUyHcadDw+NO4/REQiwd03UfNZhYT?=
 =?us-ascii?Q?3vNbm9HqWolpr8ZhT/qZpZQuMHoOZg9XxOzdRsN/lhXZY3OKO2vJ+N7qUj+q?=
 =?us-ascii?Q?E9+WY2NWf3N8MHIt888EbUrOFphVWxOh+qqebar8mK59eRsmwmk6Bi8aWeer?=
 =?us-ascii?Q?F7UIFcXHDNwoK4XMBwJG6pFsFVo9u6lCLBBnZObwrp8V0b+AK9abQYj4zZSj?=
 =?us-ascii?Q?4U4USxLf/HR3Yo79eL0vgDEbAFyC6odawL8XFbLWM29lKGM9K3SdTJ4q3jkC?=
 =?us-ascii?Q?0m73SLj9ywW70nAeBjjW0PPTuFJq6KABQ/LS4gmnE8rNAqz4ilG77D6MwRWq?=
 =?us-ascii?Q?WJHw71D6dcLeiokwefaWd9NzPiexLSmztqATF5SFOo1ODZ1kI+O+qWPwdsa6?=
 =?us-ascii?Q?WDe3goG8VpbvFYrK60rE9ObJQFFszBJc+RTBP8/FAVxpDEc5nPNaxA/tWAbU?=
 =?us-ascii?Q?mmCx48JGcedznJ//JF4W0FU+oqy9V0Ts2vVbBtT5suowzL0VSUcqMRz4xvum?=
 =?us-ascii?Q?Xiex26/glxZsXlNh1cgqUsSZdjXpHLoNAPUdy0qI4r94PZO39p5ixY6Uvg4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4e171e-5e79-4dc0-344e-08ddb0143d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 16:05:13.0819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7333

From: Naman Jain <namjain@linux.microsoft.com> Sent: Friday, June 20, 2025 =
12:06 AM
>=20
> Size of ring buffer, as defined in uio_hv_generic driver, is no longer
> fixed to 16 KB. This creates a problem in fcopy, since this size was
> hardcoded. With the change in place to make ring sysfs node actually
> reflect the size of underlying ring buffer, it is safe to get the size
> of ring sysfs file and use it for ring buffer size in fcopy daemon.
> Fix the issue of disparity in ring buffer size, by making it dynamic
> in fcopy uio daemon.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 0315fef2aff9 ("uio_hv_generic: Align ring size to system page")
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  tools/hv/hv_fcopy_uio_daemon.c | 65 ++++++++++++++++++++++++++++++----
>  1 file changed, 58 insertions(+), 7 deletions(-)
>=20
> diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemo=
n.c
> index 0198321d14a2..da2b27d6af0e 100644
> --- a/tools/hv/hv_fcopy_uio_daemon.c
> +++ b/tools/hv/hv_fcopy_uio_daemon.c
> @@ -36,6 +36,7 @@
>  #define WIN8_SRV_VERSION	(WIN8_SRV_MAJOR << 16 | WIN8_SRV_MINOR)
>=20
>  #define FCOPY_UIO		"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b=
64d17d4/uio"
> +#define FCOPY_CHANNELS_PATH	"/sys/bus/vmbus/devices/eb765408-105f-49b6-b=
4aa-c123b64d17d4/channels"
>=20
>  #define FCOPY_VER_COUNT		1
>  static const int fcopy_versions[] =3D {
> @@ -47,9 +48,51 @@ static const int fw_versions[] =3D {
>  	UTIL_FW_VERSION
>  };
>=20
> -#define HV_RING_SIZE		0x4000 /* 16KB ring buffer size */
> +#define HV_RING_SIZE_DEFAULT	0x4000 /* 16KB ring buffer size default */
>=20
> -static unsigned char desc[HV_RING_SIZE];
> +static uint32_t get_ring_buffer_size(void)
> +{
> +	char ring_path[PATH_MAX];
> +	DIR *dir;
> +	struct dirent *entry;
> +	struct stat st;
> +	uint32_t ring_size =3D 0;
> +
> +	/* Find the channel directory */
> +	dir =3D opendir(FCOPY_CHANNELS_PATH);
> +	if (!dir) {
> +		syslog(LOG_ERR, "Failed to open channels directory, using default ring=
 size");

This is where the previous long discussion about racing with user space
comes into play. While highly unlikely, it's possible that the "opendir" co=
uld fail
because of racing with the kernel thread that creates the "channels" direct=
ory.
The right thing to do would be to sleep for some period of time, then try
again. Sleeping for 1 second would be a very generous -- could also go with
something like 100 milliseconds.

> +		return HV_RING_SIZE_DEFAULT;
> +	}
> +
> +	while ((entry =3D readdir(dir)) !=3D NULL) {
> +		if (entry->d_type =3D=3D DT_DIR && strcmp(entry->d_name, ".") !=3D 0 &=
&
> +		    strcmp(entry->d_name, "..") !=3D 0) {
> +			snprintf(ring_path, sizeof(ring_path), "%s/%s/ring",
> +				 FCOPY_CHANNELS_PATH, entry->d_name);
> +
> +			if (stat(ring_path, &st) =3D=3D 0) {
> +				/* stat returns size of Tx, Rx rings combined, so take half of it */
> +				ring_size =3D (uint32_t)st.st_size / 2;
> +				syslog(LOG_INFO, "Ring buffer size from %s: %u bytes",
> +				       ring_path, ring_size);
> +				break;
> +			}
> +		}
> +	}

The same race problem could happen with this loop. The "channels" directory
might have been created, but the entry for the numbered channel might not.
The loop could exit having found only "." and "..". Again, if no numbered
channel is found, sleep for a short period of time and try again.

> +
> +	closedir(dir);
> +
> +	if (!ring_size) {
> +		ring_size =3D HV_RING_SIZE_DEFAULT;
> +		syslog(LOG_ERR, "Could not determine ring size, using default: %u byte=
s",
> +		       HV_RING_SIZE_DEFAULT);
> +	}
> +
> +	return ring_size;
> +}
> +
> +static unsigned char *desc;
>=20
>  static int target_fd;
>  static char target_fname[PATH_MAX];
> @@ -406,7 +449,8 @@ int main(int argc, char *argv[])
>  	int daemonize =3D 1, long_index =3D 0, opt, ret =3D -EINVAL;
>  	struct vmbus_br txbr, rxbr;
>  	void *ring;
> -	uint32_t len =3D HV_RING_SIZE;
> +	uint32_t ring_size =3D get_ring_buffer_size();

Getting the ring buffer size before even the command line options
are parsed could produce unexpected results. For example, if someone
just wanted to see the usage (the -h option), they might get
an error about not being able to get the ring size. I'd suggest doing
this later, after the /dev/uio<N> entry is successfully opened.

> +	uint32_t len =3D ring_size;
>  	char uio_name[NAME_MAX] =3D {0};
>  	char uio_dev_path[PATH_MAX] =3D {0};
>=20
> @@ -416,6 +460,13 @@ int main(int argc, char *argv[])
>  		{0,		0,		   0,  0   }
>  	};
>=20
> +	desc =3D (unsigned char *)malloc(ring_size * sizeof(unsigned char));
> +	if (!desc) {
> +		syslog(LOG_ERR, "malloc failed for desc buffer");
> +		ret =3D -ENOMEM;
> +		goto exit;
> +	}
> +
>  	while ((opt =3D getopt_long(argc, argv, "hn", long_options,
>  				  &long_index)) !=3D -1) {
>  		switch (opt) {
> @@ -448,14 +499,14 @@ int main(int argc, char *argv[])
>  		goto exit;
>  	}
>=20
> -	ring =3D vmbus_uio_map(&fcopy_fd, HV_RING_SIZE);
> +	ring =3D vmbus_uio_map(&fcopy_fd, ring_size);
>  	if (!ring) {
>  		ret =3D errno;
>  		syslog(LOG_ERR, "mmap ringbuffer failed; error: %d %s", ret, strerror(=
ret));
>  		goto close;
>  	}
> -	vmbus_br_setup(&txbr, ring, HV_RING_SIZE);
> -	vmbus_br_setup(&rxbr, (char *)ring + HV_RING_SIZE, HV_RING_SIZE);
> +	vmbus_br_setup(&txbr, ring, ring_size);
> +	vmbus_br_setup(&rxbr, (char *)ring + ring_size, ring_size);
>=20
>  	rxbr.vbr->imask =3D 0;
>=20
> @@ -472,7 +523,7 @@ int main(int argc, char *argv[])
>  			goto close;
>  		}
>=20
> -		len =3D HV_RING_SIZE;
> +		len =3D ring_size;
>  		ret =3D rte_vmbus_chan_recv_raw(&rxbr, desc, &len);
>  		if (unlikely(ret <=3D 0)) {
>  			/* This indicates a failure to communicate (or worse) */
>=20
> base-commit: bc6e0ba6c9bafa6241b05524b9829808056ac4ad
> --
> 2.34.1


