Return-Path: <linux-hyperv+bounces-1876-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1793D892807
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Mar 2024 01:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBD11F21932
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Mar 2024 00:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CFB365;
	Sat, 30 Mar 2024 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H706wri5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11023019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E98C181;
	Sat, 30 Mar 2024 00:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711757526; cv=fail; b=LFX3LxyQD0FaOnAL7bCMZ2g75FIvh4fF1qWtbJNZfx3+DNcC9MOC0QqTm/+Bfh3obrWX4roY+aerIMBo9rP1zZZ9iQWD2X2/o5IEqMaXK1tHxMNRSCZqmc8pUFpGjZAebXdu3+jEqwpuKAoBbHm7t1PgVo0JJ0lAXVd3WVqJT7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711757526; c=relaxed/simple;
	bh=92SPfIJKxtT5DfQTFANAg552Oktfg6hkrKhCaUDhJOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bozvMU5S0JWpYxRFHlw8ZwmttHf7QLA8MBzcvIrsso6bUu3c+tlPzaisR4KYwYo8MlbdH2bd7c0Q8f0kui2JZ1rvlI7uqYn6dy7jX4VM0ag6+GmY7zGgLtrxCuXobn+jYRrWDpbmhIOUAGRNR/WaSgOoYMLKesEAYfFg+Dm2meg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=H706wri5; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2iqa6yWdW96idrBzvxI4h/xNSL5EkG9sDw62F1iOjJMGaJKEqtgFlIKrmcRgb7c4X6OJ2nldkCSDRYWtxUoBhrgnzvGPJ2yPXE9OcFJDYFEO2BnRvERbPBeKIMLwLBvPgIGIn1GdBgArEOLXgGlra88DhIH231rDjAbcABSoCVHrqLdR1FpQOT5UH9YpU3bxnNEnfnXwWJ8wdKCXgTsJjchOR6+L8EX1xGbll058k8SIm0kIhgT5TWMkC/lqmKgw/2Es16rXP8Obxl21OTG5lJ4lVI4/N+WlvLyW1fNLmkMmT84lX+wiVuFFqzX7ydFIJ7L0uvXf2vHc6MYel2btg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sngLlg8NjBQ7ydog24HB/PWNDek39lAbXQmF+7Cc6ys=;
 b=ZYmbhith4I+CFZ7eZjRO8gsTv4A1yMUYUvXMUqRWkpDyu++sYTDJc+XAF+9xSUb4dYj63mnjO8W3rdOrCYxJPKX68vYWil1Io115skGIcldEb6TMO9BssQWsXgxZSxBnBTByxSxIHRZnjxhvOa0VQaaP+TAfxywj+oV1Mfb+F3NE9PcJ8p0xYOn3r+uWWlh7EfMjOdVduFnjAqu4u1OGGen+fFBy+8Qxwqc/qLiB0hsNxUysUhkvPO4XdJjgAeo/fXWLHtD7OXXMIxFa6u9jQM0Pw9IGEqU2I/LB7XlNfACC2zLFlLvr40DsjFRHm9TAPTO310wVlv1QPXeKq2saqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sngLlg8NjBQ7ydog24HB/PWNDek39lAbXQmF+7Cc6ys=;
 b=H706wri5KZ3Bxwiw9xKyn/Bvf25z9EFDWJ4kQADqBOxh86AugaMQNZOlP2WkAj6kvMPUIulnHhYmd4WXAneuLmh20G+b+Pnc1q3+N1o9/XoABmswQ2KP5Tucne84wxJPcPuUy3iEignKEZJhiNJzv+MvBpxAtHx1ZIO8kxNtA4Q=
Received: from CY5PR21MB3759.namprd21.prod.outlook.com (2603:10b6:930:c::10)
 by CH2PR21MB1509.namprd21.prod.outlook.com (2603:10b6:610:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.0; Sat, 30 Mar
 2024 00:12:00 +0000
Received: from CY5PR21MB3759.namprd21.prod.outlook.com
 ([fe80::1c76:5d37:cef1:f135]) by CY5PR21MB3759.namprd21.prod.outlook.com
 ([fe80::1c76:5d37:cef1:f135%5]) with mapi id 15.20.7452.001; Sat, 30 Mar 2024
 00:12:00 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: stephen <stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>,
	Paul Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org"
	<leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net] net: mana: Fix Rx DMA datasize and skb_over_panic
