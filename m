Return-Path: <linux-hyperv+bounces-4357-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E47CA5A4D7
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 21:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50BA3A9C33
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 20:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7251D1B4153;
	Mon, 10 Mar 2025 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="j1p4fI2n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010079.outbound.protection.outlook.com [52.103.2.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB9139E;
	Mon, 10 Mar 2025 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638066; cv=fail; b=hqxEDbiVsBZM2RMUCl3VIIXyf/d+yblMQ8Qbo4DWJoKvIlpg8fGdzOXnjM9QCs/z468Xb5Wfb36RNBAPTQ22f+22wJtLeew+XVtMr3zxASZM2Ykbx/djoD/TNAmUfywCQNRToBRXlyQLk9qZy2Zd/c1uchAZaLPv7f4SpYpUS5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638066; c=relaxed/simple;
	bh=1idqnTfvL1yoddhcR9sP0fBoB/Lo8BjVM1NAcU4j6q8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yvh0yjIx6F+gti6JiECByxLoZTWNYpVL1upxDt6pjLcJxBKIAJzR9XEjAUQWTPZRbcvTi2jf7orgc1NfbcHjteMpR69qcBUfVoXll+eWiagIeY5cxHiw2VzjM8NLzqBZtcSyeZ0gGhdvTqeeB5U9ui4YGaVXtjRHi54cRFtOuvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=j1p4fI2n; arc=fail smtp.client-ip=52.103.2.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjxCOff7umJbhjgIz9y0YXWRLtwHL+3Dl2EBYUE87stMwRGQcKNW15cPS2PHK6ADMa9G9BRXCr1q2TRuU5Bg/YRM1wsvHEvj/bgZLFRhBqFkPnvwYaP7GPy4GcsJr0T45peQyG/DiRzQgu9fifgiKY3smuY1bMAa0ezFIQsZ7GGB2+g0T1OljiqaFXsnXaXxqdBe/NfgUX6EcMiPw269IjXjecWq3xqCh7C0NucNdXQqPN6bT6XklKLU3Sk9x8CEBKboeyRRV+nQqT+ZTWVy8aKx9MyMz/wu7LG9ckriQW38YYFYvnCVsviLRNNedthIoCsxTMrmh/Sh2cHPbW9r8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYA3d4lAhcj4DIYhBfnYzDVvJX3/W3P5RDkEiVR0VJg=;
 b=Q4Gj1PgxUxVnEhy5M/T1ELiXEOfU0NSbc4EWUpRjSduFHigyvpWaVUitSVTN2US2gnp5NIFMi6rEk3CwyhMJ0tYkrtq07UxZxmfjG5uWmV6Pk0YixOhhJHMG/f42j6j3OmpGKtAD6NxWc056hfQgjOrC0iUAD1vDDgQn6I7wXEMC39eZTMor9CVtUTFYa3ORyTqvsNipkl08fB6Bd6UGAV3gR4gH5qzUe9ToadnaN9A3hMn8FD08r+puWsVujTse38ZmI8gl1dcw7GsLt6PuH2FLTweHdeQV8HCHgfAijygVYMsPS+UHvZ5jttYe8HjsqsiYAijt9YD5HksaG+Shpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYA3d4lAhcj4DIYhBfnYzDVvJX3/W3P5RDkEiVR0VJg=;
 b=j1p4fI2nbzfjYyWafhYC3BareaqKPOlb5l3eC92J9qLd08HOdY8iQHTQRzHo76iNsPoaE88fichIzCfGx26W3471qz8HjDlDRzAZY50INaTZPTQPWb+eMkWBXSA8EXv/xdzdMALjz7w3XHN1nWPNfuK2URB2z1mftbJcidFPh9wX+0YOq3/hjsIk7RxAm60YnuDCWCpxaxpXuvY/y/07XU6Hpof4tfH+2QnvIjX0Fsmo3h7ibgc2+n2ht20UO8aGHZcPsdfmnCZ3bT+e5JrugGSOaV5jwwLwp2k7uJ9KyfhOI94YpZic1sp2nQMkDY+e2DemnbRPKb2uzq+t+iL3KQ==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by BL0PR02MB6514.namprd02.prod.outlook.com (2603:10b6:208:1cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 20:21:02 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 20:21:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hyperv: Remove unused union and structs
Thread-Topic: [PATCH] hyperv: Remove unused union and structs
Thread-Index: AQHbkfJebyVFUgBJq0+B7AOJi27pP7NsyzHw
Date: Mon, 10 Mar 2025 20:21:02 +0000
Message-ID:
 <BN7PR02MB414819702EA59A53FE581943D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250310192629.443162-1-thorsten.blum@linux.dev>
In-Reply-To: <20250310192629.443162-1-thorsten.blum@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|BL0PR02MB6514:EE_
x-ms-office365-filtering-correlation-id: d421ac61-5313-47b0-7b87-08dd60111437
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999004|19110799003|461199028|8062599003|8060799006|15080799006|440099028|3412199025|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0qf2YcmhpGkhJ73LPjk6X6N/ipW5jdW/3VL1b88N8vGlJGbfOk3e9aYdxVKX?=
 =?us-ascii?Q?sVy1BZWJvO4OH0C0p3sSaaHSDbSzMb6cjyivj6J9HZEDDP1LYc4qqtzlKAOq?=
 =?us-ascii?Q?h6+eCsNC3WDP1+g2iuO4uk6/fASgdS0B1ufroLldbeQw2XInRdtXqud+vhfd?=
 =?us-ascii?Q?+b+6PmNShUbd1+S3uTMGCbdKYZeJEnXCHFYX38wPlZ49IFafjb/ibR4y//1p?=
 =?us-ascii?Q?FM3dOgoP+z26ZeVYoRZ+KCPZ818FQcBs229MMItXcgpYjaXBOIxH4g02Cc1v?=
 =?us-ascii?Q?6QfkLzWx4NwR7IaAatjt2l2U0uhayTyPxKMoeSHO28N2kHpognJLXvf+6KEk?=
 =?us-ascii?Q?3OCd0bMenieJv526L2hbiaD6Ogk0cLm+InhR40rp1nQ9q3U4lTerePNPNLhp?=
 =?us-ascii?Q?JKlofSLbOpAzd+yrwfGXrB+mniYWyYiT70PVmuaaEs8gWeL3c0jI4C/51wKs?=
 =?us-ascii?Q?FftLE2ff6XYBlpVXm5JiJI0Lke/9nyFx0L82Ja0KNbj3jXjJzXMhflWo8N3T?=
 =?us-ascii?Q?gnnldXE+a2zkCpgbyLgNfj2VBDd0Oe9wJHT+BPo8GZfnMqLj/Xy2Lt6atpiX?=
 =?us-ascii?Q?8yJg729556Ehh05uGi7Z3LJpZjr1rCgQn4NU1lmlLqBdVvEDQj0YPp6tVn7L?=
 =?us-ascii?Q?YnIYXDsjV3XDcC7XAsNXtmFKn1YD96j2EWb7uvbUxhSTuxpDsDJh/eSxDMqE?=
 =?us-ascii?Q?m80ijPtZiCSljsc4eDFunoOzzId5n3RBVQmuh/Xi1w+LeGeUAJ2jnj2v2CRX?=
 =?us-ascii?Q?N+rs8LpLSl7cZknaFnHu661ONU+BDenn+PGffY9Ek9Lp5NCVtLwH7esaRa+e?=
 =?us-ascii?Q?roWAstQs5XM3sJWamN5XY3RUGJlTjba8+AjEpLc15DxG+UcPpiLPUNIxUpl4?=
 =?us-ascii?Q?vKcUxcJLspJ7cf1UQEpxBHyCg1RhHZpdmAWn3GLKdw3ISuI1Ic1ipsmi+elp?=
 =?us-ascii?Q?9Ya+Mr+sh4IsLsHwEn0/qMlaM+xFbalSDDxAnjtXoOSl5BgnDORFeLlKWTSf?=
 =?us-ascii?Q?IVcw0V4LCE6Cjv9bBYFw2CBfiFlPurS9CGnI/K6qTUxoZua2DE1+OjJg1+O9?=
 =?us-ascii?Q?LZiUKZokmM5XRlTmqH7MLYooY6Mn+TOuUhPvJRiKxEFX4GyurlU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8GQwELvW7rYPi/RK3NIAyBH80Pdt80mcIkpXCldDOeBGrzQUkxij0Ky6CDKM?=
 =?us-ascii?Q?JQcMadGgxP3NYB3rMbcBNy/MV0G8kxzP340OGdIFcPffXqd4wjNZXs/DGoEp?=
 =?us-ascii?Q?3CXgBVLZX0Q2ztDUSQ7+1m1n9XLlh+R0jD5BLvhkX7Z2jBRGo7HW1Vj7+DsU?=
 =?us-ascii?Q?ZMsb5KFO+bHpEH4XkoBMB6sU2u8lfass7qcv58uKrH5H+TjMEEb9UaiTfw3i?=
 =?us-ascii?Q?oLQtoz9pziKft3v2c+Nz9Y5PECwgHCSi88TQEjZPPTxQfiGAPJV7EdfgkvzX?=
 =?us-ascii?Q?IKknwwo7q0M+wz4zibY4OtvgjGRKTPr3POU+U1HadX33T1I1u92hSu9pYzWS?=
 =?us-ascii?Q?FMKVAU2+NlD+zXccoXEKKSgJvYLHm5hn8iAgsFBMyhYIORytjdSUbKnvSe9S?=
 =?us-ascii?Q?zS27PDxpJgTPIxcUNX24sNMMQx6N7a5qlAGbR/Mr7DxosM7mJ9I8ZK5dixAR?=
 =?us-ascii?Q?nToa5VCqSxmNAN4REfjX/WavLHZPY7k+94ApfK7KnqnSNmnAIkO2sfjhl5gf?=
 =?us-ascii?Q?dXAYahRv4UPSOYv9U4LpnKHjlRHn2kdmDRMk8/piQXWyXS3IPBXpUdVu2I4A?=
 =?us-ascii?Q?NajjSzXBOv1tjSS2wJaiqIUUQeysMpxU6oReQDZRTbUOp7OJHTYxL7M0hVaB?=
 =?us-ascii?Q?EF8bYdwObWAwey7hKa6XxHHVeiWdwkykoVZh/KHCtVkUvdWsoQ+xXl2ijyn1?=
 =?us-ascii?Q?qireyX4ISTMfTv/khfmM3wHH6mbkk7GOg1PSpwkDp918z63SVk9C+GBs2pvD?=
 =?us-ascii?Q?pvbwUC4ZfFskbyg+I3HbPWSm7x+KSC6ro87AmgrDiIhctXcveEhKIX8PlFZ5?=
 =?us-ascii?Q?1RJaqTv6o2JqdRjwWlv2ro5o3lNLzUOxrk1LRUs6ZflDEzkFXQQm7Bl1/k+k?=
 =?us-ascii?Q?hZ4jqA0SiQZ75jWuDc8T/URPVbOuiENBEUr6JjmS2Wpwr/LxsFGYhokfMaZd?=
 =?us-ascii?Q?QJu1SAZpmxSy+xB6MDxwgJHUK47M9t9joHN0O4MUKXHJhPp3uT2LSv+cVAOV?=
 =?us-ascii?Q?KtoGAM9Zc4/e9rXllhgcT+H27fxFfyqXWTW+zqmZ08jbLepITrQLbABi1dzd?=
 =?us-ascii?Q?UAB9HCOlkLDpDVLJfZG0dp33J2GMCgCivIAgxLfMKRzM3nTEbQEZFZtMi9Vq?=
 =?us-ascii?Q?79n5VJYkUJn3CF+RhD5SMGwVg3aguhVaS8qXonAa1xIVYRTEeTtaHKPHM9wO?=
 =?us-ascii?Q?FQD+8eUtStITtWv5VC1+rOqLAxg0N4soCoyr2MLsgXmSqnXhLnifrsTWNz4?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d421ac61-5313-47b0-7b87-08dd60111437
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 20:21:02.6252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6514

From: Thorsten Blum <thorsten.blum@linux.dev> Sent: Monday, March 10, 2025 =
12:26 PM
>=20
> The union vmpacket_largest_possible_header and several structs have not
> been used for a long time afaict - remove them.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  include/linux/hyperv.h | 47 ------------------------------------------
>  1 file changed, 47 deletions(-)
>=20
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 4179add2864b..bff91788c8a3 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -371,19 +371,6 @@ struct vmtransfer_page_packet_header {
>  	struct vmtransfer_page_range ranges[];
>  } __packed;
>=20
> -struct vmgpadl_packet_header {
> -	struct vmpacket_descriptor d;
> -	u32 gpadl;
> -	u32 reserved;
> -} __packed;
> -
> -struct vmadd_remove_transfer_page_set {
> -	struct vmpacket_descriptor d;
> -	u32 gpadl;
> -	u16 xfer_pageset_id;
> -	u16 reserved;
> -} __packed;
> -
>  /*
>   * This structure defines a range in guest physical space that can be ma=
de to
>   * look virtually contiguous.
> @@ -394,30 +381,6 @@ struct gpa_range {
>  	u64 pfn_array[];
>  };
>=20
> -/*
> - * This is the format for an Establish Gpadl packet, which contains a ha=
ndle by
> - * which this GPADL will be known and a set of GPA ranges associated wit=
h it.
> - * This can be converted to a MDL by the guest OS.  If there are multipl=
e GPA
> - * ranges, then the resulting MDL will be "chained," representing multip=
le VA
> - * ranges.
> - */
> -struct vmestablish_gpadl {
> -	struct vmpacket_descriptor d;
> -	u32 gpadl;
> -	u32 range_cnt;
> -	struct gpa_range range[1];
> -} __packed;
> -
> -/*
> - * This is the format for a Teardown Gpadl packet, which indicates that =
the
> - * GPADL handle in the Establish Gpadl packet will never be referenced a=
gain.
> - */
> -struct vmteardown_gpadl {
> -	struct vmpacket_descriptor d;
> -	u32 gpadl;
> -	u32 reserved;	/* for alignment to a 8-byte boundary */
> -} __packed;
> -
>  /*
>   * This is the format for a GPA-Direct packet, which contains a set of G=
PA
>   * ranges, in addition to commands and/or data.
> @@ -438,16 +401,6 @@ struct vmadditional_data {
>  	unsigned char data[1];
>  } __packed;

It appears to me that struct vmdata_gpa_direct and struct
vmadditional_data are also unused. Did you keep them for
some reason? Or could they also be deleted in this patch?

>=20
> -union vmpacket_largest_possible_header {
> -	struct vmpacket_descriptor simple_hdr;
> -	struct vmtransfer_page_packet_header xfer_page_hdr;
> -	struct vmgpadl_packet_header gpadl_hdr;
> -	struct vmadd_remove_transfer_page_set add_rm_xfer_page_hdr;
> -	struct vmestablish_gpadl establish_gpadl_hdr;
> -	struct vmteardown_gpadl teardown_gpadl_hdr;
> -	struct vmdata_gpa_direct data_gpa_direct_hdr;
> -};
> -
>  #define VMPACKET_DATA_START_ADDRESS(__packet)	\
>  	(void *)(((unsigned char *)__packet) +	\
>  	 ((struct vmpacket_descriptor)__packet)->offset8 * 8)
> --
> 2.48.1
>=20

I can see from "git blame" that these structs originated back
in 2011 when the Hyper-V drivers were still in staging. Going
back as far as the 3.4 kernel, I don't see any references to them.

I don't know anything more about the history, and lacking such
information, I'm certainly OK with deleting them as unnecessary.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

