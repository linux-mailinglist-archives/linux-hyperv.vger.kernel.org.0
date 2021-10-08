Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34908426F7A
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Oct 2021 19:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbhJHRWh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Oct 2021 13:22:37 -0400
Received: from mail-oln040093003008.outbound.protection.outlook.com ([40.93.3.8]:60035
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238230AbhJHRWg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Oct 2021 13:22:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtwTPqz4P/sc9eiSXuzZEiBEn3O1eaYrlyBziR9BvECyaNDYx/r2FH/TMn3f4M7eCagKv+g2zxUYzzoLpjZWy+yv2umNeXqTKJ9YpDTFMZ1MAWPjzhyvXfR5UH0qoiZH6yZPRhS2uNcVopNKyc6H6Tid/po45ONL9LH0/Je6S0Xp2KqdIZn+uVfilp0ZvlnyiSQZ/7zOvbFLmnPOOxMm4L7u/7SBJlVVRuXfq5MoXP1fKDG8oeCY5LPt9ZbpfNye6EgnhDwQGVvxYNQPJ9pyqEWJc8IQoz5UPlTHjJybrfEmI+mGAGbRwOo8MQ/8wGaC/gSrPMOevis38EoyW3b7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6X4yc5p3EzdfW6Hrfw/xfS7h7zQHX09/4wr0MYvzs1Y=;
 b=CGBL3l9zsWzAFXH69MPORXjtx8QzD7tJ+vSNl7qCQ4NIU0iSCpYVDEXpo0eSyNCXxizdvaddrQCUrHh82j83L98vA3s/kV4yqQDP/5lzNouWkQEc1ddjqZrSTlbQv2APUI0ix8Jf2ANSWrV+YzczequEyOK9t6CqjFEhoarHQNo8PTUhf9tHscYX2vTrE7McV/7WREKgXeprng2i9815mCpdwuj6spfu3rVWgRSYcYJeXWoV8coqnaHQsFzhAuc1PKaoxzelkDusFcJbYB9nb/Jy/0NsY4eoptiioKeJjBMk6l/69+6whly9+Esuugz9bGtfCg74OrsNFzIXK8FJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6X4yc5p3EzdfW6Hrfw/xfS7h7zQHX09/4wr0MYvzs1Y=;
 b=EhrI8Dv/vrO57haSRqkuLXnEPDX8+JMe/k2JEwWbvKZnQ/aOT/txHWSHaTR/0b9gphuedLuC9iG2hd3lbLH4zlRN2D73daVVxj9Beqt8W+JeWj/d7qbQYtDzj6zk/0+gkJoIV4CduTb9r2Iww5dVRWWY/zdLxfc0VN2rX+l4r6o=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MW2PR2101MB1049.namprd21.prod.outlook.com (2603:10b6:302:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4; Fri, 8 Oct
 2021 17:20:36 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::89fe:5bf:5eb2:4c55]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::89fe:5bf:5eb2:4c55%4]) with mapi id 15.20.4608.008; Fri, 8 Oct 2021
 17:20:36 +0000
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
Subject: [PATCH v2 1/2] PCI: hv: Make the code arch neutral
Thread-Topic: [PATCH v2 1/2] PCI: hv: Make the code arch neutral
Thread-Index: Ade8Z/d+RNK9WO8BTSODIa+n2Enr/Q==
Date:   Fri, 8 Oct 2021 17:20:35 +0000
Message-ID: <MW4PR21MB2002C5BFFD9DCB9C3B2AF9E8C0B29@MW4PR21MB2002.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dde418a1-eb6c-4067-accf-bee5d847478b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-08T17:12:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5760a0e-f24c-45d1-634d-08d98a7ff13b
x-ms-traffictypediagnostic: MW2PR2101MB1049:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1049BFCA2466235AC2E666AAC0B29@MW2PR2101MB1049.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NG7fEDWNfj9VWC9XD3OndIhfZCvvhjCqsKp7u5utoOgVnWDnwZJwh3oJTC8LM5ZhhDg4FNi1LHBEqCt2954PffBFCaoR241g6YZxZkEcU/7aJ778hKfrI7schha9NonjuAPMENJSAz9TDFwaVNCaDRzQkeq3f7bVAtDDL21L0Vc0hArdPkZs5xztDY8U1nvWgctdJupjWuUpc1XqgUYWXO94nEjh4izQsotwB+vlPxrv7xCRd+ZvQ/bYcpT3/I+FO8B6eHCXAND1XPpHRv1yvTQLRNkKcJdlaY75Xqz3lA+TZWXzv6ShN+CEG5Bmrs6pk3gmza9ZKOTdfACO2uUy20GWQ5r0r8lOHNhzdix6JdhwsQn2XObHGsCfKpjieFyzGrlBdqCxJEM7kkmUeZyn1C760hG+Vxy7JLIz+jN+O0EROFgkQvKRJipto2lrZa3w+NdEP39U/Z01WTFDVJ3gSPMhwKW07WEvcfXDcrgJVUXnACaOt9EZZnqs3ZGyRQe+troPAjNLgDSRHAFV6f9FzTG0ABZ40CXbcGjnW5qrabIp7o3KPTdHdgKOR9xsJg6wfIEDyssLde6f+cQRkyiqf8IfxdBFSUuaxqu5RBi7F7Y3yXRqovGvU0NLvsYADcCTLXB7cYjyXl5UzF1zvawGkxDjzRGlIUPXL4b73VFzjWDPpB39naY2nRGoWKwFzAbAOlu/r9M1XrQ4AT82y2Zb/Z4GlGlyfCE6OOBYjhhqJ/0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(71200400001)(8990500004)(86362001)(5660300002)(10290500003)(186003)(4326008)(82950400001)(508600001)(76116006)(66946007)(82960400001)(33656002)(8676002)(6506007)(921005)(122000001)(2906002)(30864003)(66556008)(9686003)(54906003)(66476007)(8936002)(7696005)(316002)(66446008)(64756008)(38100700002)(83380400001)(110136005)(55016002)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?2xJnXocvIt7hMQCaxS2xbnW83s92cBhnUDHaIm4NK0xJmK/QpGFXnZieAW?=
 =?iso-8859-2?Q?/fO6kQSsRuHdPWbo08j+kNtRYJbDYt8YfHOry5zeXcW1mZ3DAsmU4ISBLp?=
 =?iso-8859-2?Q?8kEi8kXOrPUvU9A6KrBypJhcN0QrbHbDZwgUWHIDcb6TDDPyBnpul0vdCm?=
 =?iso-8859-2?Q?+/tK1p+iGaLdsmobC8b6y+fm/4Sevti3XE6kmE18jL65oviPQO8E6a3Hde?=
 =?iso-8859-2?Q?XMYBhmK1rxz1ODQwTolBSpWPID93JvqHvTjBmUIgKDMWcF1M9fc2S1y1Vg?=
 =?iso-8859-2?Q?yIFu1b/UZIPeDCKT8bIVL0vo23w3TlWQ3MMl6dsThyKI67miiO2k9ofNQY?=
 =?iso-8859-2?Q?ecLNMiZSwl8fGyi3jJ473qNFpdvzxlCbHE2ZxKgawKQwiNMKZtnlVJ0239?=
 =?iso-8859-2?Q?sF88E/ssxljMU5FXq2WdgoVKlQcdRPr8Z+f+rl8hWXHDvE+3FkwG3e4VRE?=
 =?iso-8859-2?Q?gnG8h+Y2w5Hn3l+4xtHfAFoMU2YiV+pFEfdz++LYVO3VNhc+3bIgc4cmZq?=
 =?iso-8859-2?Q?jLZ9uYhZPnEvyOoG/VbAndWzcKWCXj5rEipbu8apu2PFUPsIKlWSJV8jaJ?=
 =?iso-8859-2?Q?1HKXgsFpbXUBaoJiAy07n4ydrb+XTYFo/lsg69RtYekRnIB4br121kkBWn?=
 =?iso-8859-2?Q?9ypJIJ9MOi4sxtHZ+dFo+XKQi87MwaJTDF7RXjQnO84mNy4ndyCgXU0MJ1?=
 =?iso-8859-2?Q?zrNOjAm0faORNksQXSwDtuewjYqMWce/sc3uJRTMB9sSxVml7Dugv5+B38?=
 =?iso-8859-2?Q?sLRmq7wCuJ+C/MdOrJW/fpdr1UWSDlmblMfO94Xtsy9iWOGKGUguza/EMP?=
 =?iso-8859-2?Q?eN86TvFG4BsTxeQphNr8duS2JxA/c4MfnFnQUAdhBR475Hjnkayg6xLc7f?=
 =?iso-8859-2?Q?tlmrIQqHUieswzN3j4Hj+7q0TlCti970DiCWB+f/iVeoGK7BxFKFqSxF0e?=
 =?iso-8859-2?Q?nui/UcIxR7KZ+vQwwoMgy9Bu0XWNXjYDVr7CPk3Dtt7790Ta0RfLugwgmv?=
 =?iso-8859-2?Q?wVSOpQrQOU356eIWhJ+qhdiaohS56lMNlv9aYwNQcnW3rg7qWW127muNuy?=
 =?iso-8859-2?Q?c3rvLhGOxqdYuwJz94kZEmuVCR+kifjBbbRVQhIaRZks3ZYFk1Tp6T4JbX?=
 =?iso-8859-2?Q?qXHskrDOiNWanbNmyyFhhI0vw3lO7pxxL11IiTyiG4dUGVMWh9KAKjzd8e?=
 =?iso-8859-2?Q?KvMPmEUMv0UuNrnT3I6jBmtrAk9GN/s92F0C9aErI7uwoY2H4Q7fQEE+G4?=
 =?iso-8859-2?Q?PW1IZaB73sap8qjatKS/n5236vecz6t3903c/BL1oKPZPcKLfCnb/4bHne?=
 =?iso-8859-2?Q?HGAKe0/VHKkhMx0bEIndlpQ8IzNxHkKn8+Iwo4LcX0wfhDcZwSMGii/Ycp?=
 =?iso-8859-2?Q?GvpYHg8DL0ieGmp9kLc+FJEVQp8YE1WP8pYAz59csk7rma9FPrrwMJ1A6j?=
 =?iso-8859-2?Q?95WEUe00B+WRsoG4?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5760a0e-f24c-45d1-634d-08d98a7ff13b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 17:20:36.1141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUDxDTuNmlBeT5bqM6HmCab3i5s2HjK8uxHFYQa6svvV2I6fxU5zDDZSMu8pZPxat73AfEQ6uSH5DpCXT5H6e8QCR9OeQDungmuPE7dC6+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1049
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch makes the Hyper-V vPCI code architectural neutral by
introducing an irqchip that takes care of architectural
dependencies. This allows for the implementation of Hyper-V vPCI
for other architecture such as ARM64.

