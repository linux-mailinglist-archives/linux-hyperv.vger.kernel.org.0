Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97063CADEA
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jul 2021 22:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhGOUdY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Jul 2021 16:33:24 -0400
Received: from mail-bn7nam10on2091.outbound.protection.outlook.com ([40.107.92.91]:22753
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229600AbhGOUdV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Jul 2021 16:33:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQHAiBzuq/gPr7/e0F+Xwh7zEZkFBiCJ0YzmR5CvGKEsvp3pKS6aLhNNDTujZ1dSe5CiYMFsF08Ll3yYhpjdA1aHIC/1Syd3Yphm9jmiO72fxnU/8SB1W4eJ9r14Xanvqp0XfECErLrEwH8jaidjtNJRRsca9hfUruVBKgjcLL6qxqJzSagtB2CZ8l/9sarN8Wu9DVB2m5hBN7NepCGe4byF1T0rcZFDl9zrt9jmIVXiSs6oSUkdeHbPM1lRv1ztG3GLkr9oq+t91va16DuPK2E7lE4oUnOnjQItrOqdUKn/rskuZm+6dhuEaGOav6sUBVuZlc5nX+9nHhyapWUqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxfNA/aYV4FSlhJZH9aLK3vkenPLnInM47k2IlwwGUU=;
 b=HUqs1GF851sA5j+FAQrZ4VVwaebsU8dpRRmISsRaTOntnu+Ehzgkbj5rU7Sz+UpjDKTaHTlDf1FFzoJMEso01dlASdblR49XE9AjivNrLB/yM4P8r1E/5RcsSe49y4AcR1ILtgqytnW8pk2oXn22FJXOIx/tZ9ZMhsk0zuylTiZc8QF2svAm21d4mZKc2fnsHfUI1ZvMiFQHiCMHy+azYjmwa0pLy509o9UmLJrq+J809enT+jl9GhphzoIebNG6AkkWxOznbMOkEZQciyAHDPdJts6kP4fS3L5me3yTkKeJdVkqaw6/kIheZjxmjvS1pD1FiBvAvDk4GspeqWXoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxfNA/aYV4FSlhJZH9aLK3vkenPLnInM47k2IlwwGUU=;
 b=If9EXeCG55NPswl0tyvOc97lH4CWt3CZAaKZ7lXW15yoi2XqbX1WHm+TnPb8mc9I2y4FQkNHxCQFkXaCdshcoInUfVkIbdB1CxWacFOrbxo93pxWJ7P92kKTnZisUBtt1bRUF1w4qjaOu/4/9N3jqTIuXfGOJUv5JtTjCL/Y3Fk=
Received: from MN2PR21MB1295.namprd21.prod.outlook.com (2603:10b6:208:3e::25)
 by MN2PR21MB1311.namprd21.prod.outlook.com (2603:10b6:208:3f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.4; Thu, 15 Jul
 2021 20:30:25 +0000
Received: from MN2PR21MB1295.namprd21.prod.outlook.com
 ([fe80::d830:2bfc:3f18:2056]) by MN2PR21MB1295.namprd21.prod.outlook.com
 ([fe80::d830:2bfc:3f18:2056%7]) with mapi id 15.20.4331.014; Thu, 15 Jul 2021
 20:30:25 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH hyperv-fixes] Drivers: hv: vmbus: Fix duplicate CPU
 assignments within a device
Thread-Topic: [PATCH hyperv-fixes] Drivers: hv: vmbus: Fix duplicate CPU
 assignments within a device
Thread-Index: AQHXeZQIZT8tWsBsyUWOgLnQ8S24CKtEWGUAgAACJ5A=
Date:   Thu, 15 Jul 2021 20:30:24 +0000
Message-ID: <MN2PR21MB129503FDC75886A21A39C0DBCA129@MN2PR21MB1295.namprd21.prod.outlook.com>
References: <1626365442-28869-1-git-send-email-haiyangz@microsoft.com>
 <MWHPR21MB1593D479F9339821218AB0A2D7129@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB1593D479F9339821218AB0A2D7129@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=69d0e597-c308-4261-8955-06ca0ba7492c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-15T17:59:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0eeaf0f-27de-497e-d1b3-08d947cf6066
x-ms-traffictypediagnostic: MN2PR21MB1311:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR21MB1311003A1FCC63176C642EFBCA129@MN2PR21MB1311.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:215;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L0huQLh3KKJ0RI5w1Hca0jU4n73PfnJqX56OFFSB+Byt9aH5IvsReJuHYs4cPbCGm4iWWuvaarn9BEPX8vr1zMw+FZRig4/UOQmjLYv5ILPcnv+manK53hZAEnAxd4bsd98p/fGbjyt6hRo6kqH7rYiF3h+WrDSAjCO9bWZd9puFqE1p6oO9WMlVvjv8QffR6uh3z6Og/ZSZKXrWmESfBmga+k/N42J7NZpKS9nSNv9gLUMuT2fA70JSI7IwB3MARGxU2ChZZEfYbfTJEzYTZeSNtRtsPP/WM9ART1axAM6ry9JgvAc9KffqtYrbe5r7/IdaZJPmgPzOH+14slPNuIIbcK8kTyhvPHzD0P7HRHWJUYTxYhybY3KtxH31hJ2Zk6iwAdJuaJlEea8Z36ieeAgaekZvsCPNUzdnJsC3bI1kLHImM3HzJxvLsE32eCAWyg5DqkuqAb6DOY6+jcfCicUjomYOuc+ypDXERH8K5hc3d8vbuByxbt0P7oB8yrFHk4sDJYHrRYYAhPiHlT65civoSmraL9gkYW2qzXdxnjTMvo84TNsiLsteS2xNae2tG1pyQSYmSKieMmXzqYpfm8M0ZtzrUBlRTKrSh6auYmZHueABjXJtxA+iAurGhnuAU2g9UQNbzMeapHOui+CtjF/WqeeXahdFKF9suZLG/gV+Vef0pPeq2YWomk6gSCdN8q5gL7/kowv+u/czzLSqTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1295.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(66446008)(64756008)(66556008)(66476007)(478600001)(82950400001)(82960400001)(86362001)(54906003)(6506007)(7696005)(55016002)(316002)(33656002)(26005)(52536014)(53546011)(83380400001)(110136005)(186003)(122000001)(9686003)(8676002)(66946007)(2906002)(8990500004)(10290500003)(8936002)(4326008)(71200400001)(450100002)(38100700002)(76116006)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fXHehg+jrpSsnMAio0PRruSGn1jiFJNqODvPuNi3XrJeZuUR4Tj+3gdl3VgD?=
 =?us-ascii?Q?NDDcNIOqB6Fi4hKEja7ovm19Yoq8CtUWwNqO24T5FXjN2jF8LzQIPh7rXzrW?=
 =?us-ascii?Q?idy8EVKfDsHfkqL72IWs4O5aB3H66sbza1TnghzKLshz+cReezqYtttHuCqo?=
 =?us-ascii?Q?7FernuRUjOJqIbwUU4ALNt9JE9Y1KXrh2cmFcCDuFlftf+54M5FOyO3rjCoY?=
 =?us-ascii?Q?mUYEvysO5J04NLuFS/uTtlLdD29Vkv3TMWqjCRj5G9gthfj4MuWmCeeE6P8Z?=
 =?us-ascii?Q?NNSQw5JeNU2GUOL/Y4ytaE9IOwWnNmQqYWVKvVIhpm7hP95hWk4GpVMQVKO1?=
 =?us-ascii?Q?tieTBT4qUVj957a1MhAkJJGp/SL6+Wr0/XwfpZSTZGapRrMc4D9MgZSydX1/?=
 =?us-ascii?Q?8kV37m9t4M4OZ8+YoN5LdjbAY6F0z5+yd86thmmV3aYPzXFSB97bCdW4iRCv?=
 =?us-ascii?Q?aSPKoYatWCE2/iplm/42KxFw1fQd3soy1fz/9d+JtsFuI1OlqrcXDUxawJam?=
 =?us-ascii?Q?KEMljX+SyZsl4nli0faOmsJMPyaKCh3lLkrHJ6raFjKHvuW4zQy4S50IK5DR?=
 =?us-ascii?Q?bJJoL+2jwUKcRmkhHWYnQJLufPoTMl09Up37YmtWgjLeCGEGwXrxEumScbSq?=
 =?us-ascii?Q?w0z8ezyUqWrOls78BFpBm2PfjXREulB99/vTNisXDfIOwgOeOL7Wp/OLCpx4?=
 =?us-ascii?Q?06VlrkTiIKjY2qMlwglMqqgBJu4hc0BA/X9CAV0847kgONhlHg9VimO9QnBV?=
 =?us-ascii?Q?e0NXEPH3MBV6pdAk1G6Wby29AOL3tTvlG0Zi8j6rM5QhxsRNLEbvEPcT3bzG?=
 =?us-ascii?Q?dLnXK82HXCLfVsvElaA0ZFw8W/VPvKX1hA2Qa6JP988vJ2JxhiUTssY/t14m?=
 =?us-ascii?Q?KcSsyzWLRBrYxNAOSQT6vcml+g0x+R3L5vavVD6/anOGoQ14sxHJ9CrKCVu2?=
 =?us-ascii?Q?kVUtZ/sp9AuYMMkV0H98PtzBDNXH0Q64nyq5F4bfZRnb/XqXDb8bPkieuErA?=
 =?us-ascii?Q?5jVw1p3gsra1GYVmKGNcX/2pKxSGAbCL05i/3PugCqSRgjyOrOtOdIO4GB9I?=
 =?us-ascii?Q?Lg66NzlaT0S9dEFj78VZ2F1b0zUJ7I2Q9JOkwzu9mZ2BPaESzQKm/mUBV5Fy?=
 =?us-ascii?Q?TTFYvUsgWPXnC5hl3f2bM1pS0FK75n3SR/U9lPls+MmP1lZltJy3kVsQwaM9?=
 =?us-ascii?Q?VWnCGEE7AG9euakK0hnUJVxBYfc9dJrT0g43wNAjC5n7BhNFd65SIo/NCJnG?=
 =?us-ascii?Q?ojKd1D56QerNpdiMOLN0FLyvcCEmpOYmJow6q5radjDhCcLKkfiZJMZMYmo5?=
 =?us-ascii?Q?nveY2VUlPvhkaBkEnZntfbK4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1295.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0eeaf0f-27de-497e-d1b3-08d947cf6066
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 20:30:24.9160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dICAnARZ9hPUrpnf7V42G4dgYizhiH4oUljKRUnGFyOMOQfSirm21PyECg8QvoCIb1PsJ8W9sBFOVPlPrVUQxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1311
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Thursday, July 15, 2021 2:18 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>; linux-
> hyperv@vger.kernel.org
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH hyperv-fixes] Drivers: hv: vmbus: Fix duplicate CPU
> assignments within a device
>=20
> From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang Zhang
> Sent: Thursday, July 15, 2021 9:11 AM
> >
> > The vmbus module uses a rotational algorithm to assign target CPUs to
> > device's channels. Depends on the timing of different device's channel
> > offers, different channels of a device may be assigned to the same CPU.
> >
> > For example on a VM with 2 CPUs, if the NIC A and B's channels offered
>=20
> s/the NIC A/NIC A/
> s/offered/are offered/

