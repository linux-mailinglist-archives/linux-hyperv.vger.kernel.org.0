Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6C5801C4
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2019 22:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392051AbfHBUbn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Aug 2019 16:31:43 -0400
Received: from mail-eopbgr1310100.outbound.protection.outlook.com ([40.107.131.100]:6272
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728855AbfHBUbm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Aug 2019 16:31:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjL9SJ554zyYkvJFlyPlQ52+w527RFfKdSfZwSQhGz1fZbkj3zRKw36WV9xXFAIbVJ2ICNbaLnwX+wYA9aHWglC30NK28LGf58/nFeTI8kkaK6KNGuGHnuVLaRRyg20CXycjN0SfB13JfV7xfh7U9Pm/fbbUDf8NTn0Kay3Jit+vMuH6XmGxi2nGLbaIgyondZTMPbM/fSkEJOs/NlWhOj6sM5q3sWdyLD3DsoKGXgks4oI8CrtSzFyJDMrpfjDdYxZoynUGG76CsmystF3QE1qAPBEMl4FAINe8DNBIEMmKT4ZwqF/qqby8jvlUJ6gQzwAGzMUElNyAS6BDwVAg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGZ1q5MsjpR65mpe98+A428gxbRJcxGR5ImoDLAZDQs=;
 b=fRQK5V1j/3LSbN/lAHLerl41zVOUq+gi2yWOU+/FCijWVzRYNSy1I7WcXBrPnzKie+Ox7YADo+B4IDSwCYpLhXHQb8cnpsUQBKAi6l2TF0UzLEAMTU0domCBI8u+koHnWJEOFEY0RAglNwn3xU0h7QTDXQbXSr/k2k6GVzXL6n1kwKrdPelY5BEWUaL4laIXeSuoujcsAlHRNOz0EXTurWRtSMQJ3a8feBq3e68SiZdsQjdHWP9DrohQlzhWfLbL7Zc+lrK+41hN3L5/J85F4QOSKXVS1VtrSZaE/G0NF/yu3L66wP/JaBaK1pskxV6ZmvwI8GedO++ZafnoHsMZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGZ1q5MsjpR65mpe98+A428gxbRJcxGR5ImoDLAZDQs=;
 b=Q202xz0n6FYG6YZbgHH7HhO9Xfk7fyrforOQoinaxTkCUk0UJ/e4AaTq4RGqMsRTlmFVuivGT8SDUHXlwoAwirSqywKCtr/6qRlook1sE+cllOYGFtQ8OLOkRRgGbDQsaecy1jjBTt3lyBD76QxtrNO1+o20CLcaqLC2nQXlSSc=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0185.APCP153.PROD.OUTLOOK.COM (10.170.187.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Fri, 2 Aug 2019 20:31:27 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c%7]) with mapi id 15.20.2157.001; Fri, 2 Aug 2019
 20:31:27 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "jackm@mellanox.com" <jackm@mellanox.com>
Subject: RE: [PATCH] PCI: hv: Fix panic by calling hv_pci_remove_slots()
 earlier
Thread-Topic: [PATCH] PCI: hv: Fix panic by calling hv_pci_remove_slots()
 earlier
