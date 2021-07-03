Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39513BA905
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Jul 2021 16:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhGCOjm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 3 Jul 2021 10:39:42 -0400
Received: from mail-bn8nam12on2122.outbound.protection.outlook.com ([40.107.237.122]:44512
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229562AbhGCOjm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 3 Jul 2021 10:39:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEYNGCaP8xBblXc5OtdUdiFfO7rcjbhb0fksYFR5/hBXCH0N+Cjyio/Tdaym4MBD6aIZTBUi291w5UYviR9SP1CUTP4UHqj6q5P8uRHr7+8mEt/DMMsADwVpx6Q2VjDR58V7FoTqZBukPWQChEyjnjM7jJekfKgIL+LOsv+T0k4LbTZ59hNAQCb6IdfMifmiv02MIAZlcQjqERWiFx6rqc5XnoUu/3YPnw6LQwOXgY5OH9zTdx4dgoUvBORUnZZE4SaVUlmhqx4RfKi0wdQmB2/hr5QZh8iytacaZ3KCD0mYHw5yt4UCgy5yaITOLeMIniikG4bZ+U+XAFeHjo/48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49JA+MgZlI0MZsG1B0iJGCiybQ3oUGl/HUzfFAEyKwU=;
 b=FS13T06sNGQZ/0vu+1VeCmWCWxNmLLjGqgC2FVz97ncLVWdHgIUxwXJsr3qzs24NfSodUlEkd1Fqqr/FcjtfrxFMyGeM+zrlpfmh9SrWF7ntK5ZbXU8C1ESNf/GtsdYg5AFBX0eBXgzj1otEirKTfWVUx/Hd95jwJ5pY3vIyjA5jjg9CGglkhGOCj0XlTOxyOisWNRYRswicQO8816Nlf3Vr3Z/tUUbAX9F6B/APUjQEfITst0RAv1lVAxnJPMZcayBTuvGwwo21/+vqpvbtoOo0LIr1X6mdKqV5ffVbobeekFM3EKGGIOxu9PYBTzhkGfTqAwQ6k1u/g5go0jLvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49JA+MgZlI0MZsG1B0iJGCiybQ3oUGl/HUzfFAEyKwU=;
 b=F6rZhTGGyHfTCwFkNoyrKBQpJ1outR/EJN7bGA/fv9G+mfqrguuJpMMZb/jQXRghQsCyp2NYx/1NghrjIoPYylSEVbSMVCo8LZ9MB9/5OlIiBFTtWCI6QLcxC7mNcV2TbmkT2i3nnh3M0j6QWKUdT4iW5Djy1IXBpkbJq/UrL9I=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB2043.namprd21.prod.outlook.com (2603:10b6:303:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.15; Sat, 3 Jul
 2021 14:37:06 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::880d:4f8:748:ff07]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::880d:4f8:748:ff07%6]) with mapi id 15.20.4308.006; Sat, 3 Jul 2021
 14:37:06 +0000
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
Thread-Index: AQHXalTRwSwb8zgU/UyKv3LljLGzrasphsOQgAQvmICAAJcUUIACGm+AgAD0NsA=
Date:   Sat, 3 Jul 2021 14:37:06 +0000
Message-ID: <MWHPR21MB1593685E6FE65D641CE1B546D71E9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB159375586D810EC5DCB66AF0D7039@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506ACF89447B492B0F7E066CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15939CFE85138C6B73E575F2D7009@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506C29FA7FB4588E3A2BB5ECE1F9@BY5PR21MB1506.namprd21.prod.outlook.com>
In-Reply-To: <BY5PR21MB1506C29FA7FB4588E3A2BB5ECE1F9@BY5PR21MB1506.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=34b74f3b-f78a-4066-9c87-8e11622defa7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-28T14:56:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 263ad2d2-5f22-41e1-92a8-08d93e300815
x-ms-traffictypediagnostic: MW4PR21MB2043:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB204398D1A4A28CB2D3100426D71E9@MW4PR21MB2043.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PdPQlKjzXXRJpCDQeWgKDf44FjmNACpqrO/epHJvJnkk9mlrHM5aUe1KzDE+A0/LtBYz3DNUEerkQlNJfX3kbRzVIqdvm/ecBb1aXSVIIszFHVuB+3kcrRJro5nY1ekHYwqQPQXl+dJYzn8hmeMZ7ZanzrS86HO562GaZPxaQip7Qh0qnJtE2qc1RMQUmkWt/HsGEy0nW7lI5EU4mMXMscQ1Xbk2L0caOBOmqDM9WUlZbztZQ4foRuRurIL0eVhiCIgxvGMk/I2BotQ64hXCYjEG45NWqBxgJI12fndqxN519JnWqNxGSyllPit1vUkKlwlnaT/zSCI4GvXno7lvFJnBoKQQfLE2AkgEmu8NLxiNRHFoWh+ootcmw3iJ3ONqwsxBx3qs+V00i3eOWjv3lZFztAYDAgJWL5ivYlP3f+VOgXlIG7bR/EkLKLWLwxw/Q77c2tsHtNlnrQjUqJn3gJw8VmQAnZe4VMvABjXFziVFc/WEpPKF0hCe/lIfgeykaPLzWEQrTbxDjH9bvACgyBB6Jiub4Epyfg7M9P+kLxIZiHFt/keQPHhxOywee4EHUj0mbNmKFYwwm1HYDXaf6F4O+0vNB41PAEjPrZPLNfUmsVYUJmg5rL5g0B8axrpmbb93g4KbEEuadyso9PTVCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(10290500003)(8990500004)(4326008)(478600001)(2906002)(33656002)(122000001)(316002)(8936002)(71200400001)(83380400001)(8676002)(76116006)(38100700002)(86362001)(55016002)(6506007)(64756008)(9686003)(82960400001)(82950400001)(186003)(54906003)(5660300002)(110136005)(26005)(7696005)(66476007)(66556008)(7416002)(52536014)(66446008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?maMQoVcume274B5PeRfvOWXtPkI6RB43PBHclXtmGs9Xt8RzTujC2dO57iZI?=
 =?us-ascii?Q?v6pEV1FBwo58Nm1xZ+VDWhxfd/eVT3SJFR1+J/a1LmAM8KB1dtvCbMPkw7/x?=
 =?us-ascii?Q?OPaqmf8D8OUOrD4dzxsgLMvUM1zuxXxlGDeMruHXpzI5AxyIdvT3jhfkwbxN?=
 =?us-ascii?Q?XBDiYCisE5Ngc37Qp0dTzqZ5vIBzqQa+xaOEQA0Tuk5SDbS1NvR0LY9PtMUF?=
 =?us-ascii?Q?ZqRcP1Oehm5zLCwvvffpL35h0sj0f5WpNEGDIT2EXRz2r0tehixHS4506lou?=
 =?us-ascii?Q?TnQMwtZ/HhX1ifE/Udvi6+S1B3oWY95ZCqZd24eIBnQ1Hs2E4ZRHOX8q2Lqg?=
 =?us-ascii?Q?unDAaSIKKYqnD0J4k63HAH8wKWy3PzHrauz/av9l3QZWW2xv/HfpWgZBqhUY?=
 =?us-ascii?Q?rvdZAbO/5UnlC7rlcgEIXEa6NjlP3DLKqa9UMPBGaqbv6NA4KLGs3wwGkAWe?=
 =?us-ascii?Q?aQ8XM9WF0oef/t9uCMIvOxQaFQHrN+yDvC5qpgh7DyOdQ+NBiUH1ycxd1P1X?=
 =?us-ascii?Q?5riSuril6U0q2xYEZZLwTIqBlBMyLbODnIAfTxjpsvyNIWLIfbpM0HGz92/P?=
 =?us-ascii?Q?1aFsRUIbPVxqdNxfYzcAD4OH/3qXCrvzNuwPvsPxszIUuU7AWcHC2SXGEe1K?=
 =?us-ascii?Q?8AvZMgtZYw1b9YarjD6OvudyYZkacutLayIJy/wEQouO0DxiSeLoG36Wot4N?=
 =?us-ascii?Q?8odXv9nBczuAlLH9HAJ3hnuKOcNgW4wjPJDKIRnm5y6YefDreQW1w2OnoXTs?=
 =?us-ascii?Q?xpTSCOmSu9z1nq2feVm4gep/wf7Q/Lhub9IcFAFf7dsARCGfx5oxHEYssH75?=
 =?us-ascii?Q?LvrcMJhjZGQ1gXCLNFuI6gpwxzI029l/n+D3A6DTktn+7uS67jPGODc00PFl?=
 =?us-ascii?Q?cnMg2HV538Ghfsivk1I3AKppogv39NpVzM0h7mHLNY/OJBa8+kwGEIzW19zo?=
 =?us-ascii?Q?HEVaq3C7MpVmz71dHEYuwHywlcUArHO9jWSRQb3WrW+X/oUu0YlErokXz0Ll?=
 =?us-ascii?Q?uFPVeJNJ1Q0KB5MG9zOE1rThS2wBFstU8XkQLaPDovDjbSIzK/eweMhJbVt0?=
 =?us-ascii?Q?8h3rQFo5z6eJW7SoIHzxoJbj3oCueRSAmVtqLwfHJPjhj56+ikrpwVbQPI16?=
 =?us-ascii?Q?5J7+9KLXj4zE8ateqPp7EE+Wcn6trLcD1O/Pv+8mZ8mv4Hs6H2EIVwxUTQbu?=
 =?us-ascii?Q?ORagzhYnTa35F/4lolzzPEz+JtSzwd2cMGT58m4Ufe/7zQ2idWpLt5F3YLEn?=
 =?us-ascii?Q?AR5mKTA4kNsEu01AXxeAdwb2MfdLLXjHQO0PdnJecwLM+enPfUJCHQeyUGe7?=
 =?us-ascii?Q?o4tVwngQMGtr0297S5NW/2qO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263ad2d2-5f22-41e1-92a8-08d93e300815
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2021 14:37:06.2910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /l4lPGuFBh7Y6r2ELFndu6wW8q1DUWlsTJcIjOSeyuraMaGsfE6dkVJvjlu83QjAC4zmsr6X60UGU8ZobwVHxk3+O6eIj4whfbs4o1KNHeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2043
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com> Sent: Friday, July 2, 2021 4:59 PM
> >
> > [snip]
> >
> > > > > +static void az_blob_remove_device(struct az_blob_device *dev) {
> > > > > +	wait_event(dev->file_wait, list_empty(&dev->file_list));
> > > > > +	misc_deregister(&az_blob_misc_device);
> > > > > +#ifdef CONFIG_DEBUG_FS
> > > > > +	debugfs_remove_recursive(az_blob_debugfs_root);
> > > > > +#endif
> > > > > +	/* At this point, we won't get any requests from user-mode */ }
> > > > > +
> > > > > +static int az_blob_create_device(struct az_blob_device *dev) {
> > > > > +	int rc;
> > > > > +	struct dentry *d;
> > > > > +
> > > > > +	rc =3D misc_register(&az_blob_misc_device);
> > > > > +	if (rc) {
> > > > > +		az_blob_err("misc_register failed rc %d\n", rc);
> > > > > +		return rc;
> > > > > +	}
> > > > > +
> > > > > +#ifdef CONFIG_DEBUG_FS
> > > > > +	az_blob_debugfs_root =3D debugfs_create_dir("az_blob", NULL);
> > > > > +	if (!IS_ERR_OR_NULL(az_blob_debugfs_root)) {
> > > > > +		d =3D debugfs_create_file("pending_requests", 0400,
> > > > > +			az_blob_debugfs_root, NULL,
> > > > > +			&az_blob_debugfs_fops);
> > > > > +		if (IS_ERR_OR_NULL(d)) {
> > > > > +			az_blob_warn("failed to create debugfs file\n");
> > > > > +			debugfs_remove_recursive(az_blob_debugfs_root);
> > > > > +			az_blob_debugfs_root =3D NULL;
> > > > > +		}
> > > > > +	} else
> > > > > +		az_blob_warn("failed to create debugfs root\n"); #endif
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int az_blob_connect_to_vsp(struct hv_device *device, u32
> > > > > +ring_size) {
> > > > > +	int ret;
> > > > > +
> > > > > +	spin_lock_init(&az_blob_dev.file_lock);
> > > >
> > > > I'd argue that the spin lock should not be re-initialized here.
> > > > Here's the sequence where things go wrong:
> > > >
> > > > 1) The driver is unbound, so az_blob_remove() is called.
> > > > 2) az_blob_remove() sets the "removing" flag to true, and calls
> > > > az_blob_remove_device().
> > > > 3) az_blob_remove_device() waits for the file_list to become empty.
> > > > 4) After the file_list becomes empty, but before misc_deregister()
> > > > is called, a separate thread opens the device again.
> > > > 5) In the separate thread, az_blob_fop_open() obtains the file_lock=
 spin
