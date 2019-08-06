Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E0B839C7
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2019 21:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfHFTph (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 6 Aug 2019 15:45:37 -0400
Received: from mail-eopbgr690116.outbound.protection.outlook.com ([40.107.69.116]:24709
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725906AbfHFTph (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Aug 2019 15:45:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auLVnsN9Km0UdMFPjW+8B+fZIERa8gD1RuyAFEwXp+ImkXYQplt1mVJfgBiqdH2iwAt1qfdxrLNGEfMyv3W5J3Lhx2/SmjA9mZy3u0tzWkZIBeFuGPsyHMJ7zIBa0bKEhtmdAldTVNIgPzNPen6x7V2hErr1AoHDtkXi8fUB4vEeFKAqKB9XdDbej+FadtZul4th20f/whnQAnz5hPSek/iDbvYSJfTAG2fUUnuxPTusGN6AfWDzy8j1Yb/0RJf3OkX34M0AtnaQ3CVD1nuvg3zN7Y4WApebbeeRxyBZU62Ljx40VSgpvNrm3WFhzTWdkubnP3HZwBSKBtFUirMF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmqRg9OzcqTmOcaP/sksOV17c8HaDN3+2HCUJm/G3IU=;
 b=bB1npomzZ35TboNR0hmef5QyuNiM1e3jhWTqvw6pV59bMv5fxI2pelH8yoBFMC+ZpSbMNI1YLSTmJzUscyuNPYbHHPo+IShf1Xe4vlwDfP3lsBHSDCOyCTnmJxXql7p2tfM7J3aHkFRvUAf02MxKFjEn5Sck0jBojF3gI4PLF+HWbMlh0Zv4oFONpwp15torM48Dwx4vnVquo1mC+K5gD5pnkWZPoXr5nlCubVs0+U0WFsJZuZaFY84v1FT/h0aAjBIquSA5/rTN7cEgFCxOfP1KaIS5kVraUYVnqvmDerMA7/vBc9R01nU6WlkKU9U49LBsyxUF4QGqTo2PVt618w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmqRg9OzcqTmOcaP/sksOV17c8HaDN3+2HCUJm/G3IU=;
 b=NDvUUaeDXYyIV4zOrQpCjLXs+p/WPArswgG3UyajqtkcSXz8nLU6XoWtp6eO5ND9ukVUHWoHZ45S86x7NNpLNr4QcqR0iM+4WjOy9/tYSgvndJJO5l0xl6N4k+FbAGD3g55mxtolnbkljmNX0CdJXJwfGMJw+PDy+/41R+RIUnQ=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (20.179.53.80) by
 DM6PR21MB1450.namprd21.prod.outlook.com (10.255.109.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.11; Tue, 6 Aug 2019 19:45:30 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::1138:b756:9035:c34f]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::1138:b756:9035:c34f%7]) with mapi id 15.20.2157.011; Tue, 6 Aug 2019
 19:45:30 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Topic: [PATCH] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Index: AQHVSWN/lxoIKIL/NkaM6ZIBa0Xgp6bufjCAgAANOQA=
Date:   Tue, 6 Aug 2019 19:45:30 +0000
Message-ID: <DM6PR21MB1337F971324150D5AA84B9B5CAD50@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <1564771954-9181-1-git-send-email-haiyangz@microsoft.com>
 <20190806185515.GR151852@google.com>
In-Reply-To: <20190806185515.GR151852@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-06T19:43:17.8621686Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b974d65c-4fca-47c3-9f65-9a1f8e5e3dbe;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1945d8e4-1699-41c7-fb3e-08d71aa6a39e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1450;
x-ms-traffictypediagnostic: DM6PR21MB1450:|DM6PR21MB1450:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB14505042A740DC220D9E0866CAD50@DM6PR21MB1450.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(51914003)(13464003)(189003)(199004)(11346002)(4326008)(476003)(86362001)(446003)(53936002)(74316002)(7736002)(305945005)(81166006)(81156014)(33656002)(229853002)(22452003)(66066001)(55016002)(486006)(8676002)(6436002)(5660300002)(66946007)(54906003)(66446008)(64756008)(6916009)(68736007)(66556008)(52536014)(316002)(66476007)(25786009)(9686003)(76116006)(10090500001)(6116002)(3846002)(186003)(26005)(10290500003)(102836004)(99286004)(7696005)(71200400001)(71190400001)(76176011)(2906002)(6246003)(6506007)(53546011)(478600001)(8990500004)(8936002)(256004)(14444005)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1450;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NbhzEQYUf9EWsslsgTHP0RoOTa/yLUmKgwbWF4hDsJ6THTjJEmN6GhhAe/01/YMlRiobRyqaJoHmwSx/TTPSijV89XFkI7OUTIwYnnt9o/6ZOgCUYARYmymsD+kio6up51qetL6/P2/8UU8DAPtd8aAb0Sr6NCmgV4gwGD4WlAnCE9EbSgB3aLkhNM1iSZfe6X36fI0Pso2qsHWvNdG+OEedOu3nb6v3z6GpMNR+9ZhEJoWDi2eAxULoJ+ffj3gK1UeN58etuVFW54vMhCTv32CD9QURYVyt+zLL6h0T/ZnIU5zq1T1kKFeijh3FTI6VFezxIbaKG+wst40rDFZhAJDzmDSZK+8tK5y/gqsfnco0yD1nssLCFtrMV0Cu7A6rtE8hkEVEoardqEOoPSNb8pu0XlQgLjmmY2i4ao/yzlA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1945d8e4-1699-41c7-fb3e-08d71aa6a39e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 19:45:30.7147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBDeAd2it5flsGAwNNBQ03e4VALG8dcKi/AyKOndl5HY7gmMUXJNO332dT/rDB4oEsV0BBN+hCXle3LUkH6jRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1450
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, August 6, 2019 2:55 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: sashal@kernel.org; lorenzo.pieralisi@arm.com; linux-
> hyperv@vger.kernel.org; linux-pci@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> olaf@aepfle.de; vkuznets <vkuznets@redhat.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] PCI: hv: Detect and fix Hyper-V PCI domain number
> collision
>=20
> On Fri, Aug 02, 2019 at 06:52:56PM +0000, Haiyang Zhang wrote:
> > Due to Azure host agent settings, the device instance ID's bytes 8 and
> > 9 are no longer unique. This causes some of the PCI devices not
> > showing up in VMs with multiple passthrough devices, such as GPUs. So,
> > as recommended by Azure host team, we now use the bytes 4 and 5 which
> > usually provide unique numbers.
>=20
> What does "Azure host agent settings" mean?  Would it be useful to say
> something more specific, so users could ready this and say "oh, I'm using=
 the
