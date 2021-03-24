Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84D73478B5
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Mar 2021 13:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhCXMmm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Mar 2021 08:42:42 -0400
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:43233
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232099AbhCXMma (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Mar 2021 08:42:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvghRojWpYl4kI4PsDvugQ2AuGNbsDRtwxyiIh2yQ4YyrJIVy/ycoOq7IhiCzuRGmaDRdY1MRnZnkKb9H3kAmGD4Ysm+6DZSYTj6za+wcM0NvqE/rwBugOjzz7DVGgAaOvbFciMBi3ObNPdLQF9e+XIb4CwgOzaCigvpW07B6dwSkLKPwd5wAuc1qtMsqo6dxuIuMJI6iV7gFmjJjWnsOMs/CVyAi2hG/9h5tsYtm4e/mDjZaTlLWkredLzgl+u/6P31dBdQpq3XtCmLN36xFHMNiu8lhQDnwtDZDcxd6NvW3yFPzBjbKJpmpxCMPY8GZcs+idtzOD1aVRFxs0Hyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa7rI1KExabqxewULxi7oredlsfCGLp0VRXUCfJ12fs=;
 b=Eto7ZML5wiqDPp/mC+64SaPavInF71PFJnrsUrK+WsfYBfSShr0ZV7cuXmiIOlYAH3XBfdB08rBRVdYKMPjFxQWLMzkw8MxjLBeUTJTT+zKx09coXyBd7/o/ZZSw3vEFsDKjGKsZjOQcC0Oew1T0GYUUkBhgGFwxMEsVUIp7gznjFVzpAeTckRlpwTJHRgFPjBSmrBDIw+xcesnzmzNxT1GNDzYu9hqum3qB2V4VuBBMZc6xG9ieJ63qP7ny92cqzktPETDaicf7us7tLkpezlYE6K5sS3U1H5xde31wr1tAwmZX/ETQ3WTTS0kB02cB8rXPWF5xvJOfG8+wSTr/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa7rI1KExabqxewULxi7oredlsfCGLp0VRXUCfJ12fs=;
 b=RewXu+tHENxocGk9hh4f7EyIwAPBhYAhA+NchPI9g4xWYJ0h2/anPDcXlnvA2399YsNjAOgwfxVIdXPlzegxloKKQQo/NgWjtJ4cbx+BT5tAvaREkFO3crPf6v3BdUZYjh5+HWtOoh+F25OCycEUiPoyIveRrZfmQnHe20UAyK0=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BY5PR02MB6419.namprd02.prod.outlook.com (2603:10b6:a03:1f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 12:42:25 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::2418:b7d2:cbb:27f]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::2418:b7d2:cbb:27f%5]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 12:42:25 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Marc Zyngier <maz@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Frank Wunderlich <frank-w@public-files.de>,
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
Thread-Index: AQHXH0vIUXC892kDXkW3zUak9HM8+aqTE3EQ
Date:   Wed, 24 Mar 2021 12:42:24 +0000
Message-ID: <BYAPR02MB5559A0B0DA88866EDC7BDFE5A5639@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <20210322184614.802565-1-maz@kernel.org>
 <20210322184614.802565-6-maz@kernel.org>
