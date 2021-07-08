Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648D73C1BA8
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 01:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhGHXHi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Jul 2021 19:07:38 -0400
Received: from mail-bn8nam11on2133.outbound.protection.outlook.com ([40.107.236.133]:16431
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230489AbhGHXHh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Jul 2021 19:07:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBaWNMrYsrH9otA+gGwLcCdkKvCRExYYyCBacHNA6RzD2eATGNMSJe5cZFgWMSsxL2009Axxn0aVQANDJjcsMz2q2ComLDwXnHDVJdcYylK2tAih8iKLBIV6n/jMfDFkTvvNrDylsp7GIbj6xih6vE/2vq399Jxja0nAoeOfAbicq30nb31R/PaT9aIhiMaOZMukxvN0QYmhHj+NjQKqXoFwgFQxH84sZmmZRqr8HcFeTPd/iNy8SPR50ytnWzobZZ3YuF7t6gxIamC4aDb+YbjBTHtyk/EUIWQ70CofR3DUCuaMZ9qtHXZXjOJN1AO0woeJW3wkGvYje/QIrH+UfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVuZiNmr9CTZe3dl8Wd+j7pPhPqY4cvex2dRZ8x2q7Y=;
 b=Pd7M+SAe5TC85nYh+VtZGNyVqplM07uCOCeZeKGAFnQH5iSYAmnEIGfdiIXZEVO8ifyaFY6X+V/YuVU0DrvYDgHosw11Vm3K1o0PkQFDtrRJrYvC9diioMssVFVnV7JhSCXFe8sv0LuJUYQq382Lwl2Bp91FEdX3Pcn1vwfD8NncAnLhst6SksXRpSHnNDe5ihDQ0w2C8iFTqQR8CJbrYvvvy6ycA4/TPphmWpTc+GByOTLjfZ8jY1j4HrQxwJunhnQpE0gCYyUaDVLlbevX76nHC+AXetQjFx5psb+eHYndQaxvSHOLlQH8MiCePSQ1o5IbtQfgzZQU6JlYtZ8IBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVuZiNmr9CTZe3dl8Wd+j7pPhPqY4cvex2dRZ8x2q7Y=;
 b=TjmiDxsn1Eq7t96s4ewLhlx/XVGDuzI/i1Eq2Fyb8WaDSOLjvu/rc5DXy21kfAzZMEY+4Jrk6UDGUprZ0LFQSTbjFN73GlfwrS0GSPNiXoa8f75JjFinNVMBSkgLW9EQH+O9SBTIubvbiYayEGqQ9xu7pvRu1OiRa33Gkg63SHI=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MWHPR21MB0142.namprd21.prod.outlook.com (2603:10b6:300:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.12; Thu, 8 Jul
 2021 23:04:51 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::f8cc:2c20:d821:355c]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::f8cc:2c20:d821:355c%4]) with mapi id 15.20.4331.012; Thu, 8 Jul 2021
 23:04:50 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/1] PCI: hv: Support for create interrupt v3
