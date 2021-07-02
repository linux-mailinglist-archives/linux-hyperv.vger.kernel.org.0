Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8A33BA658
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Jul 2021 01:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhGCAB5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Jul 2021 20:01:57 -0400
Received: from mail-dm6nam11on2133.outbound.protection.outlook.com ([40.107.223.133]:16921
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230017AbhGCAB5 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Jul 2021 20:01:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b++3s6/NOPHWpmSuc1qHNE8JYztmZREy27AncUG/c2qzwpL5PJO4FoeTKVow45ZBDVR3KWovmKwEguWN7Bk+yywoKn08zBe0LRKtNFHa7GSEBDPhmC87MmIlR+pnSn9w/A4Vw6mHzOCADhGZFvE5IbiilZwNpaBa98UeFvQL9MoaaY8QtQSwAMXCSm2fxb4Fh9KUW6jQf4ZcSAHDNggG6ryzbGVLbPdM3bbSELpHLFRMUivAeb2m9H/4jN5nI090NsAgGgRlYweXrBY6jIHAJDU45ZqojUcVJAu5DFoyRPImfY/SolSWuU5wvr8MPimnG+3lx2zsHgL4TSMUGGExoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5PAGv5LGqOaiJ90dfDCc6C0a7fHKZgPEakYjdcuUVc=;
 b=I9Wz93nNea9OORPrO7qQTrnRpCFNufOXX98A/205tfsDfsvuHdcZs11Hs5u05fviVFyhT+4zy0QUtAJbv1tX/70Hk5WBlgukxrcUOZCgFlLJUcJZb/iONDxb04IERdYhFN3S6hnvoZxg6lEczcnMvcWArpPsr6yfDCG3vUxrKrJodpFd2j3sD31LPKn2qGMTwqiWeJ5YbDSld+edoFXNTinS+IP9n+YkwyUEB3PTDBbrsRvoNRgVc55VI0JtV0Z64Cg+wgYyyJoF9iUAJ/7qT3Aws3co+w2YDV4C+Yo+CddtqHiLPCm+6TNoCj2AxYtjb4tPkFtTrshEfMtxfmtbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5PAGv5LGqOaiJ90dfDCc6C0a7fHKZgPEakYjdcuUVc=;
 b=RnxI+jqRHreoYP8dyN1oXQXiqv//XOa+kX0slbfZCxHK9R/BmiI/yi6RjdZJaHr66JEr59ULO9CN8BryzX9AyI3uEsqS+1KzTdsMaBNJtipyjeyeBaIPXQCxB9OdEkaFZtgvidhays3pxVUCT96Tiu7kROI/qe4WTQCADgPNr+I=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1144.namprd21.prod.outlook.com (2603:10b6:a03:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.5; Fri, 2 Jul
 2021 23:59:18 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::f126:bfd2:f903:62a3]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::f126:bfd2:f903:62a3%5]) with mapi id 15.20.4308.007; Fri, 2 Jul 2021
 23:59:18 +0000