There are no functional changes expected from this patch.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
In v2:
 v2 changes are described in the cover letter.

 MAINTAINERS                                 |  2 +
 arch/x86/include/asm/hyperv-tlfs.h          | 33 +++++++++++++
 arch/x86/include/asm/mshyperv.h             |  7 ---
 drivers/pci/controller/Makefile             |  2 +-
 drivers/pci/controller/pci-hyperv-irqchip.c | 51 ++++++++++++++++++++
 drivers/pci/controller/pci-hyperv-irqchip.h | 21 +++++++++
 drivers/pci/controller/pci-hyperv.c         | 52 +++++++++++++--------
 include/asm-generic/hyperv-tlfs.h           | 33 -------------
 8 files changed, 141 insertions(+), 60 deletions(-)
 create mode 100644 drivers/pci/controller/pci-hyperv-irqchip.c
 create mode 100644 drivers/pci/controller/pci-hyperv-irqchip.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ca6d6fde85cf..ba8c979c17b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8688,6 +8688,8 @@ F:	drivers/iommu/hyperv-iommu.c
 F:	drivers/net/ethernet/microsoft/
 F:	drivers/net/hyperv/
 F:	drivers/pci/controller/pci-hyperv-intf.c
+F:	drivers/pci/controller/pci-hyperv-irqchip.c
+F:	drivers/pci/controller/pci-hyperv-irqchip.h
 F:	drivers/pci/controller/pci-hyperv.c
 F:	drivers/scsi/storvsc_drv.c
 F:	drivers/uio/uio_hv_generic.c
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hype=
rv-tlfs.h
index 2322d6bd5883..fdf3d28fbdd5 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -585,6 +585,39 @@ enum hv_interrupt_type {
 	HV_X64_INTERRUPT_TYPE_MAXIMUM           =3D 0x000A,
 };
