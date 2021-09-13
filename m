Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABBA409ABF
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Sep 2021 19:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbhIMRin (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Sep 2021 13:38:43 -0400
Received: from mail-eastus2namln1000.outbound.protection.outlook.com ([40.93.3.0]:55903
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240913AbhIMRim (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Sep 2021 13:38:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gvr79oUMz9REvs8oDzcRXxQCPp1asoHzf82PbDtE4eamS0JITBN1w2/6Tb1rKeAJiCRmvtbKBWQ4LVq51xsxqe/ag9rICIXCq/R9+d9Aj6OoBHDQibm0j6Omtsdlv+Rml77uGC4WoZfk/iniKTTdIRSlFlPQEyHiF9wy3LNFbX0pCaWZ7vPb5sfT8PCHBiJnuy9Ul8a7Kve16ONInMauO3fnxnZyazYChmUQcxsVjv/YSzqRh/ZRPNDPKZhQvPyR+30c6REquKLWlAc3qmLHTHRMsCQSy0vWbFzQueD9VpGCXTQumz9Is9XcQ9j9DZzT5w1P0LXXbo96KHtOxkPqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wZ4vfdnXyfCY1rndNdfbMT0RKnEZLeX62cMJjI4dwF8=;
 b=KA6ZtJkZh3FLdcvq4Ru3YbIzTrN6AFSq/49B5RBX/nVqAMARV/2OSGBRXxLuUDuZQk5iO00a9Dxaz5N0CtwSEJwsavNuEdKbBYRj/Q/vRynzG4CxC0FPXSn186fGnRnp5Bq7XN2NuLNJINx7cvB4ZPPoZ6+9rl50DsL+J5+NGhHDydK6QXrvAC0Mnsoels8xFYCi45SotJBVCECSHTSfQBm5UHLCnwxN/bBxSqS1HmCgIiElYnVj1Ibs8RqLMma1QeFb37jqU9LQuvCHTFD++1SoVgABCWeKvDkpb9r+dYM4rtGdxopY0mwA8u5FwPy00Udmy3hEa1bhemernnm6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZ4vfdnXyfCY1rndNdfbMT0RKnEZLeX62cMJjI4dwF8=;
 b=hgUFKGNNvMhycG3k1zpA8utxESiYB2I95fX8x62kUnz0djNTYnfkb60UNiR3JjKiE0QTvCk01rbdNeQ/T+WJYpIxjFSbdp8buMZ0vd1wbDHrXUCJwawR6WG0nFZrozg8h/Mj6HqC50uENRwsvymklaLB0A4b857nfVLQzkRNXLk=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MWHPR21MB0830.namprd21.prod.outlook.com (2603:10b6:300:76::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8; Mon, 13 Sep
 2021 17:37:22 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::b134:7809:fcff:8c8b]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::b134:7809:fcff:8c8b%4]) with mapi id 15.20.4523.011; Mon, 13 Sep 2021
 17:37:22 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
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
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] PCI: hv: Support for Hyper-V vPCI for ARM64
Thread-Topic: [PATCH 2/2] PCI: hv: Support for Hyper-V vPCI for ARM64
Thread-Index: AdeoxTZsllWVtNf9RIGrn88zMhJayQ==
Date:   Mon, 13 Sep 2021 17:37:22 +0000
Message-ID: <MW4PR21MB2002654EE498023C6F2E40B5C0D99@MW4PR21MB2002.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1a9e7dc-5381-4b89-6d02-08d976dd24d3
x-ms-traffictypediagnostic: MWHPR21MB0830:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0830812160FCD506F0F9531BC0D99@MWHPR21MB0830.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6IFP8nb78+LjS1hVnFy1ppT7pDeFUjtI61WG5sxcIZ/8MyhNeyLGPkZPFHtlWGpW1z45rETz1KTaslVYOLXDIs/rCaJ3qcUINc6CF38til5gKYUfATg/D/KFKxIGJJgpUOZVw3sjjDMNk6mfefuvvln4m0iQSO5k53tvPIFHLmUqkAUT39h/q3ZK4qoNDEalMUm+yqM/BqBhhIFcdX6WCkivht9FOzzO9/DhookyodyB6CRw7LuQ8HRPOq+/u2tzqN6ahcO7HDFLzshDBKGqFwJpkTPypB92nKLQczaXJG6RYKefN9rfVAEUBis3HFGDIylW0qSdTrEZt/h+Hnl9/moGsS4cWmFjCe1xWCPj+3LMOe/N3i8iYA4CjzXdxcjEKDDkJ7bg13A4zhZHss7p4YhRoH8PJCHIFz+2drdjt9b6YAjIflbF85cpVI86zSunGKnJnYjYgp/dpjRMHDhY9JoAJ2i4JpKjkLhVIAqUnAV1qRAlovoD+k6WZm3Onzb4IjTy+viVs81bONrsLEcEnUKFnrkyPDxooA3x2hg6ISOthRqtFeO95e0ztqbLJNyFhUKm0TxTNUsrKVYcWeF7eMjK1SwfEcLF+f/1+fs+YoSMZ/C3SnSDknFYUn4U78k/wOn5Lp33/ckYaxf9LE8e+lbY/AHg9yNSk6PS7D6b1yON94c/oLTgfIWWysnPcD1tZx8OIpTlqV9q0OfE2BH2dSjRrTYlZsNTSYYlvgP4u2vi5GaW59O8vtNJJ8Byfiqr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(9686003)(508600001)(76116006)(55016002)(52536014)(83380400001)(7696005)(38070700005)(71200400001)(33656002)(30864003)(66446008)(64756008)(82950400001)(66556008)(66476007)(82960400001)(66946007)(86362001)(38100700002)(186003)(122000001)(921005)(8676002)(8936002)(8990500004)(2906002)(4326008)(316002)(54906003)(110136005)(10290500003)(5660300002)(2004002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?9kBMSc5D0OY6LRSLKvvIsao+3N8VYjjUHoLbZlz53MYu96hLBkQTvGlaLR?=
 =?iso-8859-2?Q?iiIiL1UxbvwqVcjATPpRQMYC6kWrS5fXeoIJI699HDBUA2micyj86NcHdC?=
 =?iso-8859-2?Q?cbOAEpjJ68H7Bsjl2gr5bO8QaEsQ6F/C12fpCAO2wB80Q2vuB8xmmCpq7v?=
 =?iso-8859-2?Q?7jSlwxQVXV9Brsetxq4w85KY6BoooAwnfTi+M6hQ8+8AQfP7KJVv80NCpZ?=
 =?iso-8859-2?Q?NnFtkPeorMc+NM02q6R3MUjz+jEY2LxbR1jxvu5mIBXCyPMwAzb/B/IpD8?=
 =?iso-8859-2?Q?9Xltq7tLk9QsGFrzr3+EEO0XSOlz2SU7bRP1BxIpYwIKMtx/nk065vl3Wt?=
 =?iso-8859-2?Q?7XLZ6Dkpjx+KBzSHyOI6Ay7Wu7NwyUNgVQqA81+T65p7XJr5EPphthCaAA?=
 =?iso-8859-2?Q?W2+p3s92tRKOKIiFH7PSoXnaOtajkxfnYcuMndHYrp7R7+/RlYIxuNpdcw?=
 =?iso-8859-2?Q?2eDzBtYsHyEI+0zbS3Y1z9AOnl1UraCLZaY1sqDn5uj5dsWckZzRprTEea?=
 =?iso-8859-2?Q?D+Yj9gYEa1iJbe9QAdTWt20MyDb8TdB+kYIpnRvsx2PTTN0DlBnvSfQ5tI?=
 =?iso-8859-2?Q?NwJM8W5a9d+3klRKIxBP+XbkfqKp7lBeB0A0k1JfrwXztquv1q7XiKOSM7?=
 =?iso-8859-2?Q?olREYbEDh7Y+jgTL4lIWOuy2cfsDUycpSPlwGx1iseVHcRVjsM3MGlg7uf?=
 =?iso-8859-2?Q?P2AsT6XxvBu0wH/jDLoKreFHLBhwoQm6ivxd+OA3QvOkv3FA6lLorAEKpg?=
 =?iso-8859-2?Q?wXTaklRjLPfbcoMj0W1O4df9g+kQ5bkpjH3OlaAZe95QSzNZPb7VCkCF/B?=
 =?iso-8859-2?Q?vFh5a5owP4duPnUPb+o/Dv/b4bd2KQ8vNnIIYSwVX9WtSB5aCzn1vNFgN7?=
 =?iso-8859-2?Q?kLpqdzbkEvnahrR6C1SdEtYQvh7GUSN27u1PpOiWxwKRXBAdr/7orxnWW5?=
 =?iso-8859-2?Q?svOWwXqnmHhU++cMkvd0jUvaTs76TLbcTeL1dLTEKvfncRvzMHEmtiJBmW?=
 =?iso-8859-2?Q?PX34jsUXYG3eMaY/D3onWTqnoldoJgqLQxGCk2oQBVDiBh22iMOj4o7FV/?=
 =?iso-8859-2?Q?gII7Z95idDz9DUxIbwDr7nCe58VP7py6egEO/11gvEvkkalABh4RQxhE8x?=
 =?iso-8859-2?Q?oc3nn+OR+XhXyGrsr7fnxLCfyzwC0l4tWYX9jWtut2aSDCodAhMEG6bF1J?=
 =?iso-8859-2?Q?0U3PhGDamiygERcMd2QQ0qyBa+oNKkWCvOEhu/wO5BjC72HQ/z03VYggMD?=
 =?iso-8859-2?Q?1ZLwMVKlkNmJT8Y9WUL8NUZRbqTRqEAoy8Hb0kiTIPRnlPTwfXVjZcf+xb?=
 =?iso-8859-2?Q?s5KuOmOfC9kIKjNRPb8q/RPXISal006uwicvLYz/2SrtDkOWx0MR2O6rjF?=
 =?iso-8859-2?Q?y2mSeIKy7jX4GdJiBFFGyKrKGSysGHOMOgPJEqLcZBss6IPag75nNttuzx?=
 =?iso-8859-2?Q?duCHI0QIwZ5DEi1O?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a9e7dc-5381-4b89-6d02-08d976dd24d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 17:37:22.5997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6xvDXWhFD/QwrlqgUpwPM0oqx+Nbx8diJOpaYCjfXsMOB26CMrP9YxZ+PE/64Rfw9RY4I4qVbJvkpPmY/jEU5KIoPU6GOazNrYAxeftx7EI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0830
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch adds support for Hyper-V vPCI by adding a PCI MSI
IRQ domain specific to Hyper-V that is based on SPIs. The IRQ
domain parents itself to the arch GIC IRQ domain for basic
vector management.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 arch/arm64/hyperv/Makefile           |   2 +-
 arch/arm64/hyperv/hv_pci.c           | 275 +++++++++++++++++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h |   9 +
 arch/arm64/include/asm/mshyperv.h    |  26 +++
 drivers/pci/Kconfig                  |   2 +-
 drivers/pci/controller/Kconfig       |   2 +-
 drivers/pci/controller/pci-hyperv.c  |   5 +
 7 files changed, 318 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/hyperv/hv_pci.c

diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
index 87c31c001da9..af7a66e43ef4 100644
--- a/arch/arm64/hyperv/Makefile
+++ b/arch/arm64/hyperv/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y		:=3D hv_core.o mshyperv.o
+obj-y		:=3D hv_core.o mshyperv.o hv_pci.o
diff --git a/arch/arm64/hyperv/hv_pci.c b/arch/arm64/hyperv/hv_pci.c
new file mode 100644
index 000000000000..06179e4a6a2d
--- /dev/null
+++ b/arch/arm64/hyperv/hv_pci.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Architecture specific vector management for the Hyper-V vPCI.
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : Sunil Muthuswamy <sunilmut@microsoft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as publishe=
d
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT. See the GNU General Public License for more
+ * details.
+ */
+
+#include <asm/mshyperv.h>
+#include <linux/acpi.h>
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
+#include <acpi/acpi_bus.h>
+
+/*
+ * SPI vectors to use for vPCI; arch SPIs range is [32, 1019], but leaving=
 a bit
+ * of room at the start to allow for SPIs to be specified through ACPI.
+ */
+#define HV_PCI_MSI_SPI_START	50
+#define HV_PCI_MSI_SPI_NR	(1020 - HV_PCI_MSI_SPI_START)
+
+struct hv_pci_chip_data {
+	spinlock_t lock;
+	DECLARE_BITMAP(bm, HV_PCI_MSI_SPI_NR);
+};
+
+/* Hyper-V vPCI MSI GIC IRQ domain */
+static struct irq_domain *hv_msi_gic_irq_domain;
+
+static struct irq_chip hv_msi_irq_chip =3D {
+	.name =3D "Hyper-V ARM64 PCI MSI",
+	.irq_set_affinity =3D irq_chip_set_affinity_parent,
+	.irq_eoi =3D irq_chip_eoi_parent,
+	.irq_mask =3D irq_chip_mask_parent,
+	.irq_unmask =3D irq_chip_unmask_parent
+};
+
+/**
+ * Frees the specified number of interrupts.
+ * @domain: The IRQ domain
+ * @virq: The virtual IRQ number.
+ * @nr_irqs: Number of IRQ's to free.
+ */
+static void hv_pci_vec_irq_domain_free(struct irq_domain *domain,
+				       unsigned int virq, unsigned int nr_irqs)
+{
+	struct hv_pci_chip_data *chip_data =3D domain->host_data;
+	unsigned long flags;
+	unsigned int i;
+
+	for (i =3D 0; i < nr_irqs; i++) {
+		struct irq_data *irqd =3D irq_domain_get_irq_data(domain,
+								virq + i);
+
+		spin_lock_irqsave(&chip_data->lock, flags);
+		clear_bit(irqd->hwirq - HV_PCI_MSI_SPI_START, chip_data->bm);
+		spin_unlock_irqrestore(&chip_data->lock, flags);
+		irq_domain_reset_irq_data(irqd);
+	}
+
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+}
+
+/**
+ * Allocate an interrupt from the domain.
+ * @hwirq: Will be set to the allocated H/W IRQ.
+ *
+ * Return: 0 on success and error value on failure.
+ */
+static int hv_pci_vec_alloc_device_irq(struct irq_domain *domain,
+				unsigned int virq, irq_hw_number_t *hwirq)
+{
+	struct hv_pci_chip_data *chip_data =3D domain->host_data;
+	unsigned long flags;
+	unsigned int index;
+
+	spin_lock_irqsave(&chip_data->lock, flags);
+	index =3D find_first_zero_bit(chip_data->bm, HV_PCI_MSI_SPI_NR);
+	if (index =3D=3D HV_PCI_MSI_SPI_NR) {
+		spin_unlock_irqrestore(&chip_data->lock, flags);
+		pr_err("No more free IRQ vector available\n");
+		return -ENOSPC;
+	}
+
+	set_bit(index, chip_data->bm);
+	spin_unlock_irqrestore(&chip_data->lock, flags);
+	*hwirq =3D index + HV_PCI_MSI_SPI_START;
+
+	return 0;
+}
+
+/**
+ * Allocate an interrupt from the parent GIC domain.
+ * @domain: The IRQ domain.
+ * @virq: The virtual IRQ number.
+ * @hwirq: The H/W IRQ number that needs to be allocated.
+ *
+ * Return: 0 on success and error value on failure.
+ */
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
+/**
+ * Allocate specified number of interrupts from the domain.
+ * @domain: The IRQ domain.
+ * @virq: The starting virtual IRQ number.
+ * @nr_irqs: Number of IRQ's to allocate.
+ * @args: The MSI alloc information.
+ *
+ * Return: 0 on success and error value on failure.
+ */
+static int hv_pci_vec_irq_domain_alloc(struct irq_domain *domain,
+				       unsigned int virq, unsigned int nr_irqs,
+				       void *args)
+{
+	irq_hw_number_t hwirq;
+	unsigned int i;
+	int ret;
+
+	for (i =3D 0; i < nr_irqs; i++) {
+		ret =3D hv_pci_vec_alloc_device_irq(domain, virq, &hwirq);
+		if (ret)
+			goto free_irq;
+
+		ret =3D hv_pci_vec_irq_gic_domain_alloc(domain, virq + i, hwirq);
+		if (ret)
+			goto free_irq;
+
+		ret =3D irq_domain_set_hwirq_and_chip(domain, virq + i,
+				hwirq, &hv_msi_irq_chip,
+				domain->host_data);
+		if (ret)
+			goto free_irq;
+
+		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq + i)));
+		pr_debug("pID:%d vID:%u\n", (int)hwirq, virq + i);
+	}
+
+	return 0;
+
+free_irq:
+	if (i > 0)
+		hv_pci_vec_irq_domain_free(domain, virq, i - 1);
+
+	return ret;
+}
+
+/**
+ * Activate the interrupt.
+ * @domain: The IRQ domain.
+ * @irqd: IRQ data.
+ * @reserve: Indicates whether the IRQ's can be reserved.
+ *
+ * Return: 0 on success and error value on failure.
+ */
+static int hv_pci_vec_irq_domain_activate(struct irq_domain *domain,
+					  struct irq_data *irqd, bool reserve)
+{
+	/* All available online CPUs are available for targeting */
+	irq_data_update_effective_affinity(irqd, cpu_online_mask);
+	return 0;
+}
+
+static const struct irq_domain_ops hv_pci_domain_ops =3D {
+	.alloc	=3D hv_pci_vec_irq_domain_alloc,
+	.free	=3D hv_pci_vec_irq_domain_free,
+	.activate =3D hv_pci_vec_irq_domain_activate,
+};
+
+
+/**
+ * This routine performs the architecture specific initialization for vect=
or
+ * domain to operate. It allocates an IRQ domain tree as a child of the GI=
C
+ * IRQ domain.
+ *
+ * Return: 0 on success and error value on failure.
+ */
+int hv_pci_vector_init(void)
+{
+	static struct hv_pci_chip_data *chip_data;
+	struct fwnode_handle *fn =3D NULL;
+	int ret =3D -ENOMEM;
+
+	chip_data =3D kzalloc(sizeof(*chip_data), GFP_KERNEL);
+	if (!chip_data)
+		return ret;
+
+	spin_lock_init(&chip_data->lock);
+	fn =3D irq_domain_alloc_named_fwnode("Hyper-V ARM64 vPCI");
+	if (!fn)
+		goto free_chip;
+
+	hv_msi_gic_irq_domain =3D acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
+					fn, &hv_pci_domain_ops, chip_data);
+
+	if (!hv_msi_gic_irq_domain) {
+		pr_err("Failed to create Hyper-V ARMV vPCI MSI IRQ domain\n");
+		goto free_chip;
+	}
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
+/* This routine performs the cleanup for the IRQ domain. */
+void hv_pci_vector_free(void)
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
+/* Performs the architecture specific initialization for Hyper-V vPCI. */
+int hv_pci_arch_init(void)
+{
+	return hv_pci_vector_init();
+}
+EXPORT_SYMBOL_GPL(hv_pci_arch_init);
+
+/* Architecture specific cleanup for Hyper-V vPCI. */
+void hv_pci_arch_free(void)
+{
+	hv_pci_vector_free();
+}
+EXPORT_SYMBOL_GPL(hv_pci_arch_free);
+
+struct irq_domain *hv_msi_parent_vector_domain(void)
+{
+	return hv_msi_gic_irq_domain;
+}
+EXPORT_SYMBOL_GPL(hv_msi_parent_vector_domain);
+
+unsigned int hv_msi_get_int_vector(struct irq_data *irqd)
+{
+	irqd =3D irq_domain_get_irq_data(hv_msi_gic_irq_domain, irqd->irq);
+
+	return irqd->hwirq;
+}
+EXPORT_SYMBOL_GPL(hv_msi_get_int_vector);
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
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/msh=
yperv.h
index 20070a847304..68bc1617707b 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -20,6 +20,8 @@
=20
 #include <linux/types.h>
 #include <linux/arm-smccc.h>
