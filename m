Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BE03B2000
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jun 2021 20:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhFWSHl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Jun 2021 14:07:41 -0400
Received: from mail-mw2nam12on2101.outbound.protection.outlook.com ([40.107.244.101]:30158
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229900AbhFWSHj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Jun 2021 14:07:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFAodHdhjDuWEC77jnDYWa68d01LSxA9pQFVXK1Hi7hZ0Ifg5mYyn6osVK3GYI6Xh1JS20hiyP9x07Vxw4rBshMqxdjBUh3vSte6VZBDak8Ne7WWcfXMBC9uJxEv0c1OeRjCyA7QK0oFb5APJNw1LwbRC315Ia6RlKYUaf3oogvefRYnLilXANl2oSLZBF3nzkqMgoQX1xLdjCSlsmgtrr0Ff4r+yJjAXV3FUE+oqUflKdbnZeXy4wzsipyuTzr/hQYh9ULCL5aWTYoZrXZHnZyNU6cAGdNXBAwXDPnXQkzfF8BG8QB7RG5xJ4A9HiiQl0fHBvc+eyuAbZmz0b293w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc4WlGOwXrmyi3PsDJuEmVLx5wOLAJZTQ8g9Hcn3vcc=;
 b=nbWt0ikhLB/GSVC6+gV5mRvq/F0GoYoZ9vikgmwFZrgEnEpMgv6WUsk5HKgtYd5bW5PIFySDJ21XBsTNrDxrNyve1an5dJbi/O9W/dxGm/x8q/tbvR1MQvvcMKPMpsMOsSkZtpGt5Ahmh4l+mRGtEXgdciwyrFiU7K2FxJaBp4IZTDlnnMKi4lLPu2LK55fiJ0sZURYTShAlE1PTRPPuaqMhhiMKZGgSK05MTYJqV3F9dH2Em9cNNWgrXT4z4w0049qMaMhjqzIbOjhKEzw8dUH3pXcUF45F7jgSVHo3eThP9IGxD6wBamgCmFytnumjg6c3IxWv4qnP/t2Hj4WANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc4WlGOwXrmyi3PsDJuEmVLx5wOLAJZTQ8g9Hcn3vcc=;
 b=DQI0EbLI92hgHHcDdUSeUWpwvSqD0fxMw7vCpbKHS+EqQg87MB5S9pAdRmOYQfYRWWN8dAjDRbYGY9wuO2iCdqsK3M+x3PCdKTLuBDrFvoYk+FG0b+T87b+YrFnHknYIpMZZ+lXk5jMA5Uoy+XrYQEuV8MYw+mx4DlZDeKB9WE8=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1365.namprd21.prod.outlook.com (2603:10b6:a03:10c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.5; Wed, 23 Jun
 2021 18:05:20 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::b56b:cd5f:3b00:1c52]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::b56b:cd5f:3b00:1c52%6]) with mapi id 15.20.4287.008; Wed, 23 Jun 2021
 18:05:20 +0000
From:   Long Li <longli@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH 1/2] Drivers: hv: vmbus: add support to ignore certain
 PCIE devices
Thread-Topic: [PATCH 1/2] Drivers: hv: vmbus: add support to ignore certain
 PCIE devices
Thread-Index: AQHXXAJI6six0p8y4EiEFEcGwGZhMqse2DMAgAMkPWA=
Date:   Wed, 23 Jun 2021 18:05:19 +0000
Message-ID: <BY5PR21MB1506B03095E341B0D3A691A9CE089@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1623114276-11696-1-git-send-email-longli@linuxonhyperv.com>
 <1623114276-11696-2-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB1593CD3B5D24099745AD1D21D70A9@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB1593CD3B5D24099745AD1D21D70A9@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3219d225-fde2-4811-87cb-ad1267ef32e9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-21T17:50:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b3e152f-de4f-4d7e-2a84-08d9367176bb