=20
+union hv_msi_address_register {
+	u32 as_uint32;
+	struct {
+		u32 reserved1:2;
+		u32 destination_mode:1;
+		u32 redirection_hint:1;
+		u32 reserved2:8;
+		u32 destination_id:8;
+		u32 msi_base:12;
+	};
+} __packed;
+
+union hv_msi_data_register {
+	u32 as_uint32;
+	struct {
+		u32 vector:8;
+		u32 delivery_mode:3;
+		u32 reserved1:3;
+		u32 level_assert:1;
+		u32 trigger_mode:1;
+		u32 reserved2:16;
+	};
+} __packed;
+
+/* HvRetargetDeviceInterrupt hypercall */
+union hv_msi_entry {
+	u64 as_uint64;
+	struct {
+		union hv_msi_address_register address;
+		union hv_msi_data_register data;
+	} __packed;
+};
+
 #include <asm-generic/hyperv-tlfs.h>
=20
 #endif
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyper=
v.h
index adccbc209169..c2b9ab94408e 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -176,13 +176,6 @@ bool hv_vcpu_is_preempted(int vcpu);
 static inline void hv_apic_init(void) {}
 #endif
=20
-static inline void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entr=
y,
-					      struct msi_desc *msi_desc)
-{
-	msi_entry->address.as_uint32 =3D msi_desc->msg.address_lo;
-	msi_entry->data.as_uint32 =3D msi_desc->msg.data;
-}
-
 struct irq_domain *hv_create_pci_msi_domain(void);
=20
 int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vecto=
r,
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makef=
ile
index aaf30b3dcc14..2c301d0fc23b 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_PCIE_CADENCE) +=3D cadence/
 obj-$(CONFIG_PCI_FTPCI100) +=3D pci-ftpci100.o
 obj-$(CONFIG_PCI_IXP4XX) +=3D pci-ixp4xx.o
-obj-$(CONFIG_PCI_HYPERV) +=3D pci-hyperv.o
+obj-$(CONFIG_PCI_HYPERV) +=3D pci-hyperv.o pci-hyperv-irqchip.o
 obj-$(CONFIG_PCI_HYPERV_INTERFACE) +=3D pci-hyperv-intf.o
 obj-$(CONFIG_PCI_MVEBU) +=3D pci-mvebu.o
 obj-$(CONFIG_PCI_AARDVARK) +=3D pci-aardvark.o
diff --git a/drivers/pci/controller/pci-hyperv-irqchip.c b/drivers/pci/cont=
roller/pci-hyperv-irqchip.c
new file mode 100644
index 000000000000..5f334f7d66cb
--- /dev/null
+++ b/drivers/pci/controller/pci-hyperv-irqchip.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Hyper-V vPCI irqchip.
+ *
+ * Copyright (C) 2021, Microsoft, Inc.
+ *
+ * Author : Sunil Muthuswamy <sunilmut@microsoft.com>
+ */
+
+#include <asm/mshyperv.h>
+#include <linux/acpi.h>
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
+#include <linux/msi.h>
+
+#ifdef CONFIG_X86_64
+int hv_pci_irqchip_init(struct irq_domain **parent_domain,
+			bool *fasteoi_handler,
+			u8 *delivery_mode)
+{
+	*parent_domain =3D x86_vector_domain;
+	*fasteoi_handler =3D false;
+	*delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
+
+	return 0;
+}
+
+void hv_pci_irqchip_free(void) {}
+
+unsigned int hv_msi_get_int_vector(struct irq_data *data)
+{
+	struct irq_cfg *cfg =3D irqd_cfg(data);
+
+	return cfg->vector;
+}
+
+void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
+				struct msi_desc *msi_desc)
+{
+	msi_entry->address.as_uint32 =3D msi_desc->msg.address_lo;
+	msi_entry->data.as_uint32 =3D msi_desc->msg.data;
+}
+
+int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
+		   int nvec, msi_alloc_info_t *info)
+{
+	return pci_msi_prepare(domain, dev, nvec, info);
+}
+
+#endif
diff --git a/drivers/pci/controller/pci-hyperv-irqchip.h b/drivers/pci/cont=
roller/pci-hyperv-irqchip.h
new file mode 100644
index 000000000000..8fbf17f03385
--- /dev/null
+++ b/drivers/pci/controller/pci-hyperv-irqchip.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Architecture specific vector management for the Hyper-V vPCI.
+ *
+ * Copyright (C) 2021, Microsoft, Inc.
+ *
+ * Author : Sunil Muthuswamy <sunilmut@microsoft.com>
+ */
+
+int hv_pci_irqchip_init(struct irq_domain **parent_domain,
+			bool *fasteoi_handler,
+			u8 *delivery_mode);
+
+void hv_pci_irqchip_free(void);
+unsigned int hv_msi_get_int_vector(struct irq_data *data);
+void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
+				struct msi_desc *msi_desc);
+
+int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
+		   int nvec, msi_alloc_info_t *info);
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index eaec915ffe62..2d3916206986 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -43,14 +43,12 @@
 #include <linux/pci-ecam.h>
 #include <linux/delay.h>
 #include <linux/semaphore.h>
