Return-Path: <linux-hyperv+bounces-3229-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FBF9B8322
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Oct 2024 20:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24EE61F22B13
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Oct 2024 19:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E401AD3E0;
	Thu, 31 Oct 2024 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CC2Juikz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010016.outbound.protection.outlook.com [52.103.2.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A90380BF8;
	Thu, 31 Oct 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402064; cv=fail; b=K4Iwt0HEh7nWWlXdnB+KkUVZpTmxWInLdaSnli0M8GS3YKFeIUFgd36+I87TwwJDbH/JXCzEpcCX9NWjFPUY4SRxz4PKYWNfyJYaINMcWRRfPxWTeLPJNls2qj9o5yd/MBZNC/D2YnVMMPrfonYj76XknMgZg7EphS9j6sujz6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402064; c=relaxed/simple;
	bh=ItWL3sFL4vqjVF4WFwKyHLK+5P6qNRaUuY7jMUtqwEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LjiF1ScXssVfOIxXxo54o4CT7UjdBHo8eCzavlHJkkeg/qxE6U1kpeOHP6p8KY/Hq8WVAAjeBHR97/KvxAT22DkynlS9eGBefTAIaZdoHPscs9nE5CQQv1kOV/tBjaqWuEzBqlhgjiiZ0PMPD+NORl+ZhN9yv03eFYh0z5rg+Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CC2Juikz; arc=fail smtp.client-ip=52.103.2.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujLvSdtRiCYaoOpk956K72R1yJQVSWY3CRxauOQ+lvLCcq+XfGn1V9pmj1Dz/7yFoX8t3Z9DdQ6hHagFpNi9vQyp1GfSmHt1Ai172UKSXwMVHaahNMlYiUzfrCjPcLaqwsvjlrfb0rPyE5ipGKWX7Mp/3TnBIO/S2PIj7e7+wkIe3Pjg9YtNdbciVKte5QNPZMRN8tr6D9DJXeAtmc5sAzng41lDGAnZgO5N/1bukPSk4KnMxD5NUlYMCPzKgFwW6J4UY2dTFuxtIQinKgQA98v28SjpJbQntq1Mob3qyl0cZ3ToHUtV590aHo+ellTibsOPrOGu5G/VR/Fk67UIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HFLceaVdAaJzfWp9tChUDh4av5v2ri74LhK9VXB+6U=;
 b=ZVWO/8U6SbqXLoIXMET5qehydAn+klVVnHC4TRzkNLPd+28do9kxD8xuXN5BqMysu/BzdAN63a5uAKAMNOT0yWF1Mpor6Ss18UDvVoVgH4IWU3xGo1ATaVwbUrdmHkRoflRazIJKHwLDMsrtvmMDml0pjPMjbHBihlJP+14JsyBdDssTikHO4iVEHLoqPKw/sdYYASQxGzNEUtmGLgNwU/EtkPztijkPQauS5qB4GztoBNfxHba84lYByZVMCpKPj/RCOhVZoZrbUWx+ySz4v1KVsN/8lLfdIBchWpY84TGTtYNeUXSPE5/hodP2FXA7sn9XigS+dWrosZBzcbREGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HFLceaVdAaJzfWp9tChUDh4av5v2ri74LhK9VXB+6U=;
 b=CC2Juikz09vSbGqg5DWJio3E4Y6hltShhZ7yMuD3zfKqbmfhkcFNyIrRyx1bAl4Hz6sOwNgbCdWiLEY59Ipb955GrV5D/QyR52wapBQPvid3pgNDKkKFZ5kl3X7PxzdPQSMqDendaOStduCIvOfQIYTmOHeuYQGWK5htFk4Bc+UE1yf/vUqE58XbBi+rAx3Mah2rGnGgbmqBS3ItwlWI+eOK2EkNcCj+etq2D4NuOxGXZVR1lYcq8LiDjTY0gh4PTIFtJ2RPa7EW56Yz51D7KBeJ5VrxsSccrdTOrQm6TPZWCvm6QFAfpDgu04SraOjbV8NAqXjC5Vf2pTbd2tLNYg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9260.namprd02.prod.outlook.com (2603:10b6:610:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 19:14:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 19:14:20 +0000
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
Subject: RE: [PATCH v2 2/2] Drivers: hv: vmbus: Log on missing offers
Thread-Topic: [PATCH v2 2/2] Drivers: hv: vmbus: Log on missing offers
Thread-Index: AQHbKdjVc/uD1sxpKEWYetd8Cd2q47KhHRlQ
Date: Thu, 31 Oct 2024 19:14:20 +0000
Message-ID:
 <SN6PR02MB4157D7212FE3F0F50FAB0592D4552@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241029080147.52749-1-namjain@linux.microsoft.com>
 <20241029080147.52749-3-namjain@linux.microsoft.com>
In-Reply-To: <20241029080147.52749-3-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9260:EE_
x-ms-office365-filtering-correlation-id: d77d09c5-9bbf-4d19-541f-08dcf9e038f4
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|19110799003|461199028|8060799006|8062599003|56899033|1602099012|102099032|10035399004|3412199025|4302099013|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pZnmmr0mPNm12i7vUZE3j4ujah71mKMjkNii5eiRvr7LpgGMY1/OjRyH28/E?=
 =?us-ascii?Q?itZcvHgIJeFZ1/SBQSRlApDFj5AR3qa4zp632/Ii2NtY9/eTlGG/M6IfxVTO?=
 =?us-ascii?Q?8cG5N5FkKxceoWA8PagWj9p/0eBEBunrA1XaIqzS7GokVokXwx/v2EW3ZQub?=
 =?us-ascii?Q?71XCLVo+AVu6BYCwOM9oG/gLNKK/JIx5K18mIKM3XtE5q9MgEV71glPTn/MU?=
 =?us-ascii?Q?5uS2qUssOHLrNBRBIkLEXjX9oAbXWt/pXQDjmoFdXBK1vk7ksXRU26jK5duf?=
 =?us-ascii?Q?sotTq54dfxjm6EHunJJLxaN0bReGLokyi1SY92cx/uvNSdnfV7jX9SSIVAiF?=
 =?us-ascii?Q?AO82kwo1yb1r2MuU2YcXaBNTRu9UK5j9LLkBmcO4rS1nPb2hm2QGeyWUaSku?=
 =?us-ascii?Q?UiaYp/sNCM1H7kSIGKmDNmsOejGCW/Iol/6r2G6X8Lm0GbbWxTUKC7OZcsbl?=
 =?us-ascii?Q?0wWfX199eFAuzNUZFO5Ww7O/OcWicJpO+UnRPqr9MmPiNfsxeZd8iU7XFahg?=
 =?us-ascii?Q?WfIUsKCugiWwtm6CpwRLtyrn1x4Qy+wh/INP7cXHqCZL//10ia239MxCesXC?=
 =?us-ascii?Q?2VI4pcTB/Jjj2UzGfpDse69H4NEkagQ53OXYsUyMOp1vmNR2yx2IdVuXpFBC?=
 =?us-ascii?Q?FQy59NMyZklfmlLTZ3Exrbc1COt04tTkHXT5psPEXmOJAd7mjrPxhA3gczuh?=
 =?us-ascii?Q?4/t7b2TGNdqxV7kXUMudScPPLl2a9ghjHnqKw3azsawfGdmBbgr3ifxD3tu8?=
 =?us-ascii?Q?6PLqyxfQpYO8HfNJbt4pwOZRGpB2K4iNWBb/vEOiyYuOgqtn5TOfG68Zbe/s?=
 =?us-ascii?Q?7JPC/xDwgfh0q/ZU8322chbWKIRssRYGIBkeIVP6DmW8DSKPt8NbuxhFzZJG?=
 =?us-ascii?Q?2mbLcijSTTT7la61tEk3FEjfeayK2+ujf6AP2+rUAt/f4/PQB0zBz8t9LZ7p?=
 =?us-ascii?Q?DpAUwkVBFkTUAM8gBMpA0gXs2T+jBT3/fD751f0WIMJjtHHCLPkeiSgsfoGI?=
 =?us-ascii?Q?HzQrJp9zTXHUbyhtkRIU+2aXV792J/fm0mUXhv+XaG4FpuhCkPW69+csmfMX?=
 =?us-ascii?Q?rYSLJlgZRAGScWgOyNn4dANoqIPU1UnScx3WIgevKV1EQQNn8XekPeDFsjSH?=
 =?us-ascii?Q?ESXq+fFTL80dx+3amyglX5tWFNnheBsheyBZIUDOZP2RPRzA5CdzneI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?h04hQyL0DwhBBULzmZXDZAEP+pMFcKqdIDUVpSpDKvsu7HXDDSs9CUYCPcvo?=
 =?us-ascii?Q?7HX4JTowicP7VblkxC0ze33u2JW+JEb8VeayvaPeF4KTay02/qnHvwBfEdBM?=
 =?us-ascii?Q?Gj5NAlewUaSzjE7v8NnkQ2HgVlPX53UuuAFvuQGW/wDMKILwoUIfV0g+vdwV?=
 =?us-ascii?Q?DiWW0/i0kYNcbPPBVnVz/ftB9qnYk5S3e/U7VeBLonH211DRMydmoQ+WICra?=
 =?us-ascii?Q?nl+qgda/kmppS/x42rwoktY/eN1XTMZWwpL9kTbVPSNogFwgABU7tcmgIG+s?=
 =?us-ascii?Q?620aaJ+1oc+d2Fl5/0aoBlaDcim7VMvyebgdZTcskR96xRrODPf0yu5LHzEQ?=
 =?us-ascii?Q?6WDyKZCEwFjv0/w1AE/lkXTjw0GB4aqkdC/K2uS4IcQpiu7qCyHdiFn9VoOV?=
 =?us-ascii?Q?DJtmc1ZY8mNLbpMIb11gpIbGenmRIuWiONONdSCdzdWWn2XwTHAV3TpyE35H?=
 =?us-ascii?Q?Ciw9VUxHos4MBiRH0N9BLDoiySboazx/TRwKiDedPT/i71+t2vIG53tfRIu8?=
 =?us-ascii?Q?fKKJ9cnbdrxd1KfEhU9pZYG/2ucHAx2Q3zUvbTTt6b1Gat19LjvPt4ZFhB6o?=
 =?us-ascii?Q?X80q8s1DUFa53wy5LHLJdexI/rnKiQaN5tIGw7uemlonBRosWybCa4p3yF5P?=
 =?us-ascii?Q?lGDXaRmH/hsrw5yHdxTDNDx90GKJc0Ih7mKBrvcvEI/+T7i869x3+HjrsIxy?=
 =?us-ascii?Q?pFkb0suHJwnInDcL8GefdmnDCCSFeO3xdr3cjch1LFXfzfI19PtRweuLbRHE?=
 =?us-ascii?Q?CkfUO/mOTHCUK+7WXX6KfuJdk2OzOnk6stkS18KChuinSOtofUcZTROxmbgp?=
 =?us-ascii?Q?LjieYfkhHiU8ipLuUXWO/eIu2l2aK8zh8brjkVpSnM5jBUPkriTCIIQQkIl8?=
 =?us-ascii?Q?36MDWim/XCuHEMc0909MALMYIAuMA+e/+RZdwJoTLhgh2TBVyeJBconBdVKh?=
 =?us-ascii?Q?bkwrhsA0zBvic7x2ZxlCx5KsT6EdRiWbiNgZjRnBh8ZighwGgsEXpwo/9jHi?=
 =?us-ascii?Q?Qm8QsyLoIXBRP4gI2FgK8i7mGi6vpkKLCNhfoCKF969qvlbXsDhoYEpviTSa?=
 =?us-ascii?Q?Z4R8LVYQCPFexj8BHR37O4QLTdCNFOIvzthclbhPDto6hpmoLop0svjhwR50?=
 =?us-ascii?Q?iSL3g0joXikUX6tJxrVIVOFiEw2aHKy3N2Zx8Z/ZCxxgCOr6Rp2BJhVcItJE?=
 =?us-ascii?Q?FUaDOwTqfR/V/eI3eo8q8gsCnp9NUG8PJ2KgDomEtG58+7wpzjBN3gdoj9s?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d77d09c5-9bbf-4d19-541f-08dcf9e038f4
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 19:14:20.3154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9260

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, October 29, 2=
024 1:02 AM
>=20
> When resuming from hibernation, log any channels that were present
> before hibernation but now are gone.
> In general, the essential virtual devices configured for a VM, remain
> same, before and after the hibernation and its not very common that
> some offers are missing.=20

The wording here is a bit jumbled. And let's use consistent terminology.
I'd suggest:

In general, the boot-time devices configured for a resuming VM should be
the same as the devices in the VM at the time of hibernation. It's uncommon
for the configuration to have been changed such that offers are missing.
Changing the configuration violates the rules for hibernation anyway.

> The cleanup of missing channels is not
> straight-forward and dependent on individual device driver
> functionality and implementation, so it can be added in future as
> separate changes.
>=20
> Signed-off-by: John Starks <jostarks@microsoft.com>
> Co-developed-by: Naman Jain <namjain@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
> Changes since v1:
> https://lore.kernel.org/all/20241018115811.5530-1-namjain@linux.microsoft=
.com/
> * Added Easwar's Reviewed-By tag
> * Addressed Saurabh's comments:
>   * Added a note for missing channel cleanup in comments and commit msg
> ---
>  drivers/hv/vmbus_drv.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index bd3fc41dc06b..08214f28694a 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2462,6 +2462,7 @@ static int vmbus_bus_suspend(struct device *dev)
>=20
>  static int vmbus_bus_resume(struct device *dev)
>  {
> +	struct vmbus_channel *channel;
>  	struct vmbus_channel_msginfo *msginfo;
>  	size_t msgsize;
>  	int ret;
> @@ -2494,6 +2495,22 @@ static int vmbus_bus_resume(struct device *dev)
>=20
>  	vmbus_request_offers();
>=20
> +	mutex_lock(&vmbus_connection.channel_mutex);
> +	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
> +		if (channel->offermsg.child_relid !=3D INVALID_RELID)
> +			continue;
> +
> +		/* hvsock channels are not expected to be present. */
> +		if (is_hvsock_channel(channel))
> +			continue;
> +
> +		pr_err("channel %pUl/%pUl not present after resume.\n",
> +			&channel->offermsg.offer.if_type,
> +			&channel->offermsg.offer.if_instance);
> +		/* ToDo: Cleanup these channels here */
> +	}
> +	mutex_unlock(&vmbus_connection.channel_mutex);
> +

Dexuan and John have explained how in Azure VMs, there should not be
any VFs assigned to the VM at the time of hibernation. So the above
check for missing offers does not trigger an error message due to
VF offers coming after the all-offers-received message.

But what about the case of a VM running on a local Hyper-V? I'm not
completely clear, but in that case I don't think any VFs are removed
before the hibernation, especially for VM-initiated hibernation. It's
a reasonable scenario to later resume that same VM, with the same
VF assigned to the VM. Because of the way current code counts
the offers, vmbus_bus_resume() waits for the VF to be offered again,
and all the channels get correct post-resume relids. But the changes
in this patch set break that scenario. Since vmbus_bus_resume() now
proceeds before the VF offer arrives, hv_pci_resume() calling
vmbus_open() could use the pre-hibernation relid for the VF and break
things. Certainly the "not present after resume" error message would
be spurious.

Maybe the focus here is Azure, and it's tolerable for the local Hyper-V
case with a VF to not work pending later fixes. But I thought I'd call
out the potential issue (assuming my thinking is correct).

Michael

>  	/* Reset the event for the next suspend. */
>  	reinit_completion(&vmbus_connection.ready_for_suspend_event);
>=20
> --
> 2.34.1


