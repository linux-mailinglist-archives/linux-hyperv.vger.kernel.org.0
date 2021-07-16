Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD653CBE56
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 23:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhGPVWl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Jul 2021 17:22:41 -0400
Received: from mail-dm3nam07on2124.outbound.protection.outlook.com ([40.107.95.124]:58048
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230430AbhGPVWk (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Jul 2021 17:22:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VE/ezcmZowosm2qNIeWNtOwjn2f4sParyJMTQKlrmtLAyU4KuERmYB0c/bRtbI78pQlCsEtYWcAzBqkFh7xeK90mLJzzkV+PEtWtzw9c0Cx+Stu9qz0ylcBlzqL+LS0DBxTZH8QD+KXJGJb7iC8DGfUFz5AwpDpugqV0GtROX6SlMiWmY3fNg0uficuCrjcYExeBLH2jT57tvEzS6LNM2MAsxwBL776HeaJ7Llw2ZA6ep4EWThgvQRMNsHpZO9oGi/ohVPE+TsvlsN2k1VpwLdDtq6XvKdh9KmmVo5iPvivxzZx6Upozd9xmqa/YclpLoq5WkxaF7hWjSlMoirsOfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFLqPV2YRbw/nsZUZnDqHGFpbTlNIgtFgUn8NFwvXas=;
 b=ITJe2qORe/rfoBCLxD82xjS8O3XWidDi9d/KaddSV5tWBtDG6vvhSDpjww3KFYMl260nwUQsWsN/QhXzkPNMGZsDlhlwdhLJFc8C5nim9s3XXZDdsm/IijPyU43v2OXG+hmckgGsmQI7/fHe9I5L2APXU+b9GpmcJz/4gl9bqG+GX/Qu2mNKkvlCxJ6w+8YlCFXGdm1PpKRDKKjQUgXVRd9BCVRx5eIL4s372+C9XGjNnJmqWiaJ3pJ7frSxKejfuMHXkoyRnTpUNHhG132wst5Rh3W3Cq9TTlecUklW7kCgHajYBQswA37yxS7ivd3jOBVeQPDp3v+DyfX8+WQWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFLqPV2YRbw/nsZUZnDqHGFpbTlNIgtFgUn8NFwvXas=;
 b=DCIirTy6jpQmizeL0NM8tiJCTDsU4OYGtYuVFjYbgQRjEQfiQGpxlZQfoAvWFXOZQ2U9buNUck5BFMdSht46FYffASE20ALzm6LPo0Wgc5ojbgbAYZcm93PikQ5we8w81eRIVDVuQOgTLDvkWxWKmPGvQCN9Sx2Jl+mAcOhWAOY=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BY5PR21MB1507.namprd21.prod.outlook.com (2603:10b6:a03:231::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.3; Fri, 16 Jul
 2021 21:19:38 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::ec21:a9f8:7e74:5e1b]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::ec21:a9f8:7e74:5e1b%8]) with mapi id 15.20.4352.011; Fri, 16 Jul 2021
 21:19:38 +0000
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
Subject: RE: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXeFpU0avVPr6X1EyU3ZDtwXfEcKtFxYAAgAAlVyCAADFvAIAAAy5Q
Date:   Fri, 16 Jul 2021 21:19:37 +0000
Message-ID: <BY5PR21MB1506A8B3AA10BDC0CC87A399CE119@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
 <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15937DF3FB30DDA65EF58EE1D7119@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB15062B99587CDDCC126DDD87CE119@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB159322A1E3F0C50362643D34D7119@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB159322A1E3F0C50362643D34D7119@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=637f0e51-bd6a-4fba-b81c-288709d0b198;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-16T14:43:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77fc3204-de36-462c-f404-08d9489f6af1
