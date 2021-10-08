Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CA6426F7D
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Oct 2021 19:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhJHRX3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Oct 2021 13:23:29 -0400
Received: from mail-oln040093003003.outbound.protection.outlook.com ([40.93.3.3]:5171
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231217AbhJHRX2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Oct 2021 13:23:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOtrpgsTr7nS4Lp5oNiKy+IEdFGBW/li+gL+KA0IgmNBwW38H5Kz9QzdAD6gao4692PD10CeERsiFvSgxXzPTMpbBNHPxROyClc2gmM624KxR9gf5eEH3Npvn1SslPMVCluPBuEXORo2r0BiskubiJVtyJAhBgNUUdbYG6op5Xmzt6c5yVlpEPqpEYFnYgf6UEkjxzE6MckFlmXrlPg39oNzwdip+RO7x+RED8AiuASzJfTOKKmoTnc91lWX7eMckfF+WFNiUm0OKagVwH/H6lN3a/gAKjgPfMyIiG+EiuhgoB8RIEQj4SzHK+wTphX7Pa2zG8yR14qyrcm7yCwcvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eEuKBd7Ay6pJYDUhhzSOldIdM72wrxCrAtaAXCNRsQ=;
 b=VQSd7/gGrIcgqcns6i7745TijTuAhufOZ84/aM7pEtEFrBzT9wGychrhZJhIR7j0DDt396w97usFNLwXqT9qmDoZrD/r8CCreHcUmtkql6wAKCscQXBCIDwOTZZrahX4IzBFvPmpwvmTqkgZD4FmyCK7ogsjd+OLc398oDVvkQEBMPGNbfO7mUMF0sr5sUaPBXlYqzJmHKbWwavNCryfCLiKU8UTIn1pufdzkcn/TBznWZlA/FFnCVC7DCO7Z4bj7/xrN9jm9jRnypeHVTC0xn9ja3MB2zza5fne3xVpGC3Ru1FcP1y4UK/KmFKBvwt3yM7nzJ2mXq+5OG8HS9TUrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eEuKBd7Ay6pJYDUhhzSOldIdM72wrxCrAtaAXCNRsQ=;
 b=Bs31Cez480v/ko70A+VyUXXodvjNEVGM6shJuwO8ZRWekK3xN/XO9+ecYAUL3SI2fJDmzPIrmvdQzu3T8AZDyJnniVuv1FX6POoExawT+Vf70A4794ku12AHCcVnQ+Opb2otENxE59KZFEidHk2C4cfFPyI5h4iwKlGhQsQwTBU=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MW2PR2101MB1049.namprd21.prod.outlook.com (2603:10b6:302:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4; Fri, 8 Oct
 2021 17:21:29 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::89fe:5bf:5eb2:4c55]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::89fe:5bf:5eb2:4c55%4]) with mapi id 15.20.4608.008; Fri, 8 Oct 2021
 17:21:29 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Marc Zyngier <maz@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?=22Krzysztof_Wilczy=F1ski=22?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] PCI: hv: Support for Hyper-V vPCI for ARM64
