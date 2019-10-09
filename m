Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22912D04AD
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Oct 2019 02:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfJIAQW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Oct 2019 20:16:22 -0400
Received: from mail-eopbgr1300139.outbound.protection.outlook.com ([40.107.130.139]:20608
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728792AbfJIAQW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Oct 2019 20:16:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FunGi9ms5KsXNGDxZ9FcdKfCQe65NPVlXqjykOImSwhL7+SGZnGmYQXctSwyuOYOrWWZaRmV5XHaES19m5KFoTFuazfaWNBpvOmEEgGFNPpQg+OaCIDIWTMaERQaFSAQoFKByNgmciMWYHUbSAn+6lJy492IrJRsY7yAW+xohx/AaiVCA8lXcOcPQGTKasAo8JKyHUTsmyQZyU1zlIa7X7djzVQGKeDyY2NlcMPGabgzc0qJdU5UKm7u+HT54oX/5hdhWtLlUcqDtnhIPHKPyhbFvtfzlzxPqC6+qMRqTtpfcdMhZE+gdi79pKvcWROFoRCYb4G43XN903W/cI3UZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Okz/dP8GdW4F/ReC1j1fCe7QOcf6UWvSEb3E/+xKlo=;
 b=ZyHw9X6sU416i84v+F5RGjdxl+EenlYhR8p9ym5xXcZOBDrzZOmPoJ9znYz/iAi1/hKmpnSm0qPaPeoxHT5P2TxG4OxN/YjV0yf2pynr3tun5m2w15LGx26Ep/F4UgEvgYo8ErnuqLfqlL3UQ3b6Tl+Ay3+XCd/JWibkCsTKA8pnD4zumW5gWwhx9HOrlT7EHg7JcRHnhWKIwGdG3BlnwsvlrFwTqgDminBcHt/X8o/2/ubihoOT4hKqlXKY9Y/RXu85jIegRLgW6QgGiB2hpks5Qzz1J/IV0f/xHguBTdYPcwLAk41OG9AV4dsgx+zjVQpAXFXFdQXKLN+VOmfi0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Okz/dP8GdW4F/ReC1j1fCe7QOcf6UWvSEb3E/+xKlo=;
 b=GNk+jMG3pO7eVGwYo76DwIiypOwuL+ypc6tIXjQHkPNIVQePvSDhKwI30d5NfZlW3ndsJ28lIrZA32q/h2CrIcjufWLbT09dinPV0C0ceZfdkLpcYpYJrVxoBxK6j38Dc5uxV4zQRLRpb8bqmb0V5zBLgic4BttCudJ2IKVL+Sw=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0172.APCP153.PROD.OUTLOOK.COM (10.170.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.2; Wed, 9 Oct 2019 00:16:05 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2367.004; Wed, 9 Oct 2019
 00:16:05 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
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
        Stephen Hemminger <sthemmin@microsoft.com>,
        "jackm@mellanox.com" <jackm@mellanox.com>
Subject: RE: [PATCH v2] PCI: PM: Move to D0 before calling
 pci_legacy_resume_early()
Thread-Topic: [PATCH v2] PCI: PM: Move to D0 before calling
 pci_legacy_resume_early()
Thread-Index: AQHVfhJ2d22rbcvgTV28JV77HSffhqdRa4KA
Date:   Wed, 9 Oct 2019 00:16:05 +0000
Message-ID: <PU1P153MB0169909FAD3032F462F48E9FBF950@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <a2d8ad9f-b59d-57e4-f014-645e7b796cc4@intel.com>
 <20191008195624.GA198287@google.com>
In-Reply-To: <20191008195624.GA198287@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-09T00:16:02.0523304Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2b92351c-f491-4b1f-bb63-d2e14e522426;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [167.220.2.148]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb3e6445-3631-4549-06b7-08d74c4de078
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0172:|PU1P153MB0172:|PU1P153MB0172:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0172BB72E8716DC34D2596C1BF950@PU1P153MB0172.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(199004)(189003)(478600001)(76116006)(7416002)(229853002)(26005)(2906002)(186003)(33656002)(5660300002)(10090500001)(66446008)(486006)(64756008)(6246003)(9686003)(446003)(66556008)(11346002)(66476007)(86362001)(256004)(476003)(14444005)(10290500003)(6436002)(66946007)(99286004)(55016002)(14454004)(22452003)(102836004)(3846002)(316002)(4326008)(6116002)(8990500004)(110136005)(8936002)(6506007)(305945005)(8676002)(81166006)(81156014)(71200400001)(71190400001)(7696005)(66066001)(74316002)(52536014)(25786009)(7736002)(54906003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0172;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f6Z9tdBngugsf0ezBsN6NuSpYu3EcG0fKhzwUlW3RoCbphaN3RiNqA79jPS0hl5CaaYlKQhG83T5XiGAAZqgtZWYO++0dOHhjFiYj+YraMnbQYNtG5oBGfP73688wXimJDsnSeY6X9ZCNwcdzegvZZD9uB/jGDLbbjT2HELoDQOMeCh5J57yu8bv9bhLTuiFS2V+Bz9XRRK+tELokfBuIkNE72Cyxru8Z0fwI6FO5/cK+6yItwkavKazgT4gsoLJ3L7wsho5XLs1+wHIOLtoMLn78vvcO4YUX6h4E+Yk3l2/x8kbqpilGfg81wi/bu+jNa2VAdVEN7Rt8khGqM9/E6nsdE27DgJnr5q8G4Kjbi2c67/RmdHnCvA63wRl+sGJZ58Lzs/cJ7me0VGgzXV1UvJlXju/SnLMbLlMiuDmLjQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3e6445-3631-4549-06b7-08d74c4de078
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 00:16:05.3382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HKrm2PxTEL1ykbFyBPVZCpChngspkL/nZvMqgbzec5e2UkUFqlurSwpCDabroCZiJlggJsecFHxDt7EndouN+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0172
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, October 8, 2019 12:56 PM
> ...
> Wordsmithing nit: what the patch does is not "fix the error message";
> what it does is fix the *problem*, i.e., the fact that we can't
> operate the device because we can't enable MSI-X.  The message is only
> a symptom.

I totally agree. :-)

> IIUC the relevant part of the system hibernation sequence is:
>=20
>   pci_pm_freeze_noirq
>   pci_pm_thaw_noirq
>   pci_pm_thaw
>=20
> And the execution flow is:
>=20
>   pci_pm_freeze_noirq
>     if (pci_has_legacy_pm_support(pci_dev)) # true for mlx4
>       pci_legacy_suspend_late(dev, PMSG_FREEZE)
> 	pci_pm_set_unknown_state
> 	  dev->current_state =3D PCI_UNKNOWN  # <---
>   pci_pm_thaw_noirq
>     if (pci_has_legacy_pm_support(pci_dev)) # true
>       pci_legacy_resume_early(dev)          # noop; mlx4 doesn't
> implement
>   pci_pm_thaw                               # returns -95
> EOPNOTSUPP
>     if (pci_has_legacy_pm_support(pci_dev)) # true
>       pci_legacy_resume
> 	drv->resume
> 	  mlx4_resume                       # mlx4_driver.resume (legacy)
> 	    mlx4_load_one
> 	      mlx4_enable_msi_x
> 		pci_enable_msix_range
> 		  __pci_enable_msix_range
> 		    __pci_enable_msix
> 		      if (!pci_msi_supported())
> 			if (dev->current_state !=3D PCI_D0)  # <---
> 			  return 0
> 			return -EINVAL
> 		err =3D -EOPNOTSUPP
> 		"INTx is not supported ..."
>=20
> (These are just my notes; you don't need to put them all into the
> commit message.  I'm just sharing them in case I'm not understanding
> correctly.)

Yes, these notes are accurate.

> > > > > When the system starts again, a fresh kernel starts to run, and w=
hen the
> > > > > kernel detects that a hibernation image was saved, the kernel
> "quiesces"
> > > > > the devices, and then "restores" the devices from the saved image=
. In
> this
> > > > > path:
> > > > > device_resume_noirq() -> ... ->
> > > > >    pci_pm_restore_noirq() ->
> > > > >      pci_pm_default_resume_early() ->
> > > > >        pci_power_up() moves the device states back to PCI_D0. Thi=
s
> path is
> > > > > not broken and doesn't need my patch.
> > > > >
>=20
> The cc list suggests that this might be a fix for a user-reported
> problem.  Is there a launchpad or similar link you could include here?

I guess I'm the first one to notice the issue and there is not any bug link=
 AFAIK.

The hibernation process usually saves the states into a local disk (before =
the
system is powered off), and the Mellanox NIC is not needed during the proce=
ss,
so it's not a real issue that the NIC can not work between pci_pm_thaw() an=
d=20
power_down(). This may explain why nobody else noticed the issue. I happene=
d
to see the error message, and hence investigated the issue.

> Should this be marked for stable?

I think we should do it.
=20
> > > > > --- a/drivers/pci/pci-driver.c
> > > > > +++ b/drivers/pci/pci-driver.c
> > > > > @@ -1074,15 +1074,16 @@ static int pci_pm_thaw_noirq(struct devic=
e
> > > > *dev)
> > > > >   			return error;
> > > > >   	}
> > > > >
> > > > > -	if (pci_has_legacy_pm_support(pci_dev))
> > > > > -		return pci_legacy_resume_early(dev);
> > > > > -
> > > > >   	/*
> > > > >   	 * pci_restore_state() requires the device to be in D0 (becaus=
e
> of MSI
> > > > >   	 * restoration among other things), so force it into D0 in cas=
e
> the
> > > > >   	 * driver's "freeze" callbacks put it into a low-power state
> directly.
> > > > >   	 */
> > > > >   	pci_set_power_state(pci_dev, PCI_D0);
> > > > > +
> > > > > +	if (pci_has_legacy_pm_support(pci_dev))
> > > > > +		return pci_legacy_resume_early(dev);
> > > > > +
> > > > >   	pci_restore_state(pci_dev);
> > > > >
> > > > >   	if (drv && drv->pm && drv->pm->thaw_noirq)
> > > > > --
> > > > > 2.19.1
> > > > >
> > The patch looks reasonable to me, but the comment above the
> > pci_set_power_state() call needs to be updated too IMO.
>=20
> Hmm.
>=20
> 1) pci_restore_state() mainly writes config space, which doesn't
> require the device to be in D0.  The only thing I see that would
> require D0 is the MSI-X MMIO space, so to be more specific, the
> comment could say "restoring the MSI-X *MMIO* state requires the
> device to be in D0".
>=20
> But I think you meant some other comment change.  Did you mean
> something along the lines of "a legacy drv->resume_early() callback
> and pci_restore_state() both require the device to be in D0"?
>=20
> If something else, maybe you could propose some text?
>=20
> 2) I assume pci_pm_thaw_noirq() should leave the device in a
> functionally equivalent state, whether it uses legacy PM or not.  Do
> we want something like the patch below instead?  If we *do* want to
> skip pci_restore_state() for legacy PM, maybe we should add a comment.
>=20
> 3) Documentation/power/pci.rst says:
>=20
>   ... devices have to be brought back to the fully functional
>   state ...
>=20
>   pci_pm_thaw_noirq() ... doesn't put the device into the full power
>   state and doesn't attempt to restore its standard configuration
>   registers.
>=20
> That doesn't seem consistent, and it looks like pci_pm_thaw_noirq()
> actually *does* put the device in full power (D0) state and restore
> config registers.

