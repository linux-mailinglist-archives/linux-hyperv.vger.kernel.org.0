Return-Path: <linux-hyperv+bounces-3707-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07922A14889
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 04:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538E0188CCED
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 03:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8950225A646;
	Fri, 17 Jan 2025 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gCaGOuT3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2052.outbound.protection.outlook.com [40.92.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C2D25A620;
	Fri, 17 Jan 2025 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737085177; cv=fail; b=I6+Y3fJ3yFgwpyb17fivmMnFa4/lNT2CWh+dsnHUk/eDCQekBSu9kxWxoL09XTg1JYavsyqDFLzBUka3iRiP5hjxF0tUsVBRM6JT4k46M47ROix2XrdNuUk+gbYzh0guJT2Hly6vPpODKpcpBmFpMnAxewA4n2FJW90EgNuQMVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737085177; c=relaxed/simple;
	bh=Gt1H7Th62C8u7doPtxDqVNkoFdrO7c0gzkuJQRDcUQM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M2c8kYzIMGt/grvbawfVkn2hc6FfuRdVoFLcRbbINB3aVSrRf1yYzxG0ilsy68OvXAxpTu3hU3rsvL1zlV6XD+1DA47s/EooDhPrrcqUyrEk89j8v5T6ovhgPusrgA3je7075umIBdNLb8/I5ZK2UYgx20Gj7wiU95bLC3GCWng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gCaGOuT3; arc=fail smtp.client-ip=40.92.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYTit9ia+DOLz7L0BpfRmLS1a2cXOFaogjSacBY1uNeb/S40gLT6QBviY9pg4Ejp1gp1O6oYEeN8GV84mA2paANJFaOV7XYUAV8V6/VZsDrQLCxslXUhgwn5nad4yqXStzG6RgT0GilxwftMKhySO7sncpBSV6k+EuTuVQGfLOQAMbILOwJeZ3LGes8NzQ/e4oxiM5pcGtAAXhzNRfC3OmlBUOSJJ0+A3UBRbzXcnzqiRw1Wqepp1SfmllcijHGPAKihuG88RhAfM8aDY65if4hANA7V4jN0qlH9rDDiDGrWMKTLfPtJKb/lyGB22FDZTEuids/3JknUJwtw9zVtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sslropy3lDfvw9lh5TAuhbW9AhmXssUun+m1FILdbS8=;
 b=zSs1jnGb2oFzyS/AIBihb5NcA3Xd4YsAK189F87Xt161EmVAfYAv3Nvl+87tBpGTnFYh2QRE8S58lT9E/VgCKZOz1TWeih9T47cb2L1TiNWd4OFKyukPBnQnqrI8cMXVd8t9s7exlnvGhyiYARt96u/XJvKbumLdHl+jXQ7ajwNDBxwnn4tg5ho7DMPRhgZthXe+xEm0aUcFv9x7QLRwmsPHOQ/8y7bQXtCuvbOa0C+S5zVGrUjcDHQSmxkybvoKym98jBTBoB6Fprd+y0hceTOXW+Psl8AGOgdH6rbH9vgT8xJs1+v9fMc+A/OR8jGh26Dw1bF3qhz5jVdaU/roFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sslropy3lDfvw9lh5TAuhbW9AhmXssUun+m1FILdbS8=;
 b=gCaGOuT3yQ6PMZND02mDO3pKfijOrvpvggvt86QkZn31ilX14sF975gIagbg/KuT5yisRB43XRI7yxM2O7vgH4MpE6dC1iUH+SUIH25CUmBTatl49LBJYg9sm6BY2YGRDd6ExuLQ1bgqLqsEFkPt3zpL2PNSK5Tx1CAlELtROGMYA8y7yXEisMoTX+AHjlxLCg4Rj/s1uk9eNbOkbQeq0+52V6GBovC025tXD3E4ue1qwZUgPIFGsirSYKA8mKCm6zlZx23uCokZtIjLtK/56aTC9EGzfoLVkV2ORnpexTUF+6G5cECLBeEM4mh6LFa6iZrCGEeWPikS5HCarREPkg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN6PR02MB10749.namprd02.prod.outlook.com (2603:10b6:208:501::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 03:39:33 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 03:39:33 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/2] drivers/hv: introduce vmbus_channel_set_cpu()
Thread-Topic: [PATCH v5 1/2] drivers/hv: introduce vmbus_channel_set_cpu()
Thread-Index: AQHbaGuA6KyFjefvqUirz8dzPxCfiLMaFiqg
Date: Fri, 17 Jan 2025 03:39:32 +0000
Message-ID:
 <SN6PR02MB415716122746EF3CF667C4C6D41B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250116230714.305387-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20250116230714.305387-1-hamzamahfooz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN6PR02MB10749:EE_
x-ms-office365-filtering-correlation-id: 9fdd7383-c850-40aa-ca0e-08dd36a88e81
x-ms-exchange-slblob-mailprops:
 ScCmN3RHayFXX0mVJp9wZC4LLIW1QoQ+lldg5cP8rAWXW877MKNLLGRrfHzrPAmY+FASgUEz53soPNmkVDDcbcrZxMHHr6GrsKlGKrHCKZzr3w+brM8hsKd6rW87keh+8c1GtYR+w7YljhANQja+nFddg2Hykfu5v2Bg/uLdRzsFnAEzqrIHv/VlPxfwVbPC1nh6oEk+8Qyv8PymOuk0bJtqoYlUKUkfp3ty4IV9mOHSGGUzKIGAucfukzftdh55JF0R5MThBLULQIsBguloOk9DWqzzWHIN94rxuFlfQXF5SNwYFfITpfBS8ZBvDaykPSEDo7n/k5alsJKxVracEEcpBxzU9RJ3vcIbJbkDXlu0NcyXTvMoNKiXLxm7aaM+YgHuW9RDsmKk1Sa4wDXXFTVNE2tOSIXtUH5Ell01+N2CV65ydyLfE7PhgJPyjWnfrWJF6+aAWkXxy2j4JyOPXCMOWdKrCljpT+P4HxsTQG0sKlwWYjBNGy4+TmqPCBS882jKvVZ9upxakqsn/paRx/0EcMhUoLwFCQGhnjw721HfSNEbUQJyiXP2KkhWFNoZHAPdKhXPkkLXC/iKYYPl5gcjjLlYwDr0zGC5c+A4qWSLeLEoEzAnwnT6AQNFxrnTXsm+R4wZGAseLCCYU8JETIxOZ/8udGZWdXdATUawUwOM5KFg6bPCB6rMnC4hTT//1QtAfMgTAeXCc0Qd8XH5LjvXRr8e5f1Lk3g0gqU3xoU=
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|15080799006|461199028|8062599003|3412199025|440099028|102099032|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WVpdMrkrPHZZSYviVQgP5MzKdyHcOloQV/uFR/jiTlL4clPpIOCgsOmluA5w?=
 =?us-ascii?Q?zUCTblNGAkj9DZCrEtHqWYOyvXLywT6LkhR/AfFmqNnOzHium8689GaDZM4T?=
 =?us-ascii?Q?+oEy9o5LrMKo/hn6AeYG2A7P0F5Y0aokcqVjFyR+FAHTZ+pwZplX5/FDDA77?=
 =?us-ascii?Q?3VUbvBxHwdTpyKFJBKoWBkG1rIH5oY7XUqcvwoD9WVKMO6WFDEY8QAv47ywD?=
 =?us-ascii?Q?ANF1CqBVyGdJoVFeUbLbyTEhpNomtzMF4jq9l0VtiXuSCu6sb276rC6Bwe+3?=
 =?us-ascii?Q?om1Izam7F9Pjfd4yNpIL3p3h8Rk6rxqhAjAFK+8yYfh/Mp14eKUD70mLbcgc?=
 =?us-ascii?Q?VewZRI0agOpB+55y2s86Mdnx6J9GYqI6ypnjbM1BzcgbtOk200gp8ADwrZsB?=
 =?us-ascii?Q?sbVj20X71tgQfewF8pTG553PDtsd4wCeIAbOYbSNzuht5GFaQ2A6YXNs3POz?=
 =?us-ascii?Q?PmoTrvmwbLJkie3LRY4ic4CLroM7uRhF62XxtpXGiV1Qfx0C0qmnYj7dJsmG?=
 =?us-ascii?Q?R1t+KjpiWwH3bAIlCshvnfJXKq3jZnwkR6GdsQ4allJwDY35bSdijdIrv0ky?=
 =?us-ascii?Q?sM0YQahf+Hl9IqcyQamy0b9KHrGG9kh/nh4nFNotLBshIkGwX26P1lafXwu1?=
 =?us-ascii?Q?DWrsOjA1mhRhuk1VR+bVI6frklQLGPLg2MSgE3X8eCBuRb6dqGj/f5BrMN4L?=
 =?us-ascii?Q?lsxGw0jNAUlVWv1cGOm+GauQJ27xwLBQo4/o3xXU9yhDhg3vi+kZWee1wdVb?=
 =?us-ascii?Q?5it8nA3QGw37C80Q6Hi3nIRCZIaj7h/vUZw0iaYzAjS6pXERIlhrV4VPZFqM?=
 =?us-ascii?Q?sWDZF+JLQQn6l0BBRRbwj89wCIxEjpVvEfDE695PgG1AYgS+wBQJ6e0rBp+9?=
 =?us-ascii?Q?jBUGrAhJUyu94WlMhZgksE90OUibTur59jq6abWSPa7kwRYq+Pja4SvObW7I?=
 =?us-ascii?Q?VHAKg45KzNl9o5YZSxmFEfF+aWpf9pWJTBw/68jRk/kPZwMAbVYDxYoXHjcz?=
 =?us-ascii?Q?pGNczGAiZdRURzUFkGBwNLWoMno5aVwhbsSNDrwsOU0UILDQkiuseRN0NUau?=
 =?us-ascii?Q?ap7YbeaXrLDePlZclh6ZLhK+qbw9SA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YxjSFrxPnmWRGOcTKMhRW1G4zQ2HlNF5RKsLnrc02U6vj1x1o4xTDZTGhSPq?=
 =?us-ascii?Q?s1QJJVUUSfNzsiIoe+zy2FX7uSXgBAbo6EHKxMcWO0oprbd5I10uBNc2eZ5e?=
 =?us-ascii?Q?Xs04BZPQEEl5X3x/z+ChM27ZZ0OAWU1OvXZUsF2TqNLMCf6FskjmlKiPzdxv?=
 =?us-ascii?Q?6oIlJYxhEKY0oVFAvJ6XJrCkYh5q9xuWPrPBp3/wcWiWrOfeD/MXr4yquww1?=
 =?us-ascii?Q?uRLStMSKgcRIQ6UlfeaP29NmKaszI5sKcO4E/Mc8oQPa7rl2+wBTGdB03+P0?=
 =?us-ascii?Q?m8L7953ptwZLlueZEbu5FzFY81Y166P1/QPad+ie9h6p9U/zjoXTD7qi9vFU?=
 =?us-ascii?Q?IZ3fQVw5eGpxAqYAmmVahQYs1g/9QlWIP2ZlCwROyaKvo6hHvdRxjh7WnWRk?=
 =?us-ascii?Q?LHz6hqh7i9zIpsSkYa9Sqt1kY2WkVDMUB7vbdmxxSQOJ82eDFcEAR5nuDUlX?=
 =?us-ascii?Q?SGdTLbXeBavUuktXHgJ+NSS6+gOuqhnXfeodIzWjlrxClw8yJnqYB0azP//u?=
 =?us-ascii?Q?KvIT4fJ1I+w7RnfeI0kLYLYlam8OlMEBhIqjJdeOG2NqIKdMhvYzwH4ZOOMi?=
 =?us-ascii?Q?XnmZxsvtJX+UGIcx8Dy8jLoTz+MIyRmvST51VeLsj1kQSMM6ogabYLzYoqcv?=
 =?us-ascii?Q?KggFW5TlAyI7g0jx2oRXNFTCBz7NqCV2l4UNL29z+Ze+cOoLoV4pKVggdQQT?=
 =?us-ascii?Q?SFFHmivmif0oBHogjQY6TxSyWeZt2O1rqXwoUjgC9W8AAgu7cI1CaozK1ZJt?=
 =?us-ascii?Q?imCfOaWo9wdTvITj8U3udx+k4qykhN+QoMbA6O1jTefvOgPM9FtiJeXab92f?=
 =?us-ascii?Q?/vMmJUFsUbiAIh3sBFuhn/aMUvnYTcpjXBp6eYK+gmb6w7lfIUFe/Sp0J+cU?=
 =?us-ascii?Q?EEHOeBoSJ5DogLEQpB7N5Q5j3phn1aKtli1uSg9jI0ewmPewFhMqS3uZq7ml?=
 =?us-ascii?Q?g3XRdO9abdiTjj0cnK7Kq68YEZE/OTQFZJpGYTWh3m1csAiyxoweKfRjTyDK?=
 =?us-ascii?Q?GeZfc9b+5vp9nPdp1IH+XkW2tZRL9sg+pvMnRW5ylANrKOupGs8CVupSjww/?=
 =?us-ascii?Q?bQo1PU6BVW4of0NUz9Bff7FWVXQn0CAFlaGtzvSWMZFMUbMtCbz+9EwLyNuZ?=
 =?us-ascii?Q?uT1D4BJYsap+bt1XTa7Dg8WNYHrSr9/rA++pW1w0HOddXa+l2hQaYaYJ5GZV?=
 =?us-ascii?Q?GZRnxojyUE9IdyUUW7DTTR1Hq9ow8J/NYZP2WC3o+RyetMJlN4ifxh78+SI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdd7383-c850-40aa-ca0e-08dd36a88e81
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 03:39:32.7388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR02MB10749

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Thursday, Janu=
ary 16, 2025 3:07 PM
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
> ---
>  drivers/hv/vmbus_drv.c | 50 +++++++++++++++++++++++++-----------------
>  include/linux/hyperv.h |  1 +
>  2 files changed, 31 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 2892b8da20a5..0ca0e85e6edd 100644
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

With the previous bugs fixed, I applied both patches in this series
and did a test build. Unfortunately, lockdep_assert_cpus_held() is
not exported, and the build fails if CONFIG_HYPERV=3Dm.=20

cpus_read_lock(), cpus_read_unlock(), and cpus_read_trylock() are
exported, but lockdep_assert_cpus_held() is not. I don't know why
they are inconsistent in that regard. You'll need to drop the use of
lockdep_assert_cpus_held() here and in hv_pick_new_cpu(), or
add a patch to export lockdep_assert_cpus_held(), assuming it's
valid to do so.

With any Hyper-V related changes, it's necessary to build and
test with CONFIG_HYPERV=3Dm to catch problems like this.

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
> @@ -1708,9 +1702,25 @@ static ssize_t target_cpu_store(struct vmbus_chann=
el *channel,
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
> +	ssize_t ret =3D count;
> +	u32 target_cpu;
> +
> +	if (sscanf(buf, "%uu", &target_cpu) !=3D 1)
> +		return -EIO;
> +
> +	cpus_read_lock();
> +	mutex_lock(&vmbus_connection.channel_mutex);
> +	ret =3D vmbus_channel_set_cpu(channel, target_cpu);

There's a problem here that I didn't previously see. Like all other
functions for setting a sysfs attribute, this function should return
the number of bytes processed, or a negative errno value. That's
why "ret" is initialized to "count". But vmbus_channel_set_cpu()
sets "ret" to zero if it succeeds, and the wrong value will be
returned. The original code correctly returned "count".

This problem would have been evident with a simple test of
writing to /sys/bus/vmbus/devices/<guid>/channels/<nn>/cpu.

Michael

>  	mutex_unlock(&vmbus_connection.channel_mutex);
>  	cpus_read_unlock();
> +
>  	return ret;
>  }
>  static VMBUS_CHAN_ATTR(cpu, 0644, target_cpu_show, target_cpu_store);
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