Thread-Topic: [PATCH v2 2/2] PCI: hv: Support for Hyper-V vPCI for ARM64
Thread-Index: Ade8aA2v7N19jp6XTU2lQwhKOEXJNw==
Date:   Fri, 8 Oct 2021 17:21:29 +0000
Message-ID: <MW4PR21MB2002619B2F7EEB9B1C4F5712C0B29@MW4PR21MB2002.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=977fe94e-ee0a-4530-9ff9-e2b7cc82b99a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-08T17:12:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed359b89-b2af-41d6-3f83-08d98a80110e
x-ms-traffictypediagnostic: MW2PR2101MB1049:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB10495E8D7ED5AB284CA83D17C0B29@MW2PR2101MB1049.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WWOvU6EMjP84jHuI/NgD+wFtYDU+qYCFItac7MJKfMnkNLFGjFPb6DxO8jiin2AIf0Fcu4qcZ7c1w8yOdJPJk4okybV1tSvxW185bTKc7z1yjPtPNaohDMpw4+MnFpZZWss/uRvq3k8SF0eKvvSoFr6WKaRh9yo5tJUghFfzF3BfA1ZDZfcyh7M0Rvspn6OaKM94bg0DlB/y3aWd/4lQX0jJWvBIcYN7te15IedkLPMo8ZaU0ovUTZv/Q84cTEsrwJQ7P6fcQgi7W2QPdEr7rDInQ4ZdUn/YAwMNwLojAHhrFTbp+z0eh9gFW7JpePU3qV22XCYRp6jmlAToGIf0IFoCOf+5o2hRRBnaIL2aKM3o7aZ80D6EIUrxQElOVdktDj613MUtPjXwvLz8KK2ASDdecMXRkE1QJWNkvywxp1Bd173P6ffI0SvG2DsfKEsiM/KFUvYXj9GDm3fFJ8K7Efqb+HCi/z0FJ9o0zqXLNxRAcu8OnCO7LGXTYNUqimCfBLvMRMF2W77UZW53tA51Elb61YExUcN06JHeKKsEj7xDVHsMLGL6eRnzldmmOimecaGlYzDi3AInQur7j99kpFbjcX5YFSiCKJ7JQlIR5f2+01IlDnx+60bcHXEcxh3NgqMAJfVK4dFacuQ8bsQ18kgMZFfjBLRARhIDGaMmGu8f4488IzdsRnA9iD+Vl+SSDti8XbxwwPtBeM5BSIenz3BQOPjCTT9Cn8vjNp2s15s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(71200400001)(8990500004)(86362001)(5660300002)(10290500003)(186003)(4326008)(82950400001)(508600001)(76116006)(66946007)(82960400001)(33656002)(8676002)(6506007)(921005)(122000001)(2906002)(66556008)(9686003)(54906003)(66476007)(8936002)(7696005)(316002)(66446008)(64756008)(38100700002)(83380400001)(110136005)(55016002)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?9G+4+lVTnXsrYpA00TyeWzNK9+9s1dhwpPd0XNen1DD5cAiivN9PiZXfZY?=
 =?iso-8859-2?Q?j96VHStA0lOc+5PlyxqMZHi0Cu3hC7Y3MpS06+4NQK/yvqDCetUyktP0xj?=
 =?iso-8859-2?Q?OnmEWWbLRgpZ8iYHE7cJXuZl/VffEhhpasbhGh5TrxRJw6q2P1mCgM4ybb?=
 =?iso-8859-2?Q?YOpMLaZY+4ZO2Jow0ZQUB1mf7+9Rc81ucNF1t9QM4XtxeG4D3AScf9EZZM?=
 =?iso-8859-2?Q?aZulxxMEo1viVfgiCmYtGr7LcbBB1XAvAlSohUe+8xxpvAuEKe7KiIeQvU?=
 =?iso-8859-2?Q?Y969JhxZ61XeXW4L+zZevVh/38HiexzizJ97gBr7+Bmbj4+ReuffPZlt6j?=
 =?iso-8859-2?Q?oz7tL/4UbLgNqN2LZfY0vgM1/L2pZDpFfu6in/BYcVns4ApvVMsQCGu9yZ?=
 =?iso-8859-2?Q?0I2vEyO7+3wV7xpeXFDV1UPqCfKXptijEQN30jZlPpf+XOzDW8DUWO46PB?=
 =?iso-8859-2?Q?wG1ByV/4XwcKpwLwJ2FXWrKMn/gLrmcOsWJQgmuZJciicd3tV+gEIgqftO?=
 =?iso-8859-2?Q?clix43pgmfwSMoHPm/cXEUaCJm4lGq8Uu/Q1GZKbXK08VH4TY7hu9wJ3+i?=
 =?iso-8859-2?Q?/bo9qWQN8+at7HaDU02oZqHUniDuWZICtLbx93uure0D92/jKtdU0wSi/2?=
 =?iso-8859-2?Q?L/DWkurMz4Hn+u1yhzuWgPRu/BkqstHkwEkZvfasiecEOvmaoKoNuq/iG8?=
 =?iso-8859-2?Q?qlUP3oel/L5wYI/w0+9IlUtlUw8lCGvo7VIRatgbXAkaUpwU3f8OB6uOue?=
 =?iso-8859-2?Q?lVay/18oRmpojru7sDacd1PSWOdqS17x4UCT6ZzUJ247bESwxh/IhdH7fq?=
 =?iso-8859-2?Q?POXCwo8RH6FSdiG1RipEu2ZARI/1CO6UyYvZHIVZN8TRJwT5tQcG1Ns9o5?=
 =?iso-8859-2?Q?revVFsK//7KMyhmVbXkeW0LdJw0X0Kom9BdpQJKpItBgCrDfCe+X0bqBp4?=
 =?iso-8859-2?Q?C2/Wm3GVWlUPQArNp1RqS27F4nHNpIPPE1lnpqnbf8SPFh8Rqm+dZNmZEF?=
 =?iso-8859-2?Q?2drR2/cLEJhlv+JqYhYz2B718IuHXlrucHgdThOllcREUlmKvprqBgsvYZ?=
 =?iso-8859-2?Q?miqVFggPRHSxnUndeWVX0A08T4qIPwhaBigAiXuWsO7rZFbIAIozfQ/gOF?=
 =?iso-8859-2?Q?99Ine0rjWB7wygkNBP2c4sueXOcRUcbjF8da9om3kC2WbwVmwYrV71/cA0?=
 =?iso-8859-2?Q?elOiS/fHHQ03lUaZlYn51AEBktpznB/rRfFF+lrxIFmeyX3sypiccTyEyZ?=
 =?iso-8859-2?Q?sAQ8gRMtJN3wAgOr7Q4vIY+r2ozGUwA6MchtEc+49ywHgzUDxyY5fyufvB?=
 =?iso-8859-2?Q?vrryDJiJPabbDE/Phpprssyo29edwp1MuuS2Pj2Yw0szynYDwzFCYh5y6+?=
 =?iso-8859-2?Q?FNvVzxUCJ1MIySNzokyiGfDsq2CNDUPAnKsrOLsW+fjuPotcRC6bwN7Irj?=
 =?iso-8859-2?Q?Mbe9yPcZbfUTpbou?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed359b89-b2af-41d6-3f83-08d98a80110e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 17:21:29.5044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZYq/R6KivHszp3+yXgTSxQDeDlyerv147wIy9cKZtkmnnqVJ83rUFxf+KULKhE7S2fjx2+6p+uxD2xKmli3qqt1uLxKz159HmLlRLDzPaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1049
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch adds support for Hyper-V vPCI by adding a PCI MSI
IRQ domain specific to Hyper-V that is based on SPIs. The IRQ
domain parents itself to the arch GIC IRQ domain for basic
vector management.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
In v2:
 v2 changes are described in the cover letter.

 arch/arm64/include/asm/hyperv-tlfs.h        |   9 +
 drivers/pci/Kconfig                         |   2 +-
 drivers/pci/controller/Kconfig              |   2 +-
 drivers/pci/controller/pci-hyperv-irqchip.c | 205 ++++++++++++++++++++
 drivers/pci/controller/pci-hyperv.c         |   6 +
 5 files changed, 222 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/hyperv-tlfs.h b/arch/arm64/include/asm/=
