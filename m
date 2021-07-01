Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821AD3B9479
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Jul 2021 18:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhGAQEk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Jul 2021 12:04:40 -0400
Received: from mail-dm6nam11on2107.outbound.protection.outlook.com ([40.107.223.107]:18049
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232126AbhGAQEj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Jul 2021 12:04:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+XUTQNltd2r8zU4JDVK9fHu9gnAmJs83ZoLpAObgQSKJEntLrtm5b/GgFbYs5IK48s072c3O2ersd4mkZemSdkkXnkEVGUhzVWrG9uCGRAe5ts1lKQ0bwpDytShfX6sYbEhKP6alVdaw81NoqHfqRKNG0kYGOWoMQDN8334/4K4NeNvEuk6+IGCcmk6yHXV6CTYnZDJc4GobB1+44Q8ivZ7PhQGo0bzqXIfsUVFVu/zVvBYR44SLkCytfTKRe08XJ+YqNLb5opwXHTagrp7X7jiP+Ueq/hrch+84tALoCsTqO34ydh8pRh0d1LavbdDbE6YBnYf0k1aituU2ncs1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcfoIAVNkjfggDqZCdog33KgAVrbs15JBSO36KMDn4k=;
 b=Mc1l4SpRO9YBE3EJrSLBIdL9AJ/8Xjvy0U/rMy7ZEzowkZcJkcseiPOtnRC7KsggDEnfLBsl9PuOWGWkQTQR02pQgYD3xus8V/JYG1witB0qgyhSvOQQh4UEvkKYDO1XFFnKjjiODTSCn+fSB8AaOIL5jiJRLMZn2kGwrIEI/6BlFK1I3K5olwSaWH9pAwjV4cPKu8JyGbhXDG46f6qtErMbv7KxUmOQXc1tANYpfhFMRgeh/y5RwTbxmZoHOB+zWb8gWartbMzXg2x+meuMnp+OEgX6w2GmOFFpJGUlJRYqYYfpVR0cjjrEsFPQ1GTJIxEQDGakVB2LU9TQgG1N8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcfoIAVNkjfggDqZCdog33KgAVrbs15JBSO36KMDn4k=;
 b=YI2matvZJpEelDCKEHHwiMOFhR4M0egu+k+tsV4ix6J6mWDtPL92Pt3ysGBgfQQU5P4oJCcGzCIilJcSe8uA2Wlfiz4M8HsxrvPeztOoJ0TFm7dolGDp/c5Jzlqw+XiajtMKxhp/SLDu7t/ea8gTdfy5K+P/8oKHFy63x8MjAcM=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1036.namprd21.prod.outlook.com (2603:10b6:302:a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.6; Thu, 1 Jul
 2021 16:02:06 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::880d:4f8:748:ff07]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::880d:4f8:748:ff07%6]) with mapi id 15.20.4308.006; Thu, 1 Jul 2021
 16:02:06 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Long Li <longli@microsoft.com>,
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
Thread-Index: AQHXalTRwSwb8zgU/UyKv3LljLGzrasphsOQgAQvmICAAJcUUA==
Date:   Thu, 1 Jul 2021 16:02:05 +0000
Message-ID: <MWHPR21MB15939CFE85138C6B73E575F2D7009@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB159375586D810EC5DCB66AF0D7039@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506ACF89447B492B0F7E066CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
In-Reply-To: <BY5PR21MB1506ACF89447B492B0F7E066CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=34b74f3b-f78a-4066-9c87-8e11622defa7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-28T14:56:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07d8356a-2a18-42f0-b3da-08d93ca992f9
x-ms-traffictypediagnostic: MW2PR2101MB1036:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1036927DAAF2C70201D13B61D7009@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8kkd+yzrRv9uOQGdhQJPKwHW2OI+NAbegfp4A93szCEI5PSumiOV9U4x1GWPpnAPFvHvnQcB9ccxv4n/3YsYbxAnKRpXkUFZ9ENca+YvoAyYz+EQ63N2IIkQUkMhRl689M5VaCTghPU65r+J8AAFuhyFPIZiWmXxfHK7MRLxgfv4V7KwTPTHgq21wmVmX9r2zYC/6FXYNKbgGkRAZm5Ru5KpwwIrACLFqWdsCJOyJRdKXA0RJX8BaZzrQ3bOBWmDrIyEapbpaDEBf7xkkIw5F3/yk4s/ydOHhmp7ODDf/PbkXxWopffsXd7U4dS23fMgppLW8RgmsA6bUVMuX/P9Be9b3DLXQteJLjwkQcIYkBwxfgLD3pJk0eG1AtHe3tJG3qHPWsK1L/jMuab5c9tOsmUO6ALVGbQNAWBmudfWj4zQTaMh7w2DeWED7isWkYzbwPf3MiaF5rQBoxN63GPZe3f6DJZw3PULbgFOaA1S0/Pp+XJK/8jo1u86FKTAr8rYI4kfTK1wSp6DAmlnOor7W/Xc58gI7nRAGZObpAiEcjOlINZ/xjoMeRcibJZdLxrrWKLJHA7OXtRI/nmyCUbX73iE+JvCu8HjaZVmUf99v/PpPklMTHurJgrf/YSi4NkJ4ojvX4VYF77ECimgfwaMXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8990500004)(82960400001)(4326008)(82950400001)(7416002)(5660300002)(52536014)(55016002)(110136005)(54906003)(38100700002)(66946007)(66446008)(64756008)(7696005)(66476007)(66556008)(186003)(33656002)(26005)(122000001)(8936002)(86362001)(6506007)(76116006)(10290500003)(9686003)(8676002)(71200400001)(2906002)(83380400001)(316002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H3rfRm4p3AZTJ3E0CUbt/hJNVyaBneA9CbvRbzWcxT0auNBgxtkXEoqpSOPx?=
 =?us-ascii?Q?oYSVR+P9TKwcbzZRtx33MdFlZUzj4Hbm6KopONU1noaWa3CzkFOVmnwhXf4x?=
 =?us-ascii?Q?hj8eIWY95+YOLsXxcyUpm8ap/Y2qbHINjCHIXPKtHaAAfPIcnDDTAd9KNo12?=
 =?us-ascii?Q?fH2RhP3j0YOSkZR1bRIzwI56hEgAPAbWlZIsVx3pBx5VBbMnMBlb51XDwC1T?=
 =?us-ascii?Q?mqdH7GS6V1TnVK6S4n4IJxpktLsHYEWkixznC6nc/sT/VIalaeEiqPbba8qx?=
 =?us-ascii?Q?wmXy4a/6sFNVSY4wfjBzX57q4jwLb+aanXV0jTvLB22HmuL2KQE3b8Md5EvS?=
 =?us-ascii?Q?DcU2PITWdtF5TmvSMANUgv1a18jVexutESvwSDGXlXx8edxvyuhOGom/iSLs?=
 =?us-ascii?Q?yppD89h3LN7wiRObXdySxXeRNf9IbpNKfXZSDJmA8OYn07O7530SokgRnvwW?=
 =?us-ascii?Q?Ik8jW6kTUAisbC7qm3utbNKfskvH+7fkELmJXtR8GTLc1z08qmRF5aGPNyOW?=
 =?us-ascii?Q?PxfQPIxZRTFFbBDZQx81isAulVkG+LoWBO+sW1gqycyL9G29mwaQCgrf7V4i?=
 =?us-ascii?Q?aQ2u3a8EU6Dpd3ivpwVU1hvZ7BwAXPLmrDFSc/fNFvQGgxZ5RaixKv2nUrEV?=
 =?us-ascii?Q?Ga00LJTgfaUWLRbHXAYI0C6eErZ+CLtazLAvIce/BeBJFZsjT+hqd+pK7712?=
 =?us-ascii?Q?hOWJglTx8aQ39cZ5H2UVXJh5O0ChFYNfw2ryP7eL7hHL5nXhldL/RVHd2PgN?=
 =?us-ascii?Q?4H8y+7Wo78wGA6uT0b+sOj4BMWRXvMz/m9+3swqT2zI/efJPLxBr2NdWVLd1?=
 =?us-ascii?Q?5jf3q6kd/vqvi5JdI+jnoZjgIDkj9XROYKhBhxB15bGjOwpPUKoPsidL2jKc?=
 =?us-ascii?Q?JWz1MkfgGAZWiibIbtA3aFn04qgOFex7sgRbTM9v9pUmjwXrjU4KAd3UcJZe?=
 =?us-ascii?Q?8UzhbzGSXptL1hb6PFXKcxp3EDw58sNxl3CDqP/3v+wdaWAwEwq7sxDCU+dy?=
 =?us-ascii?Q?azS7vtczlkTWimT0S14d0vSznck/PZ81VPpT+MMlLkjtpLx+p0ruFyMeyywa?=
 =?us-ascii?Q?T21/ajx8X422m0sv+IC22WAh5EZqruH2pF/sHSkK8vBlrgrIlyrxkeHIrNoG?=
 =?us-ascii?Q?CcPNvJYS60pREn/ZdPBtnnHKvZnmPtK7R7shi8cdppDhMbto8qy0vjjO5pFI?=
 =?us-ascii?Q?nzVjo1fd/VTpKjMtG938ftW8/aEeAPP+gTAMiGNTxIiZvqqB1SeB+BEqZC0/?=
 =?us-ascii?Q?lgfXkdthRcHrtpXx9LALAdGlg4I+FT7jlWFsMxKhfwt2V3bpcWNYv6FpzD/A?=
 =?us-ascii?Q?cvrOVz4gx9Zvg+VjcBXPbaJp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d8356a-2a18-42f0-b3da-08d93ca992f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 16:02:06.0694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G6Pjf5gaR0lpM6Sv7oAMdg+BEoTWD9FkmDHvnhQuwJ2aKygQd5D3NCOmAM6z0675n41KVbf8SeNURSFTPFCMR8YwNtKsP8ST5y03aXmtPkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com> Sent: Wednesday, June 30, 2021 11:51 P=
M

[snip]

> > > +static void az_blob_remove_device(struct az_blob_device *dev) {
> > > +	wait_event(dev->file_wait, list_empty(&dev->file_list));
> > > +	misc_deregister(&az_blob_misc_device);
> > > +#ifdef CONFIG_DEBUG_FS
> > > +	debugfs_remove_recursive(az_blob_debugfs_root);
> > > +#endif
> > > +	/* At this point, we won't get any requests from user-mode */ }
> > > +
> > > +static int az_blob_create_device(struct az_blob_device *dev) {
> > > +	int rc;
> > > +	struct dentry *d;
> > > +
> > > +	rc =3D misc_register(&az_blob_misc_device);
> > > +	if (rc) {
> > > +		az_blob_err("misc_register failed rc %d\n", rc);
> > > +		return rc;
> > > +	}
> > > +
> > > +#ifdef CONFIG_DEBUG_FS
> > > +	az_blob_debugfs_root =3D debugfs_create_dir("az_blob", NULL);
> > > +	if (!IS_ERR_OR_NULL(az_blob_debugfs_root)) {
> > > +		d =3D debugfs_create_file("pending_requests", 0400,
> > > +			az_blob_debugfs_root, NULL,
> > > +			&az_blob_debugfs_fops);
> > > +		if (IS_ERR_OR_NULL(d)) {
> > > +			az_blob_warn("failed to create debugfs file\n");
> > > +			debugfs_remove_recursive(az_blob_debugfs_root);
> > > +			az_blob_debugfs_root =3D NULL;
> > > +		}
> > > +	} else
> > > +		az_blob_warn("failed to create debugfs root\n"); #endif
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int az_blob_connect_to_vsp(struct hv_device *device, u32
> > > +ring_size) {
> > > +	int ret;
> > > +
> > > +	spin_lock_init(&az_blob_dev.file_lock);
> >
> > I'd argue that the spin lock should not be re-initialized here.  Here's=
 the
> > sequence where things go wrong:
> >
> > 1) The driver is unbound, so az_blob_remove() is called.
> > 2) az_blob_remove() sets the "removing" flag to true, and calls
> > az_blob_remove_device().
> > 3) az_blob_remove_device() waits for the file_list to become empty.
> > 4) After the file_list becomes empty, but before misc_deregister() is c=
alled, a
> > separate thread opens the device again.
> > 5) In the separate thread, az_blob_fop_open() obtains the file_lock spi=
n lock.
> > 6) Before az_blob_fop_open() releases the spin lock, az_blob_remove_dev=
ice()
> > completes, along with az_blob_remove().
> > 7) Then the device gets rebound, and az_blob_connect_to_vsp() gets call=
ed,
> > all while az_blob_fop_open() still holds the spin lock.  So the spin lo=
ck get re-
> > initialized while it is held.
> >
> > This is admittedly a far-fetched scenario, but stranger things have
> > happened. :-)  The issue is that you are counting on the az_blob_dev st=
ructure
> > to persist and have a valid file_lock, even while the device is unbound=
.  So any
> > initialization should only happen in az_blob_drv_init().
>=20
> I'm not sure if az_blob_probe() and az_blob_remove() can be called at the
> same time, as az_blob_remove_vmbus() is called the last in az_blob_remove=
().
> Is it possible for vmbus asking the driver to probe a new channel before =
the
> old channel is closed? I expect the vmbus provide guarantee that those ca=
lls
> are made in sequence.