From:   Long Li <longli@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXalTR5lVKFlOZkEmq8/y9Kgt/basp6bQAgAPHdaCAAJ8MgIACFAVQ
Date:   Fri, 2 Jul 2021 23:59:17 +0000
Message-ID: <BY5PR21MB1506C29FA7FB4588E3A2BB5ECE1F9@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB159375586D810EC5DCB66AF0D7039@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506ACF89447B492B0F7E066CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15939CFE85138C6B73E575F2D7009@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB15939CFE85138C6B73E575F2D7009@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=34b74f3b-f78a-4066-9c87-8e11622defa7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-28T14:56:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01daccbe-4dfc-45f6-fb8b-08d93db56745
x-ms-traffictypediagnostic: BYAPR21MB1144:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB11448EAE2B736F5A7C23F8FECE1F9@BYAPR21MB1144.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mz6EwWzmeeGMBFhbQxkzITQRQkTwn2hVj3i80lbgukWSaAfIoevqES3a+aVp/KB0++d5bsu2Z4WmJ689MKM/P71paEQPrrewOp+B30uu11Yi7KWSJ6sJqqKmGrtFCFghs33NdnA6P+tkrQ/lRpheZg8SOP1aLFl7AlvZtE1bJBE+vnGUFumxZrfFWGPBZUj32zIIoL3N6/sUkZjpg9n3DFnP8w6lBtudLwOd0Xp1p4H6ExSZy4+TMZKAw8X+JBS6RHH+I0psp3WNk2IEOk/JLDmfW/UQOz0n4oGdoD9v+PWl7gAnSNPZU7WtwhcrRA4DByvJxaIMPMYKGIh/lLns6JckjWDNRhPcsC0OpySGPlCdLUYMXHY1+tMWB3g/skmO4y740dINSeG3+y4pGc/Ic+hO63spFMP8Nr2LuMUJJCUvIo8FEtHGZmmTwVoK2/tVBT4U0Kr/pJReuB7tfz6ZnUB+ayAYAN68rocF1oJPBSFk2ccQPEFQxh+HssuSQ3S+p+VJ9237brhcJY8pBDerywliefqLM4aWowE/gJUXZAi78H9sBEKZB1loY+Y8JCdCkuztTfSeyJmtg/ASR+CxcZvd6QHg3ga+5mJiJ6GWFTdxQTyf0VJJx4oMu7VNTP9mI7JK5l+OxNYn+e0QZ+ugbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(2906002)(7416002)(71200400001)(8676002)(76116006)(478600001)(66556008)(66446008)(64756008)(66476007)(86362001)(38100700002)(8990500004)(9686003)(55016002)(26005)(10290500003)(82950400001)(186003)(122000001)(82960400001)(7696005)(33656002)(83380400001)(316002)(52536014)(110136005)(54906003)(5660300002)(8936002)(4326008)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2ejoCv4MHdlPNdmRn5yiTNGJAC9MRn438RZ4MTWUhUHEe57nlTT9pQAbc+5q?=
 =?us-ascii?Q?oPZwRGKMnYhrCWhmUaczujdgD0Xqk+dL23uB2mO96iNlQ1k4e9zhVhe+ixSX?=
 =?us-ascii?Q?n7s9mhJwMWZ00d0liqpzPe+AbSeurMEd6NP6AfroEIRAgYwqMEcieSSrHfiU?=
 =?us-ascii?Q?dL3ekJkMqUl8+WbabEwzab4Q+fZrUko88wGIuGWXrZsaBaq3B8xWPcugoX3f?=
 =?us-ascii?Q?6fK+nx0AC6XEgSz71OQQeQDVg2T9fAtygloLKNYXATsHL/PBa1qwknfyS/fm?=
 =?us-ascii?Q?DN9ZORfULX8X94LaYyxyBZqLjDXmGVNj9XE8Vsy7wvJ3jdGXirj1J5v5m1Rz?=
 =?us-ascii?Q?jqS2eRYfGnD7/dEySM89YXC3TzEf5cEmFYtwfPJCmQ0xvXtqp6DE59TEaMYW?=
 =?us-ascii?Q?MPmxTONaafp/l5FOcyqjc0QrCJ+rmU045Ebgj9iIHkWnUmb/bELogD0Fz51C?=
 =?us-ascii?Q?Xa5gW/fZwrF3rhUzsWg8e/H7O1g6FKI3LNt7anEysa8MJR7QHoG/K+UhIm97?=
 =?us-ascii?Q?QruWqmQX6LUATSy7UK/Y4vjnFbZpVu4Lw1uNdMx2vnNM9CvuL2PX0TYuEioK?=
 =?us-ascii?Q?/m8LlbX+6+sR/jGweiOflyXr3fiaZucHH9v5YlBClmLT70X2GlMOyiqtwvuD?=
 =?us-ascii?Q?Ij9dn4/+GADfYSGgInPCOncOQnymrT+C6hU6ke3b2PRDfJ+Lhw1ZLZ5Xc5Q4?=
 =?us-ascii?Q?0iNZ4ukF33ugIpAJ/FPv/tXEVwuZMhL6o+VZwTu/SXW82iSISGNLQTjl6T6s?=
 =?us-ascii?Q?cFPyes2RYGyP8Ebe9NX7nT3jp/jQwym3N1LtBAVBcbK/U/zepMeAbNX3QqXk?=
 =?us-ascii?Q?D8mSbtfw2l+Hr/dvQxXZxWnzeXtIBrc83yzfjMvdUdTvwa37rnROJOnYpM0S?=
 =?us-ascii?Q?j3NY+x5KpYtMOMrq0QPmV0S8CPmTIgrdhXk0Emnd5kOsxGDeDyne/wvbfne/?=
 =?us-ascii?Q?l3hq8ShTC2guB/k0YXpZ0l5foXkhdWJfCxT7zAqsWsDxjFmStYEoCatzbuuK?=
 =?us-ascii?Q?lqOeWzdLdWpU26+xxG4MYh/uRkSyazKKFvt9ZPz3EjLlSabOOqLksmjbjB4s?=
 =?us-ascii?Q?zb6suxv0Pz+vYdjBIqP4v0KrrKZ6OnHL/2hvS/koCNVtO22DtjAlGPE0ji+m?=
 =?us-ascii?Q?KaT8xP+/zcSlBqw/tm2Pds5gMvTnvzrE5YASw84RvQESaGzyAkEP59QNwYoi?=
 =?us-ascii?Q?EonhAVW/GTMTF3kd5SOJTVWLee+TfW50KAXNoxzIJ4ZQaSqY5RsX9dlp6vp8?=
 =?us-ascii?Q?yYMTR2GsVazm3mB9QpevXPZ3VtAyx4Ipoe7pQhLVnimfq5qaYNiRTglFkII/?=
 =?us-ascii?Q?Tmc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01daccbe-4dfc-45f6-fb8b-08d93db56745
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 23:59:17.9385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWTAIK4qgQg3q3rND6p0tzE4cHhqfMcXyHs5ewSfd8n6AeKDX5/f3Uxo3bhsH6mAERgNcarLqOMQ7bpzyJxryw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1144
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
>=20
> From: Long Li <longli@microsoft.com> Sent: Wednesday, June 30, 2021 11:51
> PM
>=20
> [snip]
>=20
> > > > +static void az_blob_remove_device(struct az_blob_device *dev) {
> > > > +	wait_event(dev->file_wait, list_empty(&dev->file_list));
> > > > +	misc_deregister(&az_blob_misc_device);
> > > > +#ifdef CONFIG_DEBUG_FS
> > > > +	debugfs_remove_recursive(az_blob_debugfs_root);
> > > > +#endif
> > > > +	/* At this point, we won't get any requests from user-mode */ }
> > > > +
> > > > +static int az_blob_create_device(struct az_blob_device *dev) {
> > > > +	int rc;
> > > > +	struct dentry *d;
> > > > +
> > > > +	rc =3D misc_register(&az_blob_misc_device);
> > > > +	if (rc) {
> > > > +		az_blob_err("misc_register failed rc %d\n", rc);
> > > > +		return rc;
> > > > +	}
> > > > +
> > > > +#ifdef CONFIG_DEBUG_FS
> > > > +	az_blob_debugfs_root =3D debugfs_create_dir("az_blob", NULL);
> > > > +	if (!IS_ERR_OR_NULL(az_blob_debugfs_root)) {
> > > > +		d =3D debugfs_create_file("pending_requests", 0400,
> > > > +			az_blob_debugfs_root, NULL,
> > > > +			&az_blob_debugfs_fops);
> > > > +		if (IS_ERR_OR_NULL(d)) {
> > > > +			az_blob_warn("failed to create debugfs file\n");
> > > > +			debugfs_remove_recursive(az_blob_debugfs_root);
> > > > +			az_blob_debugfs_root =3D NULL;
> > > > +		}
> > > > +	} else
> > > > +		az_blob_warn("failed to create debugfs root\n"); #endif
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int az_blob_connect_to_vsp(struct hv_device *device, u32
> > > > +ring_size) {
> > > > +	int ret;
> > > > +
> > > > +	spin_lock_init(&az_blob_dev.file_lock);
> > >
> > > I'd argue that the spin lock should not be re-initialized here.
> > > Here's the sequence where things go wrong:
> > >
> > > 1) The driver is unbound, so az_blob_remove() is called.
> > > 2) az_blob_remove() sets the "removing" flag to true, and calls
> > > az_blob_remove_device().
> > > 3) az_blob_remove_device() waits for the file_list to become empty.
> > > 4) After the file_list becomes empty, but before misc_deregister()
> > > is called, a separate thread opens the device again.
> > > 5) In the separate thread, az_blob_fop_open() obtains the file_lock s=
pin
> lock.
> > > 6) Before az_blob_fop_open() releases the spin lock,
> > > az_blob_remove_device() completes, along with az_blob_remove().
> > > 7) Then the device gets rebound, and az_blob_connect_to_vsp() gets
> > > called, all while az_blob_fop_open() still holds the spin lock.  So
> > > the spin lock get re- initialized while it is held.
> > >
> > > This is admittedly a far-fetched scenario, but stranger things have
> > > happened. :-)  The issue is that you are counting on the az_blob_dev
> > > structure to persist and have a valid file_lock, even while the
> > > device is unbound.  So any initialization should only happen in
> az_blob_drv_init().
> >
> > I'm not sure if az_blob_probe() and az_blob_remove() can be called at
> > the same time, as az_blob_remove_vmbus() is called the last in
> az_blob_remove().
> > Is it possible for vmbus asking the driver to probe a new channel
> > before the old channel is closed? I expect the vmbus provide guarantee
> > that those calls are made in sequence.
>=20
> In my scenario above, az_blob_remove_vmbus() and az_blob_remove() run
> to completion in Step #6, all while some other thread is still in the mid=
dle of
> an
> open() call and holding the file_lock spin lock.  Then in Step #7
> az_blob_probe() runs.  So az_blob_remove() and az_blob_probe() execute
> sequentially, not at the same time.
>=20
> Michael

