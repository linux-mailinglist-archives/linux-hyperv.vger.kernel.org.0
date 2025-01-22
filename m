Return-Path: <linux-hyperv+bounces-3744-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF87A1957C
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jan 2025 16:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AF21882832
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jan 2025 15:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE6D2147E5;
	Wed, 22 Jan 2025 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VHo9GvpX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2038.outbound.protection.outlook.com [40.92.42.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4638DC0;
	Wed, 22 Jan 2025 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560409; cv=fail; b=tq3dtl4VGWvBy84NmcENMEAlPLIJILtp8rMibU4mL3CZTliZJ1NkJnpkVCb9xLODw4mw1dyGjKgszo1m4DfXTMWKUp97+JyXPvjOzZLzxGF+fYfM9qV1fr3itxnrsscdIzze4EoUAU275hdC+Oa0LBn++eGf0utbvZvoPkSAOW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560409; c=relaxed/simple;
	bh=mY3ZhbpPqa9k2u+QT8wAnr1YUvlEhOeiPb2gvwmb5wY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j1qpK6bxZ42PDxTMMUoMxpgc92ft5xDNFYjXSfaNecAv1o9heHBnI2ZoC+zu3NRZ98CHfojCHUwmEZ9MH6PbzpVuGtiSZ9WVtNStEgn6NYIqkq21/y73ESydxPC+hyvKfy2rdS888gzTTcz0fZAyS6VqtpKYBY3IydPuo459qO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VHo9GvpX; arc=fail smtp.client-ip=40.92.42.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLefbf6XkM1H3DRni0JKSV19da0K4RnFTDwouOz2YzbU36VuEw8NcJkt85npFlq0FVd67guVFUwgyA6Zl03xDCJwc0mKHAPsil7aRfEEc6Iw06uEzYT3qFfwfsWsh04mQR88Jlk58f8F9euNoUK4NJh49RQLC/7ijip59AtaS0kGQ4kohXocVdhpnn1sm/rw/E9/16KnOUqKpebmw4MKCxSHnKV1STZ88N4yZDDvFIUqbx47WiI9cZ1try0kH6ndo9aDZkqM69uIyhj5AmiH/3XXPN5UTLC5er5JbwLBSvdv9UGTRsGMN3xUdbGnoecpD+D9g2IHD6ZG/Lcb2dx8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qMHXNMoVhfZsbPr8/pVSP+nB6xpVHi9EDO1t3fmoKw=;
 b=GLspYgkGUA40BPEfghePKog3DVFY2c6bH+B2wKUgI+5LAt0WdDNS7IIJADjo+xV5/Ih/Y1QqtyEaxHAX7UzldmpH+FQfOw+kH7Ev3lPHxsBA9X/+CAFZx1mnyGvwHs+zOZmVgFGZjCR0E3jQsFgrzrxkyyu0CeQ1npMeQyZTqR65UtU/JdObVeUbcs+3FZ/9k0v/L28exFoFiTPuCcRqP7WytgsYok281Z9ffeXAVxDr+kFUM7PD8WQfHvpkrb201/kE6okQMjzCII6zbiYuY70HFcKFcRSx3ulRJRPgfz20YxSYh3WvC6LbvwgEYHZfJJoVA/fprgF2TbtTZe25QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qMHXNMoVhfZsbPr8/pVSP+nB6xpVHi9EDO1t3fmoKw=;
 b=VHo9GvpXov4Yg3ZhnieG/fjjAdCHdyWTQ1i91Rbxwdh5crRNdcN7bIKGqLpHnaLrwIm3m36MRcVs1tiZis2xI7K5M/tqdF/cBptqwwvwB7V+eZ0UQPcbg4dMnKuIMFH/EfzzCDkWskv/+hG0zx3yHbf5AIK+tT7GtFWKDpArk24wR/4fqq3CfQaFNvKCUkt6zA+csiNfRRPZlGvBJ1hsj343Nsm3EaUjA0UxFqRVV/FhfgA0V765OwFx1rDmOulTPzlRpuO1TU4UOmroG6xIw1qkvOfS9wCe/Gn+1HDHaOhpXrAA20tCG8iRlOZq+gX2pW+/vzGEmR+BmZHw7DlT/Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV8PR02MB9998.namprd02.prod.outlook.com (2603:10b6:408:184::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 15:40:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 15:40:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 3/3] drivers/hv: add CPU offlining support
Thread-Topic: [PATCH v5 3/3] drivers/hv: add CPU offlining support
Thread-Index: AQHbaR8W3qtIz70HPEqjSm/GSRWRhbMi9OnQ
Date: Wed, 22 Jan 2025 15:40:05 +0000
Message-ID:
 <SN6PR02MB4157B22200AECEE09849D43CD4E12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250117203309.192072-1-hamzamahfooz@linux.microsoft.com>
 <20250117203309.192072-3-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20250117203309.192072-3-hamzamahfooz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV8PR02MB9998:EE_
x-ms-office365-filtering-correlation-id: be605f6f-1414-43a5-127f-08dd3afb0b09
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799006|8062599003|19110799003|8060799006|102099032|440099028|3412199025|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FHt7ywanMlFB527yzbJM47EDkB9i0iG1dxwYJammOaP9B2QygRgxYGhvwQH8?=
 =?us-ascii?Q?HIH0lHjqSGTI0A+Y4Wy/YkhnYRXv9ZKp0m89DlU0uq2JBXEmH0UwnUlmyutP?=
 =?us-ascii?Q?G1LAmnRgB+ERpO/vzJgl8pHHCmWciZ1tTzBM8V/QYUnhfaiFSudkRWTMO0BB?=
 =?us-ascii?Q?se2TG/pXuc9KXrPXkCuja4CsrXyaHSrREVL7jxY4Vb1cru27U58FpBHsqCbK?=
 =?us-ascii?Q?xkerrbwtc90SWeQ8K0rdBi/7qTSrpnLpKPhPoqP7VpBIQ3ADOlIyPcDcedIP?=
 =?us-ascii?Q?IMZFeDFWoIzboLE0J93utN+LA9B5C3XhqApZCq0/B4AorTXLp5d+WQDW1dBe?=
 =?us-ascii?Q?xYtox11C6a7WlkqhLfXNwhoYjZP0r4WhaB4NGsSIVpfWXVW8ETgVfQ71MRmU?=
 =?us-ascii?Q?BNiF8hYF9wQQfLtdtONo0hRhjNtAYgzozjYNA/r0lXrVs0NEFpuyn3nuXOTC?=
 =?us-ascii?Q?FkRws0THXYg9Dww+6nOwTEQ4xZp79dLEaCuTG5ZlSEyLXZ7FaUIupL+fM4ov?=
 =?us-ascii?Q?2B2GgHn4xODzLLcXw0z7HYZPm8aWQUbT8RzJTasrVJoeWhxJhHhs2szGVnM+?=
 =?us-ascii?Q?cuCfVRepL+MEa83VslD78+0oE9NDz6rzoJhNFH2jSzyEwMQR/QJ2nxABacda?=
 =?us-ascii?Q?yzerVoAZE3N5hQBv83hkXLTYeos0VcghVqcHYyRnCArYmshCwE3sS8C1auvt?=
 =?us-ascii?Q?Md8fxc8P8QRk46Bn6f54utGtJykcdQDKRDaUrU2B6zL3NN5M2UR8wjKsb00f?=
 =?us-ascii?Q?ysPuvydS67y5yLhQnxmwI5iSjk1zjHDnKaA3tfl5T2HTw5Aeda9mFfCJEg6b?=
 =?us-ascii?Q?i+QoLyCgQOLVlvV5Sr744VJ6J/INOitf2SESjQjf58S0zQiBxvBC+gECP+6l?=
 =?us-ascii?Q?2kF+3OFY4OAQfleJa0+N/Ok5BMCFVKH6v9/ejl7RY3uC3W0BfKdhrWJfdOXY?=
 =?us-ascii?Q?yIZyZB2BrLLxC0mZIzoQ8+mXPvmmpeohn0yxhlrHNzMg3wKVJjjX2tmIYurR?=
 =?us-ascii?Q?xut1r2fRohnEXh9TP1F4TkYtUfJiHnD/R7UJ67kqF5FTdgixk/TPpTKNPLL4?=
 =?us-ascii?Q?NAze/J5ubSRV+WZmyYD3jGlPROE52g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Gb3c49hI1ZxtVgOtRPrgAcCk8jf4JHtfqmfkzkGlvQpFBGKBETGtAvbXSVy6?=
 =?us-ascii?Q?kA7JG6LuGtMRtNlCov/9cGQg1dpTjb2aA0K4+Vn8LQk+sGbaqwrO1BkHqZyA?=
 =?us-ascii?Q?PPJBR0ZfRiGg6SdkQUEPy6BzpO6smdzSAPdSr/4MBSnJxZYnXDSmYPky4Vpl?=
 =?us-ascii?Q?SeUb+ih5NAbwt6saPCvcIuEIPy8DM5Xyza2To89lkC9bntQwBqwWyshNARiZ?=
 =?us-ascii?Q?jPYVR2LrcFk71xI0W+vBpclMPie0LP1ufSQBAMUP4RfjESaEmBWt2tFAqztn?=
 =?us-ascii?Q?78ImQa+Bgezif9IyK4apJSDPLUSfX4yTQqFBeQ/2LU3tv3WBvi5AYTnpQZXU?=
 =?us-ascii?Q?w0GBa445OULkxelVPBll9VJV9NzUNjOVwYI+6fFUBh8+L43Ttq7yU80jOUf0?=
 =?us-ascii?Q?7/CFzARJydlwRKBrChdPtymHzVHiSpBkr8S9NDmA14NhEjK09HTTdZ6BjmKc?=
 =?us-ascii?Q?cnQrs1dx7fC/6dxxCitkf8ZTIln4s+aVkxfMItu9F8bba1CcK751de9Gb5hz?=
 =?us-ascii?Q?ilOehwj3Z81d6AwupRqwIdbk47M+y19BrHegQ3NhMXOgcBoEtk29HDT+nxd3?=
 =?us-ascii?Q?URHckua6iy57NM/czwPCdLLpx6goYlkuOp8tDXNNyvx2+Uv66kRCW7fr3Fq1?=
 =?us-ascii?Q?g653I3+O8bXxFNA6ZAFoNTvlp9sO8/anm9mqR0K1jUfajrG32ALZ3pJeAZAN?=
 =?us-ascii?Q?9C4iwWWawSPc+szSRHtA0QInCxZpLQTPWM145mMzMAu1kzTeYMxCH/i2I/xT?=
 =?us-ascii?Q?+3DjKYJsyzkIw5ZgmSwiRMs7uBUuOIsaVjz/S5PYnxoaEMBKJ83lUxw5pg5E?=
 =?us-ascii?Q?zrMtZMi0ZWQl8K6dWmbKvO4d1Z8zquGatgQxvYFpZTLvKhQFc5AnZC8zKGNc?=
 =?us-ascii?Q?xY8hqDad97rzxrejXRZtCQnXDN4TMFIwY2ysJ+mSuIC1/09cSifPstOJKoAZ?=
 =?us-ascii?Q?v5GmH14WsUvNwnvrQjZHzIWQ6xVShuJ+uq7toFKrJX6Q9VY5Qj6pyx/hS0Ld?=
 =?us-ascii?Q?t/ELV47jKb4IdXnNzSXYY3FbHoIALVTnRkJa2HGYu4kiChyTXPEq7P++bqax?=
 =?us-ascii?Q?z3xkPDdWMvEzB6VKpxxsaNGF5hZpzAsHejKw8hHwKOmYXEFV8kcMDtcl05bM?=
 =?us-ascii?Q?5+XgdHWiH3k1I9x5qH6M7y5kJFnI29sNLkNi3iDNpDAtdxeOYCwE75uk+m4k?=
 =?us-ascii?Q?xsTrY1NmA9v9eP6mktuGJ3aszFNAX/x1q1cvkIPNeA8IPBBfKE3XShuZgi0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: be605f6f-1414-43a5-127f-08dd3afb0b09
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 15:40:05.2596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB9998

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, Januar=
y 17, 2025 12:33 PM
>=20
> Currently, it is tedious to offline CPUs in a Hyper-V VM since CPUs may
> have VMBus channels attached to them that a user would have to manually
> rebind elsewhere. So, as made mention of in
> commit d570aec0f2154 ("Drivers: hv: vmbus: Synchronize init_vp_index()
> vs. CPU hotplug"), rebind channels associated with CPUs that a user is
> trying to offline to a new "randomly" selected CPU.
>=20
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Michael Kelley <mhklinux@outlook.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
> v2: remove cpus_read_{un,}lock() from hv_pick_new_cpu() and add
>     lockdep_assert_cpus_held().
>=20
> v3: use for_each_cpu_wrap() in hv_pick_new_cpu().
>=20
> v4: store get_random_u32_below() in start.
>=20
> v5: style fixes, use target_cpu and set ret to -EBUSY by default.
> ---
>  drivers/hv/hv.c | 72 ++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 51 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 36d9ba097ff5..fab0690b5c41 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -433,13 +433,47 @@ static bool hv_synic_event_pending(void)
>  	return pending;
>  }
>=20
> +static int hv_pick_new_cpu(struct vmbus_channel *channel)
> +{
> +	int ret =3D -EBUSY;
> +	int start;
> +	int cpu;
> +
> +	lockdep_assert_cpus_held();
> +	lockdep_assert_held(&vmbus_connection.channel_mutex);
> +
> +	/*
> +	 * We can't assume that the relevant interrupts will be sent before
> +	 * the cpu is offlined on older versions of hyperv.
> +	 */
> +	if (vmbus_proto_version < VERSION_WIN10_V5_3)
> +		return -EBUSY;
> +
> +	start =3D get_random_u32_below(nr_cpu_ids);
> +
> +	for_each_cpu_wrap(cpu, cpu_online_mask, start) {
> +		if (channel->target_cpu =3D=3D cpu ||
> +		    channel->target_cpu =3D=3D VMBUS_CONNECT_CPU)
> +			continue;
> +
> +		ret =3D vmbus_channel_set_cpu(channel, cpu);
> +		if (!ret)
> +			break;
> +	}
> +
> +	if (ret)
> +		ret =3D vmbus_channel_set_cpu(channel, VMBUS_CONNECT_CPU);
> +
> +	return ret;
> +}
> +
>  /*
>   * hv_synic_cleanup - Cleanup routine for hv_synic_init().
>   */
>  int hv_synic_cleanup(unsigned int cpu)
>  {
>  	struct vmbus_channel *channel, *sc;
> -	bool channel_found =3D false;
> +	int ret =3D 0;
>=20
>  	if (vmbus_connection.conn_state !=3D CONNECTED)
>  		goto always_cleanup;
> @@ -456,38 +490,34 @@ int hv_synic_cleanup(unsigned int cpu)
>=20
>  	/*
>  	 * Search for channels which are bound to the CPU we're about to
> -	 * cleanup.  In case we find one and vmbus is still connected, we
> -	 * fail; this will effectively prevent CPU offlining.
> -	 *
> -	 * TODO: Re-bind the channels to different CPUs.
> +	 * cleanup.
>  	 */
>  	mutex_lock(&vmbus_connection.channel_mutex);
>  	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
>  		if (channel->target_cpu =3D=3D cpu) {
> -			channel_found =3D true;
> -			break;
> +			ret =3D hv_pick_new_cpu(channel);
> +			if (ret) {
> +				mutex_unlock(&vmbus_connection.channel_mutex);
> +				return ret;
> +			}
>  		}
>  		list_for_each_entry(sc, &channel->sc_list, sc_list) {
>  			if (sc->target_cpu =3D=3D cpu) {
> -				channel_found =3D true;
> -				break;
> +				ret =3D hv_pick_new_cpu(sc);
> +				if (ret) {
> +
> 	mutex_unlock(&vmbus_connection.channel_mutex);
> +					return ret;
> +				}
>  			}
>  		}
> -		if (channel_found)
> -			break;
>  	}
>  	mutex_unlock(&vmbus_connection.channel_mutex);
>=20
> -	if (channel_found)
> -		return -EBUSY;
> -
>  	/*
> -	 * channel_found =3D=3D false means that any channels that were previou=
sly
> -	 * assigned to the CPU have been reassigned elsewhere with a call of
> -	 * vmbus_send_modifychannel().  Scan the event flags page looking for
> -	 * bits that are set and waiting with a timeout for vmbus_chan_sched()
> -	 * to process such bits.  If bits are still set after this operation
> -	 * and VMBus is connected, fail the CPU offlining operation.
> +	 * Scan the event flags page looking for bits that are set and waiting
> +	 * with a timeout for vmbus_chan_sched() to process such bits. If bits
> +	 * are still set after this operation and VMBus is connected, fail the
> +	 * CPU offlining operation.
>  	 */
>  	if (vmbus_proto_version >=3D VERSION_WIN10_V4_1 && hv_synic_event_pendi=
ng())
>  		return -EBUSY;
> @@ -497,5 +527,5 @@ int hv_synic_cleanup(unsigned int cpu)
>=20
>  	hv_synic_disable_regs(cpu);
>=20
> -	return 0;
> +	return ret;
>  }
> --
> 2.47.1

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>