+#include <linux/interrupt.h>
+#include <linux/msi.h>
 #include <asm/hyperv-tlfs.h>
=20
 /*
@@ -49,6 +51,30 @@ static inline u64 hv_get_register(unsigned int reg)
 				ARM_SMCCC_OWNER_VENDOR_HYP,	\
 				HV_SMCCC_FUNC_NUMBER)
=20
+#define hv_msi_handler			NULL
+#define hv_msi_handler_name		NULL
+#define hv_msi_irq_delivery_mode	0
+#define hv_msi_prepare NULL
+
+int hv_pci_arch_init(void);
+void hv_pci_arch_free(void);
+struct irq_domain *hv_msi_parent_vector_domain(void);
+unsigned int hv_msi_get_int_vector(struct irq_data *data);
+static inline irq_hw_number_t
+hv_msi_domain_ops_get_hwirq(struct msi_domain_info *info,
+			    msi_alloc_info_t *arg)
+{
+	return arg->hwirq;
+}
+
+static inline void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entr=
y,
+					      struct msi_desc *msi_desc)
+{
+	msi_entry->address =3D ((u64)msi_desc->msg.address_hi << 32) |
+			      msi_desc->msg.address_lo;
+	msi_entry->data =3D msi_desc->msg.data;
+}
+
 #include <asm-generic/mshyperv.h>
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
index 5e1e3796efa4..8a19a3dc339c 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -279,7 +279,7 @@ config PCIE_BRCMSTB
=20
 config PCI_HYPERV_INTERFACE
 	tristate "Hyper-V PCI Interface"
-	depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
+	depends on (X86_64 || ARM64) && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN
 	help
 	  The Hyper-V PCI Interface is a helper driver allows other drivers to
 	  have a common interface with the Hyper-V PCI frontend driver.
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index b7213b57b4ec..79a29a18e84e 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1177,6 +1177,8 @@ static int hv_set_affinity(struct irq_data *data, con=
st struct cpumask *dest,
 static void hv_irq_mask(struct irq_data *data)
 {
 	pci_msi_mask_irq(data);
+	if (data->parent_data->chip->irq_mask)
+		irq_chip_mask_parent(data);
 }
=20
 /**
@@ -1294,6 +1296,8 @@ static void hv_irq_unmask(struct irq_data *data)
 		dev_err(&hbus->hdev->device,
 			"%s() failed: %#llx", __func__, res);
=20
+	if (data->parent_data->chip->irq_unmask)
+		irq_chip_unmask_parent(data);
 	pci_msi_unmask_irq(data);
 }
=20
@@ -1538,6 +1542,7 @@ static struct irq_chip hv_msi_irq_chip =3D {
 	.irq_compose_msi_msg	=3D hv_compose_msi_msg,
 	.irq_set_affinity	=3D hv_set_affinity,
 	.irq_ack		=3D irq_chip_ack_parent,
+	.irq_eoi		=3D irq_chip_eoi_parent,
 	.irq_mask		=3D hv_irq_mask,
 	.irq_unmask		=3D hv_irq_unmask,
 };
--=20
2.25.1

