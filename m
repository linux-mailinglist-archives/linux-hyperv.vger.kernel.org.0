Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683F22EC9D1
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jan 2021 06:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbhAGFG0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jan 2021 00:06:26 -0500
Received: from mail-bn7nam10on2118.outbound.protection.outlook.com ([40.107.92.118]:10849
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725929AbhAGFG0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jan 2021 00:06:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4PPd2nTKELnXfIZ2GflM2xzxlmXZdcyjn0qLd2H6kHKH1QRtESJ3JgThcdRhO03VtcqHKjlYBfuYKIKgf2/JoJW4U+BXhCd1Y6sZ8G5KJz61V72Xck5ZpAm0RSam7gOetsIm1rs2qyFnf7CK38U23c8pTB5CBNVQGpuANHHde2k7/suwEs6IjSUlKhlMHqTCihCceTTav02Z2A8KMlB93nAvVtE91HNWV8O4uY/2Bnj+9A7thQvM3bTtSo8jbgG3nqfyJgM3a2Zpl48YGE9wsd1gdH54RjLqk3VxfZjVW5Bab1MvT2RWOk53edX4UlITk9Zf86xmlnH+dcCUC5A4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9IKnXKI7nM+Rb32/24yW0ADpgXGcrTekl3zfUQrUZY=;
 b=BImt2VuZnw/ZLUBXuT3f+AYCiUejrcWiXVGyWjMO6yP0WM25XS+j1/bZzOUuXYRWZkcFdkLC1oFtLhgDXQt0XyvXa2dbXkcZAOFAFYmSTS3QCrAYw8MaH558Dj7ZRPNQ07a6RXmgW+lvLyf+eXGyuwMYp9z4CkQ64+jX4eaSMbo0t161yH8l+ObS9q4DdJ0Myo/5E/qFx85huwPjmAZwU5PTC/FGPDQB/NNO2tQN5sDgOGnb53D4D6YVBTrYgJZOQlrdPi3UKeD/6Xr7ukWNPNdkuuuWtQ++F/UXo3Qyx5IMMsKTwm7po7FCCOzIqc34yFVKnrSyLb5R95KAHv1Xaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9IKnXKI7nM+Rb32/24yW0ADpgXGcrTekl3zfUQrUZY=;
 b=Z5BS+NBq4SxX9N5gO8dFfkYiKJGNp++FzJNmLsFM5Kug+URxeUGeBD7F8U1uT8s+cNBdZLnZs5dxun6mFpYMfEcEl9lIyG9+NpK5IFa0Gmb0BGfnXahS2hHpCy3DSTdYXiNgYynkAIpeBZct7FDJQgHSPNw7VlpGuymwDXu7Gtw=
Received: from (2603:10b6:803:51::33) by
 SN6PR2101MB1679.namprd21.prod.outlook.com (2603:10b6:805:59::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.0; Thu, 7 Jan
 2021 05:05:37 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8%4]) with mapi id 15.20.3763.002; Thu, 7 Jan 2021
 05:05:37 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH] Hyper-V: pci: x64: Generalize irq/msi set-up and handling
Thread-Topic: [PATCH] Hyper-V: pci: x64: Generalize irq/msi set-up and
 handling
