Return-Path: <linux-hyperv+bounces-3399-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C74D9E5B6B
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Dec 2024 17:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6445280E28
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Dec 2024 16:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C08222572;
	Thu,  5 Dec 2024 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ceoYBll5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012011.outbound.protection.outlook.com [52.103.14.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899BF21D59F;
	Thu,  5 Dec 2024 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416208; cv=fail; b=lE+Rn2iVKXR2dPJSxjfMM0nHapBwMJIoHWYZgGFCGIlLPrse/CVwdhhtnFB1F3Cly4x7nXlCyEYkhPq43KI1rhq3CrQyTYJBsDnt3PlqLdINhx2Cs6OWbCLSYT7H89NG9lpyeuZbQ3cZigG9M+82/kNqL/aj758OEolE1iG/jHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416208; c=relaxed/simple;
	bh=qcH2Ud6c4RfLIgEX4R1+5BrUlV7rsPB/BIQDidZ4Nso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A50fg3YZTY6jKelBd5hY2twLmY4J+1+UO7+up2VK3E6OCkgbEAgC3uzrPsakSHw1wwXbamTvZwhlhV2umHbsIVvkjf4I2QZAGUUsxaZFg0CGBeVUpuaNnLeI2kjQisu10Y0iCjVvesJk/24pLmlnObRmeCO6apVRNIo++dhDjUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ceoYBll5; arc=fail smtp.client-ip=52.103.14.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiLAYMqrGpe6miu6kxE3AOlxaJxbXNw4FTEyqZUx3Wn8wm+5aiHnyNyfg/mYGTFa6bp+UTmEtrVNZ83OpW7FBw04pzuiF8izfjtayKJ+RBkhOTWWRykcBsrxxmZQE6IkVkDnlGZNpOBIvQvWZapjziI13XJymPBfI4hIA7FzsmfgylgWFBxMKgADqpUkSkGx5TiwF6OHXt2dtBO7aiow3LD22VWuPAp883x8zdDGqG6a39TgOe5EG+26NiGIub3wxQE7kiGgmTL1zE+ifUtjxDKkCXPtqRrt1GkH21J7dPOJX9H/diblbV404HtH3zxQOVaqYBy89E2OQIa8h7h/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwsROMbgtiTSHVsDfm0jbQ7MY5l5aJX4lwXTTwi3WXU=;
 b=tjwTrCb16uVBf8AlmYKHcNANubH6Js7g4LTbNUknBl/gmSaOPmqZUQ5i3QSZ9H1pGrPIZjVGb0M/zp+FjskVNlCeWPsfe1PP+drAQEclmt4845r61H7v4PDysbCPpfl1Ru205w9koU/ZzdCK1v9FYOJVYS6gN/eREIJxdha97F6PtDGnQ1kd+cVJPqO5CwFenjcn+CApuxzWFbXpCoxzWCbVDBxObVz6xqOgrKxB6WGLQXLyzM/erkLdS6H+AGoxY++wB8K9FIau1aTpfdCG6sGlxlxnudbd/0qu5cLZh4Vrkn5/S6Kq+SJr5RDh9AHVOjeL8EU3Y/GTuKU7RuY0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwsROMbgtiTSHVsDfm0jbQ7MY5l5aJX4lwXTTwi3WXU=;
 b=ceoYBll5r5ILT9+YJPPIuHOlfcUNfiRjcF+PuyjUZ4NnonM8J8QFHKRL02iNAs3ilOUyUY22J8k1dWahIyUXKvvtEVL3e8bhOam1oFabGmPRcZtnfCE+KE3ruUBPw3RtSePMOG1HHXGdNVBH/Yg1sHm6GSqHbSxZ8o0DtPdLpoacS3IEg72cDshtA4cAcnUsTUw1AMCrI85/EswSkJBZPwkvBKyptPl2ghFtKHK41uO++d1kSgmLAFkWef28uemKKg4XregivcLGClkdDbxmRNKgoGkwiFVyYU7HWlPUpj8NeE6bHd7N17qdb+03BOUlYdMXSyl8n8+Y9EjJOOI3oA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7443.namprd02.prod.outlook.com (2603:10b6:303:66::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 16:30:02 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%7]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 16:30:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Starks
	<jostarks@microsoft.com>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, Easwar Hariharan
	<eahariha@linux.microsoft.com>, Saurabh Singh Sengar
	<ssengar@linux.microsoft.com>
Subject: RE: [PATCH v3 1/2] Drivers: hv: vmbus: Wait for boot-time offers
 during boot and resume
Thread-Topic: [PATCH v3 1/2] Drivers: hv: vmbus: Wait for boot-time offers
 during boot and resume
Thread-Index: AQHbNaigDD//TIh0nkyr/61pVGNAJrLX+SWw
Date: Thu, 5 Dec 2024 16:30:01 +0000
Message-ID:
 <SN6PR02MB4157091021133B871D840A9FD4302@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241113084700.2940-1-namjain@linux.microsoft.com>
 <20241113084700.2940-2-namjain@linux.microsoft.com>
In-Reply-To: <20241113084700.2940-2-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7443:EE_
x-ms-office365-filtering-correlation-id: b997199e-5bcd-4179-06d2-08dd154a1160
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|8062599003|19110799003|461199028|15080799006|440099028|3412199025|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IRTZIzdQn7nPduIiDJRMOOFCodo0E8f+Hsc7vgJxX4O8tY4kgKtid5WXS8jp?=
 =?us-ascii?Q?/NGL2IzA0MHr+h0O4yN/HS1b+isvJJKKv3KUyYUyX7/JdytSOopB7Xj/AlBq?=
 =?us-ascii?Q?VwJRUfoTt7p/nn+u1hRZGJRzxi1Ih9TNdn8zazRS5S0+9KkbeFo5RzGKeFtW?=
 =?us-ascii?Q?i07IfipwGDX1GHOCiVN1GjbX/+qzSaW3fkoLgavF4+MpVjDF+P/zwuV3UchB?=
 =?us-ascii?Q?aEs3MCPHAlSaXy2JIFABkLYPStjJyMDFwQDBvxBpDUDaekGhdDyb2uo6/BKr?=
 =?us-ascii?Q?u7xIdgqFufz9ZFYYcOCBhgctp0MVN95sM5Z3npddj9ta7Dc5BNFR8t7UEWr6?=
 =?us-ascii?Q?eI9YGpmxPE8in/nX6Kzqz/8PwNU7pc/KcVUZ1QKuFQEYTaOLihAGh4vFrlWh?=
 =?us-ascii?Q?RALH1cQrZBD5hltvHTBxzHXL2VQn7bGAImqoo+69PrFnr3wdpkihImU84b2M?=
 =?us-ascii?Q?/wFtlykT+ebxu8+mVA7jbECdLLWCkW4V4AFHk680qC8qzutED2D5LYiG+j1v?=
 =?us-ascii?Q?rvzg3Bxxa5bT447wetiVSHtETmFHp5j57FTFk3mK9ZhV9UcblbWrzd/mTlqp?=
 =?us-ascii?Q?0mFGvToRGfRbv+ENqdgTBMhjSvryav+N58nZFn4lr+GL9RlA3aktA9Tsh3+B?=
 =?us-ascii?Q?dlibCpxhiU9w2tdfUVwFLyPLz9C3q6yuwkPO/ilLeyuutpIaVK2sb5sE53gE?=
 =?us-ascii?Q?dzJjvQ0M09t4Ens+EKGqWipZd5KliqDFbtIcD9/d8Z0KRyvR8HCcmMekf8RI?=
 =?us-ascii?Q?dtOb1ASAWzfihQ402enx46idb9xEN92rSjM6A3PSNdRb0Bp/UfSpdlH3oyFG?=
 =?us-ascii?Q?7PB4EwEswNwP6Kep3JZwmQluopWXBMXD+lY4h86lfCWsCciP+3e3JkIQ0aNf?=
 =?us-ascii?Q?+ehZ4Hx1b6XMbblR3KKsUmFL5MKGmgD4HdHxiZfrXw/wqIfzmdzQ7Tm82rIe?=
 =?us-ascii?Q?LyTMMcJs9xUew/0IyC4yx+w/afDZ8gGMExJDbgMASDolL6dDAPtR7M5rfv66?=
 =?us-ascii?Q?bfsM08LlWZGai9pfkClc06EiJA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0bs4qva7SV1Rs81bxC9J8+IOnHMjjETgHt4m7Nu6JTuAyc2v7t+C7leCuDEq?=
 =?us-ascii?Q?e0h+ey/64uIlfVdeeHUWJ9u0rEFKWmje7v0U7UP+HmLrKHu5tHPqyYJe9G9I?=
 =?us-ascii?Q?fN+k+RJCr/mhlfllwHzo1Li33ED3NJVDPcgt/XkIVzopALyiDtE1izN6j1Fs?=
 =?us-ascii?Q?v4I1bX1D7I3crMl/wCNdYRfJyYuHGzmhemXqUOOOXfGMzmdcfo8By8H9ykeC?=
 =?us-ascii?Q?QABF+RJ2/d9c0psP/+TGBftsSsFpLfDS+D7R8C5Al0TAfb3g2ZjIWP5R0fH0?=
 =?us-ascii?Q?5FzytLWeQexkz1IjAU253EgZl1CgabEsVnPuU1rD1+7bX6yWLp9u1O3v51Nz?=
 =?us-ascii?Q?mjPbG7kbvYkacpOqaXe+vTh1eUUYfzZQyggAhvuYjDS8NLqm9fj4hnmhkE/A?=
 =?us-ascii?Q?AbVi7nvxWbXWC3Fe0p2pJTQQYT3FmZc/lZI6YgSflE1hv0r1EPcw8vkdp2aI?=
 =?us-ascii?Q?YPUywj1RRqQz3QxM4EDMj4cNbni5PaD5m21eNiFi0fWdsfRf1uHXZ+y5Q5jK?=
 =?us-ascii?Q?e2UPh7Adg4JMANyTbjY5cFfxsaNxTA5tfAOn7n9kz9qnpPvLGwJnEKWhmBYb?=
 =?us-ascii?Q?MbvphJ/5zWKqbGvA+g+KwPvf+05FGb3yJdrFtT6/J4acIa4W1UEavRINkolC?=
 =?us-ascii?Q?Yw+OxnFOvaCb9EQDdL20fh5NYEdBSnUfao7CEs6RMo3syxROwJluHF+6x4VM?=
 =?us-ascii?Q?UKfziRrerCJ3ejY1NWSwS9zy3uN+LZGkMKsTcUeLjE4Jo0Q0+pxc1vsYzAEv?=
 =?us-ascii?Q?9RYFfFNqM0o5smUtPXLLtbDeAVj+K+aqRdUk5qxnN30tmcNmHhWNj4BFISpO?=
 =?us-ascii?Q?RYT7A+7xdNcs2zirJ5+PXN8SvhowZl+wBm3sadfiGgo3V73HdEj2BNK40I9C?=
 =?us-ascii?Q?fPUeKr0xtwYG7RFnwtaRPn6IHd/pg/0ZVjYy82JDwlZTBOcOqZCuB5s3px4V?=
 =?us-ascii?Q?dfVxABLXix1cR97xLhc6Ske/hy1itt+DFRlGH0OHXKAou1wgSr429TRnOL3w?=
 =?us-ascii?Q?j60I0+1M7ZloOtrmOcNFtaI8SvedV38sIFtoVxx0RRnLOxTyT9jgkxEW/Ew6?=
 =?us-ascii?Q?L6t1cxAkDIETMa/1VfQ/qL99PK/aTK8S12heeaAbbevAGE5OHbKEVFa9Gjms?=
 =?us-ascii?Q?JTL/rmBMuecRWOtzvjS2mKaLMeccjYLM7j+lTvZYEuZXbE2IMYWXnteiog1p?=
 =?us-ascii?Q?g8kybGyKrYdZEtdW+h/Jcc/07dUPOQKHU/3N+bp5LYcqyRdTyNoRC7WYrgQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b997199e-5bcd-4179-06d2-08dd154a1160
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 16:30:01.9245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7443

From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, November 13=
, 2024 12:47 AM
>=20
> Channel offers are requested during VMBus initialization and resume from
> hibernation. Add support to wait for all boot-time channel offers to
> be delivered and processed before returning from vmbus_request_offers.
>=20
> This is in analogy to a PCI bus not returning from probe until it has
> scanned all devices on the bus.
>=20
> Without this, user mode can race with VMBus initialization and miss
> channel offers. User mode has no way to work around this other than
> sleeping for a while, since there is no way to know when VMBus has
> finished processing boot-time offers.
>=20
> With this added functionality, remove earlier logic which keeps track
> of count of offered channels post resume from hibernation. Once all
> offers delivered message is received, no further boot-time offers are
> going to be received. Consequently, logic to prevent suspend from
> happening after previous resume had missing offers, is also removed.
>=20
> Co-developed-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

I finally did my own custom logging to confirm for myself how this
all works, primarily so I can write finish writing the Linux kernel
documentation on Hyper-V guest hibernation that I mentioned
earlier. I think these changes all look good. So,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
> Changes since v2:
> * Incorporated Easwar's suggestion to use secs_to_jiffies() as his
>   changes are now merged.
> * Addressed Michael's comments:
>   * Used boot-time offers/channels/devices to maintain consistency
>   * Rephrased CHANNELMSG_ALLOFFERS_DELIVERED handler function comments
>     for better explanation. Thanks for sharing the write-up.
>   * Changed commit msg and other things as per suggestions
> * Addressed Dexuan's comments, which came up in offline discussion:
>   * Changed timeout for waiting for all offers delivered msg to 60s inste=
ad of 10s.
>     Reason being, the host can experience some servicing events or diagno=
stics events,
>     which may take a long time and hence may fail to offer all the device=
s within 10s.
>   * Minor additions in commit subject.
>=20
> Changes since v1:
> * Added Easwar's Reviewed-By tag
> * Addressed Michael's comments:
>   * Added explanation of all offers delivered message in comments
>   * Removed infinite wait for offers logic, and changed it wait once.
>   * Removed sub channel workqueue flush logic
>   * Added comments on why MLX device offer is not expected as part of
>     this essential boot offer list. I refrained from adding too many
>     details on it as it felt like it is beyond the scope of this patch
>     series and may not be relevant to this. However, please let me know i=
f
>     something needs to be added.
> * Addressed Saurabh's comments:
>   * Changed timeout value to 10000 ms instead of 10*10000
>   * Changed commit msg as per suggestions
>   * Added a comment for warning case of wait_for_completion timeout
> ---
>  drivers/hv/channel_mgmt.c | 61 +++++++++++++++++++++++++++++----------
>  drivers/hv/connection.c   |  4 +--
>  drivers/hv/hyperv_vmbus.h | 14 ++-------
>  drivers/hv/vmbus_drv.c    | 16 ----------
>  4 files changed, 51 insertions(+), 44 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 3c6011a48dab..b1a095671e32 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -944,16 +944,6 @@ void vmbus_initiate_unload(bool crash)
>  		vmbus_wait_for_unload();
>  }
>=20
> -static void check_ready_for_resume_event(void)
> -{
> -	/*
> -	 * If all the old primary channels have been fixed up, then it's safe
> -	 * to resume.
> -	 */
> -	if (atomic_dec_and_test(&vmbus_connection.nr_chan_fixup_on_resume))
> -		complete(&vmbus_connection.ready_for_resume_event);
> -}
> -
>  static void vmbus_setup_channel_state(struct vmbus_channel *channel,
>  				      struct vmbus_channel_offer_channel *offer)
>  {
> @@ -1109,8 +1099,6 @@ static void vmbus_onoffer(struct
> vmbus_channel_message_header *hdr)
>=20
>  		/* Add the channel back to the array of channels. */
>  		vmbus_channel_map_relid(oldchannel);
> -		check_ready_for_resume_event();
> -
>  		mutex_unlock(&vmbus_connection.channel_mutex);
>  		return;
>  	}
> @@ -1296,13 +1284,28 @@
> EXPORT_SYMBOL_GPL(vmbus_hvsock_device_unregister);
>=20
>  /*
>   * vmbus_onoffers_delivered -
> - * This is invoked when all offers have been delivered.
> + * The CHANNELMSG_ALLOFFERS_DELIVERED message arrives after all
> + * boot-time offers are delivered. A boot-time offer is for the primary
> + * channel for any virtual hardware configured in the VM at the time it =
boots.
> + * Boot-time offers include offers for physical devices assigned to the =
VM
> + * via Hyper-V's Discrete Device Assignment (DDA) functionality that are
> + * handled as virtual PCI devices in Linux (e.g., NVMe devices and GPUs)=
.
> + * Boot-time offers do not include offers for VMBus sub-channels. Becaus=
e
> + * devices can be hot-added to the VM after it is booted, additional cha=
nnel
> + * offers that aren't boot-time offers can be received at any time after=
 the
> + * all-offers-delivered message.
>   *
> - * Nothing to do here.
> + * SR-IOV NIC Virtual Functions (VFs) assigned to a VM are not considere=
d
> + * to be assigned to the VM at boot-time, and offers for VFs may occur a=
fter
> + * the all-offers-delivered message. VFs are optional accelerators to th=
e
> + * synthetic VMBus NIC and are effectively hot-added only after the VMBu=
s
> + * NIC channel is opened (once it knows the guest can support it, via th=
e
> + * sriov bit in the netvsc protocol).
>   */
>  static void vmbus_onoffers_delivered(
>  			struct vmbus_channel_message_header *hdr)
>  {
> +	complete(&vmbus_connection.all_offers_delivered_event);
>  }
>=20
>  /*
> @@ -1578,7 +1581,8 @@ void vmbus_onmessage(struct
> vmbus_channel_message_header *hdr)
>  }
>=20
>  /*
> - * vmbus_request_offers - Send a request to get all our pending offers.
> + * vmbus_request_offers - Send a request to get all our pending offers
> + * and wait for all boot-time offers to arrive.
>   */
>  int vmbus_request_offers(void)
>  {
> @@ -1596,6 +1600,10 @@ int vmbus_request_offers(void)
>=20
>  	msg->msgtype =3D CHANNELMSG_REQUESTOFFERS;
>=20
> +	/*
> +	 * This REQUESTOFFERS message will result in the host sending an all
> +	 * offers delivered message after all the boot-time offers are sent.
> +	 */
>  	ret =3D vmbus_post_msg(msg, sizeof(struct vmbus_channel_message_header)=
,
>  			     true);
>=20
> @@ -1607,6 +1615,29 @@ int vmbus_request_offers(void)
>  		goto cleanup;
>  	}
>=20
> +	/*
> +	 * Wait for the host to send all boot-time offers.
> +	 * Keeping it as a best-effort mechanism, where a warning is
> +	 * printed if a timeout occurs, and execution is resumed.
> +	 */
> +	if (!wait_for_completion_timeout(
> +		&vmbus_connection.all_offers_delivered_event, secs_to_jiffies(60))) {
> +		pr_warn("timed out waiting for all boot-time offers to be delivered.\n=
");
> +	}
> +
> +	/*
> +	 * Flush handling of offer messages (which may initiate work on
> +	 * other work queues).
> +	 */
> +	flush_workqueue(vmbus_connection.work_queue);
> +
> +	/*
> +	 * Flush workqueue for processing the incoming offers. Subchannel
> +	 * offers and their processing can happen later, so there is no need to
> +	 * flush that workqueue here.
> +	 */
> +	flush_workqueue(vmbus_connection.handle_primary_chan_wq);
> +
>  cleanup:
>  	kfree(msginfo);
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index f001ae880e1d..8351360bba16 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -34,8 +34,8 @@ struct vmbus_connection vmbus_connection =3D {
>=20
>  	.ready_for_suspend_event =3D COMPLETION_INITIALIZER(
>  				  vmbus_connection.ready_for_suspend_event),
> -	.ready_for_resume_event	=3D COMPLETION_INITIALIZER(
> -				  vmbus_connection.ready_for_resume_event),
> +	.all_offers_delivered_event =3D COMPLETION_INITIALIZER(
> +				  vmbus_connection.all_offers_delivered_event),
>  };
>  EXPORT_SYMBOL_GPL(vmbus_connection);
>=20
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index d2856023d53c..66160995519a 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -287,18 +287,10 @@ struct vmbus_connection {
>  	struct completion ready_for_suspend_event;
>=20
>  	/*
> -	 * The number of primary channels that should be "fixed up"
> -	 * upon resume: these channels are re-offered upon resume, and some
> -	 * fields of the channel offers (i.e. child_relid and connection_id)
> -	 * can change, so the old offermsg must be fixed up, before the resume
> -	 * callbacks of the VSC drivers start to further touch the channels.
> +	 * Completed once the host has offered all boot-time channels.
> +	 * Note that some channels may still be under process on a workqueue.
>  	 */
> -	atomic_t nr_chan_fixup_on_resume;
> -	/*
> -	 * vmbus_bus_resume() waits for "nr_chan_fixup_on_resume" to
> -	 * drop to zero.
> -	 */
> -	struct completion ready_for_resume_event;
> +	struct completion all_offers_delivered_event;
>  };
>=20
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 9b15f7daf505..bd3fc41dc06b 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2427,11 +2427,6 @@ static int vmbus_bus_suspend(struct device *dev)
>  	if (atomic_read(&vmbus_connection.nr_chan_close_on_suspend) > 0)
>  		wait_for_completion(&vmbus_connection.ready_for_suspend_event);
>=20
> -	if (atomic_read(&vmbus_connection.nr_chan_fixup_on_resume) !=3D 0) {
> -		pr_err("Can not suspend due to a previous failed resuming\n");
> -		return -EBUSY;
> -	}
> -
>  	mutex_lock(&vmbus_connection.channel_mutex);
>=20
>  	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
> @@ -2456,17 +2451,12 @@ static int vmbus_bus_suspend(struct device *dev)
>  			pr_err("Sub-channel not deleted!\n");
>  			WARN_ON_ONCE(1);
>  		}
> -
> -		atomic_inc(&vmbus_connection.nr_chan_fixup_on_resume);
>  	}
>=20
>  	mutex_unlock(&vmbus_connection.channel_mutex);
>=20
>  	vmbus_initiate_unload(false);
>=20
> -	/* Reset the event for the next resume. */
> -	reinit_completion(&vmbus_connection.ready_for_resume_event);
> -
>  	return 0;
>  }
>=20
> @@ -2502,14 +2492,8 @@ static int vmbus_bus_resume(struct device *dev)
>  	if (ret !=3D 0)
>  		return ret;
>=20
> -	WARN_ON(atomic_read(&vmbus_connection.nr_chan_fixup_on_resume) =3D=3D
> 0);
> -
>  	vmbus_request_offers();
>=20
> -	if (wait_for_completion_timeout(
> -		&vmbus_connection.ready_for_resume_event, 10 * HZ) =3D=3D 0)
> -		pr_err("Some vmbus device is missing after suspending?\n");
> -
>  	/* Reset the event for the next suspend. */
>  	reinit_completion(&vmbus_connection.ready_for_suspend_event);
>=20
> --
> 2.34.1


