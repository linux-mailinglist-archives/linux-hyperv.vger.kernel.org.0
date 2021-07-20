Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213EC3D026A
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 21:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhGTTR6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 15:17:58 -0400
Received: from mail-co1nam11on2101.outbound.protection.outlook.com ([40.107.220.101]:63328
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232651AbhGTTRV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 15:17:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKn+0HvNxEdIjd+enMN7rsk+1vzGxczKNHaUeTpxpoUcW1g3dHgbkjwTqHGwMJLVolaNQsGA0WdNGmU3LSHMVxYcfTTCbO+LRZ4RsfhmCUdpCS3sreqsiAN4IrlW9PldCn9FfGx9bEr828uMiTw1Ac42Oz09b2eEJSvpwPKneBJrxPEGMlTTdHB+F5cAkAdLX3CNGc4/zVFInJZJZ1PnnzoQnGA/PXaCS4ZPol+66y5ELO8NKotTdLqKI1z6XgooErhU+O+FcqtUPPzeFQt/LKCpeNiNIgOS4uelhcYdY0zxlJi4juAW9v+FAfPQ8xRQX6DsTRWVqvuxncYibODwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uep3EcUdTb9ly/X40p8qPcAK85TnOT7TC57JmNA4EhE=;
 b=i85bs8lOiN0aIcfpV9Y8H+FqZeRWRI8FCIaaw4K/dLCXJJi/7EZ7YqoGzrX1tsO4j4CP9OVN1yVLeerihwi0LyLIqVKLBoAkzezSVno/j2/BJep253xWnYHCdjYyv68hBIESquV7x/DrBdUp99nbiXJF+/I4qqBqQrXWn8wOh/mnQufJ7I3bPukOI2d7tl14M9nokGQQbAqAKVdVmcrpyrVNbML74mS5Xy7WCrh4y8idGSZXOe2/m7q0H7m3dukLCUPzjjskDJfvXPPepvSDeWOZDs4AWknOSM12nfINbi98s6ddCy7CMu3U1CJzQLSmgEvFO65LrTRPFnjEK3LGjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uep3EcUdTb9ly/X40p8qPcAK85TnOT7TC57JmNA4EhE=;
 b=WVFrFXgrNNAWP4mt9K03OEw898eRqwVz+LN5LGRBpWHY5/QjU05kjDifEN3QTaAzJ9IwcuMXAo76oYygCl99Y7Kec2ueMN1Lymo/mp4Ik2KBNWboY9j2uc5lfjwFX+QKGagTccZIwCM1nnx01L7WOrSU8c/AlzD2v4w8gx/Q/ao=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1144.namprd21.prod.outlook.com (2603:10b6:a03:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.5; Tue, 20 Jul
 2021 19:57:56 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d97f:36c9:1b1:5d07]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d97f:36c9:1b1:5d07%8]) with mapi id 15.20.4373.006; Tue, 20 Jul 2021
 19:57:56 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     "linux-fs@vger.kernel.org" <linux-fs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
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
Subject: RE: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXfRfGpWx8JX5XBkGm4J8f9X8COatLeSmAgADAw3A=
Date:   Tue, 20 Jul 2021 19:57:56 +0000
Message-ID: <BY5PR21MB1506A52AD22240E22A0D6DE5CEE29@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <1626751866-15765-3-git-send-email-longli@linuxonhyperv.com>
 <YPZ8hX7sx1RFL0c5@kroah.com>
