Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C093C29CF
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 21:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhGITq4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 15:46:56 -0400
Received: from mail-dm6nam10on2130.outbound.protection.outlook.com ([40.107.93.130]:2657
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229459AbhGITqz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 15:46:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jddnb2fbDLjLZ75XJv/B3SEN4kw1z2fF9zc8z81dOOD6Rtvgg4nlpR5XyvDGClMPRnkhLan2v867UNSE3lnE5w1RaxvPiRuxQWSzO+YXkRm+GDESR8uHXpG8fGZRRbYMh85BtvgllUvt4XIWG6P2MW1xWUzCr7xgc8HOCf21X9rxiLqE48qVfX3V7iV8U3aeh22vXuBfcoS472x7DomXdIsmLCrMNSzvWQiSugKk0r9XUQcwCBw67RjjnmPvSqDEgijr6B+t9GH93OgP9b2aicCqFcqS2jCTotMrwUvO3p95kFlc1VFAwNcsXCXXm+eXGUWnmYStxsX7jm0nk7d01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fGXAYr5WxOrcNrfxcJvbl6SmjKdXUH5KKQzWHZ2DVw=;
 b=TPKWw37kY54n9b6LC1e8MfGwOcR7aKPB5prcnIY+Tdqm+iWlyqjw6C/am7MHwHH2rJnk+zRjiWoKhXB/Y0nQFGLD3LoP0I7PNMhEpuZKtpMVe5tc2SHF3ECIULADWa6EhDkA80aufJliA5PRje7xOlJp6I8rSx63LWYI4Prm4JnSpGGI4J/OGgmr2tvbGLUf3PEvujoSvMhhPDY6w4/vUlZvuTEN3BhwFRHgk2hbp9unl4wVm6F/EVYQbmoQo9WiS9cyPUSFe/3uqeVIwKnQPShgNTQ+sXoEVKcKKT879ZN0gS4wKKg+n4O2jXCkZGZ7JjVFPWRHjhoCKKw8ImZNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fGXAYr5WxOrcNrfxcJvbl6SmjKdXUH5KKQzWHZ2DVw=;
 b=bjf3iwTnZFAR0+Gfxim7oDvnM7NWWDHOWKKTPH0Fku71fnzodd5fZ/5q4L8z4JZwQtwN9N8cAIDzZGQfGCOuxw8fnCz0viZti5/6CYVqHx+blcjPfCJXKFf8grEgE0z+uvXYYLDY9sewlyr5Xw51ohXJ6qeoaIs+UGR9qIsErHo=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BY5PR21MB1441.namprd21.prod.outlook.com (2603:10b6:a03:21c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.7; Fri, 9 Jul
 2021 19:44:08 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::8135:6d63:d3fe:ba9d]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::8135:6d63:d3fe:ba9d%7]) with mapi id 15.20.4331.007; Fri, 9 Jul 2021
 19:44:08 +0000
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
Thread-Index: AQHXalTR5lVKFlOZkEmq8/y9Kgt/basp6bQAgAPHdaCAAJ8MgIACFAVQgAmV7gCAAR9SIA==
Date:   Fri, 9 Jul 2021 19:44:08 +0000
Message-ID: <BY5PR21MB15060921F762175FB4E85F26CE189@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB159375586D810EC5DCB66AF0D7039@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506ACF89447B492B0F7E066CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15939CFE85138C6B73E575F2D7009@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506C29FA7FB4588E3A2BB5ECE1F9@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB1593F080DF28E10FF6E3A529D7189@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB1593F080DF28E10FF6E3A529D7189@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=34b74f3b-f78a-4066-9c87-8e11622defa7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-28T14:56:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b4bedfe-6f6b-4981-f879-08d94311eb19
x-ms-traffictypediagnostic: BY5PR21MB1441:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BY5PR21MB1441DD65595F52F14C02B0C8CE189@BY5PR21MB1441.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9HFitfl72XLcmxn/A76oeml9oYoIQTAilkiGIecSCbcLxj7Yb1v3EQB2+WrpPVATiIRCqXBM3jgmMdnkaJpqQS2WlJAEE4mP2NfXf+Xj8H+D29oxuxTEuU8WHMxoVopz9FKEPOpzKa2HkrV4QimS3yEvf0DCc9eDkCGgPUf+sMuYkarOPsuqbIx19mHLbUGdeaM1kt67Y5Dx03KRKpmsv4VxUKpMSpIKZF6bhP4pNZxIAUAWEI98lPf38InOrhUDCWcG9mWpVs/lK9Yk3o9igqo7zgcAwhk8aBoLneX+fKoEDbXQSV0ZC9jD0D/F7tX14rsh3BI0ZCTKcezyp3Zu/PgO7nT52jHaF5iFo33luXxCMz2AKBWkU3rztd1Nj/YUS9e2fum80glqFL61ysNJxyKwteVEQ7nlSob6oKSYyJemad0XFxzevSUkkeWwJT52LuCvL8SfzS0INLSqg8IRfrONzJidtfAlp6lof8eL4SnvWBrLkBqceYUaGoSngRLXhdXtDH4bN4APzozakaL5FjXeHF8nJ2Mw16Wa95i+x8CmPUKsG41vZgFVy6VM2aEsWPS4MkPyBcJGUGowUEkstVqf0130c9PaXHy7kCPMUKSOurVz4F68O1PekukWEPznqkQtUReL2cz4xNAMYpgRFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(186003)(7416002)(54906003)(4326008)(71200400001)(55016002)(478600001)(7696005)(66946007)(110136005)(83380400001)(64756008)(316002)(66556008)(10290500003)(122000001)(26005)(8936002)(8676002)(82960400001)(86362001)(8990500004)(66476007)(38100700002)(2906002)(66446008)(52536014)(82950400001)(6506007)(76116006)(5660300002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2hQTCJ86J/afiiFGzEHyl3TWliVLtJ8hMeCCOTekiyItmYaPB6Oy4feDPKtM?=
 =?us-ascii?Q?vKlYeZf4xgJGpygcWXxrPhnoYMjfWm0Mz6+mfDCYrC7jnx+vNlw2yt47xpfG?=
 =?us-ascii?Q?4u7bVBv61Q7AbdTPzL/Jt9orQMka6rdMzCLAHsS58gIEfLNEKCOR9q/CmHsN?=
 =?us-ascii?Q?oE1/N3KvzdDniBPbc+ZecyON+tGZcExTUY4Js6mPToCjRGGy7N0bziiI7q4G?=
 =?us-ascii?Q?Bw1rspdn4LLhgubuP1UbwKtmPNypiMR0nw7LhRagaLhU3/xOt3hVhCjgFP/A?=
 =?us-ascii?Q?co9iC8K7Y/B1Jud2g3eyqET75J5OnmvvqjyNCo5T/qWGtO6ypk3C6+QapHwU?=
 =?us-ascii?Q?zhTQ3o9//1oabM7+/uJIK4LXPux/tcUi3TrMfHBco9yfW5NellpBY3lfGYfj?=
 =?us-ascii?Q?gS8Dlf1283MROXL1CVQJXu6uAYKS4cIs7sg/oUUigFlV1zECVp83ezkCXDpv?=
 =?us-ascii?Q?QKXltZD+YA/XtIt3qaJOOArVCecgyl5H1kQEAvVTN5LdVg5p4E9HwHfsI9Nm?=
 =?us-ascii?Q?T90io1nHjJxQyjWhQu2uEsco+foaDVoYJg2ad1xf8narMcq1Xq+Hb376rdWq?=
 =?us-ascii?Q?rQaB2LgXntlptpkORSkUa96AKzTzZKU4aHy9fzfuX3RUKsDCBdXQZojLJZW5?=
 =?us-ascii?Q?aGJHiQsUyF7SbP13l2utvv7df66LMoVBkofdDfn4w8tTkeMNtx9QYedNEgR1?=
 =?us-ascii?Q?Sv58UZwZ5BWZIfR9US8xABB8vsNljqr+xEoBHM/G5gykh/IJCFbn6+kNaeTR?=
 =?us-ascii?Q?0l4q0MQcbIWAuBaDvOuSZjr9/3zNcsSxsnfBC0uTISaf0PmR1NFk8rIq48lM?=
 =?us-ascii?Q?FvX6832/GqnS8Xw4tjDW/tFyfUWu3UaJ0ni+mw97S3ZhrpCDPHlc83JF3/+Z?=
 =?us-ascii?Q?fNB74TyH0rXD2AYHKN2B992d69Ns5SspFORBmHb2kvjWC1cldWgPlHSJOf1A?=
 =?us-ascii?Q?N8YOUrUCmsnNXhB5X+3y2anHSnrbErnlhMVUGkWBUClT8IIqn2EjAQ8VVE3U?=
 =?us-ascii?Q?jPUzEmVxCDboWr+h5UU6mX6Y+WAgoyzSq8vAwISYYxQ0Au8i4FudLRddKRVs?=
 =?us-ascii?Q?p4umiJhqamHamncajHV6bg14nBqWRCt158eoI6oiq0BHkN1jybkYxyU4BAV2?=
 =?us-ascii?Q?PpOERBk8j9+n27dAtDQDLjmOGNt9zfmjaYcN6/8/3hN/z0Wch5mgc2BQlEpv?=
 =?us-ascii?Q?MgqyXsr6DTj8mH9phDxTPorrvgd7DgZOvzY1qHH5nXUFtuQNqWqgStLF8pCW?=
 =?us-ascii?Q?z7byP9X1jyBUYZPsRfACJ0SJFSg9P/r/TEIOnl7cvIQJzCdp6E1pabo2QZBZ?=
 =?us-ascii?Q?hI0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4bedfe-6f6b-4981-f879-08d94311eb19
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 19:44:08.6234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yPKG4uvTpXNF+B2ol8BeYb1lxb1o29lxrxMAWgJpswde/OUEw6kg3J/c2pHVnC2D2+aIqrBRV9SmHGzeHuymfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1441
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
>=20
> From: Long Li <longli@microsoft.com> Sent: Friday, July 2, 2021 4:59 PM
> > > PM
> > >
> > > [snip]
> > >
> > > > > > +static void az_blob_remove_device(struct az_blob_device *dev) =
{
> > > > > > +	wait_event(dev->file_wait, list_empty(&dev->file_list));
> > > > > > +	misc_deregister(&az_blob_misc_device);
> > > > > > +#ifdef CONFIG_DEBUG_FS
> > > > > > +	debugfs_remove_recursive(az_blob_debugfs_root);
> > > > > > +#endif
> > > > > > +	/* At this point, we won't get any requests from user-mode
> > > > > > +*/ }
> > > > > > +
> > > > > > +static int az_blob_create_device(struct az_blob_device *dev) {
> > > > > > +	int rc;
> > > > > > +	struct dentry *d;
> > > > > > +
> > > > > > +	rc =3D misc_register(&az_blob_misc_device);
> > > > > > +	if (rc) {
> > > > > > +		az_blob_err("misc_register failed rc %d\n", rc);
> > > > > > +		return rc;
> > > > > > +	}
> > > > > > +
> > > > > > +#ifdef CONFIG_DEBUG_FS
> > > > > > +	az_blob_debugfs_root =3D debugfs_create_dir("az_blob",
> NULL);
> > > > > > +	if (!IS_ERR_OR_NULL(az_blob_debugfs_root)) {
> > > > > > +		d =3D debugfs_create_file("pending_requests", 0400,
> > > > > > +			az_blob_debugfs_root, NULL,
> > > > > > +			&az_blob_debugfs_fops);
> > > > > > +		if (IS_ERR_OR_NULL(d)) {
> > > > > > +			az_blob_warn("failed to create debugfs
> file\n");
> > > > > > +
> 	debugfs_remove_recursive(az_blob_debugfs_root);
> > > > > > +			az_blob_debugfs_root =3D NULL;
> > > > > > +		}
> > > > > > +	} else
> > > > > > +		az_blob_warn("failed to create debugfs root\n");
> #endif
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int az_blob_connect_to_vsp(struct hv_device *device,
> > > > > > +u32
> > > > > > +ring_size) {
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	spin_lock_init(&az_blob_dev.file_lock);
> > > > >
> > > > > I'd argue that the spin lock should not be re-initialized here.
> > > > > Here's the sequence where things go wrong:
> > > > >
> > > > > 1) The driver is unbound, so az_blob_remove() is called.
> > > > > 2) az_blob_remove() sets the "removing" flag to true, and calls
> > > > > az_blob_remove_device().
> > > > > 3) az_blob_remove_device() waits for the file_list to become empt=
y.
> > > > > 4) After the file_list becomes empty, but before
> > > > > misc_deregister() is called, a separate thread opens the device a=
gain.
> > > > > 5) In the separate thread, az_blob_fop_open() obtains the
> > > > > file_lock spin
> > > lock.
> > > > > 6) Before az_blob_fop_open() releases the spin lock,
> > > > > az_blob_remove_device() completes, along with az_blob_remove().
> > > > > 7) Then the device gets rebound, and az_blob_connect_to_vsp()
> > > > > gets called, all while az_blob_fop_open() still holds the spin
> > > > > lock.  So the spin lock get re- initialized while it is held.
> > > > >
> > > > > This is admittedly a far-fetched scenario, but stranger things
> > > > > have happened. :-)  The issue is that you are counting on the
> > > > > az_blob_dev structure to persist and have a valid file_lock,
> > > > > even while the device is unbound.  So any initialization should
> > > > > only happen in
> > > az_blob_drv_init().
> > > >
> > > > I'm not sure if az_blob_probe() and az_blob_remove() can be called
> > > > at the same time, as az_blob_remove_vmbus() is called the last in
> > > az_blob_remove().
> > > > Is it possible for vmbus asking the driver to probe a new channel
> > > > before the old channel is closed? I expect the vmbus provide
> > > > guarantee that those calls are made in sequence.
> > >
> > > In my scenario above, az_blob_remove_vmbus() and az_blob_remove()
> > > run to completion in Step #6, all while some other thread is still
> > > in the middle of an
> > > open() call and holding the file_lock spin lock.  Then in Step #7
> > > az_blob_probe() runs.  So az_blob_remove() and az_blob_probe()
> > > execute sequentially, not at the same time.
> > >
> > > Michael
> >
> > I think it's a valid scenario.  The return value of
> > devtmpfs_delete_node() is not checked in misc_deregister(). It decrease=
s
> the refcount on inodes but it's not guaranteed that someone else is still=
 using