hyperv-tlfs.h
index 4d964a7f02ee..bc6c7ac934a1 100644
--- a/arch/arm64/include/asm/hyperv-tlfs.h
+++ b/arch/arm64/include/asm/hyperv-tlfs.h
@@ -64,6 +64,15 @@
 #define HV_REGISTER_STIMER0_CONFIG	0x000B0000
 #define HV_REGISTER_STIMER0_COUNT	0x000B0001
=20
+union hv_msi_entry {
+	u64 as_uint64[2];
+	struct {
+		u64 address;
+		u32 data;
+		u32 reserved;
+	} __packed;
+};
+
 #include <asm-generic/hyperv-tlfs.h>
=20
 #endif
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c473d75e625..36dc94407510 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -184,7 +184,7 @@ config PCI_LABEL
=20
 config PCI_HYPERV
 	tristate "Hyper-V PCI Frontend"
-	depends on X86_64 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && SYSFS
+	depends on (X86_64 || ARM64) && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN &=
& SYSFS
 	select PCI_HYPERV_INTERFACE
 	help
 	  The PCI device frontend driver allows the kernel to import arbitrary
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfi=
g
index 326f7d13024f..15271f8a0dd1 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -280,7 +280,7 @@ config PCIE_BRCMSTB
=20
 config PCI_HYPERV_INTERFACE
 	tristate "Hyper-V PCI Interface"
-	depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
+	depends on (X86_64 || ARM64) && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN
 	help
 	  The Hyper-V PCI Interface is a helper driver allows other drivers to
 	  have a common interface with the Hyper-V PCI frontend driver.
diff --git a/drivers/pci/controller/pci-hyperv-irqchip.c b/drivers/pci/cont=
roller/pci-hyperv-irqchip.c
index 5f334f7d66cb..193f6abedb9e 100644
--- a/drivers/pci/controller/pci-hyperv-irqchip.c
+++ b/drivers/pci/controller/pci-hyperv-irqchip.c
@@ -48,4 +48,209 @@ int hv_msi_prepare(struct irq_domain *domain, struct de=
vice *dev,
 	return pci_msi_prepare(domain, dev, nvec, info);
 }