> Azure host agent settings mentioned here, so I need this patch"?  Is this
> related to a specific Azure host agent commit or release?
>=20
> "This causes some of the PCI devices ..." is not a sentence.  I think I
> understand what you're saying -- "This sometimes causes device passthroug=
h
> to VMs to fail." Is there something about GPUs that makes them more
> susceptible to this problem?
>=20
> I think there are really two changes in this patch:
>=20
>   1) Start with a domain number from bytes 4-5 instead of bytes 8-9.
>=20
>   2) If the domain number is not unique, allocate another one using
>   the bitmap.
>=20
> It sounds like part 2) by itself would be enough to solve the problem, an=
d
> including part 1) just reduces the likelihood of having to allocate anoth=
er
> domain number.
>=20
> > In the rare cases of collision, we will detect and find another number
> > that is not in use.
> > Thanks to Michael Kelley <mikelley@microsoft.com> for proposing this
> idea.
>=20
> This looks like two paragraphs and should have a blank line between them.
>=20
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 91
> > +++++++++++++++++++++++++++++++------
> >  1 file changed, 78 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c
> > b/drivers/pci/controller/pci-hyperv.c
> > index 82acd61..6b9cc6e60a 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -37,6 +37,8 @@
> >   * the PCI back-end driver in Hyper-V.
> >   */
> >
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> > @@ -2507,6 +2509,47 @@ static void put_hvpcibus(struct
> hv_pcibus_device *hbus)
> >  		complete(&hbus->remove_event);
> >  }
> >
> > +#define HVPCI_DOM_MAP_SIZE (64 * 1024) static
> > +DECLARE_BITMAP(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
> > +
> > +/* PCI domain number 0 is used by emulated devices on Gen1 VMs, so
> > +define 0
> > + * as invalid for passthrough PCI devices of this driver.
> > + */
>=20
> Please use the usual multi-line comment style:
>=20
>   /*
>    * PCI domain number ...
>    */
>=20
> > +#define HVPCI_DOM_INVALID 0
> > +
> > +/**
> > + * hv_get_dom_num() - Get a valid PCI domain number
> > + * Check if the PCI domain number is in use, and return another
> > +number if
> > + * it is in use.
> > + *
> > + * @dom: Requested domain number
> > + *
> > + * return: domain number on success, HVPCI_DOM_INVALID on failure  */
> > +static u16 hv_get_dom_num(u16 dom) {
> > +	unsigned int i;
> > +
> > +	if (test_and_set_bit(dom, hvpci_dom_map) =3D=3D 0)
> > +		return dom;
> > +
> > +	for_each_clear_bit(i, hvpci_dom_map, HVPCI_DOM_MAP_SIZE) {
> > +		if (test_and_set_bit(i, hvpci_dom_map) =3D=3D 0)
> > +			return i;
> > +	}
> > +
> > +	return HVPCI_DOM_INVALID;
> > +}
> > +
> > +/**
> > + * hv_put_dom_num() - Mark the PCI domain number as free
> > + * @dom: Domain number to be freed
> > + */
> > +static void hv_put_dom_num(u16 dom)
> > +{
> > +	clear_bit(dom, hvpci_dom_map);
> > +}
> > +
> >  /**
> >   * hv_pci_probe() - New VMBus channel probe, for a root PCI bus
> >   * @hdev:	VMBus's tracking struct for this root PCI bus
> > @@ -2518,6 +2561,7 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  			const struct hv_vmbus_device_id *dev_id)  {
> >  	struct hv_pcibus_device *hbus;
> > +	u16 dom_req, dom;
> >  	int ret;
> >
> >  	/*
> > @@ -2532,19 +2576,32 @@ static int hv_pci_probe(struct hv_device
> *hdev,
> >  	hbus->state =3D hv_pcibus_init;
> >
> >  	/*
> > -	 * The PCI bus "domain" is what is called "segment" in ACPI and
> > -	 * other specs.  Pull it from the instance ID, to get something
> > -	 * unique.  Bytes 8 and 9 are what is used in Windows guests, so
> > -	 * do the same thing for consistency.  Note that, since this code
> > -	 * only runs in a Hyper-V VM, Hyper-V can (and does) guarantee
> > -	 * that (1) the only domain in use for something that looks like
> > -	 * a physical PCI bus (which is actually emulated by the
> > -	 * hypervisor) is domain 0 and (2) there will be no overlap
> > -	 * between domains derived from these instance IDs in the same
> > -	 * VM.
> > +	 * The PCI bus "domain" is what is called "segment" in ACPI and other
> > +	 * specs. Pull it from the instance ID, to get something usually
> > +	 * unique. In rare cases of collision, we will find out another numbe=
r
> > +	 * not in use.
> > +	 * Note that, since this code only runs in a Hyper-V VM, Hyper-V
> > +	 * together with this guest driver can guarantee that (1) The only
> > +	 * domain used by Gen1 VMs for something that looks like a physical
> > +	 * PCI bus (which is actually emulated by the hypervisor) is domain 0=
.
> > +	 * (2) There will be no overlap between domains (after fixing possibl=
e
> > +	 * collisions) in the same VM.
>=20
> Please use blank lines between paragraphs.
>=20
> >  	 */
> > -	hbus->sysdata.domain =3D hdev->dev_instance.b[9] |
> > -			       hdev->dev_instance.b[8] << 8;
> > +	dom_req =3D hdev->dev_instance.b[5] << 8 | hdev->dev_instance.b[4];
> > +	dom =3D hv_get_dom_num(dom_req);
> > +
> > +	if (dom =3D=3D HVPCI_DOM_INVALID) {
> > +		pr_err("Unable to use dom# 0x%hx or other numbers",
> > +		       dom_req);
> > +		ret =3D -EINVAL;
> > +		goto free_bus;
> > +	}
> > +
> > +	if (dom !=3D dom_req)
> > +		pr_info("PCI dom# 0x%hx has collision, using 0x%hx",
> > +			dom_req, dom);
>=20
> Can these use "dev_err/info(&hdev->device, ...)" like the other message i=
n
> this function?  It's always nicer to have a specific device reference whe=
n one
> is available.  Probably don't need the new pr_fmt() definition if you do =
this.
>=20
> > +
> > +	hbus->sysdata.domain =3D dom;
> >
> >  	hbus->hdev =3D hdev;
> >  	refcount_set(&hbus->remove_lock, 1); @@ -2559,7 +2616,7 @@
> static
> > int hv_pci_probe(struct hv_device *hdev,
> >  					   hbus->sysdata.domain);
> >  	if (!hbus->wq) {
> >  		ret =3D -ENOMEM;
> > -		goto free_bus;
> > +		goto free_dom;
> >  	}
> >
> >  	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL,
> > 0, @@ -2636,6 +2693,8 @@ static int hv_pci_probe(struct hv_device
> *hdev,
> >  	vmbus_close(hdev->channel);
> >  destroy_wq:
> >  	destroy_workqueue(hbus->wq);
> > +free_dom:
> > +	hv_put_dom_num(hbus->sysdata.domain);
> >  free_bus:
> >  	free_page((unsigned long)hbus);
> >  	return ret;
> > @@ -2717,6 +2776,9 @@ static int hv_pci_remove(struct hv_device *hdev)
> >  	put_hvpcibus(hbus);
> >  	wait_for_completion(&hbus->remove_event);
> >  	destroy_workqueue(hbus->wq);
> > +
> > +	hv_put_dom_num(hbus->sysdata.domain);
> > +
> >  	free_page((unsigned long)hbus);
> >  	return 0;
> >  }
> > @@ -2744,6 +2806,9 @@ static void __exit exit_hv_pci_drv(void)
> >
> >  static int __init init_hv_pci_drv(void)  {
> > +	/* Set the invalid domain number's bit, so it will not be used */
> > +	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
> > +
> >  	return vmbus_driver_register(&hv_pci_drv);
> >  }
> >
> > --
> > 1.8.3.1

Thanks for the comments. I will make the recommended changes.

- Haiyang