I think it's a valid scenario.  The return value of devtmpfs_delete_node() =
is not checked in misc_deregister(). It decreases the refcount on inodes bu=
t it's not guaranteed that someone else is still using it (in the middle of=
 opening a file).

However, this works fine for "rmmod" that causes device to be removed. Befo=
re file is opened the refcount on the module is increased so it can't be re=
moved when file is being opened. The scenario you described can't happen.

But during VMBUS rescind, it can happen. It's possible that the driver is u=
sing the spinlock that has been re-initialized, when the next VMBUS offer o=
n the same channel comes before all the attempting open file calls exit.

This is a very rare. I agree things happen that we should make sure the dri=
ver can handle this. I'll update the driver.

Long

>=20
> >
> > >
> > > > +	INIT_LIST_HEAD(&az_blob_dev.file_list);
> > > > +	init_waitqueue_head(&az_blob_dev.file_wait);
> > > > +
> > > > +	az_blob_dev.removing =3D false;
> > > > +
> > > > +	az_blob_dev.device =3D device;
> > > > +	device->channel->rqstor_size =3D device_queue_depth;
> > > > +
> > > > +	ret =3D vmbus_open(device->channel, ring_size, ring_size, NULL, 0=
,
> > > > +			az_blob_on_channel_callback, device->channel);
> > > > +
> > > > +	if (ret) {
> > > > +		az_blob_err("failed to connect to VSP ret %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	hv_set_drvdata(device, &az_blob_dev);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static void az_blob_remove_vmbus(struct hv_device *device) {
> > > > +	/* At this point, no VSC/VSP traffic is possible over vmbus */
> > > > +	hv_set_drvdata(device, NULL);
> > > > +	vmbus_close(device->channel);
> > > > +}
> > > > +
> > > > +static int az_blob_probe(struct hv_device *device,
> > > > +			const struct hv_vmbus_device_id *dev_id) {
> > > > +	int rc;
> > > > +
> > > > +	az_blob_dbg("probing device\n");
> > > > +
> > > > +	rc =3D az_blob_connect_to_vsp(device, az_blob_ringbuffer_size);
> > > > +	if (rc) {
> > > > +		az_blob_err("error connecting to VSP rc %d\n", rc);
> > > > +		return rc;
> > > > +	}
> > > > +
> > > > +	// create user-mode client library facing device
> > > > +	rc =3D az_blob_create_device(&az_blob_dev);
> > > > +	if (rc) {
> > > > +		az_blob_remove_vmbus(device);
> > > > +		return rc;
> > > > +	}
> > > > +
> > > > +	az_blob_dbg("successfully probed device\n");
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int az_blob_remove(struct hv_device *dev) {
> > > > +	struct az_blob_device *device =3D hv_get_drvdata(dev);
> > > > +	unsigned long flags;
> > > > +
> > > > +	spin_lock_irqsave(&device->file_lock, flags);
> > > > +	device->removing =3D true;
> > > > +	spin_unlock_irqrestore(&device->file_lock, flags);
> > > > +
> > > > +	az_blob_remove_device(device);
> > > > +	az_blob_remove_vmbus(dev);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static struct hv_driver az_blob_drv =3D {
> > > > +	.name =3D KBUILD_MODNAME,
> > > > +	.id_table =3D id_table,
> > > > +	.probe =3D az_blob_probe,
> > > > +	.remove =3D az_blob_remove,
> > > > +	.driver =3D {
> > > > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > > > +	},
> > > > +};
> > > > +
> > > > +static int __init az_blob_drv_init(void) {
> > > > +	int ret;
> > > > +
> > > > +	ret =3D vmbus_driver_register(&az_blob_drv);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static void __exit az_blob_drv_exit(void) {
> > > > +	vmbus_driver_unregister(&az_blob_drv);
> > > > +}