I would leave these questions to Rafael.
=20
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index a8124e47bf6e..30c721fd6bcf 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1068,7 +1068,7 @@ static int pci_pm_thaw_noirq(struct device *dev)
>  {
>  	struct pci_dev *pci_dev =3D to_pci_dev(dev);
>  	struct device_driver *drv =3D dev->driver;
> -	int error =3D 0;
> +	int error;
>=20
>  	if (pcibios_pm_ops.thaw_noirq) {
>  		error =3D pcibios_pm_ops.thaw_noirq(dev);
> @@ -1076,9 +1076,6 @@ static int pci_pm_thaw_noirq(struct device *dev)
>  			return error;
>  	}
>=20
> -	if (pci_has_legacy_pm_support(pci_dev))
> -		return pci_legacy_resume_early(dev);
> -
>  	/*
>  	 * pci_restore_state() requires the device to be in D0 (because of MSI
>  	 * restoration among other things), so force it into D0 in case the
> @@ -1087,10 +1084,13 @@ static int pci_pm_thaw_noirq(struct device *dev)
>  	pci_set_power_state(pci_dev, PCI_D0);
>  	pci_restore_state(pci_dev);
>=20
> +	if (pci_has_legacy_pm_support(pci_dev))
> +		return pci_legacy_resume_early(dev);
> +
>  	if (drv && drv->pm && drv->pm->thaw_noirq)
> -		error =3D drv->pm->thaw_noirq(dev);
> +		return drv->pm->thaw_noirq(dev);
>=20
> -	return error;
> +	return 0;
>  }
>=20
>  static int pci_pm_thaw(struct device *dev)

The only real difference from my patch is that you moved

 +	if (pci_has_legacy_pm_support(pci_dev))
 +		return pci_legacy_resume_early(dev);

to after the line "pci_restore_state(pci_dev);"

This change is good to me, and shoud also resolve the error message I saw.

Thanks,
-- Dexuan
