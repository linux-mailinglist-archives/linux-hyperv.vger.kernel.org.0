Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE453CBB58
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 19:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhGPRsS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Jul 2021 13:48:18 -0400
Received: from mail-dm6nam11on2090.outbound.protection.outlook.com ([40.107.223.90]:26688
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229462AbhGPRsR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Jul 2021 13:48:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/w0xIDtDH3+8Mhn/Wj+zWPDqyA/yIsoojYP6LWCxukIJa7G0OhlwYjnBhwKDw4qZgp2eb+PFOvNkaTf90+jEtK3YlZE4OGd9qoXod05D4VJQI/MV40ePi9bs3dxyEgcl/9LomaFBjT6cdhkZKP+NSwVQfCpduTioWblzvUBqW0NIPwuGFFUdwhbDy7BxEfGCYrD1Zayqj9Gixey4ivFIBkEnv8FLt4vql7pVRbuvh2c13egvqXh3zjjUclwaIz7VgVnxJ6LyHuAzOkyA4YDh5Q9dkuxNt2EFdSkdHNFTTw6tXFVSfbCsyMkqZmnTdBBk8uQeYdbHiLAdlBtvlPBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq0UFFk/S4Dz2IMeTyyfNi+DMAqP3EmqZUDf/kdJvrI=;
 b=iIK9O+y5HRGRR4hmA0dUUD5wZTcGt67l48dfbGEx8Ixcb2vPZ5DR7GVNcyjBpd2r0PBZBz/R02eLqRIThV5hIn/VpODuFEy6d5tsxdwQq6HjrCsGQe618HCqLsHIi+EW/vkuFH5mZbJToXS1B0MzKr0kY18GKRhih91YhbA9yihF7/w3bj47ulqj5YloqgumYUEPgT/n6DEFnhPw8zTYuVleWDWV9QgWMYjVY5HmwcKy6BdavRp+s4wgzmeYz6apJGF1xppbbMawSR0YDUJ7XEM57vy8ECB4sdIvy1vgummRwoJYqQs/TQ4YcpHWZGv5Q/1TvyhTY3aHpzRMgx5izA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq0UFFk/S4Dz2IMeTyyfNi+DMAqP3EmqZUDf/kdJvrI=;
 b=BDvG2UuBcaOHWi5AUOXdrJ3zLt7RIHkN5sjx7b3wEgpnquXDXPs81VeZEXJ036DSXyXfY0C+lIeMFSXflBpcZDWuxRnyJJnwbXmyzxmt1HpE8D4PX9vY8pzPGe1mDOUeEW6zMeCsWeUSm40ZAJz3ox7BPXc+CJBvudLDJ3tJo10=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB2057.namprd21.prod.outlook.com (2603:10b6:303:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.7; Fri, 16 Jul
 2021 17:45:15 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19%7]) with mapi id 15.20.4331.021; Fri, 16 Jul 2021
 17:45:15 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2,hyperv-fixes] Drivers: hv: vmbus: Fix duplicate CPU
 assignments within a device
Thread-Topic: [PATCH v2,hyperv-fixes] Drivers: hv: vmbus: Fix duplicate CPU
 assignments within a device
