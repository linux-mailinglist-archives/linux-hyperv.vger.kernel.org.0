Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933923CBC8E
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 21:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGPTcb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Jul 2021 15:32:31 -0400
Received: from mail-dm6nam10on2107.outbound.protection.outlook.com ([40.107.93.107]:46816
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229611AbhGPTc3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Jul 2021 15:32:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zs8q0/syvct4fqm5/Q5vJeRuuCvN/WC9hKKgZAEZrMTt4ThdrsrkiFr/FODkwvS8hN6WPW4cdyY5a1DdPQNfREW3sSJ56UGOJN68BNBLs8QhYFjBifJk5JEjzHEbPDBJblTeSNMV24Alr/zY0BXYA5JJMN0QY3ApovFgRS28Cv6NUt8TMW7x1fDfWz3NDQa15WL5FYgq46zXoe1GfMiU32JLful0cx2QM1c+V9OKR8gcEbGWPyjDOXbslfX+nKuisflCT/p+UBeAMRKVD5YDoxo7/YGovnW6OZX066eCaMq7xmq+ZMv7t3clRCfgV6YR1aH3VQPh3QGPh2Mr61whww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwrGt8al0DAqHHIA6ZZriVfEts8YqVYHpTvey5ntXBI=;
 b=YvKm7t48dZmA7JZV72ft/g5HgqpXQ0QHjyUOGJa+DL6WKzO/gsYli9/1vgC3n9Y4uGRMv5uS4HBtRk1EcDMf77y7rQ+aPvsCbRi3Fr/xqGW9sdLbEWKdBfLVGJ8VKFiU2Z6PeBCFOWObmDocXfauo7DphbR8WsSAw9zyTAjrDg4Px5DIncWGlkNV7zS+emXmb/Ewn7BieuHr2ugSdWHc/Yq+k6i+dSJ9MB7YU3YodGtHdF2rHO0YAKBWUk1ovrJTf+UEhOZpz5LDykPXlaG3A1qjY5vunlvgQew/maHwkvem0f3TkXtwmAJkV+b/IshuAAMl9wODEYIAanKfHY6xfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwrGt8al0DAqHHIA6ZZriVfEts8YqVYHpTvey5ntXBI=;
 b=SXl8KHEnan2RZmG0CBApZoiGXxzMf99kQJET9L+ij2qtnDhcIe0tOfr4YP94VOFzhze9VHSHhuczeUF5D8cECYVeCXbihqg9f1tBYxH1LHgetO2u8aNLUO5ScB9H6nRbr38v1Iv0KYd/zjSy1W7hveGA2cnWIok14W+izm5pEWc=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by SJ0PR21MB1901.namprd21.prod.outlook.com (2603:10b6:a03:294::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.0; Fri, 16 Jul
 2021 19:29:30 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::ec21:a9f8:7e74:5e1b]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::ec21:a9f8:7e74:5e1b%8]) with mapi id 15.20.4352.011; Fri, 16 Jul 2021
 19:29:30 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
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
Thread-Index: AQHXeFpU0avVPr6X1EyU3ZDtwXfEcKtFxYAAgAAZqwCAACEvcA==
Date:   Fri, 16 Jul 2021 19:29:30 +0000
Message-ID: <BY5PR21MB15060A31D031B556700F2767CE119@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
 <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15937DF3FB30DDA65EF58EE1D7119@MWHPR21MB1593.namprd21.prod.outlook.com>
 <YPHBpo1n/COMegcE@kroah.com>