Thread-Index: Adbksm0P1pe4NiY6T8iz9IYs5m9slA==
Date:   Thu, 7 Jan 2021 05:05:36 +0000
Message-ID: <SN4PR2101MB08808404302E2E1AB6A27DD6C0AF9@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:f11f:f773:1cef:ecfe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a165ad10-bc9a-4e11-3129-08d8b2c9df13
x-ms-traffictypediagnostic: SN6PR2101MB1679:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1679B5A94491BF5F2BC991EEC0AF9@SN6PR2101MB1679.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DlOXH9dqUnI7WDAFQuvx0e4myZlLQxFnZCONhuwYgrMgsC4gkbKFYWrUZ7qkPmVZSEDejA2CO5jx8vmMpMJ8BYWAzQAssVoTxeDQHfN3WK0J6CDqEoCG8JM65OR8DgGSB9hyd4XZ1Bvebe7WZ9QER9wJ8Kh9edHkFE/jyjrSAXAr55NJNqoljtjRfhuxAY2USDtFe0WLybmYdW5KbwTKfqImfXNaNe2o3V9yzsscjS6ORncDDEMvsinWTlpv7KpKOs9vRpEUWkqxun0RCdFHS2nwwlo8nYmtYA8RlnF0nC8L+DR8ZgV4zITkE0FrRbxd9zT7jMm+T8jYXse7kzvoWQMmLVwSWBoHWOPlfLsLlTVak6VtW1BWaA23WrQXPckgM794qeOv7NCQJxVAOpr+ZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(71200400001)(9686003)(55016002)(83380400001)(54906003)(7416002)(6506007)(186003)(8936002)(8676002)(86362001)(2906002)(5660300002)(8990500004)(66946007)(33656002)(4326008)(52536014)(76116006)(10290500003)(316002)(82960400001)(66556008)(82950400001)(7696005)(478600001)(66446008)(64756008)(66476007)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Dsb8Bafto5Zd5lsn+X0SzKaWHTho2sfRkVKwI91uYc/tfAfZtgEoesKFlyG5?=
 =?us-ascii?Q?AZZzaVKM2weVWRaWuihUfSZyyXptYYoNkZeuzl3KZDXcEzeMJ8jemCqU/mnc?=
 =?us-ascii?Q?Hg8Lc60zyB8GOuPR+rgpwy7hAqFrnCsR5CFSK3Ki9V8Gl08qBhHe/y7GP7zp?=
 =?us-ascii?Q?WhJQEt0RPXhgtO64m2jgO9KbBvl/TGCF0V48ml0i25EFLWDlkmcc0+uW0oX0?=
 =?us-ascii?Q?eeUBvmS8OKsHz0Rg1+T/DocC6Tq3NTOHJRGA7XVxlSQxscIq2UGAcD8ZDefU?=
 =?us-ascii?Q?kdvHI//+sI3UNLwQLpK99OipSh3QKorHkaUrJl0TI757zP9yp7GCjLOGY7JJ?=
 =?us-ascii?Q?MRdVx6nR11P7gGMtyWd72HHVUvJ5LjnBNbASfhzh2yi/jeIHd0xqgdVfEs52?=
 =?us-ascii?Q?0qLyqYVgXKhokdYIesbviHG+tkrBGJlfibcdxPEE50sN3SKZSUXh3xhgzkxI?=
 =?us-ascii?Q?7rbdKBeDbUTiDLNPTwnvHWo8gTVes4KrXJG3u3EBMBOmA6UKClwIILAYAovA?=
 =?us-ascii?Q?XBxIPTUUiK8NmOvPn9kLVhhv3Y0n9anFXAowaxAWQKkXTkWif2/clxz1aHkh?=
 =?us-ascii?Q?6Fe8ghtlJOQFIILSrBmEUtRxOcYmIA0fME5xLBTs/0JxfcaHrh55KdD7JALt?=
 =?us-ascii?Q?RM2MzeXPTzWXXfj1lwOp8J67s3vMa4sWKh/lo1sfYf6zpDiIi8cOA8t0UHgb?=
 =?us-ascii?Q?MaJShHb72r3aqU/LhPCQlIDeI9haOTkk4hH5lM770vj9LTL5qsOfhdQfsk0q?=
 =?us-ascii?Q?YsnRmGRKFQd/5IxsrWG0xSImDPqE4/0rPp6+hCnGJ1UwX93lTRpDIAoSKmkY?=
 =?us-ascii?Q?vvEr+0TsmlKXQzgyVxYpkjC8yor+KGTBWvRCT2ekbjamlZLmCamtrcPbo6it?=
 =?us-ascii?Q?/uNEkZguC71XTzrftOmmQ7SRPu449ncEYpr6sF4BZtmUBZWBEzZPA2f3WM8R?=
 =?us-ascii?Q?2z81J+aQbxek71hAEDvH93mTMbK2j7HG23FIXN7t/jHhcGV4jw7QICXlKEBJ?=
 =?us-ascii?Q?dL1I4x1daA8dWUXJid2RRuMJwAsildHRpBSPRrIv/QGuVII=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a165ad10-bc9a-4e11-3129-08d8b2c9df13
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 05:05:37.2290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWX4LINyPqOTxS3nnqN8u/Ssikye9f5gwW9ciXQT3uLXjlI7qZ7lLHbQ2DnlwlPBK+jDiInHQvWwBvf0c0hAHZOKpJ6yOiBRbrtYRX0vBGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1679
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently, operations related to irq/msi in Hyper-V vPCI are
x86-specific code. In order to support virtual PCI on Hyper-V for
other architectures, introduce generic interfaces to replace the
x86-specific ones. There are no functional changes in this patch.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
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