-#include <linux/irqdomain.h>
-#include <asm/irqdomain.h>
-#include <asm/apic.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/hyperv.h>
 #include <linux/refcount.h>
 #include <asm/mshyperv.h>
+#include "pci-hyperv-irqchip.h"
=20
 /*
  * Protocol versions. The low word is the minor version, the high word the
@@ -81,6 +79,10 @@ static enum pci_protocol_version_t pci_protocol_versions=
[] =3D {
 	PCI_PROTOCOL_VERSION_1_1,
 };
=20
+static struct irq_domain *parent_domain;
+static bool fasteoi;
+static u8 delivery_mode;
+
 #define PCI_CONFIG_MMIO_LENGTH	0x2000
 #define CFG_PAGE_OFFSET 0x1000
 #define CFG_PAGE_SIZE (PCI_CONFIG_MMIO_LENGTH - CFG_PAGE_OFFSET)
@@ -1217,7 +1219,6 @@ static void hv_irq_mask(struct irq_data *data)
 static void hv_irq_unmask(struct irq_data *data)
 {
 	struct msi_desc *msi_desc =3D irq_data_get_msi_desc(data);
-	struct irq_cfg *cfg =3D irqd_cfg(data);
 	struct hv_retarget_device_interrupt *params;
 	struct hv_pcibus_device *hbus;
 	struct cpumask *dest;
@@ -1246,11 +1247,12 @@ static void hv_irq_unmask(struct irq_data *data)
 			   (hbus->hdev->dev_instance.b[7] << 8) |
 			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
 			   PCI_FUNC(pdev->devfn);
-	params->int_target.vector =3D cfg->vector;
+	params->int_target.vector =3D hv_msi_get_int_vector(data);
=20
 	/*
-	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED by
-	 * setting the HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
+	 * For x64, honoring apic->delivery_mode set to
+	 * APIC_DELIVERY_MODE_FIXED by setting the
+	 * HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
 	 * spurious interrupt storm. Not doing so does not seem to have a
 	 * negative effect (yet?).
 	 */
@@ -1347,7 +1349,7 @@ static u32 hv_compose_msi_req_v1(
 	int_pkt->wslot.slot =3D slot;
 	int_pkt->int_desc.vector =3D vector;
 	int_pkt->int_desc.vector_count =3D 1;
-	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
+	int_pkt->int_desc.delivery_mode =3D delivery_mode;
=20
 	/*
 	 * Create MSI w/ dummy vCPU set, overwritten by subsequent retarget in
@@ -1377,7 +1379,7 @@ static u32 hv_compose_msi_req_v2(
 	int_pkt->wslot.slot =3D slot;
 	int_pkt->int_desc.vector =3D vector;
 	int_pkt->int_desc.vector_count =3D 1;
-	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
+	int_pkt->int_desc.delivery_mode =3D delivery_mode;
 	cpu =3D hv_compose_msi_req_get_cpu(affinity);
 	int_pkt->int_desc.processor_array[0] =3D
 		hv_cpu_number_to_vp_number(cpu);
@@ -1397,7 +1399,7 @@ static u32 hv_compose_msi_req_v3(
 	int_pkt->int_desc.vector =3D vector;
 	int_pkt->int_desc.reserved =3D 0;
 	int_pkt->int_desc.vector_count =3D 1;
-	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
+	int_pkt->int_desc.delivery_mode =3D delivery_mode;
 	cpu =3D hv_compose_msi_req_get_cpu(affinity);
 	int_pkt->int_desc.processor_array[0] =3D
 		hv_cpu_number_to_vp_number(cpu);
@@ -1419,7 +1421,6 @@ static u32 hv_compose_msi_req_v3(
  */
 static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct irq_cfg *cfg =3D irqd_cfg(data);
 	struct hv_pcibus_device *hbus;
 	struct vmbus_channel *channel;
 	struct hv_pci_dev *hpdev;
@@ -1470,7 +1471,7 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
 		size =3D hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
 					dest,
 					hpdev->desc.win_slot.slot,
-					cfg->vector);
+					hv_msi_get_int_vector(data));
 		break;
