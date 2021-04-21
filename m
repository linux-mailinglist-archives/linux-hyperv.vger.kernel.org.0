Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797FE367498
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Apr 2021 23:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245718AbhDUVGV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Apr 2021 17:06:21 -0400
Received: from mail-mw2nam10on2097.outbound.protection.outlook.com ([40.107.94.97]:36225
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243828AbhDUVGV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Apr 2021 17:06:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYjhAQJlmJiRLERDYfOTF8Hj6Xn44e4P6ceAN3Mwt2IBtrKZi411hDe1sZsvTl32972EWj5+Dpj/TsIhb6M4UJcvIaXJ3avV1+ZyFlAqEoDiZ8QV3+uV/vik/vqxG/4V4Coha4QoEA07S84w44ra5h9pvQFi/35yLHFfl6xPoiZLCpSGYHtTZMVoUyMLohyBsX/FmPlpspnaUQHoGE74hMQf5camr9p9qrlcG96aSpotsGWRbNht7lMNKQGHeqEp61R3G7QYB2nBmdgiqVBmQtgYLc5ITzDlA2YwBUtQcewcgITTbmJ5QFYU67/CWpljk6MJkyzPhgWkrvAp7tsaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBgZyUszv1UCVVSmPI/s4+z47buSFS4FVyKS5KuBVj8=;
 b=TnWS/lHI/beyWITIpkL6Y0wEncDtHV4qp7EaB0U796KYUM+BwznZr9VfhVIBQIiT43zWWJt4QRAPfxwCx9CaKLaUUn8vXLi9sG+SzRcFhjUb4mCaAjcvBFQjAGJN2GD4dggNigNf0sz9zQ7JjFnKQQOZHcFLkyEJh7RzSZPk4vTzGozdh5+b+8WUf7vH2f8OBegGm/y+KNZisc2PHXmEHwfBivO8gHIAMkOEyl45Z3D/sPVhny3lUo+N8CkbIk5zAhc4PzkYLronX6saDV3rtNIH7Z9Tcia/DkVFg/OEsT15kV9jM4Erk+okPy8VJ10/ooRvDDc228x0ahHENOst6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBgZyUszv1UCVVSmPI/s4+z47buSFS4FVyKS5KuBVj8=;
 b=aIu4V1bZSHqJrGJ5tTWQOnh/4Z9A3Tn7dlqhD/ddzCE5HpBVC3BMPwomKkf5tg+q/Tssi6YNJ8ZKxqpBm3pACfcDdn3RkbSEKWYdCOzZYjMZe6w9QXxkDkCzCPUqH1IIKKlZ+fCX2MUwi+7Eo/IaBO8G1wbphrgFY274dKsL+AA=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1970.namprd21.prod.outlook.com (2603:10b6:303:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.9; Wed, 21 Apr
 2021 21:05:46 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%5]) with mapi id 15.20.4087.016; Wed, 21 Apr 2021
 21:05:46 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Long Li <longli@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Fix a race condition when removing the device
