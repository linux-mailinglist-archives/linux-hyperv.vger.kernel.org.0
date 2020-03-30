Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0566198175
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2020 18:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgC3QmZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Mar 2020 12:42:25 -0400
Received: from mail-dm6nam12on2096.outbound.protection.outlook.com ([40.107.243.96]:52160
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbgC3QmY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Mar 2020 12:42:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJJojiQxNItS/1dEvmEsWt8XGYyC2AO8a1u5Y1M+J82fVUq3cpHB6MM+M1wNRqyaKvoYNTqp6uISRghNy+0x+Ak2JvofINmzQWHau+/cTeGTzqHIYmYDOX6uRP1CUMTw9wOjuclQnJG4TUbFumoX0B+5Qw0o9rC7lEcjz1+kp9xEzUNK3fJh/ULk5c5zL3h9oeGIFLTZWWyxkgNy6NN+HCthmHN3qQBeam6SZ2aMiUyfjQVdGCxo6VZ7DNaDid0vHROOpcAO197ADTmQfrF3PcaO7ToSyZrOokRicDDfDlKt2p6URA7Gc6DtN0Ga2/+UHIhCCoI1uKNzYi0OVCiGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWj0bF8ipE890O/jbsnFih2fcivS7DjKVdY20dBIjSg=;
 b=ToLltZNOFy77bI3EQrznZF1JE73OBjRFRXcwSS7Oj2a7V3Kh+IZkItd7QHy8540nvvWZqQz9Nk8arjAjUXxcZxiIq88EgQKGeN7RYCF1ncNDhvZL1UPH7STG7TBkkoY4g3OYsADifQb70lga+E68hQqa8yFeQZy4HtmePKeX3PStJSGaH1cel6IqEPiIRSP4GQZ//ZQCZG6NmbgDLa0Z/2peQ6WkpySz/7bZML+Q2v94HIln4Br2lv4+pWlL1JiZgwZnGPGl06d+t7H0REcYxhkMUOtZPBOskFXh4YTNkbMOeo+1kPzmZEPSBkJfsFXUzA1blAE4CqtZgILrnW1uEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWj0bF8ipE890O/jbsnFih2fcivS7DjKVdY20dBIjSg=;
 b=dPwurX8t8XlDg8GiynwJlhJc+GS/H5EDm4dJyV4zbvfkslwriwghll483V18dIIZ3+FW43aVW64NV6ogFbmmQSUiJBY6sJCD1aLoKkQDQCQpoz1jqAwOIoCnEJVk/7iW9JbtrhmluBCmrikyxSQGutF1N/tdqWQsp/syXrO7JEk=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1068.namprd21.prod.outlook.com (2603:10b6:302:a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.2; Mon, 30 Mar
 2020 16:42:19 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%8]) with mapi id 15.20.2878.014; Mon, 30 Mar 2020
 16:42:19 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        vkuznets <vkuznets@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [RFC PATCH 11/11] scsi: storvsc: Re-init stor_chns when a channel
 interrupt is re-assigned
Thread-Topic: [RFC PATCH 11/11] scsi: storvsc: Re-init stor_chns when a
 channel interrupt is re-assigned
Thread-Index: AQHWAvitlhvZNTexf0e3+nkuOWs8g6hhVRzg
Date:   Mon, 30 Mar 2020 16:42:19 +0000
Message-ID: <MW2PR2101MB105208138683A6DE0564745AD7CB0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
 <20200325225505.23998-12-parri.andrea@gmail.com>