=20
 	case PCI_PROTOCOL_VERSION_1_2:
@@ -1478,14 +1479,14 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a, struct msi_msg *msg)
 		size =3D hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
 					dest,
 					hpdev->desc.win_slot.slot,
-					cfg->vector);
+					hv_msi_get_int_vector(data));
 		break;
=20
 	case PCI_PROTOCOL_VERSION_1_4:
 		size =3D hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
 					dest,
 					hpdev->desc.win_slot.slot,
-					cfg->vector);
+					hv_msi_get_int_vector(data));
 		break;
=20
 	default:
@@ -1601,7 +1602,7 @@ static struct irq_chip hv_msi_irq_chip =3D {
 };
=20
 static struct msi_domain_ops hv_msi_ops =3D {
-	.msi_prepare	=3D pci_msi_prepare,
+	.msi_prepare	=3D hv_msi_prepare,
 	.msi_free	=3D hv_msi_free,
 };
=20
@@ -1625,12 +1626,13 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus=
_device *hbus)
 	hbus->msi_info.flags =3D (MSI_FLAG_USE_DEF_DOM_OPS |
 		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
 		MSI_FLAG_PCI_MSIX);
-	hbus->msi_info.handler =3D handle_edge_irq;
-	hbus->msi_info.handler_name =3D "edge";
+	hbus->msi_info.handler =3D
+		fasteoi ? handle_fasteoi_irq : handle_edge_irq;
+	hbus->msi_info.handler_name =3D fasteoi ? "fasteoi" : "edge";
 	hbus->msi_info.data =3D hbus;
 	hbus->irq_domain =3D pci_msi_create_irq_domain(hbus->fwnode,
 						     &hbus->msi_info,
-						     x86_vector_domain);
+						     parent_domain);
 	if (!hbus->irq_domain) {
 		dev_err(&hbus->hdev->device,
 			"Failed to build an MSI IRQ domain\n");
@@ -3531,13 +3533,21 @@ static void __exit exit_hv_pci_drv(void)
 	hvpci_block_ops.read_block =3D NULL;
 	hvpci_block_ops.write_block =3D NULL;
 	hvpci_block_ops.reg_blk_invalidate =3D NULL;
+
+	hv_pci_irqchip_free();
 }
=20
 static int __init init_hv_pci_drv(void)
 {
+	int ret;
+
 	if (!hv_is_hyperv_initialized())
 		return -ENODEV;
=20
+	ret =3D hv_pci_irqchip_init(&parent_domain, &fasteoi, &delivery_mode);
+	if (ret)
+		return ret;
+
 	/* Set the invalid domain number's bit, so it will not be used */
 	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
=20
@@ -3546,7 +3556,11 @@ static int __init init_hv_pci_drv(void)
 	hvpci_block_ops.write_block =3D hv_write_config_block;
 	hvpci_block_ops.reg_blk_invalidate =3D hv_register_block_invalidate;
=20
-	return vmbus_driver_register(&hv_pci_drv);
+	ret =3D vmbus_driver_register(&hv_pci_drv);
+	if (ret)
+		hv_pci_irqchip_free();
+
+	return ret;
 }
=20
 module_init(init_hv_pci_drv);
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv=
-tlfs.h
index 56348a541c50..45cc0c3b8ed7 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -539,39 +539,6 @@ enum hv_interrupt_source {
 	HV_INTERRUPT_SOURCE_IOAPIC,
 };
=20
-union hv_msi_address_register {
-	u32 as_uint32;
-	struct {
-		u32 reserved1:2;
-		u32 destination_mode:1;
-		u32 redirection_hint:1;
-		u32 reserved2:8;
-		u32 destination_id:8;
-		u32 msi_base:12;
-	};
-} __packed;
-
-union hv_msi_data_register {
-	u32 as_uint32;
-	struct {
-		u32 vector:8;
-		u32 delivery_mode:3;
-		u32 reserved1:3;
-		u32 level_assert:1;
-		u32 trigger_mode:1;
-		u32 reserved2:16;
-	};
-} __packed;
-
-/* HvRetargetDeviceInterrupt hypercall */
-union hv_msi_entry {
-	u64 as_uint64;
-	struct {
-		union hv_msi_address_register address;
-		union hv_msi_data_register data;
-	} __packed;
-};
-
 union hv_ioapic_rte {
 	u64 as_uint64;
=20
--=20
2.25.1

