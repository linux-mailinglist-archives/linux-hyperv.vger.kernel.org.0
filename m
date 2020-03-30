Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 357CD1984D5
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2020 21:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgC3TtQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Mar 2020 15:49:16 -0400
Received: from mail-eopbgr700117.outbound.protection.outlook.com ([40.107.70.117]:5824
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727936AbgC3TtQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Mar 2020 15:49:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWZhy/gYIaeUB/qUAetbroaCQCQneSrVNkJISTzTdbpwBkYCh/S2g/ZLL3Kgih9ooTYITcB+uLkrlu+ZpGyf4G57o6mh5GQzalE6GChvlMo0SZtiIDVbGQemI3wNvWzmFCOfx/zkrGXfbRAFxarn5+pJkvh+VO6Mp/AjDMUNbq/uOY8OY4sJAI7o0LgvTD4eE9YYrbMQTkgVfDSEhp+8Om0GrTO3e5Qcgi3Nr62Cyxjd8nvaQNACD58scGqrzit77UDfsHo70rebYGErROUlE23kMJODCCiEEM/ri1i1yC/onZGRul5lkj/EcymcRAOSjwfBJqxdo+I8gATOSYd3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8Dcv59WIY5HXb6hGYXGtQq+TKNLC+W4p8/cAWzQIXo=;
 b=bKjP+X5uPn+7dF850Mft9zBUceu7xNl5Cr5qm0xe1F+G9N6wtdzEV0gKjnk726SJ4S5XA9gNLWO7z/w4UdSZPsm6EB+Jf6xbhTJsXUQ9DoiLRndPVUWZttAtOFTn/QiF2BOxn0mn/PFqPkhZprACSAjzFsHXF9QaRvZaTKDsxUPPujRzm/lAyEgOrOijVBQkaq9P/Z3eFNgaN/Gi+J6rUBb/aHFSG5qLxwYdCcND1yhrWs1b7d7NQSL6dMGVLHVdjmDnCcgDam2QrxnmCqviDrv+7v6lgwohGrJ3k13xiQrELCeFJaZcsMxMUC430Cx9N/97yMjEYOG1bYKCD0spkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8Dcv59WIY5HXb6hGYXGtQq+TKNLC+W4p8/cAWzQIXo=;
 b=Zk30libqYra9K3Vg5B2aKjdWMpp1Ptho5nRk6oOlNlIgy3Drc/s3MtIIqI+/Ih3qusCHcDOLMhVu6S903KGcQNl/OUjhm1zUGWSQgkMYgzb+YU6SrOplvYhqfxh4ExQQdVlqopyDnaUKZ1VEbRX2wDo1lg+8xHpJX8gv+R37t1s=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM5PR2101MB0966.namprd21.prod.outlook.com (2603:10b6:4:a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.2; Mon, 30 Mar
 2020 19:49:00 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::1cf9:aae4:18cc:8b3d]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::1cf9:aae4:18cc:8b3d%7]) with mapi id 15.20.2900.002; Mon, 30 Mar 2020
 19:49:00 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
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
Thread-Index: AQHWAvitlhvZNTexf0e3+nkuOWs8g6hhVRzggAAub4CAAA4jYA==
Date:   Mon, 30 Mar 2020 19:49:00 +0000
Message-ID: <DM5PR2101MB104720061795F26D892D5373D7CB0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
 <20200325225505.23998-12-parri.andrea@gmail.com>
 <MW2PR2101MB105208138683A6DE0564745AD7CB0@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <20200330185513.GA26823@andrea>