=20
+#elif CONFIG_ARM64
+
+/*
+ * SPI vectors to use for vPCI; arch SPIs range is [32, 1019], but leaving=
 a bit
+ * of room at the start to allow for SPIs to be specified through ACPI and
+ * starting with a power of two to satisfy power of 2 multi-MSI requiremen=
t.
+ */
+#define HV_PCI_MSI_SPI_START	64
+#define HV_PCI_MSI_SPI_NR	(1020 - HV_PCI_MSI_SPI_START)
+
+struct hv_pci_chip_data {
+	DECLARE_BITMAP(spi_map, HV_PCI_MSI_SPI_NR);
+	struct mutex	map_lock;
+};
+
+/* Hyper-V vPCI MSI GIC IRQ domain */
+static struct irq_domain *hv_msi_gic_irq_domain;
+
+/* Hyper-V PCI MSI IRQ chip */
+static struct irq_chip hv_msi_irq_chip =3D {
+	.name =3D "MSI",
+	.irq_set_affinity =3D irq_chip_set_affinity_parent,
+	.irq_eoi =3D irq_chip_eoi_parent,
+	.irq_mask =3D irq_chip_mask_parent,
+	.irq_unmask =3D irq_chip_unmask_parent
+};
+
+unsigned int hv_msi_get_int_vector(struct irq_data *irqd)
+{
+	irqd =3D irq_domain_get_irq_data(hv_msi_gic_irq_domain, irqd->irq);
+
+	return irqd->hwirq;
+}
+
+void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
+				struct msi_desc *msi_desc)
+{
+	msi_entry->address =3D ((u64)msi_desc->msg.address_hi << 32) |
+			      msi_desc->msg.address_lo;
+	msi_entry->data =3D msi_desc->msg.data;
+}
+
+int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
+		   int nvec, msi_alloc_info_t *info)
+{
+	return 0;
+}
+
+static void hv_pci_vec_irq_domain_free(struct irq_domain *domain,
+				       unsigned int virq, unsigned int nr_irqs)
+{
+	struct hv_pci_chip_data *chip_data =3D domain->host_data;
+	struct irq_data *irqd =3D irq_domain_get_irq_data(domain, virq);
+	int first =3D irqd->hwirq - HV_PCI_MSI_SPI_START;
+
+	mutex_lock(&chip_data->map_lock);
+	bitmap_release_region(chip_data->spi_map,
+			      first,
+			      get_count_order(nr_irqs));
+	mutex_unlock(&chip_data->map_lock);
+	irq_domain_reset_irq_data(irqd);
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+}
+
+static int hv_pci_vec_alloc_device_irq(struct irq_domain *domain,
+				       unsigned int nr_irqs,
+				       irq_hw_number_t *hwirq)
+{
+	struct hv_pci_chip_data *chip_data =3D domain->host_data;
+	unsigned int index;
+
+	/* Find and allocate region from the SPI bitmap */
+	mutex_lock(&chip_data->map_lock);
+	index =3D bitmap_find_free_region(chip_data->spi_map,
+					HV_PCI_MSI_SPI_NR,
+					get_count_order(nr_irqs));
+	mutex_unlock(&chip_data->map_lock);
+	if (index < 0)
+		return -ENOSPC;
+
+	*hwirq =3D index + HV_PCI_MSI_SPI_START;
+
+	return 0;
+}
+
+static int hv_pci_vec_irq_gic_domain_alloc(struct irq_domain *domain,
+					   unsigned int virq,
+					   irq_hw_number_t hwirq)
+{
+	struct irq_fwspec fwspec;
+
+	fwspec.fwnode =3D domain->parent->fwnode;
+	fwspec.param_count =3D 2;
+	fwspec.param[0] =3D hwirq;
+	fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+}
+
+static int hv_pci_vec_irq_domain_alloc(struct irq_domain *domain,
+				       unsigned int virq, unsigned int nr_irqs,
+				       void *args)
+{
+	irq_hw_number_t hwirq;
+	unsigned int i;
+	int ret;
+
+	ret =3D hv_pci_vec_alloc_device_irq(domain, nr_irqs, &hwirq);
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < nr_irqs; i++) {
+		ret =3D hv_pci_vec_irq_gic_domain_alloc(domain, virq + i,
+						      hwirq + i);
+		if (ret)
+			goto free_irq;
+
+		ret =3D irq_domain_set_hwirq_and_chip(domain, virq + i,
+						    hwirq + i, &hv_msi_irq_chip,
+						    domain->host_data);
+		if (ret)
+			goto free_irq;
+
+		pr_debug("pID:%d vID:%u\n", (int)(hwirq + i), virq + i);
+	}
+
+	return 0;
+
+free_irq:
+	hv_pci_vec_irq_domain_free(domain, virq, nr_irqs);
+
+	return ret;
+}
+
+static int hv_pci_vec_irq_domain_activate(struct irq_domain *domain,
+					  struct irq_data *irqd, bool reserve)
+{
+	/* All available online CPUs are available for targeting */
+	irq_data_update_effective_affinity(irqd, cpu_online_mask);
+
+	return 0;
+}
+
+static const struct irq_domain_ops hv_pci_domain_ops =3D {
+	.alloc	=3D hv_pci_vec_irq_domain_alloc,
+	.free	=3D hv_pci_vec_irq_domain_free,
+	.activate =3D hv_pci_vec_irq_domain_activate,
+};
+
+int hv_pci_irqchip_init(struct irq_domain **parent_domain,
+			bool *fasteoi_handler,
+			u8 *delivery_mode)
+{
+	static struct hv_pci_chip_data *chip_data;
+	struct fwnode_handle *fn =3D NULL;
+	int ret =3D -ENOMEM;
+
+	chip_data =3D kzalloc(sizeof(*chip_data), GFP_KERNEL);
+	if (!chip_data)
+		return ret;
+
+	mutex_init(&chip_data->map_lock);
+	fn =3D irq_domain_alloc_named_fwnode("Hyper-V ARM64 vPCI");
+	if (!fn)
+		goto free_chip;
+
+	hv_msi_gic_irq_domain =3D acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
+							  fn, &hv_pci_domain_ops,
+							  chip_data);
+
+	if (!hv_msi_gic_irq_domain) {
+		pr_err("Failed to create Hyper-V ARMV vPCI MSI IRQ domain\n");
+		goto free_chip;
+	}
+
+	*parent_domain =3D hv_msi_gic_irq_domain;
+	*fasteoi_handler =3D true;
+
+	/* Delivery mode: Fixed */
+	*delivery_mode =3D 0;
+
+	return 0;
+
+free_chip:
+	kfree(chip_data);
+	if (fn)
+		irq_domain_free_fwnode(fn);
+
+	return ret;
+}
+
+void hv_pci_irqchip_free(void)
+{
+	static struct hv_pci_chip_data *chip_data;
+
+	if (!hv_msi_gic_irq_domain)
+		return;
+
+	/* Host data cannot be null if the domain was created successfully */
+	chip_data =3D hv_msi_gic_irq_domain->host_data;
+	irq_domain_remove(hv_msi_gic_irq_domain);
+	hv_msi_gic_irq_domain =3D NULL;
+	kfree(chip_data);
+}
+
 #endif
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 2d3916206986..a77d0eaedac3 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -44,6 +44,7 @@
 #include <linux/delay.h>
 #include <linux/semaphore.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include <linux/hyperv.h>
 #include <linux/refcount.h>
@@ -1204,6 +1205,8 @@ static int hv_set_affinity(struct irq_data *data, con=
st struct cpumask *dest,
 static void hv_irq_mask(struct irq_data *data)
 {
 	pci_msi_mask_irq(data);
+	if (data->parent_data->chip->irq_mask)
+		irq_chip_mask_parent(data);
 }
=20
 /**
@@ -1321,6 +1324,8 @@ static void hv_irq_unmask(struct irq_data *data)
 		dev_err(&hbus->hdev->device,
 			"%s() failed: %#llx", __func__, res);
=20
+	if (data->parent_data->chip->irq_unmask)
+		irq_chip_unmask_parent(data);
 	pci_msi_unmask_irq(data);
 }
=20
@@ -1597,6 +1602,7 @@ static struct irq_chip hv_msi_irq_chip =3D {
 	.irq_compose_msi_msg	=3D hv_compose_msi_msg,
 	.irq_set_affinity	=3D hv_set_affinity,
 	.irq_ack		=3D irq_chip_ack_parent,
+	.irq_eoi		=3D irq_chip_eoi_parent,
 	.irq_mask		=3D hv_irq_mask,
 	.irq_unmask		=3D hv_irq_unmask,
 };
--=20
2.25.1

