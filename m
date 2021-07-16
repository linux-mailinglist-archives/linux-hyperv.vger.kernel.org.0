Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085263CBE2F
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 23:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhGPVKA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Jul 2021 17:10:00 -0400
Received: from mail-bn8nam12on2108.outbound.protection.outlook.com ([40.107.237.108]:48096
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234760AbhGPVJ7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Jul 2021 17:09:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7/FZHqo+zDIqiz+fLzlgtYLKbEL4ZhUIFd1xTkasWDyt+CdvwOgxLaXu6DINUzDeDrq7F2Q8grIAWvZYPWDH397d5t0+EpjQR1kZOWQUwVHLIQabyOIkRlmT8sh+UPKkUOaKAUn8HcBuOT6nxlMR2yPA2iocP/iOhTBiSTs68Z1N21K6AL1CsGKvO4jhMZm7PlwrpJJpzgb3KUsW3Ygh7FA/CCGk2HEXbeCLFzv7JGcKNC8WxV24lQydlskLQGJ2gkKxl79++Xdp7vGa2Qwpk25zAvL3AQTVC33XT83lYcN/f/F0os1ymKGfRkeCDGyYBD5cpaxDSBseEdj/+fi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MpBHoGV7y/GFlzECrUkPQooqKO3b9FCy5IUQcKhOTU=;
 b=hd3pY31t8muOy5KzCU7MzumodXoaLk6LjHYTD2vVpCFiag0ChVQdMhUicKQd1u97Oxd9TJwe9c6gg6+8hC7/th76GgJdWF+5Ckoeo0AQXacEPDKQcwLSsGGGvPvKHweHHs6kkEKQAIt/hMAhrLvOv/BoAxVcFLdqWoQrhfp77UutaIYFHz8llZOncd29kWfe9L4FueDDEgjECvwx7Xa4cGPIAusLbe0hkR9CgjtxCg59ZlgAL7C57i01LSUHFkwD8mLHFv5CGCJtxXB3wvfqP9LuUpd0iY9M58KwZze6pjc+Jl7rX/fz5uL0P5Vjyy45v56afQQmSj2Ur7x8SRzxew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MpBHoGV7y/GFlzECrUkPQooqKO3b9FCy5IUQcKhOTU=;
 b=TNx3XAaP3tBL14ROBpZdoHITAaFD0f7xoCt6jgbLOBXReHxaPZPVtxGZNVQMpCtbc0+tmNRZkyDL6T91chJNubE0KA9SeWQuQ+P6FQ8X8YXDEEi+mntrro+KCD5l0YtXUrP4qJC/vj0kNX2yrnn7ZvRSiU+7E7kTZwOzxkuBrPE=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0285.namprd21.prod.outlook.com (2603:10b6:300:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.4; Fri, 16 Jul
 2021 21:06:48 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19%7]) with mapi id 15.20.4331.021; Fri, 16 Jul 2021
 21:06:48 +0000
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
Subject: RE: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXeFpYCjxW1LHgzk+I9msc1XWXVqtFsSrAgABPJACAABZnYA==
Date:   Fri, 16 Jul 2021 21:06:48 +0000
Message-ID: <MWHPR21MB159322A1E3F0C50362643D34D7119@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
 <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15937DF3FB30DDA65EF58EE1D7119@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB15062B99587CDDCC126DDD87CE119@BY5PR21MB1506.namprd21.prod.outlook.com>
