Return-Path: <linux-hyperv+bounces-3743-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D1FA19579
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jan 2025 16:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0FC3A3FAC
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jan 2025 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A120721480A;
	Wed, 22 Jan 2025 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SQ/9ERXK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2021.outbound.protection.outlook.com [40.92.42.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DD2212B1A;
	Wed, 22 Jan 2025 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560347; cv=fail; b=cXzdqR9EqWtRkLi6Zzbfdfr97mkdFVwtJNL0mahEMrK94xCWpvJHMuQ3ByJvSIy4KDPYwxrgNRlkivlUpODV0bLU4YUSiRkwhml88ssCWX8QvWCIfj9+WnI5WMfX0NB53TT9ODSe2/xgHXbUQdeohbSECz9vHwlTBqrqmwukJds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560347; c=relaxed/simple;
	bh=UvBrrbCIxCNfNVPeroVBoJ4h+IGuYXy/J0yj+7AgVns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oz2NNhzKakiQbQMblEkxl9cN1uCC3TTXRln7k6p86nCRLS1TQYFjXHHPx+qCQv3gGQ4zGBauVX8nGxnPdi/u789IKPTjbB5sSBJHp/vDx5VAerP57FkS2AgVuJKzoqnJXkLsTurTdQVKZkHmydvelgzl/OndTNBQDPz/7IYeW6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SQ/9ERXK; arc=fail smtp.client-ip=40.92.42.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2TIr8eN3cteicSdNvp5NewjehxvL8oMrEaRA7E7g+OgrknfXsJL2o9bRqpxxtS8A9CBZzw3dC4ng9qQprgowqwPMqU4S5aYTK/zAV5Y0uK6pnWqQLcks0LX0nELRd6CFhXT+jA70gf1iKObhrg0viDyp9zwAv1qkUYyrLGpT9DLsdb3rl9UPZPiMAHvnlosQ6G0ksMwG/kdlRK63Z8tIz7sW7tchVWS3LsfHJhlljz6TznF99uXBmQ/q4qyZIYlNyb3bVFqJUIbB37zusEqKFLtiv+UUr8psPbPJT/I0jJtaNyURYeAajrsScUZbwhEDeWoOu7AGCe86W9l1MhS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0B5qpVOigb0cDkf6r1qKgGhuwwThHbl32L1yesu7XaE=;
 b=E9SNmfUQSssoobhc8mqGz5Xo2yK9T5/+L9IeNdcPavbX1bdUAiIMU2rKIJPejEYy2xHaKwJdjfOAZ6xpA2CzssvzmOOVPM7uUydWZ+aJtH3j+wt1jgO+Wd330CM8C//XENTqyF/LozuE8rAPAFUMHpLpvBj1pxTIhTvn7UL3UkYXjJpAW2+NvnOHIcOZMmXYEP5JxjGBguLP334u7u1bUoKOIhvf0EWS9JuxYfQKJT2L3hbAdIw/oUOow52KcjKi0RdjIyFV3LMHCUs/2PxfE7eBolt/xIEkXh8voldrOJqQrofQT1eP2S4deq8h/RCOCnN7qI9ZlWBlDykIAdq0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B5qpVOigb0cDkf6r1qKgGhuwwThHbl32L1yesu7XaE=;
 b=SQ/9ERXK4DbMav+YVsShN4QdEy/QzNJdJiTwrTIWQV59u+Z+6s5BXFuzjRbbatTpFwHfRcIHZKHSBiR+voM59w64LbklKteiDTnVinKNNDibrirNulUWEKGkgvLDDmgtiOV3Xos1kBksFBrjHH6VNeXfFrqziQVCNGSelXtGDpHKb2kebhnrVoIDM5jjYpgxU8HaZlS3XK4XwdAh0u11Cg34IZSUc7KOg+O9FlnLzx4HbbPjOJ7rL3vT3LIU9kVwWoZTkDJaqt5V1Omt9sVUTwVt4x9DKgk4gjD8Qrnchi0WEuPXSccfBRVZM1u+EwcGGt5MWGujcDGqiWV3aFLnHw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV8PR02MB9998.namprd02.prod.outlook.com (2603:10b6:408:184::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 15:39:03 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 15:39:03 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 2/3] drivers/hv: introduce vmbus_channel_set_cpu()
Thread-Topic: [PATCH v5 2/3] drivers/hv: introduce vmbus_channel_set_cpu()
Thread-Index: AQHbaR8X0ludLP3r9Ualt59ELKhE3bMi9IUw
Date: Wed, 22 Jan 2025 15:39:03 +0000
Message-ID:
 <SN6PR02MB415794B11FB449A2FDF8B18DD4E12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250117203309.192072-1-hamzamahfooz@linux.microsoft.com>
 <20250117203309.192072-2-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20250117203309.192072-2-hamzamahfooz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV8PR02MB9998:EE_
x-ms-office365-filtering-correlation-id: 0492d544-dd5b-40fa-647c-08dd3afae60d
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799006|8062599003|19110799003|8060799006|102099032|440099028|3412199025|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QNMGveiUIC91KDDqxgxz+vXJxt7ud+dZP99yo5eUjH+QykEMMqEOk1E29Ult?=
 =?us-ascii?Q?b4XLhHIkRBsMYnxD1b215yJhzbv6a3VNGBwgNsL3Zcc6h6TMwJIF/WkgVKxp?=
 =?us-ascii?Q?elu6r3yh5XcZXwIQeWBhGfay9MuLTgvcYg7L4yrKfYKB/9JODsfNSnLAa0r7?=
 =?us-ascii?Q?ha8N84ruABfGkO1250Ep3avYNgTQdn8GKSqroAmm8K6hIUKQxyBSjjqNwVAH?=
 =?us-ascii?Q?E8r349wsx1mM65GW8w1vbMx4KK7E7UHdwBOT1LggkmOCc9LIO3moZJgitn60?=
 =?us-ascii?Q?CJfoNMHiYeQ7uSlpHfnlqDv7uKrMLmA6I9Q8gzUYKNA2ZdkvaWIkDLHNvBNd?=
 =?us-ascii?Q?nFXt8Qz8Fa1DWBp0LD3VPwv0YrIC3fkU0rOpCVB8cq6ex3h2XBrYQvseTE2A?=
 =?us-ascii?Q?eJCJQSu70vCvNYcoGT+3SitnW99ZqgFAm2iCB7kq12145pN2rkjxVA56rrtw?=
 =?us-ascii?Q?amjuImqu/DB1RreLj/iGTkPX6PhKxV7EvCE4sczYQtfbMR3rudq2NM8ytOfW?=
 =?us-ascii?Q?KeOYw2+VdjCoadscsZU1N9lRgekH2TFUc2+uP1ACSaqjfYY1CIKp79TVyAZu?=
 =?us-ascii?Q?cyvAcvNbOBrvnjTI7c4C4fkwcyveNLIvDsPRc2GBcqfVMTFwKrftE+0ozHYm?=
 =?us-ascii?Q?s3w0GO+g24LYriyjwOSAT8Ze2FRzaJtzIcPw8bc4Fk1bPHHPv++ED9xOFdf0?=
 =?us-ascii?Q?awH7KW+zcZ1Vzewp5EPCVaCYnqnBp6+0VMQ69QIsgEffYDj80KXzjLRnnDTg?=
 =?us-ascii?Q?O6g6OYgq6bJhS1e7p/FLzp0eqelK8FQTNu0+HS+uqEBztIq9hzHO36+V8pBV?=
 =?us-ascii?Q?HteCrlXjldhXCxDECF0esIeTfQCxEt4pxlIQjvTBYzjxRiKoZ35AwB7RpKZ2?=
 =?us-ascii?Q?4y1Gi5pzRZJrnyUSSiTrzBqnTiMMpdVnawfbA9/eSO0jOSEsx59nz8iHxbko?=
 =?us-ascii?Q?5ZxMBtjKkF7BCjcsz8NdD7r8D3ZO5ZO98VG9zE/kuleQXFk3uTeHEXwLny2Y?=
 =?us-ascii?Q?goO8klB9SUhPWkIeBjfY41+fJNBazR0EVi2NeDMhi1sb9hqt2TjVSpCqh6mK?=
 =?us-ascii?Q?emd0KNIIpLtKrEslJp+bVIOce6PJ8w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Xc0kVM3mwUXCXDO/ZmEdXDKtFKGhoyT/LyTfOcfef4RhnfsQdrrpvtZ6YpVY?=
 =?us-ascii?Q?w1mUuG6VSwCVIo8Yd9O/7QyzdDhI5dD18llEDgFes05Ci56hxXuFolZa4qKp?=
 =?us-ascii?Q?2dPfMev2wDIiuMlh4kpkYAjb/Dp9Fzi41vCuUdSkj6sHue5tsgMqSsEWtO1u?=
 =?us-ascii?Q?GmfW4sxP9rBS50Ko2sM2q1qmZBh226KMbNjt7mIInCPRz8KNET/palp1cLvI?=
 =?us-ascii?Q?T6Vw+1hQCs+wN+dHH1ltlrlq0pIISWtUA9X5g0cuRQBFOqQ2NCL96BEexUWo?=
 =?us-ascii?Q?Gb3QsUp/0WJItodsy4odJnfXjt4QfTyFB7ChX3LBhVR9drn2Pm5YwjfILjR0?=
 =?us-ascii?Q?T5fZiNn6jcNbwmQyKz9fHfmPEwRnL96/Af+kFi27L6996vHUFYJV6K7flJ6s?=
 =?us-ascii?Q?/XyjinI1EF/+nTACOdko8WrdRpFnOsPhQTW6un1Ame+NFfSXoQAt1vx8z7eX?=
 =?us-ascii?Q?u3vm3380NDJhbLpoLKUBd7xtUWkxXxY7akSh5Suwb/GE6yXsTVLgvpEzjfP+?=
 =?us-ascii?Q?YB27nN0GZ25Q0Az83NWrtdT9wfSGgHTklktEMZ3G5kikyTK6apbrq/gylFoT?=
 =?us-ascii?Q?kj3oE0EVmeYOgdz6+CKdqggQMllRoobkHAeZX0u2Tsuewrc0hyecKbVSvJIx?=
 =?us-ascii?Q?wVPnshaONVpFVQQfNxJcI2v6fFgm6AWMkbESNbycip+Z6xNmy5JvE0wb7TaN?=
 =?us-ascii?Q?xvQVT8AlAVbfObbmLuXgzH838kTuP4unleky5+1qxYbyH3mATGRfLHf68z8r?=
 =?us-ascii?Q?cuof9o6xMJD0R5sgA2c3/ogYmEtnI/YoWgat7T4jlzSf6Ep2xzKpyXKChmbK?=
 =?us-ascii?Q?UeVh+39Uv1uGbFNYViNfs6ZXGYQG0epp6X+ius7rPXGzqXhs+GvGItZbH1eY?=
 =?us-ascii?Q?4JxHLTryV1kVNYWEA1erBgU3/SiS1z9Uzlj0hOJA9z2hW7NrDweYZ288dSsI?=
 =?us-ascii?Q?CNuwM5c1uXScAY1lW5ZNzYYbStovtqmIl+b6XHRzXDd3tbjzcTuVNZE9YhoP?=
 =?us-ascii?Q?HcXTwXZbqtWNDmwnMY3cbeJoG1Wf7HTCln6O2FkUMLdhcdNYOf78yIpSxqX5?=
 =?us-ascii?Q?qLrLf8CbcDD5MUjgjD4TBZooLA24XAbt3efxjbrn5SnzQiKiGFGtbnYKpZV8?=
 =?us-ascii?Q?wG2mSj9XoGaJ3wQ+2NA6mHje/ue98E2ASzQZcc8Ee9qd0HOu+wchu/4CiBS2?=
 =?us-ascii?Q?aH6XlKQBZ9xse3/875om74feJT/T+3G0rvtI8xf3Zenx6WmQ+i4R4Lugf5Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0492d544-dd5b-40fa-647c-08dd3afae60d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 15:39:03.1937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB9998

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, Januar=
y 17, 2025 12:33 PM
>=20
> The core functionality in target_cpu_store() is also needed in a
> subsequent patch for automatically changing the CPU when taking
> a CPU offline. As such, factor out the body of target_cpu_store()
> into new function vmbus_channel_set_cpu() that can also be used
> elsewhere.
>=20
> No functional change is intended.
>=20
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Michael Kelley <mhklinux@outlook.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
> v2: separate vmbus_channel_set_cpu() changes from
>     cpu offlining changes.
>=20
> v3: address comments from Michael.
>=20
> v5: return count if ret is 0.
> ---
>  drivers/hv/vmbus_drv.c | 52 +++++++++++++++++++++++++-----------------
>  include/linux/hyperv.h |  1 +
>  2 files changed, 32 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 2892b8da20a5..036be0f6d62d 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1611,16 +1611,16 @@ static ssize_t target_cpu_show(struct vmbus_chann=
el *channel, char *buf)
>  {
>  	return sprintf(buf, "%u\n", channel->target_cpu);
>  }
> -static ssize_t target_cpu_store(struct vmbus_channel *channel,
> -				const char *buf, size_t count)
> +
> +int vmbus_channel_set_cpu(struct vmbus_channel *channel, u32 target_cpu)
>  {
> -	u32 target_cpu, origin_cpu;
> -	ssize_t ret =3D count;
> +	u32 origin_cpu;
> +	int ret =3D 0;
>=20
> -	if (vmbus_proto_version < VERSION_WIN10_V4_1)
> -		return -EIO;
> +	lockdep_assert_cpus_held();
> +	lockdep_assert_held(&vmbus_connection.channel_mutex);
>=20
> -	if (sscanf(buf, "%uu", &target_cpu) !=3D 1)
> +	if (vmbus_proto_version < VERSION_WIN10_V4_1)
>  		return -EIO;
>=20
>  	/* Validate target_cpu for the cpumask_test_cpu() operation below. */
> @@ -1630,22 +1630,17 @@ static ssize_t target_cpu_store(struct vmbus_chan=
nel *channel,
>  	if (!cpumask_test_cpu(target_cpu, housekeeping_cpumask(HK_TYPE_MANAGED_=
IRQ)))
>  		return -EINVAL;
>=20
> -	/* No CPUs should come up or down during this. */
> -	cpus_read_lock();
> -
> -	if (!cpu_online(target_cpu)) {
> -		cpus_read_unlock();
> +	if (!cpu_online(target_cpu))
>  		return -EINVAL;
> -	}
>=20
>  	/*
> -	 * Synchronizes target_cpu_store() and channel closure:
> +	 * Synchronizes vmbus_channel_set_cpu() and channel closure:
>  	 *
>  	 * { Initially: state =3D CHANNEL_OPENED }
>  	 *
>  	 * CPU1				CPU2
>  	 *
> -	 * [target_cpu_store()]		[vmbus_disconnect_ring()]
> +	 * [vmbus_channel_set_cpu()]	[vmbus_disconnect_ring()]
>  	 *
>  	 * LOCK channel_mutex		LOCK channel_mutex
>  	 * LOAD r1 =3D state		LOAD r2 =3D state
> @@ -1660,7 +1655,6 @@ static ssize_t target_cpu_store(struct vmbus_channe=
l *channel,
>  	 * Note.  The host processes the channel messages "sequentially", in
>  	 * the order in which they are received on a per-partition basis.
>  	 */
> -	mutex_lock(&vmbus_connection.channel_mutex);
>=20
>  	/*
>  	 * Hyper-V will ignore MODIFYCHANNEL messages for "non-open" channels;
> @@ -1668,17 +1662,17 @@ static ssize_t target_cpu_store(struct vmbus_chan=
nel *channel,
>  	 */
>  	if (channel->state !=3D CHANNEL_OPENED_STATE) {
>  		ret =3D -EIO;
> -		goto cpu_store_unlock;
> +		goto end;
>  	}
>=20
>  	origin_cpu =3D channel->target_cpu;
>  	if (target_cpu =3D=3D origin_cpu)
> -		goto cpu_store_unlock;
> +		goto end;
>=20
>  	if (vmbus_send_modifychannel(channel,
>  				     hv_cpu_number_to_vp_number(target_cpu))) {
>  		ret =3D -EIO;
> -		goto cpu_store_unlock;
> +		goto end;
>  	}
>=20
>  	/*
> @@ -1708,10 +1702,26 @@ static ssize_t target_cpu_store(struct vmbus_chan=
nel *channel,
>  				origin_cpu, target_cpu);
>  	}
>=20
> -cpu_store_unlock:
> +end:
> +	return ret;
> +}
> +
> +static ssize_t target_cpu_store(struct vmbus_channel *channel,
> +				const char *buf, size_t count)
> +{
> +	u32 target_cpu;
> +	ssize_t ret;
> +
> +	if (sscanf(buf, "%uu", &target_cpu) !=3D 1)
> +		return -EIO;
> +
> +	cpus_read_lock();
> +	mutex_lock(&vmbus_connection.channel_mutex);
> +	ret =3D vmbus_channel_set_cpu(channel, target_cpu);
>  	mutex_unlock(&vmbus_connection.channel_mutex);
>  	cpus_read_unlock();
> -	return ret;
> +
> +	return ret ?: count;
>  }
>  static VMBUS_CHAN_ATTR(cpu, 0644, target_cpu_show, target_cpu_store);
>=20
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 02a226bcf0ed..25e9e982f1b0 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1670,6 +1670,7 @@ int vmbus_send_tl_connect_request(const guid_t
> *shv_guest_servie_id,
>  				  const guid_t *shv_host_servie_id);
>  int vmbus_send_modifychannel(struct vmbus_channel *channel, u32 target_v=
p);
>  void vmbus_set_event(struct vmbus_channel *channel);
> +int vmbus_channel_set_cpu(struct vmbus_channel *channel, u32 target_cpu)=
;
>=20
>  /* Get the start of the ring buffer. */
>  static inline void *
> --
> 2.47.1

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>

