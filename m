Return-Path: <linux-hyperv+bounces-8868-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDdnH5GNlGn6FQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8868-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 16:47:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E99B014DAE4
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 16:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93427302AD20
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41203358AD;
	Tue, 17 Feb 2026 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tWl80eXj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010022.outbound.protection.outlook.com [52.103.2.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4561D90DF;
	Tue, 17 Feb 2026 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771343243; cv=fail; b=WW4CEh/MR1oY7mBtkjMw6GZd/E+9cRpHrCjto06i8riPXqP8Pa+8FdOQtpLG94R5D+f1vAK7AgrgOjEarcSSbfrRgK7/SmPfo1UXBeOVrRmbaQM+UMIRZPGA63I+zm6fXd8lBxJH+h58/D6H3rzZxjpSWooecWzYP4RaEGDY/HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771343243; c=relaxed/simple;
	bh=fsFyHogiIvzfgS1SXYmYQPtNU2/OUkY9rclxqso8Prs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NHNrNpOiFiCpz/5BnmoWsypMAoEKaBSSNqmB5M9DswBSe28s4HdMfjanM24LD6VWZks9LDfQ0xEAr6tkvzaXaUabVx4DRI0tCrLtwHk+HbenEx9vjzzd7gTRAbVwVgWj8l5KOGmzSarP3Q9fRe0yRqjqmhC/qTzixD2ho++ba0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tWl80eXj; arc=fail smtp.client-ip=52.103.2.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYH1FmbxvEjvUaHQdmxPjKAf6fI1/haSU3/eYzXa6pHybEwVfxRhOncC0+fCUJ5j1qD75BjsGFaKGrTRShwN2gy9HZgBrY62N3G9y7c2/lAS5J/MUDmjyvAp1TbXwwxXsWadKV9VP8SawbG03v3o/lJn8hguYN1pofXzbhE2DXzYld5Ny/VExxPAGsytUZatgSnzM3/nc2UnnzlxvrwlWCjxjrZCr0hXDNn6b9CocV6S1ZdWfnmVr4yrt8wNOFa+8579tuP3024cpDvTwLGotOcHgKM93Pxry4hzDbHT8YcfgmLiulk8VnYBu9EpEbS/EO7uJsVCX/BBly/JB+4GJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYBG0/7CwaJyy8WOt3hfIh1nwDFf9hhj1p6JBOx/FKg=;
 b=uc9bygmj6pE5QWUkFm7hm/U8lTp+6CwTSgDjRfgMfnAlrlMMZDtt10nPRtjoiudqLutoS5dCpypsH6gLjkeCjZRDePV2FCQFv8bQAsmBVcyWTTtClWY7qb0ToUPeHCuuj6HGIbuZDtAeHJaA4OhEOHRwF0fSZ08L/67NC0StnRIOSQjxEgJoWL5R4/QZVlX76jlx3LFdqxLBuIXCzqsdYxXdcbgXyq7HvSfCOtHY6eXoXp8dY/rG5g6v1BhNcN2yEPUy/XkC8mRGeDVEM5xy0XhC+5v0p1HF79z5q/PP7rN+UfCWdYUdIRMZYoyWdiGjSpKlO+9d3eRTqINeACdHUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYBG0/7CwaJyy8WOt3hfIh1nwDFf9hhj1p6JBOx/FKg=;
 b=tWl80eXjNU0Hs6f9Xs7Y9fdnbVLb76HEe2gB98BLh1Xzypztjpa0QjnV9/Cq/nUu/yboqAJHtOmQbjCI2O4fm59Q6h/IwWVr/Hh6CH6uyejXmmPxKhhOUICgw3qp9XbTd72FH9+c+xYivsgSHUG8oa8je6pYOpAJmiwY1jVCBUX5ZyuzgElgj9amNFXARoOj8gGl6dPfm8qMtzhlaGMK9UGwj20TQ1vYjCM0nkSJp7kceVBCuK2a5gdKzcmmjabEWs1MU9m0c6XPDPWpwq9xZ32PSBByoREhAIZoEavOIvPRhscdtrLCW5JoIihVL4d54GAx4OZEJl71TdiWBGxgVw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM3PR02MB10274.namprd02.prod.outlook.com (2603:10b6:0:3d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Tue, 17 Feb
 2026 15:47:19 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 15:47:19 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Florian Bezdeka
	<florian.bezdeka@siemens.com>, RT <linux-rt-users@vger.kernel.org>, Mitchell
 Levy <levymitchell0@gmail.com>
Subject: RE: [PATCH] scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT
Thread-Topic: [PATCH] scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT
Thread-Index: AQHckSxbvhmgYaIv+0OErRpLCnikxbWHJg5w
Date: Tue, 17 Feb 2026 15:47:19 +0000
Message-ID:
 <SN6PR02MB41579C9B4F885B33D57705CFD46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com>
In-Reply-To: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM3PR02MB10274:EE_
x-ms-office365-filtering-correlation-id: f419cf10-95a5-4ef3-5241-08de6e3bd56d
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|8062599012|51005399006|15080799012|19110799012|31061999003|8060799015|461199028|1602099012|40105399003|3412199025|440099028|4302099013|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WkB/Gzx99I8okgxmUIfdVw5CYK9i9fRv2EIC7hnkvwXapvc+mDlYRndy8s8y?=
 =?us-ascii?Q?PGZTxhOqxWRMfnIW4xZm8j4efCJ4/l2TomWpBIN1NYH0rzHXKCfxsNn29clV?=
 =?us-ascii?Q?DNPDE7WHzicNKW+Wf9obf1wn4HDs5y3lbleWEbLZafexHCw60JWH1GY2UZrt?=
 =?us-ascii?Q?jLfxgBG43rLyVch6zs/MoIunaFf5dU/KJDn8zS3Wr8cM5DzKFrSkIh6A4h8J?=
 =?us-ascii?Q?78gtZPvd5Ui00Z+wEmciyCfa2Fgde0ASGZ+GPE+RTEr1I5r1cv4bRwAfCNcv?=
 =?us-ascii?Q?3FMdvj8NNZB9aWRCkb2Sbm+P00gNx3MEwENfmrk9n13RpIJTOSJSaBbHR8b7?=
 =?us-ascii?Q?osEQAZUw26u/fvcoV2tbb+RaMsOjDzp3nERiy+/5uG8bIdVFXzleqooUlOTt?=
 =?us-ascii?Q?y1yjGZV94XvFU2LY+nGYeS+bTy7scxHUuHFsPRW6/m7JrbDtOY5jBMls4tvK?=
 =?us-ascii?Q?p+y4xN74GMsAzH74xDN6VVio2Ka0XT6Aw/WlxwF2przwfbXWYNVTVWQa+7+W?=
 =?us-ascii?Q?fIOfa74DRRccZs+kd++xbZrk6p0O3/QGJhHA+brTRJEIBgHPs51sex+QaTaN?=
 =?us-ascii?Q?bnueuCrZPnV2vujycFwnNjjPc6byfCc81Zcwx0XgVrLFCBzpxyQLFXwkc2NW?=
 =?us-ascii?Q?La1fIlcTSluyoc9dSBUrEqBffF0KHjSWVRxoK3INFvUPJymxHEgYkoK5w12s?=
 =?us-ascii?Q?iXbGKjhmnctNZfIAF4kEXJisPCsKgEM+P34elv7+5d8jVE0XJcmcbgh7/Ya7?=
 =?us-ascii?Q?yhSM9H/cP3ZoFmOnMTvXHOusTWUloUoScxDRkg5fQ+vaCAuqsyCEyRwezzjU?=
 =?us-ascii?Q?R0efLhVjTTUMulrnhee2X/fPfbOi1roy/aiOXF3NXMkYE5KH0WseINrbKD+3?=
 =?us-ascii?Q?pgVA4Zj3Mwyw+dnELU6zJjU2/h0rGwA28w281skaBmitsklPECX+GOv3f88Q?=
 =?us-ascii?Q?UVKjHGCsLbrQG0INZvdgFNHRQySc+FmKqGBOQNAnvyt4xDjFHDqW/LzwMM25?=
 =?us-ascii?Q?q7dySFYKGoKoybOT8NIo6CqS5V5Hj260ekTg0y37zwzUVKpoHJnfQ/BEqv80?=
 =?us-ascii?Q?yxZ7LN9qw4CKssDV+UUYShWtdbDd/+RGCBm4t4gdih1JKaDrxIgcyK2tfSQi?=
 =?us-ascii?Q?H8gccMw9LsKa/T2ZfIAjKiwxVGuEY4IAdOYOAI7Zu94/OLDr7r7JvvwZTfxU?=
 =?us-ascii?Q?WPRdV/lUE6j5MgzmbxH3Jika0+bkYb13wIKEYb7W/NjFg9EasEAAdltiCq6w?=
 =?us-ascii?Q?tbEe6KVcPUcuEkq2WDlME363llnUa7zwIjQDD2LkPSmDjZhbd3ErmLpDezrB?=
 =?us-ascii?Q?JWdIggw33+4/+cF/efQE2zSpwrlC4RFciDTExgY9LUAZmA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+A5/+51lAcLZud9VfJKKn9BZLtDFOnUtwfUgidC6+qugcBQusO+JX1cMzqkq?=
 =?us-ascii?Q?0X5YSdGaSBSa4AE33tprKG2ABs0+4ex6+ks6lFe/PDojWZL3Hr8Is/ejyDev?=
 =?us-ascii?Q?NZGjuwypcD/cr7bqKN5kKDFuTqexamrmPA/jBbDEC33mHw1jIuN3Bb1doQs0?=
 =?us-ascii?Q?pXEqzl535TE8/nk72nugP2KUkPZwTgksxm4L4zo1roKwfZM/tzL9nOui0Act?=
 =?us-ascii?Q?Baj7XI0u7/8NbHtkTN0OCzRynfXLBPPJNuYXgPJuH7p8UamN8YVb1wOS96xc?=
 =?us-ascii?Q?LTHBaXCCrHR1M0MGKJeASP0Y5PQFNS9KIUO5dv7n9uos1gpWWJueuDjj5RFb?=
 =?us-ascii?Q?kijSH/7WYY99lNib4Z4QFZhS8pzVXNC1k3pMSNA2L34SWQmxPCWqIvTEd+xj?=
 =?us-ascii?Q?+eYRAXRuOOAAMRy2R3sNmUEWrjeUjZWs+TjQ2jVMOSprG7nb/pfPZEfaKGTg?=
 =?us-ascii?Q?Dpnxw14zMSy7QrY0O6dF7D6wDNzMQ+i3IS9F9q38iFTGqNrupwxY8pLDCMUt?=
 =?us-ascii?Q?ZlTERHgWuX4i/wn3C3p3/RYqvheS01uWbylCV5Dz1vcaeYJkDvHEj8ABQhzZ?=
 =?us-ascii?Q?+b994CZ7FGoXXiQk3zVGHsfSsTVGnpywKxwVh351G/fTUoPTV/rBnRuI74B3?=
 =?us-ascii?Q?IaZkQIkuEo38NnVBWFdc8SqG5UuGQSVveT0/v8fuaaiiujXQZ9sgEUASOR1m?=
 =?us-ascii?Q?0DXiE9tGFp1lyb7TRk1JqzZGJ7arYOgUDl5SEA+M9sUx9AmS7dQIRLQ23bcT?=
 =?us-ascii?Q?FupERvpp3KAt2D6CenCG1C60mTh03nKPb4dylNY5Hl1liORHlDEUk86D1ifG?=
 =?us-ascii?Q?nFIlhzzC7dnm2RbaD7KgZorfQv5cfCEBkt693kqBrUt+GzFZahpiC3aUSB+y?=
 =?us-ascii?Q?aWMK32kP3HlFdofNvt61q7MZlEhrQe+YgTZ/9TgI6j8hoTuWT0wLxKjSSF/M?=
 =?us-ascii?Q?+7NHvkyaYVed0UeaXjuVS7DFdJOQgntwA0XVDYKrjECmCx9i7Q2wYIFNSAkH?=
 =?us-ascii?Q?q9hOEq2sT1LR4pUsyj7CgDvsHJXGfCFEbyLCjk76w8d6jsfk4nEj3hM1CLIA?=
 =?us-ascii?Q?DPUaQ/lJOu3neL/+sLlz6la3ifR4qjHM5uRYtLogVLn4AnAPN7yvLThJEIIb?=
 =?us-ascii?Q?aYyhWZ4mApGvZ+du6nnp35HCfpjyud/9o4DrE9bQmd994nwMq1KvrM0OMTNr?=
 =?us-ascii?Q?4MhvmFRFVkT5EacpdQoMFKkmHc5PmbM0Y6y5MnMwf15siNP0seX7TRnMDtk8?=
 =?us-ascii?Q?aUONV68tjz9Xphq2uXF6BCeIdjQONlvX7OwW1p7IuRkhUOPMaL/ZmSASjqtK?=
 =?us-ascii?Q?kEQPTvCD8suOmosqNY0zoYDVWtv96IBoahnwvawBE8NYZr7BYqQ6QzObXAtp?=
 =?us-ascii?Q?IPFr6kU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f419cf10-95a5-4ef3-5241-08de6e3bd56d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 15:47:19.5627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR02MB10274
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8868-lists,linux-hyperv=lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,siemens.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,outlook.com:dkim]
X-Rspamd-Queue-Id: E99B014DAE4
X-Rspamd-Action: no action

From: Jan Kiszka <jan.kiszka@siemens.com> Sent: Thursday, January 29, 2026 =
6:31 AM
>=20
> This resolves the follow splat and lock-up when running with PREEMPT_RT
> enabled on Hyper-V:
>=20
> [  415.140818] BUG: scheduling while atomic: stress-ng-iomix/1048/0x00000=
002
> [  415.140822] INFO: lockdep is turned off.
> [  415.140823] Modules linked in: intel_rapl_msr intel_rapl_common
> intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery
> pmt_class intel_pmc_ssram_telemetry intel_vsec ghash_clmulni_intel aesni_=
intel rapl
> binfmt_misc nls_ascii nls_cp437 vfat fat snd_pcm hyperv_drm snd_timer drm=
_client_lib
> drm_shmem_helper snd sg soundcore drm_kms_helper pcspkr hv_balloon hv_uti=
ls
> evdev joydev drm configfs efi_pstore nfnetlink vsock_loopback
> vmw_vsock_virtio_transport_common hv_sock vmw_vsock_vmci_transport vsock
> vmw_vmci efivarfs autofs4 ext4 crc16 mbcache jbd2 sr_mod sd_mod cdrom hv_=
storvsc
> serio_raw hid_generic scsi_transport_fc hid_hyperv scsi_mod hid hv_netvsc
> hyperv_keyboard scsi_common
> [  415.140846] Preemption disabled at:
> [  415.140847] [<ffffffffc0656171>] storvsc_queuecommand+0x2e1/0xbe0 [hv_=
storvsc]
> [  415.140854] CPU: 8 UID: 0 PID: 1048 Comm: stress-ng-iomix Not tainted =
6.19.0-rc7 #30 PREEMPT_{RT,(full)}
> [  415.140856] Hardware name: Microsoft Corporation Virtual Machine/Virtu=
al Machine, BIOS Hyper-V UEFI Release v4.1 09/04/2024
> [  415.140857] Call Trace:
> [  415.140861]  <TASK>
> [  415.140861]  ? storvsc_queuecommand+0x2e1/0xbe0 [hv_storvsc]
> [  415.140863]  dump_stack_lvl+0x91/0xb0
> [  415.140870]  __schedule_bug+0x9c/0xc0
> [  415.140875]  __schedule+0xdf6/0x1300
> [  415.140877]  ? rtlock_slowlock_locked+0x56c/0x1980
> [  415.140879]  ? rcu_is_watching+0x12/0x60
> [  415.140883]  schedule_rtlock+0x21/0x40
> [  415.140885]  rtlock_slowlock_locked+0x502/0x1980
> [  415.140891]  rt_spin_lock+0x89/0x1e0
> [  415.140893]  hv_ringbuffer_write+0x87/0x2a0
> [  415.140899]  vmbus_sendpacket_mpb_desc+0xb6/0xe0
> [  415.140900]  ? rcu_is_watching+0x12/0x60
> [  415.140902]  storvsc_queuecommand+0x669/0xbe0 [hv_storvsc]
> [  415.140904]  ? HARDIRQ_verbose+0x10/0x10
> [  415.140908]  ? __rq_qos_issue+0x28/0x40
> [  415.140911]  scsi_queue_rq+0x760/0xd80 [scsi_mod]
> [  415.140926]  __blk_mq_issue_directly+0x4a/0xc0
> [  415.140928]  blk_mq_issue_direct+0x87/0x2b0
> [  415.140931]  blk_mq_dispatch_queue_requests+0x120/0x440
> [  415.140933]  blk_mq_flush_plug_list+0x7a/0x1a0
> [  415.140935]  __blk_flush_plug+0xf4/0x150
> [  415.140940]  __submit_bio+0x2b2/0x5c0
> [  415.140944]  ? submit_bio_noacct_nocheck+0x272/0x360
> [  415.140946]  submit_bio_noacct_nocheck+0x272/0x360
> [  415.140951]  ext4_read_bh_lock+0x3e/0x60 [ext4]
> [  415.140995]  ext4_block_write_begin+0x396/0x650 [ext4]
> [  415.141018]  ? __pfx_ext4_da_get_block_prep+0x10/0x10 [ext4]
> [  415.141038]  ext4_da_write_begin+0x1c4/0x350 [ext4]
> [  415.141060]  generic_perform_write+0x14e/0x2c0
> [  415.141065]  ext4_buffered_write_iter+0x6b/0x120 [ext4]
> [  415.141083]  vfs_write+0x2ca/0x570
> [  415.141087]  ksys_write+0x76/0xf0
> [  415.141089]  do_syscall_64+0x99/0x1490
> [  415.141093]  ? rcu_is_watching+0x12/0x60
> [  415.141095]  ? finish_task_switch.isra.0+0xdf/0x3d0
> [  415.141097]  ? rcu_is_watching+0x12/0x60
> [  415.141098]  ? lock_release+0x1f0/0x2a0
> [  415.141100]  ? rcu_is_watching+0x12/0x60
> [  415.141101]  ? finish_task_switch.isra.0+0xe4/0x3d0
> [  415.141103]  ? rcu_is_watching+0x12/0x60
> [  415.141104]  ? __schedule+0xb34/0x1300
> [  415.141106]  ? hrtimer_try_to_cancel+0x1d/0x170
> [  415.141109]  ? do_nanosleep+0x8b/0x160
> [  415.141111]  ? hrtimer_nanosleep+0x89/0x100
> [  415.141114]  ? __pfx_hrtimer_wakeup+0x10/0x10
> [  415.141116]  ? xfd_validate_state+0x26/0x90
> [  415.141118]  ? rcu_is_watching+0x12/0x60
> [  415.141120]  ? do_syscall_64+0x1e0/0x1490
> [  415.141121]  ? do_syscall_64+0x1e0/0x1490
> [  415.141123]  ? rcu_is_watching+0x12/0x60
> [  415.141124]  ? do_syscall_64+0x1e0/0x1490
> [  415.141125]  ? do_syscall_64+0x1e0/0x1490
> [  415.141127]  ? irqentry_exit+0x140/0x7e0
> [  415.141129]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> get_cpu() disables preemption while the spinlock hv_ringbuffer_write is
> using is converted to an rt-mutex under PREEMPT_RT.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>

> ---
>=20
> This is likely just the tip of an iceberg, see specifically [1], but if
> you never start addressing it, it will continue to crash ships, even if
> those are only on test cruises (we are fully aware that Hyper-V provides
> no RT guarantees for guests). A pragmatic alternative to that would be a
> simple
>=20
> config HYPERV
>     depends on !PREEMPT_RT
>=20
> Please share your thoughts if this fix is worth it, or if we should
> better stop looking at the next splats that show up after it. We are
> currently considering to thread some of the hv platform IRQs under
> PREEMPT_RT as potential next step.
>=20
> TIA!
>=20
> [1] https://lore.kernel.org/all/20230809-b4-rt_preempt-fix-v1-0-7283bbdc8=
b14@gmail.com/
>=20
>  drivers/scsi/storvsc_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index b43d876747b7..68c837146b9e 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1855,8 +1855,9 @@ static int storvsc_queuecommand(struct Scsi_Host *h=
ost, struct scsi_cmnd *scmnd)
>  	cmd_request->payload_sz =3D payload_sz;
>=20
>  	/* Invokes the vsc to start an IO */
> -	ret =3D storvsc_do_io(dev, cmd_request, get_cpu());
> -	put_cpu();
> +	migrate_disable();
> +	ret =3D storvsc_do_io(dev, cmd_request, smp_processor_id());
> +	migrate_enable();
>=20
>  	if (ret)
>  		scsi_dma_unmap(scmnd);
> --
> 2.51.0