Thread-Index: AdVI0ZE8ZG/OuLUpRiCFkuQ9gvUCcwAmKCuAAACT/uA=
Date:   Fri, 2 Aug 2019 20:31:26 +0000
Message-ID: <PU1P153MB01698F51FE22C39086CC8353BFD90@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169DBCFEE7257F5BB93580ABFD90@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190802194053.GL151852@google.com>
In-Reply-To: <20190802194053.GL151852@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-02T20:31:22.8119515Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=43160eaa-d2f6-4110-aeb7-ac4462d2355d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:71c8:ee0a:27d:d7aa]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa4f1d55-41c1-4d6c-f988-08d71788650a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0185;
x-ms-traffictypediagnostic: PU1P153MB0185:|PU1P153MB0185:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01858CF3D93DB06EAAF4FB3EBFD90@PU1P153MB0185.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(40224003)(54534003)(199004)(189003)(6116002)(10090500001)(81156014)(316002)(5660300002)(2906002)(8936002)(33656002)(8676002)(66476007)(66556008)(54906003)(76116006)(8990500004)(66446008)(22452003)(64756008)(6636002)(7736002)(68736007)(46003)(11346002)(25786009)(305945005)(10290500003)(74316002)(478600001)(1511001)(9686003)(76176011)(110136005)(7696005)(486006)(53936002)(476003)(55016002)(66946007)(446003)(14454004)(86362001)(81166006)(6246003)(4326008)(71190400001)(229853002)(99286004)(102836004)(7416002)(6506007)(71200400001)(14444005)(186003)(52536014)(6436002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0185;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1Bbdk3ldAg3wRSB6wuc7QP8cdfePd81VnPjPHVP8ALJBZTtIvfbIadLTB9vfFa6pTNC5rB94qe92+NL6Eq3NXKvr/HDnyyt63UR7rjhQpSc0NUuCAHgH7BHRyVR8aGAE36Xv1vCgRxECmH4wYR3AMQ40MdpyNoTdmfazzlWio+i5TK92dap1BwQUHs/aSjbXmYNxoTcJLkDmxeaTlypKdbmOWZyyrLTZ7W6Htsys7ntYnaOzL/B/9Iw6r7gIICFlzyBRQGzYu0sGzt31KqLRlWLV6ACKV1owQVLc3/UfkRc5L3Hz6XJ1fwinwZfTT6kv4dtJ/qFHUXjH5aev8f6XCbS/+IT8vmZNOPiMvKPnDhc7jwES3TMjfjndU+YPzbUFTbSANm9DcqfuM1/y+ZceVaJNveyLtaeA0HiFUqIYJ1A=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4f1d55-41c1-4d6c-f988-08d71788650a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 20:31:27.0076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qTDeaNc0QEmnA7PC3yMA4gCDUTqt8vTFgP59K8auAFJ5CBNZOzAXi187wEgfoltVCvrHESrw/iWsdoCJt4mQSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0185
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, August 2, 2019 12:41 PM
> The subject line only describes the mechanical code change, which is
> obvious from the patch.  It would be better if we could say something
> about *why* we need this.

Hi Bjorn,
Sorry. I'll try to write a better changelog in v2. :-)
=20
> On Fri, Aug 02, 2019 at 01:32:28AM +0000, Dexuan Cui wrote:
> >
> > When a slot is removed, the pci_dev must still exist.
> >
> > pci_remove_root_bus() removes and free all the pci_devs, so
> > hv_pci_remove_slots() must be called before pci_remove_root_bus(),
> > otherwise a general protection fault can happen, if the kernel is built
>=20
> "general protection fault" is an x86 term that doesn't really say what
> the issue is.  I suspect this would be a "use-after-free" problem.

Yes, it's use-after-free. I'll fix the the wording.
=20
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -2757,8 +2757,8 @@ static int hv_pci_remove(struct hv_device *hdev)
> >  		/* Remove the bus from PCI's point of view. */
> >  		pci_lock_rescan_remove();
> >  		pci_stop_root_bus(hbus->pci_bus);
> > -		pci_remove_root_bus(hbus->pci_bus);
> >  		hv_pci_remove_slots(hbus);
> > +		pci_remove_root_bus(hbus->pci_bus);
>=20
> I'm curious about why we need hv_pci_remove_slots() at all.  None of
> the other callers of pci_stop_root_bus() and pci_remove_root_bus() do
> anything similar to hv_pci_remove_slots().
>=20
> Surely some of those callers also support slots, so there must be some
> other path that calls pci_destroy_slot() in those cases.  Can we use a
> similar strategy here?

Originally Stephen Heminger added the slot code for pci-hyperv.c:
a15f2c08c708 ("PCI: hv: support reporting serial number as slot information=
")
So he may know this better. My understanding is: we can not use the similar
stragegy used in the 2 other users of pci_create_slot():

drivers/pci/hotplug/pci_hotplug_core.c calls pci_create_slot().
It looks drivers/pci/hotplug/ is quite different from pci-hyperv.c because
pci-hyper-v uses a simple *private* hot-plug protocol, making it impossible
to use the API pci_hp_register() and pci_hp_destroy() -> pci_destroy_slot()=
.

drivers/acpi/pci_slot.c calls pci_create_slot(), and saves the created slot=
s in
the static "slot_list" list in the same file. Again, since pci-hyper-v uses=
 a private
PCI-device-discovery protocol (which is based on VMBus rather the emulated
ACPI and PCI), acpi_pci_slot_enumerate() can not find the PCI devices that =
are
discovered by pci-hyperv, so we can not use the standard register_slot() ->
pci_create_slot() to create the slots and hence acpi_pci_slot_remove() ->=20
pci_destroy_slot() can not work for pci-hyperv.

I think I can use this as the v2 changelog:

The slot must be removed before the pci_dev is removed, otherwise a panic
can happen due to use-after-free.

Thanks,
Dexuan