Thanks, I will update this and other descriptions.

>=20
> > in the following order, the NIC A will have both channels on CPU0, and
>=20
> s/the NIC A/NIC A/
>=20
> > NIC B will have both channels on CPU1 -- see below. This kind of
> > assignments cause RSS spreading loads among different channels ends up
>=20
> "assignment causes RSS load that is spread across different channels to e=
nd
> up"
>=20
> > on the same CPU.
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
> >
> > Update the vmbus' CPU assignment algorithm to avoid duplicate CPU
>=20
> s/vmbus'/vmbus/

>=20
> > assignments within a device.
> >
> > The new algorithm iterates 2 * #NUMA_Node + 1 times. In the first
> > round of checking all NUMA nodes, it tries to find previously unassigne=
d
> > CPUs by this and other devices. If not available, it clears the
> > allocated CPU mask.
> > In the second round, it tries to find unassigned CPUs by the same
> > device.
> > In the last iteration, it assigns the channel to the first available CP=
U.
> > This is not normally expected, because during device probe, we limit th=
e
> > number of channels of a device to be <=3D number of online CPUs.
> >
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > ---
> >  drivers/hv/channel_mgmt.c | 95 ++++++++++++++++++++++++++---------
> ----
> >  1 file changed, 65 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > index caf6d0c4bc1b..fbddc4954f57 100644
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
> >  			      &vmbus_connection.chn_list);
> > @@ -647,7 +648,6 @@ static void vmbus_process_offer(struct
> vmbus_channel *newchannel)
> >  		/*
> >  		 * Process the sub-channel.
> >  		 */
> > -		newchannel->primary_channel =3D channel;
> >  		list_add_tail(&newchannel->sc_list, &channel->sc_list);
> >  	}
> >
> > @@ -683,6 +683,29 @@ static void vmbus_process_offer(struct
> vmbus_channel *newchannel)
> >  	queue_work(wq, &newchannel->add_channel_work);
> >  }
> >
> > +/*
> > + * Clear CPUs used by other channels of the same device.
> > + * It's should only be called by init_vp_index().
> > + */
> > +static bool hv_clear_usedcpu(struct cpumask *cmask, struct
> vmbus_channel *chn)
> > +{
> > +	struct vmbus_channel *primary =3D chn->primary_channel;
> > +	struct vmbus_channel *sc;
> > +
> > +	lockdep_assert_held(&vmbus_connection.channel_mutex);
> > +
> > +	if (!primary)
> > +		return !cpumask_empty(cmask);
>=20
> Minor note:  As this function is currently used, the cmask parameter shou=
ld
> never be empty.  Calling cpumask_empty() doesn't hurt anything but
> this line should always return "true".


>=20
> > +
> > +	cpumask_clear_cpu(primary->target_cpu, cmask);
> > +
> > +	list_for_each_entry(sc, &primary->sc_list, sc_list)
> > +		if (sc !=3D chn)
> > +			cpumask_clear_cpu(sc->target_cpu, cmask);
> > +
> > +	return !cpumask_empty(cmask);
> > +}
> > +
> >  /*
> >   * We use this state to statically distribute the channel interrupt lo=
ad.
> >   */
> > @@ -705,7 +728,7 @@ static void init_vp_index(struct vmbus_channel
> *channel)
> >  	cpumask_var_t available_mask;
> >  	struct cpumask *alloced_mask;
> >  	u32 target_cpu;
> > -	int numa_node;
> > +	int numa_node, i;
> >
> >  	if ((vmbus_proto_version =3D=3D VERSION_WS2008) ||
> >  	    (vmbus_proto_version =3D=3D VERSION_WIN7) || (!perf_chn) ||
> > @@ -724,29 +747,41 @@ static void init_vp_index(struct vmbus_channel
> *channel)
> >  		return;
> >  	}
> >
> > -	while (true) {
> > -		numa_node =3D next_numa_node_id++;
> > -		if (numa_node =3D=3D nr_node_ids) {
> > -			next_numa_node_id =3D 0;
> > -			continue;
> > +	for (i =3D 1; i <=3D nr_node_ids * 2 + 1; i++) {
> > +		while (true) {
> > +			numa_node =3D next_numa_node_id++;
> > +			if (numa_node =3D=3D nr_node_ids) {
> > +				next_numa_node_id =3D 0;
> > +				continue;
> > +			}
> > +			if
> (cpumask_empty(cpumask_of_node(numa_node)))
> > +				continue;
>=20
> This test has the potential to get the next_numa_node_id value out of syn=
c
> with the index "i" in the containing "for" loop.  The intent is to go thr=
ough all
> NUMA nodes up to 2 times, plus 1 more time.  But if a NUMA node is
> encountered
> with no online CPUs, next_numa_node_id may get incremented multiple
> times
> in a single iteration of the "for" loop.  So you could end up cycling thr=
ough
> some
> of the NUMA nodes more than twice before doing the final iteration.

I will switch to an update algorithm: see blow.

>=20
> > +			break;
> >  		}
> > -		if (cpumask_empty(cpumask_of_node(numa_node)))
> > -			continue;
> > -		break;
> > -	}
> > -	alloced_mask =3D &hv_context.hv_numa_map[numa_node];
> > +		alloced_mask =3D &hv_context.hv_numa_map[numa_node];
> > +
> > +		if (cpumask_weight(alloced_mask) =3D=3D
> > +		    cpumask_weight(cpumask_of_node(numa_node))) {
> > +			/*
> > +			 * We have cycled through all the CPUs in the node;
> > +			 * reset the alloced map.
> > +			 */
> > +			cpumask_clear(alloced_mask);
> > +		}
> > +
> > +		cpumask_xor(available_mask, alloced_mask,
> > +			    cpumask_of_node(numa_node));
> > +
> > +		/* Try to avoid duplicate cpus within a device */
> > +		if (channel->offermsg.offer.sub_channel_index >=3D
> > +		    num_online_cpus() ||
> > +		    i > nr_node_ids * 2 ||
> > +		    hv_clear_usedcpu(available_mask, channel))
> > +			break;
> >
> > -	if (cpumask_weight(alloced_mask) =3D=3D
> > -	    cpumask_weight(cpumask_of_node(numa_node))) {
> > -		/*
> > -		 * We have cycled through all the CPUs in the node;
> > -		 * reset the alloced map.
> > -		 */
> >  		cpumask_clear(alloced_mask);
>=20
> This clearing of the "alloced_mask" concerns me.  It is done incrementall=
y
> as the NUMA nodes are cycled through the first time.  So if an available =
CPU
> is found in the 3rd NUMA node on the first cycle, the alloced_mask will
> have been cleared for NUMA nodes 0, 1, and 2.  A subsequent call to
> this function for a different device will find the CPUs in those NUMA nod=
es
> unalloc'ed, and therefore useable.  It seems like this will tend to bunch=
 the
> CPU
> assignments across multiple devices much more toward NUMA node 0 than
> the existing algorithm does.  Or am I missing something about how this wo=
rks?

The assignment is a rotational algorithm, and next_numa_node_id is a global=
=20
variable, which keeps the last assignment's numa id. So if the last device =
used=20
numa#3, the next device will try numa#4 (or numa 0, if there are only 4 nod=
es).=20
Then the next channel of this device will try the next numa node #5. And th=
e=20
next one will try #6, etc... Because the rotational algorithm keeps rotatin=
g,=20
there is no preference towards any NUMA node.

But, I believe since we use cpumask_first(available_mask) instead of a rota=
tion=20
within a node, the new algorithm does have preference on the "small" cpu=20
numbers WITHIN a numa node due to possible "extra" cpumask_clear() than=20
the old algorithm.

So I updated the algorithm like this below. Basically, it keeps running the=
 rotational=20
algorithm until it finds a cpu not used by self. And any new device will st=
art rotation
after the point of last cpu assignment. So, it doesn't have any preference =
on any=20
node or cpu.

Existing_find_next() {
	Get the next numa node
	Clear this node if all occupied

	Cpu =3D the next available cpu of this node;
	cpumask_set_cpu(cpu);

	return cpu;
}

Updated_find_next() {
	N =3D number_online_cpu()

	for (i=3D1, i<=3D N+1, i++) {
		cpu=3D Existing_find_next()
		If (chn_index >=3D N ||
		  i > N ||
		  NotUsedBySelf(cpu))
		Break;
	}

	channel->target_cpu =3D cpu;
}

Thanks,
- Haiyang