Thread-Topic: [PATCH 1/1] PCI: hv: Support for create interrupt v3
Thread-Index: Add0TIVdcQX5pMV/TWWUfz5smDdQ7A==
Date:   Thu, 8 Jul 2021 23:04:49 +0000
Message-ID: <MW4PR21MB20025B945D77BBFDF61C6DA8C0199@MW4PR21MB2002.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b234f5c4-c70e-4c07-8a82-08d94264ca67
x-ms-traffictypediagnostic: MWHPR21MB0142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0142D292C98BFC129533AF53C0199@MWHPR21MB0142.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t3/sKUHFQSe8x89YI5f7f1MYNtVbCWbyalSxGQ0jHjYKq0stbFFaAF4mEBviJvhk2ueyUiN5q8aAzETNRK3eYGZEZ8eyi4UCkEijZaQ40gZW6UA//nKw8JM7fDDZSXC3fJIkTKkgbWSmaeR9WlMTqxLxImxx1xqRucCL+yiU45CSLFphLlysfILwFZ2lrXKR6M0yPoR1rYIpioegY3b6C1WpSQclORRf6zUBU8a2cVyZDrMDQiTOLEMQsTEgtYGIGas/C6MIBN6aicqOnN2dqNQEBVE5x+g6r4pT4avho60bSfWv4i9HCr91U/IR2AB/gQohRXKw8EOAbi0366ggv5LxU0z0h5lIVEK5cfQUR25xnadXJ+miRvIIoJg8/Z6E8e2/hSLMToRWoAFL8U8U4W5EguBhBFc4SeLuiMMpoxBqFP3rKaEO/fV5NLbsOUciNZCTiASxZuQ9kBnlsXp7e2UtVUDHqNO5S6WPr7RDp10jjwiGUKpgUIkyDUv9VPUEX/O/aG28HR/jUTQNshpp+0BHLnHjYYoQ1dzdPIk1O0jhHqZwqWed79PzrZ//JhpTxk1k8c4sTu1S4QGKi+S26sKrBZfsxrWQmMuXxIbST2+T48N8+5+42HG9Gb7RTYYezOJD60QU9kt4fLnvCGwDpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(54906003)(52536014)(9686003)(478600001)(110136005)(83380400001)(76116006)(8676002)(7696005)(122000001)(38100700002)(316002)(66556008)(6506007)(8990500004)(8936002)(66946007)(66476007)(186003)(71200400001)(66446008)(10290500003)(33656002)(64756008)(82950400001)(6636002)(82960400001)(5660300002)(2906002)(4326008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JFifBPGgzDrLhQiRXCep8IpeOX218w2za6kHehqP84IweBlOfRDjIGu6Bcv2?=
 =?us-ascii?Q?t6DSw9bapB9IPxbbTP6f076vQVB5mydfv6s9zLsHa0GCNTP2jntIzDCT4i31?=
 =?us-ascii?Q?AKK9Etcy7NMpjjQAdPem0EDO1BLu29O6cXbj7QNkoGvH/hcVbaObeUswIoxx?=
 =?us-ascii?Q?aNoMTxfOzxRuQVKXbmSRmK8AYhVsKlemjj+2kgkcOI7gKeaNOe2qlPnMlOXA?=
 =?us-ascii?Q?nRf2x+6BjTRPdmqUGO2yj1jdNyvliUA1sWNjngbhkDAtDu8z5350s+MxFyOo?=
 =?us-ascii?Q?1lPtVxH6q5Z4yGgzU4zmSAGPTK1wCwTuJX67l7fiQOh/kaDKLVBbdqM3Ra5p?=
 =?us-ascii?Q?8ZQ2HfbcTtl4Y6IWhtoV/vEp9APM//HPZasAsZ2+SRrl0/8B6rOktMx1AjLo?=
 =?us-ascii?Q?pC7SzCQS8yNdl1v2oYFH+u36iYg9dotfjUIhuMSo+ljBdMFulrC/IYssoDzr?=
 =?us-ascii?Q?8Jsu5Xp1QVns5O9x2PkaWki65NtDYU6TdFeHxEHXdx0tyCT3kUyZl4KwB8DJ?=
 =?us-ascii?Q?Xuj1/17Ex15Yre6TLJkmVNFpE0E9CRxr7vR+Y2QhKNcXrp8/5roWXmi6avUk?=
 =?us-ascii?Q?ktsF7fecVYsn/NHjdLf3xDhTQ95FIIYsRGXNntlbqHpmpcA9YJjpZF86oIyf?=
 =?us-ascii?Q?vVWtuWLetmE1WNp8PORR6ldHbJ2ru5qNkFaQoOnms6GXQ9CohuVxWj3XHVwg?=
 =?us-ascii?Q?HSnwHzEL9/cu+Hu0tavdCsuzYaeLu9x8+OHTcgUXLKGZ3DFjF9nCMMhFzCzX?=
 =?us-ascii?Q?T0ciiZBuirYYZGqocjyuICCN5pyqDJ7CK04pP6FVdkWlm+sXB3Vu3/Ea1wEx?=
 =?us-ascii?Q?ivqyPyvirdT3eSAiP1ZinrajNQG+HgZ0vnzG5YWTVHhfIVzwpNN+Lp+fO9Q0?=
 =?us-ascii?Q?zIf36tD2Jn7GYzwXGsxpIjVCAiPI176l+Ukmf8eNyQu9kfGjApONAWzhnA2F?=
 =?us-ascii?Q?hItlb/3llAMc5UhCrDCOE1NS9ugipkZEM1ZUwBkBw4bVOx9n4QAGjSz8dGbn?=
 =?us-ascii?Q?Nk89+AtdrXBQlwiAh38XNUPajhq7AKPmiqbIhm/wCGn+z98gyIYOuQ41PPRr?=
 =?us-ascii?Q?HaZtTBCXv6ORBExGFQAtImCzJsxgnlIgp2RakbVdnBQ4lVMVx+CuAwvGgyku?=
 =?us-ascii?Q?PRbXW+8yxN1o4GEJ+8KEmvY1i6lY0t4D8xsC2DcDgC+/S03dM9MxcPPEFRah?=
 =?us-ascii?Q?66pcj6Ccxa1lQ96QaQSSDj026IVVdV3DFkJy6JNOIW0+Uc5+LZRG9epVRuqQ?=
 =?us-ascii?Q?baxiRX61inNCRhkWVg3xUivBby2heS3w2if4LgfvzkAcBmaT1XWvs7Kthafe?=
 =?us-ascii?Q?i6Hu5Eywoo2rNacXUw21sud7LPwDZiH17hqd1WCJynqOxGaOeIrMeY/8R2Dw?=
 =?us-ascii?Q?Yofl+0JNQrAHYZe231uyAfZUHzNM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b234f5c4-c70e-4c07-8a82-08d94264ca67
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 23:04:50.7381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7n24WpdvH7FAYwJgRzFYjvQ/iOVFFNwqNrv4yY/aCxRpx1tcGoMXJe3EAx/MTA+mhBdMlJVhgkDaFLv/yM3bxII9wl6nr1nye8xdWrNOANM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0142
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V vPCI protocol version 1_4 adds support for create interrupt
v3. Create interrupt v3 essentially makes the size of the vector
field bigger in the message, thereby allowing bigger vector values.
For example, that will come into play for supporting LPI vectors
on ARM, which start at 8192.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 74 ++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index bebe3eeebc4e..de61b20f9604 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -64,6 +64,7 @@ enum pci_protocol_version_t {
 	PCI_PROTOCOL_VERSION_1_1 =3D PCI_MAKE_VERSION(1, 1),	/* Win10 */
 	PCI_PROTOCOL_VERSION_1_2 =3D PCI_MAKE_VERSION(1, 2),	/* RS1 */
 	PCI_PROTOCOL_VERSION_1_3 =3D PCI_MAKE_VERSION(1, 3),	/* Vibranium */
+	PCI_PROTOCOL_VERSION_1_4 =3D PCI_MAKE_VERSION(1, 4),      /* Fe */
 };
