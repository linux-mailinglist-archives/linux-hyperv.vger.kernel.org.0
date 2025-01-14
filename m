Return-Path: <linux-hyperv+bounces-3677-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ADCA0FEE3
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jan 2025 03:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EABDB166778
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jan 2025 02:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690C9230998;
	Tue, 14 Jan 2025 02:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="F5QsH9yO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010013.outbound.protection.outlook.com [52.103.10.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436D230276;
	Tue, 14 Jan 2025 02:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736822601; cv=fail; b=BHk8kuRzwdEZnJFALlLe0ff3uKaQEAzrEre52su4NPAb107c8lQkHRt7B8JbUkcjfWYeaUhlVSSH+++NZJYTfpnq1F7KCoKcFoyEAN6wk1D0G15LvCSO2t2/JT9lghngZlqZhHhWOFC3NfhR/E8gjn+4BY9o2UdM/rxtAAtSsS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736822601; c=relaxed/simple;
	bh=n/2MfB8r7TrHfoSc/lzXQ267qi0l6wK2xx7UQjF+0Ic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hxgE2/EG9qwnxwhgVAwFSv6TsP/ZKUWgpmt4GnNL7F/VNihxzSIsaWJ10YFNB3T5b98hNVuZvBH/p3qrrAZjxfMrmcVSOFucvmQtTvB/S8u862d9j7waPbGf9mntR/DpJhCBfNsTlz5B6d+dLjAfegHURbz2cLb0Cx9ePwZ9/Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=F5QsH9yO; arc=fail smtp.client-ip=52.103.10.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psv5i4ITB84um0PkQAj1/E29NU2ZbThgQjtQlDAN6EoR453J3HfTHWWuJWPmSHjg6O0qPZRX0dH33Bb6lWR3PcmqWRWTPWb3AW4vxFXs+t67+U+IT9bh8rb1/qRtjyNdPJBLYEaj+XmnJw9ydjsp3cMOFr3iTD99yazLJLHaMSnoFu5UNWSECKFeSFGN1XIuX7uVAg+0eb8bQMPi/1+/JuarO3ruVwEEwkwBFj1Vc+JyWaNAENTtOSWGwiCLM5sCA66zvQQs1kzvpnbsuimzmpstoBcs4oqoaPSeixipZsfwfyT/e9YzpgwWG1EwEfApE96TgTKqSguvg1CngzxUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYRZM2BS1kqkhRgWK3bYqy3v4jo4VO/GhvOjHqxcIOE=;
 b=mqaiyRWNfpZppnNQ/5PKgyJ96BmiDnoj3Q3/Fl767zMe9DhX4E8J8I8HOQHrddndCjFqfVWsITqWc3cmYEU2qggnXURgrhWteXYQEWdxjfrgfxQSZaYa4Qf4fIGZ4LMbwdisCj2e1TISj7dmNAvWEnvU5nPr0m18fR3qxpgZwd+Anuf2NBcAQXKELcu6wsOx8gPWRsCP6bprJCbck1kV9Y0HwxEdEfvqi5QDtdTH3TkRcyACRLE4na15m4PLCiELpfExaTzYi1uDbCfpk+9LXahlkn/Pj83XlplsBf+cPJmQMzsSQ/Ss2a3NMv/V4vaQOrq6+wS89XSA2EKvNeyJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYRZM2BS1kqkhRgWK3bYqy3v4jo4VO/GhvOjHqxcIOE=;
 b=F5QsH9yOXf9fW/ULwh8uCEEaignLanUYt+EKuYISH73ZxPPMEKUbHc5xLGmCmv3Kxb5jO6VjtGicoentJ2XbaBjxOCU4kU8/ktB7CSGZAwkcfXpNMsUFJvnDKOeutaQw5AI5GhIp+jz6BKqBoej4YVRSBlL0jFWy/xFOiY2G84Y2IaevozYvpZIZ6nGSNOo6fwJ281VbgR9LHKH5sy9/HtXnhgM+IpZgS7Fz/WC7vN4Skgg0APEU9Y9qiE/M0R1kdpfNDMzmZrgg0sAqvnawD8mLkizDFL/JdYv2KRyt64UjJ4irMHYyGVhjJAVVrsO0Zdmfjo9Y0tOLxOl42NyonA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB10464.namprd02.prod.outlook.com (2603:10b6:610:206::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 02:43:17 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 02:43:17 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] drivers/hv: introduce vmbus_channel_set_cpu()