In-Reply-To: <YPHBpo1n/COMegcE@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=49488778-4472-48ce-88cf-91ffeac7e4fe;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-16T19:26:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 920b031e-dd6a-466f-49be-08d948900872
x-ms-traffictypediagnostic: SJ0PR21MB1901:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR21MB1901625074F29CA5555EB926CE119@SJ0PR21MB1901.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uqWvrAdWFbxnxTmGT37WWJpoxZy0jcXvJan6ijbTq1Y5mEExCHa0EM6L16FoL6o2XiuweN0xA7MVZVLutpQFoO18b5pEI5gOJmJUsEdtA0RfZagofrjHJsm8x5IeeQmuricDNa7NK/lt9zH2ISAMhtrHN58VCpKk/6EgyFhqpm8WUrgbjUccNMVaIeEgn2B2MUEFiQd/ALactOa+pVXj3Q07JMHdATK5RC/dP0xPBguIYxQTSmMJyQrXVTPZITs+axDGlwFZySwoY/Mfbz+2DvNcLET4mnQbf6pVziAVhn52/zkiw07NcPcrXGcKD1yTVSydmtqT7YDMLPbD8/Xz2UOg47BQVJzceIY0VLN7Mlop+Kes7QcLOlO6MK739QXDeasyD+U3T6JOCYhJGLbjVqOfAlXMKl1lyX7m8GDLJMMDHUzzr34Jh8QrxxzFgPzQbUhyJD3JBVG0hklSQFa7SHw4Nl5fD+nlDKzpC5J3K/dI8iKUeL2M7s7oQurR75KLiq9EVtM2/9ldNDGmywbUjax6NztGE/piT5B5QbWznaZMWAzgvE8T+eZ8xDxfxKwXwzRPCS3xRocJw1tWaijRR850ARnR/Wtbdj/D4rxBIvfJeCZp5MNEVodHXFoJVOQq8ACCoDHFA1j2p2Q+oDx/VcxkXsFRjihAELlMLdUzxdtoWFsPD086AVuiS/V5z7WGnyn8U0M0kKUaQLKhiXD63w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(9686003)(86362001)(54906003)(8990500004)(71200400001)(7416002)(38100700002)(83380400001)(316002)(8676002)(64756008)(66556008)(10290500003)(66476007)(33656002)(122000001)(8936002)(508600001)(66946007)(76116006)(5660300002)(2906002)(4326008)(82950400001)(82960400001)(52536014)(66446008)(55016002)(186003)(7696005)(6506007)(53546011)(26005)(6636002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jzegd+sl3jBz6SD17TTgQ0WmVsr0hLGwb5i+JsIdNT0ZqU28jSjKFo0Jw1fD?=
 =?us-ascii?Q?FEELtb0RShF7c8XTVi3Poh4MqmNETJD+JVmyYebgIoCi5BGiQCJIN/UglHfC?=
 =?us-ascii?Q?T/HBWZbCrtW+2bysu35TwS9NGI/QFg2/cZS4RA57fADp6riVuPjOZoHGsbRy?=
 =?us-ascii?Q?gnQ1Cg7mn1vJHsFxgf70HhJr4vivtL6XdfSpUFXz5kThOaWdnBNcTZkLxnZj?=
 =?us-ascii?Q?Cok3kZrfZ/FP2IUCBMpVnIAtsWOkWOp8qwsNEupZZ8Gb29Nz/hJY0y0V88iC?=
 =?us-ascii?Q?x5Z5fxOboMzMNNpFhncP3zVu1WXe7Yci4D5ZfHAGnuh87TNIBoKB5rvU8YK0?=
 =?us-ascii?Q?43e8kNCOqSx84rRm0OYmd6UQUefcAE51eKfR5M3bGB8Kdtpexv8Ve1Iy1JPi?=
 =?us-ascii?Q?ez73UFf5dhkkBcPvplygZLIJJHlVeMKkskT0Y/YPf0iTiy9/B4GuezPGUKWw?=
 =?us-ascii?Q?oTKKVWk3Pwr+W2x7KKNd6455SkKr4YcUbWhvE4quaXb/WlmYh1wLan35Zw4h?=
 =?us-ascii?Q?ftFGr6hc+pMAYht2cV8WM5DW7xkpBF9tjcEGxdTwbsE+zxOgAxgCcxYgPZNj?=
 =?us-ascii?Q?+OjuxPYKZw0y3vpo8N9vCfl1qkHTiQsxepiEeVSpz4FiD7UqAQVGEbnHfgyT?=
 =?us-ascii?Q?YRaaOuNbjL4sH8CmsmsXO1IsTi5t82DjhygH0gHGUHjwPX6YXkeFXDrWWa+/?=
 =?us-ascii?Q?+dqyX47DHgkC7uxcHjRtb2z/CFyBhIB3tRN2LmjC2uZYTaYBOke7Sf1xk2PB?=
 =?us-ascii?Q?R681EVMMrjrmlGJODc/AIbKUE2AKZzvM6Vp++sXggKmMH3SbZlxqyzjcl2JD?=
 =?us-ascii?Q?FVCOoJR+bA6wUeuJrdQQmOy4nxbvsSsI5gli3Ng8NYHuY7x9u8LP3VTtP60M?=
 =?us-ascii?Q?KIlaqH+5c1SWqfQpAEkefT0MdNzzx2ucKyRfAu7nm0whLVq6jHb5BxUCfyYj?=
 =?us-ascii?Q?h+xRNokqrFkLfzXaXzNMXMIZAvA4/iQoS96ScMlLuTzBg6SUhd2T9UBl1sPs?=
 =?us-ascii?Q?MSYYmgO/GuWYOBywL0iroqZhScfysKI/vh81qsUlu6SmzMJR7IrTiY0fsJcm?=
 =?us-ascii?Q?NPjlE4F2jg6n04jHIae6bXSlyv+h5CjVJWDOcpvLQQzzbWYM/rUAV/v29Ukj?=
 =?us-ascii?Q?r+aZQvWr/1BiTYzRc9p27AkaeNavIMI7vALhjy4s1YhxgWFL9x8dGryZBVxo?=
 =?us-ascii?Q?Xd+66FZxaqFH5609eSvA+QIfyeS37gm2q9tmhON+ZvZG1dzHNM7BRoiDD4Ma?=
 =?us-ascii?Q?euvXOihlpqF4CrAK/Kp+5xFm0whIe7x2yA+bETjWCaXoSIA/ND4X7im89FlP?=
 =?us-ascii?Q?9c8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920b031e-dd6a-466f-49be-08d948900872
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 19:29:30.2659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYVGKkts/3ux4zbfEVohGqPEDU8IuTxBRbKeEuytZMWSOIyhA/Df/iYQP2K52Rkq3NerKuwXzjWjcTStewaRng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1901
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Friday, July 16, 2021 10:28 AM
> To: Michael Kelley <mikelley@microsoft.com>
> Cc: longli@linuxonhyperv.com; linux-kernel@vger.kernel.org; linux-
> hyperv@vger.kernel.org; Long Li <longli@microsoft.com>; Jonathan Corbet
> <corbet@lwn.net>; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; Bjorn Andersson <bjorn.andersson@linaro.org>;
> Hans de Goede <hdegoede@redhat.com>; Williams, Dan J
> <dan.j.williams@intel.com>; Maximilian Luz <luzmaximilian@gmail.com>;
> Mike Rapoport <rppt@kernel.org>; Ben Widawsky
> <ben.widawsky@intel.com>; Jiri Slaby <jirislaby@kernel.org>; Andra
> Paraschiv <andraprs@amazon.com>; Siddharth Gupta
> <sidgup@codeaurora.org>; Hannes Reinecke <hare@suse.de>; linux-
> doc@vger.kernel.org
> Subject: Re: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
>=20
> On Fri, Jul 16, 2021 at 03:56:14PM +0000, Michael Kelley wrote:
> > > +static int az_blob_remove(struct hv_device *dev) {
> > > +	az_blob_dev.removing =3D true;
> > > +	/*
> > > +	 * RCU lock guarantees that any future calls to az_blob_fop_open()
> > > +	 * can not use device resources while the inode reference of
> > > +	 * /dev/azure_blob is being held for that open, and device file is
> > > +	 * being removed from /dev.
> > > +	 */
> > > +	synchronize_rcu();
> >
> > I don't think this works as you have described.  While it will ensure
> > that any in-progress RCU read-side critical sections have completed
> > (i.e., in az_blob_fop_open() ), it does not prevent new read-side
> > critical sections from being started.  So as soon as synchronize_rcu()
> > is finished, another thread could find and open the device, and be
> > executing in az_blob_fop_open().
> >
> > But it's not clear to me that this (and the rcu_read_locks in
> > az_blob_fop_open) are really needed anyway.  If
> > az_blob_remove_device() is called while one or more threads have it ope=
n,
> I think that's OK.  Or is there a scenario that I'm missing?
>=20
> This should not be different from any other tiny character device, why th=
e
> mess with RCU at all?
>=20
> > > +	az_blob_info("removing device\n");
> > > +	az_blob_remove_device();
> > > +
> > > +	/*
> > > +	 * At this point, it's not possible to open more files.
> > > +	 * Wait for all the opened files to be released.
> > > +	 */
> > > +	wait_event(az_blob_dev.file_wait,
> > > +list_empty(&az_blob_dev.file_list));
> >
> > As mentioned in my most recent comments on the previous version of the
> > code, I'm concerned about waiting for all open files to be released in
> > the case of a VMbus rescind.  We definitely have to wait for all VSP
> > operations to complete, but that's different from waiting for the
> > files to be closed.  The former depends on Hyper-V being well-behaved
> > and will presumably happen quickly in the case of a rescind.  But the
> > latter depends entirely on user space code that is out of the kernel's
> > control.  The user space process could hang around for hours or days
> > with the file still open, which would block this function from completi=
ng,
> and hence block the global work queue.
> >
> > Thinking about this, the core issue may be that having a single static
> > instance of az_blob_device is problematic if we allow the device to be
> > removed (either explicitly with an unbind, or implicitly with a VMbus
> > rescind) and then re-added.  Perhaps what needs to happen is that the
> > removed device is allowed to continue to exist as long as user space
> > processes have an open file handle, but they can't perform any
> > operations because the "removing" flag is set (and stays set).
> > If the device is re-added, then a new instance of az_blob_device
> > should be created, and whether or not the old instance is still
> > hanging around is irrelevant.
>=20
> You should never have a single static copy of the device, that was going =
to be
> my first review comment once this all actually got to a place that made s=
ense
> to review (which it is not even there yet.)  When you do that, then you h=
ave
> these crazy race issues you speak of.  Use the misc api correctly and you=
 will
> not have any of these problems, why people try to make it harder is beyon=
d
> me...
>=20
> thanks,
>=20
> greg k-h

I will address all the comments and send the driver for broader review incl=
uding
linux-fsdevel and linux-block.

Thanks,
Long
