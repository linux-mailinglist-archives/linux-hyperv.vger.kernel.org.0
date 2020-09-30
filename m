Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5DA27DD7A
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Sep 2020 02:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgI3AiO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Sep 2020 20:38:14 -0400
Received: from mail-eopbgr1300114.outbound.protection.outlook.com ([40.107.130.114]:23743
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728684AbgI3AiO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Sep 2020 20:38:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdvEo6EbVK/BooknBaoenXttDc6RBigjCLoXxtSCiEDt4VEy8Cq34YDEpB1wiCH+gZef3DURTBP6V2COFqGcT91wGCzIFM2pWRMLpNdT6zl3u46DpPFStoUcDGUH+2ekJzSwgik5f8VHgrf2Xrg8l6Gxlhb3HRY6VAAlqojik9/lxcOqylNXdQyLvySnck/FglRy0ZL4t9qrbgND3i/hzBmBMz17SF54I0gz1fLa2XnCCAFr8ZL7kqKUzW+lvkTG3EwJRrZKNryNCxUsAkEo9qw7brCF8PVAhRm0bm581S3LgndYfKt+G3CQw3GvwjQq5GYcmaDwaykuJJYZWayVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJkic1F7IogL3itWZsjLLmFPA/0V7VYzxLwSDAYycJ0=;
 b=idIFtTnNJwtLdbClg2reg54YJfKZ/hoXT01srjN8CjLGmLR03ytYendLi5bJhOmWUx6Kpp6hOSL/Qk81VzA8Rnul6d7uCtFITwQ5Y5QeQ1kejzFEONSAHeytu3imPv3Li+z/96swaosVUtrUqqPuPQLYaF/BsP4qorNhcYUhDV7izWPEC0sV57xD4alXkN4c2TD1uP1w8lsX23QJn5b54v8YgAvf1aLcqEq9h+pY75zfmOVbnWoepQqSAuCtd9LGNFETRhpZdV5NwAurRQOt7JbQoCQOcObfdjGO3ujxW8kJRXNFRGE2weLGUJe76E17Z3u5b2a39i3yUYNRdpk0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJkic1F7IogL3itWZsjLLmFPA/0V7VYzxLwSDAYycJ0=;
 b=NzWk2BL1T4qGriSCwYSJ1N/3VcvrgXtGLPmmlqVx05PZkIaEuUlt29Rs/ehqhaJrAinhrB11wsNSKwdQU+AMKTZh0qbT6P/JfqPaWedyxsASLYMUzla0GGURbY03IazPG4N+U+wn7/0zUXP4lOySWRo2jdEbzxH97tb2cmJO9Kk=
Received: from KU1P153MB0120.APCP153.PROD.OUTLOOK.COM (2603:1096:802:1a::17)
 by KU1P153MB0133.APCP153.PROD.OUTLOOK.COM (2603:1096:802:1a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.12; Wed, 30 Sep
 2020 00:38:05 +0000
Received: from KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
 ([fe80::800c:633d:2d74:4f61]) by KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
 ([fe80::800c:633d:2d74:4f61%5]) with mapi id 15.20.3433.034; Wed, 30 Sep 2020
 00:38:05 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "maz@kernel.org" <maz@kernel.org>
CC:     "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jake Oshins <jakeo@microsoft.com>
Subject: RE: [PATCH v2] PCI: hv: Fix hibernation in case interrupts are not
 re-created
Thread-Topic: [PATCH v2] PCI: hv: Fix hibernation in case interrupts are not
 re-created
Thread-Index: AQHWlYQn2ALom6ybqEW4kSyfVSvz+Kl/Kh1g
Date:   Wed, 30 Sep 2020 00:38:04 +0000
Message-ID: <KU1P153MB01201EEC711EC37D30687940BF330@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
References: <20200908231759.13336-1-decui@microsoft.com>
 <20200928104309.GA12565@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200928104309.GA12565@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=87ae1cb6-54ec-453a-beb8-c09ac141503f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-29T06:34:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:bcd9:7e61:bb7f:9c95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5305fe94-0e83-4f8f-eef4-08d864d9184d
x-ms-traffictypediagnostic: KU1P153MB0133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KU1P153MB01335D2891641E53E337D243BF330@KU1P153MB0133.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OxC6AYGDQfu7y4ICpmU9ZgjeUA/DlfjPd8FIT4joIsjC2HBV5334DWSdHI5fqdvVlbOTb4JSO2zKo19+nuKBSvq45qd1MyFxQc3Xm/iwBPhFNQV0wV7OdBAIInrBMIU4CxbXYKhBD0Kk/vqhsHgDQl7Zrl8k3bg79SgSb+cH6CzkrB+A1uXRFsAFSS7XW/02+7PsBeZSOnL1J7q9BsOYJ9Dx5jkrayvvAhUnTFjANEB/mdDjHgwR7tse+j7kqnoXRgvtrFiMLkH6SkRXbmExZRcPexh2+ljqkhzFOArWubDxqaxT54dV4lo5dMhQCuIO3iwVWAoxOexapkpgkmeOxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1P153MB0120.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(66946007)(33656002)(8990500004)(6506007)(186003)(4326008)(8676002)(64756008)(316002)(54906003)(66556008)(66446008)(83380400001)(7696005)(66476007)(55016002)(107886003)(5660300002)(10290500003)(2906002)(110136005)(8936002)(9686003)(478600001)(71200400001)(82950400001)(76116006)(86362001)(82960400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OSovayw/ElKvnzJJukN3VJnbdlaxyEHVHJOdhyOxT7hUCxzXNtfWG61o8odlZ3Nu5WR4d8qxkrQFfC9N/dJxcBWrGbiUWftyRRyCfiXcEF6pAdAbGSvRbz4lFsiNWr6YvPcSWP8gc7LZy+LSWq/I3DTDjSptZWGvokMzRy6livCFbsOJFBlLBwhKhY1sarP+biEhcRLw5Cv8pY3ksRTQajlsB+hmv3FjzbO1vKhO5B3MaeGQJSF0Ci7d0AyyQskfnRtN5TxxikcUStF0HmCV7sgTxMoA2Agnsq6L6wgs5qrUoYO6FMxfbi867DGbZ/PQ0VYABVdplICA73grN75rjHNVwiOZuDfr6neHPyJh5GpHzzaQf5HD94+YRLhLGS4NSciOGa6RtjIoctJ92CJALAWHyQxkpYL9SshgemSBdwv1FL84K+CqiVyVQAVsG7efiIUcScdyxoI4efaq//c/dfGwRps1ae6bAaDt8QBfyk1VsHixtn3UGWNKOyHp49xxF+T1pH8wsgcULixIldKnZEWMlaOdScSFcAfvQED0zSIqMMeAuBxtgFH78lDdzfmyQfhZ8239hrJy3OkilMZKjSs/QFxs56FT4ARv0LsECs4fH+9kOEWnFA3RXx5OS5hGurLFt1S+9RXr0RH4g0B7DbT0MCiVKg+oeuqZFqE/DyNoDkkJJDrDErX3IZzaw/5UY6/1jI0hLTB9bKqG7u0ukg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5305fe94-0e83-4f8f-eef4-08d864d9184d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 00:38:04.4780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aXzQENl2compPqdFoLNrcfz5l7tF+BTUgq/vmuukz5J7QJu6IQ9XmFogwr+8i0HfKUoATX7XpPo+voqhUiU6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0133
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Monday, September 28, 2020 3:43 AM
>
> [+MarcZ - this patch needs IRQ maintainers vetting]

Sure. Hi MarkZ, please also review the patch. Thanks!

> On Tue, Sep 08, 2020 at 04:17:59PM -0700, Dexuan Cui wrote:
> > Hyper-V doesn't trap and emulate the accesses to the MSI/MSI-X
> > registers, and we must use hv_compose_msi_msg() to ask Hyper-V to
> > create the IOMMU Interrupt Remapping Table Entries. This is not an issu=
e
> > for a lot of PCI device drivers (e.g. NVMe driver, Mellanox NIC drivers=
),
> > which destroy and re-create the interrupts across hibernation, so
> > hv_compose_msi_msg() is called automatically. However, some other
> > PCI device drivers (e.g. the Nvidia driver) may not destroy and re-crea=
te
> > the interrupts across hibernation, so hv_pci_resume() has to call
> > hv_compose_msi_msg(), otherwise the PCI device drivers can no longer
> > receive MSI/MSI-X interrupts after hibernation.
>
> This looks like drivers bugs and I don't think the HV controller
> driver is where you should fix them.

IMHO this is not a PCI device driver bug, because I think a PCI device driv=
er
is allowed to keep and re-use the MSI/MSI-X interrupts across hibernation,
otherwise we would not have pci_restore_msi_state() in pci_restore_state().

The in-tree open-source Nvidia GPU driver drivers/gpu/drm/nouveau is such
a PCI device driver that re-uses the MSI-X interrupts across hibernation.
The out-of-tree proprietary Nvidia GPU driver also does the same thing.
It looks some other in-tree PCI device drivers also do the same thing, thou=
gh
I don't remember their names offhand.

IMO it's much better to change the pci-hyperv driver once and for all, than
to change every such existing (and future?) PCI device driver.

pci_restore_msi_state() directly writes the MSI/MSI-X related registers
in __pci_write_msi_msg() and msix_mask_irq(). On a physical machine, this
works perfectly, but for a Linux VM running on a hypervisor, which typicall=
y
enables IOMMU interrupt remapping, the hypervisor usually should trap and
emulate the write accesses to the MSI/MSI-X registers, so the hypervisor
is able to create the necessary interrupt remapping table entries in the
IOMMU, and the MSI/MSI-X interrupts can work in the VM. Hyper-V is differen=
t
from other hypervisors in that it does not trap and emulate the write
accesses, and instead it uses a para-virtualized method, which requires
the VM to call hv_compose_msi_msg() to notify the hypervisor of the info
that would be passed to the hypervisor in the case of the trap-and-emulate
method.

I mean this is a Hyper-V specific problem, so IMO we should fix the pci-hyp=
erv
driver rather than change the PCI device drivers, which work perfectly on a
physical machine and on other hypervisors. Also it can be difficult or=20
impossible to ask the authors of the aforementioned PCI device drivers to
destry and re-create MSI/MSI-X acorss hibernation, especially for the
out-of-tree driver(s).

> Regardless, this commit log does not provide the information that
> it should.

Hi Lozenzo, I'm happy to add more info. Can you please let me know
what extra info I should provide?

> > Fixes: ac82fc832708 ("PCI: hv: Add hibernation support")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > Reviewed-by: Jake Oshins <jakeo@microsoft.com>
> >
> > ---
> >
> > Changes in v2:
> >     Fixed a typo in the comment in hv_irq_unmask. Thanks to Michael!
> >     Added Jake's Reviewed-by.
> >
> >  drivers/pci/controller/pci-hyperv.c | 44 +++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c
> b/drivers/pci/controller/pci-hyperv.c
> > index fc4c3a15e570..dd21afb5d62b 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -1211,6 +1211,21 @@ static void hv_irq_unmask(struct irq_data *data)
> >  	pbus =3D pdev->bus;
> >  	hbus =3D container_of(pbus->sysdata, struct hv_pcibus_device, sysdata=
);
> >
> > +	if (hbus->state =3D=3D hv_pcibus_removing) {
> > +		/*
> > +		 * During hibernation, when a CPU is offlined, the kernel tries
> > +		 * to move the interrupt to the remaining CPUs that haven't
> > +		 * been offlined yet. In this case, the below hv_do_hypercall()
> > +		 * always fails since the vmbus channel has been closed, so we
> > +		 * should not call the hypercall, but we still need
> > +		 * pci_msi_unmask_irq() to reset the mask bit in desc->masked:
> > +		 * see cpu_disable_common() -> fixup_irqs() ->
> > +		 * irq_migrate_all_off_this_cpu() -> migrate_one_irq().
> > +		 */
> > +		pci_msi_unmask_irqpci_msi_unmask_irq(data);
>
> This is not appropriate - it looks like a plaster to paper over an
> issue with hyper-V hibernation code sequence. Fix that issue instead
> of papering over it here.
>
> Thanks,
> Lorenzo

IMO this patch is fixing this Hyper-V specific problem. :-)

The probem is unique to Hyper-V because chip->irq_unmask() may fail in a
Linux VM running on Hyper-V.=20

chip->irq_unmask() can not fail on a physical machine. I guess this is why=
=20
the return value of irq_unmask() is defined as "void" in include/linux/irq.=
h:
struct irq_chip {
...
        void            (*irq_mask)(struct irq_data *data);
        void            (*irq_unmask)(struct irq_data *data);

As I described in the comment, in a VM on Hyper-V, chip->irq_unmask()
fails during the suspending phase of hibernation because it's called
when the non-boot CPUs are being offlined, and at this time all the devices=
,
including Hyper-V VMBus devices, have been "frozen" -- this is part of
the standard Linux hibernation workflow. Since Hyper-V thinks the VM has
frozen the pci-hyperv VMBus device at this moment (i.e. closed the VMBus
channel of the VMBus device), it fails chip->irq_unmask(), i.e.
hv_irq_unmask() -> hv_do_hypercall().

On a physical machine, unmasking an MSI/MSI-X register just means an MMIO
write, which I think can not fail here.

So I think this patch is the correct fix, considering Hyper-V's unique
implementation of the MSI "chip" (i.e. Hyper-V does not trap and emulate
the MSI/MSI-X register accesses, and uses a para-virtualized method as I
explained above), and the fact that I shouldn't and can't change the
standard Linux hibernation workflow.

In hv_irq_unmask(), when I skip the hypercall in the case of
hbus->state =3D=3D hv_pcibus_removing, I still need the pci_msi_unmask_irq(=
),
because of the sequences in kernel/irq/cpuhotplug.c:

static bool migrate_one_irq(struct irq_desc *desc)
{
...
        if (maskchip && chip->irq_mask)
                chip->irq_mask(d);
...
        err =3D irq_do_set_affinity(d, affinity, false);
...
        if (maskchip && chip->irq_unmask)
                chip->irq_unmask(d);

Here if hv_irq_unmask does not call pci_msi_unmask_irq(), the desc->masked
remains "true", so later after hibernation, the MSI interrupt line always
reamins masked, which is incorrect.

Here the slient failure of hv_irq_unmask() does not matter since all the
non-boot CPUs are being offlined (meaning all the devices have been
frozen). Note: the correct affinity info is still updated into the
irqdata data structure in migrate_one_irq() -> irq_do_set_affinity() ->
hv_set_affinity(), so when the VM resumes, hv_pci_resume() ->
hv_pci_restore_msi_state() is able to correctly restore the irqs with
the correct affinity.

I hope the explanation can help clarify things. I understand this is not
as natual as tht case that Linux runs on a physical machine, but due to
the unique PCI pass-through implementation of Hyper-V, IMO this is
the only viable fix for the problem here. BTW, this patch is only confined
to the pci-hyperv driver and I believe it can no cause any regression.

Thanks,
-- Dexuan


> > +		return;
> > +	}
> > +
> >  	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
> >
> >  	params =3D &hbus->retarget_msi_interrupt_params;
> > @@ -3372,6 +3387,33 @@ static int hv_pci_suspend(struct hv_device
> *hdev)
> >  	return 0;
> >  }
> >
> > +static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
> > +{
> > +	struct msi_desc *entry;
> > +	struct irq_data *irq_data;
> > +
> > +	for_each_pci_msi_entry(entry, pdev) {
> > +		irq_data =3D irq_get_irq_data(entry->irq);
> > +		if (WARN_ON_ONCE(!irq_data))
> > +			return -EINVAL;
> > +
> > +		hv_compose_msi_msg(irq_data, &entry->msg);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Upon resume, pci_restore_msi_state() -> ... ->  __pci_write_msi_msg=
()
> > + * re-writes the MSI/MSI-X registers, but since Hyper-V doesn't trap a=
nd
> > + * emulate the accesses, we have to call hv_compose_msi_msg() to ask
> > + * Hyper-V to re-create the IOMMU Interrupt Remapping Table Entries.
> > + */
> > +static void hv_pci_restore_msi_state(struct hv_pcibus_device *hbus)
> > +{
> > +	pci_walk_bus(hbus->pci_bus, hv_pci_restore_msi_msg, NULL);
> > +}
> > +
> >  static int hv_pci_resume(struct hv_device *hdev)
> >  {
> >  	struct hv_pcibus_device *hbus =3D hv_get_drvdata(hdev);
> > @@ -3405,6 +3447,8 @@ static int hv_pci_resume(struct hv_device *hdev)
> >
> >  	prepopulate_bars(hbus);
> >
> > +	hv_pci_restore_msi_state(hbus);
> > +
> >  	hbus->state =3D hv_pcibus_installed;
> >  	return 0;
> >  out:

