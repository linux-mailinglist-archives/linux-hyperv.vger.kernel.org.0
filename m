Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56883CA53F
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jul 2021 20:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhGOSVK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Jul 2021 14:21:10 -0400
Received: from mail-co1nam11on2127.outbound.protection.outlook.com ([40.107.220.127]:7554
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237945AbhGOSVK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Jul 2021 14:21:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mp1OSB1fH0aSiq5BCVQBaIPjAWF9OKnNg4/5NY6l1y+0jGaBjQxfdTKBYuckR3PBqiKQcxXExRqdbbT05RrklVlWTdslJo/9GxWF3eYmuNwWiOzrCFuWZkRZKzAtdZWKwWbg+Smbkz/G2emWCFVcpQKhsp8AaRzZQ2Xpn7lr8Kng6Qv0sPlgl2UbuWDAor9NSDpcOpSA+stEP3nXjPPRcn57gERcrLRnr3AU1NWeRYUCWt+hHxrhIoOJ/9Hs1ZOc/akpILEIr6Fq1v2Qb2yRivE126Oy5xULN1y6YsIedrBuzspjoSMcs6ACz6TN8+VnSLj0Wcksc2GRxrNXuq0+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+xvexA/cvM0PjH1mM0+A6ZfhrIvcebfN1yf9E0KMmo=;
 b=HyEf1IFxjbdcZ+ztzqpqbsjQVgW9KEAQxBXJOY+curCh/RSLZZT++Jf6NwIKMXLPxWbj7Dkf0bhAFXZqjic3bi/aNN8usWKEYKVEQhPf7R8rfDQPEpow2Azp4CP0qmcpbc7M9H/RUpjJ1kGu6E7HTth4DePl5cL+WXpHN7dzlkVqVYkm8pSvhy/uvpMkTXIstQ7Y4pwXhqEbZvvFwKsa3lGN+IGwuJSEUHYsqbg7cOknIUb9W3wbPbS4Y4jusi8nQ9FnURdZ9EY9DKoxU/bLqjNG3NWA0pb/YiIxkR937KLhjBTkLxGogZRqeneMK5s/eut+MPpZCbcsPS8y9nxrhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+xvexA/cvM0PjH1mM0+A6ZfhrIvcebfN1yf9E0KMmo=;
 b=NpRaUYMrXkOHr/UqbatNGz22oehg7MqUpeAghBUEw1AW+cMHn0Z1vja0AINqjcIR4RUtxxZ+G6glzQdTAXdqvIojeaqpp6CcmXx4B4oKCxUlsbpJm15nlI0dUO3/ShgIw/iWXypQy4OZh3f5AZ8TQPlls0b2W2L6vT+bq28t2OA=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB0938.namprd21.prod.outlook.com (2603:10b6:302:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.8; Thu, 15 Jul
 2021 18:18:14 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19%7]) with mapi id 15.20.4331.021; Thu, 15 Jul 2021
 18:18:14 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH hyperv-fixes] Drivers: hv: vmbus: Fix duplicate CPU
 assignments within a device
Thread-Topic: [PATCH hyperv-fixes] Drivers: hv: vmbus: Fix duplicate CPU
 assignments within a device
