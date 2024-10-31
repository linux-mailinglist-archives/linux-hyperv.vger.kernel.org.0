Return-Path: <linux-hyperv+bounces-3228-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3825B9B8320
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Oct 2024 20:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA441F229FE
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Oct 2024 19:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5084A1AD3E0;
	Thu, 31 Oct 2024 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OQdbNpq2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazolkn19013009.outbound.protection.outlook.com [52.103.2.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575E080BF8;
	Thu, 31 Oct 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402034; cv=fail; b=otc3YBM+UXLvaebxem4BkWNV0qanuhTJiNeIg2HdSrVidOPaV+RJ4DYlFjfcGx8zL5SjpbfUoKd8/6rQ9G87r79hOn0YNL5sYaJrtZfaSYYUoMVl40eLAlLqFzUR9Ux4khWM3U3K3+lb8/dwfHBinmGadornoZScC4D9BG4DEh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402034; c=relaxed/simple;
	bh=1b/X9u9gsP3dBgV5skU3PSZcl8bbhur51locx8KVT9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u5uO/cH19UeiUahIlmOQ5O6g0njTkVlf+n7e+DWSgE8shB764UfkKE31RsDzInT1Ph40jZt8Pwk77bY3FYzEs5vYic4QPFpRvCKdFCqAfERLus9B8layvYqvZlwWl+PXr4y7/2CnbydOK1YOAinIrrX0o0x5wwCy7Ra4vgTfx3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OQdbNpq2; arc=fail smtp.client-ip=52.103.2.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aV9H6bUL7gzK6lHZQDZJlx/Ri30Ghq+SH6/8AZIq5v0775c4/x8rlqeBfmQcQE8Xqc9+kFo5x+j3PGNymO4/r9QTlirppkh5oAQ9TQHPHWv4tQLCQsd8TOxXl7zucVOxLzkIvJSNVnnYeCZnxlKJQEPyXE3H3zezOLbWmBO6tpe8ZQYrZemjKGWgjeprSlIK+D+pcnuxGbIN5RnS6b4KUycQqkoyzB/RZEobGvPOGhXcNiOK7oanl8G2vZRHDTYAeUCX920tN5qT7OHb6I2m8DXrmHRzDrj2LNGbHLAROiSSBceyo1hfJc77ItcjVU8sNftx4Sp1E1dMqbsaEaSndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peZSzuyudRMA4tCe+2w8vO6l5tyTqtJyWm/dcQWS1Zc=;
 b=Rmgw0GdqRrjFxiR2URH4qP87i2tZ6bRsFyjAQvvqkhOJRGndWRsKJdA2x2LBr6EwhUMgpULuRBWqqd95nJrL/4O1eRHHZVx3HqXXWNwnu5Vllx29OQT2QI75LHmtrlns+61gqiX8RRveibMD2J1yHeN7E8+B0pib+LFJYUbXdSdIOeYJK7RWbE2SieQQxv2CpMlAe86YvDywkYSuqjmWocxA05XXDZD5Oi+wt/T/Iid0O6DzSOyd7sotLyRqqhbLW/6TaLtp3hsdOldp5+kIf2Yugy1ngoehugZfAs1ZPi7Lop2qX/ee9V9fMR6BZAWYVIr5iIyxJV7pY0xKU1viYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peZSzuyudRMA4tCe+2w8vO6l5tyTqtJyWm/dcQWS1Zc=;
 b=OQdbNpq2GgjYUcPefqxaFH+7g4QnEFA+XwmqNp6huYTDTkhKFGW3M+Py6BpKcFPcMPpKtmIXqz4fm9idNjgc5f6Jbi4ohd6SgC/pl6olsSeozl652eJY5wztboPFGooScGg4O2WJZNI6dQQPz5QqOCXRx4BOKl7mrredTzgq305A0mYZXZLlQZIDG6Y+4b7fJ091PfJBmlhsDMMytkICn7C+umvBnfvD0PZSwwJJ5j1l2XyS52zFMQeN7Ao+3IDsbloEogz5xe1LV7O/orrLW9QYymQQud4jqHTom/C9l7mRGCc/Y35IqhEh63vbzsMJArvncekzHoPUCHF4XqR6eg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9260.namprd02.prod.outlook.com (2603:10b6:610:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 19:13:48 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 19:13:48 +0000
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
Subject: RE: [PATCH v2 1/2] Drivers: hv: vmbus: Wait for offers during boot
Thread-Topic: [PATCH v2 1/2] Drivers: hv: vmbus: Wait for offers during boot
Thread-Index: AQHbKdjUFq8frzPLX0SXVVeH2+YpXLKhExew
Date: Thu, 31 Oct 2024 19:13:48 +0000
Message-ID:
 <SN6PR02MB4157726CAAFB3F9FC8B682A4D4552@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241029080147.52749-1-namjain@linux.microsoft.com>
 <20241029080147.52749-2-namjain@linux.microsoft.com>
In-Reply-To: <20241029080147.52749-2-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9260:EE_
x-ms-office365-filtering-correlation-id: 7d17f623-6dab-4e03-d6fe-08dcf9e0260e
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|19110799003|461199028|8060799006|8062599003|56899033|1602099012|102099032|10035399004|3412199025|4302099013|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?s7K1GFM+cBiGp5G7mOQwwA3fjSjH6bA+m3rifB9suUK9+Rf3C0go0WBiy6rQ?=
 =?us-ascii?Q?vmPL9Uettnnu2cl4cPJirz2ZvZGrHRPHxl2U1jZ5qZw5DjyIvXKVVwBEWJ+n?=
 =?us-ascii?Q?mr9eUPdVPjKTL/XOsvutwgNXDqSlRqtAJ4ax4SnxQmpOJL6r7NQNdZ5LMrPd?=
 =?us-ascii?Q?gzIyp7Ja86Fuytzf2v37kpeDCP3l7Igg4RH/MjaXm20FKZ/YihAf5x3aZR4y?=
 =?us-ascii?Q?erc5eJ0BneYwe8r9aF6Z3v2k6fCTU7CHkUEZYzEtbVv5cQEcdioCKzJDZ9wn?=
 =?us-ascii?Q?02XFHFHzWRNJzfvKUv0Q55GOGP8vEILrDvBEtsZVMitbnr5CMkRpbefKulM2?=
 =?us-ascii?Q?rPRjsQorkFkXXhEiT5xHZwYUPXjPwr1F2TNQRAFbRYF1HT1i1orN9/xm5lej?=
 =?us-ascii?Q?6u0siv+e+Ynz8PVksqzdFfing1xz2kTzSR7lvhtwDo+fd98bE1zJ9mIDJTrF?=
 =?us-ascii?Q?uKhR56sDYAiTm2CEIVsmNb8HSW3ldbL/9cCYgykn/2056iJHi6YUtYeQfs8B?=
 =?us-ascii?Q?p6Rvm7p0YAItAIyR8AjYVZtA7T+cZakRz72mkt2UdFxgVrAuAx5ulO/rKNMC?=
 =?us-ascii?Q?/zL5FCWJPQW9DrvfXS+44WrZt3C8GQPQxx521jvMl6QkmDosOmjz7AChCu08?=
 =?us-ascii?Q?AinxXrMGRWogtPj0MruHkVM5hahNp3MT/RYUnn1d45wuNgMvZoU5kb4aekKu?=
 =?us-ascii?Q?+fwvO/fHyKTLUjxl2kzI8lETxIYWzN0kTbCc4ZGb7PfLwvEN76TCAosr7Nu4?=
 =?us-ascii?Q?q7WlNLyUEEHrjbBMWux6wsFHCM5vdz6xjisgGr5qhxBUD0B8uCTwUbqz85Qz?=
 =?us-ascii?Q?IheenqJtp5m76M30F52o5TchVIFZq3NR0TAkzKTqdjoApaq+WFQIjeT0qU4u?=
 =?us-ascii?Q?kCAiOzZm2f+XVcBwfSNJ/MO3PKSBti+6aXnHTMXnOfBlZ3i4FZaNt/eE6Tt4?=
 =?us-ascii?Q?ZYLwTfUukIUJahgXb5jsvpvqy9lC9JkeVUgsjWnDjJSIF2vbFyC0BfMEPLNa?=
 =?us-ascii?Q?MLYNVdUBN3IIdXJbeYVF8PrK0JcTtV5Vl0h1MrUmTHz52ATGE7D2yeLZw6g+?=
 =?us-ascii?Q?PDgqmS2YCPLs2xY6bE+tUvcFv3ZrmZEVVCmqN8n4KwvLy7RQzbZp4VEKsKaQ?=
 =?us-ascii?Q?8D4xl7IYj1PX6B6F8TVqYKO2SBsK/voXyL4iwsz/Ht+atL+XloUL8GA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i9eg8NA2EsDJ9cEuABR8ohJab4J2v1FD4Nrpb1enaXeG3d2XDTgaIr4rIkJ/?=
 =?us-ascii?Q?8x69jzkGzXz2C8JANwA+9r2vBQ868b2vAg+Y6SNmvdQJGpvXDH4ImUwIjGaZ?=
 =?us-ascii?Q?LOJtHGalkAxr2SV03sgw1jaANSgC5rj3Yo1CniXexzTOENZM5Y31RaRJax5S?=
 =?us-ascii?Q?7fwjL367dZMm97KUUCUXTzgXEjSQs/ITvKkR5EWsAv1yVGJFIgN2CEVNp4w8?=
 =?us-ascii?Q?bwSYZ9J2/Ehr1rd3qS6I2NAd5I6DMsgcIxWXWb2ScH8k9fUpVjT6Ni0a64fD?=
 =?us-ascii?Q?Ss+Q4CnkY7Y0kTKtEh7eLxFnDu57hPqsuO5NhLxQwIT9EZoQ11/auT2rI/7W?=
 =?us-ascii?Q?H19+Ep2C2W2jRqh1LA8BcQtG9MucjIbI3P6sQDWuCUB1diWDi4riRhkkfx1S?=
 =?us-ascii?Q?u/n6swIjqWcUiJvqSw9Zg7BfkltuQjqF/BJYB0f26DDGS+toHCfSPfKGvcnk?=
 =?us-ascii?Q?0JTr6wlIN30H+Uie/yZvdSNEKmY65Pk/xdXZ5mKTFJluwONo70X9OWANRcv8?=
 =?us-ascii?Q?FNlcPHZytKX0S13czL41w8mnES59waaznFV4l3BLrQwmb4iKq5H1zXijoL3H?=
 =?us-ascii?Q?sabRMCipqulsP4VXuw2odrg8QD4LQ4RwPi7HTHowpqbD1ynoXRk1FWlufFlU?=
 =?us-ascii?Q?FKXIdgfb57pfr0VQY8ccrWu0VzZQ6R92B9+QWeTYv3ZDxjsOqWcpexacIvz2?=
 =?us-ascii?Q?T7/GtDCbfG5ERESMJ8KRa1MbPrvJ8kLeOIbjHkYApLct1SxPxzeQ+rxUONBx?=
 =?us-ascii?Q?D+31b4lxbRW4LzoDVSN0pgiYO2KSm4C9YTy74xo6jmeZEayLRESzR6upuv4o?=
 =?us-ascii?Q?fyLyeXxjWFgCmrwz8SaRBRGHaDzq1AhPQgVHyZZeH3h3QwsF1uop527KLHuu?=
 =?us-ascii?Q?3YL3RrHfmg8FTetb7L2pdP4HqQEaObRB4KR8EH4vLAEROeA/lSGJG4yeeorQ?=
 =?us-ascii?Q?V82f4+QEMkkCxTMHgDIVax06QvCX6x2Q54WQBD/mdFWtpYjeM0QhHAIXPghi?=
 =?us-ascii?Q?FPOj8DNa0uoOuf9XNVzusAq7rYZM99oS+bVWpWpESPuiQ3d9ngmB/8jMHR8i?=
 =?us-ascii?Q?LIw0rC+cnNdDzXAiyMZABX7eiJ6v+aQhEL+WKy/SgKXzjIo1V0lapMpMDSRf?=
 =?us-ascii?Q?YAbxWhxeLyW1BHII4VNK/AEkhglq8ycMPfznV2z6bSOZMdDGvl39rQnM5jY5?=
 =?us-ascii?Q?1SnVVV0/DkZoQEv8nOtMcK8nsI7CaEXvPLbKHq4NvDc4rfojDw6mIZXYBs4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d17f623-6dab-4e03-d6fe-08dcf9e0260e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 19:13:48.6005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9260

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, October 29, 2=
024 1:02 AM
>=20
> Channel offers are requested during VMBus initialization and resume
> from hibernation. Add support to wait for all channel offers to be

Given the definition of ALLOFFERS_DELIVERED, maybe change to:

" wait for all boot-time channel offers"

> delivered and processed before returning from vmbus_request_offers.
>=20
> This is in analogy to a PCI bus not returning from probe until it has
> scanned all devices on the bus.
>=20
> Without this, user mode can race with VMBus initialization and miss
> channel offers. User mode has no way to work around this other than
> sleeping for a while, since there is no way to know when VMBus has
> finished processing offers.

"finished processing boot-time offers."

>=20
> With this added functionality, remove earlier logic which keeps track
> of count of offered channels post resume from hibernation. Once all
> offers delivered message is received, no further offers are going to
> be received.

"no further boot-time offers"

> Consequently, logic to prevent suspend from happening
> after previous resume had missing offers, is also removed.
>=20
> Co-developed-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
> Changes since v1:
> https://lore.kernel.org/all/20241018115811.5530-1-namjain@linux.microsoft=
.com/=20
> * Added Easwar's Reviewed-By tag
> * Addressed Michael's comments:
>   * Added explanation of all offers delivered message in comments
>   * Removed infinite wait for offers logic, and changed it wait once.
>   * Removed sub channel workqueue flush logic
>   * Added comments on why MLX device offer is not expected as part of
>     this essential boot offer list. I refrained from adding too many

You've used slightly different phrasing here ("essential boot offer list").
Potential confusion can be avoided if the terminology is super consistent.
I'm good with "boot-time offers" (or something else if you prefer). I'm not
sure what "essential" means here, unless it refers to offers for VFs from
SR-IOV NICs (like Mellanox) being excluded. But it should be fine to
use something short like "boot-time offers" and then note the VF
exception in the code comments as you've done.

> details on it as it felt like it is beyond the scope of this patch
> series and may not be relevant to this. However, please let me know if
>     something needs to be added.
> * Addressed Saurabh's comments:
>   * Changed timeout value to 10000 ms instead of 10*10000
>   * Changed commit msg as per suggestions
>   * Added a comment for warning case of wait_for_completion timeout
> ---
>  drivers/hv/channel_mgmt.c | 55 ++++++++++++++++++++++++++++-----------
>  drivers/hv/connection.c   |  4 +--
>  drivers/hv/hyperv_vmbus.h | 14 +++-------
>  drivers/hv/vmbus_drv.c    | 16 ------------
>  4 files changed, 45 insertions(+), 44 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 3c6011a48dab..a2e9ebe5bf72 100644
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
> @@ -1296,13 +1284,22 @@
> EXPORT_SYMBOL_GPL(vmbus_hvsock_device_unregister);
>=20
>  /*
>   * vmbus_onoffers_delivered -
> - * This is invoked when all offers have been delivered.
> + * CHANNELMSG_ALLOFFERS_DELIVERED message arrives after all the essentia=
l

Again, I would drop "essential" here, as its meaning in this context isn't
defined anywhere.

> + * boot-time offers are delivered. Other channels can be hot added
> + * or removed later, even immediately after the all-offers-delivered
> + * message. A boot-time offer will be any of the virtual hardware the
> + * VM is configured with at boot.

This is good to have a definition of "boot-time offer".  But I think some
additional specification is appropriate.  Let me suggest the following:

The CHANNELMSG_ALLOFFERS_DELIVERED message arrives after all
boot-time offers are delivered. A boot-time offer is for the primary channe=
l
for any virtual hardware configured in the VM at the time it boots.
Boot-time offers include offers for physical devices assigned to the VM
via Hyper-V's Discrete Device Assignment (DDA) functionality that are
handled as virtual PCI devices in Linux (e.g., NVMe devices and GPUs).
Boot-time offers do not include offers for VMBus sub-channels. Because
devices can be hot-added to the VM after it is booted, additional channel
offers that aren't boot-time offers can be received at any time after the
all-offers-delivered message.

SR-IOV NIC Virtual Functions (VFs) assigned to a VM are not considered
to be assigned to the VM at boot-time, and offers for VFs may occur after
the all-offers-delivered message. VFs are optional accelerators to the
synthetic VMBus NIC and are effectively hot-added only after the VMBus
NIC channel is opened (once it knows the guest can support it, via the
sriov bit in the netvsc protocol).

[Please confirm that my suggested wording is correct!]

>   */
>  static void vmbus_onoffers_delivered(
>  			struct vmbus_channel_message_header *hdr)
>  {
> +	complete(&vmbus_connection.all_offers_delivered_event);
>  }
>=20
>  /*
> @@ -1578,7 +1575,8 @@ void vmbus_onmessage(struct vmbus_channel_message_h=
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
> @@ -1596,6 +1594,10 @@ int vmbus_request_offers(void)
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
> @@ -1607,6 +1609,29 @@ int vmbus_request_offers(void)
>  		goto cleanup;
>  	}
>=20
> +	/*
> +	 * Wait for the host to send all offers.
> +	 * Keeping it as a best-effort mechanism, where a warning is
> +	 * printed if a timeout occurs, and execution is resumed.
> +	 */
> +	if (!wait_for_completion_timeout(
> +		&vmbus_connection.all_offers_delivered_event, msecs_to_jiffies(10000))=
) {
> +		pr_warn("timed out waiting for all offers to be delivered...\n");
> +	}
> +
> +	/*
> +	 * Flush handling of offer messages (which may initiate work on
> +	 * other work queues).
> +	 */
> +	flush_workqueue(vmbus_connection.work_queue);
> +
> +	/*
> +	 * Flush workqueues for processing the incoming offers. Subchannel

s/workqueues/workqueue/

> +	 * offers and processing can happen later, so there is no need to
> +	 * flush those workqueues here.

s/those workqueues/that workqueue/

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

"all boot-time channels"


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


