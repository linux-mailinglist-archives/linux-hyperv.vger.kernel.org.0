Return-Path: <linux-hyperv+bounces-1426-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1BB82C3BD
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 17:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ACDC1F22AA7
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 16:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6017E77633;
	Fri, 12 Jan 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HKBqY0TF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2070.outbound.protection.outlook.com [40.92.41.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C884177620;
	Fri, 12 Jan 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSgagJjV04HvxjO76vlAybuAKs4bqATkRgw3Eph9j89nmFSQIGEkZV5G8GBRy/ybvAax+3VzsYdQkcYl5GdrGBxJ4/2nbEbCQ6J9yX1OorUCLCMQCq8a4ro2u6JE5pl8MOBLAeHWZhZsztoEhC4AcxIPlapOfeT/cSdVc+bh52aNuyT9cIBEjXGRtSkPYxk/r7r6oK4A7sgqz7cP5Ii6BOP97ob18eNmFSgbBb6TbPqpKeS2y6TU3j34iHToAmleeak9tN0CkQh3kg7m4rNTDGgy6npxD2AVwWocq2MyDlfQv68V6ihatMk67djBWJQneTbu+gV11KM+h7i+Hf7fTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXL8Sr4jA0Zci68m3RtcVCPJt4ph36iSEIUi5bDwbuI=;
 b=DD4SiC7V/F6mqJaNQD8sD4Bkx3hESPpCVv/EAU5tE4pIJqqbKBJ3GklfOVxCffKqhtSeVGZjeilgwLkPgxfhbI6BCcsCRN/OJc587O62vpJ8HUQfrkqj44WSEttE52WpIS0GviSVQx1AIdYtzm6pGB5cmcSPLowvtTzAdx6Smc6VEjZaLLkIGgaU4RhbmvUAvN3QzQqu5de23spuz7nlGyZYIBzRSOUWUhMvBW2CjgURqz6tfo4IB5KRX5KoG19pVlhF1Rdpgz/nKPrhk8Dyo5HStTV2sxegXCWQhalIup2URe/npxQAuVYWUWyxT2UYKO+cP0wQNA0ZjaiAe5OfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXL8Sr4jA0Zci68m3RtcVCPJt4ph36iSEIUi5bDwbuI=;
 b=HKBqY0TFHymzEsFD6u+HEgHKCS8uEXQV3JhBr4GnpKT0sH1e9g7/TLEjeCrPCzGWgsl/fOwDT/Zq8F+QHupIGvTWIDDrSJpXm4jGSor6fPhvR1gLgRdjsogweluVloSOWb8DLwSqBlnoiLFopVOy6zmTiFUH+MJ8fNHqMSZ6gHLXditNgbYefuPrR7iKU0IwHb/ePNlaus1nedxCBW4UhB3HP8XFjcDkU71rkhQTC391A/LqZDKxEul1oNR4MlUE2rXdlqT9XIzha8yZLK3TJHafmUDAwDiZC1yjay1+tOILbhOJH4FQaH8zJsrBCcBlwCr0nszYYX5HYIzNXbLNjA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8429.namprd02.prod.outlook.com (2603:10b6:806:1f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 16:36:57 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2%4]) with mapi id 15.20.7181.015; Fri, 12 Jan 2024
 16:36:57 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
CC: Yury Norov <yury.norov@gmail.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "leon@kernel.org"
	<leon@kernel.org>, "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "schakrabarti@microsoft.com"
	<schakrabarti@microsoft.com>, "paulros@microsoft.com" <paulros@microsoft.com>
Subject: RE: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs per
 CPUs
Thread-Topic: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs
 per CPUs
Thread-Index: AQHaQuoWNi7Bv1N390Ch4p7DlTYrcLDR1sMggABKpoCAAAdtgIAB++CAgAI7qHA=
Date: Fri, 12 Jan 2024 16:36:56 +0000
Message-ID:
 <SN6PR02MB4157234176238D6C1F35B90BD46F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1704797478-32377-4-git-send-email-schakrabarti@linux.microsoft.com>
 <SN6PR02MB4157CB3CB55A17255AE61BF6D46A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZZ3Wsxq8rHShTUdA@yury-ThinkPad>
 <SN6PR02MB415704D36B82D5793CC4558FD4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240111061319.GC5436@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20240111061319.GC5436@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [VvSeSWuITgYk/xvP78DMF+dsKwkMrysa]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8429:EE_