Thread-Index: AQHXeZQLGo77qUjRL0m52a3JrVI0uKtEU0Fw
Date:   Thu, 15 Jul 2021 18:18:14 +0000
Message-ID: <MWHPR21MB1593D479F9339821218AB0A2D7129@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1626365442-28869-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1626365442-28869-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=69d0e597-c308-4261-8955-06ca0ba7492c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-15T17:59:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 692c2b0f-b34a-41e1-04ff-08d947bce9a5
x-ms-traffictypediagnostic: MW2PR2101MB0938:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB093898CBC13602C92FB5EB9BD7129@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:370;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /pcqvf2rGMk5ZymPMwLUiDLs+Vhh5znnFes4OlPL6fe0/5vq6G13Azj63o41OAZ73/SQadn1dZGaGAfAkL7dClBFFI92E50aJOgsWaATkzQ4zjnzdw5DXTV6Kr7H+YNIFxv8eIuzoQG0OVpHOuLUlXrAQZ36h6vRYyuftiqtafHJijKPLfMA+HKeuSIphps60Aa+QXokRGak2eWE1xQR29ZfTWVN2bi6nBzNdoqyymWt5CuJ1eiL4otJUsvk+DsCnPqR49e5m9cdQmQwWZEqAxSjYFouqMy2hrNTk0dhXbx6R6au1wUc0QxFRiAJFrvL2lbjotlKzEYwlwlfGh6bF7pUTgi32E6PWaoeHbGCglUUoXDHBGmddduSvMo8TCX9pbhSoLdy651FhohE3HlPhtXKFchahQ8Q/wkyNMtvNKa0JxhpCSpqgFrxJ2GnLPVxKkzdz6MSs9dtn1viIf/1gA8+LFZoh+mbLTVtBvWFD6oFTlD45KBsB+/EgkQc+0nRIdHKzAUzIHIPuS0JVZo7R7xelabe2PMD+lCwH1ruYhGrfHCQRS9qheKoRtTbMH+mXIoE8WWQGj9yka9luOSWcXa8vgRKTCFvSMuD7jmxIsAD6u4ZIEDqaJqVz04WXtM48OKk5cHKcjWoeeerfycotDZxju3xZumL0YqZPR81s3A+2MCDcoJ6BjHeR/fODWMYsZmJzRXfHBVBzyzgfOECiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66946007)(8990500004)(64756008)(66446008)(26005)(186003)(66556008)(66476007)(33656002)(82960400001)(82950400001)(83380400001)(9686003)(55016002)(8936002)(2906002)(86362001)(5660300002)(450100002)(4326008)(6506007)(8676002)(10290500003)(71200400001)(122000001)(54906003)(7696005)(478600001)(316002)(38100700002)(52536014)(110136005)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t4mPaf7oGU2moOIIfEnyhSgtWtdZHVj8J8DJW9eiutppTqx9rhgTYO2F6Nwi?=
 =?us-ascii?Q?U8jYF6DxJ6HLaTgrMOiUOMAxzqiKgktqzJeD3iaI4Q/wYYPPlqA8EEmrdKNC?=
 =?us-ascii?Q?hhPSoZBhLide+mqZFCtRttRchJUj0pjdiwIwjSdzyOTUP/6PvwraKC7WijmV?=
 =?us-ascii?Q?NZcFZbg7cTnf6GaMRTb0IjJOwTYDeN7Ckk0gYpPMlOKN6TNNhkHUuGLnVL2f?=
 =?us-ascii?Q?tC4yRzEplkGqK3RBJZbUlUAMKBDyhjqtlXny2zGJ0SmHd6wm8tJK/6lS+UtZ?=
 =?us-ascii?Q?BuzrtueofQbwlNW5oaJZ/dgFEoae961Fi3gy2MEpURA+KOEpjzqZVBWQ94ZC?=
 =?us-ascii?Q?oHq/TlVO2WLLe9pFcnaFRlWz+JJ/z4Kat10q3AMzfx7t58h5MGuUMkDYCKpy?=
 =?us-ascii?Q?MUfc6nZ0z5B0IoLqU3+wjbsNdp0503LYa+U25Hcky59K2DzqL5LFnSDDAQ1O?=
 =?us-ascii?Q?HaJwS4JXQGBZhsdoPgH4EwQTrl9HMbtVPdNcH+r0/53grWL4vw4YSAa2wcEb?=
 =?us-ascii?Q?t+z/XeI+sxvlk3zDts1udEwB1F1yMtxnas5UCgRecFCa6/6TrMwdPi7LjtFB?=
 =?us-ascii?Q?EyipOl44xdJtlSY/p9K3WHMJeLa1Xkjm6YRUFXpkJklFlAF8N7fgfcAv2xkd?=
 =?us-ascii?Q?yEjA8iMK+dboCpm/Q6tO76GRJIgV+TTPILAHSg06DpAZso0i3I5ihLxZTH1v?=
 =?us-ascii?Q?8tC11Q5AFIG4kkXqxFAKgcSBlZZSK6wgYUEEMqMXUEOAw5dOCV+JvLcF1yVp?=
 =?us-ascii?Q?/Xp7uSZYAUpOe7sbFKcWQJnZwg1Xfgh/3MaNacG84/vmpguQ4EWlsuKzlxlC?=
 =?us-ascii?Q?m0JodRZHR99btLW1itUZfIXWNhcSE/ljdvZGH1wBOownnTBLHieEmTa7cO0b?=
 =?us-ascii?Q?uNWKirv3ogPugUTk3LF8EPCETXw4kQqN1wj2Ech+Pequ4+kcuXTNfkNMKxtB?=
 =?us-ascii?Q?kmdlEjd9nFCmNkxpJpjP50hhy5IbDFJQxdNfMRsSUy6NWmXW4YWsLhK0m/UY?=
 =?us-ascii?Q?dh/Qt/sMGlPsfALY/v9u5NiSeZkg52NGqjIFxIBPZCPqNwX3HojfsmTqFLic?=
 =?us-ascii?Q?bI8Xn5X61P2ySbab40B7PFpomyymWWu2wBg1NqLNBqVutkyGpruM5h4GWE0k?=
 =?us-ascii?Q?1JAZPjHv0NvXuOAxm2PUbY7BCwftheRiTLc1jRGvkBborPl6BJft2zBfw7vD?=
 =?us-ascii?Q?GPtPNhkhprtPAvnFvg5xQwAOJxd2WBf9YI0Q7AZLA/mOgIBsNR4vTUt/uixE?=
 =?us-ascii?Q?GYrPgZVMIEId5EgSMEvILZ+INfCWXfEi0n07wIWu+dKWDD+l6Mn7PjTWaB/Q?=
 =?us-ascii?Q?aTCMHfDo399LUXu8lxhq0/Hw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692c2b0f-b34a-41e1-04ff-08d947bce9a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 18:18:14.8166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/euhEtJsAQGJrY0Z9HIvPTIZOgYRsS9/jTJjnxt4WABxAEPqllVFGvEE7xxJ+a1QYG/Fa0Wx4LjPBndOj+xCBBf1aXd0r5iOiXkSSjWwmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang Zhang Sent=