Thread-Topic: [PATCH v2 1/2] drivers/hv: introduce vmbus_channel_set_cpu()
Thread-Index: AQHbY6sUPNSmI7XBvk688/OcQsJpj7MVVGGw
Date: Tue, 14 Jan 2025 02:43:17 +0000
Message-ID:
 <SN6PR02MB4157C306208A6CF5478ED584D4182@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250110215951.175514-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20250110215951.175514-1-hamzamahfooz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB10464:EE_
x-ms-office365-filtering-correlation-id: 3ad4784d-f39b-453c-4f2f-08dd3445331e
x-ms-exchange-slblob-mailprops:
 ScCmN3RHayFXX0mVJp9wZC4LLIW1QoQ+lldg5cP8rAWcxN6M3w1HmjpALsSbPUuAqFKLC2jG2/p0IDX6yxkHNpQOAtnxEPW9YopaDdaTPt5OfiSeSBccZi2JPjRB1uSUgSA/ZAjp4+l8J3UsUDHzl1j+rEh4SiUvcNiy3UqRu4rfPyGhXHHlU4EzjgNAqhq8p9pEDkqU/F9uSwbhQE83q08JsFAD1OPfOwBIs7OnMFmu0hwi9HgRPTUv7cn6GbHevpqGTyFD78chSbF/5k0tbAJnEckn2i/+sOA3GzaqGhpVrzyztjDpldcFmPFHI5VQassvs04w0Q/b8gas7Vr9WM5N6nWBoJ8OYf1p+80HJE6DrXOMOMs3hUAc72l66cM/bkV72Hi94rW74Ub6DI9qzt6WId5Elz8bTZjiYNHDULPaX7MTfPVbDaePIPjmQnZw++QOSJHxUeuR1CHlc3RlYDZjkkFdT06DaHJY+yUBoB1PBGIVlsGRqRRRWdrT0zweP/zoAwtEd5SDfCsgmaA5oTu5FoU1kmp3huHu8WqVByLNp+snRgBli5fftdKSnH446J0aGgrlixYN0pi1kn/ff/pUSyr/H9BSK0SYrgqctn7omreBRaCXgydwBMaa1lvczcud6FqyQQQHXKN2Ez/Js0IQT+c2zE7C3c8TySUInxbd3eikvV9F5cfFS1CXTVq9HH2ZsULtYZXO8VsN8W8csMa24G0/49eR0PcaCaHS82A=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|15080799006|8060799006|19110799003|461199028|440099028|102099032|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3AOMR9DHPKsTaul6wGtnryNFn2ok87EzDHVFrdo5O0iSWN1DmhqaW6fECOpi?=
 =?us-ascii?Q?cPtIRixrvwzTTIIid0Eh7d1AhN1nh0ozuTZNViwrKCeAWyQB4i+0dCafM1p4?=
 =?us-ascii?Q?AcRP88KWPLrhq0iYV4fw1jWfa6l472qGlVIDxdSFM1v1asppnwICQ81MjXo+?=
 =?us-ascii?Q?XlGMDOMoCDFmH61obNXuPo1ILxxSinStb69JhgV72vidScA6eOr9hW9ievZ1?=
 =?us-ascii?Q?akYixXkFbdGvsJKgD2O2mAHVGKU3jeCcAuk8GEw8TvCIFjwAz40/k2M3iZev?=
 =?us-ascii?Q?Np8KAUlmRwE2gNasMUme6P0ZT5KZ0OrwRP79S+BzeMOKz0CIJz1Eyq7iQaeN?=
 =?us-ascii?Q?Bb4Uu7D1IKguHs1+oqtestvZ5EuylPH26HiCmictreXis56kh3BHgRc+3M2E?=
 =?us-ascii?Q?UoMfkKtNyDog2ZWSOxkriDPG8eDSdmBnhrP7KZRjT+UNoCt2Qh8GLqWaK3pR?=
 =?us-ascii?Q?5m11wpgZ3CwWp8AclO2ZKcmD5gCH7XaN4hW77RBwJgwlV9YQ8e6FtW84x3fa?=
 =?us-ascii?Q?ROwlNmdNqh+gvZQVbqPu2S0uGorJj+VVc5brKwQ3UyyVC7KpWvJxlLzETqlN?=
 =?us-ascii?Q?ycS0pCqZlsqQCUTB25F9TvdmAhJYeK9lWRQqSm7S69uSxjOOT4VxsifSMJjD?=
 =?us-ascii?Q?reyiaAwGXQP3LI4bpsATSebW5lQIpsYjM5QGl1ncP00WdXSUAoIQ3ui+EQb7?=
 =?us-ascii?Q?5f2j7TZFxnG/g7E4vsyN/7VkIsKVM/CF/0srrx/2Exs20gzM9dFk6GnWyO3s?=
 =?us-ascii?Q?VTtr3esW2esyPFPN//N90WtcCG/fi+nvNmVGGUHnUTubHl37vHT+MqAvgWYe?=
 =?us-ascii?Q?uFe+srziqokcNggu9EoFsLLkvEyVwUto7ky807MVnTJSgdJagiCbmzPD63oE?=
 =?us-ascii?Q?65nX9eGI4pcMpYuPq9BW1Ie8JlVnC+KJLhLhBK4rR4kMqq/5Dk5YZN3I1+zR?=
 =?us-ascii?Q?Y/adkfvjoPUUp7wgTZG8jutzhb+nLlQ79Wk/yrr5J/Ob7egoeyK1cnOuBTby?=
 =?us-ascii?Q?c5xuX2vtEHZYUaVGBK/Up8IzJPm8oVwL0mLtGD1G5d6jlgo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jrEWHHhhwfwcY0bwaNTWgSbtBiu9KvJ+He2aMKut7d1C5beTt4CDodpSGkNO?=
 =?us-ascii?Q?M53sjwlCxwgNyUm9iqoYkxVpiYV/i0F8fEjYDolkjtWpvr53bMWkIrBclYF6?=
 =?us-ascii?Q?OzZFtZJmPO+ZrY3i4fl7ZNzQ8As107Tie27zY4LUE6TeDqmllkT7AHLMAZu9?=
 =?us-ascii?Q?UufJGDRUFYd5iW1yvRo5L2ekNoymVyHuf5+ubyQQIOP+yx0cQpw2iCsxIyom?=
 =?us-ascii?Q?2Fam7J1h9ZPdM3QaO4nMgRVK43/StI9POch3SthTnDfHBw1XmLr8nnvVIUG5?=
 =?us-ascii?Q?uX98nDpbE/C2eXI6/0ONsLrFrT2pYQ5xPtjffk5GtMngbJL2ocaXAEx9YDHH?=
 =?us-ascii?Q?FrqctXzJDI2ry+NyjcCs/4Xb9LSsmm4o9bdMblTJTKx5BkIglr53Kr2TuE5E?=
 =?us-ascii?Q?qn4l5GGA0McJd098P7Y6K6Vq5xEpGm++zZg/UMhM3wnXUODk+WPxtvp2tftn?=
 =?us-ascii?Q?dYFGTkaQNjep3cdXvc+33pC0QOp6LxoG/eR1iECPSHd96OH3RZdgstgfwn0N?=
 =?us-ascii?Q?9Ff3RANHnS1LKiVqRJT3KtwV9g0zV0OKbSxxDswXKZPN80qLM4Bcw6KwmWLt?=
 =?us-ascii?Q?9wvn/gfcvoqiSFwU8bOnQJU3s7NVfrGf55voCIlCcoY5jq3KRXGPer64EZsD?=
 =?us-ascii?Q?xc04Hj/OKSClCk9dLLpfrKe9CVelf+bge1sDVm+HhsY5tmqAXB9SRrYmhCHG?=
 =?us-ascii?Q?Dba5j+7yOKUNmJ/aCSfENwdPhaXZGNPGU5/WxxLe5RqlS4K2V/Yvc4c9j9dS?=
 =?us-ascii?Q?gFpybsX8Z3DHtptRC0q2cZH0lPL/2wtfWO1B3qQi8qChhD1vxNSQSLeVt65k?=
 =?us-ascii?Q?9bGtknuI+HgMhprCPS6xolPfYWgllAQEj1EQ+V301YorIxXGbUwq3ETjtVAm?=
 =?us-ascii?Q?wek63C6b5p2jNcF9q5KsGpjn/xR7o0pB1DPKq77JeCQcTRgwgeULOPYHwFxS?=
 =?us-ascii?Q?WzuI+cm5AfcDmH8gHDDsKOYGAPTliNf0aU93L8krjYSoBe9baiWKf/a5tBmP?=
 =?us-ascii?Q?3HZCVsL9PmtUCGxJLOSiWmhqNxohzGAzwpZqOzWGvYwvGIRVLxkins1BQsT2?=
 =?us-ascii?Q?1Qy/hh0zTygwmK/PSdEhegoNg9LkUtMxDW0u44HugavejnLZ1fbhk5vCOIOT?=
 =?us-ascii?Q?F3j9kzo0eVqkq/o6XLrd1A8dspQsbv+Ywc2th+27jO6/tR8QZKsNcHtI5q3o?=
 =?us-ascii?Q?+6QCmBRP0+v03vtvBkDrN6EPIk/LJqB/EKJYRFCBrIQcIh8PfL0wyry8XWQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad4784d-f39b-453c-4f2f-08dd3445331e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 02:43:17.1303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10464

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, Januar=
y 10, 2025 2:00 PM
>=20
> I would like to reuse target_cpu_store() within the driver. So, move
> most of it's body into vmbus_channel_set_cpu().

