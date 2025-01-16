Return-Path: <linux-hyperv+bounces-3697-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83078A140C4
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2025 18:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DA73A3CEE
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2025 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FC422BADF;
	Thu, 16 Jan 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dlPTTqSF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazolkn19011038.outbound.protection.outlook.com [52.103.7.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E827F22C9F6;
	Thu, 16 Jan 2025 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737048016; cv=fail; b=G1Bcccos8LiSYIQYsmegKdNcOeZ5ZcV5OcAktDIma1xW4RUFUce2IjN8IAnexJPV6VItOe0Xn/MxQO7J+EbHhutZME0CrPz96V8wHR+2bSic/UwDU6FtW4+xe+8o2wfKxgXgCqpWagrlpPzTUTt1Ysl6GpMWcUVo8Xs4YzpXRQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737048016; c=relaxed/simple;
	bh=nOYbmbJBNEOAJLQ4hFfWTOzDb7uxwajmFdq109AlKrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pZznfdRlPzTb4zJP0zSYct+CRt3U+c616/xeWMVxeIpbp2c/nTOPmlgs9ImVOWeo5ZG08a6ypoRivbOd5Affndig32BkRhkp/eH+V3BDkbbYeTj5Znf5k9V0PgYVY17/RRHt7cGYPast/hvCqWBVPZkbgEVvU3EDBJRJlx+3yfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dlPTTqSF; arc=fail smtp.client-ip=52.103.7.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCG/4p25jjZDWh7jj0/9+nja+oSGfxb9jZWHqXqg8BJctD9M0tzwAeZ9dn5JP4R+d02XQIqJEvmSmwSwtOe7hFIDfvGkMMNib8XqjehnBc2CeVv4jx/QEn9PA5NYjb/clAT71w5JXOENSOLCs/XuMfjvjitwuirh8+RnDktvNNsSXJcqMOh4bpXegyqiBH3Z1UHK4jkn4xHfsrZr1JoxQXCP07G3/7S6fGfjede5HpQiQU7fOtx30N6am84OW7ZMkr+Q4DYIw+d01U2UOCMV8lFAFIo0yX6J0AGySWBCJsHzi31HKms9zYoe2pNNANfzn4NUB5Dj49Xik5jqHKmv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR02vu2ye9P3P1W7KfSC3816cRlC4Ov/ElpGLiRsJ3g=;
 b=nVa2vCwdN45dXkrSR7tqJJQXIQgPducOIUhyEXR93IB8LNFGkRLUfIRVvQewSeX1yEgoTAxCYgBbuUpkcrpMo+c0gFSkFYAXWRd/GDpFUlm45pGNpaWpgMvuqwS/XjbZDgxETQvnjW268VLJaZ2RuJxm6SJkmMjDkjIHKWq7fnDuzNKKKsX6ZGLU2t+2gkOy3NmuZuaajvBncpImDgi9//CfUWl1VCodv9WNnzhuMnoZaHjS4tSrpudDfrdqKm4bJjdCaLr6dkKzKf7+QgTTqlTDC8DhL2EDciz/h03aqzVxa9PIfLol5b+S8YNkSlESl8onTm7lehA5D95dvVw+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR02vu2ye9P3P1W7KfSC3816cRlC4Ov/ElpGLiRsJ3g=;
 b=dlPTTqSFOeXVfL0VK9R4UMTZMdNYcAI5+oxxR18czuShyz3+zjcGLRslnTG45mSt9BWwpDyTKGL9KqKSX4Ji1DqcPuV+FReo9fM45noW/mZbdYUmpd9LbDOUaXJVgh1eSSbo/KA6D4CO3iE85Yhrl0jz+RmRpihZ2H17iueQ1vUAOi3yGwW+ELXyzVfcY8NdTURLp/jaRJ/y3+nao4TPorIG+DckYXWgRvKWW7J+RaXDILzr0s3SYqVVT6EvL2mzkHe5uvcQui5H3L/MvHiGviHXaasAuAGpRSphEcm6qeODn8YJkzCecMdwUQwZMCvmpZu3fVQrOdlnZ6sKqZiBBw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8635.namprd02.prod.outlook.com (2603:10b6:303:15e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Thu, 16 Jan
 2025 17:20:12 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 17:20:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] drivers/hv: add CPU offlining support
Thread-Topic: [PATCH v4 2/2] drivers/hv: add CPU offlining support
Thread-Index: AQHbaBxpUxVLf0FolUGrKJfrZGPjl7MZngpw
Date: Thu, 16 Jan 2025 17:20:12 +0000
Message-ID:
 <SN6PR02MB41577ABE2174E5630703F842D41A2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250116134136.66749-1-hamzamahfooz@linux.microsoft.com>
 <20250116134136.66749-2-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20250116134136.66749-2-hamzamahfooz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8635:EE_
x-ms-office365-filtering-correlation-id: 579b9fa0-f624-4859-4332-08dd36520925
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrPgu9FUvYZ88hunKvKD6srSLFVp6T5xwK6Qp07NI6oMEoo8nS++ZPIUhEFUMK3IWWXDz0tQJ04xov0jpgdKNqL2Dhsewop5zeVCIh3OaSXXgcKhh38MTWiLx2iIlL0OoAE+p9BtQONEzBAdHUen+POPjFo7Z2MkWcVsMNF3xoKfB/77H+kncC3bN3KDqwdjgrjdFOuowKo4GFihQ5EPfh8/iCAOMh8TkEc0BnI1HjBRM8MfoYWwXPcWyPGq7YwWTTvVnQRWhByxXDiQmnIXy6lqPhAQgvXTjq/dGUbvOe+q+Trj03kwHlSYvse0c5xbV4+swWw/btcT4LAvY4DfahjHeY+STNJEjZwErAO2YVArQZjLmpsVskJifKyKttsSjWCxS3j0BORZdCZ9auenys2piouavmHyX2lCi3sGp6ScWFnwNiKXBorU9atyfkENepPmzST+ZyA3rr26rgLis9Ni+Ooh7VcoVkv3dVYo6dkA75jIQ4cn4u8/+p7zYhYg4rBaYTYz4NTehvJCeWq9PNz4KI5g+CyrbuSaQNl0UOXFs/gwThaJnvSvsw95F0LTAizpgir7wRF5fINNM6NefvNf0zez53RyTfx1GuedbP6Fdyh7CGInoAABZeTcYYcWmwZYmO99kSO88jtfqrbCaI9pcA/75VzNJOzejMLRsfLaLUeRn1mM6gcMcFsHXJVKsOgQtVt/k+dqDa8eXmYZcPXk9kocVN8/hPCPG0xvWpDmbzu1cBzm13nJVD9XqxShE/g=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|8060799006|19110799003|15080799006|18061999003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?o36vK4axdLHNfbLVaeQJIKrgrq3zTSSr52dSBnPAbLIApoGgfXEOZTUBY63B?=
 =?us-ascii?Q?F6YyyuzV25TC/1cq1Ciw0nNoIfyJDsruABneBQ3taX1HlvYRahT9Ov2Tl2/H?=
 =?us-ascii?Q?XF17xrB5CpIW4VsfW38Ap7ON9ClfEP4i3bqQgJNC4CjH8sQQ527pTNqNYidE?=
 =?us-ascii?Q?+4h9gfmcYUt24vikPowoGOwZlCp3HXCdyHvp9p8amT+l8IYE43ulBnjFOeEO?=
 =?us-ascii?Q?zwC5sTHSrOjS+mGHXVFHn+ea0qPGMuN1ScZMpR+olCS7Nm8vTRyVTCFQoPni?=
 =?us-ascii?Q?2TMM/Kd1zI5nE9tTy3Xma8aV6WRqxv9rXjsQuARonKkG56jazTXbdqzaGRMK?=
 =?us-ascii?Q?/F3WshqB2jxNwNN8ecZr0fDjV+aUsWEFxl2JdFGC5qsWHSJTf63e/Jqp9d7J?=
 =?us-ascii?Q?k9P33jX8IKETQssMgeek/xWgZiCvo6REvlb5SZWRcl4A0IdDzwXXWaQQDfgU?=
 =?us-ascii?Q?b8STgdovYoZLCB8FdMqjefI24GoD467dkLQLZu++1rhkTmRcv6mDtegUHR/g?=
 =?us-ascii?Q?qyV6EjBXiITHQlCY2DB6zk0q/V1v1H1T5SXT690egrX04WOf7I9rd+fqFJwl?=
 =?us-ascii?Q?QKoXJViN0X7rKuG9PJxbAJKiy5QoTOCNRH52z0bsmbKDtNRifXEYSSiSH84f?=
 =?us-ascii?Q?SafVEc2DwFsF+PWdL0Mbmkgv04FbKmnXnKGW+eQ1UMERWbaeICeSd4k5ty2N?=
 =?us-ascii?Q?pwQFzAAPd96gMZk7JyQC0zcG1lB0extDavtG95zs/Dx/aWA04lxIQDUHqYYw?=
 =?us-ascii?Q?iCZuljW/6AIorthB5c0oO9jSxxy0xMPwgCpQStCGo+hAsAC3Qvi2mmjK+0zI?=
 =?us-ascii?Q?qiA819LFPbVh+ujpu6C3lpE5/XSqMNftEfVm/Or41lTqHRdbHvXVl6vLfuMH?=
 =?us-ascii?Q?Hdb2w2IT5+o868YOY4tKRRI9qgwGtlZ4xPT8wX+67jkqP9matWTUQFqc7QQt?=
 =?us-ascii?Q?30/VcoK8h2j+tdF80ejUBobY4VqRJ/bSMQjUEmKQM6jhYepjXW1nQDHeuvYE?=
 =?us-ascii?Q?T2qHWQy5CwfFAwmv2eLji1y6a1Jp9RIIpyHZvyT4IHbZUtlMw0pWsUlMFsPb?=
 =?us-ascii?Q?a0WpmryHEq/ar8OIJew8IcioRrVJIQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9BH6086EeqaF9EwuTXY3cET/Jz2ToN9IFqvqgAVDnd8WAk3rrIAA/Tkhz4tR?=
 =?us-ascii?Q?FEabuPA6pZaseu7YlEJgNmE88av8s4TB95jj/9qy/GcMaSGrpRDGGFBcZli+?=
 =?us-ascii?Q?OGY43LfNNleuqkyfYb40nA7oibPXWSO9aRBD7mr3ugei5qx+jOcZ9auHpLrB?=
 =?us-ascii?Q?wYzVJZuH0DNsQ5wLqglM5ffyFziXGjixU6PBYtaHk1m84as5+ntDKdCrnPmb?=
 =?us-ascii?Q?xjIctDpM30lfkVBCniwLm6vGRF8xGCtxGXX6/7lnYArm8kN9YiXyhZiWKxHG?=
 =?us-ascii?Q?BW7U3jWaSDb9KnaP2jDzgfmX2arXga2Yz/2XRFKsr/x5w8wVf7DRc4zMbt+a?=
 =?us-ascii?Q?MYklK+z8zLPm+GNSspKZtaGoQTYzGlCoJ16A40bRYSSB0T+rL3gte6WC6lmH?=
 =?us-ascii?Q?GsncrokCV0OSiNDYe3WFFfqPyPSEvwqmRKmwOEeNNQYL8ccGLAVt156A00ci?=
 =?us-ascii?Q?xpK3ssTbmGU0fYVze4b5BHTSU3Kje9ojrGAliznT7q8lzrqFLEIUnGRUQcNH?=
 =?us-ascii?Q?RE6ojbl8YbSdoSv22Tyei/LOtWyHe4oVG3ovXCs+sI2obkPpsTbTPjgFnxJz?=
 =?us-ascii?Q?r5u38Z3hqULUnI2b0JWiXzSkx/rOwyBHl/p5Eol4L1TdpeIDQqQOrtRHcazN?=
 =?us-ascii?Q?6L3UY+vQT5qZ/ThRMlbkhr0s8e/vI4+8A74j5ktaeiZWzcuQCMHeZXt1UpU1?=
 =?us-ascii?Q?p5zmQb7HlaVEVVqDBNr73XNjhUKVsi3kcjInk/+M/+4p8DfRpMp0ptfetyhV?=
 =?us-ascii?Q?S82m9C27cLyoIMrqqaQAlG+p+q2IAqGA5Vux6uC7SS3AaoOZz/F0jF0vgLP7?=
 =?us-ascii?Q?If0aVDYIPbcz9KbQFlXBmfjntLv/CoivSYB7ZBvAW/pXs2Jl9l+qq2H04EMV?=
 =?us-ascii?Q?QKfVJId1VHUlHc9dBT9GT86nIEcg7pGR6zPekNV4evcd28wRtpOn9/kQtRyQ?=
 =?us-ascii?Q?gG8YWwEWCVbA3O59CVAgbSqFIM8nYmuqFNTtxU7zGQpqp3xLGngHO/RY9oaX?=
 =?us-ascii?Q?LOFzxOvBpcchNJPKUF1+iqlTFXy7vqOF4P2lzxLQ7vgoK9XMfLL6fp9eCmBg?=
 =?us-ascii?Q?onDqbXFxtplYxvfiHnNKows/rzcqZN12JbTxdeH5Oj5BY42iMuIt21MKiXro?=
 =?us-ascii?Q?KghOK9cRMvB3vqiodUWD2OHy5b1LVyMoQbDEITDw4skuGh04m+xaVGKWvMnv?=
 =?us-ascii?Q?O2ffEmZsOlCnfuZbVA3tRTgiE7MBv6wDQFut/R2s8YcXDF/uyDaunWFQpzs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 579b9fa0-f624-4859-4332-08dd36520925
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 17:20:12.5036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8635

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Thursday, Janu=
ary 16, 2025 5:42 AM
>=20
> Currently, it is tedious to offline CPUs. Since, most CPUs will have
> vmbus channels attached to them that a user would have to manually
> rebind elsewhere.=20

Cleaning up the punctuation and wording a bit:

Currently, it is tedious to offline CPUs in a Hyper-V VM since CPUs may
have VMBus channels attached to them that a user would have to manually
rebind elsewhere.

> So, as made mention of in
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
> ---
>  drivers/hv/hv.c | 65 +++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 50 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 36d9ba097ff5..4388c0030a59 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -433,13 +433,48 @@ static bool hv_synic_event_pending(void)
>  	return pending;
>  }
>=20
> +static int hv_pick_new_cpu(struct vmbus_channel *channel,
> +			   unsigned int current_cpu)
> +{
> +	int ret =3D 0;
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
> +		if (cpu =3D=3D current_cpu || cpu =3D=3D VMBUS_CONNECT_CPU)
> +			continue;
> +
> +		ret =3D vmbus_channel_set_cpu(channel, cpu);
> +

Avoid the blank line between setting "ret" and testing it. If you look thro=
ugh
other Linux kernel code, you'll see that the set and test are almost always
grouped together with no intervening blank line.

> +		if (!ret)
> +			break;
> +	}

