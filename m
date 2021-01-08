Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB432EEDE3
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Jan 2021 08:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbhAHHb5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Jan 2021 02:31:57 -0500
Received: from mail-co1nam11on2134.outbound.protection.outlook.com ([40.107.220.134]:24790
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbhAHHb5 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Jan 2021 02:31:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkMDAgRWCbRo0JXvcIoV5uWCnxKVs4wG02Vi2tUySXFhUtYbECQFpueBSx+gf9gYJ3UtH/FlLlENXX3VcuySfZ/Fx/wNT3U/JvYl/208rQbPWC/uEbyFytteF6KiDZHqrOGrrGv/Wc2SPz1ce+fUkjIlldxwbTjjA7pbUDY0WKrcxXE8+dqG2vOfnvDuzkI+BOGmYvRXuOUgyLTulz+nuP/brAdcyCY6nVm10kgrBl5OL6kT8qxrPKBgfWjjDpq4wO1EbRHPwJ+9ihqb9/2YcigD1Xlw3QNhc4OL+NWA90bxj1q1nQxD6ijxl7cMPYhEi3kFqYHUmoxbrqiP34w+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRQ0ZdUESidlGsbsjyMgnR/NapqB/+xGffCt+6KLgdc=;
 b=lLTX+xJckC6njFx5vmKkBNWkkC1vZqCdDCzcxTtk5UX/Jvmikyl2llP6pz7FA0bPCUAgLMfIajEednTGmamLS8i891gsXtC0kVOeEzMOs3wbcrbiuQqe2OrCypeMi6VzMfKrWh//nn8RqC8WdNIA6PDcmDufZUDrAhp05i5GuVImmfcPaGCrghuJUiuVtAgf0/JD8FODawbcsKmzwmLXuW2rbdkhh8Mzd3/TCHYsVe9avWeKF+vrSINCLqqiU1FZR8ZNVKQGmWeGIQM9p4kdUPxJtPD8yd+Fv5Wj5Tc1QMbnV3bXaCot0JuUfx+ZD3qDli7WE9p+tBwcv43+nBKiKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRQ0ZdUESidlGsbsjyMgnR/NapqB/+xGffCt+6KLgdc=;
 b=QXrrEnomgwgnWaUG0MkD+FKucotZb9ccJu8Il2epgqH6o/NnGqZ9v0/JK12PAGSFilWM/qHeXyS3OyXmmZvji8snbu43MWZYIuf5cIm/FEfH/rWgbFeQzBU2YfgTe6KOPN9+tODUyWFBuhtkgVWCzwzCxKuPvPOvkC7MhScBZGQ=
Received: from (2603:10b6:803:51::33) by
 SA0PR21MB1866.namprd21.prod.outlook.com (2603:10b6:806:ed::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.0; Fri, 8 Jan 2021 07:31:08 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8%4]) with mapi id 15.20.3763.002; Fri, 8 Jan 2021
 07:31:08 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH v2 1/2] Hyper-V: pci: x64: Generalize irq/msi set-up and
 handling
Thread-Topic: [PATCH v2 1/2] Hyper-V: pci: x64: Generalize irq/msi set-up and
 handling
