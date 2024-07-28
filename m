Return-Path: <linux-hyperv+bounces-2606-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79E393E39C
	for <lists+linux-hyperv@lfdr.de>; Sun, 28 Jul 2024 06:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92CAB21198
	for <lists+linux-hyperv@lfdr.de>; Sun, 28 Jul 2024 04:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F35633F6;
	Sun, 28 Jul 2024 04:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cPeNZa/7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010011.outbound.protection.outlook.com [52.103.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD7E1B86E5;
	Sun, 28 Jul 2024 04:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722141149; cv=fail; b=Hbpf2AImxttz3PcJ2REbrdhaKk1KgbefLW7Mj7cynuEi7i1YQndByTtzWTJ7v5IaxVH0jafePoNe/ZJCitOoiGKramA47XxoNHcUWGAGmgA7OpVooQpLnisVmkO6jjnCUr2b33fGhZnT7TDk6/lae/aQrtKPOqEoG7jOIc06EIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722141149; c=relaxed/simple;
	bh=/51CqoxzI90GJovf0JKqdZFc4jQAjgRC4LioBgJ0eOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GPV9w0+ejN1EeksDPefhqzawC/1j7DG4XENnnjJI1M4eCzClpcYnvZv+0RhvGMDCSUjjQyhUq1IAkPWgVFlFB/Ch7Ts72trj+g2RTbD68UDgQ967Aon500b73/ELyZgMj3EpqnpVVgUx1RRNgP/tS8A3Sw7EAUEMM0T7XHAH0Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cPeNZa/7; arc=fail smtp.client-ip=52.103.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPiCEymRW67zQZlt1ULtF5rcpAks6FqFdDC9SLd4mNLToG6XtdjRGoVmhUutzxc8wq/2P88RvZvF1Nq2HxInHrIfbDu1ZviaLJgqvPbueGw+glqBGapmIwTxqMI4BKI73GmL3fKeC4l0DeTtSmEgbnsgRH6IGMhFdoPYKcEktodIxlE302x+XeDrXT2gp04FWPTnYdx0ZLE2jfiIbKTUUPbnELVD/LMof5xQlKk9egrw76+rx9KlTKw9/jQSJWEvAugOYDl9wn1EuS6/PD1zuiRdkHIf3ECoEkb6U4SglB1MIVcuDs+hBw3YDs/nKM8UIkLYJoGE4lTOkoLHHaP9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Y1D99nIgb+43Pd2UHv7QAGcFePHbFVt4HCuCwsNbso=;
 b=EqFb5z+csF4USBpIO7GKQ4vW73Y/XL0VdP+jCL4R78FguWeMSGSOf8GRCrUG/gJy1aY6bZkVF8aKbKJ02iCmN3An7qP4sohI9AFRyoyG842xB9a7pDUaM6gMTtk7rCjRV7VTO3i0nUw05Sx+jl/ZQ6VWvWvBh4VPUWqOWTqaanNfwTK1Rl1CcB8ihHGbjd5twZo9q2lDYS6sPzW3BQS9x5NynPj71sayIyBEZbztDvuqej3t/I2VgcimfqvvVapTnmT5vko2i/WDwGgfTxW4HMzZyFspqXem0kzpswAkrPxecD/cvuzCrm9jreyLGHPBaBqAok+gQZzj8eW+FH6/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Y1D99nIgb+43Pd2UHv7QAGcFePHbFVt4HCuCwsNbso=;
 b=cPeNZa/7fP9TyF7XsZj7GqgDiFGZ1jarUz4i46H/mg78qmhd0dyiK4Wkrz1ZvGeFNxaZJ4FOnyUOAb+e8AbC9OyI0h/0PwSY8sXMBhsiWyRGk/VI/3+kIzc6WsZ9VSZYpzvDTXH4dAwPR8OnnKBewjRxoEvRJC325iYPLT18VLEQepFrgxv7st2flexEJG4diteS59sB2T42Hjqh83EIJ/PsmfJj441dCz2UZlcoib8eubxIRghwmogHhcVH7/LBUGVA8ZE5AaNynpkKRAtMnMSWatd93YIF5CoVVSekzmVTqvVYoKH17uWeO9iTXjY7C9+XsclmZt0cxQdil5zUmw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB9942.namprd02.prod.outlook.com (2603:10b6:510:2f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Sun, 28 Jul
 2024 04:32:24 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7784.020; Sun, 28 Jul 2024
 04:32:23 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "ssengar@microsoft.com" <ssengar@microsoft.com>, "srivatsa@csail.mit.edu"
	<srivatsa@csail.mit.edu>
Subject: RE: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
Thread-Topic: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
Thread-Index: AQHa3lM09woqlpVK5UOgvbiXDK+uF7ILkLnQ
Date: Sun, 28 Jul 2024 04:32:23 +0000
Message-ID:
 <SN6PR02MB4157BB3FF96D869D87B0A5D2D4B62@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1721885164-6962-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1721885164-6962-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [jB809l7YN8AuZq/WlU9mciHvTqCwddMl]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB9942:EE_
x-ms-office365-filtering-correlation-id: 5a7674e1-51b8-4385-6dc4-08dcaebe46b0
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|19110799003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 2PXmmMoBoc0Zr2oZsPYZ71J2ZTUc30NKM2D7pUj79i46fGAAQTACTUM9e1hRZQ+syu5G5tdmfOqxmGwMKvGLKGx7B5YKkdwKOSweILW9RhWZZX1bCDUtujJaaR2PyoLABF+/Prgua0wNe3/dsUCFtyU8DxPmxo3Fwlcb1JlwbK5whK0B9r+vlONWlr8MWZw1g7nMTgyLq+r9pucCWvJGehI72Ba+hWMTO+IaBWEy6ifjVp2TqLH5clsx4KKI+4QoZEo1k8nqK9pm9u0/SGtqhEZGmWSDvT8HthWGtcqEhPJdRF+CBWheO8zFuTbF8RduaMCFGeiwL9QrXETjX3uaXEVQ7If8yQbie00MrhPKHL/m6XZBICOjV/DgR8C0ddtEmRqvqonq6DM2ytcncaF4pS5ItlaY8pqOGcJULIb7M/Ei0uprXCxJqEzba1jyvGLQ+nGS1cbPQEBB+1iMoFu6reSSftbRYfzunxSAX8BCJcqojA5m1nDXm6+Ym3GgPufIFT/aT3IKIYqA+ADEDefS2+AFMs1i0/oJqxBO7e91DMl1wC38TKVO127k2tOqlZi6Qni0oi2dN/u3vFu5E1CcLnOb1XArR/OqmmYlfB6eg+ORWxO0KwNxjfnBZVgk4kFpGFxcVrZJvgWMtb2+D5IK/A==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XHSGwinW4NtARYqnCaJz8FI52TrBBpz5VDK5SC7Ke+MS6QCUiHaNmBC5qaFT?=
 =?us-ascii?Q?t6zNU2wajcw2115hxjixabT6AlrrxQaAU8PO8KAZgoA4C0AkWjLfn4sf0TL3?=
 =?us-ascii?Q?22nAlkxfG88Ejtg7xFSrm2DriNpZRxiOCp31gDZJ0AaQFRZqIH59zds9NFrE?=
 =?us-ascii?Q?NGaVorMM9d+3nDgtxteLWCtY/W+54xHguS9tSWp/Nps1kFe/o0Eh9dfi/apz?=
 =?us-ascii?Q?e0gRVAkS8lx+pTFbEhgoTIpSxF2RR0hs9MXyFVrXMe5b6HK19ToMC0qmBIz0?=
 =?us-ascii?Q?yqhKmRC/mg5Ea+WLseo23SRxdL8n6oRWUU//QPf6SjKLxVJ1SmjX5AFiGsb6?=
 =?us-ascii?Q?lmBc5qQX2XDugcVAIDJ0G/yCrPTRa7mr4hUtaxOpYBt4jrxiJ4LxPUFWZUQi?=
 =?us-ascii?Q?3ExMqgLg3VcngOWNJcbOyEZ34WOyNmcWpPNS8v1d0H3T+4AIPgw982iXPTx8?=
 =?us-ascii?Q?Re3UL1nXmoECbCOv2aHttZZ6GbtV7Z/doi2D9uGZL+FXgqzL8a2GpPua6Znb?=
 =?us-ascii?Q?9WDE7g3LofelcOIbAJbFJarZA9vnEjEzZTkTyRQsLmkgHpp8L6fR7Tt16OJh?=
 =?us-ascii?Q?hkzWxp+vkn3fvfM5cJCekU1R6rokoex7cwvd18kA1oxC8IJPfmtQEbNTC1nZ?=
 =?us-ascii?Q?E+1LmQL3sT0oI6iTeEGS2/Cip6av+aEODTxOUfrC9siLYoKkaay085SroEfc?=
 =?us-ascii?Q?+hg0zZT5Y2qZ4Uv8isvFD8kQ3/v0fpJETztInMQcd6vtSq1b85UCh/RQK6/t?=
 =?us-ascii?Q?3MfL8vuLDHPXIUXFfpNQyGDUpDNQO7kgpd84AWvaRCyld7bCa6mtGQWHzwft?=
 =?us-ascii?Q?yt1KQM+XSBgG2rzHQYLASRNQkDa9YoAgyr0vHhBSe19Rc8Vv95hpywgSOIxE?=
 =?us-ascii?Q?a3x0cJyaosjpMC8vQIVowLsP3/852V9NU69ixUOzZnNDWoLoPOflfpLRbtmO?=
 =?us-ascii?Q?Pht0+ZbSQKkabNg88t3b3DPjWFIRpqxwf2oG1Al6VbEMEfsNQZI3yzi45cui?=
 =?us-ascii?Q?ZtCn5dPSTCnynOJvbp+z6NkaT5LNIo+GQwufw6IWvyDdZ7JVeaqFkId3SX39?=
 =?us-ascii?Q?4rLrMU+gLClSpdvI93eIojWuYtHe73elbHSh41CIoAaCE13FG3kOPEnkhcdn?=
 =?us-ascii?Q?ZazElpsJ7jIj9nbYpHHeGVIDCK9BfTY0Oh7/jd0/xY9BXl7YeEPMiMal0JRj?=
 =?us-ascii?Q?7st9yaX2nBxTU5/x2A7ZuBd+G9cg2s6KdBy86G6jM2nuS6QK7geGhDroFos?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7674e1-51b8-4385-6dc4-08dcaebe46b0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2024 04:32:23.2441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9942

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Wednesday, July 24=
, 2024 10:26 PM
>=20
> Currently on a very large system with 1780 CPUs, hv_acpi_init takes
> around 3 seconds to complete for all the CPUs. This is because of
> sequential synic initialization for each CPU.
>=20
> Defer these tasks so that each CPU executes hv_acpi_init in parallel
> to take full advantage of multiple CPUs.
>=20
> This solution saves around 2 seconds of boot time on a 1780 CPU system,
> that around 66% improvement in the existing logic.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index c857dc3975be..3395526ad0d0 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1306,6 +1306,13 @@ static irqreturn_t vmbus_percpu_isr(int irq, void =
*dev_id)
>  	return IRQ_HANDLED;
>  }
>=20
> +static void vmbus_percpu_work(struct work_struct *work)
> +{
> +	unsigned int cpu =3D smp_processor_id();
> +
> +	hv_synic_init(cpu);
> +}
> +
>  /*
>   * vmbus_bus_init -Main vmbus driver initialization routine.
>   *
> @@ -1316,7 +1323,8 @@ static irqreturn_t vmbus_percpu_isr(int irq, void *=
dev_id)
>   */
>  static int vmbus_bus_init(void)
>  {
> -	int ret;
> +	int ret, cpu;
> +	struct work_struct __percpu *works;
>=20
>  	ret =3D hv_init();
>  	if (ret !=3D 0) {
> @@ -1355,12 +1363,31 @@ static int vmbus_bus_init(void)
>  	if (ret)
>  		goto err_alloc;
>=20
> +	works =3D alloc_percpu(struct work_struct);
> +	if (!works) {
> +		ret =3D -ENOMEM;
> +		goto err_alloc;
> +	}
> +
>  	/*
>  	 * Initialize the per-cpu interrupt state and stimer state.
>  	 * Then connect to the host.
>  	 */
> -	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
> -				hv_synic_init, hv_synic_cleanup);
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		struct work_struct *work =3D per_cpu_ptr(works, cpu);
> +
> +		INIT_WORK(work, vmbus_percpu_work);
> +		schedule_work_on(cpu, work);
> +	}
> +
> +	for_each_online_cpu(cpu)
> +		flush_work(per_cpu_ptr(works, cpu));
> +
> +	ret =3D __cpuhp_setup_state_cpuslocked(CPUHP_AP_ONLINE_DYN, "hyperv/vmb=
us:online", false,
> +					     hv_synic_init, hv_synic_cleanup, false);

I'd suggest using cpuhp_setup_state_nocalls_cpuslocked().  It appears to be
the interface intended for users outside the cpuhotplug code, whereas
__cpuhp_setup_state_cpuslocked() should be private to the cpuhotplug code.

Michael

> +	cpus_read_unlock();
> +	free_percpu(works);
>  	if (ret < 0)
>  		goto err_alloc;
>  	hyperv_cpuhp_online =3D ret;
> --
> 2.43.0
>=20


