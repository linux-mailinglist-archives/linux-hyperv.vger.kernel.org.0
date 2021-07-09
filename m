Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033BE3C1D41
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 04:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhGICL6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Jul 2021 22:11:58 -0400
Received: from mail-dm6nam12on2132.outbound.protection.outlook.com ([40.107.243.132]:8416
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229875AbhGICL6 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Jul 2021 22:11:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAbrIR9FyM+CPOHV3K/GdHklr1bRcihT0OuqeWQg2dw5FVY4PX7SiKbtzX9ynaV6jgaIq3x+M5wR9eB3R2ubDzcRNQkyhonHMxNjqY855P59Yxl8JLwLrocPmY5WfMuu5k1gfex+h54AhHfKb6bD6gjZaaXB+oCKdgXNHt/+lH/kFvXBxxdz/OplAqWMmR/vXPs9HTmh9GfUr8c+qEkElaUFOVjH4eWiXOCCakOljdAuT2bGB4TmUJJjAjVbHYllTwcvse9Pn/ztPmaSJyixTC9l/jatI3m1c6c3vg8go7iovzAWRPKCX66GqrBKR+qI6YcuX4GOKDj6TJF/B1RjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UKnsXnKl9ncO9DH3gUPVXVXqjlLIcRw8n40jj2ELJA=;
 b=khwaY9NS8qLsQel0nXFggseLX/Esu6tG8KLzx7gD9RLZY/D1dL8pUtD7BHjAVCOunQu617NAthwCK+JIBgJ9XtbtbrGyEs3CNfRixqSshxCwfj+XmfTGPY4uwuWs3rDWzkHX7EdGwstRmZFUtaehpngGUUZtPc/OBDwvSlukXpA8HFbJtep25WtGoycwOOANTg633Tv6VZ7TPh9u9Cm+18Ca9oUzGHgWBZB58k/7j4uiBsq3J4KfisOfyJ8sGkOqAa2BSMX0jxEhoMYZByIwW03+OJ+3IKbQDkrgMQOHOSwIE7o6dvO/oEJPWIUE38ppFwrYDUY7H3hx0uahNFLTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UKnsXnKl9ncO9DH3gUPVXVXqjlLIcRw8n40jj2ELJA=;
 b=HZuCbWhWz8BDmv0e7sBHW+ZwbhPYicBLcg9REIH9+w8q3rnxB518iE21OGARtQXZFg15/Ps3KZXb8oamJcqeB1prggKM58CkbPvVVNeXfNkUsP/8Ga0lG1+1rpXoj+aWzfyESZowIdZIClJL6Pz3cnyeswIpNiZizYoZT4oV0wI=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by CO1PR21MB1315.namprd21.prod.outlook.com (2603:10b6:303:152::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.7; Fri, 9 Jul
 2021 02:09:12 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19%7]) with mapi id 15.20.4331.009; Fri, 9 Jul 2021
 02:09:12 +0000
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
Thread-Index: AQHXalTRwSwb8zgU/UyKv3LljLGzrasphsOQgAQvmICAAJcUUIACGm+AgAmQCRA=
Date:   Fri, 9 Jul 2021 02:09:12 +0000
Message-ID: <MWHPR21MB1593F080DF28E10FF6E3A529D7189@MWHPR21MB1593.namprd21.prod.outlook.com>
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
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c7670c8-4b73-468f-ae26-08d9427e8b76
x-ms-traffictypediagnostic: CO1PR21MB1315:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CO1PR21MB1315C00754283278803A40CFD7189@CO1PR21MB1315.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u6HIXUpURz09Eq+S1+8Aivgdk7eGQXraHTR8MuC5lRrDKzmKTFeDuG6xrKNHjNMzqbIbLGdCpYIwa6t/wzHM/chYakSym0Q1Aysmpd2obCfccRrCnWUUIwyuZa/DnvjEzec6CAHi14pEn4DyN9yrphWtBv1a/44VI31g/Klzamr2wskjURIoQzlFA9if3awSowEp0DlqtyRAJ+DIFjB4Ai+rxKyJIsKFtP9SXrHQkmkU6Q5Ma+8ClCIMpprYhIsyMgGpBrvMcCFH0a9dMSGUC6N+/RtBka0DxcXy04QyCkNWwauE1dy06ZtlFdvgV1TOxtR7++HwmYVGZYmk1/uNVV3E2t+FqPXLZrAtFndTYI3VEvNOpK4YSrRbfewWNIo5z9U/uRn9ddkmZbH+XMKpUuPuoN+DMDJTalU30/rnX32+0cbiYIkzvtuyYl71BGv1qkVfd9N5w1wZISCeXlbASk12tfIkyDeITlsLLX8tTOaZ1UCZtb42PWbc8XISDxtoRM9YGoY3Ru52OQPla9ACAMs850PE2/TVV6U5YfPEMPcSeajnvwVaWq+zWCcdar8U2KzsV2yLM2+fBQeNnk4P9nWBUxqAndiQr+/SA1WWhW3rpMBY8dBTC02Bmfy8VSPBekBnAmvmVz6jXtZ8uan72A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(186003)(10290500003)(110136005)(54906003)(7696005)(9686003)(6506007)(55016002)(26005)(82950400001)(66946007)(76116006)(66476007)(66446008)(2906002)(64756008)(82960400001)(316002)(4326008)(66556008)(5660300002)(33656002)(83380400001)(8990500004)(8936002)(86362001)(8676002)(38100700002)(7416002)(71200400001)(122000001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HmmG/Z1wJDYHyUWmEqeV2+bCOEmNZznqmRCP774BWZ6O/uhSKpBwm3YSxcsM?=
 =?us-ascii?Q?GJg2XA0bAuPdxt1wp7Yi7K/Q9S3MxaPNW2QNtg8hoJBAo9D/Nc47SXNv09Bt?=
 =?us-ascii?Q?VIJSzSyjDKNssduFiq2NNWfn+y0dYvdZcaMgW2NWbgjYzbN5+qATOCZJ18+5?=
 =?us-ascii?Q?6HnUz5TuCeeVMgRYiahAt0bJqgLvv5FFnH+/TzS7pleJM0DmGZcnodAboNFW?=
 =?us-ascii?Q?WjpyGQQQJ7eUtp0LuxqlR/SkLWH+gk+YQ52wKjWAu33QwmgWXLKkKyNshKnV?=
 =?us-ascii?Q?LkTL3W4xsXvf0sd09HHOcPkBhvDmvvXGhGPpE/9kVndWOad5tf2xjiMsxp6s?=
 =?us-ascii?Q?A2aVuIDhaluvuKaJFS6/xfVDQ3qZA8jhHNCcDg/x6wnsvFVxSA9g++9E/OHl?=
 =?us-ascii?Q?gIy/pC1sF0T06r7NteQsyVrbdxTLf9mHhIqDI2IbbSFX+DDw3ypIPCHSmrRo?=
 =?us-ascii?Q?VAFjpgLyH1iqFa93NSIDEBRALt9pJqJUfBSaV1YPVtfaqLPwh63QJQ68b6rz?=
 =?us-ascii?Q?hnV3TaYg4YA6334bT6WAMjtrvf9Wro4bWI4luWJbMOmODoF1IejBD987mdJN?=
 =?us-ascii?Q?PDHHZkrfCep4q5wDFA92pHS2+vhZsb/a5J/U00d0VnABksxllyqNl/T2tKIe?=
 =?us-ascii?Q?8h+pQxrhZyyCOGOTu3PgyoPBEjVBrKQZeLgdm5kOlnmOSbqDcGJowqRsJZ9k?=
 =?us-ascii?Q?Ktnkbfd24oJS7+qFibsCwUFIuE6zv5gQvayro4TsTIA7qW+WCRbcZ3tREpK7?=
 =?us-ascii?Q?wCx+R7FGB/MW9QKCIV1pi1WfCk4GPqutYucJIZXFiecCY0Gfv5YTlxCe7NkQ?=
 =?us-ascii?Q?PZrHMSHTbYNjNcvRKE+LQnawDNlkzhJDt0bZumUu/BK+JIGI9dquSkqSW5lC?=
 =?us-ascii?Q?lkRG/UcbsE61f0Ly126ha4NN8o2S0DYGEjxJoZW3SmPav6k6TrMYZSL483hO?=
 =?us-ascii?Q?k8g7tcRHKAAcfliWdllLObMqlpneMznfbGR7VjZRpdDED3b02xzUO/A2WzrD?=
 =?us-ascii?Q?P5hIfgjdizEjGL6aKsu/ufCe89CN37gBGtRZxn3vgzBjAqlGsuppPuGNP8Vp?=
 =?us-ascii?Q?eQ71swtYRkQXNTXKhBG33CIF333wt1FxOu46WqniOrL0NDkwqauRKiS3v7Gg?=
 =?us-ascii?Q?Ks2ahgQqySGoC3v0mxj3J/MMnbi/MGD1Y97vNbh9VTduiGVdq0jWFwiSx4yz?=
 =?us-ascii?Q?uqIwEMzh8EOCdSCU11AAUypeymS60Ww1dS2OhIaQBxQVQvnnuTn3LIP/5c/C?=
 =?us-ascii?Q?LavSRBa1Nj9d4jsPDwQXJmXsMS8kDKnlaTphopWL9UC1vkWMgKdP9070mDP4?=
 =?us-ascii?Q?mU2V1EKxDN2uTpfbmjZqqbXb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7670c8-4b73-468f-ae26-08d9427e8b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 02:09:12.0400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfnQwwsEUaJxLMVcINngPw5dHzDyfsn7yKFgvupLT9jAegAgr0PWFkBBSj6bNZzC0Hu8Uw/gm2C3ORv9lKatDi7vYPU2w90U+oQclSGsEBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1315
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com> Sent: Friday, July 2, 2021 4:59 PM
> > PM
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
) is not checked in misc_deregister(). It decreases
> the refcount on inodes but it's not guaranteed that someone else is still=
 using it (in the middle of opening a file).