> it (in the middle of opening a file).
> >
> > However, this works fine for "rmmod" that causes device to be removed.
> > Before file is opened the refcount on the module is increased so it can=
't be
> removed when file is being opened. The scenario you described can't
> happen.
> >
> > But during VMBUS rescind, it can happen. It's possible that the driver
> > is using the spinlock that has been re-initialized, when the next VMBUS
> offer on the same channel comes before all the attempting open file calls
> exit.
>=20
> I was thinking about the rescind scenario.  vmbus_onoffer_rescind() will =
run
> on the global workqueue.  If it eventually calls az_blob_remove() and the=
n
> az_blob_remove_device(), it will wait until the file_list is empty, which
> essentially means waiting until user space processes decide to close the
> instances they have open.  This seems like a problem that could block the
> global workqueue for a long time and
> thereby hang the kernel.   Is my reasoning valid?  If so, I haven't
> thought about what the solution might be.  It seems like we do need to wa=
it
> until any in-progress requests to Hyper-V are complete because Hyper-V ha=
s
> references to guest physical memory.  But waiting for all open instances =
to
> be closed seems to be problematic.

My tests showed that misc_deregister() caused all opened files to be releas=
ed if there are no pending I/O waiting in the driver.

If there are pending I/O, we must wait as the VSP owns the memory of the I/=
O. The correct VSP behavior is to return all the pending I/O along with res=
cind. This is the same to what storvsc does for rescind.