Thread-Index: AQHXeeMz61DGX0LK7kKUYpdpjyKtsqtFzALg
Date:   Fri, 16 Jul 2021 17:45:15 +0000
Message-ID: <MWHPR21MB1593ED77DF2C9528269228D9D7119@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1626399458-23990-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1626399458-23990-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7f75105a-0676-4b04-8008-3d2731d1a81d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-16T16:30:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c25251a-f529-44cc-b2fe-08d948817848
x-ms-traffictypediagnostic: MW4PR21MB2057:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB20578CC7711E68E98FC72040D7119@MW4PR21MB2057.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVzlwN+kbGMzo5Zhbxkga37J8ctWBGh63PL5RWsljq+iDGq7ay++6NgHRLmJoXp9QL3d7RkYjofl9iaVT5+XfQrgWTJAnKuaJt5ye9jlNbIOYEsrGZWDJ+8/SX+aFh+XNa1IFt66cQPx35UbK5e5QXgF6tmKXIi/cvNscxsL+2nt61z4FNc9xxGG/PCLLW/KYkfHEFpTfSziyQ2B9Yk0tZi7IfOadFatrDZAdTmRBJyWO6K6sbEw07g9GMkiaExUxKymUyovuC2GIAdTBz+yPGkZqtiCS7Tfb+sjWAYp+n3dF9jLfTrw5NksRVMsetpwXDT7jBhYrLcXznDbz+rSk38VYeUavAJvshnGMLZBSnMURmukdGBADSyWxiPWyphDYcVsWDRnPeoCPJq0Sv0ruFjgUVlK9Njrhsm4W2zQ2R0CYE40t0d5Y9pwgWxakQZCap/i7IYWQCoYGk5jRqx1rR0OqUHt1CesAp8UvfXVfpjmNGTdIZ9RDXyNAo5+pCaT34JTLS8LozcLMI34bjfZieXFW/2KO0rUZzmK0lH0cMF7VYm1K5LQd/1X+SzJnSOeTYRvPk9EvFolVUbE7zILmRmcmJndCrkbwJfm+qgq/LCCbYeUVWbJZrgEZn1x6rqV5BIsGCUiH6CQQ3xe/IVTbxG7YzNdYkIN7yrgcMBXct9TYByLoGjYFxE6cLeqWQ/gbILRMHtiKs0IuCi1Nh12JQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(2906002)(10290500003)(9686003)(122000001)(55016002)(8936002)(8676002)(76116006)(26005)(4326008)(450100002)(186003)(110136005)(38100700002)(316002)(71200400001)(66946007)(66556008)(86362001)(83380400001)(66476007)(66446008)(6506007)(82950400001)(82960400001)(508600001)(8990500004)(52536014)(7696005)(5660300002)(33656002)(64756008)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HGgKnGwa6RYHX2elOXzRC3ueytbZakpUTN4GKSHePupfngpC7wDKpAosauDI?=
 =?us-ascii?Q?sJ7o8cfDEnPAW9Og+bBFFimPsBAQWS37Ieqtk2PkbYcSEHZjtblacIeY1wEC?=
 =?us-ascii?Q?Ssn4DspfIPBLj4y/ssA934G38MwqXNGLwvN34tWIQYoS/P13AuXhzqtNUVzd?=
 =?us-ascii?Q?SNfjuigp3RfRUxz1qZKleKNM9wW3qIjyVwEV0P8ePNe0W7RxODNLA7Y493dt?=
 =?us-ascii?Q?G1/rOhMkxgypmmX1kTrDWmGKrzyiIyBNAsk3h6XAmU1fUc/u4XhFqc9QIE0S?=
 =?us-ascii?Q?uYod6TQLI2eO32U46tdxtMzVV3wMM8kdJbQ12RjaHRtjpsnXnfortqgPH5em?=
 =?us-ascii?Q?Lz+ugUbVzUSb2ezjOFcizlpe7h9373tstl2kHCyp8caDG2TKD0lQh3kx4PnA?=
 =?us-ascii?Q?TZAG0kLglgA5V04h8BvvCd1ELTkxeSylErUFOiDJgY2ZGG2SABJmoCIg4pB7?=
 =?us-ascii?Q?N4AObge7PIVdvWAzA6tQqjYbIYr2XGLMC7OfBU64xJJLtFAFeBFIVtMY6fMb?=
 =?us-ascii?Q?xijEnaSgvWWMQhLgfNRzL+imzhC/kX5+WRLW8vghF4D1eUzNSLIWuIrkyHqU?=
 =?us-ascii?Q?LxCe2b2fdwhZ8WHn4JdsHLUAtFN3CjgP9Og2XmiqVwxSPaddEygQTOdivPA/?=
 =?us-ascii?Q?0LfUKJkO2eH5QbTrV59Ce13XV8tpvE0bTmz+MlqEUc3z8mvozZdjhv1L/l11?=
 =?us-ascii?Q?nMxSgCUU2gFoDjCXsIkoBaQHgZ+zkKIKrGPQNOL6HK8dJAn0IIa4Gji0TJML?=
 =?us-ascii?Q?W0MHQ9o86Ym+IPTVOBIgbAS632AO44woCYIp08pVQuULRuDtTjFQ89TnsImw?=
 =?us-ascii?Q?itQUViUX7stNP/hdRh5r1J+98yLHZ9sasXzQSWrNlayuTTy60Aa27I3pbEjd?=
 =?us-ascii?Q?iXxFJskJwAg/ujdfUBxwj6VV0LBnCd7OXpdm4aNnp6yuO/NYxb4gvc6ExELd?=
 =?us-ascii?Q?kfqMbEpMqwu+hUnljO2R2JGhiNpyiw+zWCSabAQj09hdvgf/IwSAe/Cdugyr?=
 =?us-ascii?Q?6SFx5Fw/61iFml8NWQpfbWdzaqdnOWNa14cCKXJrcwR5nAd8Yj/u1I4PMqJ2?=
 =?us-ascii?Q?H9reFBieoWgT52pQIouZGLE4AAIgJNX4PvLJNvOUkYRZFPGGFwmDmwYpBgHn?=
 =?us-ascii?Q?lFPZxLeqaXjxpxMTGW++SslkiHSe/NFy7RHVdlfTKzH5g5bm5Si7ML63DAK8?=
 =?us-ascii?Q?ywH20V7Tzfh2pcr3qS6/WOa2OoNo6MR/z3gH+1JSiik1g800MX3uAW+zKuaf?=
 =?us-ascii?Q?3EXp8TngqJyUqM1SkL9PUDOqYe3MLmxvdfOR7T79bXUkmOBIJ0Yy4mN/Yf3W?=
 =?us-ascii?Q?E4/T/uanDnD6Q3FwfajT3aQF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c25251a-f529-44cc-b2fe-08d948817848
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 17:45:15.3928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VArFSmdfpLUejHqRENhFFXGIc780AjQSmdxcZFJY74rNM2CRJ9wO0m+bb+gWeKND0JWZXfXUdH7wTm0equ6SZcg7fm28AZtO++E8L2g1RPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2057
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang Zhang Sent=
: Thursday, July 15, 2021 6:38 PM
>=20
> The vmbus module uses a rotational algorithm to assign target CPUs to
> device's channels. Depends on the timing of different device's channel

