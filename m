Return-Path: <linux-hyperv+bounces-3721-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C27A15F49
	for <lists+linux-hyperv@lfdr.de>; Sun, 19 Jan 2025 00:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED9C7A2378
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Jan 2025 23:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743F319F128;
	Sat, 18 Jan 2025 23:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hJ63mRp9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2080.outbound.protection.outlook.com [40.92.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B623C9;
	Sat, 18 Jan 2025 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737243318; cv=fail; b=r9uldQaL5hyudXwRT7HamvlbCNnPiJZxBbSln9gF5hMLjJ/11BWmc5JA/bkYb3+RBhhcL4DOub/NbyY9itJ3LLmfzl1lHiBGUz7+sV2NDVfvHpQQMfhW2nIWAfQMPFtmOyydVDV3kOyBGj+ZDd7Bl5lbTBBeYDuX9paVC2p4FPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737243318; c=relaxed/simple;
	bh=rY0xSkAp6G/Gu7hd27gx9b/b31/B4hUU8jnLjTr2iI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g0RaTdE5+3u6wiHbEM0wnwYaI5wNZ8Jaxl36hv/iyBQDfhMadDfQf/bF1ndKfp4E6AI4H9SIgiy/Lhv/Zgr38AHlCTSuPzUlEriy9ttAoMEIFBF1mOjPxCfxERSucrb88pghvlSp8yxbpaZAm9Ok7IWrj9gmcUXl0DrfWXju+tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hJ63mRp9; arc=fail smtp.client-ip=40.92.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYCFu8gyTBv/rdFTmX+eazWDw7hWYpVraEdXwU6Y/FTB2yYUV/Hzpxxx5plK50g6vtCwT9h5xp/Y7Fe+SOfipcvVRHX3JwT9oFe6CxGynWoXHp+INk+l1EesvP/WiNTUT5arnQoJjqQVladVY6+NjzXr6d7KgiowpkGUAWsjCz378vAMn1HPL6lPttRMOKgvk8zaVAhxIpqCo5noDin8p0x+8G4GTJIpL+/3Xjzcvzso2vie67Ujv3tftajpyM3ZYcy/fQvLqnlZTA0lzMbr9L666M2M+vb2NlDfJXBwAr+GDt7PhrZjkchJLIuCuP3QDD7hqgpvvIJHOOXLcDAgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XuC5K9kX2UchU2mIu5aMu52kxpplySe8oB5epJxEDg=;
 b=i0rjmrSeAFMWFua0uMZ9SdF2HqKsFFIfdCV/SHr1LvR9l43WteN52CdtFidT/3POv5jYTCQw2bBzkaXMq/4EBIu3D9dSE8OtcjF38MAvdsFq8Z9qUL/EOMPJ8TOISVimsx7sKs8yr+T+eJosNVwy6dLdWzyGXTXQ2Sva3IKdpWBwStbd+njz4pZdG//HU/0+iPSQuyI3eJNOGrZkbinLhh2gSw19mFx2DTNmMIFcUxE9wmjVDWQBNDkq4Myhcx/CSGJCqrRVL/aGjxeMPq2q018/OrkfS+ol71zw/CbEKeotfCmAuYtqUCs0SyIQ760iQtEehx7tu3LC9WtqsYREGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XuC5K9kX2UchU2mIu5aMu52kxpplySe8oB5epJxEDg=;
 b=hJ63mRp9FYk/gQjRPhEhOBLK8AsTOsUJEpQTgqnKgdJNY+tSbaMV7cSnKyMc563cAxlsjcmvgMK6xfHUIhgR73GrNEB573NNO4luD1U6N++auKmRbqbrfnPn8pcp4mBX4niUcB+7lHl7lBzoIy1FC2rugA0pO4Q6sTZdKTVoSVpxzfKtAJMO8ZfVyYy0COP5j7JKu7Eojr2Oah3JNjrFp+8NlHxiV5t2z6sKpYhGUBmXjTj4+2yLQd90rBqYLvsl4xzFwF5R2JtnnT4vJ9jaapAWqMxjnTdXjkqnkPQC1IbHbqp8Y+u6QiINa/3ONhUJH5gM/mHUByV1RcZUNgvRug==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SJ2PR02MB9824.namprd02.prod.outlook.com (2603:10b6:a03:537::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Sat, 18 Jan
 2025 23:35:11 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8356.017; Sat, 18 Jan 2025
 23:35:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, James Bottomley <JBottomley@Odin.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>, "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Set correct data length for sending SCSI
 command without payload
Thread-Topic: [PATCH] scsi: storvsc: Set correct data length for sending SCSI
 command without payload
Thread-Index: AQHbaHLRzkYQZ+EqJE6PNc5JdE6XVLMdMCTw
Date: Sat, 18 Jan 2025 23:35:10 +0000
Message-ID:
 <BN7PR02MB41487C2C9BA6B963758E722AD4E52@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <1737071998-4566-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1737071998-4566-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SJ2PR02MB9824:EE_
x-ms-office365-filtering-correlation-id: fe30e40f-217f-4a88-4adf-08dd3818bfc1
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|15080799006|19110799003|8060799006|461199028|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XK0aW9Q1BdRzBqB9P57+p0ZRhq1UrkTEmHV4E4OunDdJoD7eqE9zJrfm5CjO?=
 =?us-ascii?Q?WOXjwYA9KGjCj7/FHxGq9+i8S6zln94FTvgDx1BePwMK6abvs260EZAvnuCs?=
 =?us-ascii?Q?S0MmAYlR3G3MbX4lU3tSgZxYndhtNOfdrC/GrGLuz13S6aXnTkIsbOhboqsT?=
 =?us-ascii?Q?S6oXooq49NgSyyMq1ctnTDp5/VkgPN/xVL69/mthtFJ+Ju1pjg5Hf5nLIBML?=
 =?us-ascii?Q?fdCCz6jbaNtqaCsSEmjgvRpsaz+LVARbEVc39KiNBkcNADnKRWEOebOuxuX3?=
 =?us-ascii?Q?UncOBMGb1mKRqMcijJlaF3iU8oSjdLSMcx7KvgbXXyV6hwJyzI87rDlP4h1A?=
 =?us-ascii?Q?NydhZiwtoRrkJV9kkwFUiszszlp+MtAuz8NXQNva222FDDvTmLPRXg9SHk1V?=
 =?us-ascii?Q?SPI7EMjCT3+EpnxYzSDYX4kExkJT+jeCy11Lx/jia05Xy2HluxuM/fYaQj86?=
 =?us-ascii?Q?OWcP0+YBsgTLtvtCvdGvt9EgMg+WhDpwWSOqso45YTzLejNQcaLuJMPDBTqE?=
 =?us-ascii?Q?Osw5yjyAu8puVzzXm2LMqwv4PpfWD0XfoLNRahQzY82KeTnpedoOrjJqddbQ?=
 =?us-ascii?Q?jgnmOaLkzx/HSBdgR6t2168UCObwlIHdKTy5mPWmRgxy2EkyU29x6zXL2fiB?=
 =?us-ascii?Q?SgKF2xY3+iamqY8slv5DtfDa7nU7rioMVWn/w6Yh4iKCSEFpaHeJN/cXUs5Z?=
 =?us-ascii?Q?fY9fy3A38UKkwynZ/ZEBzpaNBflgBNAfAOmDY8Q7oLwXKiAeGV3y3gyDfsEc?=
 =?us-ascii?Q?AldxnJZvYg/C9U9wLMxf2+JsQ8RuQXICmU3I6cPNJVNpEHoXaRp7oKKuhx7Q?=
 =?us-ascii?Q?lmRQxrsakTJ0zumi6iybvwtoNTePr33PVQp4OMjueli7Ru2tFSsUjrbakNw1?=
 =?us-ascii?Q?t8NzUQ9HJAQ5tUXQ1t5bAqoE+QYu3oaeQgFIxz+BrPTsRBXRlKK3p8lfy9JJ?=
 =?us-ascii?Q?9k21KYp4yOjIByqjyC3UcPUocQervjXa9yAqd18y+/oITAtZqfRNzWqp4hdq?=
 =?us-ascii?Q?OGj6NJfvoJojNYHC4XzmJKjWdPgGVCLLSpHQsayN57tUecY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?l1iEt3JJlj4/8q7AFFoPXdfa4yWNwLPt6gpr0kR2rnSXcMlE7jfwTOKc8ag7?=
 =?us-ascii?Q?HkTi9ZHmjixfp6ZAAYqoqRaiVN4cPdTXUjt5hWgGPX0FW/zgoPV3nICK7Bln?=
 =?us-ascii?Q?2sIrdRwJRpS2Q82z1FNgmU8G1AlRv9k5pktcFV5fys5z0UVkr9kQtYR9W561?=
 =?us-ascii?Q?ktltTQfkgyYnHKWew+1zKGkvCyeTgQfNwignOwtOpl6muUvGAz0OxaqzTzmo?=
 =?us-ascii?Q?9zyf5lebBkLWbyKN+vJdBgrxFvnAuERWeBejAXdXa5KkONMYqk7UXnBc1G8y?=
 =?us-ascii?Q?I+hXWS5CZdOEjZdL/glTe/uGBIf70P1Bg98pOkMyRHd1n4hwMufpZStFCYlA?=
 =?us-ascii?Q?EYQLVXHAemHC7aFVih0BODR7c40tylsAaD/CkiGHyRKYFI+xEWIdM75sQtqj?=
 =?us-ascii?Q?tQw8Sqr0I7WWwsIvg5m41ux4wIcU1y3FbukzyNTvQ6UKOQr1pmasZYeNbHhE?=
 =?us-ascii?Q?Ox9GtdBzdBDO2YV3RhayyJANjrGiEYxJJF1vKbSyvoBwtihZxmKT3kKmP594?=
 =?us-ascii?Q?OTYxUEyGA3eU+eS2UCIajbAg930r/xfI9empIXVDwhJHJUfwf3yPnSpRnvtt?=
 =?us-ascii?Q?cVRUSyVw8Pdp0xqx9sVoysFIyZaGnV9uoVU+CQ0ItRWV5wTqM8428suj/a9K?=
 =?us-ascii?Q?NlixwOyImFarA7IQV8nliWEQe/470FiYoFZANWZUZR5INZj9bIhITETotzs+?=
 =?us-ascii?Q?Th+hNbGhsve6ocEucuHzFszebLn49OuvLTYuTkexaELAz7w4oVWywYblOKpK?=
 =?us-ascii?Q?5mplU2Do3n9MHk/qrdIkOshx0b54ZdvuzV3tk+oMSZLaR4Wl++IHnQo4RhQB?=
 =?us-ascii?Q?y3L7vWGiHMd/W60kkaQiyGp/1lBeovTL7v7i3c/mm6/1L0YGLscK9I7RSoDv?=
 =?us-ascii?Q?d6UdLRtuN5PLVU0pezaBWebf/hwL0csbt+GFsO7ZQgC00s+uGRReA9HuOnW3?=
 =?us-ascii?Q?IBY8c60/1urSbGZWrwT6h8G6ZUN4mDsFWxZWsikc2v5U2AdPro2tYS/K5TdH?=
 =?us-ascii?Q?BfKUcm6S9+zBI3XB2yDPbE1CbU4wWr9MMxmFMn0WWgyF3mYBd7VyrYJZfMs0?=
 =?us-ascii?Q?tvMjyq6UZJjrHpd1v5O2j/oEZECotzK60guvroE94v8lT+MLlPzqncd8g1qP?=
 =?us-ascii?Q?pRvknu0TesX5MO0zB1NG471gQOpUEQrhyBj+Ilr5n7JiXWNh8REAaRapjDb9?=
 =?us-ascii?Q?oiqCavek0nDXbUjSz4/KsaM4JZLiOwRXzz58LH5NcuxFxZHYkVk07/e6BL8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe30e40f-217f-4a88-4adf-08dd3818bfc1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2025 23:35:10.3403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9824

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>Sent: Thursday, Ja=
nuary 16, 2025 4:00 PM
>=20
> In StorVSC, payload->range.len is used to indicate if this SCSI command
> carries payload. This data is allocated as part of the private driver
> data by the upper layer and may get passed to lower driver uninitialized.

I had always thought the private driver data *is* initialized to zero by th=
e
upper layer. Indeed, scsi_queue_rq() calls scsi_prepare_cmd(), which
zeros the private driver data as long as the driver does not specify a
custom function to do the initialization (and storvsc does not).  So
I'm curious -- what's the execution path where this initialization doesn't
happen?

Michael

>=20
> If a SCSI command doesn't carry payload, the driver may use this value as
> is for communicating with host, resulting in possible corruption.
>=20
> Fix this by always initializing this value.
>=20
> Fixes: be0cf6ca301c ("scsi: storvsc: Set the tablesize based on the infor=
mation given by
> the host")
> Cc: stable@kernel.org
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 7ceb982040a5..ca5e5c0aeabf 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1789,6 +1789,7 @@ static int storvsc_queuecommand(struct Scsi_Host *h=
ost,
> struct scsi_cmnd *scmnd)
>=20
>  	length =3D scsi_bufflen(scmnd);
>  	payload =3D (struct vmbus_packet_mpb_array *)&cmd_request->mpb;
> +	payload->range.len =3D 0;
>  	payload_sz =3D 0;
>=20
>  	if (scsi_sg_count(scmnd)) {
> --
> 2.43.0
>=20