The loop looks good as a solution to filtering isolated CPUs!  But there's
a subtle bug. Consider a VM with two CPUs. One of the CPUs is the
VMBUS_CONNECT_CPU, and the other CPU is being taken offline.
The loop will exit without ever having called vmbus_channel_set_cpu(),
so "ret" will still be zero. The check below will *not* call
vmbus_channel_set_cpu(), and the CPU will be offlined with the
channel interrupt still assigned.

I think the easy fix is to initialize "ret" to -EBUSY, but double-check
my thinking.

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
> @@ -456,31 +491,31 @@ int hv_synic_cleanup(unsigned int cpu)
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
> +			ret =3D hv_pick_new_cpu(channel, cpu);
> +

As above, avoid the blank line here.

> +			if (ret) {
> +				mutex_unlock(&vmbus_connection.channel_mutex);
> +				return ret;
> +			}
>  		}
>  		list_for_each_entry(sc, &channel->sc_list, sc_list) {
>  			if (sc->target_cpu =3D=3D cpu) {
> -				channel_found =3D true;
> -				break;
> +				ret =3D hv_pick_new_cpu(channel, cpu);

The first argument to hv_pick_new_cpu() should be "sc", not "channel".
Currently you'll be updating the primary channel, not the intended
sub-channel.

Also, you don't really need to pass the "cpu" as an argument to
hv_pick_new_cpu(). Just have that function take the channel as its
only argument.  It can get the cpu as the target_cpu field in the channel.

> +

Avoid the blank line here too.

> +				if (ret) {
> +					mutex_unlock(&vmbus_connection.channel_mutex);
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
>  	 * channel_found =3D=3D false means that any channels that were previou=
sly

Since the "channel_found" local variable has been removed, this comment
needs some cleanup.

>  	 * assigned to the CPU have been reassigned elsewhere with a call of
> @@ -497,5 +532,5 @@ int hv_synic_cleanup(unsigned int cpu)
>=20
>  	hv_synic_disable_regs(cpu);
>=20
> -	return 0;
> +	return ret;
>  }
> --
> 2.47.1


