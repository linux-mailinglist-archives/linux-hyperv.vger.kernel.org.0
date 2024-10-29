Return-Path: <linux-hyperv+bounces-3215-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9669B5780
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Oct 2024 00:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B15284907
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 23:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34659212620;
	Tue, 29 Oct 2024 23:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KTH/RVad"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011037.outbound.protection.outlook.com [52.103.13.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7371120FAA1;
	Tue, 29 Oct 2024 23:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245491; cv=fail; b=CN9gMDgUhMn8hZIQn2nvyQuzSu2/67izRwd02IsQWDbeeGBuJ+0Bd17Zkq1rhzYvdZ+jIisei8wyYR04IV5pIO8xF4Q4AbV2ybqIiiM1l+7Qm0do0jRilSor1ss5Gx0dIAAJkNBF4jpQEdeX4DIueemSKeTHxvR8ppbkLyvwZls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245491; c=relaxed/simple;
	bh=ohvuKpPLfomqLgXtxPLLABcM4C7fZIpfMpF7t1D71Ec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gu/3bAHZq6v7ma6Qsb6uoNuCFuHIdmI8ow4DTeVrwZn+j4edLos6LrZHolTZGgdQN+1kDqXMFUZ/JKO1ET8LDpE0pO/jQM+0kRdJuXiO8dPbadaBEiQSujmYUyr42cqjvmCqfUh0g+A4t2/EERKIkHQ0gt7YxL68uDgjGW0wnjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KTH/RVad; arc=fail smtp.client-ip=52.103.13.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSJ47FznEDkPuk6np8tdu0/Z1KyTLsD1CozFmb3zhNRgZiXbwgyPKrCU3ug+SrC6RducJoUZUIOVsE1t7+haT9MY9jNBxo29uR9Yl/aq8PstbSVVlzs21qBPA4VnSpSxwsZCw5BUYFOz08eptZQ098ApnwGWcq0jOSeqgdlKS82Z6HpfbgVqCrugiPGQO+zjbVyo30P0uc6ayHyCxKmmmbZNT9X+XxdV9yqTdQZRWu6V460FCQTYl/bW/lJULKRu5ZFf8PedKqyyU4UtsIiPfpL5889ZRLzwrHdqb1t0jNjPhhuTbw4vtw5wuW3bZc2OydvsoRihPT0O/4cxRJsYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zl/OyZ0/0+FVXNDBJDUG4bZzSL7OruC4BxWhoynM1C8=;
 b=M7Qe16kiK4T7Fx4dk4W9NqcKbvL9aoIDy7fXaybkHxv9FGVbhcuPJBzMbrwHP2Nzqp0W+bm/kYybVV1sVZnhrDYYZo/Vp0OiqPjtaDFNYJqnO4OHhJCMHAG1MHt5v90GDm3+bxOHhnI9wDhfvcXmLOZRhawuEEE4H3WNYeSETEQcU3Q9P8avIe92HnBK3CX8T5nz4xzg+1ubA8IktWqfpgjo52uFzNSa/6xHkYUHaIWY8xq/5pdWtv1e45IJzPN6CTszUfCel5k3Ee8v2qMvsTvUCyU4+6vVOlLeqBwUI8rrHEL/espHhTfMtZeNipevakIGh9tuzBpYtyBebP0t7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zl/OyZ0/0+FVXNDBJDUG4bZzSL7OruC4BxWhoynM1C8=;
 b=KTH/RVadpnSpsXJFRZ5f4p/2YxLnvUnZL/DfIE2svfZykGz5hMBHl6azuJEIOTwu4WKkdp6lErKOQpFvYeZMDycOnE4a5BsiOWGfnOn01a7r13mBZzbQ00zKY82RpZPk41FFXpYg1OrTXu2jnXCluPhzaGhq0NmO3RCPqw9cH5ZwB1oZ5SwpMUEOGU2BeXd5DNHEFm9AiFg41paz+hssBxYRfet6fiaNgsitu3jsJFOEIyWdMXjosrZJbmU5BoQV2d/JvkgE1+p0BhY54IjamuVED4HkTv43SduNvSk9tA+C+xcV6TSMCQpbi0CxmUMt4zjrH2V66HDHysPwSxYNww==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY1PR02MB10433.namprd02.prod.outlook.com (2603:10b6:a03:5a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 23:44:45 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 23:44:45 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <decui@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "open list:Hyper-V/Azure CORE AND DRIVERS"
	<linux-hyperv@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: kvp/vss: Avoid accessing a ringbuffer not
 initialized yet
Thread-Topic: [PATCH] Drivers: hv: kvp/vss: Avoid accessing a ringbuffer not
 initialized yet
Thread-Index: AQHbAxLFR0Ovyi2Whk6CD70yxEN1m7KerxPQ
Date: Tue, 29 Oct 2024 23:44:44 +0000
Message-ID:
 <SN6PR02MB4157630C523459A75C83C498D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240909164719.41000-1-decui@microsoft.com>
In-Reply-To: <20240909164719.41000-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY1PR02MB10433:EE_
x-ms-office365-filtering-correlation-id: cc11bcbf-fe74-4e48-fa4d-08dcf873aacd
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|15080799006|8062599003|19110799003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?T1iQQyv8h0XOdUeCfXA37O/E3mFahzqyOtUMM1BgiGmZd5u5ePFcCrdXZiW2?=
 =?us-ascii?Q?G+kHJlwlfJR0vhUS30k7F+sySiGTzYAiW30rm2uGpd5XBHqE3iLipa9vyy5Y?=
 =?us-ascii?Q?YtAXWJ+763aKjJOwYxzD6NFXEtFHZ4BGbAK9F2JhJt41//Qmt1mMxCw9vtG7?=
 =?us-ascii?Q?4NSYO9LW1CpuEWdKtqq3mgVPHKssPpd6gof3x7yu5gZ/S/hpGAPFFN2NT9or?=
 =?us-ascii?Q?+5B64Dv+rikBQaOvTxnMLfsrrcjbsxLVQJCHJnaHHVSnvktt+Tc+GPxsLs9f?=
 =?us-ascii?Q?vHdMpyYSIB4LYK4A/SG400aaovQ3PZK2EE0bufFeZNc6+EQblRV1Xbgledst?=
 =?us-ascii?Q?oaw+00Dcw8EmL4XUiuXDBkuNiYAmgkKIg8yMf19pdQZoH1uJbaHLNu/055kb?=
 =?us-ascii?Q?LgH8Xxi0M+SA8cCU0+OrpT3YdNN2l1+IN2kDUdkNw/n4J7b9pc/yQvQeJGHe?=
 =?us-ascii?Q?DHFcDGRnF8DSrMus2DlH0swUyt+PZLsdV+8zY34CxHLzFj/K/M7zsiC5830I?=
 =?us-ascii?Q?Vt+C6KOHedBaAqb/FVEWAlvh5mgGfHU7Tzb2WiqsU1FDfBe9spRFNf7Zeasd?=
 =?us-ascii?Q?gMabhzVtHsmUrMRLGgY4ESPrncYD14mVYmcOV5xY9JgdLTD1o4DUySfNGSal?=
 =?us-ascii?Q?KHglMkKmuNZS7roomJ7Q05SiqqXWCvDZNw+n59uwxDCXtrPNqtaaoEBBZ2xu?=
 =?us-ascii?Q?mCn3EhqsCZBWwxSqD5+dw+9JU63fWnCwZSaKGQIkbJ+kr4MCaXFNprAQFUFO?=
 =?us-ascii?Q?qo6swTwcbfqKAs8HBx4yj51mUraJkK+JSfaCgQnS5m0a2kkjfVCfPb+8dpy9?=
 =?us-ascii?Q?gCBrKLan53kkgN2p2MuHueq1OkV7ZIXIfOPndNF0hXru1ztw2sKVhcYLkFxV?=
 =?us-ascii?Q?upvbZ5nrB4xtPAuwfJWxOsxV8gN2AttuaCsaM3x+EbD+2gPlc6NPdNo8RBY1?=
 =?us-ascii?Q?nqx8MkszNX30a8140coCY1cTJ2722sciPWGdh5K0pqza3luklq9Sw4QRhe13?=
 =?us-ascii?Q?dOU6HkRIpE3grAQ5ar+K6Df6Ew=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BowGrnfYpAA+KqXPMigsjwX1q5HUT7Hblf9x62hTlwFEPKfRe+DCPX7UgF+K?=
 =?us-ascii?Q?2TsHHDDJrCFXEXLz+lDeLtlJuykbBu5V1EW7lz4ielClDd8YUIV8kBAsvo00?=
 =?us-ascii?Q?iPqS85k+H7NRNiadwX+wn3ukAqCpUKpENOFLwjngRkVc3l9v3UiQ4uE/eRBs?=
 =?us-ascii?Q?NykvVksL9Odi39svPOlENSDtTBl0QN59RERywp/6FtOIgb122t2jRU/Q6PQZ?=
 =?us-ascii?Q?hnv6jtq0VT4x7yB+D6ANZV3ueFXL9WmBX4YkXi0jZRFRH0zOYrsNaaI1X8Q7?=
 =?us-ascii?Q?WFjEJpB8yu2GzOl1omm8QqOUJSK/d/c2fFg4sTZzYlJSj4yUym4a1l2+PFvF?=
 =?us-ascii?Q?AUaybUzUXH4mWA4LbsKiV1v1M6KSY3xde/PAQYQ9jzIGjDvWHbnwu007MqS8?=
 =?us-ascii?Q?Sii9PQN/XjyZrKxwODKYomTy4HDltyhAIZQT5Yme+/rI+XvSchbyRjwRrpl1?=
 =?us-ascii?Q?Wp9WSRXlmMdZcoVMseMgisXf2PafaMgnt1Vs1UopB+M83fKBwQsqnQjQqlkb?=
 =?us-ascii?Q?3ALuH9j8J6iqXyihIXQrp0c8oEJw3v92UxuDPGpOewYL4HkzTclm+LYm1dQQ?=
 =?us-ascii?Q?e3RTUnJYYZkGqxl/7gfI2p7my2JagkeRUTLR4WGsxkPRKvzYpxi/lnAVyeJQ?=
 =?us-ascii?Q?carSb2LqvSMGBbAEKSPDJJbzU+mSOayxwJuqTRnwOuEL++GIy+018CZ7e7ij?=
 =?us-ascii?Q?77I5wzgz9SemzQRdo19aSRAkHqH7n1ev8ll9gCg3H72lD1i6B87blazVSdq1?=
 =?us-ascii?Q?oEyky1JUxARB7Icv6RZfAHiok+73uETqI0C9tb2pjEEPEMFU8tq9A3tpT7vj?=
 =?us-ascii?Q?jThduxoMnCWP0hjhaUpzavgCme6d+YNdNS/pfA3p1siTVI0hozyXU1pU0vzO?=
 =?us-ascii?Q?8n8R1PFZeP2SEjeaqlAnQueCNdrnlz46dmhu1hoJ10bei4x6HJLl+sHV/Tww?=
 =?us-ascii?Q?IoLLsuxkNqpkPCOW7wOOGN4v4GD48ALgChADPwjS27zEDyhKavH6odpV1996?=
 =?us-ascii?Q?5UIao4dofD27yYjp6DxMUqaGSuBxdycvP/DdZQq5102vKD1ZWwWnLkZ2mXRv?=
 =?us-ascii?Q?QtOZeqh8h75S8Aj5AXeWFSU1JPqu63OlAzCV/sjmlw+QQwMjAIqM6C85Z9Gv?=
 =?us-ascii?Q?fLjaxCH5zC6uwyPKz5Gh9LWbEdsT/uWax/vWDKluBo3iJZVyd9l5c0sBoLBw?=
 =?us-ascii?Q?/RL7LfXtONb/0nb8HtKvITSdAigvYKBHbjy6/k82lGV6bUDj0j9O0hxJsug?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc11bcbf-fe74-4e48-fa4d-08dcf873aacd
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 23:44:44.9953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10433

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, September 9, 2024 9:47=
 AM
>=20
> If the KVP (or VSS) daemon starts before the VMBus channel's ringbuffer i=
s
> fully initialized, we can hit the panic below:
>=20
> hv_utils: Registering HyperV Utility Driver
> hv_vmbus: registering driver hv_utils
> ...
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> CPU: 44 UID: 0 PID: 2552 Comm: hv_kvp_daemon Tainted: G E 6.11.0-rc3+ #1
> RIP: 0010:hv_pkt_iter_first+0x12/0xd0
> Call Trace:
> ...
>  vmbus_recvpacket
>  hv_kvp_onchannelcallback
>  vmbus_on_event
>  tasklet_action_common
>  tasklet_action
>  handle_softirqs
>  irq_exit_rcu
>  sysvec_hyperv_stimer0
>  </IRQ>
>  <TASK>
>  asm_sysvec_hyperv_stimer0
> ...
>  kvp_register_done
>  hvt_op_read
>  vfs_read
>  ksys_read
>  __x64_sys_read
>=20
> This can happen because the KVP/VSS channel callback can be invoked
> even before the channel is fully opened:
> 1) as soon as hv_kvp_init() -> hvutil_transport_init() creates
> /dev/vmbus/hv_kvp, the kvp daemon can open the device file immediately an=
d
> register itself to the driver by writing a message KVP_OP_REGISTER1 to th=
e
> file (which is handled by kvp_on_msg() ->kvp_handle_handshake()) and
> reading the file for the driver's response, which is handled by
> hvt_op_read(), which calls hvt->on_read(), i.e. kvp_register_done().
>=20
> 2) the problem with kvp_register_done() is that it can cause the
> channel callback to be called even before the channel is fully opened,
> and when the channel callback is starting to run, util_probe()->
> vmbus_open() may have not initialized the ringbuffer yet, so the
> callback can hit the panic of NULL pointer dereference.
>=20
> To reproduce the panic consistently, we can add a "ssleep(10)" for KVP in
> __vmbus_open(), just before the first hv_ringbuffer_init(), and then we
> unload and reload the driver hv_utils, and run the daemon manually within
> the 10 seconds.
>=20
> Fix the panic by checking the channel state in the channel callback.
> To avoid the race condition with __vmbus_open(), we disable and enable
> the channel callback temporarily in __vmbus_open().
>=20
> The channel callbacks of the other VMBus devices don't need to check
> the channel state since they can't run before the channels are fully
> initialized.
>=20
> Note: we would also need to fix the fcopy driver code, but that has
> been removed in commit ec314f61e4fc ("Drivers: hv: Remove fcopy driver") =
in
> the mainline kernel since v6.10. For old 6.x LTS kernels, and the 5.x
> and 4.x LTS kernels, the fcopy driver needs to be fixed when the
> fix is backported to the stable kernel branches.