Thread-Topic: [PATCH net] net: mana: Fix Rx DMA datasize and skb_over_panic
Thread-Index: AQHagiFTbDDISYHohEGBGDLC4qicc7FPUWYQ
Date: Sat, 30 Mar 2024 00:12:00 +0000
Message-ID:
 <CY5PR21MB375904FD3437BA610E6BDBD1BF392@CY5PR21MB3759.namprd21.prod.outlook.com>
References: <1711748213-30517-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1711748213-30517-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=59ee9ed2-1d2f-476e-81a2-fdbc522a1f8e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-29T22:45:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR21MB3759:EE_|CH2PR21MB1509:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 78t04tPeAiIH8qy0QFz5N7v2Xsnhe3pj5jFkJbPHhwCJOHsBaSpWJ4TT9I24HakOElOqoLTMH9BSOcd7/7z3iNk6BGSSu4ZZpDaY1rKd+eJqQ7SKjCb/WyY4qkdyRmWBD7/PpiGtnsNHE2agjJycjJMhwYsmcv8ZwdETvaT7+/VffRhWkui94LoMj7QyfXxKhwr2+hPGDg2FkTdunZ4BCoQ3lhZvI2Z556p2OwyoaIEEfmJNE3rVk1Z89S7av6Hz5ocIgNDntW+kACrWJyTTnidrtqSudjuDErFzRIQZjGSQyEh5SLi7eehwMmXWiyJTsoQbErnYR0pS97+fkn+WpGdAFkzdKwrHfIAQKFxDaX45LLOlxYJRTt13YhRodULcsxI9enZM82HYCaUotRTDioUVn+9NFRM9AtDazB44Q18BuYjAkF4EawWlmUU896PJXpBy8fI6ejMDlfQspwnfPZSUtt3TUMfEdTizbYB6UWCoaclcOB1Z9czKtqA+NZ+3SDaRTLwItRaw5O0QHjJIXgQoCSBeX6zST7Nu+5W7n6F8iBz8N5k04jBvYV+GFQ/COnD2aDUoZQPU5tXUAKH1IAtvSCc+AL5Y3zU8sK/iflD8LS6BQNDaqKBS8+7W0H1mj/0vFu27qfTqHBXYF+jBYf8/6vNibJoIhCLjNbHQQP4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR21MB3759.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Vc1rtwnwY2Ya1Ff4AYRnFLXccQQ8to5bxYkH5g8QVoI5YbBSTIP2FvUTuSZP?=
 =?us-ascii?Q?r2DrE3VSaJQ5plKVS9DJT6wQCGPRoTjLzXHg5RK0/fxC1Nl5iNsQ8mZ76xQP?=
 =?us-ascii?Q?yjOFv/9Ebr5Hi2ursitKz+AorrxZRTyy2DcHEOaWf1KlKnCv8U7thrAVxb8I?=
 =?us-ascii?Q?V5Q76ihRP2jEGSoU3w3NvMQnZzLmBagiINM3G7GYyKjOQhgS3bvcCowad5Z0?=
 =?us-ascii?Q?A6FH+/EMlEHf3BOEewTzR2mkuMe6qOduc3W64+/34xXNsNd02T8jaT0cnIg+?=
 =?us-ascii?Q?dSFXfZN9ryroOsmU/gLcG90LfbOCu2ySOgyAuZlUF0qUXok+w4Kvdh8mMjve?=
 =?us-ascii?Q?ZEb0/9Jwt4ITSl6yzYDNHLJaHaLx3BRoVjk2tFT+6paTwymv4VqBPIjSNc8L?=
 =?us-ascii?Q?sBLnEXnlVGpOWdRZBftuXNB0idTfundUsEs5e65p4FCTsYMZfTv1nJ82WX9e?=
 =?us-ascii?Q?Z/bJzqFbx0g2WmZSqd6AqPVXo34qyWDLPjeQgRa0TaDW8lpaMvWaS4zKFBmD?=
 =?us-ascii?Q?//QCe3hFBrGrXnLrAEIKf2dmp9T/7LJ+jgv9JW9jDxI4Zc4R2sfnqZ97keP6?=
 =?us-ascii?Q?GDfwqg8oa6p6NSEqRsKyVJ85u9+xnt5ykKZn+twZ2e67omXNjaThm/ewZ9WB?=
 =?us-ascii?Q?j12u6rnJtbONsAR1uyHgynhnEUD5BazcRZsbmNqvcXUMDsd68v+XLjT27wyl?=
 =?us-ascii?Q?N5lMx7dvY4JDTd94ukzRwAytc30/0VCh9FfI3HruO6gxhtemAHZ9NE5HU3BL?=
 =?us-ascii?Q?Ct6eG2I4+iiwlKpgh9kevHplk/OBTeYoAbblSg7UyiHRg6yJxxL7FfA2cdVa?=
 =?us-ascii?Q?Xu5dYSuU42GmO48hxJ5lCVzkGH0BafEUKRfNnik7sIxHNDbp3OS6RBoAXrlw?=
 =?us-ascii?Q?yS9rlHD2jmuQsa2MH/kOfHM8VUduYFsYvtkXhn89uBhsI5dIrw9Tb4jMG9UX?=
 =?us-ascii?Q?IRHNNYpIdtyWjG74M7XXJebHr/x83Pg/q7o2zg8HGQbnPr9t+kTCUGtoVWxB?=
 =?us-ascii?Q?zZxDkdch5mJhMGwyqu6Mprb4Qii1thLWDAFSEGRjdwkjJVf/BS5H61kGq6n8?=
 =?us-ascii?Q?RVsKCCvo9dV/AkRtL5Bbi8u9U7R3zK18LKZFKvY4nToyDFC3RSk4u/d2xdba?=
 =?us-ascii?Q?MmG+rH3uBl0wOGz4t9xrozJrfhYx3WlrFQ/cEFpnKEscbwpQD4ieg3QBjh9M?=
 =?us-ascii?Q?mFBoT097Ive6ZSTT4XXAkSIfGN56lComM8V3DcGbJhXUK5zh9iwZB9POVI11?=
 =?us-ascii?Q?+rXmMO4E9xpDjSqLyi0CJDEJRFb20BlePu/rT5XKwqATZzjcVDpRSeaPG8L5?=
 =?us-ascii?Q?ZNLcu3QnxpgMSYjaTe3C86s3B5ZqS4bZxCx1HOwURxC8qUMg7wVYAeJLva/B?=
 =?us-ascii?Q?TKYGkKhiQrVnzu3BvLlmn/0H75Ud43Ezj9/gCrbnx6T5pUvU5ldBtJ1qjeMU?=
 =?us-ascii?Q?g03qP5ANWZ0s1KQFJrf2ovAJn0qbKrVSd/BUOHbHWczQ8B1RmkSxRHQI0ikf?=
 =?us-ascii?Q?Yp+Wg37y9RcmKx3Aw27Gcww+TtXOfCA7dvQRj6uGuiDvS0YpCGSt0fhdc6Av?=
 =?us-ascii?Q?VURr6W4dT1ngXQzA5aZNjd2TvjxR8WPCfTNi9cW0VyDhRQT3MLgkRqpkkfS5?=
 =?us-ascii?Q?EZdrsyk2sxsHlWE/pXpeOLA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR21MB3759.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b685f989-80e9-4886-034d-08dc504e050a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2024 00:12:00.1812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Sk7dowv76SJFdpuaM3A5TvJZ5EvpwjeT1KF3NbYpnm024sjKOBjZ4oXDHbl3m3eV1nI6S4/I5eSs6vyOFBllg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1509

