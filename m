Return-Path: <linux-hyperv+bounces-4022-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D8DA40338
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Feb 2025 00:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324FC179F33
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Feb 2025 23:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F3E1FBC99;
	Fri, 21 Feb 2025 23:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mw0Mt0sO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazolkn19013014.outbound.protection.outlook.com [52.103.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C79E1E282D;
	Fri, 21 Feb 2025 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740178875; cv=fail; b=KteyTfFxTczKdZ//qzioLwWJ8gfUQ05cyCVLoyi4uyNsRy1Gf6vnUZ+L6YGwcmfnKg47i7fkSyPbclfyKj+0CMfYpf0oUH9aNK5MM9fCXkCQPrWUL3PP+/JwB74QWUjkmDq4/lpuuLzDgBxKgKsZrpm3LOWhhOn+ZH1kdA0JGeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740178875; c=relaxed/simple;
	bh=dqXPNvMucI2aI7K9oieB+u9oHYUZEIhm9jHSlhEm/oI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jzmn8vYS9OGOp2SAsdwesrjHiUSPN2ljpWYpXV8ckQ+V3ANSQbHzxYyfzY3IVcZAecaDh/40tnbwe7crSWGnqrxzdyq2FA5HGFFqShXkjbHk6LaIh4+yAmgu1bBo+YU2aQKJ34eC2VAus1jzwwREb7JKNsOVMmFNXbIJoK4cYB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mw0Mt0sO; arc=fail smtp.client-ip=52.103.2.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdvKvlYefPcvS0xNlGpqly2ZHbmaL/sgJFIcTL8thl9QAXIV9GnTKlHWMsd/KJk44X6TslbO1issdQscoFGvvTI8WjiQT1zGHs/PMuAkrIPd5g40DKtmCLeT7fZzggyaj+5NThrE3ibUgHJHtGdDzTUpjDigDuAwWWph8JHd8L3nWyt53floAZ96H2L39cyOBqelAz1PtMl89kBiAB8BQGHhi/cUtZgaI0gggBojim+GGEjgV+XQLm7rz3iCKN0ngmdeTkBLsLyqoIzSH80HrIxW3nhfOfvH4S/sm2xiM9xyJfOXdL4eaq1YtpcjkdEv402U1cTRqzbmOm7NixBBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQBmHdNUgl3bjX/SLQDgD0kADsX4Y04KQHBHVwlxxlY=;
 b=fq/h2zfMiWw9PjpYv3EPQBdIcL7V8AM6vXOYPfbwOlIXiM8pkfacbOgBsJWvQOUhEzTsjZCAPSrHGAyKFCrfZ8QvXuho3t1W6O3l53yrni1c7n6NTg28ZHfa/Rh6By60N6vglwbjACtpjo84wP0e7COlpupMTPgV4biw0b3DfxO03eB4fr6GWVbEBUFKSP9Um8diI1wLBdHEgxxAjzQp2kCW3DlYBa1jogO6Hm/SHgWAE2g68zouzjo1bvkjSaNQcrn8rPyA0YweZ3CPwPJGT4YK6Fge0BrPpyOwG+BkG7Mou1SMMEyvp5DiybZL0IMU5RM7rQHIE9UQoR0/PCfi/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQBmHdNUgl3bjX/SLQDgD0kADsX4Y04KQHBHVwlxxlY=;
 b=mw0Mt0sO/3fP6GUHYFx6TjqdAUgxmaUfEKFYLBnVRN80iaaUk3JQx0VJDPK4SG80hl1/xBuj2u+sGORazD+4EX5kjkXAtt44staCVUubrRrJOO2Y/NfndiTzf45cTdYnw0phwNORsapc9WI9l0LsDRFwl/tD0CtNF86hzSIT17+6xEvAKGSuxThpCWpDlT80qtXR/Sb1pO+pdteHQgcScrtZogTE35kfA0GnFxhpi5n1tr70Q34y5Yy78s7/NK5oaoWMww34mWt0qiN4L3fMLZ+8c7Wwm3kuP/DEaUaRDwbsfWs8XHaB0UCOsjI6jhzoU3a7VNYV9f0uWKPHc77JRQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS1PR02MB10492.namprd02.prod.outlook.com (2603:10b6:8:215::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 23:01:12 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 23:01:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, Petr Mladek <pmladek@suse.com>, Andrew Morton
	<akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	John Ogness <john.ogness@linutronix.de>, Jani Nikula <jani.nikula@intel.com>,
	Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ryo
 Takakura <takakura@valinux.co.jp>
Subject: RE: [PATCH v2] panic: call panic handlers before
 panic_other_cpus_shutdown()
Thread-Topic: [PATCH v2] panic: call panic handlers before
 panic_other_cpus_shutdown()
Thread-Index: AQHbhKgE7m7J+NObG0GGYUSr+UK83LNSW/ug
Date: Fri, 21 Feb 2025 23:01:09 +0000
Message-ID:
 <SN6PR02MB4157D993CCE04F2D46E2B8A1D4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250221213055.133849-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20250221213055.133849-1-hamzamahfooz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS1PR02MB10492:EE_
x-ms-office365-filtering-correlation-id: 0509d550-f150-4f47-ecdf-08dd52cba181
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|8062599003|461199028|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XoFpTqyxzJvrKjXROAH0Gu37aukkOB8BoS0tqyMO9qV+wttgNbv4c2CCCEAO?=
 =?us-ascii?Q?xZPPRal0GmXi8I30ueHn273RwA1mFC1Qs6JNVBj1PZxV+nIU7iEL9dGTCaTO?=
 =?us-ascii?Q?wWmGuy+v5JpLEymdprGus3ghWZV+B1K5+/fuoxDtHRv5lTitkm7kLbi1QANv?=
 =?us-ascii?Q?xlWYyltpOu9WdE64pYehfloTCv9qrRasO1RI+tcA1M1mvxOKk7C4dAck3d4f?=
 =?us-ascii?Q?oqj48t1ZIALKU1ndwoWs+J52LLDNIgILpid2AcWEheFKxHFhE47yfebrA0XD?=
 =?us-ascii?Q?7lIVIgcsGhW62XLQeq0OElDa4M9KRGfZdo0k6VRxEi8P+zGPNz940WDZczRo?=
 =?us-ascii?Q?Zi5ZdZDXG7i7/7N34tkJZEsNVu//JVs7BfpPeXqz3dhXiqYnnBgElOSYf7DY?=
 =?us-ascii?Q?WiBRfWgkQGRc/nrKyW6MYGROxR2tzSfFatmYmnG8rxSz5NHtXaI8GSt3ZqVg?=
 =?us-ascii?Q?9Bprntlablyb7WSAT4gOU/lFQCQVmne7obFGCHdvM6C1tESak85yltS5S82O?=
 =?us-ascii?Q?CFxjmZmZsfYzUu1cnZRBFPaL4G2B2cReakPEqIB/gwpP1A9DdSQ8ZWod2dM8?=
 =?us-ascii?Q?UvYEfYwOwIBtztuWhkC2Fsl4MpwGS7ZCJTVJdZOmkxcWuuOZfygQyC2uVkGF?=
 =?us-ascii?Q?OmmmcPbzIHc8nDriOlbr9Tmu+mxwK91msGqJI4+L0ozE+mJ8W213woDm0W1W?=
 =?us-ascii?Q?oPIwTnT1lUyAF4wU8l5Dgzrb8/9Vkt7JV2VOJVS1fA7ejnwyBjGWGjmpZwZv?=
 =?us-ascii?Q?EXON21+SfIZ+oHHgoaIUZyzCqxZ2b37/7BiUsLl8GOFJau8z9enJKqodxxH0?=
 =?us-ascii?Q?6ruCRu/OR2oRiQE4vsPzVmjKVGLNq4/HaV2IWlfL8BpwtJxbqCMUu7atWb7f?=
 =?us-ascii?Q?hOsWUFiBzlaNWDgf3jJvQTVd5Oo4KK1xpbChtsav7QctxCKSbUNiCPbAinAp?=
 =?us-ascii?Q?GbvduxAYaJcDU8XLZJLl2jSMf+2sK3Z1wmQ35iHmcyT42ToEY73yEVM1dV0v?=
 =?us-ascii?Q?Ek+r8kvmvALvswQQWd7CbWLM74kPa/9AhaEm9qdEuHzgbCk=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wFaHlrMG471Zq42yfPT9wMz04NMiGaHu4O1Gjd4+UYUuJ3fh8aCnwUAOWi2T?=
 =?us-ascii?Q?BI2VTbr9k3BWhulRmWoesxHKI1ZATNePils/BnRVYFpiVzThsSHURekZ3+SW?=
 =?us-ascii?Q?COYcehXNh7YkkNhPu3TqKczYyDFfs7rB4K2wpSNn3LvzuALeF4gVkp7Edv4E?=
 =?us-ascii?Q?djfpF+LDccBvs46S9pcm3FRHrKU/RaC3yZ8lsPyYewEoxn8A6iiyNY/rJirM?=
 =?us-ascii?Q?Dcwha+IYoxUMsGKUgE6EdW+h2beypB3mTdEQor/AjjXjM5wAxbSWWi1BV1H8?=
 =?us-ascii?Q?i1lzhlBHo9Db0H7fIcI6PmYi3RuQBn7NUEpjA6gpSOLz+4ipjUnKTPSI0x9D?=
 =?us-ascii?Q?kFziFvjj/+o/mC6R9mIjrXAd2iFmdETK/9B/F75SwQYnIEbvORdRL9wcElYv?=
 =?us-ascii?Q?rJrPZAF/+5dkkB/o7xBYcuweOgBJEUWOUkmXQYp+51KA0qw9K5BtS50LrY3v?=
 =?us-ascii?Q?ykXiPGAuN22AL1JmvLXfhGZFKgZNwj5sbYZ+jVnf5FvTLH0qTH2A833Hg/a9?=
 =?us-ascii?Q?2Jje1oLtRoylfe1nNhvc/8PCbKZDLvC7BrRXy8uCNiZCps3aptTlyBvB79Ti?=
 =?us-ascii?Q?I8gWz+qYeNEU5iYwZZj0YzTVd3nAMbOMvderm+It5X/RiHPkACtIBrV2+aSW?=
 =?us-ascii?Q?pQTm9mbJ4MNkJg8xm/5Bpwumap6xCHZhvWZLzyQ7CZc4YwAPgPlYmN2yOGB1?=
 =?us-ascii?Q?X7d9meW0b8YoGgzGztacGEmqEFhsGkkVdL7GmrXLEHFm8VXtfI+QooRCVLYw?=
 =?us-ascii?Q?/fod2j+ppgkSr2POxJN2hnyx8lexXCBue5rGqPlbfQr8aTLQxKTBUYS+keD8?=
 =?us-ascii?Q?2nMclDS01Gpe4Ckwkvfu+NubfrEC2TjhLITh1TowRuzMYtkGXvuoglaLK9bo?=
 =?us-ascii?Q?nUAvEBAB/y71j1pYI03Bz9DpGUZ8EjOI3ai3lT7QUGnjY1qg97k1RZMDIiYJ?=
 =?us-ascii?Q?fnv7IraTSvZRqJdSxNKOQ1FVqGCZv8t5V7gZwo5Dk49ww9qjtS6fMcNbLuPl?=
 =?us-ascii?Q?ACK+qoDryXEasbVMd9Msl5ygmlHJKfy1vrWMeAuQp61eNaAH8LMdwCQcSY0M?=
 =?us-ascii?Q?sBz5tvjJ29FNecuWezM1nruWFo92GY6OQEB6L0Mvt/maKBY5lgaPplfsfgn5?=
 =?us-ascii?Q?Vn8uwgrZzn8hvquHjYxsgTwNuU4DishDxunR50/05gzF1mPXOhc3eE2A+F6M?=
 =?us-ascii?Q?+qIRUpJTvIu1XICM60shSLcKwu5TbAlEE3sPWQgjqkEM7j9OkPuZa48raSo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0509d550-f150-4f47-ecdf-08dd52cba181
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 23:01:09.7686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR02MB10492

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, Februa=
ry 21, 2025 1:31 PM
>=20
> Since, the panic handlers may require certain cpus to be online to panic
> gracefully, we should call them before turning off SMP. Without this
> re-ordering, on Hyper-V hv_panic_vmbus_unload() times out, because the
> vmbus channel is bound to VMBUS_CONNECT_CPU and unless the crashing cpu
> is the same as VMBUS_CONNECT_CPU, VMBUS_CONNECT_CPU will be offlined by
> crash_smp_send_stop() before the vmbus channel can be deconstructed.

Hamza -- what specifically is the problem with the way vmbus_wait_for_unloa=
d()
works today? That code is aware of the problem that the unload response com=
es
only on the VMBUS_CONNECT_CPU, and that cpu may not be able to handle
the interrupt. So the code polls the message page of each CPU to try to get=
 the
unload response message. Is there a scenario where that approach isn't work=
ing?

Note also that Hyper-V itself can take a long time (10's of seconds) to res=
pond
to the unload request. See the comments in vmbus_wait_for_unload() about
flushing the Azure host disk cache. I worked on this code and did the
measurements, so I have some familiarity with the problems. :-)

Michael

>=20
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
> v2: keep printk_legacy_allow_panic_sync() after
>     panic_other_cpus_shutdown().
> ---
>  kernel/panic.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/panic.c b/kernel/panic.c
> index fbc59b3b64d0..433cf651e213 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -372,16 +372,16 @@ void panic(const char *fmt, ...)
>  	if (!_crash_kexec_post_notifiers)
>  		__crash_kexec(NULL);
>=20
> -	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
> -
> -	printk_legacy_allow_panic_sync();
> -
>  	/*
>  	 * Run any panic handlers, including those that might need to
>  	 * add information to the kmsg dump output.
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>=20
> +	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
> +
> +	printk_legacy_allow_panic_sync();
> +
>  	panic_print_sys_info(false);
>=20
>  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> --
> 2.47.1
>=20