Need a more focused commit message.  Don't use personal pronouns
like "I".  I would suggest something like:

   The core functionality in target_cpu_store() is also needed in a
   subsequent patch for automatically changing the CPU when taking
   a CPU offline. As such, factor out the body of target_cpu_store()
   into new function vmbus_channel_set_cpu() that can also be used
   elsewhere.

   No functional change is intended.

>=20
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
> v2: separate vmbus_channel_set_cpu() changes from
>     cpu offlining changes.
> ---
>  drivers/hv/vmbus_drv.c | 52 +++++++++++++++++++++++++-----------------
>  include/linux/hyperv.h |  1 +
>  2 files changed, 32 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 2892b8da20a5..001e64fb8d43 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1611,16 +1611,16 @@ static ssize_t target_cpu_show(struct vmbus_chann=
el
> *channel, char *buf)
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
> @@ -1708,9 +1702,25 @@ static ssize_t target_cpu_store(struct vmbus_chann=
el *channel,
>  				origin_cpu, target_cpu);
>  	}
>=20
> -cpu_store_unlock:
> -	mutex_unlock(&vmbus_connection.channel_mutex);
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
> +	mutex_lock(&vmbus_connection.channel_mutex);
> +	cpus_read_lock();

These locks are in the wrong order.  Must do cpus_read_lock()
first, then lock the channel_mutex, to be consistent with the
pattern in hv_synic_cleanup(), which is entered with
cpus_read_lock() already held.

Michael

> +	ret =3D vmbus_channel_set_cpu(channel, target_cpu);
>  	cpus_read_unlock();
> +	mutex_unlock(&vmbus_connection.channel_mutex);
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
>=20