In my scenario above, az_blob_remove_vmbus() and az_blob_remove() run to
completion in Step #6, all while some other thread is still in the middle o=
f an
open() call and holding the file_lock spin lock.  Then in Step #7 az_blob_p=
robe()
runs.  So az_blob_remove() and az_blob_probe() execute sequentially, not at
the same time.

Michael

>=20
> >
> > > +	INIT_LIST_HEAD(&az_blob_dev.file_list);
> > > +	init_waitqueue_head(&az_blob_dev.file_wait);
> > > +
> > > +	az_blob_dev.removing =3D false;
> > > +
> > > +	az_blob_dev.device =3D device;
> > > +	device->channel->rqstor_size =3D device_queue_depth;
> > > +
> > > +	ret =3D vmbus_open(device->channel, ring_size, ring_size, NULL, 0,
> > > +			az_blob_on_channel_callback, device->channel);
> > > +
> > > +	if (ret) {
> > > +		az_blob_err("failed to connect to VSP ret %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	hv_set_drvdata(device, &az_blob_dev);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void az_blob_remove_vmbus(struct hv_device *device) {
> > > +	/* At this point, no VSC/VSP traffic is possible over vmbus */
> > > +	hv_set_drvdata(device, NULL);
> > > +	vmbus_close(device->channel);
> > > +}
> > > +
> > > +static int az_blob_probe(struct hv_device *device,
> > > +			const struct hv_vmbus_device_id *dev_id) {
> > > +	int rc;
> > > +
> > > +	az_blob_dbg("probing device\n");
> > > +
> > > +	rc =3D az_blob_connect_to_vsp(device, az_blob_ringbuffer_size);
> > > +	if (rc) {
> > > +		az_blob_err("error connecting to VSP rc %d\n", rc);
> > > +		return rc;
> > > +	}
> > > +
> > > +	// create user-mode client library facing device
> > > +	rc =3D az_blob_create_device(&az_blob_dev);
> > > +	if (rc) {
> > > +		az_blob_remove_vmbus(device);
> > > +		return rc;
> > > +	}
> > > +
> > > +	az_blob_dbg("successfully probed device\n");
> > > +	return 0;
> > > +}
> > > +
> > > +static int az_blob_remove(struct hv_device *dev) {
> > > +	struct az_blob_device *device =3D hv_get_drvdata(dev);
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&device->file_lock, flags);
> > > +	device->removing =3D true;
> > > +	spin_unlock_irqrestore(&device->file_lock, flags);
> > > +
> > > +	az_blob_remove_device(device);
> > > +	az_blob_remove_vmbus(dev);
> > > +	return 0;
> > > +}
> > > +
> > > +static struct hv_driver az_blob_drv =3D {
> > > +	.name =3D KBUILD_MODNAME,
> > > +	.id_table =3D id_table,
> > > +	.probe =3D az_blob_probe,
> > > +	.remove =3D az_blob_remove,
> > > +	.driver =3D {
> > > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > > +	},
> > > +};
> > > +
> > > +static int __init az_blob_drv_init(void) {
> > > +	int ret;
> > > +
> > > +	ret =3D vmbus_driver_register(&az_blob_drv);
> > > +	return ret;
> > > +}
> > > +
> > > +static void __exit az_blob_drv_exit(void) {
> > > +	vmbus_driver_unregister(&az_blob_drv);
> > > +}
