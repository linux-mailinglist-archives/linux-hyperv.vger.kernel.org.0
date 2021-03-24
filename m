Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3473347A04
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Mar 2021 14:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhCXN4h (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Mar 2021 09:56:37 -0400
Received: from mail-eopbgr770052.outbound.protection.outlook.com ([40.107.77.52]:45554
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235793AbhCXN4T (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Mar 2021 09:56:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UllG1U6PCB15oD7uRc49V7sBJMcZQxQiUU+6W6D/N1M/pKg3P+eRfzgmkiZ9G04MbqeXpNdicmdQtaTx+L//trkTwxsnT4TFohEXNwChw5/9tmvxja074PK10V1aSPAvaGH2o4RHEWze813i44+JTfvc86UtibRWpTWFhaPByh+2zKRFxS99+PVEtceBZYUImWvwDHpIPoTj67TfQBX1lXWFsdQlba8FuejzWXYDtW9Gai5ToRFrdoCBruYiepXM6D42Exd1q+UNz9LvybJ30CZk+x5K30fS6YA9jnWd8vRmaPwPGdwfAdHfkxT0C3182pAjsQDTbemPoatWSysz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ma9VBPHSJAXFz8V/7f6vlUdnTsmXhusqfeS8VBf/+F8=;
 b=WTFegcHr7dmqi5LZrw5wdfqdRlAd/7+gOhWykokZ9ZuQPNSJNTSiXxfmSUhKL78fEoIEJfSFdmHHtpJ1FCYfX8K6hU4jcWw9aIR/4Atx2ts7YvY3HscIVA1zvEHphTeIfOi2ROhON/jlr+lnnAtstu8GltyX+UEu3E5BUAq1CyLJBjLJacmZA0HeCw02tPey8LsDoNydgSaHOytUkiw5Vciujpa8YLflARwYLmpwpqkeqe/QHPyCjbe3w1CwOCdZga4iKlmU+ippXFe5RaucmkhmdK0v9FJDM/JsuALNgvSl6oys7QfSWHSQN2VDFm7Yxf54rflhasx7CaLVIExDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ma9VBPHSJAXFz8V/7f6vlUdnTsmXhusqfeS8VBf/+F8=;
 b=mPVPVpnt242CMk7u5TsK81fEABamInPBxZM9ujWOaGT1KzXriaZsyHwirC7i5b9Tggcx7IYYwr4/R8nM1iQhy7KTxaCipCRBSquUa1FB5sFYeCar5mt79RAEHkGHAkFmGLfiqeNoX7RUIKbvlmzqfrICs3T5HP6kWwRe6fT0r8A=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB5429.namprd02.prod.outlook.com (2603:10b6:a03:99::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 13:56:16 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::2418:b7d2:cbb:27f]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::2418:b7d2:cbb:27f%5]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 13:56:16 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Michal Simek <michals@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: RE: [PATCH v2 05/15] PCI: xilinx: Convert to MSI domains
Thread-Topic: [PATCH v2 05/15] PCI: xilinx: Convert to MSI domains
Thread-Index: AQHXH0vIUXC892kDXkW3zUak9HM8+aqTE3EQgAANhwCAAArBcA==
Date:   Wed, 24 Mar 2021 13:56:16 +0000
Message-ID: <BYAPR02MB5559590C1395C15205582976A5639@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <20210322184614.802565-1-maz@kernel.org>
        <20210322184614.802565-6-maz@kernel.org>
        <BYAPR02MB5559A0B0DA88866EDC7BDFE5A5639@BYAPR02MB5559.namprd02.prod.outlook.com>
 <877dlwk805.wl-maz@kernel.org>
In-Reply-To: <877dlwk805.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a388b3a0-3cba-402d-98ce-08d8eecc983e
x-ms-traffictypediagnostic: BYAPR02MB5429:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5429BAB4DD62B44DA18CCE72A5639@BYAPR02MB5429.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WdJg/UkTD7+8URxl0VsYK0Y03V+knyrmOmTNRONz/qBAgPabt+aY3KrUrw0BNkxNOaEUeZzHKjjRQaVpd7x2uOcptVipZQI8/zraYxtbXNzJu5tygid98dReUEkSHk5N/pG61jKXaLdfGvIEM6vECRLGgtR9TvXbVxCV+w2NUGxIxzPp7v5boWC2lujQwK+fy5U/EZdyQ7HrX0jE/oGVy/SkhpqTYBzL7c602j0uqOmTzONt+QN3h2BNxIESvSEIT0OGYUUgj2BYu8xtSTVC5BCjljvpA9hW7pusiAWfclTR4jLzHbHcG3fl+e2or5n19UD4qp9Blgspry4mBRGBMZadW3r7+2ze6JZeP9vtXBGc3c/s3QTmRYoo+ngW8kgsrsgYiJPgYVx74ghb7JmXQi+45d8E2KIeW47N/QZU7rWmDSyzOCpBOJ4m/uYc+6MONSsgBtyDO6dln8PmxtZhu6Z/1RK5/Rl7K+Serp1/fvDIAztzb5nXO3KsnN+OdjtfILl8g1SMVmwrEmqo6wwNX64PyLDQCM+6ZpG2pK3S8rSnnA9MpDLFJeAio45gp1vHOknWw+vHCBPiFerdEGna4gQsN0jsoQhTVHp37KGAIfiYS2WuzHpt8wTmbl53vAiSt1IVYT4HR6K0BVqQw6OHyWJZND2GOkcVv2k2J6P3Brw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(6916009)(4326008)(478600001)(66946007)(64756008)(76116006)(54906003)(66446008)(7696005)(38100700001)(8936002)(86362001)(66556008)(52536014)(5660300002)(55016002)(2906002)(83380400001)(71200400001)(316002)(33656002)(9686003)(186003)(8676002)(7416002)(66476007)(6506007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CwCz9iBx19ly093Y32ZCmxPnp5bUFISqk6soD9jZRlhaMCE0dTKDnc9F7qyr?=
 =?us-ascii?Q?4NwH72Xshat9crKQVTFWqTtX5Ugfy19hmM5Zs0YrPzahML32G1GOIRPp4Jmo?=
 =?us-ascii?Q?fCUSPkYTxg31hFohiG92aPo5nE/Jp5m23KJyxLH9RP+0dSetzpigSi66Bdbl?=
 =?us-ascii?Q?dzfxSI5fVtdgKJiQHYKPoHaraX1SJ4uKIYqdqM8FQmhPxQMxqap+S2hasJ4l?=
 =?us-ascii?Q?bMCDWvaGnKDvjxX3MWt6kD79N31Q71nXAUMJDFzpAAYp8JjybPkqnNqUAbx0?=
 =?us-ascii?Q?58RW8pkV7MgTe01CtgZJiK96acbymmBeoWaNDk6PekCLu2WsS+ZDPEb5zcJR?=
 =?us-ascii?Q?B7XyIixW+Ef8xd+XDJojVczdD/TiXNOT9almZAS3SSI0wmIw/YwYVqOjoNZw?=
 =?us-ascii?Q?0bttGHFvdP90Tt5cq3eaKPeZYKoWgrTdAdlNBdypKwIUBcqhJiKPAf3XAggN?=
 =?us-ascii?Q?k1TGDT/O8YJPFeQWIq7Wgpn+li77RGB6ohujsirASHxHRbkCLAcrwZK7Mamz?=
 =?us-ascii?Q?V3SQ/DohD2hqvyh/B+Bm3pgZWj6KohOl9oFgTrQ2juX0XmSxbSErEJ8BYdzL?=
 =?us-ascii?Q?eI0S/nNu/xLx+2VVzbyO2ycps896RKZ8gu4IQpMFQO+SSftGL3qaqCn1Qa/i?=
 =?us-ascii?Q?kNPBxIJtBTJKCgphQTbE74qwzzcI2Sj74D4j+GnPNq0jJfnHTwlvV+UxylZL?=
 =?us-ascii?Q?y8kxO1aTEpaklB6YJ+xdo1czdRa2W+rdz4sQarHCYjaOnVYnYcHnEMVcuvfx?=
 =?us-ascii?Q?t6M0yQyIy4WizHvNeuR3EJco9awTsqvzOJ0CP8GnlQICJph2/FEeKnd2J6K8?=
 =?us-ascii?Q?qk4rUZglhFeKbtdZVVM2stXhLrKbd5ZdldC0obdDl+FKpIr+e1bjquy7dyXF?=
 =?us-ascii?Q?n4OkWS19kntodaZM5wrJRQPQHq04MMUcNNPjq6lQ3ub0y+pSDJoAHvAj52qj?=
 =?us-ascii?Q?9P097yJsTpZOC/8jn2UY8Za/TcXQ3KuQCWMU5HV1RRfbGAbhUI3ADFwd80bQ?=
 =?us-ascii?Q?Xj4ejVQpCMVk1lnBojvGsVc799L7gy739JFMg/L238C+I4wSdKVZLQB6Mhsi?=
 =?us-ascii?Q?zVmQSRrbVmG/relfKuRwPvh9H/wCB2T26zE5wSB4M2KQ4N2qNld0jGrG6lyC?=
 =?us-ascii?Q?gORCNN/dM1IE4xocFkbbgj8xGueRCgpnVeUAb/s208bBkgjxVJk5rGaUOfyl?=
 =?us-ascii?Q?jwTOTDpfjojIzkkim09eK/fsba516LJCO/hvEGJLvb8OStR34rkM0R/KvQyL?=
 =?us-ascii?Q?7Q/cJA/jbbfRIlDBstsAK0iYZRl+yYDzZFABgu+bFx8vnq1fPV69V9fd2q1o?=
 =?us-ascii?Q?og5qiPX0vJhOBpoJgq03IjE8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5559.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a388b3a0-3cba-402d-98ce-08d8eecc983e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 13:56:16.5814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sF6iO+SVrS+nD9WueX/IqrzeK3Jd+fsj7QFytRUl1raTRGI2hNDQoJME87yOa6BQ+hP9a2SeKxYNyAAt5LqSsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5429
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > Hi Marc,
> >
> > Thanks for the patch.
> >
> > > Subject: [PATCH v2 05/15] PCI: xilinx: Convert to MSI domains
> > >
> > > In anticipation of the removal of the msi_controller structure,
> > > convert the ancient xilinx host controller driver to MSI domains.
> > >
> > > We end-up with the usual two domain structure, the top one being a
> > > generic PCI/MSI domain, the bottom one being xilinx-specific and
> > > handling the actual HW interrupt allocation.
> > >
> > > This allows us to fix some of the most appalling MSI programming,
> > > where the message programmed in the device is the virtual IRQ number
> > > instead of the allocated vector number. The allocator is also made
> > > safe with a mutex. This should allow support for MultiMSI, but I
> > > decided not to even try, since I cannot test it.
> > >
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > ---
> > >  drivers/pci/controller/Kconfig       |   2 +-
> > >  drivers/pci/controller/pcie-xilinx.c | 234
> > > +++++++++++----------------
> > >  2 files changed, 97 insertions(+), 139 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/Kconfig
> > > b/drivers/pci/controller/Kconfig index 5cc07d28a3a0..60045f7aafc5
> > > 100644
> > ...
> >
> >
> > > +static struct irq_chip xilinx_msi_bottom_chip =3D {
> > > +	.name			=3D "Xilinx MSI",
> > > +	.irq_set_affinity 	=3D xilinx_msi_set_affinity,
> > > +	.irq_compose_msi_msg	=3D xilinx_compose_msi_msg,
> > > +};
> > >
> > I see a crash while testing MSI in handle_edge_irq [<c015bdd4>]
> > (handle_edge_irq) from [<c0157164>] (generic_handle_irq+0x28/0x38)
> > [<c0157164>] (generic_handle_irq) from [<c03a9714>]
> > (xilinx_pcie_intr_handler+0x17c/0x2b0)
> > [<c03a9714>] (xilinx_pcie_intr_handler) from [<c0157d94>]
> > (__handle_irq_event_percpu+0x3c/0xc0)
> > [<c0157d94>] (__handle_irq_event_percpu) from [<c0157e44>]
> > (handle_irq_event_percpu+0x2c/0x7c)
> > [<c0157e44>] (handle_irq_event_percpu) from [<c0157ecc>]
> > (handle_irq_event+0x38/0x5c) [<c0157ecc>] (handle_irq_event) from
> > [<c015bc8c>] (handle_fasteoi_irq+0x9c/0x114)
>=20
> Thanks for that. Can you please try the following patch and let me know i=
f it
> helps?
>=20
> Thanks,
>=20
> 	M.
>=20
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controlle=
r/pcie-
> xilinx.c
> index ad9abf405167..14001febf59a 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -194,8 +194,18 @@ static struct pci_ops xilinx_pcie_ops =3D {
>=20
>  /* MSI functions */
>=20
> +static void xilinx_msi_top_irq_ack(struct irq_data *d) {
> +	/*
> +	 * xilinx_pcie_intr_handler() will have performed the Ack.
> +	 * Eventually, this should be fixed and the Ack be moved in
> +	 * the respective callbacks for INTx and MSI.
> +	 */
> +}
> +
>  static struct irq_chip xilinx_msi_top_chip =3D {
>  	.name		=3D "PCIe MSI",
> +	.irq_ack	=3D xilinx_msi_top_irq_ack,
>  };
>=20
>  static int xilinx_msi_set_affinity(struct irq_data *d, const struct cpum=
ask
> *mask, bool force) @@ -206,7 +216,7 @@ static int
> xilinx_msi_set_affinity(struct irq_data *d, const struct cpumask *mas  st=
atic
> void xilinx_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)  =
{
>  	struct xilinx_pcie_port *pcie =3D irq_data_get_irq_chip_data(data);
> -	phys_addr_t pa =3D virt_to_phys(pcie);
> +	phys_addr_t pa =3D ALIGN_DOWN(virt_to_phys(pcie), SZ_4K);
>=20
>  	msg->address_lo =3D lower_32_bits(pa);
>  	msg->address_hi =3D upper_32_bits(pa);
> @@ -468,7 +478,7 @@ static int xilinx_pcie_init_irq_domain(struct
> xilinx_pcie_port *port)
>=20
>  	/* Setup MSI */
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		phys_addr_t pa =3D virt_to_phys(port);
> +		phys_addr_t pa =3D ALIGN_DOWN(virt_to_phys(port), SZ_4K);
>=20
>  		ret =3D xilinx_allocate_msi_domains(port);
>  		if (ret)
>=20
Thanks Marc.
With above patch now everything works fine, tested a Samsung NVMe SSD.=20
tst~# lspci
00:00.0 PCI bridge: Xilinx Corporation Device 0706
01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD=
 Controller 172Xa/172Xb (rev 01)

Regards,
Bharat