> From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang Zhang
> Sent: Friday, March 29, 2024 2:37 PM
> [...]
> mana_get_rxbuf_cfg() aligns the RX buffer's DMA datasize to be
> multiple of 64. So a packet slightly bigger than mtu+14, say 1536,
> can be received and cause skb_over_panic.
>=20
> Sample dmesg:
> [ 5325.237162] skbuff: skb_over_panic: text:ffffffffc043277a len:1536
> put:1536 head:ff1100018b517000 data:ff1100018b517100 tail:0x700
> end:0x6ea dev:<NULL>
> [ 5325.243689] ------------[ cut here ]------------
> [ 5325.245748] kernel BUG at net/core/skbuff.c:192!
> [ 5325.247838] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [ 5325.258374] RIP: 0010:skb_panic+0x4f/0x60
> [ 5325.302941] Call Trace:
> [ 5325.304389]  <IRQ>
> [ 5325.315794]  ? skb_panic+0x4f/0x60
> [ 5325.317457]  ? asm_exc_invalid_op+0x1f/0x30
> [ 5325.319490]  ? skb_panic+0x4f/0x60
> [ 5325.321161]  skb_put+0x4e/0x50
> [ 5325.322670]  mana_poll+0x6fa/0xb50 [mana]
> [ 5325.324578]  __napi_poll+0x33/0x1e0
> [ 5325.326328]  net_rx_action+0x12e/0x280
>=20
> As discussed internally, this alignment is not necessary. To fix
> this bug, remove it from the code. So oversized packets will be
> marked as CQE_RX_TRUNCATED by NIC, and dropped.
>=20
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network
> Adapter (MANA)")