x-ms-office365-filtering-correlation-id: dd336f3a-36cc-4771-4df0-08dc138cb13e
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUFU4QVyvJMYbyB44ymHfgCnvC76qrtNdsVM/0pTQmDkEAIA75NGth0grn3L5xWqD5Rv/J4Y9mylMK6EL0AUlmNDsdQ0bG3fO4cfQtv4ua/4fXPuJORvPZ26bMAhBGLec/icJmdRWKMfUVslFAsVWgeHq1Mjy8Sme1gCp/9b5Wm0J/+7nSjfmRquIR+RQVxXMGdiFUbCNUg5gWxexLGE2MigiM+QsXmmFKRKPt7FQ1+SNssPTjbihUCK8p14EZ8F9V3S87Sk771JZDnem7eVgdkK6/uoAASxtfCln9uHoE7ExrciOgv5jQMFh3VKqcIbxKDhxWH5aVHpl6sNHYzTwyxZxTVL/wGwtnXxA1cl4mY4iQI8J9e+xoTjTPP1BYtrtwfBsreOrvv7Gn79E5INepAEMX9uNpHEcPBqt0UQOGRoREhavarV1OkyrnkqhiI8B6NgEy27Ww2f4fQco7+OpSKyFnhjonl37JnP+21Sdrfsx5S2Gb2iVOEvQJmnHnpnCfXTPni20jTr7yrCJlGkBe+Tacrji26ysOy1aJA+sH5ECcnzUiB9tTupVnarNYV81qHSnf/eZSDvZcLR71RnUoj8yFEtDBqYhKMujv9nRXftgoqhMjzqIvWWBIlOKLH+R6dgxVHD3MI46/KgAzPqNnmEIdCm5LrlfErsvhq9JWGrBrpFir0d2KfBRd6tvbPGYzKPy2dq3bBbqOultRcl6Y4LXBTBknmqJqz4ivNJhFzqvPV3KAtdD65a846nbUdU28=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 C6+lY0K4YPreXep9ERmP/+Tzbbl2j1d+WsO0DqlBUQtMzatpN5Xvy4IJjebaloM/K3I4mwWcQKThXwZm5QiNwkOEH80iuWUfxPLUtt7j4Smmfb/UEsNR33kwLu4tKNu7zvn2fJUnylhtwBLRDii2cNXicnhS4njqqoI97aWUN8ImltoeZnCcE4mlUaKmlr3yT76zbJTQPnmuVDyM0BWr6FcDcTfUl48zsVojDQ/WXvYrSEHSukeCdMV00+Z0o+pKmvMhbviIujUNqyIIAkeMw55vyiVNyppZqbhKTaRDNW0V7dB9e93/XhP52cs9QvuW4hbylW4V+g3wjM1ZQocAKJPi6E/HQ602w197Ej/VzGp6FxmZhD/bJbcMbZaSfjT1bORpKMnKfARZVJkeOHVDkNXY6PnjsjBm9t1tWMG1mw1szXfhGSSeYISwpRq+biOdExAEyBsMM8rVeURJdFZprKB5I/RULKCillNiZ8SKyzvMobZuWG20MBEECZ+0GBWAIxnjG+pzyxiti5n/WwpVC22c3P0sQ4xgbNZH4NNpk+EiZe2J4aTuUIEBWzk49qHq
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z9vWkSB48jTRN+uChEGF7/OQ5QGd8WUmKsBE9nMitFAQyQxLIlNsTbk649al?=
 =?us-ascii?Q?Bmhge96MwjT1ViY1jp95eaP5mTiN5kuPvvZUX2C4MTs7PwtLt1APVl+gUPQc?=
 =?us-ascii?Q?iWnm9Z0iefVEdJWI0ZTGaCyRtox1xByGJDFVLOYdr3BTRv40aypI4LAPhXRg?=
 =?us-ascii?Q?saiU+xZMkIRKKmRPvvwXyaVV3UX+hLxuOck2/+0tvlZ8aDWfp4W5uEty8JwC?=
 =?us-ascii?Q?UreXzMlPx54alPJhjMF2oQ1EQBFAKylQy+KCoodxVhrBT0NiJ0gPhoIEkxTi?=
 =?us-ascii?Q?/Ny5CpV9yAub9kp1Hx/sGHsbQ+2bGZHgtnFvosT9t7mrCojuB02b60FyYjpd?=
 =?us-ascii?Q?jcO0U1s+S+ij2IkY0T4D/qiSYwVeeGQbt4wnPMs7fWPt58tfhRFGRTW1cF8A?=
 =?us-ascii?Q?kx5zC159AJQcH+M8Eb5Z/bNfTWrq4s7B4mADMHzqOp6Hebrnpx/Qss+C2lj5?=
 =?us-ascii?Q?5NFHl9GzIYry8oinoRHOUtDv4QuR8OtS401qwoKs6Wcan47YyaX0DF9txfLr?=
 =?us-ascii?Q?fxYpMhGfdlQSKFph2lSSxzG0ZITfGnqvhEL7uRGVms3Agka437N8D0dl0h4A?=
 =?us-ascii?Q?ULiN/D9GEF9LzTVZkk+uFweEH6fKncjq6+J9FPRkBQjADLm5XoVKHJxjfMeO?=
 =?us-ascii?Q?G06SnLjbWaZaTtZBOL4nkuL3Kvio4erwTOvTCDqxcqlHpeIzvRfPgAxuWA1C?=
 =?us-ascii?Q?Ro/ul6NyOpAqVibtwlabr6fxK8G5rSoUCdMubD/Vssjlh5is2prHmuO0fso4?=
 =?us-ascii?Q?XngT1sPYQbyPou8UdCrNs4aZgGhcva/Fk+nLjL39W06gkZX6cLOO75T2J+dO?=
 =?us-ascii?Q?ebkdOyXRUToPRiVwZci3RIufYd6BCuxx6fU0nylkCmfavSSQE9wnf1jzh6Yw?=
 =?us-ascii?Q?plw9IhCnelGMFThzFKpgUHoBeTLeUel6t4lX9+OYcDSxmBZUA3DMWjc33CIM?=
 =?us-ascii?Q?pun0op4z5Gao4hcdsURtqFjiPZMUDSAJExSjtXLY0m4T0abZ8WZZFlnH9OZH?=
 =?us-ascii?Q?KUof4TIo/kq3xMZzsqwC/NDhr+4rFne4PGGT25XKiV4ePkDXzIHgMFBm9M/g?=
 =?us-ascii?Q?3wdx1DcUcDuRKfxlneAPpYB1+VZVNmWPtxGzPkL4vaqKTuMQjflvqCDUX3hu?=
 =?us-ascii?Q?O/Io4c5FNKLMdI0kn/FMBUJkvIQmbcC0uLM6wAelNt9IzuQfikxEWQWJ3BHw?=
 =?us-ascii?Q?G+nxF+JEOl+pP8NwGZdQIePfRP+ucHOCjtMThQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd336f3a-36cc-4771-4df0-08dc138cb13e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 16:36:56.9753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8429