x-ms-traffictypediagnostic: BY5PR21MB1507:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BY5PR21MB150712F9659EE33DB1304375CE119@BY5PR21MB1507.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YKp4E2EDLR8iNHCTkORwqTDYv2yFT8jKsrVd+W+SBAbcPmnhNq6tKZTi4pTI++nkN+oJcSWkDr0c0IDKHP7gC08P33pswL6+sZjG8leJmI4yVRP1/xmx7ujvVIT1sAlYe3XLUFyWSG7S1uSRDspgeLDqewIM+yg5uQa1Uz1Z4y1QOq7eRavdCVlkk6TrGGHTg7eFn36eAnMk3BbXOyP6cgdts1QSMNWvpN5uSIhdytm/pwFP9qXss+p3MbK6k+eRPMjPA4dLvzueNk8UkwntL+o0VCF3KDfTmIl2luNP5QMFBQklAc/rQ/aZShitwh3tHbBok+OaglBmdZ7I+Eg0O93U6IzTH7994eumbKZ6sgb81iBVeAX2PO58Os1Q+eatDPW+PRWEdZEj0soVuR0M/Rb1wayTfQjYLvGTWiYP95vn5aSGSwqfZb4FJiKN1iWZZBNHFyqSnb6vdgLsmLL2E5FntiSG5E8SS13yU3jvYathGwfyw2mIRMynfQiIF6GxdepoVOdbLscGO0S6ottnlv6FuvHlUdbrrY52Km4cljw0HDp1qkqK7ztMOhRYr0B/IziOxwTPvVmHfTMLbudeCqN609Si/NGKpqSk6mhBN7mL67IHFg5lNQXJu5HdgUvPlRHtMtm9m1N7sN9h+GGmYjAb8i96MiOueXVLY+2MWIPKu595mVUpE+Dedlr7aUflTOTv8Y6KKqztXjY2DcbXEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(508600001)(71200400001)(7416002)(33656002)(9686003)(10290500003)(52536014)(8990500004)(66446008)(66476007)(86362001)(83380400001)(8936002)(5660300002)(186003)(110136005)(54906003)(30864003)(66556008)(64756008)(2906002)(6506007)(82960400001)(38100700002)(66946007)(8676002)(76116006)(55016002)(316002)(7696005)(4326008)(122000001)(82950400001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qKYMOgs/d1At9+lYZZ550Fctq0TTSetdvO1V0tfnhdDYzXsEEZ4OD31jLi9f?=
 =?us-ascii?Q?wBeGePEj5astR5USGf5vg/+OBLDat4VwD3TGWhVTDYAmLBxUTylSS4jru7Jk?=
 =?us-ascii?Q?qn3RNggDwsSSsTAOqvxJDtq0RCrDQj9b9pr0FYu56yh6q1D0eeBg3KKbvuAb?=
 =?us-ascii?Q?vq57b2vDv+Rmq0zeV85G4z5fjzUdmo6xsAMZXv2sZFJdPPQQz3K90GPOQwpq?=
 =?us-ascii?Q?Wc3E11vmFPe6ib8FR8XJTfKzbSQJVkRaiQvle/dJBrlzKDY99n9qPIOBaMSF?=
 =?us-ascii?Q?0NQ8QKNiFKBz8KkIpgnMnzJJ8jCu3KPKxu4cILB+kcWRVrBfqTaEyZCfzR40?=
 =?us-ascii?Q?a4IoJlMhEjD25l62n1EVt4X3fTx4DTwdhZJ27I45vikMRNufF/xRCXyyIJPG?=
 =?us-ascii?Q?KXmRLwp4i7dUK6UkUBAklAJmO2uBZqr9oB6zZZxd53papri2OaBmHCr34NO8?=
 =?us-ascii?Q?pUidxp+Bk1KMdG8J6R441aSJ7IjZo7Hkf++N/Tav/6vbwWSIx13SEL4+bKH6?=
 =?us-ascii?Q?d2QDB3cHaun3YH6qsPGPk0rBezeGOSLjkQcx8pNbOypIlgvPIg2IEeXViO/r?=
 =?us-ascii?Q?yr5/erb1Ru/QqpMNLzofet1x5BIQp2qZlNY4KGYv465VnlM390kLUa5lGERG?=
 =?us-ascii?Q?iTamCOkgR1OC583lUHNUQIwcbqTft+3iVPM+NfxQG9wwY3tF2JZsNTFYP8My?=
 =?us-ascii?Q?3C9EwnZwGWbJr9MlUvFsopscDuvKcFXE47VtOPl0KxGF//PVLJo+8pEThL0Z?=
 =?us-ascii?Q?2QcPSMwN5oJZ61OsMphtSUG4JJDF1YhTH08TxfBawy+FVxcrvw8LszajKsk4?=
 =?us-ascii?Q?84CsZM1IbaBYaLdlue6Du+pwJDxVz7pQpePc03g8PMlAdbzW1AEYbgp0UfZD?=
 =?us-ascii?Q?zsu/WaOv1X6MhEmUk8DU3OW7Q6KiYGbSiegetB+xY6MydAFyAao6kBdu8eOv?=
 =?us-ascii?Q?LV117oJT72wX45WvysmdjRqOGt9zHbkpwGDTdf02OqpPkpQOKNywadZeH5OG?=
 =?us-ascii?Q?HdLTU/YvDQaFOcN+oqIqJTOt21EN5Cxsrnx9skzkN6iHxWux1Ge/amPsI5Dm?=
 =?us-ascii?Q?nPwslGPDNNNEwY7BR3HZWQe6kn9UMoylBmuNv515qyPig4vIcqEcMZxY3+Yy?=
 =?us-ascii?Q?tKI+4zgxHbVPn7GW4HZjHJJpqgnJ99M9vb/tKk3len+GqZoCDkbGyHgvyXDr?=
 =?us-ascii?Q?V6glkrUNpoS9fk5dFImvduGRtshFEEApXi1bdhZ9Up0hih8o9WqmE/Xr0HPd?=
 =?us-ascii?Q?0XCQpmSlSICkTQ4HClG5xmgl/XjpY2TsKBycOndD26bPj4olh3ol1r9TI0rL?=
 =?us-ascii?Q?WFc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fc3204-de36-462c-f404-08d9489f6af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 21:19:37.9413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aKLhmgPsLVxXGmp4honsTha4aIAL2O+QizRTwbqSMpGF02DYvbbonKUwgd/b8+C0kzZKf2xsvZx250K5tXEZqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1507
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
>=20
> From: Long Li <longli@microsoft.com> Sent: Friday, July 16, 2021 12:27 PM
>=20
> [snip]
>=20
> > > > +
> > > > +static int az_blob_connect_to_vsp(struct hv_device *device, u32
> > > > +ring_size) {
> > > > +	int ret;
> > > > +
> > > > +	spin_lock_init(&az_blob_dev.file_lock);
> > > > +	INIT_LIST_HEAD(&az_blob_dev.file_list);
> > > > +	init_waitqueue_head(&az_blob_dev.file_wait);
> > > > +
> > > > +	az_blob_dev.device =3D device;
> > > > +	device->channel->rqstor_size =3D AZ_BLOB_QUEUE_DEPTH;
> > > > +
> > > > +	ret =3D vmbus_open(device->channel, ring_size, ring_size, NULL, 0=
,
> > > > +			 az_blob_on_channel_callback, device->channel);
> > > > +
> > > > +	if (ret)
> > > > +		return ret;
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
> > > > +			 const struct hv_vmbus_device_id *dev_id) {
> > > > +	int ret;
> > > > +
> > > > +	ret =3D az_blob_connect_to_vsp(device, AZ_BLOB_RING_SIZE);
> > > > +	if (ret) {
> > > > +		az_blob_err("error connecting to VSP ret=3D%d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	// create user-mode client library facing device
> > > > +	ret =3D az_blob_create_device(&az_blob_dev);
> > > > +	if (ret) {
> > > > +		az_blob_err("failed to create device ret=3D%d\n", ret);
> > > > +		az_blob_remove_vmbus(device);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	az_blob_dev.removing =3D false;
> > >
> > > This line seems misplaced.  As soon as az_blob_create_device()
> > > returns, some other thread could find the device and open it.  You
> > > don't want the
> > > az_blob_fop_open() function to find the "removing"
> > > flag set to true.  So I think this line should go *before* the call
> > > to az_blob_create_device().
> > >
> > > > +	az_blob_info("successfully probed device\n");
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int az_blob_remove(struct hv_device *dev) {
> > > > +	az_blob_dev.removing =3D true;
> > > > +	/*
> > > > +	 * RCU lock guarantees that any future calls to az_blob_fop_open(=
)
> > > > +	 * can not use device resources while the inode reference of
> > > > +	 * /dev/azure_blob is being held for that open, and device file i=
s
> > > > +	 * being removed from /dev.
> > > > +	 */
> > > > +	synchronize_rcu();
> > >
> > > I don't think this works as you have described.  While it will
> > > ensure that any in-progress RCU read-side critical sections have
> > > completed (i.e., in
> > > az_blob_fop_open() ), it does not prevent new read-side critical
> > > sections from being started.  So as soon as synchronize_rcu() is
> > > finished, another thread could find and open the device, and be
> > > executing in az_blob_fop_open().
> > >
> > > But it's not clear to me that this (and the rcu_read_locks in
> > > az_blob_fop_open) are really needed anyway.  If
> > > az_blob_remove_device() is called while one or more threads have it
> > > open, I think that's OK.  Or is there a scenario that I'm missing?
> >
> > I was trying to address your comment earlier. Here were your comments (=
1
> - 7):
> >
> > 1) The driver is unbound, so az_blob_remove() is called.
> > 2) az_blob_remove() sets the "removing" flag to true, and calls
> az_blob_remove_device().
> > 3) az_blob_remove_device() waits for the file_list to become empty.
> > 4) After the file_list becomes empty, but before misc_deregister() is c=
alled,
> a separate thread opens the device again.
> > 5) In the separate thread, az_blob_fop_open() obtains the file_lock spi=
n
> lock.
> > 6) Before az_blob_fop_open() releases the spin lock, az
> > block_remove_device() completes, along with az_blob_remove().
> > 7) Then the device gets rebound, and az_blob_connect_to_vsp() gets
> > called, all while az_blob_fop_open() still holds the spin lock.  So the=
 spin