> > lock.
> > > > 6) Before az_blob_fop_open() releases the spin lock,
> > > > az_blob_remove_device() completes, along with az_blob_remove().
> > > > 7) Then the device gets rebound, and az_blob_connect_to_vsp() gets
> > > > called, all while az_blob_fop_open() still holds the spin lock.  So
> > > > the spin lock get re- initialized while it is held.
> > > >
> > > > This is admittedly a far-fetched scenario, but stranger things have
> > > > happened. :-)  The issue is that you are counting on the az_blob_de=
v
> > > > structure to persist and have a valid file_lock, even while the
> > > > device is unbound.  So any initialization should only happen in
> > az_blob_drv_init().
> > >
> > > I'm not sure if az_blob_probe() and az_blob_remove() can be called at
> > > the same time, as az_blob_remove_vmbus() is called the last in
> > az_blob_remove().
> > > Is it possible for vmbus asking the driver to probe a new channel
> > > before the old channel is closed? I expect the vmbus provide guarante=
e
> > > that those calls are made in sequence.
> >
> > In my scenario above, az_blob_remove_vmbus() and az_blob_remove() run
> > to completion in Step #6, all while some other thread is still in the m=
iddle of
> > an
> > open() call and holding the file_lock spin lock.  Then in Step #7
> > az_blob_probe() runs.  So az_blob_remove() and az_blob_probe() execute
> > sequentially, not at the same time.
> >
> > Michael
>=20
> I think it's a valid scenario.  The return value of devtmpfs_delete_node(=
) is
> not checked in misc_deregister(). It decreases the refcount on inodes but=
 it's
> not guaranteed that someone else is still using it (in the middle of open=
ing a file).
>=20
> However, this works fine for "rmmod" that causes device to be removed.
> Before file is opened the refcount on the module is increased so it can't=
 be
> removed when file is being opened. The scenario you described can't happe=
n.
>=20
> But during VMBUS rescind, it can happen. It's possible that the driver is=
 using
> the spinlock that has been re-initialized, when the next VMBUS offer on t=
he
>  same channel comes before all the attempting open file calls exit.

In my scenario, Step #1 is an unbind operation, not a module removal.  But
you make a valid point about VMbus rescind, which has the same effect as
unbind.

>=20
> This is a very rare. I agree things happen that we should make sure the d=
river
> can handle this. I'll update the driver.

Sounds good.

Michael
