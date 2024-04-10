Return-Path: <linux-hyperv+bounces-1949-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE7189FF6B
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Apr 2024 20:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C705A1F2301F
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Apr 2024 18:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1475417F370;
	Wed, 10 Apr 2024 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Uxp28V/4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2058.outbound.protection.outlook.com [40.92.41.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE028178CE7;
	Wed, 10 Apr 2024 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772512; cv=fail; b=VaZHTdHZb2j2pO4hoCE5IBdLPA1Dgzt0fLMZg4UIWDcOtLgJsHroyFuEGRxGB0nWxDiZXY53OQ+2GCgDjb8zRZiN4kTddyUYLxed7HwRXr8/Sq8h7EdDLDBLjsvurmmiM++IywDPoXZTS6LkC7DwGAosnzlEPCWmhaCFx8vwM7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772512; c=relaxed/simple;
	bh=n2vS59lACA3pf4vLogsdMwLRjx0pqZF5gsS50cOFnI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZaegxuZ1q9ImNgOUF0RRbderxWW/IEQDJkvPlT+cameHaU6Q/z+nc8K7fOHUEiwBAmuvHk/spj+56OmYfvwK22r+lEKapQVYamUq8NUbMfQYmHmRckkoIm2oGnX02Q0utdgP3nBZ2FV+As6ex9EqOKwrnWad+bMiCqZuFIskIM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Uxp28V/4; arc=fail smtp.client-ip=40.92.41.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9uy/RtBTqnglcDyZyaE5JZmVNWMSEflGGlqjwPG6mj2HoI7RHLazixcwoR/JNdQbzitR4arLtqhwXMtuptO9MH27tdRSvYqTUyU0+dGKjWgCnBxBTOKEYKLZ7qC5iHQlM+KBeZvBU7XGeliE9sJOqTQtt27ta7OMbZfAqSqI8VX9VE8Rg898JAnj6UWEOuirKPZKQ1cdvRBz3kvBF27CfQ3mXYE42aXhpon5jbXmFALivbIvDlgX14XJibTRPZihNBnkSNdMgr73J1bGgeh9npAQdMF2Df2LYb5YgOl+vELUHKinBSoHzdH8xpxwjsMDj53Q8OUURlHmYD+y0ndiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2KvXkyDImCMp4YXyq4cZZbx3ZLcBM9YKtXAxRDEzCE=;
 b=gkpwPX9cMo5ZFPL3Pu1z+hGhR0pHT6Nc+tEfBp9i/TxTE1di9nFIwKXsTypbJc6wbCRMMDNZR2a9gRCg9IbecU6tZCKdh23uRD4fmbNRvE1IPw76NkmbikZnDAef7FzxPZpVQX0u7m1qvC/tfWKEG+zv4JV7Pqo4fFR8wCXJnsEwwwZq8qkuQZYCbTDVER6zLMfbrPNikr7KNCgv46Cjtp/PFYytOIyKDoOFoLPA+ivhRpx2Y6PSxsq2D341vgYP6hCW07ttz5Ar+3FJxg7G8piHU2lQDYMnYxptyxVFGrQA1dmcTc2JhIu/99AtnrDohQc7EgbDJcbxPd1b/LRykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2KvXkyDImCMp4YXyq4cZZbx3ZLcBM9YKtXAxRDEzCE=;
 b=Uxp28V/4VnBCKK1OEC/WO47+XZDxKcbk66/L0in491TdqiiA0zPvFf4DjAcJd/AVi2VHZzWYAthXC7/UWlxhwFmdxa47jGCeV7nAislJKuIHkfMPtPwKnHEBfgmyLnpynlX5cB9UaMO3kvEFjie7Ar2ArS8XyMJNkR+Xi0bKRiPHrnc0ke+iwazSQQHCcbOweSTov3y8g1gLcTU70gNHkP6ThrmbhUKV742g87iJ0TFFHhi/0jJ9UaA0IjDzq0+tEkMhSh3cqTf7RwEzfFkvB6yGhRy5JH4FP8OZtWZHzoIGrP41jeIoLtIz25Yx9b1VigVFndoC5key2CSP1+eQgA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9260.namprd02.prod.outlook.com (2603:10b6:610:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 18:08:27 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 18:08:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Allen Pais <apais@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "tj@kernel.org" <tj@kernel.org>, "keescook@chromium.org"
	<keescook@chromium.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] hyperv: Convert from tasklet to BH workqueue
Thread-Topic: [PATCH v2 1/2] hyperv: Convert from tasklet to BH workqueue
Thread-Index: AQHahefjEIyL+z2vREm4553g5qSVN7Fh0dQA
Date: Wed, 10 Apr 2024 18:08:26 +0000
Message-ID:
 <SN6PR02MB4157085E3111E1C251168ED2D4062@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240403165542.21738-1-apais@linux.microsoft.com>
In-Reply-To: <20240403165542.21738-1-apais@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [9Hb5BRmasODZ0hRVbbLoftpISz1rMfw2]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9260:EE_
x-ms-office365-filtering-correlation-id: f447fe92-25b6-429e-3912-08dc59893828
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pfPqdrm4b+xExpW67kwcj9HEkZVjcqja3QNgfUcNhl9XL8B0j7QskB5nMr4ROiuBz/eGkkIgRM0VneKm00GUIDS7/AAbI/rvl4ea9fNkvYKYOIV9inqVgKi2EUwloy7zo0PWBb7aApbnrI0wpwLjUWuj5Pm9/ciztluFYKXXeqFP4q3XYmAvKHZ1rPeGQHww2u1YXLDdY8YLTXGBQpXFQJxE7iJdF4sBbLS+euJY0gCyEykNpKpwEe9eaHP1ASPap/AyrJqQZRHLA4fwyKIzoR3ir2i4T7o72GDY8ubbHHI5MgL9RtL/ClQh96vnLdxuTAJag6S7Kq+egU9IHRKT+TaQ+79QKTBU9ils8ItE9BCytLWYC6wBM2s9aG/ikoiY/m9E0qYTzrP/K2tEy/n9aI+Bcx/npRyMQwl97PcwWO9lAp/jDTrGGO25wfo13G5EwqnVDX5OHfnIBSjQQYWoVmBXc85v96ntSjKEujvnoihmVel0KuwmUfZ5uVKSU0ugmS4orJCU6EVVpjnjvgUIw8MSu7Tys/GP9D4vBLl7lc7SJAMROByMXYqNO72zWgvOpj5JoK1NSt52bEEQR/tqIWNRovjWLx344detx4sFNHXZ6R5/JupGxr1zjB+p1bXXvwAWFJrQh29UqgIm00K8AaGPPcJ7pP2ROkScyglhr/YiQCaHyG1CO6/+igriHkQobw5QsFrR5nqf6R+fMiD4Xw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nEqSNwbzkZLVlUgkNgP17lKzAHLNJE2hA4S8CzdyEauVUADEaQ1t8CnjlWxW?=
 =?us-ascii?Q?2kz+N+SedrplxJ1zWck/HxdqLhlKQFGoqcDLRF+vS9A34KTRn8oJ9oObulmq?=
 =?us-ascii?Q?JDfwDuhR/zMEiIYh1Vj1l97NqNcI+DWYmexL3cxsfqPs+c7R4bx9Y74SeJnz?=
 =?us-ascii?Q?f3MG5a7jGVD5BI+cwO/zUWs7TlhoVsPIyAKJbKHB0/y7CDZceByam8/uzBWs?=
 =?us-ascii?Q?qYSYP3Si50N1rnw3yX88SQ/8u0y4QTxuJr7qNlcu5SzrpwM9texMyV7F7xO7?=
 =?us-ascii?Q?K9GbndcFSEHHo6lv6qKGykcpvOYt8e4NHyBJXjTi6C3QBPOnw/MV6jZlJNJ1?=
 =?us-ascii?Q?AM6EsFu3Nm9FgQnD1rAUNqjvx9l6n8qh4TmBc7+p6zwWaYMx8Bhy6FPgaMg5?=
 =?us-ascii?Q?nSB0v/S6fqpmRO9/rafo0TRBTdvNP2UDwxkPoWLVb9K929WHMNgBhWH27mZ9?=
 =?us-ascii?Q?55RumzPvgPIiFd6zO94rL9rgbxsEg8VU+ED3DXchqNNuTzTtI1H2Qx1+wCWK?=
 =?us-ascii?Q?s2H23OWKtOaVuNs118pSUflKGQypEtEKOY9E7Y8tj6yMS3IVAJvgH5sP0V8c?=
 =?us-ascii?Q?r5BMg8bTToN5FFnePD6LFGhZKhjHnrUqa1+GPt6REcljXMom1jMk1DiKx0h/?=
 =?us-ascii?Q?xv246Y3Wcvv2ClDG6ywXee1bJfyNUj0ma16EjjEWzQyxiDlkh/sy9ZBufvYX?=
 =?us-ascii?Q?ojaXd3P149FGnvYpAINn+1YZxO9+1QmfXaGSVi7kIsYOOcHP907VyDpoYU24?=
 =?us-ascii?Q?eAPng75guEyembd6ug9E5j1+cAEtlCpraLpBc87oN+DUeHWMcIv9ny1qQHnI?=
 =?us-ascii?Q?2iEA6Mu0Iw6OBZpWEj7EHfhprg7u1UG802Pt1GUYHeQANUYn31Hj9pjFYOta?=
 =?us-ascii?Q?BxJniX+k4TUGqUDoufFVuQGdx40G2J/90mzcmK5/9D9qL9m0Cv46CR6wPHNl?=
 =?us-ascii?Q?IjlkPJoWoAE4eRxWR2uEsVUybvWm6YRUiXSFb5+WeeMxmkDn254Aa0qrVFGN?=
 =?us-ascii?Q?B5olqo3VKf24yrlB12cOC9UN/1AvKwIEHHzFMMIKSrJnpdiYHUCoTRIK5Ugj?=
 =?us-ascii?Q?tdqJrkU+l/qpsI42Ja/UXeNq6NNoqa4LCB9Cp75f0F+iivQBNamoyF7arW6E?=
 =?us-ascii?Q?6mb2ctDQilrreaIyK8uGyY5tHQb5uwoj9NgjhnW6EktlUMAsGFFbRkyHvwP7?=
 =?us-ascii?Q?AWGS5br55IbHZDYKc/cfYjdwgEtk5lDsgHvS6ZfJMY+xmvU+BIgpumNaWKA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f447fe92-25b6-429e-3912-08dc59893828
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 18:08:26.7289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9260

From: Allen Pais <apais@linux.microsoft.com> Sent: Wednesday, April 3, 2024=
 9:56 AM
>=20
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
>=20
> This patch converts drivers/hv/* from tasklet to BH workqueue.
>=20
> Based on the work done by Tejun Heo <tj@kernel.org>
> Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.1=
0
>=20
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  drivers/hv/channel.c      |  8 ++++----
>  drivers/hv/channel_mgmt.c |  5 ++---
>  drivers/hv/connection.c   |  9 +++++----
>  drivers/hv/hv.c           |  3 +--
>  drivers/hv/hv_balloon.c   |  4 ++--
>  drivers/hv/hv_fcopy.c     |  8 ++++----
>  drivers/hv/hv_kvp.c       |  8 ++++----
>  drivers/hv/hv_snapshot.c  |  8 ++++----
>  drivers/hv/hyperv_vmbus.h |  9 +++++----
>  drivers/hv/vmbus_drv.c    | 20 +++++++++++---------
>  include/linux/hyperv.h    |  2 +-
>  11 files changed, 43 insertions(+), 41 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index adbf674355b2..876d78eb4dce 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -859,7 +859,7 @@ void vmbus_reset_channel_cb(struct vmbus_channel
> *channel)
>  	unsigned long flags;
>=20
>  	/*
> -	 * vmbus_on_event(), running in the per-channel tasklet, can race
> +	 * vmbus_on_event(), running in the per-channel work, can race
>  	 * with vmbus_close_internal() in the case of SMP guest, e.g., when
>  	 * the former is accessing channel->inbound.ring_buffer, the latter
>  	 * could be freeing the ring_buffer pages, so here we must stop it
> @@ -871,7 +871,7 @@ void vmbus_reset_channel_cb(struct vmbus_channel *cha=
nnel)
>  	 * and that the channel ring buffer is no longer being accessed, cf.
>  	 * the calls to napi_disable() in netvsc_device_remove().
>  	 */
> -	tasklet_disable(&channel->callback_event);
> +	disable_work_sync(&channel->callback_event);
>=20
>  	/* See the inline comments in vmbus_chan_sched(). */
>  	spin_lock_irqsave(&channel->sched_lock, flags);
> @@ -880,8 +880,8 @@ void vmbus_reset_channel_cb(struct vmbus_channel *cha=
nnel)
>=20
>  	channel->sc_creation_callback =3D NULL;
>=20
> -	/* Re-enable tasklet for use on re-open */
> -	tasklet_enable(&channel->callback_event);
> +	/* Re-enable work for use on re-open */
> +	enable_and_queue_work(system_bh_wq, &channel->callback_event);

In this case and in several other cases in the Hyper-V related code, you've
used enable_and_queue_work() as the replacement for tasklet_enable().
I would have expected just enable_work() as the equivalent.  tasklet_enable=
()
just re-enables the tasklet; it does not do tasklet_schedule().

Doing the additional queue_work() shouldn't break anything; the work
function will run and find nothing to do, which is benign.  But it seems
conceptually wrong to have these places in the code queueing the work
to run.

Other than that, the code looks good to me.  I can see that there's
considerably more overhead in using a workqueue instead of a
tasklet.  Tasklets access with only per-CPU data and have no spin locks,
whereas the workqueue code reads some global data and does
a spin lock obtain/release on per-CPU data.  I haven't done any
perf testing, and won't be able to at least over the next week. But
the key scenario will be to test VMs with high CPU counts and lots
of synthetic and/or storage interrupts.  I suspect the additional
overhead won't be noticeable/measurable, but I agree with your
initial statement that this should be checked.

Michael

>  }
>=20
>  static int vmbus_close_internal(struct vmbus_channel *channel)
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 2f4d09ce027a..58397071a0de 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -353,8 +353,7 @@ static struct vmbus_channel *alloc_channel(void)
>=20
>  	INIT_LIST_HEAD(&channel->sc_list);
>=20
> -	tasklet_init(&channel->callback_event,
> -		     vmbus_on_event, (unsigned long)channel);
> +	INIT_WORK(&channel->callback_event, vmbus_on_event);
>=20
>  	hv_ringbuffer_pre_init(channel);
>=20
> @@ -366,7 +365,7 @@ static struct vmbus_channel *alloc_channel(void)
>   */
>  static void free_channel(struct vmbus_channel *channel)
>  {
> -	tasklet_kill(&channel->callback_event);
> +	cancel_work_sync(&channel->callback_event);
>  	vmbus_remove_channel_attr_group(channel);
>=20
>  	kobject_put(&channel->kobj);
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 3cabeeabb1ca..f2a3394a8303 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -372,12 +372,13 @@ struct vmbus_channel *relid2channel(u32 relid)
>   * 3. Once we return, enable signaling from the host. Once this
>   *    state is set we check to see if additional packets are
>   *    available to read. In this case we repeat the process.
> - *    If this tasklet has been running for a long time
> + *    If this work has been running for a long time
>   *    then reschedule ourselves.
>   */
> -void vmbus_on_event(unsigned long data)
> +void vmbus_on_event(struct work_struct *t)
>  {
> -	struct vmbus_channel *channel =3D (void *) data;
> +	struct vmbus_channel *channel =3D from_work(channel, t,
> +						callback_event);
>  	void (*callback_fn)(void *context);
>=20
>  	trace_vmbus_on_event(channel);
> @@ -401,7 +402,7 @@ void vmbus_on_event(unsigned long data)
>  		return;
>=20
>  	hv_begin_read(&channel->inbound);
> -	tasklet_schedule(&channel->callback_event);
> +	queue_work(system_bh_wq, &channel->callback_event);
>  }
>=20
>  /*
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index a8ad728354cb..2af92f08f9ce 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -119,8 +119,7 @@ int hv_synic_alloc(void)
>  	for_each_present_cpu(cpu) {
>  		hv_cpu =3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
> -		tasklet_init(&hv_cpu->msg_dpc,
> -			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
> +		INIT_WORK(&hv_cpu->msg_dpc, vmbus_on_msg_dpc);
>=20
>  		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx())
> {
>  			hv_cpu->post_msg_page =3D (void *)get_zeroed_page(GFP_ATOMIC);
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index e000fa3b9f97..c7efa2ff4cdf 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -2083,7 +2083,7 @@ static int balloon_suspend(struct hv_device *hv_dev=
)
>  {
>  	struct hv_dynmem_device *dm =3D hv_get_drvdata(hv_dev);
>=20
> -	tasklet_disable(&hv_dev->channel->callback_event);
> +	disable_work_sync(&hv_dev->channel->callback_event);
>=20
>  	cancel_work_sync(&dm->balloon_wrk.wrk);
>  	cancel_work_sync(&dm->ha_wrk.wrk);
> @@ -2094,7 +2094,7 @@ static int balloon_suspend(struct hv_device *hv_dev=
)
>  		vmbus_close(hv_dev->channel);
>  	}
>=20
> -	tasklet_enable(&hv_dev->channel->callback_event);
> +	enable_and_queue_work(system_bh_wq, &hv_dev->channel->callback_event);
>=20
>  	return 0;
>=20
> diff --git a/drivers/hv/hv_fcopy.c b/drivers/hv/hv_fcopy.c
> index 922d83eb7ddf..fd6799293c17 100644
> --- a/drivers/hv/hv_fcopy.c
> +++ b/drivers/hv/hv_fcopy.c
> @@ -71,7 +71,7 @@ static void fcopy_poll_wrapper(void *channel)
>  {
>  	/* Transaction is finished, reset the state here to avoid races. */
>  	fcopy_transaction.state =3D HVUTIL_READY;
> -	tasklet_schedule(&((struct vmbus_channel *)channel)->callback_event);
> +	queue_work(system_bh_wq, &((struct vmbus_channel *)channel)->callback_e=
vent);
>  }
>=20
>  static void fcopy_timeout_func(struct work_struct *dummy)
> @@ -391,7 +391,7 @@ int hv_fcopy_pre_suspend(void)
>  	if (!fcopy_msg)
>  		return -ENOMEM;
>=20
> -	tasklet_disable(&channel->callback_event);
> +	disable_work_sync(&channel->callback_event);
>=20
>  	fcopy_msg->operation =3D CANCEL_FCOPY;
>=20
> @@ -404,7 +404,7 @@ int hv_fcopy_pre_suspend(void)
>=20
>  	fcopy_transaction.state =3D HVUTIL_READY;
>=20
> -	/* tasklet_enable() will be called in hv_fcopy_pre_resume(). */
> +	/* enable_and_queue_work(system_bh_wq, ) will be called in hv_fcopy_pre=
_resume(). */
>  	return 0;
>  }
>=20
> @@ -412,7 +412,7 @@ int hv_fcopy_pre_resume(void)
>  {
>  	struct vmbus_channel *channel =3D fcopy_transaction.recv_channel;
>=20
> -	tasklet_enable(&channel->callback_event);
> +	enable_and_queue_work(system_bh_wq, &channel->callback_event);
>=20
>  	return 0;
>  }
> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
> index d35b60c06114..85b8fb4a3d2e 100644
> --- a/drivers/hv/hv_kvp.c
> +++ b/drivers/hv/hv_kvp.c
> @@ -113,7 +113,7 @@ static void kvp_poll_wrapper(void *channel)
>  {
>  	/* Transaction is finished, reset the state here to avoid races. */
>  	kvp_transaction.state =3D HVUTIL_READY;
> -	tasklet_schedule(&((struct vmbus_channel *)channel)->callback_event);
> +	queue_work(system_bh_wq, &((struct vmbus_channel *)channel)->callback_e=
vent);
>  }
>=20
>  static void kvp_register_done(void)
> @@ -160,7 +160,7 @@ static void kvp_timeout_func(struct work_struct *dumm=
y)
>=20
>  static void kvp_host_handshake_func(struct work_struct *dummy)
>  {
> -	tasklet_schedule(&kvp_transaction.recv_channel->callback_event);
> +	queue_work(system_bh_wq, &kvp_transaction.recv_channel->callback_event)=
;
>  }
>=20
>  static int kvp_handle_handshake(struct hv_kvp_msg *msg)
> @@ -786,7 +786,7 @@ int hv_kvp_pre_suspend(void)
>  {
>  	struct vmbus_channel *channel =3D kvp_transaction.recv_channel;
>=20
> -	tasklet_disable(&channel->callback_event);
> +	disable_work_sync(&channel->callback_event);
>=20
>  	/*
>  	 * If there is a pending transtion, it's unnecessary to tell the host
> @@ -809,7 +809,7 @@ int hv_kvp_pre_resume(void)
>  {
>  	struct vmbus_channel *channel =3D kvp_transaction.recv_channel;
>=20
> -	tasklet_enable(&channel->callback_event);
> +	enable_and_queue_work(system_bh_wq, &channel->callback_event);
>=20
>  	return 0;
>  }
> diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
> index 0d2184be1691..46c2263d2591 100644
> --- a/drivers/hv/hv_snapshot.c
> +++ b/drivers/hv/hv_snapshot.c
> @@ -83,7 +83,7 @@ static void vss_poll_wrapper(void *channel)
>  {
>  	/* Transaction is finished, reset the state here to avoid races. */
>  	vss_transaction.state =3D HVUTIL_READY;
> -	tasklet_schedule(&((struct vmbus_channel *)channel)->callback_event);
> +	queue_work(system_bh_wq, &((struct vmbus_channel *)channel)->callback_e=
vent);
>  }
>=20
>  /*
> @@ -421,7 +421,7 @@ int hv_vss_pre_suspend(void)
>  	if (!vss_msg)
>  		return -ENOMEM;
>=20
> -	tasklet_disable(&channel->callback_event);
> +	disable_work_sync(&channel->callback_event);
>=20
>  	vss_msg->vss_hdr.operation =3D VSS_OP_THAW;
>=20
> @@ -435,7 +435,7 @@ int hv_vss_pre_suspend(void)
>=20
>  	vss_transaction.state =3D HVUTIL_READY;
>=20
> -	/* tasklet_enable() will be called in hv_vss_pre_resume(). */
> +	/* enable_and_queue_work() will be called in hv_vss_pre_resume(). */
>  	return 0;
>  }
>=20
> @@ -443,7 +443,7 @@ int hv_vss_pre_resume(void)
>  {
>  	struct vmbus_channel *channel =3D vss_transaction.recv_channel;
>=20
> -	tasklet_enable(&channel->callback_event);
> +	enable_and_queue_work(system_bh_wq, &channel->callback_event);
>=20
>  	return 0;
>  }
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index f6b1e710f805..95ca570ac7af 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -19,6 +19,7 @@
>  #include <linux/atomic.h>
>  #include <linux/hyperv.h>
>  #include <linux/interrupt.h>
> +#include <linux/workqueue.h>
>=20
>  #include "hv_trace.h"
>=20
> @@ -136,10 +137,10 @@ struct hv_per_cpu_context {
>=20
>  	/*
>  	 * Starting with win8, we can take channel interrupts on any CPU;
> -	 * we will manage the tasklet that handles events messages on a per CPU
> +	 * we will manage the work that handles events messages on a per CPU
>  	 * basis.
>  	 */
> -	struct tasklet_struct msg_dpc;
> +	struct work_struct msg_dpc;
>  };
>=20
>  struct hv_context {
> @@ -366,8 +367,8 @@ void vmbus_disconnect(void);
>=20
>  int vmbus_post_msg(void *buffer, size_t buflen, bool can_sleep);
>=20
> -void vmbus_on_event(unsigned long data);
> -void vmbus_on_msg_dpc(unsigned long data);
> +void vmbus_on_event(struct work_struct *t);
> +void vmbus_on_msg_dpc(struct work_struct *t);
>=20
>  int hv_kvp_init(struct hv_util_service *srv);
>  void hv_kvp_deinit(void);
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 4cb17603a828..28490068cacc 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1025,9 +1025,9 @@ static void vmbus_onmessage_work(struct work_struct=
 *work)
>  	kfree(ctx);
>  }
>=20
> -void vmbus_on_msg_dpc(unsigned long data)
> +void vmbus_on_msg_dpc(struct work_struct *t)
>  {
> -	struct hv_per_cpu_context *hv_cpu =3D (void *)data;
> +	struct hv_per_cpu_context *hv_cpu =3D from_work(hv_cpu, t, msg_dpc);
>  	void *page_addr =3D hv_cpu->synic_message_page;
>  	struct hv_message msg_copy, *msg =3D (struct hv_message *)page_addr +
>  				  VMBUS_MESSAGE_SINT;
> @@ -1131,7 +1131,7 @@ void vmbus_on_msg_dpc(unsigned long data)
>  			 * before sending the rescind message of the same
>  			 * channel.  These messages are sent to the guest's
>  			 * connect CPU; the guest then starts processing them
> -			 * in the tasklet handler on this CPU:
> +			 * in the work handler on this CPU:
>  			 *
>  			 * VMBUS_CONNECT_CPU
>  			 *
> @@ -1276,7 +1276,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_cont=
ext *hv_cpu)
>  			hv_begin_read(&channel->inbound);
>  			fallthrough;
>  		case HV_CALL_DIRECT:
> -			tasklet_schedule(&channel->callback_event);
> +			queue_work(system_bh_wq, &channel->callback_event);
>  		}
>=20
>  sched_unlock:
> @@ -1304,7 +1304,7 @@ static void vmbus_isr(void)
>  			hv_stimer0_isr();
>  			vmbus_signal_eom(msg, HVMSG_TIMER_EXPIRED);
>  		} else
> -			tasklet_schedule(&hv_cpu->msg_dpc);
> +			queue_work(system_bh_wq, &hv_cpu->msg_dpc);
>  	}
>=20
>  	add_interrupt_randomness(vmbus_interrupt);
> @@ -2371,10 +2371,12 @@ static int vmbus_bus_suspend(struct device *dev)
>  			hv_context.cpu_context, VMBUS_CONNECT_CPU);
>  	struct vmbus_channel *channel, *sc;
>=20
> -	tasklet_disable(&hv_cpu->msg_dpc);
> +	disable_work_sync(&hv_cpu->msg_dpc);
>  	vmbus_connection.ignore_any_offer_msg =3D true;
> -	/* The tasklet_enable() takes care of providing a memory barrier */
> -	tasklet_enable(&hv_cpu->msg_dpc);
> +	/* The enable_and_queue_work() takes care of
> +	 * providing a memory barrier
> +	 */
> +	enable_and_queue_work(system_bh_wq, &hv_cpu->msg_dpc);
>=20
>  	/* Drain all the workqueues as we are in suspend */
>  	drain_workqueue(vmbus_connection.rescind_work_queue);
> @@ -2692,7 +2694,7 @@ static void __exit vmbus_exit(void)
>  		struct hv_per_cpu_context *hv_cpu
>  			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
> -		tasklet_kill(&hv_cpu->msg_dpc);
> +		cancel_work_sync(&hv_cpu->msg_dpc);
>  	}
>  	hv_debug_rm_all_dir();
>=20
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 6ef0557b4bff..db3d85ea5ce6 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -882,7 +882,7 @@ struct vmbus_channel {
>  	bool out_full_flag;
>=20
>  	/* Channel callback's invoked in softirq context */
> -	struct tasklet_struct callback_event;
> +	struct work_struct callback_event;
>  	void (*onchannel_callback)(void *context);
>  	void *channel_callback_context;
>=20
> --
> 2.17.1
>=20