=20
 #define CPU_AFFINITY_ALL	-1ULL
@@ -73,6 +74,7 @@ enum pci_protocol_version_t {
  * first.
  */
 static enum pci_protocol_version_t pci_protocol_versions[] =3D {
+	PCI_PROTOCOL_VERSION_1_4,
 	PCI_PROTOCOL_VERSION_1_3,
 	PCI_PROTOCOL_VERSION_1_2,
 	PCI_PROTOCOL_VERSION_1_1,
@@ -122,6 +124,8 @@ enum pci_message_type {
 	PCI_CREATE_INTERRUPT_MESSAGE2	=3D PCI_MESSAGE_BASE + 0x17,
 	PCI_DELETE_INTERRUPT_MESSAGE2	=3D PCI_MESSAGE_BASE + 0x18, /* unused */
 	PCI_BUS_RELATIONS2		=3D PCI_MESSAGE_BASE + 0x19,
+	PCI_RESOURCES_ASSIGNED3         =3D PCI_MESSAGE_BASE + 0x1A,
+	PCI_CREATE_INTERRUPT_MESSAGE3   =3D PCI_MESSAGE_BASE + 0x1B,
 	PCI_MESSAGE_MAXIMUM
 };
=20
@@ -235,6 +239,21 @@ struct hv_msi_desc2 {
 	u16	processor_array[32];
 } __packed;
=20
+/*
+ * struct hv_msi_desc3 - 1.3 version of hv_msi_desc
+ *	Everything is the same as in 'hv_msi_desc2' except that the size
+ *	of the 'vector_count' field is larger to support bigger vector
+ *	values. For ex: LPI vectors on ARM.
+ */
+struct hv_msi_desc3 {
+	u32	vector;
+	u8	delivery_mode;
+	u8	reserved;
+	u16	vector_count;
+	u16	processor_count;
+	u16	processor_array[32];
+} __packed;
+
 /**
  * struct tran_int_desc
  * @reserved:		unused, padding
@@ -383,6 +402,12 @@ struct pci_create_interrupt2 {
 	struct hv_msi_desc2 int_desc;
 } __packed;
=20
+struct pci_create_interrupt3 {
+	struct pci_message message_type;
+	union win_slot_encoding wslot;
+	struct hv_msi_desc3 int_desc;
+} __packed;
+
 struct pci_delete_interrupt {
 	struct pci_message message_type;
 	union win_slot_encoding wslot;
@@ -1334,26 +1359,55 @@ static u32 hv_compose_msi_req_v1(
 	return sizeof(*int_pkt);
 }
=20
+static void hv_compose_msi_req_get_cpu(struct cpumask *affinity, int *cpu,
+				       u16 *count)
+{
+	/*
+	 * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
+	 * by subsequent retarget in hv_irq_unmask().
+	 */
+	*cpu =3D cpumask_first_and(affinity, cpu_online_mask);
+	*count =3D 1;
+}
+
 static u32 hv_compose_msi_req_v2(
 	struct pci_create_interrupt2 *int_pkt, struct cpumask *affinity,
 	u32 slot, u8 vector)
 {
 	int cpu;
+	u16 cpu_count;
=20
 	int_pkt->message_type.type =3D PCI_CREATE_INTERRUPT_MESSAGE2;
 	int_pkt->wslot.slot =3D slot;
 	int_pkt->int_desc.vector =3D vector;
 	int_pkt->int_desc.vector_count =3D 1;
 	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
-
-	/*
-	 * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
-	 * by subsequent retarget in hv_irq_unmask().
-	 */
 	cpu =3D cpumask_first_and(affinity, cpu_online_mask);
+	hv_compose_msi_req_get_cpu(affinity, &cpu, &cpu_count);
 	int_pkt->int_desc.processor_array[0] =3D
 		hv_cpu_number_to_vp_number(cpu);
-	int_pkt->int_desc.processor_count =3D 1;
+	int_pkt->int_desc.processor_count =3D cpu_count;
+
+	return sizeof(*int_pkt);
+}
+
+static u32 hv_compose_msi_req_v3(
+	struct pci_create_interrupt3 *int_pkt, struct cpumask *affinity,
+	u32 slot, u32 vector)
+{
+	int cpu;
+	u16 cpu_count;
+
+	int_pkt->message_type.type =3D PCI_CREATE_INTERRUPT_MESSAGE3;
+	int_pkt->wslot.slot =3D slot;
+	int_pkt->int_desc.vector =3D vector;
+	int_pkt->int_desc.reserved =3D 0;
+	int_pkt->int_desc.vector_count =3D 1;
+	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
+	hv_compose_msi_req_get_cpu(affinity, &cpu, &cpu_count);
+	int_pkt->int_desc.processor_array[0] =3D
+		hv_cpu_number_to_vp_number(cpu);
+	int_pkt->int_desc.processor_count =3D cpu_count;
=20
 	return sizeof(*int_pkt);
 }
@@ -1385,6 +1439,7 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
 		union {
 			struct pci_create_interrupt v1;
 			struct pci_create_interrupt2 v2;
+			struct pci_create_interrupt3 v3;
 		} int_pkts;
 	} __packed ctxt;
=20
@@ -1432,6 +1487,13 @@ static void hv_compose_msi_msg(struct irq_data *data=
, struct msi_msg *msg)
 					cfg->vector);
 		break;
=20
+	case PCI_PROTOCOL_VERSION_1_4:
+		size =3D hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
+					dest,
+					hpdev->desc.win_slot.slot,
+					cfg->vector);
+		break;
+
 	default:
 		/* As we only negotiate protocol versions known to this driver,
 		 * this path should never hit. However, this is it not a hot
--=20
2.17.1