: Thursday, July 15, 2021 9:11 AM
>=20
> The vmbus module uses a rotational algorithm to assign target CPUs to
> device's channels. Depends on the timing of different device's channel
> offers, different channels of a device may be assigned to the same CPU.
>=20
> For example on a VM with 2 CPUs, if the NIC A and B's channels offered

s/the NIC A/NIC A/
s/offered/are offered/

> in the following order, the NIC A will have both channels on CPU0, and

s/the NIC A/NIC A/

> NIC B will have both channels on CPU1 -- see below. This kind of
> assignments cause RSS spreading loads among different channels ends up

"assignment causes RSS load that is spread across different channels to end=
 up"

> on the same CPU.
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
>=20
> Update the vmbus' CPU assignment algorithm to avoid duplicate CPU

s/vmbus'/vmbus/

> assignments within a device.
>=20
> The new algorithm iterates 2 * #NUMA_Node + 1 times. In the first
> round of checking all NUMA nodes, it tries to find previously unassigned
> CPUs by this and other devices. If not available, it clears the
> allocated CPU mask.
> In the second round, it tries to find unassigned CPUs by the same
> device.
> In the last iteration, it assigns the channel to the first available CPU.
> This is not normally expected, because during device probe, we limit the
> number of channels of a device to be <=3D number of online CPUs.
>=20
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>=20
> ---
>  drivers/hv/channel_mgmt.c | 95 ++++++++++++++++++++++++++-------------
>  1 file changed, 65 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index caf6d0c4bc1b..fbddc4954f57 100644
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
> @@ -683,6 +683,29 @@ static void vmbus_process_offer(struct vmbus_channel=
 *newchannel)
>  	queue_work(wq, &newchannel->add_channel_work);
>  }
>=20
> +/*
> + * Clear CPUs used by other channels of the same device.
> + * It's should only be called by init_vp_index().
> + */
> +static bool hv_clear_usedcpu(struct cpumask *cmask, struct vmbus_channel=
 *chn)
