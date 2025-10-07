Return-Path: <linux-hyperv+bounces-7131-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33FEBC1F5F
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Oct 2025 17:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0E33B4755
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Oct 2025 15:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB0B2DC77E;
	Tue,  7 Oct 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Q3EpYCR2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010024.outbound.protection.outlook.com [52.103.23.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD6F2550CA;
	Tue,  7 Oct 2025 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851708; cv=fail; b=XfV0pdecZpyz22KiWjpZTQz1/MZeeihfDH4F9Airl8fhUXqjrtM0CBOByPg+7CiI3CY2sqATSt+DRZnBJ/oFhIaEoD2EFm8mcUbMcSjptxc3Es60IjNwWjLpJEy7YGxaDNgRCTxSah1rQcDWkR/ZFV/Fjl8pmpYfdCGQWzW5JTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851708; c=relaxed/simple;
	bh=MjqbMlVimN/evxxvqGvtn7q+2wjex4LuYxzkBIaJP3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K+83UTb7XEfkI81HwBgHNEEu3ec4DLf3D81Ueh9VXr1AM01ux96pNqDKUE/tX7+JzyEpFvIqn4Wd2Smb8f26uwkgG0MP+LlHTb7uD0MLR20KGSnt9Qa02Bi10faxruCXsymAMfOVRE0zmrz6amkam5zrcDLiFyK0b1++OQCdvj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Q3EpYCR2; arc=fail smtp.client-ip=52.103.23.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eo/J1tin6jMbvbLzFRPJSAuizF6CnrA/nbUXBqp7292Ks9rAUYw/Q9iZyt38QIdzdGrK2Dv4tuVmvNRsyknPtMA8cepzY601KLtAdoHq/0CWFNcameLvFSaPNVzb0Jv8AQsptjgK5RFkseFdk4ke8IJPNHzVKChrWB3IMyjjmy6HwlC59UNyA9ji5wtbqecUam4W8OBQn564vnVrmkiyStxJ03RvP1/zPvkVoCMb52fUf18tN8RQhKSyuwjcmDHTPaplGQzGSpJOxlmJIeMAtklCWmLOnIipM6S2pqIFjd3EypccFrzBL/BuDQ4Lo48RF1PZKA48DHHENdFcUXjoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtXapYRCkp5V65nWgkHbEKU+tSMHN7aQL9iouvIjCkA=;
 b=ksbBne0aAY+7IZC3p1Y4tXMtnYKesB/W/mD+CzdsiCEfa0Z5YKV4P7o0XcFwpP76B9ftBB3uPcf7CN/bkkdjcezuJ41tL4B2Z+bZvuNQ60IjT2xSj+2KOKF0SusUz4ExsrwVIjTcVabvWZhq2vr6OjL19eWuSloKEMqdkK8w7YLzBM9wu1Vb8k38eUuIr7Mv5QwqhaqQJnyq/yIiwvNapSqCSm8d3Xzqda0Ws+QoBLCZLVQnut6pzfzz9wBNYz43Udoe4zJyjFZSRt7BFsAkL/YTb66i/Ae3mQyqxmAs32nw5S6BZpoRDfwEsP78kFR49qN5+6QKRQUJO+rDoNpuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtXapYRCkp5V65nWgkHbEKU+tSMHN7aQL9iouvIjCkA=;
 b=Q3EpYCR28TXoMyr/6LDV7/JyjncAso0n5td5WwzvKcNDXRDmC0zvUkR8Sgood37fzwBjfGo2fiY9seLCzeZe5AwhKhEhzr0RX0xjX+KDKAeZjhOIM3fKjisZsjNA5ea4/M0QGWLvxh2de481/iLjhrvlCNS2uhJzjrYuyMmyTsHQyXFVDZgA93hiqk3pHIQPjEmQ90KBjVclFaHyOy5BYnJ04t5FEjlcx6t8No2U1zUD5iv/XxAvFyodKrAR++egFBGw/UykJUA+ryCSgvB5fXrlBTEMR+NIu2m7OaLlR8qizwpYwL4LybRXZFoo3e1LLqR6uaIMJxwMntLGjprNEQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8026.namprd02.prod.outlook.com (2603:10b6:610:107::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 15:41:43 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 15:41:43 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linux.microsoft.com" <longli@linux.microsoft.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, James Bottomley <JBottomley@Odin.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>
Subject: RE: [PATCH] scsi: storvsc: Prefer returning channel with the same CPU
 as on the I/O issuing CPU
Thread-Topic: [PATCH] scsi: storvsc: Prefer returning channel with the same
 CPU as on the I/O issuing CPU
Thread-Index: AQHcM1o80XmWhpePUEiNmnbV/dytobS20liA
Date: Tue, 7 Oct 2025 15:41:43 +0000
Message-ID:
 <SN6PR02MB4157B7FC3362C4C6838BAD3DD4E0A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1759381530-7414-1-git-send-email-longli@linux.microsoft.com>
In-Reply-To: <1759381530-7414-1-git-send-email-longli@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8026:EE_
x-ms-office365-filtering-correlation-id: 38989c0c-c346-4b1f-78cc-08de05b80429
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|8062599012|8060799015|15080799012|19110799012|13091999003|31061999003|56899033|13041999003|3412199025|440099028|52005399003|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FQ6GJ6K3XGePOOhdaBOc4I81++6GOFyHFr+HRj4yebsCFBYH0QYPejnJUMCA?=
 =?us-ascii?Q?sdth6fA0QrsdPXIPb+k4vX6AuCJwvw0R+mcI2ztPWmOjRl6DsQiMn4ihPjri?=
 =?us-ascii?Q?hVyNIKQoGKEkBRf/ipWv4uUHsy7+fXvbch8YUiHanuytgDNbuskxza4ahkiG?=
 =?us-ascii?Q?pg3i+UJd+n/YfVjXnmFqlQ6x8Mmz51yCSy7mMDZBrNTmK2sA1l4y6VWuJNAZ?=
 =?us-ascii?Q?/JuCG677fF+dUr90Q6E57ZecR2vhdEQd3Gp5+sT0Mx7AsfOscwjjKiwr264P?=
 =?us-ascii?Q?9k5EiDE6fG3YYfx0V58JVVYnUST5ipOfMp4MBfMaKlRezSUsTnwp3BfPLH+R?=
 =?us-ascii?Q?VHZ+N7XWEaz6oheqozc0eDBWir36kxxBEtd9VKyED1XY8NO7b2y0izvxyu5f?=
 =?us-ascii?Q?Amicc5NuE5WhAahzUHKZE3urYr1M2pTp/aw0PGSG81qGlc6Tyi0Hv+t6n7fK?=
 =?us-ascii?Q?q6Fszr1RXu3f/IVxgVsxnSvUQiQq3xQ4B+KzZivFKfFnsC8Y9R77C6OY6dyY?=
 =?us-ascii?Q?2ZiREI0TVyRTd9F90QJEWABJIKkHm9rIoDyt/DHhLg+VV4f7C4OY6iMGtbY9?=
 =?us-ascii?Q?+3yOxF+dKsOuxKzbny7y6/bhyIFKEZWGwSDMFGZ+4WzOjPjdTsB0hwH4nP9M?=
 =?us-ascii?Q?XZM4uALD5bWETGfBYmSGqgsMDnINq/0yqf+dMfy6SA1qDb7g0n+QoXqWXKrD?=
 =?us-ascii?Q?RONlzitEy5kH9NSwPl6+E0zPLIKZ12vJQsX4vB3ayVjo/rmgiBCfx/NACXIi?=
 =?us-ascii?Q?fDJvI6HVn7/1djYQn5q8U2UP1SqiVZIvFeC3uRXtGhCLltsRn/3Y2K1k/fin?=
 =?us-ascii?Q?YwKRvSaqMG15IMx6+2WnQUS9ljfPIjNWNtrZtp1m/ungnTskI54sNj3zxHJ7?=
 =?us-ascii?Q?5hjsaM4aWABmAIS0MHqUQ59EdXHIrw3Pho8/Df+r1bCCiUB707xdNvEjKoJu?=
 =?us-ascii?Q?GT3gtN9CWd2MWF2nEKcK6J3T8qcFo7Zw9wpHhykzL+5MEbyYn+FomyC29FwK?=
 =?us-ascii?Q?jo9sJAwPhjOySmY4Mhsu+IQLsdFB89Q9PUJwB9F4TM7c7yrZKF+giCovTEc/?=
 =?us-ascii?Q?ITPCWLMKnbZlbon7haZhfO4GhoYbD0V494Rc0yQNyFXZTrJLtm0GcKnq+rBQ?=
 =?us-ascii?Q?ISbJ9IGWCwJOntUQ6l3ZMF6xYS8iJTJlRXfLcb5nCC/+qoguX3v04CWRIZvD?=
 =?us-ascii?Q?gX47UqHJpMQHyZH9j1zd1+qCZfK+1ABWjt0gj2E9HSd05aR0qErV2jhL0nMe?=
 =?us-ascii?Q?iHdgmCQewig4gNb89N3c6q6iniCOKWBF6I+txNToug=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9gsv8LiRE7rs/8XpN/reQ7NS9iNQ6Ny3fSCqEYsu/Bn2MU7EEF0cyHosJ0tw?=
 =?us-ascii?Q?rXhqnthHcmZQO96sKJCbQLtxLgmBwMC+e94hJi4d7OQHgXfaIMLcvwXyMWSL?=
 =?us-ascii?Q?xbRD2tFgIQvu3fIZ8/Im0engxzq4xCU9auwI+ayuD+PVFpgrav3bV5MIQZd3?=
 =?us-ascii?Q?SoO1gJTPGdHEDE1I5rC48Qsg3OdPptkiUbPSWLaeGRJ66urpE9NDFGpAVJXf?=
 =?us-ascii?Q?Q+dA3p7hXiFeocwUCJym4igJy5U60qsAfyYcAsBAjH0tFbbelfeL3cepvi0r?=
 =?us-ascii?Q?Z+78ti7iKyZVsqGUVCxMXkelHP4ghnRphnS6fWTtSypVTtjjC0PoIQviexgg?=
 =?us-ascii?Q?VG7D+LpiTka4Cu6bq88UT/tlzbYC+r9AJPXpgi1WTnTRGhRuyzbfNtRiOD6T?=
 =?us-ascii?Q?GWTYpYxs0QdBKnPoJ5MWGcbqGwCrc7YIbcL1HW5EHWrn9Po35uUPk8Rd3obf?=
 =?us-ascii?Q?N8jKUfihp6S1DHYgg/7LjR+9CuS5tu4jhcddL703TeL/DlKmIHoDJ42mkXPo?=
 =?us-ascii?Q?mQ0hZ45AlpR2wCuFKyOkxfiQdqAPvxt/AgXlwH9mWTY/J+JPbxCYu1iHtGKZ?=
 =?us-ascii?Q?7Epr5opuyVH82q+WrhDtw+gjRFYWhSr0P9FPl7zpHj+9Z2aNTp5j7zHg6P01?=
 =?us-ascii?Q?iRviiBux1M2vFmAX7oHF6MYRcye5tDGT2T1t03oSTMwzQApAY+m88F3urQJy?=
 =?us-ascii?Q?tBYTrQpHDGCykp/99V1+R0p4Cn3tfXWFkclzhCt2lCkau3QPP1tqebrCDgPY?=
 =?us-ascii?Q?U18xJGLixUzD+BBWlue9E8b0gSrPapuTxRVmpXVbmdjK9LIr3FnQgJUxBZ2i?=
 =?us-ascii?Q?MsrATu2ZtAZ3oWM4pGRjeFQqxBlEAQo32jgbEZk7fb4un6KTM5l8lKJYTDbP?=
 =?us-ascii?Q?w1ueqDm1OhHxv6m1nGP8p4IbfcE5vfGuEs1z0ufEgpLB0GXXlYGrfFEsrmtP?=
 =?us-ascii?Q?qBbvgbfpR+jN0Zeler/ey1bBSEhct4+2o9z5VtodC4qG1OIvhZvdmZACGaan?=
 =?us-ascii?Q?iZ3+Wp33+0ZNvK1pi/7v+3KIlQSTVrXc/FbRDiuUX4pUGe32wrj7+/cfye5G?=
 =?us-ascii?Q?8f+FpOdMxZeFA9uQokEiaiZj9D+pkbWjm1x0UaYRTY046WZLa/l7z4PN+A7h?=
 =?us-ascii?Q?/e2UG7m1olryOc2xnNmpIayH/3PKsyf6cxkAfYfoxQlbwx+XV5CVqL65bENr?=
 =?us-ascii?Q?/j8dMiXhW4zcG+OMRaVvrnzixiNr80zL0w4Ufa79b3TseuwrCL+6+9HzFiE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38989c0c-c346-4b1f-78cc-08de05b80429
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 15:41:43.4961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8026

From: longli@linux.microsoft.com <longli@linux.microsoft.com> Sent: Wednesd=
ay, October 1, 2025 10:06 PM
>=20
> When selecting an outgoing channel for I/O, storvsc tries to select a
> channel with a returning CPU that is not the same as issuing CPU. This
> worked well in the past, however it doesn't work well when the Hyper-V
> exposes a large number of channels (up to the number of all CPUs). Use
> a different CPU for returning channel is not efficient on Hyper-V.
>=20
> Change this behavior by preferring to the channel with the same CPU
> as the current I/O issuing CPU whenever possible.
>=20
> Tests have shown improvements in newer Hyper-V/Azure environment, and
> no regression with older Hyper-V/Azure environments.
>=20
> Tested-by: Raheel Abdul Faizy <rabdulfaizy@microsoft.com>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 96 ++++++++++++++++++--------------------
>  1 file changed, 45 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index d9e59204a9c3..092939791ea0 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1406,14 +1406,19 @@ static struct vmbus_channel *get_og_chn(struct st=
orvsc_device *stor_device,
>  	}
>=20
>  	/*
> -	 * Our channel array is sparsley populated and we
> +	 * Our channel array could be sparsley populated and we
>  	 * initiated I/O on a processor/hw-q that does not
>  	 * currently have a designated channel. Fix this.
>  	 * The strategy is simple:
> -	 * I. Ensure NUMA locality
> -	 * II. Distribute evenly (best effort)
> +	 * I. Prefer the channel associated with the current CPU
> +	 * II. Ensure NUMA locality
> +	 * III. Distribute evenly (best effort)
>  	 */
>=20
> +	/* Prefer the channel on the I/O issuing processor/hw-q */
> +	if (cpumask_test_cpu(q_num, &stor_device->alloced_cpus))
> +		return stor_device->stor_chns[q_num];
> +

Hmmm. When get_og_chn() is called, we know that
stor_device->stor_chns[q_num] is NULL since storvsc_do_io() has
already handled the non-NULL case. And the checks are all done
with stor_device->lock held, so the stor_chns array can't change.=20
Hence the above code will return NULL, which will cause a NULL
reference when storvsc_do_io() sends out the VMBus packet.

My recollection is that get_og_chan() is called when there is no
channel that interrupts the current CPU (that's what it means
for stor_device->stor_chns[<current CPU>] to be NULL). So the
algorithm must pick a channel that interrupts some other CPU,
preferably a CPU in the current NUMA node. Adding code to prefer
the channel associated with the current CPU doesn't make sense in
get_og_chn(), as get_og_chn() is only called when it is already=20
known that there is no such channel.

Or is there a case that I'm missing? Regardless, the above code
seems problematic because it would return NULL.

Michael

>  	node_mask =3D cpumask_of_node(cpu_to_node(q_num));
>=20
>  	num_channels =3D 0;
> @@ -1469,59 +1474,48 @@ static int storvsc_do_io(struct hv_device *device=
,
>  	/* See storvsc_change_target_cpu(). */
>  	outgoing_channel =3D READ_ONCE(stor_device->stor_chns[q_num]);
>  	if (outgoing_channel !=3D NULL) {
> -		if (outgoing_channel->target_cpu =3D=3D q_num) {
> -			/*
> -			 * Ideally, we want to pick a different channel if
> -			 * available on the same NUMA node.
> -			 */
> -			node_mask =3D cpumask_of_node(cpu_to_node(q_num));
> -			for_each_cpu_wrap(tgt_cpu,
> -				 &stor_device->alloced_cpus, q_num + 1) {
> -				if (!cpumask_test_cpu(tgt_cpu, node_mask))
> -					continue;
> -				if (tgt_cpu =3D=3D q_num)
> -					continue;
> -				channel =3D READ_ONCE(
> -					stor_device->stor_chns[tgt_cpu]);
> -				if (channel =3D=3D NULL)
> -					continue;
> -				if (hv_get_avail_to_write_percent(
> -							&channel->outbound)
> -						> ring_avail_percent_lowater) {
> -					outgoing_channel =3D channel;
> -					goto found_channel;
> -				}
> -			}
> +		if (hv_get_avail_to_write_percent(&outgoing_channel->outbound)
> +				> ring_avail_percent_lowater)
> +			goto found_channel;
>=20
> -			/*
> -			 * All the other channels on the same NUMA node are
> -			 * busy. Try to use the channel on the current CPU
> -			 */
> -			if (hv_get_avail_to_write_percent(
> -						&outgoing_channel->outbound)
> -					> ring_avail_percent_lowater)
> +		/*
> +		 * Channel is busy, try to find a channel on the same NUMA node
> +		 */
> +		node_mask =3D cpumask_of_node(cpu_to_node(q_num));
> +		for_each_cpu_wrap(tgt_cpu, &stor_device->alloced_cpus,
> +				  q_num + 1) {
> +			if (!cpumask_test_cpu(tgt_cpu, node_mask))
> +				continue;
> +			channel =3D READ_ONCE(stor_device->stor_chns[tgt_cpu]);
> +			if (!channel)
> +				continue;
> +			if (hv_get_avail_to_write_percent(&channel->outbound)
> +					> ring_avail_percent_lowater) {
> +				outgoing_channel =3D channel;
>  				goto found_channel;
> +			}
> +		}
>=20
> -			/*
> -			 * If we reach here, all the channels on the current
> -			 * NUMA node are busy. Try to find a channel in
> -			 * other NUMA nodes
> -			 */
> -			for_each_cpu(tgt_cpu, &stor_device->alloced_cpus) {
> -				if (cpumask_test_cpu(tgt_cpu, node_mask))
> -					continue;
> -				channel =3D READ_ONCE(
> -					stor_device->stor_chns[tgt_cpu]);
> -				if (channel =3D=3D NULL)
> -					continue;
> -				if (hv_get_avail_to_write_percent(
> -							&channel->outbound)
> -						> ring_avail_percent_lowater) {
> -					outgoing_channel =3D channel;
> -					goto found_channel;
> -				}
> +		/*
> +		 * If we reach here, all the channels on the current
> +		 * NUMA node are busy. Try to find a channel in
> +		 * all NUMA nodes
> +		 */
> +		for_each_cpu_wrap(tgt_cpu, &stor_device->alloced_cpus,
> +				  q_num + 1) {
> +			channel =3D READ_ONCE(stor_device->stor_chns[tgt_cpu]);
> +			if (!channel)
> +				continue;
> +			if (hv_get_avail_to_write_percent(&channel->outbound)
> +					> ring_avail_percent_lowater) {
> +				outgoing_channel =3D channel;
> +				goto found_channel;
>  			}
>  		}
> +		/*
> +		 * If we reach here, all the channels are busy. Use the
> +		 * original channel found.
> +		 */
>  	} else {
>  		spin_lock_irqsave(&stor_device->lock, flags);
>  		outgoing_channel =3D stor_device->stor_chns[q_num];
> --
> 2.34.1
>=20