In-Reply-To: <20200325225505.23998-12-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-30T16:42:17.7398508Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c1f5250c-1a4d-4e21-932e-531b00446085;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bbd64437-7a73-403c-a973-08d7d4c9505c
x-ms-traffictypediagnostic: MW2PR2101MB1068:|MW2PR2101MB1068:|MW2PR2101MB1068:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1068EB0F0F1D34DA56500108D7CB0@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(498600001)(30864003)(10290500003)(66946007)(33656002)(82950400001)(8990500004)(82960400001)(71200400001)(186003)(55016002)(76116006)(86362001)(26005)(8676002)(54906003)(8936002)(2906002)(66556008)(64756008)(4326008)(52536014)(110136005)(6506007)(66446008)(81166006)(7696005)(81156014)(5660300002)(9686003)(66476007);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKoY6dHdS+sYf0x+WwHde+aYDlMnP2w4tTrDZoTO3zGj/Z29EJ0Y3CpLnA8rZZSLOywDaPArNq/8seAzXMCV3P6EBkzCp/Q06p8Io/8Pvhk+N/1TP/sGy2z8fbKMJq5w6IfWBXczPPuuzposDdLxZ+JtRZ4z1r/1J41otn+to5WPniy3bG+ETtfbWEot36zdcvSvzNELhVOjGDy2EvBe7eKH5OHq663dFgCYEfNKx1BgSwYURTHsvuukdMdhRnwWPueXqUEWSqcIyp+WDw7UUcN5CQ+A7+VUMFPHjooBVhkgzSW1qCuaqEfjv1+CImA5JOLVZliMLxcVBbz4bYWgI8Xn+rDdWSvzR94T6lg+KhSKTXvikWjfugrvdf7PjZbib/fJqrhBZW/sjimSVQr7s5+cGHOBQlBK4R9IiA+3bnM+G5M0P1c5ydLZymYeOCdx
x-ms-exchange-antispam-messagedata: Xv3bPCGh8McHNIRZ++jEQjjNbYmc08la88NWayIqNBv9TL1W/AiQLOtxlbzEU94m9O7/eDacPaDmmTDuInAXIvH0HQQlredWc1nr/55v9+mQvK0QpAqfNQM+jv9Whx54D+UI6UdqpJrMH13Gk3m9Hw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd64437-7a73-403c-a973-08d7d4c9505c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 16:42:19.7329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHtmAb0s59bYRQoF3LLIJXNF/QFKON/49AK19wyVyrRiE20PYxxQP6Fkk+6BnkBe11+fCJLW8kvPB5H9g2u90xgfYfllaYkuS4IymSR/yZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com>  Sent: Wednesday, M=
arch 25, 2020 3:55 PM
>=20
> For each storvsc_device, storvsc keeps track of the channel target CPUs
> associated to the device (alloced_cpus) and it uses this information to
> fill a "cache" (stor_chns) mapping CPU->channel according to a certain
> heuristic.  Update the alloced_cpus mask and the stor_chns array when a
> channel of the storvsc device is re-assigned to a different CPU.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: <linux-scsi@vger.kernel.org>
> ---
>  drivers/hv/vmbus_drv.c     |  4 ++
>  drivers/scsi/storvsc_drv.c | 95 ++++++++++++++++++++++++++++++++++----
>  include/linux/hyperv.h     |  3 ++
>  3 files changed, 94 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 84d2f22c569aa..7199fee2b5869 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1721,6 +1721,10 @@ static ssize_t target_cpu_store(struct vmbus_chann=
el *channel,
>  	 * in on a CPU that is different from the channel target_cpu value.
>  	 */
>=20
> +	if (channel->change_target_cpu_callback)
> +		(*channel->change_target_cpu_callback)(channel,
> +				channel->target_cpu, target_cpu);
> +
>  	channel->target_cpu =3D target_cpu;
>  	channel->target_vp =3D hv_cpu_number_to_vp_number(target_cpu);
>  	channel->numa_node =3D cpu_to_node(target_cpu);

I think there's an ordering problem here.  The change_target_cpu_callback
will allow storvsc to flush the cache that it is keeping, but there's a win=
dow
after the storvsc callback releases the spin lock and before this function
changes channel->target_cpu to the new value.  In that window, the cache
could get refilled based on the old value of channel->target_cpu, which is
exactly what we don't want.  Generally with caches, you have to set the new
value first, then flush the cache, and I think that works in this case.  Th=
e
callback function doesn't depend on the value of channel->target_cpu,
and any cache filling that might happen after channel->target_cpu is set
to the new value but before the callback function runs is OK.   But please
double-check my thinking. :-)


> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index fb41636519ee8..a680592b9d32a 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -621,6 +621,63 @@ static inline struct storvsc_device *get_in_stor_dev=
ice(
>=20
>  }
>=20
> +void storvsc_change_target_cpu(struct vmbus_channel *channel, u32 old, u=
32 new)
> +{
> +	struct storvsc_device *stor_device;
> +	struct vmbus_channel *cur_chn;
> +	bool old_is_alloced =3D false;
> +	struct hv_device *device;
> +	unsigned long flags;
> +	int cpu;
> +
> +	device =3D channel->primary_channel ?
> +			channel->primary_channel->device_obj
> +				: channel->device_obj;
> +	stor_device =3D get_out_stor_device(device);
> +	if (!stor_device)
> +		return;
> +
> +	/* See storvsc_do_io() -> get_og_chn(). */
> +	spin_lock_irqsave(&device->channel->lock, flags);
> +
> +	/*
> +	 * Determines if the storvsc device has other channels assigned to
> +	 * the "old" CPU to update the alloced_cpus mask and the stor_chns
> +	 * array.
> +	 */
> +	if (device->channel !=3D channel && device->channel->target_cpu =3D=3D =
old) {
> +		cur_chn =3D device->channel;
> +		old_is_alloced =3D true;
> +		goto old_is_alloced;
> +	}
> +	list_for_each_entry(cur_chn, &device->channel->sc_list, sc_list) {
> +		if (cur_chn =3D=3D channel)
> +			continue;
> +		if (cur_chn->target_cpu =3D=3D old) {
> +			old_is_alloced =3D true;
> +			goto old_is_alloced;
> +		}
> +	}
> +
> +old_is_alloced:
> +	if (old_is_alloced)
> +		WRITE_ONCE(stor_device->stor_chns[old], cur_chn);
> +	else
> +		cpumask_clear_cpu(old, &stor_device->alloced_cpus);

I think target_cpu_store() can get called in parallel on multiple CPUs for =
different
channels on the same storvsc device, but multiple changes to a single chann=
el are
serialized by higher levels of sysfs.  So this function could run after mul=
tiple
channels have been changed, in which case there's not just a single "old" v=
alue,
and the above algorithm might not work, especially if channel->target_cpu i=
s
updated before calling this function per my earlier comment.   I can see a
couple of possible ways to deal with this.  One is to put the update of
channel->target_cpu in this function, within the spin lock boundaries so
that the cache flush and target_cpu update are atomic.  Another idea is to
process multiple changes in this function, by building a temp copy of
alloced_cpus by walking the channel list, use XOR to create a cpumask
with changes, and then process all the changes in a loop instead of
just handling a single change as with the current code at the old_is_alloce=
d
label.  But I haven't completely thought through this idea.

> +
> +	/* "Flush" the stor_chns array. */
> +	for_each_possible_cpu(cpu) {
> +		if (stor_device->stor_chns[cpu] && !cpumask_test_cpu(
> +					cpu, &stor_device->alloced_cpus))
> +			WRITE_ONCE(stor_device->stor_chns[cpu], NULL);
> +	}
> +
> +	WRITE_ONCE(stor_device->stor_chns[new], channel);
> +	cpumask_set_cpu(new, &stor_device->alloced_cpus);
> +
> +	spin_unlock_irqrestore(&device->channel->lock, flags);
> +}
> +
>  static void handle_sc_creation(struct vmbus_channel *new_sc)
>  {
>  	struct hv_device *device =3D new_sc->primary_channel->device_obj;
> @@ -648,6 +705,8 @@ static void handle_sc_creation(struct vmbus_channel *=
new_sc)
>  		return;
>  	}
>=20
> +	new_sc->change_target_cpu_callback =3D storvsc_change_target_cpu;
> +
>  	/* Add the sub-channel to the array of available channels. */
>  	stor_device->stor_chns[new_sc->target_cpu] =3D new_sc;
>  	cpumask_set_cpu(new_sc->target_cpu, &stor_device->alloced_cpus);
> @@ -876,6 +935,8 @@ static int storvsc_channel_init(struct hv_device *dev=
ice, bool is_fc)
>  	if (stor_device->stor_chns =3D=3D NULL)
>  		return -ENOMEM;
>=20
> +	device->channel->change_target_cpu_callback =3D storvsc_change_target_c=
pu;
> +
>  	stor_device->stor_chns[device->channel->target_cpu] =3D device->channel=
;
>  	cpumask_set_cpu(device->channel->target_cpu,
>  			&stor_device->alloced_cpus);
> @@ -1248,8 +1309,10 @@ static struct vmbus_channel *get_og_chn(struct sto=
rvsc_device
> *stor_device,
>  	const struct cpumask *node_mask;
>  	int num_channels, tgt_cpu;
>=20
> -	if (stor_device->num_sc =3D=3D 0)
> +	if (stor_device->num_sc =3D=3D 0) {
> +		stor_device->stor_chns[q_num] =3D stor_device->device->channel;
>  		return stor_device->device->channel;
> +	}
>=20
>  	/*
>  	 * Our channel array is sparsley populated and we
> @@ -1258,7 +1321,6 @@ static struct vmbus_channel *get_og_chn(struct stor=
vsc_device
> *stor_device,
>  	 * The strategy is simple:
>  	 * I. Ensure NUMA locality
>  	 * II. Distribute evenly (best effort)
> -	 * III. Mapping is persistent.
>  	 */
>=20
>  	node_mask =3D cpumask_of_node(cpu_to_node(q_num));
> @@ -1268,8 +1330,10 @@ static struct vmbus_channel *get_og_chn(struct sto=
rvsc_device
> *stor_device,
>  		if (cpumask_test_cpu(tgt_cpu, node_mask))
>  			num_channels++;
>  	}
> -	if (num_channels =3D=3D 0)
> +	if (num_channels =3D=3D 0) {
> +		stor_device->stor_chns[q_num] =3D stor_device->device->channel;

Is the above added line just fixing a bug in the existing code?  I'm not se=
eing how
it would derive from the other changes in this patch.

>  		return stor_device->device->channel;
> +	}
>=20
>  	hash_qnum =3D q_num;
>  	while (hash_qnum >=3D num_channels)
> @@ -1295,6 +1359,7 @@ static int storvsc_do_io(struct hv_device *device,
>  	struct storvsc_device *stor_device;
>  	struct vstor_packet *vstor_packet;
>  	struct vmbus_channel *outgoing_channel, *channel;
> +	unsigned long flags;
>  	int ret =3D 0;
>  	const struct cpumask *node_mask;
>  	int tgt_cpu;
> @@ -1308,10 +1373,11 @@ static int storvsc_do_io(struct hv_device *device=
,
>=20
>  	request->device  =3D device;
>  	/*
> -	 * Select an an appropriate channel to send the request out.
> +	 * Select an appropriate channel to send the request out.
>  	 */
> -	if (stor_device->stor_chns[q_num] !=3D NULL) {
> -		outgoing_channel =3D stor_device->stor_chns[q_num];
> +	/* See storvsc_change_target_cpu(). */
> +	outgoing_channel =3D READ_ONCE(stor_device->stor_chns[q_num]);
> +	if (outgoing_channel !=3D NULL) {
>  		if (outgoing_channel->target_cpu =3D=3D q_num) {
>  			/*
>  			 * Ideally, we want to pick a different channel if
> @@ -1324,7 +1390,10 @@ static int storvsc_do_io(struct hv_device *device,
>  					continue;
>  				if (tgt_cpu =3D=3D q_num)
>  					continue;
> -				channel =3D stor_device->stor_chns[tgt_cpu];
> +				channel =3D READ_ONCE(
> +					stor_device->stor_chns[tgt_cpu]);
> +				if (channel =3D=3D NULL)
> +					continue;

The channel =3D=3D NULL case is new because a cache flush could be happenin=
g
in parallel on another CPU.  I'm wondering about the tradeoffs of
continuing in the loop (as you have coded in this patch) vs. a "goto" back =
to
the top level "if" statement.   With the "continue" you might finish the
loop without finding any matches, and fall through to the next approach.
But it's only a single I/O operation, and if it comes up with a less than
optimal channel choice, it's no big deal.  So I guess it's really a wash.

>  				if (hv_get_avail_to_write_percent(
>  							&channel->outbound)
>  						> ring_avail_percent_lowater) {
> @@ -1350,7 +1419,10 @@ static int storvsc_do_io(struct hv_device *device,
>  			for_each_cpu(tgt_cpu, &stor_device->alloced_cpus) {
>  				if (cpumask_test_cpu(tgt_cpu, node_mask))
>  					continue;
> -				channel =3D stor_device->stor_chns[tgt_cpu];
> +				channel =3D READ_ONCE(
> +					stor_device->stor_chns[tgt_cpu]);
> +				if (channel =3D=3D NULL)
> +					continue;

Same comment here.

>  				if (hv_get_avail_to_write_percent(
>  							&channel->outbound)
>  						> ring_avail_percent_lowater) {
> @@ -1360,7 +1432,14 @@ static int storvsc_do_io(struct hv_device *device,
>  			}
>  		}
>  	} else {
> +		spin_lock_irqsave(&device->channel->lock, flags);
> +		outgoing_channel =3D stor_device->stor_chns[q_num];
> +		if (outgoing_channel !=3D NULL) {
> +			spin_unlock_irqrestore(&device->channel->lock, flags);
> +			goto found_channel;
> +		}
>  		outgoing_channel =3D get_og_chn(stor_device, q_num);
> +		spin_unlock_irqrestore(&device->channel->lock, flags);
>  	}
>=20
>  found_channel:
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index edfcd42319ef3..9018b89614b78 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -773,6 +773,9 @@ struct vmbus_channel {
>  	void (*onchannel_callback)(void *context);
>  	void *channel_callback_context;
>=20
> +	void (*change_target_cpu_callback)(struct vmbus_channel *channel,
> +			u32 old, u32 new);
> +
>  	/*
>  	 * Synchronize channel scheduling and channel removal; see the inline
>  	 * comments in vmbus_chan_sched() and vmbus_reset_channel_cb().
> --
> 2.24.0