In-Reply-To: <20210322184614.802565-6-maz@kernel.org>
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
x-ms-office365-filtering-correlation-id: 2594ff9b-4419-44ef-03d1-08d8eec246c5
x-ms-traffictypediagnostic: BY5PR02MB6419:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB641923AE808606816E1375A3A5639@BY5PR02MB6419.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3e351za1hXq0K1JLY2vTfLReX0Uuwb+klTcgUzpvMRIeJDwLL/6YvZSz5ZEk1wIEQ5JemoaOBpQQAjBYdyCtWgU2nMIr8SaOtgCtyOfyu3iyDhRTVYpS1yjj5VcCTYLkS158/C2NtGQKogm8hKzN4tlrdq0BTrDqzAPG2UBvlIF9eULNHrB5oW7yZ/MQQ56nYLqM7ECU6U8Ca4+Nu9F2HZth/fX8qBs97Xg5Y3mMumoAUbJcbXf7/04J8fcv6cnAi8SLDY68pHLC1yHPIEyAwUBKwgFQ7Omvami1IuK0CkNsXv5pyjWCQEE1ClE0ZMEmO082FicZ5h3x0jvC7/Xcbj3TW92tfcjDs5ffs1Gj0btUerQKSv2blRc9ns6cTPNvMTCWHQ62WgHw33FhnpcudNIWB4edGdyl7oCmnF29lySud8IPz1s+F+V2Ag4kROv21SXzmqZgLAtvOO9NLihxBhU3GE4WFelZd2dD4VR2uprVKHDvXc13laoaO3tu0DrdOpBhb/ONHPsiczW7DMwjK9xAEGMGOVpLOvU93+mhjiMTaoXA77lhvlgUZX7zNLTb6Gc3iGlPtAuvQSU6pQ4o3NhLV45Z/SIFAIE3fypkxA+MvIZl15eUq+W82BeXumDQjAxIKfP4K7tmxpvLexTSUttzlU3KvVf+zFRvTtDNvOI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(83380400001)(7416002)(8936002)(186003)(4326008)(110136005)(54906003)(26005)(8676002)(71200400001)(33656002)(5660300002)(7696005)(64756008)(52536014)(66556008)(2906002)(66446008)(66476007)(38100700001)(66946007)(86362001)(76116006)(55016002)(316002)(9686003)(478600001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HQdovewaKhqmcNXou3OMpFnE3shsxdt0u320c+hiiSWg0DSC8I3bB0e69Kgd?=
 =?us-ascii?Q?W2u5v7JQh8h+mzmmiOBQjatnwrFpgIdRFAKJB0KXyM/prurM4+I7KW2IMV6i?=
 =?us-ascii?Q?LCghfxTMcCnq4QzdIgpUKtbdNh9WzFqzs/8o1ncGisjrjg5HEsKZXwvhVh/U?=
 =?us-ascii?Q?voZTUmwCQ2hSHSJbFZIKU04cSp9pkqRZ1klDY40hjDkeeyNEzhBwVdZTk7B6?=
 =?us-ascii?Q?UoeXvu86NeNteSKtAH0RC4BEqQHSwisbAPtXpSC09FELRqigwhgcFylfDkU6?=
 =?us-ascii?Q?vldHG4Hf7hwNalBOpqK/7wFU23u7vILLVH8qxGb49XqnuwTO/psSrcynEcrk?=
 =?us-ascii?Q?lidPzCWP9BO87kbtA75Q0WRwX3V8Kr1lc2r/d18x9xhaZOchRIAT6W0up9AG?=
 =?us-ascii?Q?Qk3rS3s9inIWB4AfKxY3Du1DwhTgyzzUo8evS8uNOopk2c6/Tl5pnJb20z3l?=
 =?us-ascii?Q?fb9qjLIAg55vr3ECwPtmcwzngu0I4/F50fKMnX8s2ikkNrZ6AQTrjNGl3r6y?=
 =?us-ascii?Q?BSewaCQFSukLs4vKYidqi39JMp2IfChxDzUCpVIi034zka/vjc96lUaastE9?=
 =?us-ascii?Q?tjcGrK1xLHbGrruCrNHjU72cga6twqtfGSOVfLSXUa846TFRgI4tv867ybq+?=
 =?us-ascii?Q?pOHguFds5OY1wgzzJb4YmjhWbKLmKYaiPkzblncSCrp7Au0SV82eSSOU7k8H?=
 =?us-ascii?Q?k3hz7XkUPSz4tEwrCKmTWin04i3tS7JIAMFfx9m4PWpbcI/pTBAapWvBZXC6?=
 =?us-ascii?Q?VlrS449SfihUJwjxm9Oc3ySQ+Uop1wBIFoOy2aPv8Y+WjR4la+f2zD6KYfhe?=
 =?us-ascii?Q?zeI0KKP3toKJ1OCisxTAi0zb3Vebnk+lEX16Yuw0PnX4JI7Psbx1QYaQ9i62?=
 =?us-ascii?Q?c/hC9t4TB4DgRYhA2JrAfMnsSNscjfCE4Kp5sWiuETNPw8WuNG4RgKB19fJh?=
 =?us-ascii?Q?yo5Y3WugmvbEOuNjMEp897qfjPnIYYW7On9pkaRruHmw2eqFWnPop7VWtwU8?=
 =?us-ascii?Q?T+QBpPWdY0AE25sdmbndVEH3pDcTCE3GhjhXFI4Kyn+OD6+OTBRGrktYHzFr?=
 =?us-ascii?Q?iCxGs0WD1SaHqZSg0PQdgL+WDsfIdZgt+PWSjqgNQM7f8WeWKyBThD2DsJk7?=
 =?us-ascii?Q?ZTqIfRhOYnHjbMampVOlyspfA1WSOZkeuEtWvcnT28LGvFBpOrPBNxrFmmfL?=
 =?us-ascii?Q?q+wmTHvXmVrHvNPunfybc4smKyApl0Jmv0T+tmk6r+qEA0M5Tsx2DBErN8FE?=
 =?us-ascii?Q?g3SozEFUazLktE4gg5usIPkxnpZu7fvpCqEX53WAmqIhuz6Vx5JXaNZKHQwV?=
 =?us-ascii?Q?yGT8tR1YyDXKQPZLY4mDFfXe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5559.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2594ff9b-4419-44ef-03d1-08d8eec246c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 12:42:24.8759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVrrKU6jxdP540Y8lOK3my9rbhFLFELgCtmpNzKU3jOcisQo3pizXC/Yt09ZuymLYdWSf9w8z5KugnjguTMn6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6419
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Marc,

Thanks for the patch.=20

> Subject: [PATCH v2 05/15] PCI: xilinx: Convert to MSI domains
>=20
> In anticipation of the removal of the msi_controller structure, convert t=
he
> ancient xilinx host controller driver to MSI domains.
>=20
> We end-up with the usual two domain structure, the top one being a generi=
c
> PCI/MSI domain, the bottom one being xilinx-specific and handling the
> actual HW interrupt allocation.
>=20
> This allows us to fix some of the most appalling MSI programming, where t=
he
> message programmed in the device is the virtual IRQ number instead of the
> allocated vector number. The allocator is also made safe with a mutex. Th=
is
> should allow support for MultiMSI, but I decided not to even try, since I
> cannot test it.
>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pci/controller/Kconfig       |   2 +-
>  drivers/pci/controller/pcie-xilinx.c | 234 +++++++++++----------------
>  2 files changed, 97 insertions(+), 139 deletions(-)
>=20
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> index 5cc07d28a3a0..60045f7aafc5 100644
...


> +static struct irq_chip xilinx_msi_bottom_chip =3D {
> +	.name			=3D "Xilinx MSI",
> +	.irq_set_affinity 	=3D xilinx_msi_set_affinity,
> +	.irq_compose_msi_msg	=3D xilinx_compose_msi_msg,
> +};
>=20
I see a crash while testing MSI in handle_edge_irq
[<c015bdd4>] (handle_edge_irq) from [<c0157164>] (generic_handle_irq+0x28/0=
x38)
[<c0157164>] (generic_handle_irq) from [<c03a9714>] (xilinx_pcie_intr_handl=
er+0x17c/0x2b0)
[<c03a9714>] (xilinx_pcie_intr_handler) from [<c0157d94>] (__handle_irq_eve=
nt_percpu+0x3c/0xc0)
[<c0157d94>] (__handle_irq_event_percpu) from [<c0157e44>] (handle_irq_even=
t_percpu+0x2c/0x7c)
[<c0157e44>] (handle_irq_event_percpu) from [<c0157ecc>] (handle_irq_event+=
0x38/0x5c)
[<c0157ecc>] (handle_irq_event) from [<c015bc8c>] (handle_fasteoi_irq+0x9c/=
0x114)

void handle_edge_irq(struct irq_desc *desc) {
...
        kstat_incr_irqs_this_cpu(desc);

        /* Start handling the irq */
        desc->irq_data.chip->irq_ack(&desc->irq_data);	//There is no check =
here for ack function is registered for chip
..
}

> -/**
> - * xilinx_pcie_msi_setup_irq - Setup MSI request
> - * @chip: MSI chip pointer
> - * @pdev: PCIe device pointer
> - * @desc: MSI descriptor pointer
> - *
> - * Return: '0' on success and error value on failure
> - */
> -static int xilinx_pcie_msi_setup_irq(struct msi_controller *chip,
> -				     struct pci_dev *pdev,
> -				     struct msi_desc *desc)
> +static int xilinx_msi_domain_alloc(struct irq_domain *domain, unsigned i=
nt
> virq,
> +				  unsigned int nr_irqs, void *args)
>  {
> -	struct xilinx_pcie_port *port =3D pdev->bus->sysdata;
> -	unsigned int irq;
> -	int hwirq;
> -	struct msi_msg msg;
> -	phys_addr_t msg_addr;
> +	struct xilinx_pcie_port *port =3D domain->host_data;
> +	int hwirq, i;
> +
> +	mutex_lock(&port->map_lock);
> +
> +	hwirq =3D bitmap_find_free_region(port->msi_map,
> XILINX_NUM_MSI_IRQS,
> +order_base_2(nr_irqs));
> +
> +	mutex_unlock(&port->map_lock);
>=20
> -	hwirq =3D xilinx_pcie_assign_msi();
>  	if (hwirq < 0)
> -		return hwirq;
> +		return -ENOSPC;
>=20
> -	irq =3D irq_create_mapping(port->msi_domain, hwirq);
> -	if (!irq)
> -		return -EINVAL;
> +	for (i =3D 0; i < nr_irqs; i++)
> +		irq_domain_set_info(domain, virq + i, hwirq + i,
> +				    &xilinx_msi_bottom_chip, domain-
> >host_data,
> +				    handle_edge_irq, NULL, NULL);
>=20
> -	irq_set_msi_desc(irq, desc);
> +	return 0;
> +}
>

Regards,
Bharat=20
