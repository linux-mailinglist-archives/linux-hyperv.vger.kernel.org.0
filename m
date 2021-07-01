Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7EA3B8DFA
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Jul 2021 08:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbhGAHBI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Jul 2021 03:01:08 -0400
Received: from mail-mw2nam12on2114.outbound.protection.outlook.com ([40.107.244.114]:60929
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234697AbhGAHBH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Jul 2021 03:01:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2IGy9HmhlFqRApD0dgsbXP/0vQ4w43Di2Xds3JYEzinbNtk/V78cPnVLSWd45xKrT61LUEJ3WC4yG7WD9xqWR5ASllOedSBWzM/0ZHqHJjjcPHc9VGEwpLR6+Fo34ou47ZfmSCbu4hdgqxjPiTK5mQqbRyV6i6BMXrETKEqbRzy1KlIyTztOTOb+Qip6ak9y+EHlUiiRPJtMudAivXjXoliPDAVIAJQJq1j4AkusVt0buqlheWqrLmQQ9Gv7gwzPFbQqv/dSBMoft5IW00lw0oh9Ccgsd8nCXcohUCDZOmeBClzFEtIFye94Rf7Q8AG25I4Vybus1NaRAQlhUuuOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yfQ+kIh5ccSnhDaPKJh7Q9eKqj97vrHwXQ65Wda1wA=;
 b=amKd6HmxHNQbj9zsdX1Tu9SYJoC7gnkKYdXdh7r1tAywnI+YOigUP0GuBJ7poy9ywuvtrD6WCD0VZk6we0jPynkLJkXmPdEwabIMnDctz5Frp3Uk5vWWOykudM+gc9C/6Z/j+ELa5dhSlhAY2FQd3Ble0mbTqHnjI754SXexZaAa7spIxnUq6cQ2BYe2m2upJF9IedJr1etWzP7SQLNx2F9BCyBVdBlNKaFCBg/OoXtmLC9nRs5M8saBjpptWP/xygNJAR58nzuiFPrFB+B/JoxruYbDljOOTWtRNeJ4l+YMhdteaEdHu8kkqhapusb3n9OEokIMzZg280o6SIdHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yfQ+kIh5ccSnhDaPKJh7Q9eKqj97vrHwXQ65Wda1wA=;
 b=GjCtZjse7DvcLOYsRB0TBKKxCWE3aX8tppLKFFSSsSFd8IhHqeMTaYZ9J+GcRvNSOByl9rK5bWFt4gUA9ZgyniTe3jFlxSJ9IvfhyB61GYxjCTIOi9AtEp/JLqu3nrkW5CtEApqOYXVJcfQqCHaX1R+oHfGO9BF/JC0i5mBgr50=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1656.namprd21.prod.outlook.com (2603:10b6:a02:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.3; Thu, 1 Jul
 2021 06:58:35 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::f126:bfd2:f903:62a3]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::f126:bfd2:f903:62a3%5]) with mapi id 15.20.4308.007; Thu, 1 Jul 2021
 06:58:35 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Subject: RE: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXalTR5lVKFlOZkEmq8/y9Kgt/basqijaAgAMsL9A=
Date:   Thu, 1 Jul 2021 06:58:35 +0000
Message-ID: <BY5PR21MB1506FC199A753667E72C9B09CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
 <YNq8p1320VkH2T/c@kroah.com>