In-Reply-To: <YPZ8hX7sx1RFL0c5@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=71fcdba0-7845-415a-8462-058cb3c8de43;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-20T19:04:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f85d8175-570c-4c45-1382-08d94bb8ab44
x-ms-traffictypediagnostic: BYAPR21MB1144:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB1144951860F7B3C03B5FBF3ACEE29@BYAPR21MB1144.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NRjYULmYVGM8Z2rMHlXpxEdcg+4lIiI8OI9S4PCXV61Dj4GOTzJr532TSkDHV/nZdOf7x7s6DTQlc22bPX5ito/+p49aYYCUOTR5rlcrRxB/9abOVyEakWLS9jnk7J19lVgS+3PS/hhgELwNjZeMHHY8A+A89BECn44uHfFz0MSkqEBBER/vrhTydbi70PnpOK4RR02dvQio3jUMM6p/uhDfcimHp4NATIv5jewNBziQrjqUJ1Efbf1zgIyZDRSpm+iKixvUTFvj9D1W22jzQFc9J1BC90tEttOjI7ujK8vwelaLgcXUD2iiojSYtqXDxwk0v9wVTizRWv+SY2VYyGVjE/yOkC1TBUt/28jGXLY9PB0mM6juB38NM/DNzTRfU1BGs9jLYPWbZkKz4Q/QQ96AnUkzBwWXFCpylq8G9yHXHjq+Eu0KG+VBiNyI4K8yLXIgb8KYUWN3zNE9zmcATmdaHN0v5SJYwkkNZDOCmv/b9jT0O4kWmD84A9KgYZnC3YrDi0cMvjGlg3XSbfHkWI1o4+imYZaCcGa7p+4cjB72OZi1T4C6l2e7ctJyvkvQSiVY0eP+P1CsUwIRL5KfTB6J+zKRrww02/gAqpZtc8otId3hnvTm4ndthkvrzDZnn1mghy+02EjundxPx9bab1HAkBhgzZBM40+VPqqgIqIZiyj3PhjyMCjoB5WdCEg7eIBtlrr2DkkFiiUHxhQPUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(86362001)(8990500004)(76116006)(508600001)(7696005)(8676002)(83380400001)(26005)(186003)(82960400001)(8936002)(82950400001)(52536014)(66556008)(7416002)(9686003)(4326008)(66476007)(316002)(66446008)(54906003)(64756008)(38100700002)(122000001)(110136005)(66946007)(5660300002)(10290500003)(6506007)(71200400001)(2906002)(33656002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G5V9MlLUf5ojADCUsKwWIjJ4yeFbrqE6+t8HTzoj7Er5cjSIPeKZSSV3Clw2?=
 =?us-ascii?Q?tbiEW/bJUk4aLHLZvx1xXfWwPNI8L7NC8XZdkok0Z+1U9ihQmqGXg/FZ7h0o?=
 =?us-ascii?Q?7gG6tVAuioZDiiKu+M5zWVwCjR73zWD+1C4+quoP8EpvXEv+6wEvQnTiddKM?=
 =?us-ascii?Q?NqIGKMRIKMsmxodoq5GnDao3eGj+4H1hqElfkLiK678TlSNSJkzZqWbrBhCQ?=
 =?us-ascii?Q?kfJk8alvN1aV77/MIXpXPoPwyX4WXZk2eUwFWG+oNckfdVHBaRbAbuf4Y/nV?=
 =?us-ascii?Q?WfV9lq9Lnwqg02CcNHXN22/O3WP342xVQeuL0/y8tq/br8KlSVjDV6jGI4eY?=
 =?us-ascii?Q?/LwoFrFdOnQfdNOmxg/hyHURsURNchd7vPG+cvzPEzz2oYPUvusKF8OOy3rF?=
 =?us-ascii?Q?4OQIfrPRKuiFPoDRWF6AvkjJUlVQ+snLfcTn2bE3YWZHXsn8vOJFABe/F8ZJ?=
 =?us-ascii?Q?j2uAp9c8BSJh8qvM9RV59DOIH1ZPrzCYk1HGYFJn/SsqXvu2Xf2nVXHwb0TE?=
 =?us-ascii?Q?YFGjFF9YysOt+G6CZyK76vIlZBC7ghvFW0u2iuypf8UqpcWAr7AiEB8WY+e7?=
 =?us-ascii?Q?Rh4NK4PPK71Tj0u76Cmqj2TZ8yqTQvIY36ocdgsqn+HIQeBArFbffHWcZc2B?=
 =?us-ascii?Q?xnXrJQWI15Lelyxo3RTJ7GbpdWRb2HBybQ1eLz3r6HdyNgrNoYKB2VlEi/AP?=
 =?us-ascii?Q?uXcL4IfhJ4K/kEk5ibMRgRna+3JGZ0Iaf0FrJNz4OpmJ2drqtnDgImKfmWkt?=
 =?us-ascii?Q?8QHJnTw/tRAMBjtsilXiSCTF+iW5Dnwy6MF/7QLiVluPiQTx00t6S6QG4bMH?=
 =?us-ascii?Q?P0po3yifPftsDiad6tkEgfWvymLTm8G2bqgE0MhR6XzaHyA62xyQ9k4sbzGK?=
 =?us-ascii?Q?TooQT/JYDdaEj1pyQhBqcBfT2QAg2DYF/2gQxyVxaDnqoSrIGfqT7aveiV0l?=
 =?us-ascii?Q?SCQIFkVVmusHnCrBNLLbpNOG8DSQdwfdNTy3ZtxjtEhZQp1H/Oxy2Rlan0kh?=
 =?us-ascii?Q?jyLSmIM7TU0TnHFG1ePer5HAL8VZ4DqZlf+JxiWlobYCpEZ6Bdk5E+Gj1w0t?=
 =?us-ascii?Q?K4c+B7IjPtTVnVruPX1RQ8VRrEXs3doH8hIy8kogiR/6KIOXcRt8w4LiH/F1?=
 =?us-ascii?Q?ES282h//atM99xUwHdIYFB33lK3PkKcbcosI+oLfnqPue3E1qn8xiTB6C/4P?=
 =?us-ascii?Q?LeMF8/O1x/IJUUWhj5coLSOX6vv6WzHm/KWd8Er5yswjrUH3n47a1Hagbdm/?=
 =?us-ascii?Q?/ZDg7EdoePCUhSx9xIS1CkIxHJEV/uiitpsDZr2LaZTduUCpOTuhB4y2YJTP?=
 =?us-ascii?Q?nQs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85d8175-570c-4c45-1382-08d94bb8ab44
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 19:57:56.7553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OvuMpQ6Jhq+plSadNfFBWJFfLEOhcoPqJ1FIe2crE+KO19sJdbuNGj+hnVh4jUfmj6vusc1t2NMgOKFS+Qb4xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1144
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
>=20
> On Mon, Jul 19, 2021 at 08:31:05PM -0700, longli@linuxonhyperv.com wrote:
> > +struct az_blob_device {
> > +	struct hv_device *device;
> > +
> > +	/* Opened files maintained by this device */
> > +	struct list_head file_list;
> > +	/* Lock for protecting file_list */
> > +	spinlock_t file_lock;
> > +
> > +	/* The refcount for this device */
> > +	refcount_t count;
>=20
> Just use a kref please if you really need this.  Are you sure you do?
> You already have 2 other reference counted objects being used here, why m=
ake
> it 3?

The "count" is to keep track how many user-mode instances and vmbus instanc=
e
are opened on this device. Being a VMBUS device, this device can be removed=
=20
at any time (host servicing etc). We must remove the device when this happe=
ns
even if the device is still opened by some user-mode program. The "count" w=
ill
guarantee the lifecycle of the device object after all user-mode has releas=
ed the device.

I looked at using "file_list" (it's used for tracking opened files by user-=
mode) for this purpose,=20
but I found out I still need to manage the device count at the vmbus side.=
=20

>=20
> > +	/* Pending requests to VSP */
> > +	atomic_t pending;
>=20
> Why does this need to be atomic?

"pending' is per-device maintained that could change when multiple-user acc=
ess
the device at the same time.

>=20
>=20
> > +	wait_queue_head_t waiting_to_drain;
> > +
> > +	bool removing;
>=20
> Are you sure this actually works properly?  Why is it needed vs. any othe=
r misc
> device?

When removing this device from vmbus, we need to guarantee there is no poss=
ible packets to
vmbus. This is a requirement before calling vmbus_close(). Other drivers of=
 vmbus follows
the same procedure.

The reason why this driver needs this is that the device removal can happen=
 in the middle of
az_blob_ioctl_user_request(), which can send packet over vmbus.

>=20
>=20
> > +/* VSC->VSP request */
> > +struct az_blob_vsp_request {
> > +	u32 version;
> > +	u32 timeout_ms;
> > +	u32 data_buffer_offset;
> > +	u32 data_buffer_length;
> > +	u32 data_buffer_valid;
> > +	u32 operation_type;
> > +	u32 request_buffer_offset;
> > +	u32 request_buffer_length;
> > +	u32 response_buffer_offset;
> > +	u32 response_buffer_length;
> > +	guid_t transaction_id;
> > +} __packed;
>=20
> Why packed?  If this is going across the wire somewhere, you need to spec=
ify
> the endian-ness of these values, right?  If this is not going across the =
wire, no
> need for it to be packed.

Those data go through the wire.

All data structures specified in the Hyper-V and guest VM use Little Endian=
 byte
ordering.  All HV core drivers have a dependence on X86, that guarantees th=
is
ordering.

>=20
> > +
> > +/* VSP->VSC response */
> > +struct az_blob_vsp_response {
> > +	u32 length;
> > +	u32 error;
> > +	u32 response_len;
> > +} __packed;
>=20
> Same here.
>=20
> > +
> > +struct az_blob_vsp_request_ctx {
> > +	struct list_head list;
> > +	struct completion wait_vsp;
> > +	struct az_blob_request_sync *request; };
> > +
> > +struct az_blob_file_ctx {
> > +	struct list_head list;
> > +
> > +	/* List of pending requests to VSP */
> > +	struct list_head vsp_pending_requests;
> > +	/* Lock for protecting vsp_pending_requests */
> > +	spinlock_t vsp_pending_lock;
> > +	wait_queue_head_t wait_vsp_pending;
> > +
> > +	pid_t pid;
>=20
> Why do you need a pid?  What namespace is this pid in?

It's a request from user library team for production troubleshooting
purposes. It's exposed as informal in debugfs.

>=20
> > +static int az_blob_probe(struct hv_device *device,
> > +			 const struct hv_vmbus_device_id *dev_id) {
> > +	int ret;
> > +	struct az_blob_device *dev;
> > +
> > +	dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
> > +	if (!dev)
> > +		return -ENOMEM;
> > +
> > +	spin_lock_init(&dev->file_lock);
> > +	INIT_LIST_HEAD(&dev->file_list);
> > +	atomic_set(&dev->pending, 0);
> > +	init_waitqueue_head(&dev->waiting_to_drain);
> > +
> > +	ret =3D az_blob_connect_to_vsp(device, dev, AZ_BLOB_RING_SIZE);
> > +	if (ret)
> > +		goto fail;
> > +
> > +	refcount_set(&dev->count, 1);
> > +	az_blob_dev =3D dev;
> > +
> > +	// create user-mode client library facing device
> > +	ret =3D az_blob_create_device(dev);
> > +	if (ret) {
> > +		dev_err(AZ_DEV, "failed to create device ret=3D%d\n", ret);
> > +		az_blob_remove_vmbus(device);
> > +		goto fail;
> > +	}
> > +
> > +	dev_info(AZ_DEV, "successfully probed device\n");
>=20
> When drivers are working properly, they should be quiet.

The reason is that in production environment when dealing with custom suppo=
rt
cases, there is no good way to check if the channel is opened on the device=
. Having
this message will greatly clear confusions on possible mis-configurations.

>=20
> And what is with the AZ_DEV macro mess?

It's not required, it's just for saving code length. I can put "&az_blob_de=
v->device->device"
in every dev_err(), but it makes the code look a lot longer.

>=20
> And can you handle more than one device in the system at one time?  I thi=
nk
> your debugfs logic will get really confused.

There can be one device object active in the system at any given time. The =
debugfs grabs
the current active device object. If the device is being removed, removed o=
r added,=20
the current active device object is updated accordingly.

>=20
> thanks,
>=20
> greg k-h