s/device's/a device's/
s/Depends/Depending/

> offers, different channels of a device may be assigned to the same CPU.
>=20
> For example on a VM with 2 CPUs, if NIC A and B's channels are offered
> in the following order, NIC A will have both channels on CPU0, and
> NIC B will have both channels on CPU1 -- see below. This kind of
> assignment causes RSS load that is spreading across different channels
> to end up on the same CPU.
>=20
> Timing of channel offers:
> NIC A channel 0
> NIC B channel 0
> NIC A channel 1
> NIC B channel 1
>=20
> VMBUS ID 14: Class_ID =3D {f8615163-df3e-46c5-913f-f2d2f965ed0e} - Synthe=
tic network adapter
>         Device_ID =3D {cab064cd-1f31-47d5-a8b4-9d57e320cccd}
>         Sysfs path: /sys/bus/vmbus/devices/cab064cd-1f31-47d5-a8b4-9d57e3=
20cccd
>         Rel_ID=3D14, target_cpu=3D0
>         Rel_ID=3D17, target_cpu=3D0
>=20
> VMBUS ID 16: Class_ID =3D {f8615163-df3e-46c5-913f-f2d2f965ed0e} - Synthe=
tic network adapter
>         Device_ID =3D {244225ca-743e-4020-a17d-d7baa13d6cea}
>         Sysfs path: /sys/bus/vmbus/devices/244225ca-743e-4020-a17d-d7baa1=
3d6cea
>         Rel_ID=3D16, target_cpu=3D1
>         Rel_ID=3D18, target_cpu=3D1
>=20
> Update the vmbus CPU assignment algorithm to avoid duplicate CPU
> assignments within a device.
>=20
> The new algorithm iterates num_online_cpus + 1 times.
> The existing rotational algorithm to find "next NUMA & CPU" is still here=
.
> But if the resulting CPU is already used by the same device, it will try
> the next CPU.
> In the last iteration, it assigns the channel to the next available CPU
> like the existing algorithm. This is not normally expected, because
> during device probe, we limit the number of channels of a device to
> be <=3D number of online CPUs.
>=20
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 96 ++++++++++++++++++++++++++-------------
>  1 file changed, 64 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index caf6d0c4bc1b..8584914291e7 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -605,6 +605,17 @@ static void vmbus_process_offer(struct vmbus_channel=
 *newchannel)
>  	 */
>  	mutex_lock(&vmbus_connection.channel_mutex);
>=20
> +	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
> +		if (guid_equal(&channel->offermsg.offer.if_type,
> +			       &newchannel->offermsg.offer.if_type) &&
> +		    guid_equal(&channel->offermsg.offer.if_instance,
> +			       &newchannel->offermsg.offer.if_instance)) {
> +			fnew =3D false;
> +			newchannel->primary_channel =3D channel;
> +			break;
> +		}
> +	}
> +
>  	init_vp_index(newchannel);
>=20
>  	/* Remember the channels that should be cleaned up upon suspend. */
> @@ -617,16 +628,6 @@ static void vmbus_process_offer(struct vmbus_channel=
 *newchannel)
>  	 */
>  	atomic_dec(&vmbus_connection.offer_in_progress);
>=20
> -	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
> -		if (guid_equal(&channel->offermsg.offer.if_type,
> -			       &newchannel->offermsg.offer.if_type) &&
> -		    guid_equal(&channel->offermsg.offer.if_instance,
> -			       &newchannel->offermsg.offer.if_instance)) {
> -			fnew =3D false;
> -			break;
> -		}
> -	}
> -
>  	if (fnew) {
>  		list_add_tail(&newchannel->listentry,
>  			      &vmbus_connection.chn_list);
> @@ -647,7 +648,6 @@ static void vmbus_process_offer(struct vmbus_channel =
*newchannel)
>  		/*
>  		 * Process the sub-channel.
>  		 */
> -		newchannel->primary_channel =3D channel;
>  		list_add_tail(&newchannel->sc_list, &channel->sc_list);
>  	}
>=20
> @@ -683,6 +683,30 @@ static void vmbus_process_offer(struct vmbus_channel=
 *newchannel)