From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com> Sent: Wednes=
day, January 10, 2024 10:13 PM
>=20
> The test topology was used to check the performance between
> cpu_local_spread() and the new approach is :
> Case 1
> IRQ     Nodes  Cores CPUs
> 0       1      0     0-1
> 1       1      1     2-3
> 2       1      2     4-5
> 3       1      3     6-7
>=20
> and with existing cpu_local_spread()
> Case 2
> IRQ    Nodes  Cores CPUs
> 0      1      0     0
> 1      1      0     1
> 2      1      1     2
> 3      1      1     3
>=20
> Total 4 channels were used, which was set up by ethtool.
> case 1 with ntttcp has given 15 percent better performance, than
> case 2. During the test irqbalance was disabled as well.
>=20
> Also you are right, with 64CPU system this approach will spread
> the irqs like the cpu_local_spread() but in the future we will offer
> MANA nodes, with more than 64 CPUs. There it this new design will
> give better performance.
>=20
> I will add this performance benefit details in commit message of
> next version.

Here are my concerns:

1.  The most commonly used VMs these days have 64 or fewer
vCPUs and won't see any performance benefit.

2.  Larger VMs probably won't see the full 15% benefit because
all vCPUs in the local NUMA node will be assigned IRQs.  For
example, in a VM with 96 vCPUs and 2 NUMA nodes, all 48
vCPUs in NUMA node 0 will all be assigned IRQs.  The remaining
16 IRQs will be spread out on the 48 CPUs in NUMA node 1
in a way that avoids sharing a core.  But overall the means
that 75% of the IRQs will still be sharing a core and
presumably not see any perf benefit.

3.  Your experiment was on a relatively small scale:   4 IRQs
spread across 2 cores vs. across 4 cores.  Have you run any
experiments on VMs with 128 vCPUs (for example) where
most of the IRQs are not sharing a core?  I'm wondering if
the results with 4 IRQs really scale up to 64 IRQs.  A lot can
be different in a VM with 64 cores and 2 NUMA nodes vs.
4 cores in a single node.

4.  The new algorithm prefers assigning to all vCPUs in
each NUMA hop over assigning to separate cores.  Are there
experiments showing that is the right tradeoff?  What
are the results if assigning to separate cores is preferred?

My bottom line:  The new algorithm adds complexity.  We
should be really clear on where it adds performance benefit
and where it doesn't, and be convinced that the benefit
is worth the extra complexity.

Michael