> +{
> +	struct vmbus_channel *primary =3D chn->primary_channel;
> +	struct vmbus_channel *sc;
> +
> +	lockdep_assert_held(&vmbus_connection.channel_mutex);
> +
> +	if (!primary)
> +		return !cpumask_empty(cmask);

Minor note:  As this function is currently used, the cmask parameter should
never be empty.  Calling cpumask_empty() doesn't hurt anything but
this line should always return "true".

> +
> +	cpumask_clear_cpu(primary->target_cpu, cmask);
> +
> +	list_for_each_entry(sc, &primary->sc_list, sc_list)
> +		if (sc !=3D chn)
> +			cpumask_clear_cpu(sc->target_cpu, cmask);
> +
> +	return !cpumask_empty(cmask);
> +}
> +
>  /*
>   * We use this state to statically distribute the channel interrupt load=
.
>   */
> @@ -705,7 +728,7 @@ static void init_vp_index(struct vmbus_channel *chann=
el)
>  	cpumask_var_t available_mask;
>  	struct cpumask *alloced_mask;
>  	u32 target_cpu;
> -	int numa_node;
> +	int numa_node, i;
>=20
>  	if ((vmbus_proto_version =3D=3D VERSION_WS2008) ||
>  	    (vmbus_proto_version =3D=3D VERSION_WIN7) || (!perf_chn) ||
> @@ -724,29 +747,41 @@ static void init_vp_index(struct vmbus_channel *cha=
nnel)
>  		return;
>  	}
>=20
> -	while (true) {
> -		numa_node =3D next_numa_node_id++;
> -		if (numa_node =3D=3D nr_node_ids) {
> -			next_numa_node_id =3D 0;
> -			continue;
> +	for (i =3D 1; i <=3D nr_node_ids * 2 + 1; i++) {
> +		while (true) {
> +			numa_node =3D next_numa_node_id++;
> +			if (numa_node =3D=3D nr_node_ids) {
> +				next_numa_node_id =3D 0;
> +				continue;
> +			}
> +			if (cpumask_empty(cpumask_of_node(numa_node)))
> +				continue;

This test has the potential to get the next_numa_node_id value out of sync
with the index "i" in the containing "for" loop.  The intent is to go throu=
gh all
NUMA nodes up to 2 times, plus 1 more time.  But if a NUMA node is encounte=
red
with no online CPUs, next_numa_node_id may get incremented multiple times
in a single iteration of the "for" loop.  So you could end up cycling throu=
gh some
of the NUMA nodes more than twice before doing the final iteration.

> +			break;
>  		}
> -		if (cpumask_empty(cpumask_of_node(numa_node)))
> -			continue;
> -		break;
> -	}
> -	alloced_mask =3D &hv_context.hv_numa_map[numa_node];
> +		alloced_mask =3D &hv_context.hv_numa_map[numa_node];
> +
> +		if (cpumask_weight(alloced_mask) =3D=3D
> +		    cpumask_weight(cpumask_of_node(numa_node))) {
> +			/*
> +			 * We have cycled through all the CPUs in the node;
> +			 * reset the alloced map.
> +			 */
> +			cpumask_clear(alloced_mask);
> +		}
> +
> +		cpumask_xor(available_mask, alloced_mask,
> +			    cpumask_of_node(numa_node));
> +
> +		/* Try to avoid duplicate cpus within a device */
> +		if (channel->offermsg.offer.sub_channel_index >=3D
> +		    num_online_cpus() ||
> +		    i > nr_node_ids * 2 ||
> +		    hv_clear_usedcpu(available_mask, channel))
> +			break;
>=20
> -	if (cpumask_weight(alloced_mask) =3D=3D
> -	    cpumask_weight(cpumask_of_node(numa_node))) {
> -		/*
> -		 * We have cycled through all the CPUs in the node;
> -		 * reset the alloced map.
> -		 */
>  		cpumask_clear(alloced_mask);

This clearing of the "alloced_mask" concerns me.  It is done incrementally
as the NUMA nodes are cycled through the first time.  So if an available CP=
U
is found in the 3rd NUMA node on the first cycle, the alloced_mask will
have been cleared for NUMA nodes 0, 1, and 2.  A subsequent call to
this function for a different device will find the CPUs in those NUMA nodes
unalloc'ed, and therefore useable.  It seems like this will tend to bunch t=
he CPU
assignments across multiple devices much more toward NUMA node 0 than
the existing algorithm does.  Or am I missing something about how this work=
s?

Michael

>  	}
>=20
> -	cpumask_xor(available_mask, alloced_mask, cpumask_of_node(numa_node));
> -
>  	target_cpu =3D cpumask_first(available_mask);
>  	cpumask_set_cpu(target_cpu, alloced_mask);
>=20
> --
> 2.25.1

