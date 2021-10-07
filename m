Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DF94260A8
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Oct 2021 01:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhJGXnL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Oct 2021 19:43:11 -0400
Received: from mail-bn8nam12on2091.outbound.protection.outlook.com ([40.107.237.91]:55168
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229778AbhJGXnK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Oct 2021 19:43:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C46ZNaJqN0NIkHW5ew051e3ffKSe66OdBr9AzNFlI8eq1s+D1RA5gdM6/YfAxS59Q4BwikNLWyD+JqRED5XMTKiVp8RCCqzuAoDjOn3K6j5oYkrAQs0b14seMY8YRqlfWacjXg7ehRl2Pr5Vuh5IDGVdDG/j4jppGnhzjqiOhg4PXYhb/zzHpgRG0PbtS3D0vsG2fcZGv/SPtlXu9FckYKDcXIVVbJv40886elMfoyFqO1UxxWf2pm/YALbsQERsm1oaiXungeqhqIrm/X2JepGuInp+VatZtqk4fWEXZL3VhiF/eTb3V1g7DpjuonFrcoFKSkiadODor8Dxa1V6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDtwZdagJj7KG/T+oRxJwXyhpBQcc+zPlopA53mVx30=;
 b=iJ9q9s9CX0TvAHqXxBkdKfg67sWCXgzxzpTMJ7g5SAjFEVkIbVD/JuENvPOENIAd0Pjgz9v+oJ/lMAXEkCo2U7KTFncw0BD9MiAve68qj7Qp28bu1OnevZZ9sBTymK7JS2197prJQoKXC6KhQQ/wXhCd8XRS8FfdZ14xIfqq0WxNnwP4Dp+2XKrVo/rQ8YptjNIxshHoVhqTla7j4uGh6QYKdZkdMIxFtzsMpFh+3sP0ehuxCeawD3Mj1rVxyR4v0zVdhb28muLUBcStpcRo2XmmeRvr/eRNzClVN4b0B7YFYkL7arvsX40cRwcTBRdool//VM7MrZ+cXb6dbXr0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDtwZdagJj7KG/T+oRxJwXyhpBQcc+zPlopA53mVx30=;
 b=MFZTNa2Leb/2/haHlCDNa+B+GjRfDbW/xq5Y4qlABG2jOvSvzTNrMrDrp4X+8pcHAfnZApDKReVqZ8ss/Kqk0mD7zQecuKItpPS2smUXHf5Y/+HiJwsoAyl7BUuZgUFqx18HsrZlnSUpghiWkrz2T23RpM+B4ozE/76fIPES2i0=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MW2PR2101MB1002.namprd21.prod.outlook.com (2603:10b6:302:4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4; Thu, 7 Oct
 2021 23:41:12 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::89fe:5bf:5eb2:4c55]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::89fe:5bf:5eb2:4c55%4]) with mapi id 15.20.4608.004; Thu, 7 Oct 2021
 23:41:12 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?=22Krzysztof_Wilczy=F1ski=22?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH 2/2] PCI: hv: Support for Hyper-V vPCI for
 ARM64
Thread-Topic: [EXTERNAL] Re: [PATCH 2/2] PCI: hv: Support for Hyper-V vPCI for
 ARM64
Thread-Index: AdeoxTZsllWVtNf9RIGrn88zMhJayQADLhwABL/WdPA=
Date:   Thu, 7 Oct 2021 23:41:12 +0000
Message-ID: <MW4PR21MB20022829D7F0CF0AE641F75AC0B19@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <MW4PR21MB2002654EE498023C6F2E40B5C0D99@MW4PR21MB2002.namprd21.prod.outlook.com>
 <87zgsgb8ob.wl-maz@kernel.org>