In-Reply-To: <20200330185513.GA26823@andrea>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-30T19:48:58.2820027Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3acbabca-9a73-466e-8da4-7c38c474fcaf;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09f52f82-ee3b-4cd1-b21e-08d7d4e364ad
x-ms-traffictypediagnostic: DM5PR2101MB0966:|DM5PR2101MB0966:|DM5PR2101MB0966:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB0966F876F759FB4F187269A6D7CB0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(81166006)(81156014)(8676002)(10290500003)(33656002)(54906003)(76116006)(8990500004)(4326008)(478600001)(82950400001)(52536014)(71200400001)(82960400001)(55016002)(86362001)(66946007)(8936002)(26005)(5660300002)(66556008)(66476007)(2906002)(66446008)(6916009)(64756008)(6506007)(9686003)(7696005)(186003)(316002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rj3yDST/GorujSa2gJBIeMzlDzGsXCVm5h4vXx07gbhe23aWbKYYmGb9RmHP8vaWDdvGFWKRo6ydQ8Ow3HOT6Br21dyKquFa0WGvEMk4i1004DXO1zWjGP+aGjKQeJqw9dpac+xtB11YxHjxWehCtMHGG1DLEEurt6Kj2fCbGticbRHKRz/cFE4ZPfO98SnF8enkut3+nr5Cs0HsgMzwv9sVKDaquJiyHXNFn5zZnGWUihACyIyXshlW2mOZR7/+WBWYTONFfSW8nFqnHasQyg1sEX+frVdgjoAR7//LNXlq9PsSBLc1i72EFdiFxfv71FVRzhIy9B8WJlBClu2tUf0EwPKRKanlN8mfpyu8+70f8KayrmpdJzslBFmTn4ZpmqeqQxlWQTAMbHFuUvsJ34veQ/IExgkxcYPucPUR1KD1cMxSvbcw270YBwRb8szf
x-ms-exchange-antispam-messagedata: F2taVw0TSTtqxb8YeC0AupBX5N+824jHS5HYblo2c2OFd9vlZAmw70n4WcD0rNyJnpW7JY1uXEFlGYTUoEPV1jK1kDfbM9rIP8GcbUYZLKs1ecJ5TOp0y6ibQSj809CI/bK35OBmIxOm2Ll47MkxVQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f52f82-ee3b-4cd1-b21e-08d7d4e364ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 19:49:00.6574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ooGdGbb3DxrhvmTR4xH7hamqJsyWFSO6MbEEOlMI3ysZ/O2WROivnxnn7v682oIcLg6FFn1EhSAHKwT8LGKRNTpIUpGErmVTUpDwygHLsTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com> Sent: Monday, March 30, 2020 11=
:55 AM
>=20
> > > @@ -1721,6 +1721,10 @@ static ssize_t target_cpu_store(struct vmbus_c=
hannel
> *channel,
> > >  	 * in on a CPU that is different from the channel target_cpu value.
> > >  	 */
> > >
> > > +	if (channel->change_target_cpu_callback)
> > > +		(*channel->change_target_cpu_callback)(channel,
> > > +				channel->target_cpu, target_cpu);
> > > +
> > >  	channel->target_cpu =3D target_cpu;
> > >  	channel->target_vp =3D hv_cpu_number_to_vp_number(target_cpu);
> > >  	channel->numa_node =3D cpu_to_node(target_cpu);
> >
> > I think there's an ordering problem here.  The change_target_cpu_callba=
ck
> > will allow storvsc to flush the cache that it is keeping, but there's a=
 window
> > after the storvsc callback releases the spin lock and before this funct=
ion
> > changes channel->target_cpu to the new value.  In that window, the cach=
e
> > could get refilled based on the old value of channel->target_cpu, which=
 is
> > exactly what we don't want.  Generally with caches, you have to set the=
 new
> > value first, then flush the cache, and I think that works in this case.=
  The
> > callback function doesn't depend on the value of channel->target_cpu,
> > and any cache filling that might happen after channel->target_cpu is se=
t
> > to the new value but before the callback function runs is OK.   But ple=
ase
> > double-check my thinking. :-)
>=20
> Sorry, I don't see the problem.  AFAICT, the "cache" gets refilled based
> on the values of alloced_cpus and on the current state of the cache but
> not based on the value of channel->target_cpu.  The callback invocation
> uses the value of the "old" target_cpu; I think I ended up placing the
> callback call where it is for not having to introduce a local variable
> "old_cpu".  ;-)
>

You are right.   My comment is bogus.

>=20
> > > @@ -621,6 +621,63 @@ static inline struct storvsc_device *get_in_stor=
_device(
> > >
> > >  }
> > >
> > > +void storvsc_change_target_cpu(struct vmbus_channel *channel, u32 ol=
d, u32 new)
> > > +{
> > > +	struct storvsc_device *stor_device;
> > > +	struct vmbus_channel *cur_chn;
> > > +	bool old_is_alloced =3D false;
> > > +	struct hv_device *device;
> > > +	unsigned long flags;
> > > +	int cpu;
> > > +
> > > +	device =3D channel->primary_channel ?
> > > +			channel->primary_channel->device_obj
> > > +				: channel->device_obj;
> > > +	stor_device =3D get_out_stor_device(device);
> > > +	if (!stor_device)
> > > +		return;
> > > +
> > > +	/* See storvsc_do_io() -> get_og_chn(). */
> > > +	spin_lock_irqsave(&device->channel->lock, flags);
> > > +
> > > +	/*
> > > +	 * Determines if the storvsc device has other channels assigned to
> > > +	 * the "old" CPU to update the alloced_cpus mask and the stor_chns
> > > +	 * array.
> > > +	 */
> > > +	if (device->channel !=3D channel && device->channel->target_cpu =3D=
=3D old) {
> > > +		cur_chn =3D device->channel;
> > > +		old_is_alloced =3D true;
> > > +		goto old_is_alloced;
> > > +	}
> > > +	list_for_each_entry(cur_chn, &device->channel->sc_list, sc_list) {
> > > +		if (cur_chn =3D=3D channel)
> > > +			continue;
> > > +		if (cur_chn->target_cpu =3D=3D old) {
> > > +			old_is_alloced =3D true;
> > > +			goto old_is_alloced;
> > > +		}
> > > +	}
> > > +
> > > +old_is_alloced:
> > > +	if (old_is_alloced)
> > > +		WRITE_ONCE(stor_device->stor_chns[old], cur_chn);
> > > +	else
> > > +		cpumask_clear_cpu(old, &stor_device->alloced_cpus);
> >
> > I think target_cpu_store() can get called in parallel on multiple CPUs =
for different
> > channels on the same storvsc device, but multiple changes to a single c=
hannel are
> > serialized by higher levels of sysfs.  So this function could run after=
 multiple
> > channels have been changed, in which case there's not just a single "ol=
d" value,
> > and the above algorithm might not work, especially if channel->target_c=
pu is
> > updated before calling this function per my earlier comment.   I can se=
e a
> > couple of possible ways to deal with this.  One is to put the update of
> > channel->target_cpu in this function, within the spin lock boundaries s=
o
> > that the cache flush and target_cpu update are atomic.  Another idea is=
 to
> > process multiple changes in this function, by building a temp copy of
> > alloced_cpus by walking the channel list, use XOR to create a cpumask
> > with changes, and then process all the changes in a loop instead of
> > just handling a single change as with the current code at the old_is_al=
loced
> > label.  But I haven't completely thought through this idea.
>=20
> Same here: the invocations of target_cpu_store() are serialized on the
> per-connection channel_mutex...

Agreed.  My comment is not valid.

>=20
>=20
> > > @@ -1268,8 +1330,10 @@ static struct vmbus_channel *get_og_chn(struct
> storvsc_device
> > > *stor_device,
> > >  		if (cpumask_test_cpu(tgt_cpu, node_mask))
> > >  			num_channels++;
> > >  	}
> > > -	if (num_channels =3D=3D 0)
> > > +	if (num_channels =3D=3D 0) {
> > > +		stor_device->stor_chns[q_num] =3D stor_device->device->channel;
> >
> > Is the above added line just fixing a bug in the existing code?  I'm no=
t seeing how
> > it would derive from the other changes in this patch.
>=20
> It was rather intended as an optimization:  Each time I/O for a device
> is initiated on a CPU that have "num_channels =3D=3D 0" channel, the curr=
ent
> code ends up calling get_og_chn() (in the attempt to fill the cache) and
> returns the device's primary channel.  In the current code, the cost of
> this operations is basically the cost of parsing alloced_cpus, but with
> the changes introduced here this also involves acquiring (and releasing)
> the primary channel's lock.  I should probably put my hands forward and
> say that I haven't observed any measurable effects due this addition in
> my experiments; OTOH, caching the returned/"found" value made sense...

OK.  That's what I thought.  The existing code does not produce an incorrec=
t
result, but the cache isn't working as intended.  This fixes it.

>=20
>=20
> > > @@ -1324,7 +1390,10 @@ static int storvsc_do_io(struct hv_device *dev=
ice,
> > >  					continue;
> > >  				if (tgt_cpu =3D=3D q_num)
> > >  					continue;
> > > -				channel =3D stor_device->stor_chns[tgt_cpu];
> > > +				channel =3D READ_ONCE(
> > > +					stor_device->stor_chns[tgt_cpu]);
> > > +				if (channel =3D=3D NULL)
> > > +					continue;
> >
> > The channel =3D=3D NULL case is new because a cache flush could be happ=
ening
> > in parallel on another CPU.  I'm wondering about the tradeoffs of
> > continuing in the loop (as you have coded in this patch) vs. a "goto" b=
ack to
> > the top level "if" statement.   With the "continue" you might finish th=
e
> > loop without finding any matches, and fall through to the next approach=
.
> > But it's only a single I/O operation, and if it comes up with a less th=
an
> > optimal channel choice, it's no big deal.  So I guess it's really a was=
h.
>=20
> Yes, I considered both approaches; they both "worked" here.  I was a
> bit concerned about the number of "possible" gotos (again, mainly a
> theoretical issue, since I can imagine that the cash flushes will be
> relatively "rare" events in most cases and, in any case, they happen
> to be serialized); the "continue" looked like a suitable and simpler
> approach/compromise, at least for the time being.

Yes, I'm OK with your patch "as is".  I was just thinking about the
alternative, and evidently you did too.

>=20
>=20
> >
> > >  				if (hv_get_avail_to_write_percent(
> > >  							&channel->outbound)
> > >  						> ring_avail_percent_lowater) {
> > > @@ -1350,7 +1419,10 @@ static int storvsc_do_io(struct hv_device *dev=
ice,
> > >  			for_each_cpu(tgt_cpu, &stor_device->alloced_cpus) {
> > >  				if (cpumask_test_cpu(tgt_cpu, node_mask))
> > >  					continue;
> > > -				channel =3D stor_device->stor_chns[tgt_cpu];
> > > +				channel =3D READ_ONCE(
> > > +					stor_device->stor_chns[tgt_cpu]);
> > > +				if (channel =3D=3D NULL)
> > > +					continue;
> >
> > Same comment here.
>=20
> Similarly here.

Agreed.

>=20
> Thoughts?
>=20
> Thanks,
>   Andrea