> lock get re-initialized while it is held.
> >
> > Between step 4 and step 5, I don't see any guarantee that
> > az_blob_fop_open() can't run concurrently on another CPU after
> > misc_deregister() finishes. misc_deregister() calls
> > devtmpfs_delete_node() to remove the device file from /dev/*, but it
> doesn't check the return value, so the inode reference number can be non-
> zero after it returns, somebody may still try to open it.
>=20
> I'm no expert here, but once misc_deregister() finishes, I would expect t=
hat
> any attempt to open the device with the assigned major:minor number will
> fail.  However, existing opens may still be active.   So another thread c=
ould
> still
> have it open, but no new opens can be done.  As coded in this version of
> your patch, az_blob_remove() waits until all those existing opens have be=
en
> closed,
> so everything is clean once the wait is complete.   Of course, while wait=
ing
> here, the threads with the open fd could try to start another operation
> against the VSP, but the "removing" flag will prevent that.  So the only =
access
> these threads will have is to the singleton az_blob_dev instance and the =
list
> of open files.
>=20
> But as noted previously, waiting here for the opens to be closed is
> problematic because the wait could be arbitrarily long.  And there's
> messiness if the device gets re-added later, because there's no distincti=
on
> between the old instantiation that a thread might still have open vs. the=
 new
> instantiation that you want to initialize fresh.  That's where creating a=
 new
> dynamic instance will solve any problems.

As I said in my previous email, I'm moving to dynamically allocated objects=
 to fix all of these.

>=20
> > This check guarantees that the code can't reference any driver's intern=
al
> data structures.
> > az_blob_dev.removing is set so this code can't be entered. Resetting
> > it after az_blob_create_device() is also for this purpose.
> >
> > >
> > > > +
> > > > +	az_blob_info("removing device\n");
> > > > +	az_blob_remove_device();
> > > > +
> > > > +	/*
> > > > +	 * At this point, it's not possible to open more files.
> > > > +	 * Wait for all the opened files to be released.
> > > > +	 */
> > > > +	wait_event(az_blob_dev.file_wait,
> > > > +list_empty(&az_blob_dev.file_list));
> > >
> > > As mentioned in my most recent comments on the previous version of
> > > the code, I'm concerned about waiting for all open files to be
> > > released in the case of a VMbus rescind.  We definitely have to wait
> > > for all VSP operations to complete, but that's different from
> > > waiting for the files to be closed.  The former depends on Hyper-V
> > > being well-behaved and will presumably happen quickly in the case of
> > > a rescind.  But the latter depends entirely on user space code that
> > > is out of the kernel's control.  The user space process could hang
> > > around for hours or days with the file still open, which would block =
this
> function from completing, and hence block the global work queue.
> > >
> > > Thinking about this, the core issue may be that having a single
> > > static instance of az_blob_device is problematic if we allow the
> > > device to be removed (either explicitly with an unbind, or
> > > implicitly with a VMbus
> > > rescind) and then re-added.  Perhaps what needs to happen is that
> > > the removed device is allowed to continue to exist as long as user
> > > space processes have an open file handle, but they can't perform any
> > > operations because the "removing" flag is set (and stays set).
> > > If the device is re-added, then a new instance of az_blob_device
> > > should be created, and whether or not the old instance is still
> > > hanging around is irrelevant.
> >
> > I agree dynamic device objects is the way to go. Will implement this.
> >
> > >
> > > > +
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
> > > > +	return vmbus_driver_register(&az_blob_drv);
> > > > +}
> > > > +
> > > > +static void __exit az_blob_drv_exit(void) {
> > > > +	vmbus_driver_unregister(&az_blob_drv);
> > > > +}
> > > > +
> > > > +MODULE_LICENSE("Dual BSD/GPL");
> > > > +MODULE_DESCRIPTION("Microsoft Azure Blob driver");
> > > > +module_init(az_blob_drv_init); module_exit(az_blob_drv_exit);
> > > > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > > > index 705e95d..3095611 100644
> > > > --- a/drivers/hv/channel_mgmt.c
> > > > +++ b/drivers/hv/channel_mgmt.c
> > > > @@ -154,6 +154,13 @@
> > > >  	  .allowed_in_isolated =3D false,
> > > >  	},
> > > >
> > > > +	/* Azure Blob */
> > > > +	{ .dev_type =3D HV_AZURE_BLOB,
> > > > +	  HV_AZURE_BLOB_GUID,
> > > > +	  .perf_device =3D false,
> > > > +	  .allowed_in_isolated =3D false,
> > > > +	},
> > > > +
> > > >  	/* Unknown GUID */
> > > >  	{ .dev_type =3D HV_UNKNOWN,
> > > >  	  .perf_device =3D false,
> > > > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h index
> > > > d1e59db..ac31362 100644
> > > > --- a/include/linux/hyperv.h
> > > > +++ b/include/linux/hyperv.h
> > > > @@ -772,6 +772,7 @@ enum vmbus_device_type {
> > > >  	HV_FCOPY,
> > > >  	HV_BACKUP,
> > > >  	HV_DM,
> > > > +	HV_AZURE_BLOB,
> > > >  	HV_UNKNOWN,
> > > >  };
> > > >
> > > > @@ -1350,6 +1351,14 @@ int vmbus_allocate_mmio(struct resource
> > > **new, struct hv_device *device_obj,
> > > >  			  0x72, 0xe2, 0xff, 0xb1, 0xdc, 0x7f)
> > > >
> > > >  /*
> > > > + * Azure Blob GUID
> > > > + * {0590b792-db64-45cc-81db-b8d70c577c9e}
> > > > + */
> > > > +#define HV_AZURE_BLOB_GUID \
> > > > +	.guid =3D GUID_INIT(0x0590b792, 0xdb64, 0x45cc, 0x81, 0xdb, \
> > > > +			  0xb8, 0xd7, 0x0c, 0x57, 0x7c, 0x9e)
> > > > +
> > > > +/*
> > > >   * Shutdown GUID
> > > >   * {0e0b6031-5213-4934-818b-38d90ced39db}
> > > >   */
> > > > diff --git a/include/uapi/misc/azure_blob.h
> > > > b/include/uapi/misc/azure_blob.h new file mode 100644 index
> > > > 0000000..f4168679
> > > > --- /dev/null
> > > > +++ b/include/uapi/misc/azure_blob.h
> > > > @@ -0,0 +1,34 @@
> > > > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only WITH
> > > > +Linux-syscall-note */
> > > > +/* Copyright (c) Microsoft Corporation. */
> > > > +
> > > > +#ifndef _AZ_BLOB_H
> > > > +#define _AZ_BLOB_H
> > > > +
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/uuid.h>
> > > > +
> > > > +/* user-mode sync request sent through ioctl */ struct
> > > > +az_blob_request_sync_response {
> > > > +	__u32 status;
> > > > +	__u32 response_len;
> > > > +};
> > > > +
> > > > +struct az_blob_request_sync {
> > > > +	guid_t guid;
> > > > +	__u32 timeout;
> > > > +	__u32 request_len;
> > > > +	__u32 response_len;
> > > > +	__u32 data_len;
> > > > +	__u32 data_valid;
> > > > +	__aligned_u64 request_buffer;
> > >
> > > Is there an implied 32-bit padding field before "request_buffer"?
> > > It seems like "yes", since there are five 32-bit field preceding.
> > > Would it be better to explicitly list that padding field?
> > >
> > > > +	__aligned_u64 response_buffer;
> > > > +	__aligned_u64 data_buffer;
> > > > +	struct az_blob_request_sync_response response; };
> > > > +
> > > > +#define AZ_BLOB_MAGIC_NUMBER	'R'
> > > > +#define IOCTL_AZ_BLOB_DRIVER_USER_REQUEST \
> > > > +		_IOWR(AZ_BLOB_MAGIC_NUMBER, 0xf0, \
> > > > +			struct az_blob_request_sync)
> > > > +
> > > > +#endif /* define _AZ_BLOB_H */
> > > > --
> > > > 1.8.3.1