Thread-Topic: [PATCH] PCI: hv: Fix a race condition when removing the device
Thread-Index: AQHXNVHtsv1pPhn/lUymN/4kjb1Ps6q/O9jQgAAqeACAABF+EA==
Date:   Wed, 21 Apr 2021 21:05:46 +0000
Message-ID: <MWHPR21MB15933F28861A2C448C3F233DD7479@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1618860054-928-1-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB1593CAEAFB8988ECB93BE6E3D7479@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BYAPR21MB12711AF8B782FAA4B492D0CFCE479@BYAPR21MB1271.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB12711AF8B782FAA4B492D0CFCE479@BYAPR21MB1271.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0c2cd82d-a9ce-4184-9a5b-6c1855cc9093;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-21T17:24:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [8.46.73.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4a1995f-3379-4990-cc60-08d905093bc0
x-ms-traffictypediagnostic: MW4PR21MB1970:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB197097B9F204BEC6A512ECAAD7479@MW4PR21MB1970.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iei+qwveFsrkT5Pfmyxtx9SbI0Y4QK4pJk11Ds5aOzhFZ5wmzxQzdUXq81Wcr7JAnkJEmDTISDG82mN3oyTGUfADDSPOCowj7dUwbj3rfkh20q8h/k4siXl4r9W8qIXfam58KM8upa6JDbRoKEBSViyvjHtAfWTZ6UPQ0uXHxy5hkz9Sq8xm/vIfTt3UooBreTwC2vNNjLScLjOlAXhH6J7U3x0MdTeeoU1HJkJtjbetPxPpsCUphC+YqU68bUOM46TNLNZuOW3p82bKAO+sH71uW3VwMsiICMhsAz3PF031quKUAtPejOT10/otakJhEcOX8v/P9agAgf/KC2yW6taaGPcyi599/4HamnIyup/oEsg97XDzpojcifP2UQnDWxIafZuimldzITHYaXK3vXzw1ZxaFv7w8/P8ipWBbPe7XD1ZOhYB1nI84zRVIzbkuwvSOxPkhWTNaf6+FFob4SQ5jiGJmhqbQtWHZc8yl7b/cpmDltdqH/CIXKVxUYgV8ERJjZljxpY5Kec/pYCVCxJu4QbR4iuBYGiyTjAq0+oe3riGSRW9qIHkyY7pmsCH8efM1luZ/q5Oci3ePmklE0Ps4wgAoZnhO4dFYhpZFwwOqKhz3raLKiz5HzYpQ6YMPY1IIQRGzjLAXxP3/17jAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(76116006)(64756008)(110136005)(7696005)(316002)(66556008)(2906002)(66446008)(9686003)(6636002)(10290500003)(82960400001)(82950400001)(55016002)(66476007)(83380400001)(33656002)(66946007)(6506007)(921005)(8990500004)(38100700002)(186003)(5660300002)(8936002)(86362001)(8676002)(122000001)(26005)(478600001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?o0CvNKdfPDPV1aGu0+5kCTeEpLhunKWGzK8RJAzDuXC07XuztBmda9w2grYe?=
 =?us-ascii?Q?a2ftI7f5pomp5sTFfVo5zh9JnG25r+mSQnklU+EP5EbZlAhCPMLY/FMlSpzU?=
 =?us-ascii?Q?lyreaOcyaFhiAK5vsFv4BDUzptHdQBiGOtJlWSbYoTqoGv7AY4kJe4hbT+kP?=
 =?us-ascii?Q?ZYcuMa67Hb6ZgJ6JdT3TpUUbAS2DrM3v2jOR0zHDDRykNz7WvyYKX3PzJGLs?=
 =?us-ascii?Q?0vN7G4QgEkQvEkXJcJHZQhTB9twm1hPT3v45UoIemNtAUEvzueORW1vzNBHt?=
 =?us-ascii?Q?EHAI+O8ovoXpgC+0rpBgLQzfjI5Y6fyZUmgx85tdgHEVZpvQzNIV7O1DZhEf?=
 =?us-ascii?Q?E+KMW7lcwcf6uwEDGnSYQwE5ahxZT+p0Qq6ZbKoHeRIcNQF2Vx6athzLyZaW?=
 =?us-ascii?Q?FwFLNuJAeTsDPORejFCfcQkbN7hbgz3UxlJe9nEBivL3epl6Ttb0/5jtU8wO?=
 =?us-ascii?Q?FzwnfZHfQiPm7EtLUZxEVqFccEa/ko45GRC8hIANe4/aloyGJsqYzGt7CYju?=
 =?us-ascii?Q?UrrSEVOTmz3iSZm2CwRrZnqS3Cu51/i4sGH7Jw0z9RI7kjugfOkLyINhUQLw?=
 =?us-ascii?Q?68pFpJ5gnonGNxmFv6BnOPEE02Bu+IaBI0mT4nRzEJjbdsGnZ4Dvc0JXxcAf?=
 =?us-ascii?Q?daxtWpyct4XiUNVguW2kOyWaCmFcHjnq1+dzvYd+3YnmAqW6eG3Dl4LufLKa?=
 =?us-ascii?Q?ZkD5Ie4lRLirsHk2RrL+O+magAMtdxOBYGgETGsjO8yDcalUJnZoaTJbg+VL?=
 =?us-ascii?Q?a6eKM0zqJYsVdJntvGHpNQq8arpK2f2S3DwJ7bgD1wpH0irGIKY0npMf2DwF?=
 =?us-ascii?Q?3gXEj0MNB8I5DL+dpUDJum1Ej9c+b/14KupThmUlP/MUP3+z4R0WAykS4KOV?=
 =?us-ascii?Q?RTiwnTRkrLYmPIFReNsK+w/JQQIl+5CC9hFVUqVtlHGJWKi2JQwZ9TEjVNie?=
 =?us-ascii?Q?q2P5XsYxWeE4vwCfaYsFCn2IvtEvQIn3QdkcbzZnNtUFpsSKJQNz2CFw4bB2?=
 =?us-ascii?Q?9gobGU9k/H6lAj2q//ge1fvQwaSbjYvaFc1J6iE4YYl2VkS6JFHaB97fB+/+?=
 =?us-ascii?Q?EdO/nantHff80S9ZMWBpyTMtQuBfoTd7JqjOdhSC1BVo/CxUksivMftPLuK+?=
 =?us-ascii?Q?xPlInEcBdTOTzWWpU8wXWc6WmHbLEdkXin2Rm6Kwulhet439KW4e+J7M8CBO?=
 =?us-ascii?Q?KfR59g/AGCBNSBTYrKKxlYwru1TGouLpP1VsF4hhxokqlhJboRmKY3oRm7pg?=
 =?us-ascii?Q?szlpGUr9G4o2icZ7Wc5clORVBmfDG1DMB/yapXcyo0TgISrWIaG5AtI6SpLh?=
 =?us-ascii?Q?dKs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a1995f-3379-4990-cc60-08d905093bc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 21:05:46.3862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yU/h4rzG5kzNkRhBbJcejdOLe1eIWZ3RS6WIoCZTCxXS6GKppuFAXEFXOcSVFIVQyf8e/Z593uY/XxxV21emsTlMzK4TJXETaT72pK2Dqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1970
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com> Sent: Wednesday, April 21, 2021 12:57 =
PM
> > From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>  Sent:
> > Monday, April 19, 2021 12:21 PM
> > >
> > > On removing the device, any work item (hv_pci_devices_present() or
> > > hv_pci_eject_device()) scheduled on workqueue hbus->wq may still be
> > > running and race with hv_pci_remove().
> > >
> > > This can happen because the host may send PCI_EJECT or
> > > PCI_BUS_RELATIONS(2) and decide to rescind the channel immediately
> > after that.
> > >
> > > Fix this by flushing/stopping the workqueue of hbus before doing hbus
> > remove.
> >
> > I can see that this change follows the same pattern as in hv_pci_suspen=
d().
> > The comments there give a full explanation of the issue and the solutio=
n.  But
> > interestingly, the current code also has a reference count mechanism on=
 the
> > hbus.  And code near the end of hv_pci_remove() decrements the referenc=
e
> > count and then waits for all users to finish before destroying the work=
queue.
> > With this change, is this reference counting mechanism still needed?   =
If the
> > workqueue has already been emptied, it seems like the
> > wait_for_completion() near the end of hv_pci_remove() would never be
> > waiting for anything.  It makes me wonder if moving the reference count
> > checking code from near the end of hv_pci_remove() up to near the begin=
ning
> > would solve the problem as well (and maybe in hv_pci_suspend also?).
>=20
> Yes I think put_hvpcibus() and get_hvpcibus() can be removed, as we have =
changed to use
> a dedicated workqueue for hbus since they were introduced.
>=20
> But we still need to call tasklet_disable/enable() the same way hv_pci_su=
spend() does, the
> reason is that we need to protect hbus->state. This value needs to be con=
sistent for the
> driver. For example, a CPU may decide to schedule a work on a work queue =
that we just
> flushed or destroyed, by reading the wrong hbus->state.
>=20

Yes, I would agree the tasklet disable/enable are needed, especially since =
tasklet_disable()
is what ensures that the tasklet is not currently running.

If the hbus ref counting isn't needed any longer, I would strongly recommen=
d adding
a patch to the series that removes it.  This synchronization stuff is hard =
enough to
understand and reason about; having a leftover mechanism that doesn't reall=
y do
anything useful makes it nearly impossible. :-)

Dexuan -- I'm hoping you can take a look as well and see if you agree.

Michael

> >
> > Michael
> >
> > >
> > > Signed-off-by: Long Li <longli@microsoft.com>
> > > ---
> > >  drivers/pci/controller/pci-hyperv.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/pci-hyperv.c
> > > b/drivers/pci/controller/pci-hyperv.c
> > > index 27a17a1e4a7c..116815404313 100644
> > > --- a/drivers/pci/controller/pci-hyperv.c
> > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > @@ -3305,6 +3305,17 @@ static int hv_pci_remove(struct hv_device
> > > *hdev)
> > >
> > >  	hbus =3D hv_get_drvdata(hdev);
> > >  	if (hbus->state =3D=3D hv_pcibus_installed) {
> > > +		tasklet_disable(&hdev->channel->callback_event);
> > > +		hbus->state =3D hv_pcibus_removing;
> > > +		tasklet_enable(&hdev->channel->callback_event);
> > > +
> > > +		flush_workqueue(hbus->wq);
> > > +		/*
> > > +		 * At this point, no work is running or can be scheduled
> > > +		 * on hbus-wq. We can't race with hv_pci_devices_present()
> > > +		 * or hv_pci_eject_device(), it's safe to proceed.
> > > +		 */
> > > +
> > >  		/* Remove the bus from PCI's point of view. */
> > >  		pci_lock_rescan_remove();
> > >  		pci_stop_root_bus(hbus->pci_bus);
> > > --
> > > 2.27.0