In-Reply-To: <YNq8p1320VkH2T/c@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c9a8c1c1-4569-4a87-989c-29ff49c11389;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-01T06:51:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f9b9550-98ad-430c-cf36-08d93c5da54a
x-ms-traffictypediagnostic: BYAPR21MB1656:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB1656E4AB4D2F29D0C22149E5CE009@BYAPR21MB1656.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cOcrx5dv2HXJIHvb97n6VEAtDQKAEp1aZltL2LJABLhc3EGLxVkOwKQQYlgXmf15/hobSbF7RIYKVDYFNdubF7aoGbcWpuhcNeHiuVHedMcRhjicxAohnaQNDyMklNGIJm+R/pMLUpo+KM5InibBsRJ0L3yKo9Lee0++1y6bD0t8ETijJD5PVmdecID+lqPfZQpeawtCvGpNf6Y4Y0yPhsRsVSPzRiAZlF3rSMN1uAVKow9cCknjBvuWEh+SLORN9Hjs5gc4se8aVAuAXduaHG1wSGSE9mv35ygITTGKdoondBh5lICX3GGjsZd5BCkQ9g/LYp/bsgvJEm+92IcInFkdNQK8ZxiAD5p/UxtvQRCumn0ej+zxmsHZEPSX9jnEhDUbOTK9sYI9gc0v1tRmycdZ7DBG/c2RP/G260jl5EhSPHx8+xrF+bSBw2OUBt8da6FG4uAAuT9FfFjVzBB5H6H3mNX12raudBg7iWrr3P632GvaNO6V4g4uszI+fZ8bB4C0axI4TosjfuohTC9dp0EmHShwR+Lwzg0BfvOoqwQS6WgRWi6DlI8LQxRxbKa8NUKzFfiQOs29mJ6cqhy4wKqWhBMOgafxC8DKCPaeXdiR9GHDu2D3jIdZK9hzAp3ed15YPXWWXx/RhUGXTri/OA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(71200400001)(2906002)(38100700002)(8936002)(122000001)(5660300002)(478600001)(10290500003)(8676002)(7696005)(83380400001)(26005)(54906003)(316002)(86362001)(66946007)(6506007)(76116006)(4326008)(33656002)(66476007)(110136005)(64756008)(9686003)(82960400001)(186003)(66556008)(55016002)(82950400001)(66446008)(8990500004)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5R1bykMLjFqlbUgV9iTZGzPY6Unphw5gw5b4C4HE2tTMPG4L7kGX9BO7j8Dm?=
 =?us-ascii?Q?lGr1nE5ejg6MTOkBglDeIFv+38dct8XthVhXzGvVKf3r/DHFZ0TPXrDZl3Rv?=
 =?us-ascii?Q?DFpVv3JK4C6I4YiViD39SuCQt8jZ8YeaNEB0Ox+wchQ6ELqLYp3twtG1KTwt?=
 =?us-ascii?Q?6xWa7lCpUd+lPyXR8jbKmGTnQx/dTPa+xaZgQl3m97wqUdOU24XSpQFJVO11?=
 =?us-ascii?Q?WJ7VdxOlJdNOvVXkHqB9L3Dqu60lVVTVUnjeOIqMJj74mJ/0pA76Grtlz94t?=
 =?us-ascii?Q?VtOy2XC6XLJcNmnPPtQcO9aS1g3B2Dmf5dF0dTAeE7k2e6TU8dOmCxVxyY9g?=
 =?us-ascii?Q?GOKEbySgkFvOhcpNFz3Jiq2bs0n8YL7BFrt+4PSSuECkbq06C8h51NZHoWqB?=
 =?us-ascii?Q?xhYN5QYjHbhBDZKX0lXGNg913ACOEZa8RPH8pF5gTCfIY3EtVZFa0e18mL0k?=
 =?us-ascii?Q?ElTX85XnlAPUg1W64nNK2v+6RupB2JvEaSLg/UVvq77WS3msEwabEsMm4sgu?=
 =?us-ascii?Q?X45JgpfiGks8KQ1uObI/jFZxqRowWHxqvKCqZAiRPB9p5ZodziOjN5+bpNiY?=
 =?us-ascii?Q?y6JaXZHXc4ngLtNPqilxYLN87kBduGvpQITJ9w0swMfp/xugirBi/hisNAcQ?=
 =?us-ascii?Q?Vrf+04vvh/BHuGwRjtznmtzHt0ZjkD0G6eM23yq0/v68l4I+ummOsFFplGLq?=
 =?us-ascii?Q?7J8XT58sDAD1Ys52lxEvX4TRE+mYU9DjLWD3pimesaS03C36FVTUsgBHzvmT?=
 =?us-ascii?Q?qvyW8fVlVt+o34neozroM46cxKImWNVgXhIFByxcRTc4fWjzY/Q/c4JxpdrL?=
 =?us-ascii?Q?tvV91yBPJbmcqw4Mij7L6xFkLzmNNc4jI6T1qKBykhTu6aLh4YoBTzAP1Hv7?=
 =?us-ascii?Q?+sM2NPZeq+qnE1b6kqzELUxIfOwtWsqpmQMum5WLnWgWbnlnKqR6fDOcikku?=
 =?us-ascii?Q?EQukW1YtGspkU0EYiMskm/P2QaZkG8yEwB4JmabYiJpxNqIxmPEqs4jbkA5D?=
 =?us-ascii?Q?qPFzYjCCef3uSu+sJThRPMCewgOB2eT3Xmt3IZ5CBzeIbzZxs9QpMUR1Tc02?=
 =?us-ascii?Q?nkPSdfyTIk/fld5fwUTOuA8d4paLPfUisrhXdUgp5UlTzfZfRh9jBnb4eDO3?=
 =?us-ascii?Q?SBKemNMVzOI/CdBFlagX3/xTUiTcvfvBcCbZ6VaDjQJrVQvhkbuITRnUNRQE?=
 =?us-ascii?Q?TNohp6sxn/ozasDehh2e2jsb4W8vgjoQbljWISL0L+cmY7BoQRx7J+i8V9Gs?=
 =?us-ascii?Q?iWShEKK6qYvbl5qV+22Qxa8kc4oAn+CykFivQ1TL7T7nYC77I5vJ9BxZfY7n?=
 =?us-ascii?Q?PHWzKhOX6tE48YWudLPZzpR/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9b9550-98ad-430c-cf36-08d93c5da54a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 06:58:35.0582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJ4FmqNtfFVsl//hdN2TguVH6ybbFkaanNBNRPzqA+Avxg5LVhbf0BDTUoRdBIr75fp1JqA381c4tgTEO1Vwqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1656
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
>=20
> On Fri, Jun 25, 2021 at 11:30:19PM -0700, longli@linuxonhyperv.com wrote:
> > +#ifdef CONFIG_DEBUG_FS
> > +struct dentry *az_blob_debugfs_root;
> > +#endif
>=20
> No need to keep this dentry, just look it up if you need it.