In-Reply-To: <87zgsgb8ob.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=38b02f94-854c-41e5-856c-3e31232b5ba8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-07T23:15:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce891330-2ac7-42e6-82c8-08d989ebf25b
x-ms-traffictypediagnostic: MW2PR2101MB1002:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1002552750437735A0C25F15C0B19@MW2PR2101MB1002.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJkRcaNqz6ZS4105Gmo7SrlVSyv0ADmH/HeuYBKPWQ1ZeKExD3NxC2Unbs45KLXIQ6jzjwfKKZJRf+pjrjRgCru/Fq7iNXnrUWPlPXSSRgYmnXzitBhcSe9jADdq3p8rNLQmr4rUbTlLVd4vzVq17S/OAjN0LiVBKUDQnly63epk5itlP8Ao6j/L0DeYSgxp9Nk7QELnkyY4EQAprLIhLoU12utOKoeY7ABAIkKe/YQRJft1wnxeA4dLK+zEAVp9f3Vx3Jx/jc7tFK6quPqMEPW0EzCdhnyGfpCfcRPML9T7zkJ5mxK5cweMnS582Ug4CkX4vGt6zzk9BchnpYKa9Bwbo2r7saNHf1D4S6vQueYrnikZpCxIKwRZoK219/5HhRfPKIOcJjjM/UZB2VIWsNU9fkjibUywwKKM6RowhiGQsV2dOqDVU0Rf2XxOXERY8B62EELjxJ/Au3FO4SEIrXb7FN+6VQ5uDWJ9mrghk6Al/1j3Em/H++IupKyU2CVC/+FgoQs8C/ss8bczjsqxQo5omARjjA9V0xHFsc2iUt6mrks3kElkgghggwD37X/Oba3QZhb0UO2m5ZoPo8QNfhZ/LXZzp1+xwQAU7CYOLPTDG97ficrkizYo5j3x0bseoy5UKIPrS2U2bXkS3pGh18EZqmKJDsg30WobNhU651zklM/0a6/FA2m6aCmOYwe0sI6Y/CILi9BwRQ4abv+bh3iiB0sRVDO+/6GKVvPTWu4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(10290500003)(33656002)(316002)(82950400001)(8676002)(38100700002)(55016002)(82960400001)(122000001)(9686003)(64756008)(66476007)(66556008)(186003)(38070700005)(66446008)(71200400001)(8936002)(7696005)(5660300002)(508600001)(8990500004)(52536014)(30864003)(2906002)(54906003)(83380400001)(86362001)(6506007)(76116006)(66946007)(4326008)(6916009)(53546011)(2004002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?QKupthtnuX0tZeoIShnafPtjLG94DhTi3tZh9j0JfSkIeL87hrJbKt2paa?=
 =?iso-8859-2?Q?zmGIwHVXQOnsJDc+CcfYO4kBzOpHkv6ACi7Ifq4A3zloyxTEyyJ62u3wy4?=
 =?iso-8859-2?Q?ZVLmQvScAoO5NNssNniEiaImXolBHfNY7ZQPWvpBgsmz1AuKImLv0IXGpX?=
 =?iso-8859-2?Q?aYNwIw1XLhxVdyf/cCv2pHHkgVxxJlg/JsvOFKXxDuHiVEYVmegclIcyk0?=
 =?iso-8859-2?Q?01kweUlEOWxfwguBytXfu6KEeonpTzCAx5GyXolZ9j9JU2/ohL3b8iSU+F?=
 =?iso-8859-2?Q?oc5WdxJ3pzDOMOLREr/Er+XNZCWFwtlrYbI9fTLmWjRsuTPEECMSN/nR6M?=
 =?iso-8859-2?Q?zNnI0evEOe62b9X2tAO413cJU2G/jsSUkaAogiBLNdWBu7JudQGHx37mOW?=
 =?iso-8859-2?Q?PgLIqnhWNOjzS+LZN+39MkSE6+yXfHz9HS46Ial7CdojIDLMaVNwSG7M0G?=
 =?iso-8859-2?Q?G8JEkftF+cONssao1ctwDj8+UyRswQ6Ha4kv/l4sj+i0Z2GOMtXh21g0SX?=
 =?iso-8859-2?Q?yvBgCtZvGGB0DIJZVrrgNGhXA97FK1DnlayFTsQtSIWKpeLUhGFTUsJCwK?=
 =?iso-8859-2?Q?QOmEaIe6HKMVYzQZp+Mc+kUWx/p2+LLbKXCE1v+x0EZ1nn/roF6xb9jT/N?=
 =?iso-8859-2?Q?5QKOU99gSeFN3Fz7IB+gP0K7NHjE1KdseSoH57JXrvAsPea8aN88bbYOXk?=
 =?iso-8859-2?Q?DCkNEGvPCL0TEKwH3ZrquyAu9B3aJkxG68WZXrDD1RjXvt4eKEIwZdEjtJ?=
 =?iso-8859-2?Q?dNt8k7I1L5w4VlfojrBE/x/PYPSHlQBgvLZo2OqvoAOhH2aiaMjtqKjCcu?=
 =?iso-8859-2?Q?83YrtvmK0FAhd7bW+GI68DiCV1Wkj+oZ4MZeblj3DQ12UMtXU37hXieRYd?=
 =?iso-8859-2?Q?zyAjCS5CN3eEWcDSVb2GFqEMZjtsJQvxkNnEa+nCr2/25ogE34hlBwa5cZ?=
 =?iso-8859-2?Q?78RSzrkclcgtACFYRSqufkw2lJVmauabPy9/1gSdTpGIfP7FxPk7ud5vlu?=
 =?iso-8859-2?Q?satM8Wxia56k4zIJuCWDUUtSZzGgNZnKtCoYgmT8K6gXhwmywLTNQjkYG4?=
 =?iso-8859-2?Q?tR/dppf+ZajDRKYX04Pq2AWoa6hl+C+QBlqxvdiYq3EGrYap2KNn2EM8wJ?=
 =?iso-8859-2?Q?kbwkGztp7XmXAc/Q1jhXlqi1OZ8Q5lriGkcUVF/i1iurqU2N2cX4D6rAQz?=
 =?iso-8859-2?Q?JMwQpB6lLkHd4m98e5jPT7/eH/gQx2YuQvBul2/fkm9gWjonbROx7xLRKC?=
 =?iso-8859-2?Q?nGaIlKpLgLLA+mRRogaMmKoVGDvPbWkZGDQl3io5jUtUPLqO6xhGBs6Ho+?=
 =?iso-8859-2?Q?vQmYk1euLZEqMnVBh0udLfDhldm3EwGjfg8sCxoDNP+WP8MjSC9C7iGaj/?=
 =?iso-8859-2?Q?9SfIIdcSoQIlqJR5n084pj63SN1mcsTWMfFiADS/srBU2gBZF2ndItRcR9?=
 =?iso-8859-2?Q?sJaJttwZbmQZnWf1?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce891330-2ac7-42e6-82c8-08d989ebf25b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 23:41:12.3341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6AfF6unhYaWPtZKQ+RHw2RwIVXL0jZknCQbrZ7eJJHa6rEdKWZl1y8q/UnfsaPS/Vj2iXmjYcRpPJRn3MzTRTM9tvK3HFtbAb2vlWOAy8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1002
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, September 13, 2021 12:03 PM
Marc Zyngier <maz@kernel.org> wrote:

> > --- /dev/null
> > +++ b/arch/arm64/hyperv/hv_pci.c
>=20
> Nit: this is definitely the wrong location. There isn't anything arm64
> specific here that warrants hiding it away. Like most other bizarre
> MSI implementation, it should either live in drivers/pci or in
> drivers/irqchip.
>
Thanks. I am moving all of this to drivers/pci/controller in v2.

> > @@ -0,0 +1,275 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Architecture specific vector management for the Hyper-V vPCI.
> > + *
> > + * Copyright (C) 2018, Microsoft, Inc.
> > + *
> > + * Author : Sunil Muthuswamy <sunilmut@microsoft.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License version 2 as
> published
> > + * by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD
> TITLE or
> > + * NON INFRINGEMENT. See the GNU General Public License for more
> > + * details.
>=20
> What is the point of this if you have the SPDX tag?
>=20
Will be fixed in V2

> > +/*
> > + * SPI vectors to use for vPCI; arch SPIs range is [32, 1019], but lea=
ving a bit
> > + * of room at the start to allow for SPIs to be specified through ACPI=
.
> > + */
> > +#define HV_PCI_MSI_SPI_START	50
>=20
> If that's the start, it has a good chance of being the wrong
> start. Given that the HyperV PCI controller advertises Multi-MSI
> support, INTID 50 cannot be used for any device that requires more
> than 2 vectors.
>=20
Moved to a power of 2, in v2. More comments below.

> > +#define HV_PCI_MSI_SPI_NR	(1020 - HV_PCI_MSI_SPI_START)
> > +
> > +struct hv_pci_chip_data {
> > +	spinlock_t lock;
>=20
> Why a spinlock? Either this can be used in interrupt context, and we
> require a raw_spinlock_t instead, or it never is used in interrupt
> context and should be a good old mutex.
>=20
Good call. Upon reviewing the requirements again, I believe we can get
away with just a mutex.

> > +	DECLARE_BITMAP(bm, HV_PCI_MSI_SPI_NR);
> > +};
> > +
> > +/* Hyper-V vPCI MSI GIC IRQ domain */
> > +static struct irq_domain *hv_msi_gic_irq_domain;
> > +
> > +static struct irq_chip hv_msi_irq_chip =3D {
> > +	.name =3D "Hyper-V ARM64 PCI MSI",
>=20
> That's a mouthful! How about "MSI" instead?
>=20
Will be addressed in V2.

> > +	.irq_set_affinity =3D irq_chip_set_affinity_parent,
> > +	.irq_eoi =3D irq_chip_eoi_parent,
> > +	.irq_mask =3D irq_chip_mask_parent,
> > +	.irq_unmask =3D irq_chip_unmask_parent
> > +};
> > +
> > +/**
> > + * Frees the specified number of interrupts.
> > + * @domain: The IRQ domain
> > + * @virq: The virtual IRQ number.
> > + * @nr_irqs: Number of IRQ's to free.
> > + */
> > +static void hv_pci_vec_irq_domain_free(struct irq_domain *domain,
> > +				       unsigned int virq, unsigned int nr_irqs)
> > +{
> > +	struct hv_pci_chip_data *chip_data =3D domain->host_data;
> > +	unsigned long flags;
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < nr_irqs; i++) {
> > +		struct irq_data *irqd =3D irq_domain_get_irq_data(domain,
> > +								virq + i);
> > +
> > +		spin_lock_irqsave(&chip_data->lock, flags);
> > +		clear_bit(irqd->hwirq - HV_PCI_MSI_SPI_START, chip_data-
> >bm);
> > +		spin_unlock_irqrestore(&chip_data->lock, flags);
>=20
> Really? Why should you disable interrupts here? Why do you need to
> lock/unlock on each iteration of this loop?
>=20
Good call. In v2, I am moving to using bitmap region to satisfy Multi-MSI
requirements and that should also take care of this.

> > +		irq_domain_reset_irq_data(irqd);
> > +	}
> > +
> > +	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
> > +}
> > +
> > +/**
> > + * Allocate an interrupt from the domain.
> > + * @hwirq: Will be set to the allocated H/W IRQ.
> > + *
> > + * Return: 0 on success and error value on failure.
> > + */
> > +static int hv_pci_vec_alloc_device_irq(struct irq_domain *domain,
> > +				unsigned int virq, irq_hw_number_t *hwirq)
> > +{
> > +	struct hv_pci_chip_data *chip_data =3D domain->host_data;
> > +	unsigned long flags;
> > +	unsigned int index;
> > +
> > +	spin_lock_irqsave(&chip_data->lock, flags);
> > +	index =3D find_first_zero_bit(chip_data->bm, HV_PCI_MSI_SPI_NR);
> > +	if (index =3D=3D HV_PCI_MSI_SPI_NR) {
> > +		spin_unlock_irqrestore(&chip_data->lock, flags);
> > +		pr_err("No more free IRQ vector available\n");
>=20
> No, we don't shout because we're out of MSIs. It happens, and drivers
> can nicely use less vectors if needed.
>=20
> But more importantly, this is totally breaks MultiMSI, see below.
>=20
'pr_err' removed in v2 and more comments below on Mult-MSI.

> > +		return -ENOSPC;
> > +	}
> > +
> > +	set_bit(index, chip_data->bm);
> > +	spin_unlock_irqrestore(&chip_data->lock, flags);
> > +	*hwirq =3D index + HV_PCI_MSI_SPI_START;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * Allocate an interrupt from the parent GIC domain.
> > + * @domain: The IRQ domain.
> > + * @virq: The virtual IRQ number.
> > + * @hwirq: The H/W IRQ number that needs to be allocated.
> > + *
> > + * Return: 0 on success and error value on failure.
> > + */
> > +static int hv_pci_vec_irq_gic_domain_alloc(struct irq_domain *domain,
> > +					   unsigned int virq,
> > +					   irq_hw_number_t hwirq)
> > +{
> > +	struct irq_fwspec fwspec;
> > +
> > +	fwspec.fwnode =3D domain->parent->fwnode;
> > +	fwspec.param_count =3D 2;
> > +	fwspec.param[0] =3D hwirq;
> > +	fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
> > +
> > +	return irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
> > +}
> > +
> > +/**
> > + * Allocate specified number of interrupts from the domain.
> > + * @domain: The IRQ domain.
> > + * @virq: The starting virtual IRQ number.
> > + * @nr_irqs: Number of IRQ's to allocate.
> > + * @args: The MSI alloc information.
> > + *
> > + * Return: 0 on success and error value on failure.
> > + */
> > +static int hv_pci_vec_irq_domain_alloc(struct irq_domain *domain,
> > +				       unsigned int virq, unsigned int nr_irqs,
> > +				       void *args)
> > +{
> > +	irq_hw_number_t hwirq;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	for (i =3D 0; i < nr_irqs; i++) {
> > +		ret =3D hv_pci_vec_alloc_device_irq(domain, virq, &hwirq);
> > +		if (ret)
> > +			goto free_irq;
> > +
> > +		ret =3D hv_pci_vec_irq_gic_domain_alloc(domain, virq + i,
> hwirq);
>=20
> Please read the specification for PCI MultiMSI. You offer none of the
> alignment and contiguity guarantees that are required.
>=20
Good call on Multi-MSI and thank you! I am looking to address this in
v2. But, the 'MSI_FLAG_MULTI_PCI_MSI' flag that we set today in=20
Hyper-V vPCI, even for x64 seems wrong and broken. We only allocate
one vector at a time from the Hypervisor. That's not going to work with
Multi-MSI. See 'vector_count' in 'hv_compose_msi_req_v2'.
Nevertheless, I do agree with you that if we are implementing something
new, we should be able to at least keep that clean. The Hyper-V vPCI
bug can be addressed separately.

> > +		if (ret)
> > +			goto free_irq;
> > +
> > +		ret =3D irq_domain_set_hwirq_and_chip(domain, virq + i,
> > +				hwirq, &hv_msi_irq_chip,
> > +				domain->host_data);
> > +		if (ret)
> > +			goto free_irq;
> > +
> > +
> 	irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq +
> i)));
>=20
> Why? The GIC is responsible for the distribution, not the MSI layer.
> This looks completely bogus.
>=20
Thanks. Will be removed in v2.