Thread-Index: Adbljt4x9C/tWN57TcS7/Z2kriU9tg==
Date:   Fri, 8 Jan 2021 07:31:08 +0000
Message-ID: <SN4PR2101MB0880A1BF1E62836EED4B8358C0AE9@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:916:634a:e039:b890]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e9c4b3a-acbe-4508-f272-08d8b3a75dc7
x-ms-traffictypediagnostic: SA0PR21MB1866:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR21MB1866FB9759333C5171DCE6CAC0AE9@SA0PR21MB1866.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GNePyEutR/RaMbeiQNQ/dmhDIvvBb/np7S84ighQH4QltNeYCEW8pfOIeN97Xsr30HPkaac6YLSzwJ2F/vRwtuO7QEZyGbbBab9fPY/s6SN/Zg4vs2OS3gPd7NIWJrTYz0kCssUXcWL3dswDjPf0wtzkirneVm/1xnPqy7fh2Z+b+MVx+BFQAe6hRgBUuhgN9JUxTlxdcTDh3qVmaiNqE1wIsheSbQnfTuOvEy3qPK9DCSfiyA1id+EJTXLNvmoC5j1HKnvsl8xasH7N01m11aklDn4HFCA1o+t7XUEQQRak5A941yqVksTWCHger7STt2NOzZGmOat8iGOeCK1oH+VLPdhAVbdeT/QGmxvuaWd+xbMPPGViZbGTWAdt7rDaDPrHf0Cdktqeop4Xbf/tVhZC6WR4aANDzkICrg6TJ9LO0/b6XROh65B4LGMIeFam
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(86362001)(6506007)(921005)(8936002)(7416002)(33656002)(4326008)(110136005)(316002)(54906003)(8990500004)(7696005)(8676002)(478600001)(10290500003)(71200400001)(52536014)(186003)(82960400001)(9686003)(5660300002)(76116006)(66476007)(66946007)(83380400001)(64756008)(66556008)(55016002)(82950400001)(2906002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6I15pTyzSubSQX8nN5MQUIM5T8qIVRWWrhJBvlcc2qPAuB1WhsLAREtBsuFd?=
 =?us-ascii?Q?iakLKw6XiinbDyV+uoqjZE5h9M5aIR2s0mXyMR+6XSKi+JO2zDt3pBfO/zXc?=
 =?us-ascii?Q?4z6Un+tr6Lqkv1iD4+73nSJgyWgHc7BIDEJTh7CQY7Y/DZzf/hkKQm3YuLgQ?=
 =?us-ascii?Q?G7BOYzDihda0WRixbjF0x3X44Za8F0uPi7KePZtXuP6/cFe/+8Si5NsmGkQl?=
 =?us-ascii?Q?g3B6YHwnG9T6qvH4zNSKcb4mhg+fvLlVYFXxGCw5g4+iesaAfKOFIqqrlnYZ?=
 =?us-ascii?Q?ghqGDn/oyVWUDJCCaKCYOLFLA43W9cuUOe1XGIDjVxhR3P6jDP702ZVYkc7e?=
 =?us-ascii?Q?AsXPOEOWCi/szCT6/5rhFLJPyRgnDsK3aPNwSsHRsXkHt1fOtYjMlaavTPk3?=
 =?us-ascii?Q?4Ggww2xwWMwM1UiJ+HYg3sWkmBH9AtsnhmzABIuLASfli08WULmkcElHk6ZY?=
 =?us-ascii?Q?uick/MvWLvbS9oYiP6KehM2vjTBbUAsHH6yEHeNW42kiVcWbfBox5K6q6cBo?=
 =?us-ascii?Q?tTGSLeeVEvdzZKUvtQRdErkiiEFanLU1wSlA5uyvs4bsElLzvTMEzyGNRO2X?=
 =?us-ascii?Q?1Z+ncESwRboxPcx6TvJaxSgoU1jiS89ai09PNe6jRCOWlFWPm9+2t4R+Pjve?=
 =?us-ascii?Q?u5s/2k2vbzbsGMqktwA3mO8tO8vTAi6qXMJH0v4IyS3eC2w02Wrs39K8wP7U?=
 =?us-ascii?Q?EokmsW37ndUScmPXuVu4UDogH3qMZDYMQk8QHGoyQsCl5SiCfUzxCv/h4olU?=
 =?us-ascii?Q?UNhVotR+cuE8EmRRWw228g/dpxjkzlvXzzXSIQC1nmkl5HvcgqoamYfE8D5c?=
 =?us-ascii?Q?hnn7Ifr7L30A/p6Tt8cJ0E3/HZPaVNXKcxUhlpAao3ulT95wDMzBwcx9odSz?=
 =?us-ascii?Q?2Juqp+Z40efOAhjsn3/r6d9Gi2QKHVpPrYvb5ehsA1/mTda0AJMywV2DEcUq?=
 =?us-ascii?Q?4+sEgZm9z34mIGfHL1144X4xqgNJysCZJCgrOfUoMvy+aK1xlcW0C2dcvjpO?=
 =?us-ascii?Q?41WVwqg7vcs4Mbq+3v/O25krn9BC/vwoihuHa/6OryL6Ze4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9c4b3a-acbe-4508-f272-08d8b3a75dc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 07:31:08.5553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bO3XaNFIZsO8a25DsARaEioBPoJLrAGOBWsFd6+xM1BINhFLfdGtlahPWGv0fgHHfnK2+a4bvyrkxkuuQHU98DpVq1s1ZDMchXDonhfepLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1866
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently, operations related to irq/msi in Hyper-V vPCI are
x86-specific code. In order to support virtual PCI on Hyper-V for
other architectures, introduce generic interfaces to replace the
x86-specific ones. There are no functional changes in this patch.

Co-developed-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
In V2:
- Addressed feedback on SoB tab.
- Added a second patch to move the MSI entry definition.
---
 arch/x86/include/asm/mshyperv.h     | 24 +++++++++++++++++++++
 drivers/pci/controller/pci-hyperv.c | 33 +++++++++++++++++------------
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyper=
v.h
index ffc289992d1b..05b32ef57e34 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -245,6 +245,30 @@ bool hv_vcpu_is_preempted(int vcpu);
 static inline void hv_apic_init(void) {}
 #endif
=20
+#define hv_msi_handler		handle_edge_irq
+#define hv_msi_handler_name	"edge"
+#define hv_msi_prepare		pci_msi_prepare
+
+/* Returns the Hyper-V PCI parent MSI vector domain. */
+static inline struct irq_domain *hv_msi_parent_vector_domain(void)
+{
+	return x86_vector_domain;
+}
+
+/* Returns the interrupt vector mapped to the given IRQ. */
+static inline unsigned int hv_msi_get_int_vector(struct irq_data *data)
+{
+	struct irq_cfg *cfg =3D irqd_cfg(data);
+
+	return cfg->vector;
+}
+
+/* Get the IRQ delivery mode. */
+static inline u8 hv_msi_irq_delivery_mode(void)
+{
+	return APIC_DELIVERY_MODE_FIXED;
+}
+
 static inline void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entr=
y,
 					      struct msi_desc *msi_desc)
 {
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 6db8d96a78eb..9ca740d275d7 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -43,12 +43,11 @@
 #include <linux/delay.h>
 #include <linux/semaphore.h>
 #include <linux/irqdomain.h>
-#include <asm/irqdomain.h>
-#include <asm/apic.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/hyperv.h>
 #include <linux/refcount.h>
+#include <linux/pci.h>
 #include <asm/mshyperv.h>
=20
 /*
@@ -1194,7 +1193,6 @@ static void hv_irq_mask(struct irq_data *data)
 static void hv_irq_unmask(struct irq_data *data)
 {
 	struct msi_desc *msi_desc =3D irq_data_get_msi_desc(data);
-	struct irq_cfg *cfg =3D irqd_cfg(data);
 	struct hv_retarget_device_interrupt *params;
 	struct hv_pcibus_device *hbus;
 	struct cpumask *dest;
@@ -1223,7 +1221,7 @@ static void hv_irq_unmask(struct irq_data *data)
 			   (hbus->hdev->dev_instance.b[7] << 8) |
 			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
 			   PCI_FUNC(pdev->devfn);
-	params->int_target.vector =3D cfg->vector;
+	params->int_target.vector =3D hv_msi_get_int_vector(data);
=20
 	/*
 	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED by
@@ -1324,7 +1322,7 @@ static u32 hv_compose_msi_req_v1(
 	int_pkt->wslot.slot =3D slot;
 	int_pkt->int_desc.vector =3D vector;
 	int_pkt->int_desc.vector_count =3D 1;
-	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
+	int_pkt->int_desc.delivery_mode =3D hv_msi_irq_delivery_mode();
=20
 	/*
 	 * Create MSI w/ dummy vCPU set, overwritten by subsequent retarget in
@@ -1345,7 +1343,7 @@ static u32 hv_compose_msi_req_v2(
 	int_pkt->wslot.slot =3D slot;
 	int_pkt->int_desc.vector =3D vector;
 	int_pkt->int_desc.vector_count =3D 1;
-	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
+	int_pkt->int_desc.delivery_mode =3D hv_msi_irq_delivery_mode();
=20
 	/*
 	 * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
@@ -1372,7 +1370,6 @@ static u32 hv_compose_msi_req_v2(
  */
 static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct irq_cfg *cfg =3D irqd_cfg(data);
 	struct hv_pcibus_device *hbus;
 	struct vmbus_channel *channel;
 	struct hv_pci_dev *hpdev;
@@ -1422,7 +1419,7 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
 		size =3D hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
 					dest,
 					hpdev->desc.win_slot.slot,
-					cfg->vector);
+					hv_msi_get_int_vector(data));
 		break;
