Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E751A3CBB60
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 19:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhGPRu5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Jul 2021 13:50:57 -0400
Received: from mail-co1nam11on2137.outbound.protection.outlook.com ([40.107.220.137]:48320
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230476AbhGPRu5 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Jul 2021 13:50:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xk+HJpkY4ot9DDP3Ka6psdw4BHr6l75zcxH4DChcY+8+3LcXywXB6Ydl/eNBH8X1KLAFgVKzTfV1cxFtLB8wgkrs4tUaEi7plpng5v+3UuZCn64xcuX1MReksMK7+34YOcF6o3fHV8rVEojhHDD4zlRUfFcGxPA/blbejnrR2Erfxq62war2CQ9jKsubhOH9h44ydmCuLIsMTz7AnWQOTBr3W6iESqZQNscIPTtfYGeOhaGcKAYbvwVGDi6HcoN/leMx02SfB/XJHtZ/6qO22VTPJVeOWgR9l19HJOl9LgjljlGv4PWfKzyxdtjFZZparnJiBNiYX+Mozd2/63r0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IwzyCkcsKg4+wunNh9E1hstBDMeqrH0rN+K33lCleg=;
 b=jbaQzPwXKYt5unQSIvS4MLf/HzpsIMzQ4A5IkeB6k7oTg0P7Na39f1MNM9UtBNIyCNMlITqLU/+GVlu/eU/48Il5jLWAndlPaExzYdMKqB6+euDJZeklyRnDtXXqbDZB1sJYrmaafDSIeXGcJPUlAC6xUfG6Js88BdAjAczaaWrSlLgptQabmdIBIDNpCEUOfx+xMlVQDBpna0Sc6x2tWZ0WNsEWNRQzgVv+MVLOZ9WfyJLJAAlBUXiBQ13chJ7yj8Bc1yMIL6hah7T25t9LowUUA6kpgwULMr/kvBsCxnYjmpOSKFm9hkMD+IWlAYrMDKGOEcwZKNtWCEfRkbAhQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IwzyCkcsKg4+wunNh9E1hstBDMeqrH0rN+K33lCleg=;
 b=ablNSAx+aaXbxI+4sw7zoVk16/K4klxbL02fDRViC7MQcsBlo1w/9dSgEQR0dNEmIRJdihHq8f8olqbMlDJAqcvwVtJ9Y0JjuIRdeSSNs3tq+zoVXhO1PaBYVxA2AYlKi0hhNFJSnkHjzoe+Az8L0wyjQhg1qjwH9+/zhFlk10k=
Received: from MN2PR21MB1295.namprd21.prod.outlook.com (2603:10b6:208:3e::25)
 by MN2PR21MB1408.namprd21.prod.outlook.com (2603:10b6:208:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.4; Fri, 16 Jul
 2021 17:47:59 +0000
Received: from MN2PR21MB1295.namprd21.prod.outlook.com
 ([fe80::d830:2bfc:3f18:2056]) by MN2PR21MB1295.namprd21.prod.outlook.com
 ([fe80::d830:2bfc:3f18:2056%7]) with mapi id 15.20.4331.014; Fri, 16 Jul 2021
 17:47:59 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2,hyperv-fixes] Drivers: hv: vmbus: Fix duplicate CPU
 assignments within a device
Thread-Topic: [PATCH v2,hyperv-fixes] Drivers: hv: vmbus: Fix duplicate CPU
 assignments within a device
Thread-Index: AQHXeeMv5XS3+YJk/Eq4N2cAv7ki46tF4OSAgAAAY3A=
Date:   Fri, 16 Jul 2021 17:47:58 +0000
Message-ID: <MN2PR21MB1295D09F6384167C2D063557CA119@MN2PR21MB1295.namprd21.prod.outlook.com>
References: <1626399458-23990-1-git-send-email-haiyangz@microsoft.com>
 <MWHPR21MB1593ED77DF2C9528269228D9D7119@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB1593ED77DF2C9528269228D9D7119@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7f75105a-0676-4b04-8008-3d2731d1a81d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-16T16:30:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 583a9908-6a71-404f-5f99-08d94881d9f8
x-ms-traffictypediagnostic: MN2PR21MB1408:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR21MB1408275274E8FCB81AFFDF13CA119@MN2PR21MB1408.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3I4+0PYaczmMmvFBleSxuWLIUVqA2aQj4yjEKabxeCpNC/Q2P9/xdUf1ynkOtaU0wm0hod3+TYsFfGoYzhR5BFbdgro+rHjCCNneExLSmIfVgQMsANHdGaW18XLTAQqtdTBDCu+etXz/RQuyRIp6aB0OYJALuyqGSS7J5ofC0pgJ7fv06c+hjBV8gng4ZMMbPOzG0yFLYOsBfei/Or0hWh/IE/k35Bq7/gIAtd3ymTvpSUh1oL/gZ9+qxJXKP+EGvxE0bG5IyrfZFfzrys0Eq5XQiA9eX2V+n0zKs5g9HFkTs+odA2dcgQeCOUytsEt9Ureqh7/sMeAjeZgxJAAk89BKHOyAO98IrV2UGzvHlXeaxfadn2X8NXAk0KdTJdTiLnjUaaq18nMkF3E+TbWvH6GApi2P8Y6dBj4mO80ho2w1qlr1Vey5IZ2Ea9FjHHCLjLfGVuOVlxi+3xdY2lASA5Htre2fNemza1CmIdVQBTXzzfooEsYXiUWk1I9mfwD2qwXAnSxNd2lj1Trcv9/nLfaLhU9NIYJS+fk+O8FSeFJw99pPeQxj6wRTTWP7IlTLxH9jp3QkRi12hs3KSnSENHbCE+4zoLAERlULloVnSVirHKXrgbBYUMU4svJihFLQKRDbhQ9+NishMjrPOkGhXuPR2KHgJK7NmgZrg1kcKsAXKilGYkg3Xeyyf47y1tb/Fw2dH9ub2EMYlb4elrmTKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1295.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(508600001)(7696005)(52536014)(83380400001)(10290500003)(110136005)(82950400001)(8990500004)(8676002)(53546011)(76116006)(6506007)(66946007)(82960400001)(316002)(66446008)(8936002)(66476007)(66556008)(64756008)(54906003)(55016002)(4326008)(186003)(450100002)(9686003)(71200400001)(33656002)(86362001)(2906002)(5660300002)(26005)(38100700002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dprELvV/tm6sePac8tlhJrTOeBu+skqHXflc2btN97rLHO+FEnMjh+kgnvMQ?=
 =?us-ascii?Q?VDuCoY7B2pi84WD72SOrSlhBSvia+z+9HzqoqK1nlWZ3UyX8g0WYunbrLBzo?=
 =?us-ascii?Q?6YhBtHf+j19WzmbYr6unD5cuPeiuMitu1r7d2WNNh6ZQ6508TKTkI11lvY62?=
 =?us-ascii?Q?T9T/0uPNn/uPJ49fNkM1tEyV2i1P+i/499uU/dasNBGsdRuqg+NZAPsMhDXd?=
 =?us-ascii?Q?lQDD/7v4ADkrjrF1pyWBAdRkcB3/KEDelxF1KfTOiCJBdzRTwYcV2RQoFk92?=
 =?us-ascii?Q?h7VfaGZGmcHJvc/9I5SeFXx8auyy4fXJr3yg1HPRVLGkz+VODFm7wCMarPhJ?=
 =?us-ascii?Q?tn5hh/6vliLuqTkVOLxs9F48kDEhxVJ++J2YhsSD8Rf8JPqoS5NLbVEkXe+w?=
 =?us-ascii?Q?nvvk+Wv8NP0+extsRTkOgLdaZYUGBCgN1bcWZglGeP2MoDrDVIhVPpg1T40d?=
 =?us-ascii?Q?irGwPdW6+HHiB9o6WDWOp79Mw+EBSWEu3p/x3tdetkQek8pwr+MelFyFRy4Z?=
 =?us-ascii?Q?9OKf/3DV7jMxFewmg0O2PQWp5zEedlkwt3WuGSUN/e7Z7LshgZQUaMNQvRf/?=
 =?us-ascii?Q?mCh0hY9HqnylNY+K7PwSbICjo8JkxnYbnAYHNIcMVhU/r366pxMAdAK8VDHQ?=
 =?us-ascii?Q?+51SEYSMwNSBU+ECgA1e9B1uCaCfCSb5BIgq+4UEqqrLcl3CoJnl87iDACMv?=
 =?us-ascii?Q?UdYCXjJQRO6m4Pl8qH1k29EH26LVxCR78wgLTKfy1CgzJH0TGeHk+tEIpk1I?=
 =?us-ascii?Q?TAM/FJneo+IUoCWlBaOgQM2eODNoSWBVXBANYMoD/+bHfph0/bVN//scOfVB?=
 =?us-ascii?Q?oL70gJYMfct3avwLfgPBQ73Ip2EcQ1p8m04+ARATTfvlbcRfYvD5BaW/HDcL?=
 =?us-ascii?Q?muQPZiVKKs76dETq8P9DE9/zpMFFUI+pBYgllNYcNaZJ0WsU4t1Kisj18SBe?=
 =?us-ascii?Q?1v4/LqCtOlXqwUUo74wzugHtzIE1AExS7bSRMv2KB5KgBd75pt34XrFLk6Cf?=
 =?us-ascii?Q?JGf8FpZMkHZCURluG/uyOJxwYYtRd1bSEbW1XEcp14qXfzsLcoC1i4YOYgYl?=
 =?us-ascii?Q?nXGtikNk6hgVciKc24FLADroRv4aV7EMUOc82zlcXckuhw3DLgF2BTtZmO9h?=
 =?us-ascii?Q?y7Cf23biITFBA4MXHHHapGuzKqlsMzav4ZS2Nb2wqq3O2kBTHjcEo7tcj5Ia?=
 =?us-ascii?Q?fe7lKyat6X45AiPedK3L8HNUYey9cRWDEzFNtDjjqBZXc7kyMFYnEWCbAIHC?=
 =?us-ascii?Q?IkuGSX7IVmMZ6KoDDA/voeAMLwkQNRzxa1CiBsOma/ZDFmx36j3/O4eGgdk5?=
 =?us-ascii?Q?CUL4k2abqdM9amuRqIabKGmo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1295.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583a9908-6a71-404f-5f99-08d94881d9f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 17:47:59.1491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQjmxQ4vAPJL/jpghQUgBnM/pPfxsU6pXvVF+68dabQfjJmWLp7yGv4OilIiVPuT4CtxjVroTuW/vslrmt4xJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1408
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Friday, July 16, 2021 1:45 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>; linux-
> hyperv@vger.kernel.org
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v2,hyperv-fixes] Drivers: hv: vmbus: Fix duplicate CP=
U
> assignments within a device
>=20
> From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang Zhang
> Sent: Thursday, July 15, 2021 6:38 PM
> >
> > The vmbus module uses a rotational algorithm to assign target CPUs to
> > device's channels. Depends on the timing of different device's channel
>=20
> s/device's/a device's/
> s/Depends/Depending/
>=20
> > offers, different channels of a device may be assigned to the same CPU.
> >
> > For example on a VM with 2 CPUs, if NIC A and B's channels are offered
> > in the following order, NIC A will have both channels on CPU0, and NIC
> > B will have both channels on CPU1 -- see below. This kind of
> > assignment causes RSS load that is spreading across different channels
> > to end up on the same CPU.
> >
> > Timing of channel offers:
> > NIC A channel 0
> > NIC B channel 0
> > NIC A channel 1
> > NIC B channel 1
> >
> > VMBUS ID 14: Class_ID =3D {f8615163-df3e-46c5-913f-f2d2f965ed0e} -
> Synthetic network adapter
> >         Device_ID =3D {cab064cd-1f31-47d5-a8b4-9d57e320cccd}
> >         Sysfs path: /sys/bus/vmbus/devices/cab064cd-1f31-47d5-a8b4-
> 9d57e320cccd
> >         Rel_ID=3D14, target_cpu=3D0
> >         Rel_ID=3D17, target_cpu=3D0
> >
> > VMBUS ID 16: Class_ID =3D {f8615163-df3e-46c5-913f-f2d2f965ed0e} -
> Synthetic network adapter
> >         Device_ID =3D {244225ca-743e-4020-a17d-d7baa13d6cea}
> >         Sysfs path: /sys/bus/vmbus/devices/244225ca-743e-4020-a17d-
> d7baa13d6cea
> >         Rel_ID=3D16, target_cpu=3D1
> >         Rel_ID=3D18, target_cpu=3D1
> >
> > Update the vmbus CPU assignment algorithm to avoid duplicate CPU
> > assignments within a device.
> >
> > The new algorithm iterates num_online_cpus + 1 times.
> > The existing rotational algorithm to find "next NUMA & CPU" is still he=
re.
> > But if the resulting CPU is already used by the same device, it will
> > try the next CPU.
> > In the last iteration, it assigns the channel to the next available
> > CPU like the existing algorithm. This is not normally expected,
> > because during device probe, we limit the number of channels of a
> > device to be <=3D number of online CPUs.
> >
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/hv/channel_mgmt.c | 96
> > ++++++++++++++++++++++++++-------------
> >  1 file changed, 64 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > index caf6d0c4bc1b..8584914291e7 100644
> > --- a/drivers/hv/channel_mgmt.c
> > +++ b/drivers/hv/channel_mgmt.c
> > @@ -605,6 +605,17 @@ static void vmbus_process_offer(struct
> vmbus_channel *newchannel)
> >  	 */
> >  	mutex_lock(&vmbus_connection.channel_mutex);
> >
> > +	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry)
> {
> > +		if (guid_equal(&channel->offermsg.offer.if_type,
> > +			       &newchannel->offermsg.offer.if_type) &&
> > +		    guid_equal(&channel->offermsg.offer.if_instance,
> > +			       &newchannel->offermsg.offer.if_instance)) {
> > +			fnew =3D false;
> > +			newchannel->primary_channel =3D channel;
> > +			break;
> > +		}
> > +	}
> > +
> >  	init_vp_index(newchannel);
> >
> >  	/* Remember the channels that should be cleaned up upon suspend.
> */
> > @@ -617,16 +628,6 @@ static void vmbus_process_offer(struct
> vmbus_channel *newchannel)
> >  	 */
> >  	atomic_dec(&vmbus_connection.offer_in_progress);
> >
> > -	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry)
> {
> > -		if (guid_equal(&channel->offermsg.offer.if_type,
> > -			       &newchannel->offermsg.offer.if_type) &&
> > -		    guid_equal(&channel->offermsg.offer.if_instance,
> > -			       &newchannel->offermsg.offer.if_instance)) {
> > -			fnew =3D false;
> > -			break;
> > -		}
> > -	}
> > -
> >  	if (fnew) {
> >  		list_add_tail(&newchannel->listentry,
> >  			      &vmbus_connection.chn_list); @@ -647,7 +648,6
> @@ static void
> > vmbus_process_offer(struct vmbus_channel *newchannel)
> >  		/*
> >  		 * Process the sub-channel.
> >  		 */
> > -		newchannel->primary_channel =3D channel;
> >  		list_add_tail(&newchannel->sc_list, &channel->sc_list);
> >  	}
> >
> > @@ -683,6 +683,30 @@ static void vmbus_process_offer(struct
> vmbus_channel *newchannel)
> >  	queue_work(wq, &newchannel->add_channel_work);  }
> >
> > +/*
> > + * Check if CPUs used by other channels of the same device.
> > + * It's should only be called by init_vp_index().
>=20
> s/It's/It/
>=20
> > + */
> > +static bool hv_cpuself_used(u32 cpu, struct vmbus_channel *chn) {
> > +	struct vmbus_channel *primary =3D chn->primary_channel;
> > +	struct vmbus_channel *sc;
> > +
> > +	lockdep_assert_held(&vmbus_connection.channel_mutex);
> > +
> > +	if (!primary)
> > +		return false;
> > +
> > +	if (primary->target_cpu =3D=3D cpu)
> > +		return true;
> > +
> > +	list_for_each_entry(sc, &primary->sc_list, sc_list)
> > +		if (sc !=3D chn && sc->target_cpu =3D=3D cpu)
> > +			return true;
> > +
> > +	return false;
> > +}
> > +
> >  /*
> >   * We use this state to statically distribute the channel interrupt lo=
ad.
> >   */
> > @@ -702,6 +726,7 @@ static int next_numa_node_id;  static void
> > init_vp_index(struct vmbus_channel *channel)  {
> >  	bool perf_chn =3D hv_is_perf_channel(channel);
> > +	u32 i, ncpu =3D num_online_cpus();
> >  	cpumask_var_t available_mask;
> >  	struct cpumask *alloced_mask;
> >  	u32 target_cpu;
> > @@ -724,31 +749,38 @@ static void init_vp_index(struct vmbus_channel
> *channel)
> >  		return;
> >  	}
> >
> > -	while (true) {
> > -		numa_node =3D next_numa_node_id++;
> > -		if (numa_node =3D=3D nr_node_ids) {
> > -			next_numa_node_id =3D 0;
> > -			continue;
> > +	for (i =3D 1; i <=3D ncpu + 1; i++) {
> > +		while (true) {
> > +			numa_node =3D next_numa_node_id++;
> > +			if (numa_node =3D=3D nr_node_ids) {
> > +				next_numa_node_id =3D 0;
> > +				continue;
> > +			}
> > +			if
> (cpumask_empty(cpumask_of_node(numa_node)))
> > +				continue;
> > +			break;
> > +		}
> > +		alloced_mask =3D &hv_context.hv_numa_map[numa_node];
> > +
> > +		if (cpumask_weight(alloced_mask) =3D=3D
> > +		    cpumask_weight(cpumask_of_node(numa_node))) {
> > +			/*
> > +			 * We have cycled through all the CPUs in the node;
> > +			 * reset the alloced map.
> > +			 */
> > +			cpumask_clear(alloced_mask);
> >  		}
> > -		if (cpumask_empty(cpumask_of_node(numa_node)))
> > -			continue;
> > -		break;
> > -	}
> > -	alloced_mask =3D &hv_context.hv_numa_map[numa_node];
> >
> > -	if (cpumask_weight(alloced_mask) =3D=3D
> > -	    cpumask_weight(cpumask_of_node(numa_node))) {
> > -		/*
> > -		 * We have cycled through all the CPUs in the node;
> > -		 * reset the alloced map.
> > -		 */
> > -		cpumask_clear(alloced_mask);
> > -	}
> > +		cpumask_xor(available_mask, alloced_mask,
> > +			    cpumask_of_node(numa_node));
> >
> > -	cpumask_xor(available_mask, alloced_mask,
> cpumask_of_node(numa_node));
> > +		target_cpu =3D cpumask_first(available_mask);
> > +		cpumask_set_cpu(target_cpu, alloced_mask);
> >
> > -	target_cpu =3D cpumask_first(available_mask);
> > -	cpumask_set_cpu(target_cpu, alloced_mask);
> > +		if (channel->offermsg.offer.sub_channel_index >=3D ncpu ||
> > +		    i > ncpu || !hv_cpuself_used(target_cpu, channel))
> > +			break;
> > +	}
> >
> >  	channel->target_cpu =3D target_cpu;
> >
> > --
> > 2.25.1
>=20
> I like this approach much better.  I did some testing with a variety of C=
PU
> counts (1, 2, 3, 4, 8, and 32), NUMA nodes (1, 3, and 4) and with
> 4 SCSI controllers and 4 NICs.  Everything worked as expected, and it's
> definitely an improvement.
>=20
> I flagged a couple of typos/wording errors, but maybe they can be fixed
> when the patch is pulled into hyperv-fixes.
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Tested-by: Michael Kelley <mikelley@microsoft.com>

Thank you for the review and test! I will just correct the comments and
submit a v3.

- Haiyang