x-ms-traffictypediagnostic: BYAPR21MB1365:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR21MB13659EBC30DF8615AFB6A9DECE089@BYAPR21MB1365.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0hI7nSC3/wcdXGA8rQhJCuiibwRyr5wSjHbeNqbUx6nDw7+cDgievWjSzWmiN6UxzuLkj1xT92owFPuNI0mDFd9HkA8kBqs44Zhp093OpiVXjq+yToCGC48p2rii5N/W3tcMY9noSjlIBXmNdMn5f1j9TBxBIPKw7n+0E+aI3QU4a9ZXVLG9k3Nt5d/zR5H97lpLChUaibvDE5CBotV9lBsAQ5rgGcMVp+yzD6TYX094tjUmKng3HSwKu8giEY9zElQs/nAm+NVxhPMCgFNayG0IRUP8ZAIgcRHjcv/jR9yqChy1ie9u66FkcyINXBfM9raI3QRyKC2V0mTnOOhoZaIDmKLPulk73ixivSp4ft3YPyY4IKtvNsXQjt3U+aC4sAc/zEDJfqSp0XCg8SI41zeJ4ajFOTex51O7qoC4YuuDLCFAyJidoAJC3YhuMB/YM3c0fobxDKEAnbuZ/GergBPBGAxJJ75SXUI+vDDfojYJPfgSLw9/ySOsDxB/xgu87u0Q8a6JnL4BVw8i/11xqHCbxA2TjYMwB5rmbx149a07SGvqE5A0B83k5FPYbm7c929GUs4HZHYFT7bbJ7gD8R9D/hNuVF4XpGG1WOgFuelJ/NyhPn47t736y4dCHOvdUw6L7xljR8i7bE/NPwqOiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(64756008)(52536014)(66556008)(186003)(55016002)(4326008)(66476007)(9686003)(8676002)(107886003)(10290500003)(83380400001)(82960400001)(8990500004)(122000001)(7696005)(66946007)(110136005)(5660300002)(66446008)(8936002)(76116006)(478600001)(54906003)(71200400001)(82950400001)(316002)(26005)(38100700002)(2906002)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TuxzlQKL3JtrBGgmKwiz4uvJA8ASaChYwko3w0uxolch5JDtRT4xgozP0/yc?=
 =?us-ascii?Q?iwsjIV3whsS2DHxdgUmHRw5kqnN8KkTVrrFu3X8pLrFebmduNtEbR+yqceMg?=
 =?us-ascii?Q?16QPh58kvJ8DBvyRl4OvjmPC0CAeeu3OzB9rgOAoBvKGoTVRTMnVfe0MLXQD?=
 =?us-ascii?Q?hrF81affQAUC+bfFMcMCSKLXfscdrakFJqtkvy+AylVGnQFJRZUFvcQhI7GL?=
 =?us-ascii?Q?2FMMFd0EoggciMDJ02ywTW93o+xTDbJNNDod6bofMNKMdx4gO+j0NTvDZIT/?=
 =?us-ascii?Q?HcuE5gqq1a7l55b9MI7UviGLwQFCpJF86jQE51B7XQLNSrJ0Ytfl8jST6f2Q?=
 =?us-ascii?Q?rUV2KEdN2t7mqknlFsq+HKkhukYI0RyO2QTOGS9LOh9jd7UKwZotH39MFUsU?=
 =?us-ascii?Q?xHFBiTkgsB4tlVpAupfE2bK5FvdZZaj5QYXS9u/PhPWhPe3ckh0/hf+d/hL9?=
 =?us-ascii?Q?SM/S4htwLdmAsXv0Jw3286x/nqooTdhkSiktnJ/tW47oGxxZhuFqONGBHhJg?=
 =?us-ascii?Q?uGdqJy1zVB4u+mbj1zE74qZDV6IVa4dYnHAzZ3YYzQhjy5IzwNaSh3SGnFKz?=
 =?us-ascii?Q?m0fUQT50pIIZbVbYd8axx8wCio+6NTXv5XlGMCN/LBWBJ/YHb6brPFt9U3KC?=
 =?us-ascii?Q?H1SdMEsAQXKx7SIOvZ/tfC/YGKkG0qmuBcrVdsXYRDjyg8HNC45qx7X2G13b?=
 =?us-ascii?Q?YxBRORa5tzExTYd1iGY73ZzickZYJ8zTHNHO1yxp9RPt3BeC4Acx0W2fcoUU?=
 =?us-ascii?Q?dsCZv6IDIzG6q717vwejIirEkTeNJ9Jvb2AymfRUKPR/2oSSY5H1gDt0+bNX?=
 =?us-ascii?Q?A7vP7I45s2bxfHNJH3kNA7BxjbD0YTc8R8eV8YMKIOlu4ouLtmltEiLEhKgx?=
 =?us-ascii?Q?0Fg17MMk2Vg2p85Zy4TkmJL5fi0vgcLtSpkvAxmQgbhcv+FHpjquOu/qm3ys?=
 =?us-ascii?Q?nCImY+7UbVcBqCDGUUC0TLqb7I+NKyNAHvf/fSld7BkdCH6J2xilMm46uL4f?=
 =?us-ascii?Q?eky1B9abJ3zzdYbIs1JgSlSX/e5YQJIzAunPLleQrSZ9YAMEp99ug9Ym3Vz7?=
 =?us-ascii?Q?Nmf1DvBo7f+BAxoFHxZVxpWm+eqUC2HJn1aYR9fGgaHw7tBa7rBB28XKlKQp?=
 =?us-ascii?Q?1+8rWoZWiQBEhqxVwBECytQZYOCHfEMe/yBQBwaCA/2NIlT0XJLCKP2LHqm5?=
 =?us-ascii?Q?0KBpD4zlPQzSZRPp6wzNp4VR1t6lVO3XehdiGOpLwJdEO2mPOItQ8Dv7QysN?=
 =?us-ascii?Q?FkMbsBNhvtzRvsondV+NLh8zrLyao0QhFFo/17N9JLnbzrBfU0QiG9Sd6TfL?=
 =?us-ascii?Q?3kk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3e152f-de4f-4d7e-2a84-08d9367176bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 18:05:19.9065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMeg1pqyya8kwZP0chi6h2cT0wOw4kY9MO9RBPmDe3k2qIy/pjhICgJ7iKYL43oD5udUd5rZx0nY+/1fG0smhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1365
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [PATCH 1/2] Drivers: hv: vmbus: add support to ignore certai=
n
> PCIE devices
>=20
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent:
> Monday, June 7, 2021 6:05 PM
> >
> > When Hyper-v presents a FlexIOV device to VMBUS, this device has its
> > VMBUS channel and a PCIE channel. The PCIE channel is not used in
> > Linux and does not have a backing PCIE device on Hyper-v. For such
> > FlexIOV devices, add the code to ignore those PCIE devices so they are
> > not getting probed by the PCI subsystem.
> >
> > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > Cc: Wei Liu <wei.liu@kernel.org>
> > Cc: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/hv/channel_mgmt.c | 43
> > +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > index caf6d0c..6fd7ae5 100644
> > --- a/drivers/hv/channel_mgmt.c
> > +++ b/drivers/hv/channel_mgmt.c
> > @@ -26,6 +26,20 @@
> >
> >  static void init_vp_index(struct vmbus_channel *channel);
> >
> > +/*
> > + * Hyper-v presents FlexIOV devices on the PCIE.
> > + * Those devices have no real PCI implementation in Hyper-V, and
> > +should be
> > + * ignored and not presented to the PCI layer.
> > + */
> > +static const guid_t vpci_ignore_instances[] =3D {
> > +	/*
> > +	 * XStore Fastpath instance ID in VPCI introduced by FlexIOV
> > +	 * {d4573da2-2caa-4711-a8f9-bbabf4ee9685}
> > +	 */
> > +	GUID_INIT(0xd4573da2, 0x2caa, 0x4711, 0xa8, 0xf9,
> > +		0xbb, 0xab, 0xf4, 0xee, 0x96, 0x85), };
> > +
> >  const struct vmbus_device vmbus_devs[] =3D {
> >  	/* IDE */
> >  	{ .dev_type =3D HV_IDE,
> > @@ -487,6 +501,16 @@ void vmbus_free_channels(void)
> >  	}
> >  }
> >
> > +static bool ignore_pcie_device(guid_t *if_instance) {
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(vpci_ignore_instances); i++)
> > +		if (guid_equal(&vpci_ignore_instances[i], if_instance))
> > +			return true;
> > +	return false;
> > +}
> > +
> >  /* Note: the function can run concurrently for primary/sub channels.
> > */  static void vmbus_add_channel_work(struct work_struct *work)  { @@
> > -958,6 +982,17 @@ static bool vmbus_is_valid_device(const guid_t *guid)
> >  	return false;
> >  }
> >
> > +static bool is_pcie_offer(struct vmbus_channel_offer_channel *offer)
> > +{
> > +	int i;
> > +
> > +	for (i =3D HV_IDE; i < HV_UNKNOWN; i++)
> > +		if (guid_equal(&offer->offer.if_type, &vmbus_devs[i].guid))
> > +			break;
>=20
> This would be the third place in channel_mgmt.c that we have essentially =
the
> same code for looking through the vmbus_devs array for a matching GUID.
> See hv_get_dev_type() and vmbus_is_valid_device().
> Perhaps do some minor refactoring to have a common search function that
> return a pointer to the matching entry in the vmbus_devs array?  The code
> would have to handle the "no match"
> case by pointing to the last entry (HV_UNKNOWN).
>=20
> > +
> > +	return i =3D=3D HV_PCIE;
>=20
> This assumes that the index in the vmbus_devs array is the same as
> the .dev_type field of the entry.  That's true at the moment, but seems a=
 bit
> brittle in the long run.
>=20
> > +}
> > +
> >  /*
> >   * vmbus_onoffer - Handler for channel offers from vmbus in parent
> partition.
> >   *
> > @@ -1051,6 +1086,14 @@ static void vmbus_onoffer(struct
> > vmbus_channel_message_header *hdr)
> >  		return;
> >  	}
> >
> > +	/* Check to see if we should ignore this PCIe channel */
> > +	if (is_pcie_offer(offer) &&
> > +	    ignore_pcie_device(&offer->offer.if_instance)) {
> > +		pr_info("Ignore instance %pUl over VPCI\n",
> > +			&offer->offer.if_instance);
>=20
> I'm wondering if we really want to output this message.   As
> Hyper-V is updated to support this new blob access method, it seems like
> pretty much every VM will generate the message on boot, and I don't see
> any real value in it.  Maybe make it debug level?
>=20
> > +		return;
> > +	}
> > +
>=20
> Is there a reason to do this check *after* searching for the oldchannel a=
nd
> handling a match?  I'm thinking this check could go immediately after the=
 call
> to trace_vmbus_onoffer().
>=20
> >  	/* Allocate the channel object and save this offer. */
> >  	newchannel =3D alloc_channel();
> >  	if (!newchannel) {
> > --
> > 1.8.3.1

I'm sending v2 to address all the comments.