In-Reply-To: <BY5PR21MB15062B99587CDDCC126DDD87CE119@BY5PR21MB1506.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=637f0e51-bd6a-4fba-b81c-288709d0b198;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-16T14:43:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 491a5903-f301-4214-dc44-08d9489da024
x-ms-traffictypediagnostic: MWHPR21MB0285:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0285E7488012A31C350FFC4FD7119@MWHPR21MB0285.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cEgDF+h77RSQU5cmt6K3WHQuwoyS6Ku4KFRFiujFIubLLUA1oyDkkPme1769gNJeJdiizIHNqkTo2+SkXeJFuhf0Gn8CoNX736vk7E78GOlhvWbyEa5v+nClo7x9Jvf/N8MNiQsXbCKYsP6Yf1ClyH0pDlGLmqb+XxLuPw7J5XR3/lMlh+Ltf44BsUq6J6aJSM6Yi2c107wVZOyFL3VALXcj2aIjUVa0b4yVCWDtw5XYSii7VNv9/mNf0gnse3o1jk3bK5SHcMqHHGTJJf7L2V7rLFFT22Vm5gU6Z0eraqFfL3uWfWHKOOZuqyfAbvnS9FZBGX+Z8VMxydGyWBQdmAT0ela++480IGIhDCHjs0AU23Bd2dcqXfErzD3621Qq2bvrWfozNh+tiIWkqRrW87F+5BA05+HQunXg140mBeYzU7W5lNAXq3JYAFCmtcnjK5xVj7EXXOdxFss+uOooGMdw4VLAOK9BbE/awop/kCnGwnzVE/hrbt/aHD66dltfxggnekXxLIFtsNngSHY68HoBlAJ5cQDBdFVDSiKYGnaOzCSWknaoty/2qEABiu4SG26QeQpEIUK687Zuoq5UnRuu9nqAh7HczoEHfzhyIedJ/6ysDTbqva5LAkmvGy6H21ICXaeAbK0c3R0qYdoK/Usz5VPPU+9505Cd3DQfcssZn0GrhxSCl9TX9WYSiP1vzlOmcEJgEIk2jGEK0bAliw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(316002)(82950400001)(30864003)(4326008)(33656002)(71200400001)(508600001)(7696005)(186003)(122000001)(9686003)(82960400001)(10290500003)(54906003)(55016002)(5660300002)(110136005)(8990500004)(86362001)(52536014)(8936002)(66556008)(6506007)(7416002)(2906002)(38100700002)(66946007)(66476007)(64756008)(66446008)(83380400001)(76116006)(8676002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KoZHtNlo4LZL9SoSaSs5nJiqk4oRAPEKKNSujklcd8GsVGPC6CtlmcSMvZKe?=
 =?us-ascii?Q?S+ZpfSKgRp3s05sBQqlwtsp9pixAq6/Bxy+kFTZ9lxIMrcvf3GQvsoyO0Soo?=
 =?us-ascii?Q?HBrz3O0Qnterg+hiOCrJ8JHWOfvv+6TLlwFKem3Vo9Sj8TjKBKL6PjrEZLVH?=
 =?us-ascii?Q?2aYonWhTX5J24pYAZ+PXB8+WJSkCI1sx5mzJAZjxhnoGXTLhUiFw/bYADOgc?=
 =?us-ascii?Q?fxZZQhtjbzDloUndNOnaL3uoU2QpI+/TdWYa+/NaAptElh5zm2EXJwhzM85f?=
 =?us-ascii?Q?O8ZlyZVt6jDQhZMrH5D+H/q6GP7x+6BmJcPQkCbp/1vLJqvtxZMSanqm9cOL?=
 =?us-ascii?Q?NDwq730nfYpiaeg1AHLifVD7zCSTV/ga9TE5ikob6LlMXnc5+zjiEto5VmGt?=
 =?us-ascii?Q?Qq2BAhFEn9RlzZZMb0CtU11qQNyXA+NA2UJmdyJQjfYLY99YZwl0rb2P/sgU?=
 =?us-ascii?Q?hg/UZ+kOlcubXl5YzrO36XSYLQbNPVrk4acgZIHnRG+YywY5ngJu6AloTVKh?=
 =?us-ascii?Q?wQ7WRt3GwVbUNnJ2FPTNkpFSpHapWXDK7aKSbJ6h0jnzLfWHWNYRBeNDa81f?=
 =?us-ascii?Q?Az2jltrmvYN28V9AbJKGFy2pC2Jl2XqglnFlSn5Qr7PVcIS64eKCHhhFd15s?=
 =?us-ascii?Q?39i67GAY/J2lX12+MjXny72q1d1NTNqTcAaXndJo7qp+ExR7hwegqqBNRgjF?=
 =?us-ascii?Q?QmSYkOQFiJvQMimeYoLO0b2WBSy0msl3kjboKWHcIS1yEyZPtkyTb9Cyrnx+?=
 =?us-ascii?Q?hMGTtHfyVISODMNzHHeZ0cQ7TF5527ttcxa2XIzyNLlHDHseeBflx6rhvw46?=
 =?us-ascii?Q?TW4OWtfXtR873hgC+3p/sIGeq+K/Vpu/mqWBeOy2k5us8oD1t+2wCeysa2+w?=
 =?us-ascii?Q?WC5bSTRZ/MOpHIhZdBAjYsPNgJWDBgq0mPtLEfCGJsBV9QjtPWYMukqAG3Bx?=
 =?us-ascii?Q?y5/qvDHKTSAgHZwaz9G7FpbXVH0IWSmDtOf4IAva9JFSzV4ReuysxoW1ZRSY?=
 =?us-ascii?Q?Vn1X8oX0fl+zkZXKWO5qc8u3zTxAg+c/361pi972veiEoxRFfhGjRO3g/jSY?=
 =?us-ascii?Q?2613deKX0BVswsWVe6bfSeaSuSH59hL/G8EqKnRSoP3XSVinFLrNiD7s2+ua?=
 =?us-ascii?Q?5jAgaWZn+LB8JZH+3cxixdMHz0mv3os0jZiYzwB6AloaXM6NgXXBMxH8Q5H+?=
 =?us-ascii?Q?9taRvfCXfAkYPQrLAiZa2qG9RJpolImbhy1UxRd6USK7LwBoRwQzx/nWMiiz?=
 =?us-ascii?Q?a7B0XMNvmb5o6+bwmYfWXvKqwbanpBylhLVqQZ/9Tkrr+Jp/Vs9oTCHWPFPF?=
 =?us-ascii?Q?c3rs5FghTVt8RupKVkUGiidJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491a5903-f301-4214-dc44-08d9489da024
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 21:06:48.1632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6EAZuGbMdhhU+u7nc9W7D5lT6P/IvMWOagrwSqglCq5991f/BKArK/RfLoYPOGViseNv5uH280WIPA/JexqvSLQlgkn4p6VRtqqR0qztAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0285
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com> Sent: Friday, July 16, 2021 12:27 PM

[snip]

> > > +
> > > +static int az_blob_connect_to_vsp(struct hv_device *device, u32
> > > +ring_size) {
> > > +	int ret;
> > > +
> > > +	spin_lock_init(&az_blob_dev.file_lock);
> > > +	INIT_LIST_HEAD(&az_blob_dev.file_list);
> > > +	init_waitqueue_head(&az_blob_dev.file_wait);
> > > +
> > > +	az_blob_dev.device =3D device;
> > > +	device->channel->rqstor_size =3D AZ_BLOB_QUEUE_DEPTH;
> > > +
> > > +	ret =3D vmbus_open(device->channel, ring_size, ring_size, NULL, 0,
> > > +			 az_blob_on_channel_callback, device->channel);
> > > +
> > > +	if (ret)
> > > +		return ret;
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
> > > +			 const struct hv_vmbus_device_id *dev_id) {
> > > +	int ret;
> > > +
> > > +	ret =3D az_blob_connect_to_vsp(device, AZ_BLOB_RING_SIZE);
> > > +	if (ret) {
> > > +		az_blob_err("error connecting to VSP ret=3D%d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	// create user-mode client library facing device
> > > +	ret =3D az_blob_create_device(&az_blob_dev);
> > > +	if (ret) {
> > > +		az_blob_err("failed to create device ret=3D%d\n", ret);
> > > +		az_blob_remove_vmbus(device);
> > > +		return ret;
> > > +	}
> > > +
> > > +	az_blob_dev.removing =3D false;
> >
> > This line seems misplaced.  As soon as az_blob_create_device() returns,
> > some other thread could find the device and open it.  You don't want th=
e
> > az_blob_fop_open() function to find the "removing"
> > flag set to true.  So I think this line should go *before* the call to
> > az_blob_create_device().
> >
> > > +	az_blob_info("successfully probed device\n");
> > > +
> > > +	return 0;
> > > +}
> > > +
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
> > I don't think this works as you have described.  While it will ensure t=
hat any
> > in-progress RCU read-side critical sections have completed (i.e., in
> > az_blob_fop_open() ), it does not prevent new read-side critical sectio=
ns
> > from being started.  So as soon as synchronize_rcu() is finished, anoth=
er
> > thread could find and open the device, and be executing in
> > az_blob_fop_open().
> >
> > But it's not clear to me that this (and the rcu_read_locks in
> > az_blob_fop_open) are really needed anyway.  If az_blob_remove_device()
> > is called while one or more threads have it open, I think that's OK.  O=
r is there
> > a scenario that I'm missing?
>=20
> I was trying to address your comment earlier. Here were your comments (1 =
- 7):
>=20
> 1) The driver is unbound, so az_blob_remove() is called.
> 2) az_blob_remove() sets the "removing" flag to true, and calls az_blob_r=
emove_device().
> 3) az_blob_remove_device() waits for the file_list to become empty.
> 4) After the file_list becomes empty, but before misc_deregister() is cal=
led, a separate thread opens the device again.
> 5) In the separate thread, az_blob_fop_open() obtains the file_lock spin =
lock.
> 6) Before az_blob_fop_open() releases the spin lock, az
> block_remove_device() completes, along with az_blob_remove().
> 7) Then the device gets rebound, and az_blob_connect_to_vsp() gets called=
, all while az_blob_fop_open() still holds the
> spin lock.  So the spin lock get re-initialized while it is held.
>=20
> Between step 4 and step 5, I don't see any guarantee that az_blob_fop_ope=
n() can't run concurrently on another CPU
> after misc_deregister() finishes. misc_deregister() calls devtmpfs_delete=
_node() to remove the device file from /dev/*,
> but it doesn't check the return value, so the inode reference number can =
be non-zero after it returns, somebody may still
> try to open it.

I'm no expert here, but once misc_deregister() finishes, I would expect tha=
t
any attempt to open the device with the assigned major:minor number will
fail.  However, existing opens may still be active.   So another thread cou=
ld still
have it open, but no new opens can be done.  As coded in this version of yo=
ur
patch, az_blob_remove() waits until all those existing opens have been clos=
ed,
so everything is clean once the wait is complete.   Of course, while waitin=
g
here, the threads with the open fd could try to start another operation
against the VSP, but the "removing" flag will prevent that.  So the only
access these threads will have is to the singleton az_blob_dev instance
and the list of open files.

But as noted previously, waiting here for the opens to be closed is
problematic because the wait could be arbitrarily long.  And there's
messiness if the device gets re-added later, because there's no
distinction between the old instantiation that a thread might still have
open vs. the new instantiation that you want to initialize fresh.  That's
where creating a new dynamic instance will solve any problems.

> This check guarantees that the code can't reference any driver's internal=
 data structures.
> az_blob_dev.removing is set so this code can't be entered. Resetting it a=
fter az_blob_create_device() is also for this
> purpose.
>=20
> >
> > > +
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
> > code, I'm concerned about waiting for all open files to be released in =
the case
> > of a VMbus rescind.  We definitely have to wait for all VSP operations =
to
> > complete, but that's different from waiting for the files to be closed.=
  The
> > former depends on Hyper-V being well-behaved and will presumably
> > happen quickly in the case of a rescind.  But the latter depends entire=
ly on
> > user space code that is out of the kernel's control.  The user space pr=
ocess
> > could hang around for hours or days with the file still open, which wou=
ld
> > block this function from completing, and hence block the global work qu=
eue.
> >
> > Thinking about this, the core issue may be that having a single static =
instance
> > of az_blob_device is problematic if we allow the device to be removed
> > (either explicitly with an unbind, or implicitly with a VMbus
> > rescind) and then re-added.  Perhaps what needs to happen is that the
> > removed device is allowed to continue to exist as long as user space
> > processes have an open file handle, but they can't perform any operatio=
ns
> > because the "removing" flag is set (and stays set).
> > If the device is re-added, then a new instance of az_blob_device should=
 be
> > created, and whether or not the old instance is still hanging around is
> > irrelevant.
>=20
> I agree dynamic device objects is the way to go. Will implement this.
>=20
> >
> > > +
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
> > > +	return vmbus_driver_register(&az_blob_drv);
> > > +}
> > > +
> > > +static void __exit az_blob_drv_exit(void) {
> > > +	vmbus_driver_unregister(&az_blob_drv);
> > > +}
> > > +
> > > +MODULE_LICENSE("Dual BSD/GPL");
> > > +MODULE_DESCRIPTION("Microsoft Azure Blob driver");
> > > +module_init(az_blob_drv_init); module_exit(az_blob_drv_exit);
> > > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > > index 705e95d..3095611 100644
> > > --- a/drivers/hv/channel_mgmt.c
> > > +++ b/drivers/hv/channel_mgmt.c
> > > @@ -154,6 +154,13 @@
> > >  	  .allowed_in_isolated =3D false,
> > >  	},
> > >
> > > +	/* Azure Blob */
> > > +	{ .dev_type =3D HV_AZURE_BLOB,
> > > +	  HV_AZURE_BLOB_GUID,
> > > +	  .perf_device =3D false,
> > > +	  .allowed_in_isolated =3D false,
> > > +	},
> > > +
> > >  	/* Unknown GUID */
> > >  	{ .dev_type =3D HV_UNKNOWN,
> > >  	  .perf_device =3D false,
> > > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h index
> > > d1e59db..ac31362 100644
> > > --- a/include/linux/hyperv.h
> > > +++ b/include/linux/hyperv.h
> > > @@ -772,6 +772,7 @@ enum vmbus_device_type {
> > >  	HV_FCOPY,
> > >  	HV_BACKUP,
> > >  	HV_DM,
> > > +	HV_AZURE_BLOB,
> > >  	HV_UNKNOWN,
> > >  };
> > >
> > > @@ -1350,6 +1351,14 @@ int vmbus_allocate_mmio(struct resource
> > **new, struct hv_device *device_obj,
> > >  			  0x72, 0xe2, 0xff, 0xb1, 0xdc, 0x7f)
> > >
> > >  /*
> > > + * Azure Blob GUID
> > > + * {0590b792-db64-45cc-81db-b8d70c577c9e}
> > > + */
> > > +#define HV_AZURE_BLOB_GUID \
> > > +	.guid =3D GUID_INIT(0x0590b792, 0xdb64, 0x45cc, 0x81, 0xdb, \
> > > +			  0xb8, 0xd7, 0x0c, 0x57, 0x7c, 0x9e)
> > > +
> > > +/*
> > >   * Shutdown GUID
> > >   * {0e0b6031-5213-4934-818b-38d90ced39db}
> > >   */
> > > diff --git a/include/uapi/misc/azure_blob.h
> > > b/include/uapi/misc/azure_blob.h new file mode 100644 index
> > > 0000000..f4168679
> > > --- /dev/null
> > > +++ b/include/uapi/misc/azure_blob.h
> > > @@ -0,0 +1,34 @@
> > > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only WITH
> > > +Linux-syscall-note */
> > > +/* Copyright (c) Microsoft Corporation. */
> > > +
> > > +#ifndef _AZ_BLOB_H
> > > +#define _AZ_BLOB_H
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/uuid.h>
> > > +
> > > +/* user-mode sync request sent through ioctl */ struct
> > > +az_blob_request_sync_response {
> > > +	__u32 status;
> > > +	__u32 response_len;
> > > +};
> > > +
> > > +struct az_blob_request_sync {
> > > +	guid_t guid;
> > > +	__u32 timeout;
> > > +	__u32 request_len;
> > > +	__u32 response_len;
> > > +	__u32 data_len;
> > > +	__u32 data_valid;
> > > +	__aligned_u64 request_buffer;
> >
> > Is there an implied 32-bit padding field before "request_buffer"?
> > It seems like "yes", since there are five 32-bit field preceding.
> > Would it be better to explicitly list that padding field?
> >
> > > +	__aligned_u64 response_buffer;
> > > +	__aligned_u64 data_buffer;
> > > +	struct az_blob_request_sync_response response; };
> > > +
> > > +#define AZ_BLOB_MAGIC_NUMBER	'R'
> > > +#define IOCTL_AZ_BLOB_DRIVER_USER_REQUEST \
> > > +		_IOWR(AZ_BLOB_MAGIC_NUMBER, 0xf0, \
> > > +			struct az_blob_request_sync)
> > > +
> > > +#endif /* define _AZ_BLOB_H */
> > > --
> > > 1.8.3.1