=20
 	case PCI_PROTOCOL_VERSION_1_2:
@@ -1430,7 +1427,7 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
 		size =3D hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
 					dest,
 					hpdev->desc.win_slot.slot,
-					cfg->vector);
+					hv_msi_get_int_vector(data));
 		break;
=20
 	default:
@@ -1541,12 +1538,13 @@ static struct irq_chip hv_msi_irq_chip =3D {
 	.irq_compose_msi_msg	=3D hv_compose_msi_msg,
 	.irq_set_affinity	=3D hv_set_affinity,
 	.irq_ack		=3D irq_chip_ack_parent,
+	.irq_eoi		=3D irq_chip_eoi_parent,
 	.irq_mask		=3D hv_irq_mask,
 	.irq_unmask		=3D hv_irq_unmask,
 };
=20
 static struct msi_domain_ops hv_msi_ops =3D {
-	.msi_prepare	=3D pci_msi_prepare,
+	.msi_prepare	=3D hv_msi_prepare,
 	.msi_free	=3D hv_msi_free,
 };
=20
@@ -1565,17 +1563,26 @@ static struct msi_domain_ops hv_msi_ops =3D {
  */
 static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
 {
+	struct irq_domain *parent_domain;
+
+	parent_domain =3D hv_msi_parent_vector_domain();
+	if (!parent_domain) {
+		dev_err(&hbus->hdev->device,
+			"Failed to get parent MSI domain\n");
+		return -ENODEV;
+	}
+
 	hbus->msi_info.chip =3D &hv_msi_irq_chip;
 	hbus->msi_info.ops =3D &hv_msi_ops;
 	hbus->msi_info.flags =3D (MSI_FLAG_USE_DEF_DOM_OPS |
 		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
 		MSI_FLAG_PCI_MSIX);
-	hbus->msi_info.handler =3D handle_edge_irq;
-	hbus->msi_info.handler_name =3D "edge";
+	hbus->msi_info.handler =3D hv_msi_handler;
+	hbus->msi_info.handler_name =3D hv_msi_handler_name;
 	hbus->msi_info.data =3D hbus;
 	hbus->irq_domain =3D pci_msi_create_irq_domain(hbus->sysdata.fwnode,
 						     &hbus->msi_info,
-						     x86_vector_domain);
+						     parent_domain);
 	if (!hbus->irq_domain) {
 		dev_err(&hbus->hdev->device,
 			"Failed to build an MSI IRQ domain\n");
--=20
2.17.1