Will fix this.

>=20
> > +
> > +static struct az_blob_device az_blob_dev;
> > +
> > +static int az_blob_ringbuffer_size =3D (128 * 1024);
> > +module_param(az_blob_ringbuffer_size, int, 0444);
> > +MODULE_PARM_DESC(az_blob_ringbuffer_size, "Ring buffer size
> > +(bytes)");
>=20
> This is NOT the 1990's, please do not create new module parameters.
> Just make this work properly for everyone.

The default value is chosen so that it works best for most workloads while =
not taking too much system resources. It should work out of box for nearly =
all customers.

But what we see is that from time to time, some customers still want to cha=
nge those values to work best for their workloads. It's hard to predict the=
ir workload. They have to recompile the kernel if there is no module parame=
ter to do it. So the intent of this module parameter is that if the default=
 value works for you, don't mess up with it.

>=20
> > +#define AZ_ERR 0
> > +#define AZ_WARN 1
> > +#define AZ_DBG 2
> > +static int log_level =3D AZ_ERR;
> > +module_param(log_level, int, 0644);
> > +MODULE_PARM_DESC(log_level,
> > +	"Log level: 0 - Error (default), 1 - Warning, 2 - Debug.");
>=20
> A single driver does not need a special debug/log level, use the system-w=
ide
> functions and all will "just work"

Will fix this.

>=20
> > +
> > +static uint device_queue_depth =3D 1024;
> > +module_param(device_queue_depth, uint, 0444);
> > +MODULE_PARM_DESC(device_queue_depth,
> > +	"System level max queue depth for this device");
> > +
> > +#define az_blob_log(level, fmt, args...)	\
> > +do {	\
> > +	if (level <=3D log_level)	\
> > +		pr_err("%s:%d " fmt, __func__, __LINE__, ##args);	\
> > +} while (0)
> > +
> > +#define az_blob_dbg(fmt, args...) az_blob_log(AZ_DBG, fmt, ##args)
> > +#define az_blob_warn(fmt, args...) az_blob_log(AZ_WARN, fmt, ##args)
> > +#define az_blob_err(fmt, args...) az_blob_log(AZ_ERR, fmt, ##args)
>=20
> Again, no.
>=20
> Just use dev_dbg(), dev_warn(), and dev_err() and there is no need for
> anything "special".  This is just one tiny driver, do not rewrite logic l=
ike this for
> no reason.
>=20
> > +static void az_blob_remove_device(struct az_blob_device *dev) {
> > +	wait_event(dev->file_wait, list_empty(&dev->file_list));
> > +	misc_deregister(&az_blob_misc_device);
> > +#ifdef CONFIG_DEBUG_FS
>=20
> No need for the #ifdef.
>=20
> > +	debugfs_remove_recursive(az_blob_debugfs_root);
> > +#endif
> > +	/* At this point, we won't get any requests from user-mode */ }
> > +
> > +static int az_blob_create_device(struct az_blob_device *dev) {
> > +	int rc;
> > +	struct dentry *d;
> > +
> > +	rc =3D misc_register(&az_blob_misc_device);
> > +	if (rc) {
> > +		az_blob_err("misc_register failed rc %d\n", rc);
> > +		return rc;
> > +	}
> > +
> > +#ifdef CONFIG_DEBUG_FS
>=20
> No need for the #ifdef
>=20
> > +	az_blob_debugfs_root =3D debugfs_create_dir("az_blob", NULL);
> > +	if (!IS_ERR_OR_NULL(az_blob_debugfs_root)) {
>=20
> No need to check this.
>=20
> > +		d =3D debugfs_create_file("pending_requests", 0400,
> > +			az_blob_debugfs_root, NULL,
> > +			&az_blob_debugfs_fops);
> > +		if (IS_ERR_OR_NULL(d)) {
>=20
> How can that be NULL?
>=20
> No need to ever check any debugfs calls, please just make them and move o=
n.

Will fix this.

Thank you,

Long

>=20
> thanks,
>=20
> greg k-h