>  	queue_work(wq, &newchannel->add_channel_work);
>  }
>=20
> +/*
> + * Check if CPUs used by other channels of the same device.
> + * It's should only be called by init_vp_index().

s/It's/It/

> + */
> +static bool hv_cpuself_used(u32 cpu, struct vmbus_channel *chn)
> +{
> +	struct vmbus_channel *primary =3D chn->primary_channel;
> +	struct vmbus_channel *sc;
> +
> +	lockdep_assert_held(&vmbus_connection.channel_mutex);
> +
> +	if (!primary)
> +		return false;
> +
> +	if (primary->target_cpu =3D=3D cpu)
> +		return true;
> +
> +	list_for_each_entry(sc, &primary->sc_list, sc_list)
> +		if (sc !=3D chn && sc->target_cpu =3D=3D cpu)
> +			return true;
> +
> +	return false;
> +}
> +
>  /*
>   * We use this state to statically distribute the channel interrupt load=
.
>   */
> @@ -702,6 +726,7 @@ static int next_numa_node_id;
>  static void init_vp_index(struct vmbus_channel *channel)
>  {
>  	bool perf_chn =3D hv_is_perf_channel(channel);
> +	u32 i, ncpu =3D num_online_cpus();
>  	cpumask_var_t available_mask;
>  	struct cpumask *alloced_mask;
>  	u32 target_cpu;
> @@ -724,31 +749,38 @@ static void init_vp_index(struct vmbus_channel *cha=
nnel)
>  		return;
>  	}
>=20
> -	while (true) {
> -		numa_node =3D next_numa_node_id++;
> -		if (numa_node =3D=3D nr_node_ids) {
> -			next_numa_node_id =3D 0;
> -			continue;
> +	for (i =3D 1; i <=3D ncpu + 1; i++) {
> +		while (true) {
> +			numa_node =3D next_numa_node_id++;
> +			if (numa_node =3D=3D nr_node_ids) {
> +				next_numa_node_id =3D 0;
> +				continue;
> +			}
> +			if (cpumask_empty(cpumask_of_node(numa_node)))
> +				continue;
> +			break;
> +		}
> +		alloced_mask =3D &hv_context.hv_numa_map[numa_node];
> +
> +		if (cpumask_weight(alloced_mask) =3D=3D
> +		    cpumask_weight(cpumask_of_node(numa_node))) {
> +			/*
> +			 * We have cycled through all the CPUs in the node;
> +			 * reset the alloced map.
> +			 */
> +			cpumask_clear(alloced_mask);
>  		}
> -		if (cpumask_empty(cpumask_of_node(numa_node)))
> -			continue;
> -		break;
> -	}
> -	alloced_mask =3D &hv_context.hv_numa_map[numa_node];
>=20
> -	if (cpumask_weight(alloced_mask) =3D=3D
> -	    cpumask_weight(cpumask_of_node(numa_node))) {
> -		/*
> -		 * We have cycled through all the CPUs in the node;
> -		 * reset the alloced map.
> -		 */
> -		cpumask_clear(alloced_mask);
> -	}
> +		cpumask_xor(available_mask, alloced_mask,
> +			    cpumask_of_node(numa_node));
>=20
> -	cpumask_xor(available_mask, alloced_mask, cpumask_of_node(numa_node));
> +		target_cpu =3D cpumask_first(available_mask);
> +		cpumask_set_cpu(target_cpu, alloced_mask);
>=20
> -	target_cpu =3D cpumask_first(available_mask);
> -	cpumask_set_cpu(target_cpu, alloced_mask);
> +		if (channel->offermsg.offer.sub_channel_index >=3D ncpu ||
> +		    i > ncpu || !hv_cpuself_used(target_cpu, channel))
> +			break;
> +	}
>=20
>  	channel->target_cpu =3D target_cpu;
>=20
> --
> 2.25.1

I like this approach much better.  I did some testing with a variety of
CPU counts (1, 2, 3, 4, 8, and 32), NUMA nodes (1, 3, and 4) and with
4 SCSI controllers and 4 NICs.  Everything worked as expected, and it's
definitely an improvement.

I flagged a couple of typos/wording errors, but maybe they can be
fixed when the patch is pulled into hyperv-fixes.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