>=20
> However, this works fine for "rmmod" that causes device to be removed. Be=
fore file is opened the refcount on the module
> is increased so it can't be removed when file is being opened. The scenar=
io you described can't happen.
>=20
> But during VMBUS rescind, it can happen. It's possible that the driver is=
 using the spinlock that has been re-initialized, when
> the next VMBUS offer on the same channel comes before all the attempting =
open file calls exit.

I was thinking about the rescind scenario.  vmbus_onoffer_rescind()
will run on the global workqueue.  If it eventually calls az_blob_remove()
and then az_blob_remove_device(), it will wait until the file_list is
empty, which essentially means waiting until user space processes
decide to close the instances they have open.  This seems like a
problem that could block the global workqueue for a long time and
thereby hang the kernel.   Is my reasoning valid?  If so, I haven't
thought about what the solution might be.  It seems like we do need
to wait until any in-progress requests to Hyper-V are complete because
Hyper-V has references to guest physical memory.  But waiting for
all open instances to be closed seems to be problematic.

Michael

>=20
> This is a very rare. I agree things happen that we should make sure the d=
river can handle this. I'll update the driver.
>=20
> Long
>=20
> >
> > >
> > > >
> > > > > +	INIT_LIST_HEAD(&az_blob_dev.file_list);
> > > > > +	init_waitqueue_head(&az_blob_dev.file_wait);
> > > > > +
> > > > > +	az_blob_dev.removing =3D false;
> > > > > +
> > > > > +	az_blob_dev.device =3D device;
> > > > > +	device->channel->rqstor_size =3D device_queue_depth;
> > > > > +
> > > > > +	ret =3D vmbus_open(device->channel, ring_size, ring_size, NULL,=
 0,
> > > > > +			az_blob_on_channel_callback, device->channel);
> > > > > +
> > > > > +	if (ret) {
> > > > > +		az_blob_err("failed to connect to VSP ret %d\n", ret);
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	hv_set_drvdata(device, &az_blob_dev);
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +static void az_blob_remove_vmbus(struct hv_device *device) {
> > > > > +	/* At this point, no VSC/VSP traffic is possible over vmbus */
> > > > > +	hv_set_drvdata(device, NULL);
> > > > > +	vmbus_close(device->channel);
> > > > > +}
> > > > > +
> > > > > +static int az_blob_probe(struct hv_device *device,
> > > > > +			const struct hv_vmbus_device_id *dev_id) {
> > > > > +	int rc;
> > > > > +
> > > > > +	az_blob_dbg("probing device\n");
> > > > > +
> > > > > +	rc =3D az_blob_connect_to_vsp(device, az_blob_ringbuffer_size);
> > > > > +	if (rc) {
> > > > > +		az_blob_err("error connecting to VSP rc %d\n", rc);
> > > > > +		return rc;
> > > > > +	}
> > > > > +
> > > > > +	// create user-mode client library facing device
> > > > > +	rc =3D az_blob_create_device(&az_blob_dev);
> > > > > +	if (rc) {
> > > > > +		az_blob_remove_vmbus(device);
> > > > > +		return rc;
> > > > > +	}
> > > > > +
> > > > > +	az_blob_dbg("successfully probed device\n");
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int az_blob_remove(struct hv_device *dev) {
> > > > > +	struct az_blob_device *device =3D hv_get_drvdata(dev);
> > > > > +	unsigned long flags;
> > > > > +
> > > > > +	spin_lock_irqsave(&device->file_lock, flags);
> > > > > +	device->removing =3D true;
> > > > > +	spin_unlock_irqrestore(&device->file_lock, flags);
> > > > > +
> > > > > +	az_blob_remove_device(device);
> > > > > +	az_blob_remove_vmbus(dev);
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static struct hv_driver az_blob_drv =3D {
> > > > > +	.name =3D KBUILD_MODNAME,
> > > > > +	.id_table =3D id_table,
> > > > > +	.probe =3D az_blob_probe,
> > > > > +	.remove =3D az_blob_remove,
> > > > > +	.driver =3D {
> > > > > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > > > > +	},
> > > > > +};
> > > > > +
> > > > > +static int __init az_blob_drv_init(void) {
> > > > > +	int ret;
> > > > > +
> > > > > +	ret =3D vmbus_driver_register(&az_blob_drv);
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +static void __exit az_blob_drv_exit(void) {
> > > > > +	vmbus_driver_unregister(&az_blob_drv);
> > > > > +}