It looks to me waiting for opened files after the call to misc_deregister()=
, but before removing the vmbus channel is a safe approach.

If the VSP is behaving correctly, the rescind process should not block for =
too long. If we want to deal with a buggy VSP that takes forever to release=
 a resource, we want to create a work queue for rescind handling.=20

>=20
> Michael
>=20
> >
> > This is a very rare. I agree things happen that we should make sure the
> driver can handle this. I'll update the driver.
> >
> > Long
> >
> > >
> > > >
> > > > >
> > > > > > +	INIT_LIST_HEAD(&az_blob_dev.file_list);
> > > > > > +	init_waitqueue_head(&az_blob_dev.file_wait);
> > > > > > +
> > > > > > +	az_blob_dev.removing =3D false;
> > > > > > +
> > > > > > +	az_blob_dev.device =3D device;
> > > > > > +	device->channel->rqstor_size =3D device_queue_depth;
> > > > > > +
> > > > > > +	ret =3D vmbus_open(device->channel, ring_size, ring_size,
> NULL, 0,
> > > > > > +			az_blob_on_channel_callback, device-
> >channel);
> > > > > > +
> > > > > > +	if (ret) {
> > > > > > +		az_blob_err("failed to connect to VSP ret %d\n", ret);
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > > +	hv_set_drvdata(device, &az_blob_dev);
> > > > > > +
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +
> > > > > > +static void az_blob_remove_vmbus(struct hv_device *device) {
> > > > > > +	/* At this point, no VSC/VSP traffic is possible over vmbus *=
/
> > > > > > +	hv_set_drvdata(device, NULL);
> > > > > > +	vmbus_close(device->channel); }
> > > > > > +
> > > > > > +static int az_blob_probe(struct hv_device *device,
> > > > > > +			const struct hv_vmbus_device_id *dev_id) {
> > > > > > +	int rc;
> > > > > > +
> > > > > > +	az_blob_dbg("probing device\n");
> > > > > > +
> > > > > > +	rc =3D az_blob_connect_to_vsp(device,
> az_blob_ringbuffer_size);
> > > > > > +	if (rc) {
> > > > > > +		az_blob_err("error connecting to VSP rc %d\n", rc);
> > > > > > +		return rc;
> > > > > > +	}
> > > > > > +
> > > > > > +	// create user-mode client library facing device
> > > > > > +	rc =3D az_blob_create_device(&az_blob_dev);
> > > > > > +	if (rc) {
> > > > > > +		az_blob_remove_vmbus(device);
> > > > > > +		return rc;
> > > > > > +	}
> > > > > > +
> > > > > > +	az_blob_dbg("successfully probed device\n");
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int az_blob_remove(struct hv_device *dev) {
> > > > > > +	struct az_blob_device *device =3D hv_get_drvdata(dev);
> > > > > > +	unsigned long flags;
> > > > > > +
> > > > > > +	spin_lock_irqsave(&device->file_lock, flags);
> > > > > > +	device->removing =3D true;
> > > > > > +	spin_unlock_irqrestore(&device->file_lock, flags);
> > > > > > +
> > > > > > +	az_blob_remove_device(device);
> > > > > > +	az_blob_remove_vmbus(dev);
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static struct hv_driver az_blob_drv =3D {
> > > > > > +	.name =3D KBUILD_MODNAME,
> > > > > > +	.id_table =3D id_table,
> > > > > > +	.probe =3D az_blob_probe,
> > > > > > +	.remove =3D az_blob_remove,
> > > > > > +	.driver =3D {
> > > > > > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > > > > > +	},
> > > > > > +};
> > > > > > +
> > > > > > +static int __init az_blob_drv_init(void) {
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	ret =3D vmbus_driver_register(&az_blob_drv);
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +
> > > > > > +static void __exit az_blob_drv_exit(void) {
> > > > > > +	vmbus_driver_unregister(&az_blob_drv);
> > > > > > +}
