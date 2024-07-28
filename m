Return-Path: <linux-hyperv+bounces-2608-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8F993E595
	for <lists+linux-hyperv@lfdr.de>; Sun, 28 Jul 2024 16:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49481F2141D
	for <lists+linux-hyperv@lfdr.de>; Sun, 28 Jul 2024 14:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859633D966;
	Sun, 28 Jul 2024 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SvkG9Blf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010009.outbound.protection.outlook.com [52.103.13.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5602E64A;
	Sun, 28 Jul 2024 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722175605; cv=fail; b=jPBpbWFBF0hs8HIs1mhbkLqL52ixBPPtyJuYwnKJbb3HFVDk/NaOpBmRYHfKA9EaBdlVnQ4nhLbrl1RnR2y3Tkv1eZee+JSLAKsnQgxukmmvGCHOG4784fGvhRqi/GfIFrGlu9qn85SITflvvs9zSuAeOQp2gX2p4Gbwn0F1mdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722175605; c=relaxed/simple;
	bh=IMMd5OpO89iUtypmw8DL4XZOAbWkPf7JXrNTJFzGjU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=etbhiXGa1CqUhQ8UgTDkaHz8V/awN8y5IT8Pbu4CHCbj5nt2zfgihoGi/5QLQkTb0whP2zgZgevdG+sj4PYLzf/n4dfW7CBv9BV2c/R4NV0nzDxzBjCNxFfeJRp9R7Stc15bMAhsliVGlEK+vm5eWfHGXCqgxD+IE12xBQiQq4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SvkG9Blf; arc=fail smtp.client-ip=52.103.13.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9exg99086PP839ikpf1pTII5VnaFjgFaQ4ly9mONpMBnFPZsXiX/WEtsgy02USM9qHsvnthUk0M54Yl32WSwI6zw5ndO+zx5i8ym6aTiCHp+SCSdWzK/tOjyqwdpTwrb6Ab12jwSL073TZG6FlMrzKQleaYyWr8msOCwp9TKu5GgZbmMFGwKDB6a2i1yLxj3xVwBlbiJu9yuvGRuCmFkTmVhMK0CYKoNnd+yx61Giv06WW4crWEANRQj2dbbv1+MEOq4Cuu0B/V93aIyhQIEwmdc86PuQdfg5HAVGfeLsT5hfeDaepf+fw0LuwiGmaVI9AKwoD6UouUkUIbetzlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wES7DO+xg70uBzMvST6fcHQAZrEWCK8KgPD+2XgwqJk=;
 b=I4kmjKWU+NPkRdufDAhQzQw9tf5pp5l3jGJWZvDyFbYr/9QkmMBgml/1s0LygoExWLZ+7baZgtbVehx/XbI+9nhk5XfYQnMx2QrRfT9nVV8jgUXphIu8noCPs9pISCB9G9tphKOCYZiH9yOFVWa9oAT8wOJOUnv6zQtfYlZyZFGefbJu+8D9XwwD82j4ynVUrONLVK940b+tdh9xZm09FYzr+Lud5zuy1BXqIgRQ9qsum+ZRjzaqWJMwiOyBghNd3xnF08esCBHGDRQEJ9d3+0OhzOX6Arnu2l75jua1mhn+0mLlI9rxK6W5MnnKDYJo7/gAWHtLVnRfnPxKIWRkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wES7DO+xg70uBzMvST6fcHQAZrEWCK8KgPD+2XgwqJk=;
 b=SvkG9BlftbXiQ9m5JOjKgstsvRz+K0A+FeQHKB7nEfjsRTaZHuRgUSGH0mUcxYUO9/H3d9h9tbuVAZ6yOGgEeyTq5hEHNo0FDFBGVQhr9rHYEQB3w0AtJRXZYoS2g+sAPfwsA/O12fxB0XZJ2tT4xobyCqD4XyrD0dE8Oo4bAyw50pKzif/mA5eh9GcasDLaNT7fPh4K5pt9atjp871RoE7C5nEuZjpoNoX+b8t0tqzEh6W8cYs5bEYg0kYxGvYsGJiJgrFHYq97msB386Yu82gkzR2S7Eei8A+3w2s1CWdn3iI8Xkcqn9hRO75q7qPeO0She1USk3KSExodcmbicQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9690.namprd02.prod.outlook.com (2603:10b6:610:175::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Sun, 28 Jul
 2024 14:06:41 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7784.020; Sun, 28 Jul 2024
 14:06:41 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ssengar@microsoft.com"
	<ssengar@microsoft.com>, "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>
Subject: RE: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
Thread-Topic: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
Thread-Index: AQHa3lM09woqlpVK5UOgvbiXDK+uF7ILkLnQgABQwoCAAE8CIA==
Date: Sun, 28 Jul 2024 14:06:41 +0000
Message-ID:
 <SN6PR02MB4157A6C0CA988FE0381F007BD4B62@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1721885164-6962-1-git-send-email-ssengar@linux.microsoft.com>
 <SN6PR02MB4157BB3FF96D869D87B0A5D2D4B62@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240728091811.GA32127@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20240728091811.GA32127@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [y+WHRdEfpwSMTohWb1trkUCaHmaJuk+Y]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9690:EE_
x-ms-office365-filtering-correlation-id: 14763bf1-014c-49cc-20ae-08dcaf0e8148
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|19110799003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 IuOhBd2sPRKPE2oIYNmbDQ3pws8BQ2SsIH1usBXo+VDOzxkpgSp6Zm9DIloCQRinTgWdtH+jUzrPlXAHJ077MLCth/+1qQHK07ioC2+HsgDIU2xb7qEn8dDL4ektIqdFTS2uA7BogqLIE8sua8YuzEjnwa3pZhTC31xZnJn+b49swsz/uDDoDCkDc4GI0wBCMVggjjwr4eC/4YH0xAZqC0R7anGHdT7Wrl0zMU7WCzYZp8t9wAUffTH+pV6pWUtk43OHHptb1EBTzbuCUjtAUt705lRoNCfWIm7wFwXT2xqYDXnS/ltiLsvk7T1FtMNDfXgSbIFPKuncJIlub9ZaZzNWkMCgiCHWiGFSzJ1S043ZgM/snOHFhTylD63oWgSodxa6OvvgZsIFkO3EtpEg2HmHGcWTHG0j2bsDFUNpBegK0kXMjajPVJYC07Nt4K1wi4DuchzrfoMmN7m38EWaSUfNLKUt9bttMCBlURvMDaT8WlcF6CRgd1EoE52GZZ6ia13g3GwL5IaH0iGw3TQaQQCmS/E6H4ktT4UgRvAzLigbZQj5ECgIWkhaKYiqUHPVjAM9MOXP2y9fdjDE4mI3eEElvzTwYPz1OxENRk4IgtgxiFiS7ScvBGBwqba+RA5E+q2RDrWsgnqkdMk6JJZATQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t7P8nP8nPqoKsEklwQzHh6jDVL4Tq65iF67bWTJ8HylBAjc1oEmegZgVBa3B?=
 =?us-ascii?Q?X0/avBG47PCfTTRvj6JjMouimjSJRToI9fYXxUt0QdT6obFdB45E370rL4DP?=
 =?us-ascii?Q?I5rzbpNyx2FIlHW/5C9SLoawsLu4qmpSb1EJy/NIjQ8mklZNvQZ27bhoI0oD?=
 =?us-ascii?Q?fgFfmpuE2dkYnr+piyGGv2poGLpYsfDWOwPk9zv8k8Y/3Y7HAq6Xme5im3Ez?=
 =?us-ascii?Q?/Lo96qawsB9ghQehYipIwB3K8L/y2RAJ7DiHOYJHpFdOYAD4ep1EGP8jPj+s?=
 =?us-ascii?Q?wyAP4tUqspfYXChTLFAmI64IRDwFEG+mCxap+oxfc9+FXFKipvIxCRIKjLA7?=
 =?us-ascii?Q?9+mQoqei5yQ1kZQb17+2pDDWIqjL9BypOUyJop9fx/qCFAw/qDdSNV1jT99l?=
 =?us-ascii?Q?H97CPSA3FBsX0L5dAeYQ+n4Rv3e/1p11i7vf0ZLe6UCjunKhfRjVQlimkY9e?=
 =?us-ascii?Q?YVaRkttjAfIIWMUG4pTMTJRQHc8Hv+aAbbd3ieJB+AEC7QMpoxJ6GkUfaKzU?=
 =?us-ascii?Q?HkGjbSyXHEZ02lN5RViOxfgz+VtAjmJAb+rA12js7NVq5+ldAwJz1BL9cR78?=
 =?us-ascii?Q?q16FWkNzd2wxsFAaq9EY3m7bl5XSMOe0Q3gxzjYPGEt04fl4OKhJhoQQyNIn?=
 =?us-ascii?Q?nfX2x++Hz00IQ/mFiUhKhayEIe+IO+28Oz9W3JCqkdjj0/1a1SHdXYIj0Tol?=
 =?us-ascii?Q?xzYWBkvVC/XAXYyKLoJHHXpCbgLqpZgjij1/3gflZNWjO8RWRnNefa05pbci?=
 =?us-ascii?Q?tWXZDOuSFEksdjdwMp+Dv6jyKzoS4ZMvkcSYUqBDD6ZjLr5VU+fiAyJ14l7w?=
 =?us-ascii?Q?+MfN7PW0GFzb+d+48eCrIaEHG0vuast/gZekZG6pbDZJc0fiTMmFjkMDU2xx?=
 =?us-ascii?Q?MB4EEq7k+twLaGqEJORksLhkW+x5Dt2TrBL+yGE8x4Nbw15HR6jgnVH+S2iJ?=
 =?us-ascii?Q?tArdpc+SymeHPukVY+g1RrNj3ygxMU9jmxBoNROqPeHpk3NB2ub64H7aBgON?=
 =?us-ascii?Q?tNygJFhWoeYiBDujHe7pWchkgY6TdpJKhWynI5fGntbzp5HunqHA5+GSyhwP?=
 =?us-ascii?Q?dXzKx8F1ftliOtsZZev/QSo9pLKSC8MdA3JcdC76UUZ/SqqnKpCBZDMvI7+E?=
 =?us-ascii?Q?3cIyw7+VKSDDJmaFxm49Q30IkJJNaRuMJGL33bXogW1sD61VnJ32svcl6hEk?=
 =?us-ascii?Q?hGfx9ALDpqn/yiScsDZONy5zRYoB85jaOaMPONhHupc2HU3CGcFlFqEREGE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14763bf1-014c-49cc-20ae-08dcaf0e8148
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2024 14:06:41.2937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9690

From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Sunday, July=
 28, 2024 2:18 AM
>=20
> On Sun, Jul 28, 2024 at 04:32:23AM +0000, Michael Kelley wrote:
> > From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Wednesday, Jul=
y 24,
> 2024 10:26 PM
> > >
> > > Currently on a very large system with 1780 CPUs, hv_acpi_init takes
> > > around 3 seconds to complete for all the CPUs. This is because of
> > > sequential synic initialization for each CPU.
> > >
> > > Defer these tasks so that each CPU executes hv_acpi_init in parallel
> > > to take full advantage of multiple CPUs.
> > >
> > > This solution saves around 2 seconds of boot time on a 1780 CPU syste=
m,
> > > that around 66% improvement in the existing logic.
> > >
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > ---
> > >  drivers/hv/vmbus_drv.c | 33 ++++++++++++++++++++++++++++++---
> > >  1 file changed, 30 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > > index c857dc3975be..3395526ad0d0 100644
> > > --- a/drivers/hv/vmbus_drv.c
> > > +++ b/drivers/hv/vmbus_drv.c
> > > @@ -1306,6 +1306,13 @@ static irqreturn_t vmbus_percpu_isr(int irq, v=
oid *dev_id)
> > >  	return IRQ_HANDLED;
> > >  }
> > >
> > > +static void vmbus_percpu_work(struct work_struct *work)
> > > +{
> > > +	unsigned int cpu =3D smp_processor_id();
> > > +
> > > +	hv_synic_init(cpu);
> > > +}
> > > +
> > >  /*
> > >   * vmbus_bus_init -Main vmbus driver initialization routine.
> > >   *
> > > @@ -1316,7 +1323,8 @@ static irqreturn_t vmbus_percpu_isr(int irq, vo=
id *dev_id)
> > >   */
> > >  static int vmbus_bus_init(void)
> > >  {
> > > -	int ret;
> > > +	int ret, cpu;
> > > +	struct work_struct __percpu *works;
> > >
> > >  	ret =3D hv_init();
> > >  	if (ret !=3D 0) {
> > > @@ -1355,12 +1363,31 @@ static int vmbus_bus_init(void)
> > >  	if (ret)
> > >  		goto err_alloc;
> > >
> > > +	works =3D alloc_percpu(struct work_struct);
> > > +	if (!works) {
> > > +		ret =3D -ENOMEM;
> > > +		goto err_alloc;
> > > +	}
> > > +
> > >  	/*
> > >  	 * Initialize the per-cpu interrupt state and stimer state.
> > >  	 * Then connect to the host.
> > >  	 */
> > > -	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online=
",
> > > -				hv_synic_init, hv_synic_cleanup);
> > > +	cpus_read_lock();
> > > +	for_each_online_cpu(cpu) {
> > > +		struct work_struct *work =3D per_cpu_ptr(works, cpu);
> > > +
> > > +		INIT_WORK(work, vmbus_percpu_work);
> > > +		schedule_work_on(cpu, work);
> > > +	}
> > > +
> > > +	for_each_online_cpu(cpu)
> > > +		flush_work(per_cpu_ptr(works, cpu));
> > > +
> > > +	ret =3D __cpuhp_setup_state_cpuslocked(CPUHP_AP_ONLINE_DYN, "hyperv=
/vmbus:online", false,
> > > +					     hv_synic_init, hv_synic_cleanup, false);
> >
> > I'd suggest using cpuhp_setup_state_nocalls_cpuslocked().  It appears t=
o be
> > the interface intended for users outside the cpuhotplug code, whereas
> > __cpuhp_setup_state_cpuslocked() should be private to the cpuhotplug co=
de.
> >
>=20
> Thanks for your review.
>=20
> The function cpuhp_setup_state_nocalls_cpuslocked() is commonly used acro=
ss the
> kernel drivers hence it was a first choice for me as well. However, it in=
cludes a
> cpus_read_lock that we already introduced separately in above code. To av=
oid recursive
> locking, I opted for __cpuhp_setup_state_cpuslocked.

cpuhp_setup_state_nocalls() includes the cpus_read_lock() as you describe.
But cpuhp_setup_state_nocalls_cpuslocked() explicitly assumes that the
cpus_read_lock() is already held, so is suitable for use in this case.  The=
re are
several variants with the _cpuslocked suffix, which indicates that the call=
er
is responsible for the cpus_read_lock().

Michael

>=20
> One might argue that unlocking and then calling cpuhp_setup_state_nocalls=
_cpuslocked
> could be a solution, but I am concerned about potential race conditions, =
as CPUs could
> come online during this interval and in such case synic initialization fo=
r those CPUs
> would be missed.
>=20
> - Saurabh