An alternate approach occurs to me. util_probe() does these three
things in order:

1) Allocates the receive buffer
2) Calls the util_init() function, which for KVP and VSS creates the char d=
ev
3) Sets up the VMBus channel, including calling vmbus_open()

What if the order of #2 and #3 were swapped in util_probe()? I
don't immediately see any interdependency between #2 and #3
for KVP and VSS, nor for Shutdown and Timesync. With the swap,
the VMBus channel would be fully open by the time the /dev entry
appears and the user space daemon can do anything.

I haven't though too deeply about this, so maybe there's a problem
somewhere. But if not, it seems a lot cleaner.

Michael

>=20
> Fixes: e0fa3e5e7df6 ("Drivers: hv: utils: fix a race on userspace daemons=
 registration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/channel.c     | 11 +++++++++++
>  drivers/hv/hv_kvp.c      |  3 +++
>  drivers/hv/hv_snapshot.c |  3 +++
>  3 files changed, 17 insertions(+)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index fb8cd8469328..685e407a3fdf 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -657,6 +657,14 @@ static int __vmbus_open(struct vmbus_channel
> *newchannel,
>  			return -ENOMEM;
>  	}
>=20
> +	/*
> +	 * The channel callbacks of KVP/VSS may run before __vmbus_open()
> +	 * finishes (see kvp_register_done() -> ... -> kvp_poll_wrapper()), so
> +	 * they check newchannel->state to tell the ringbuffer has been fully
> +	 * initialized or not. Disable and enable the tasklet to avoid the race=
.
> +	 */
> +	tasklet_disable(&newchannel->callback_event);
> +
>  	newchannel->state =3D CHANNEL_OPENING_STATE;
>  	newchannel->onchannel_callback =3D onchannelcallback;
>  	newchannel->channel_callback_context =3D context;
> @@ -750,6 +758,8 @@ static int __vmbus_open(struct vmbus_channel *newchan=
nel,
>  	}
>=20
>  	newchannel->state =3D CHANNEL_OPENED_STATE;
> +	tasklet_enable(&newchannel->callback_event);
> +
>  	kfree(open_info);
>  	return 0;
>=20
> @@ -766,6 +776,7 @@ static int __vmbus_open(struct vmbus_channel *newchan=
nel,
>  	hv_ringbuffer_cleanup(&newchannel->inbound);
>  	vmbus_free_requestor(&newchannel->requestor);
>  	newchannel->state =3D CHANNEL_OPEN_STATE;
> +	tasklet_enable(&newchannel->callback_event);
>  	return err;
>  }
>=20
> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
> index d35b60c06114..ec098067e579 100644
> --- a/drivers/hv/hv_kvp.c
> +++ b/drivers/hv/hv_kvp.c
> @@ -662,6 +662,9 @@ void hv_kvp_onchannelcallback(void *context)
>  	if (kvp_transaction.state > HVUTIL_READY)
>  		return;
>=20
> +	if (channel->state !=3D CHANNEL_OPENED_STATE)
> +		return;
> +
>  	if (vmbus_recvpacket(channel, recv_buffer, HV_HYP_PAGE_SIZE * 4, &recvl=
en, &requestid)) {
>  		pr_err_ratelimited("KVP request received. Could not read into recv buf=
\n");
>  		return;
> diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
> index 0d2184be1691..f7924c2fc62e 100644
> --- a/drivers/hv/hv_snapshot.c
> +++ b/drivers/hv/hv_snapshot.c
> @@ -301,6 +301,9 @@ void hv_vss_onchannelcallback(void *context)
>  	if (vss_transaction.state > HVUTIL_READY)
>  		return;
>=20
> +	if (channel->state !=3D CHANNEL_OPENED_STATE)
> +		return;
> +
>  	if (vmbus_recvpacket(channel, recv_buffer, VSS_MAX_PKT_SIZE, &recvlen, =
&requestid)) {
>  		pr_err_ratelimited("VSS request received. Could not read into recv buf=
\n");
>  		return;
> --
> 2.25.1