> > +		pr_debug("pID:%d vID:%u\n", (int)hwirq, virq + i);
> > +	}
> > +
> > +	return 0;
> > +
> > +free_irq:
> > +	if (i > 0)
> > +		hv_pci_vec_irq_domain_free(domain, virq, i - 1);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * Activate the interrupt.
> > + * @domain: The IRQ domain.
> > + * @irqd: IRQ data.
> > + * @reserve: Indicates whether the IRQ's can be reserved.
> > + *
> > + * Return: 0 on success and error value on failure.
> > + */
> > +static int hv_pci_vec_irq_domain_activate(struct irq_domain *domain,
> > +					  struct irq_data *irqd, bool reserve)
> > +{
> > +	/* All available online CPUs are available for targeting */
> > +	irq_data_update_effective_affinity(irqd, cpu_online_mask);
>=20
> Which completely contradicts what you have written above, and doesn't
> match what the GIC does either.
>=20
We will need to still support this as when Hyper-V vPCI composes the MSI
message (' hv_compose_msi_req_get_cpu'), it will pick the first available C=
PU
from online cpu mask.

> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops hv_pci_domain_ops =3D {
> > +	.alloc	=3D hv_pci_vec_irq_domain_alloc,
> > +	.free	=3D hv_pci_vec_irq_domain_free,
> > +	.activate =3D hv_pci_vec_irq_domain_activate,
> > +};
> > +
> > +
> > +/**
> > + * This routine performs the architecture specific initialization for =
vector
> > + * domain to operate. It allocates an IRQ domain tree as a child of th=
e GIC
> > + * IRQ domain.
> > + *
> > + * Return: 0 on success and error value on failure.
> > + */
> > +int hv_pci_vector_init(void)
>=20
> Why isn't this static?
>=20
Thanks. This is getting rearranged in v2.

> > +{
> > +	static struct hv_pci_chip_data *chip_data;
> > +	struct fwnode_handle *fn =3D NULL;
> > +	int ret =3D -ENOMEM;
> > +
> > +	chip_data =3D kzalloc(sizeof(*chip_data), GFP_KERNEL);
> > +	if (!chip_data)
> > +		return ret;
> > +
> > +	spin_lock_init(&chip_data->lock);
> > +	fn =3D irq_domain_alloc_named_fwnode("Hyper-V ARM64 vPCI");
> > +	if (!fn)
> > +		goto free_chip;
> > +
> > +	hv_msi_gic_irq_domain =3D acpi_irq_create_hierarchy(0,
> HV_PCI_MSI_SPI_NR,
> > +					fn, &hv_pci_domain_ops, chip_data);
> > +
> > +	if (!hv_msi_gic_irq_domain) {
> > +		pr_err("Failed to create Hyper-V ARMV vPCI MSI IRQ
> domain\n");
> > +		goto free_chip;
> > +	}
> > +
> > +	return 0;
> > +
> > +free_chip:
> > +	kfree(chip_data);
> > +	if (fn)
> > +		irq_domain_free_fwnode(fn);
> > +
> > +	return ret;
> > +}
> > +
> > +/* This routine performs the cleanup for the IRQ domain. */
> > +void hv_pci_vector_free(void)
>=20
> Why isn't this static?
>=20
Thanks. This is getting rearranged in v2.

> > +{
> > +	static struct hv_pci_chip_data *chip_data;
> > +
> > +	if (!hv_msi_gic_irq_domain)
> > +		return;
> > +
> > +	/* Host data cannot be null if the domain was created successfully */
> > +	chip_data =3D hv_msi_gic_irq_domain->host_data;
> > +	irq_domain_remove(hv_msi_gic_irq_domain);
> > +	hv_msi_gic_irq_domain =3D NULL;
> > +	kfree(chip_data);
> > +}
> > +
> > +/* Performs the architecture specific initialization for Hyper-V vPCI.=
 */
> > +int hv_pci_arch_init(void)
> > +{
> > +	return hv_pci_vector_init();
> > +}
> > +EXPORT_SYMBOL_GPL(hv_pci_arch_init);
> > +
> > +/* Architecture specific cleanup for Hyper-V vPCI. */
> > +void hv_pci_arch_free(void)
> > +{
> > +	hv_pci_vector_free();
> > +}
> > +EXPORT_SYMBOL_GPL(hv_pci_arch_free);
> > +
> > +struct irq_domain *hv_msi_parent_vector_domain(void)
> > +{
> > +	return hv_msi_gic_irq_domain;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_msi_parent_vector_domain);
> > +
> > +unsigned int hv_msi_get_int_vector(struct irq_data *irqd)
> > +{
> > +	irqd =3D irq_domain_get_irq_data(hv_msi_gic_irq_domain, irqd->irq);
> > +
> > +	return irqd->hwirq;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_msi_get_int_vector);
>=20
> I fail to understand why this is all exported instead of being part of
> the HyperV PCI module.
>=20
Thanks. Yes, this will all become part of the Hyper-V vPCI module in v2
with the code rearrangement.

> > diff --git a/arch/arm64/include/asm/hyperv-tlfs.h
> b/arch/arm64/include/asm/hyperv-tlfs.h
> > index 4d964a7f02ee..bc6c7ac934a1 100644
> > --- a/arch/arm64/include/asm/hyperv-tlfs.h
> > +++ b/arch/arm64/include/asm/hyperv-tlfs.h
> > @@ -64,6 +64,15 @@
> >  #define HV_REGISTER_STIMER0_CONFIG	0x000B0000
> >  #define HV_REGISTER_STIMER0_COUNT	0x000B0001
> >
> > +union hv_msi_entry {
> > +	u64 as_uint64[2];
> > +	struct {
> > +		u64 address;
> > +		u32 data;
> > +		u32 reserved;
> > +	} __packed;
> > +};
> > +
> >  #include <asm-generic/hyperv-tlfs.h>
> >
> >  #endif
> > diff --git a/arch/arm64/include/asm/mshyperv.h
> b/arch/arm64/include/asm/mshyperv.h
> > index 20070a847304..68bc1617707b 100644
> > --- a/arch/arm64/include/asm/mshyperv.h
> > +++ b/arch/arm64/include/asm/mshyperv.h
> > @@ -20,6 +20,8 @@
> >
> >  #include <linux/types.h>
> >  #include <linux/arm-smccc.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/msi.h>
> >  #include <asm/hyperv-tlfs.h>
> >
> >  /*
> > @@ -49,6 +51,30 @@ static inline u64 hv_get_register(unsigned int reg)
> >  				ARM_SMCCC_OWNER_VENDOR_HYP,	\
> >  				HV_SMCCC_FUNC_NUMBER)
> >
> > +#define hv_msi_handler			NULL
> > +#define hv_msi_handler_name		NULL
> > +#define hv_msi_irq_delivery_mode	0
> > +#define hv_msi_prepare NULL
> > +
> > +int hv_pci_arch_init(void);
> > +void hv_pci_arch_free(void);
> > +struct irq_domain *hv_msi_parent_vector_domain(void);
> > +unsigned int hv_msi_get_int_vector(struct irq_data *data);
> > +static inline irq_hw_number_t
> > +hv_msi_domain_ops_get_hwirq(struct msi_domain_info *info,
> > +			    msi_alloc_info_t *arg)
> > +{
> > +	return arg->hwirq;
> > +}
> > +
> > +static inline void hv_set_msi_entry_from_desc(union hv_msi_entry
> *msi_entry,
> > +					      struct msi_desc *msi_desc)
> > +{
> > +	msi_entry->address =3D ((u64)msi_desc->msg.address_hi << 32) |
> > +			      msi_desc->msg.address_lo;
> > +	msi_entry->data =3D msi_desc->msg.data;
> > +}
>=20
> Why do we need any of this? Why inline? Please explain what you are
> trying to achieve here.
>=20
This is because the 'hv_msi_entry' structure is defined differently by
the Hyper-V for x64 and arm64 (x64 doesn't has the high part of address).
And, so this is just to handle that difference.

Appreciate all of your inputs. v2 is coming up.

- Sunil