While the unnecessary alignment indeed first appeared in ca9c54d2d6a5
(Apr 2021), ca9c54d2d6a5 didn't cause any crash because the only
supported MTU size was 1500, and the RX buffer was a page (which is
big enough to hold an incoming packet of a size up to 1536 bytes), and
mana_rx_skb() created a big skb of 1 page (which is big enough to
hold the incoming packet); the only issue with ca9c54d2d6a5 was that
an incoming packet of 1515~1536 bytes (if such a packet was ever
received by the NIC) was still properly delivered to the upper layer
network stack, while ideally such a packet should be dropped by the
NIC driver as we would have received CQE_RX_TRUNCATED if
ca9c54d2d6a5 hadn't done the unnecessary alignment.

So,  my understanding is that ca9c54d2d6a5 is imperfect
but it doesn't really cause any real issue.

It looks like the real issue started in the commit (Apr 12 14:16:02 2023)
2fbbd712baf1 ("net: mana: Enable RX path to handle various MTU sizes")
which introduces "rxq->alloc_size", which I think can be
smaller than rxq->datasize, and  is used in  mana_poll() --> ... ->
mana_build_skb(), which I think causes the crash because
the size of the allocated skb may not be able to hold a big
incoming packet.

Later, the commit (Apr 12 14:16:03 2023)
80f6215b450e ("net: mana: Add support for jumbo frame")
does code refactoring and introduces mana_get_rxbuf_cfg().

I suggest the Fixes tag should be updated to:
Fixes: 2fbbd712baf1 ("net: mana: Enable RX path to handle various MTU sizes=
")
, because if we used "Fixes: ca9c54d2d6a5", the distro vendors
would ask us: does this fix need to be backported to old kernels
that don't have 2fbbd712baf1? The fix can't apply cleanly there
and is not really needed there. The stable tree maintainers would
ask the same question.

>  drivers/net/ethernet/microsoft/mana/mana_en.c | 2 +-
>  include/net/mana/mana.h                       | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 59287c6e6cee..d8af5e7e15b4 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -601,7 +601,7 @@ static void mana_get_rxbuf_cfg(int mtu, u32
> *datasize, u32 *alloc_size,
>=20
>  	*alloc_size =3D mtu + MANA_RXBUF_PAD + *headroom;
>=20
> -	*datasize =3D ALIGN(mtu + ETH_HLEN, MANA_RX_DATA_ALIGN);
> +	*datasize =3D mtu + ETH_HLEN;
>  }
>=20

I suggest the Fixes tag should be updated. Otherwise the fix
looks good to me.

Reviewed-by: Dexuan Cui <decui@microsoft.com>

