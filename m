Return-Path: <linux-hyperv+bounces-3168-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562039A5991
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Oct 2024 06:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B751C20A60
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Oct 2024 04:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8743155321;
	Mon, 21 Oct 2024 04:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="b999S756"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19012044.outbound.protection.outlook.com [52.103.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AA2634;
	Mon, 21 Oct 2024 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729485222; cv=fail; b=aAFMt2l4ritA2h5BokL7zrStlooTyjsRJK82gAJbbQ0HQsHP7ylde+PElH8JwIQcAvYfrW3UGLk844cyi+Wv1dodUJkca84a89t0bVynNpYCPquT3oZzbqyBTbJJqnLaL8b2Zl59C35F8j5FdjPQGKOLur5MFt08XbynXRdnXxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729485222; c=relaxed/simple;
	bh=zxvOeSfbyj1jK+APqwEue/yOsholQM6tLg+fgH2eM1o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pfvaTbpdBVjtFzA8V6L2drPe6X/vHTmW3u4vspBWLGueQ+a+xGt0Bll/WboR9jeRT5qOLZrnLmVfPRuryfP4dpaIwK/vJ0yibDCdhwie4/0QaCRW0Of5lzGi8R/cs/jmoIROcpaygF8PKSeFUPMAATEsZJ2n1hPyFnMr4UaggGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=b999S756; arc=fail smtp.client-ip=52.103.7.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIxWGmfycsVSsp0ADlAtC78qQLu4A39ejuE1bkj/mPPH79otcLfY3lxaT/Yy3N1yGrHKXpEtdEzhvVw3eBo1luknZOyZjiWWD8sChUb2Px3M9qTz/ylBHPvFZMJ3BaTW01KvSJdSga64tCOdvY2XNHCkdRRotIp1QYu3HP64TlcgyQ8KXU9C/BUjjNd4jRUH0YnU5K/5VOr9opC2uAyk5m57esItbL8ImbPk4yN3/pAFXT1WvBp5kR7JIZoGmkFaOvnQsOMF8X/7s+kzdviIOVnsOLjewcm93HrvH6/FKACDd5Rw+D0q8JbUgBmQ7ugXyPMBylm4Z0Ebq6tBls2myw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E01ZduFgeAsjFUUfjf8sWkNgi/j96mgC6PzM34FIILc=;
 b=u2uNOuUxpsaYhSJe8dPzmaW/q8RfBFbsIi4tIgoCGet3m8KJT83h4id74LbDsBhAuvYwHhR94h0bYIFS9CPx0mufRhn0PD48m2ajqE6p/a9j2VROXoeqJQNHpH9CA6z/sqQisancXZLmZT+U3a7ipr+euNOQKKKCIMp7BbQvfaZ1Yjd90GtCvB27CRyMOZSeVCui+wTlhUZo+CR2k0YY3kzQ3CkgTJj8TKmMZ9VBmG5fIvFJ4E+8yLYsVlqBnF/s+IuKCX1LixruMjCfE15GhK2Ol1qyWtbyUvECReId2hciMOFAUIHzwxMsZFMKq+TrVnN65WSz3tvtO9y/q2seNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E01ZduFgeAsjFUUfjf8sWkNgi/j96mgC6PzM34FIILc=;
 b=b999S756JJJQtn5SaMDDJ+mXmxKDijgtQlfEPpqVeEgmROcRaxZKGCZ0Q8DDob0lvLw3scXG1w8XgYNNIPURK6AQ17FyL+tn0H9V7PKM5hSLJEOweet/OpY/Ld+ciskqRcsU0inyO9CGDXKjFqmWEsvP1SUYZIPuP6RYnWaFiQ4NFFVC1jvUgmZKWRDnB0Kr30wHvDHD8ZbEWIgmIHnOBGS1S9QuO+rV/qCgDZIPs+4JuTG8MhcIiz9TDbPymN4OAl7r7WSmsRdMU7p8ScPO8AmVLSyUtJ2xKNUuWz60oreh4edG4vPkXe72sWwGBcTBPrn/Kbc9m37OXRG6iW7IdQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8655.namprd02.prod.outlook.com (2603:10b6:806:1fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Mon, 21 Oct
 2024 04:33:37 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8069.016; Mon, 21 Oct 2024
 04:33:37 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Starks
	<jostarks@microsoft.com>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, Easwar Hariharan
	<eahariha@linux.microsoft.com>
Subject: RE: [PATCH 1/2] Drivers: hv: vmbus: Wait for offers during boot
Thread-Topic: [PATCH 1/2] Drivers: hv: vmbus: Wait for offers during boot
Thread-Index: AQHbIVUZK3+QpQzaU0GO9u2NqFEaQbKPwn3A
Date: Mon, 21 Oct 2024 04:33:37 +0000
Message-ID:
 <SN6PR02MB4157F0678E2F7074A905BB64D4432@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241018115811.5530-1-namjain@linux.microsoft.com>
 <20241018115811.5530-2-namjain@linux.microsoft.com>
In-Reply-To: <20241018115811.5530-2-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8655:EE_
x-ms-office365-filtering-correlation-id: 32920a7c-37b5-430d-b42b-08dcf189880f
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8062599003|461199028|8060799006|15080799006|3412199025|440099028|102099032|56899033;
x-microsoft-antispam-message-info:
 W9sxRhIQfrNC6HxrhQtpgIR7f9CVJkU5ERLl6J5yrzExohWPHSQlUNhBI957jXENCs7xRylWbqVV8Hnt9L6Alu2wHVV1viPzB695TkadHqSGYOWxp92miItOfcNuJfO0/nWCP/yptbue/S+e0ljkPhYuOte1sbC+z/bpMkGzxO22e9ikmEYplE9K4XI6UiG1nddicVfIyo8eqJb5nl8EOuDN3JNV7c5+VnOPGBGQtaTntYNGWJC7nUF+wkY5txbW3FK04WbfT6cZ7OsO1vXOiR6mFOoICTnRraWWaK52hdxc2c3j0NZhgooyKROJ6pC2URUWpdQGv0pshpYVDP4qnz/Skg651bv+HEVdISICWDmmlqMtbEuB4TqMt/Xgqt2iAMD3BNyh+0INcUd7f40LfndDalztHI29tF3LcXh38GJrmiPaYzKGM1RvcayIxeQwk0y5kXMl6SMOMpDean7Iy4vAX5CH87fJAdtWSOY/+6l4AjjC7+OZashJFtknTvp8/mLZS0IJmM1zm0/XZ6jzQHoMAde9tH7QCuwH6Gbdd9AE8p12gtv5K+mLGJ0a2PbEhdKzD+RMLWIPaBE+mNuG0e0RDruwHl5mJk4IOJ0W9a3KNvWYI9UIyPQaDRE8RxSjv8QRQxC6+MZsi/8VyKx4olrOYJkia1x51VKwtnUWr9dTP1hrymje+oJYzIhfTqTvSCbNzwwM8yPR5NcuklrbZQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7lciEXOVmdd4/q1hWr1lGumantcw/9mnqpm7EP7+aSVMWKsw9VcVkqYCrqwh?=
 =?us-ascii?Q?k7tFBNHR3FtWLGIj9smqDib1UBryk+C0paJK4aMwq006Y+tNTozcVSjWTl6w?=
 =?us-ascii?Q?ZkQYWyZ8fuk+pqlXXhFxkZaN3QmW6xNG0e6lv8Yma6o104JgdJZT/4GoSfuO?=
 =?us-ascii?Q?UZND4bHA3t0tbsUgcYgcM59q213/4WJ28+sxI8i0I6yYYBZFqSRugyY/xW+P?=
 =?us-ascii?Q?o84o3yxBKi4Vjq51D3PLhjhZF8mAooV18EbZsuuKh8Pb5cUdFQak+hQDK130?=
 =?us-ascii?Q?7FUsBJFU8lpJX06+UBIV195mewSlzda5wfjyi6wef9dTpDrj7MZVWTSKZBfs?=
 =?us-ascii?Q?6HWLztZ+bTc88enPvLGNtneSRqQB3GRPf0iJX+iQo8GbHI5Tma82PCAjkdAN?=
 =?us-ascii?Q?XTTsKvf+K2BOOq4bD1ID/aN8ndCF0p5+Q1oPzLPBEWFS8iEpk9k6jd2tzpv0?=
 =?us-ascii?Q?xjuHp0O2vZlT2p/08QsMf7pG6Koc5/7DytPYONU+TpA22bISi8jJOXHj5s3E?=
 =?us-ascii?Q?sNZa1jxKPjstu3G389x5rJSw5gE4bzbS2BRjndDwpTQEh9vHlYKANXlju9M4?=
 =?us-ascii?Q?necl640K1bAgP3dcPyVX35eol1i7dpRRHQKa7/aKtQaTGAGAb2Ge9Rqt9vy9?=
 =?us-ascii?Q?2/3+EQ8rzOY4jL/BpGEg/w/q3fDcVl8Rxps1re228bhzWj6fleIqmSTBvZt1?=
 =?us-ascii?Q?qjCUrDUNWXadYMI7SChKnt7+rlLlRUjFMzZ4aYh5BGtuXEDfNytQnpaatvAs?=
 =?us-ascii?Q?DlCa1U7xJZiGrZ4EaeOmUC5CgA2+P+aBkIVArT9P5e93p8pCeIJJrKJ0UR9/?=
 =?us-ascii?Q?5fs6PKlz0UXUoiZXYk/MwXJpOpeN8rRm1VQsa47ASygGpFOOc505Hytt72x3?=
 =?us-ascii?Q?kjr/i2857HSX7Yeuxt+sznWyH4mlT8Y4QlJ9qjHoV2bIwcGrrPiVe9AcI287?=
 =?us-ascii?Q?+dVUHuegL2Un4Aiu226uf75yTTFyNyBl8OEFcLD9I57Tx8XV6siaAyDxeV4j?=
 =?us-ascii?Q?0bqyxrm+cCERazFbZ6hIUxCOeDpbGWju5r+IAIZXTZr0hdATrGMabVa+d19I?=
 =?us-ascii?Q?Ys8TqiMB2DjT+BInUlzL3kQCPXeKD9ICee0ioI7ilyv5RfEEEXX9MKUlilA7?=
 =?us-ascii?Q?Jk7P/71BQSJ0uNYYz8WNIow0L48qDF+Y1rt7D0wbJumOOf+no/PYMrHgmn73?=
 =?us-ascii?Q?5Gr0e4UX/GSD2rbPq/0rOZVCEplZ7kJ8wHvkZ6M+f7yi85kYQM8rqEFHwxU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 32920a7c-37b5-430d-b42b-08dcf189880f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 04:33:37.5111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8655

From: Naman Jain <namjain@linux.microsoft.com> Sent: Friday, October 18, 20=
24 4:58 AM
>=20
> Channels offers are requested during vmbus initialization and resume
> from hibernation. Add support to wait for all channel offers to be
> delivered and processed before returning from vmbus_request_offers.
> This is to support user mode (VTL0) in OpenHCL (A Linux based
> paravisor for Confidential VMs) to ensure that all channel offers
> are present when init begins in VTL0, and it knows which channels
> the host has offered and which it has not.
>=20
> This is in analogy to a PCI bus not returning from probe until it has
> scanned all devices on the bus.
>=20
> Without this, user mode can race with vmbus initialization and miss
> channel offers. User mode has no way to work around this other than
> sleeping for a while, since there is no way to know when vmbus has
> finished processing offers.
>=20
> With this added functionality, remove earlier logic which keeps track
> of count of offered channels post resume from hibernation. Once all
> offers delivered message is received, no further offers are going to
> be received. Consequently, logic to prevent suspend from happening
> after previous resume had missing offers, is also removed.
>=20
> Co-developed-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 38 +++++++++++++++++++++++---------------
>  drivers/hv/connection.c   |  4 ++--
>  drivers/hv/hyperv_vmbus.h | 14 +++-----------
>  drivers/hv/vmbus_drv.c    | 16 ----------------
>  4 files changed, 28 insertions(+), 44 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 3c6011a48dab..ac514805dafe 100644
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
> @@ -1109,8 +1099,6 @@ static void vmbus_onoffer(struct vmbus_channel_mess=
age_header *hdr)
>=20
>  		/* Add the channel back to the array of channels. */
>  		vmbus_channel_map_relid(oldchannel);
> -		check_ready_for_resume_event();
> -
>  		mutex_unlock(&vmbus_connection.channel_mutex);
>  		return;
>  	}
> @@ -1297,12 +1285,11 @@
> EXPORT_SYMBOL_GPL(vmbus_hvsock_device_unregister);
>  /*
>   * vmbus_onoffers_delivered -
>   * This is invoked when all offers have been delivered.
> - *
> - * Nothing to do here.
>   */

I'm unclear on the meaning of the ALLOFFERS_DELIVERED message. In the
early days of Hyper-V, the set of virtual devices in a VM was fixed before =
a
VM started, so presumably ALLOFFERS_DELIVERED meant that offers for
that fixed set of devices had been delivered. That meaning makes sense
conceptually.

But more recent versions of Hyper-V support adding and removing devices
at any time during the life of the VM. If a device is added, a new offer is
generated. Existing devices (such as netvsc) can reconfigure their channels=
,
in which case new subchannel offers are generated. So the core concept of
"all offers delivered" isn't valid anymore.

To date Linux hasn't done anything with this message, so we didn't need
precision about what it means. There's no VMBus specification or
documentation, so we need some text here in the comments that
explains precisely what ALLOFFERS_DELIVERED means, and how that
meaning aligns with the fact that offers can be delivered anytime during
the life of the VM.

I'll note that in the past there's also been some behavior where during gue=
st
boot, Hyper-V offers a virtual PCI device to the guest, immediately
rescinds the vPCI device (before Linux even finished processing the offer),
then offers it again. I wonder about how ALLOFFERS_DELIVERED interacts
with that situation.

I ran some tests in an Azure L16s_v3 VM, which has three vPCI devices:
2 NVMe devices and 1 Mellanox CX-5. The offers for the 2 NVMe devices
came before the ALLOFFERS_DELIVERED message, but the offer for
the Mellanox CX-5 came *after* the ALLOFFERS_DELIVERED message.
If that's the way the Mellanox CX-5 offers work, this patch breaks things
in the hibernation resume path because ALLOFFERS_DELIVERED isn't
sufficient to indicate that all primary channels have been re-offered
and the resume can proceed. All sub-channel offers came after the
ALLOFFERS_DELIVERED message, but that is what I expected and
shouldn't be a problem.

It's hard for me to review this patch set without some precision around
what ALLOFFERS_DELIVERED means.

>  static void vmbus_onoffers_delivered(
>  			struct vmbus_channel_message_header *hdr)
>  {
> +	complete(&vmbus_connection.all_offers_delivered_event);
>  }
>=20
>  /*
> @@ -1578,7 +1565,8 @@ void vmbus_onmessage(struct vmbus_channel_message_h=
eader *hdr)
>  }
>=20
>  /*
> - * vmbus_request_offers - Send a request to get all our pending offers.
> + * vmbus_request_offers - Send a request to get all our pending offers
> + * and wait for all offers to arrive.
>   */
>  int vmbus_request_offers(void)
>  {
> @@ -1596,6 +1584,10 @@ int vmbus_request_offers(void)
>=20
>  	msg->msgtype =3D CHANNELMSG_REQUESTOFFERS;
>=20
> +	/*
> +	 * This REQUESTOFFERS message will result in the host sending an all
> +	 * offers delivered message.
> +	 */
>  	ret =3D vmbus_post_msg(msg, sizeof(struct vmbus_channel_message_header)=
,
>  			     true);
>=20
> @@ -1607,6 +1599,22 @@ int vmbus_request_offers(void)
>  		goto cleanup;
>  	}
>=20
> +	/* Wait for the host to send all offers. */
> +	while (wait_for_completion_timeout(
> +		&vmbus_connection.all_offers_delivered_event, msecs_to_jiffies(10 * 10=
00)) =3D=3D 0) {

Maybe do !wait_for_completion_timeout( ...) instead of explicitly testing
for 0? I see that some existing code uses the explicit test for 0, but that=
's
not the usual kernel code idiom.

> +		pr_warn("timed out waiting for all offers to be delivered...\n");
> +	}

The while loop could continue forever. We don't want to trust the Hyper-V
host to be well-behaved, so there should be an uber timeout where it gives
up after 100 seconds (or pick some value). If the uber timeout is reached,
I'm not sure if the code should panic or just go on -- it's debatable. But =
doing
something explicit is probably better than repeatedly outputting the
warning message forever.

> +
> +	/*
> +	 * Flush handling of offer messages (which may initiate work on
> +	 * other work queues).
> +	 */
> +	flush_workqueue(vmbus_connection.work_queue);
> +
> +	/* Flush processing the incoming offers. */
> +	flush_workqueue(vmbus_connection.handle_primary_chan_wq);
> +	flush_workqueue(vmbus_connection.handle_sub_chan_wq);

Why does the sub-channel workqueue need to be flushed? Sub-channels
get created at the request of the Linux driver, in cooperation with the VSP
on the Hyper-V side. If the top-level goal is for user-space drivers to be
able to know that at least a core set of offers have been processed, it
seems like waiting for sub-channel offers isn't necessary. And new
subchannel offers could arrive immediately after this flush, so the flush
doesn't provide any guarantee about whether there are offers in that
workqueue. If there is a valid reason to wait, some explanatory
comments would be helpful.

Michael

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
> index d2856023d53c..80cc65dac740 100644
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
> +	 * Completed once the host has offered all channels. Note that
> +	 * some channels may still be being process on a work queue.
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
> -	WARN_ON(atomic_read(&vmbus_connection.nr_chan_fixup_on_resume) =3D=3D 0=
);
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
>=20


