Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458223C65C9
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jul 2021 23:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhGLWBJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Jul 2021 18:01:09 -0400
Received: from mail-dm6nam12on2109.outbound.protection.outlook.com ([40.107.243.109]:46336
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229503AbhGLWBJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Jul 2021 18:01:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbTrD5b1LYPSIhdFuOUvoHeetNx7Ws9qUR7pz7cKgD1SW+ogOpTawPJdOxFA+/LiXFTT4u+KGWK/9tvgTJcb3cs19kVvolYHtArDddbIdDbWFUDyBmtHdTaQJggN/1za/iXOrxS7iIj8KSzCy7LlJm9OftS8J88uQjyugxhXNZOesK+t1IvSBshZgicHH8EoJyBhDmqm9hm26/ynmnDZtmdmgyk8Wa+bdxBxdWVuIK+qhPt6eC7pAnrk7YopXD7kQtk+UwLMjFX6gjWfeLhDY0J1UlRS5A2A4HEINaucy6fgsgZTqAwr4pEQKJ/w3OsFEu8UWTAC4xHZHZc4H3HWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1m2vh+LBcBsPJRH2hGVxkgzn0PMN1K9Jsp1gYSdxq4=;
 b=gAJNS5LKyqZ/yxTFezbFzyUdYFpmZAU8KklhEQrvRtZo//acS6r5QhhViTTcrfj3VspsbUJc9p97kHD5wuWT2RDl4D7gyAGAj7m25+Hu3YUWb6xTRq5LMUMwwdQ/4HzBuymTu0Db/GVkzuACKMhWfO+scECQc9ukNk9jaHaSnIQYXW3aLr8uG0ntyNzyvVBZ8q+q2qE0PIJgtkMfa/51urAE0zR6V7aVmBG5XT6ayBE1YPbbCgZsYkOMW8QC4kshmQS3MMscx/V/KQU8aDUCWrHGRJTiBOir1u77Bar0uIBymL8Djxe25pGVC7+pTTFNgvPGIqfS1KRIm6Lcf58mJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1m2vh+LBcBsPJRH2hGVxkgzn0PMN1K9Jsp1gYSdxq4=;
 b=GTHxIm8Nt5Ia/Hl9Az5EaUqq01e9B6HqwuqWvK4kPyoElg1KVYYXnw2pUOs9eHRbVr7up/+VUxlsxLcHAGj6xdoZTsQnU4woUkK2gNHS6Pi6LKVGXaiVxpqp+jmULxYZHNEYV8BY944nM+Hot9yl0dSmtuiXlLx2Q+6+66MVZnU=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MW4PR21MB2003.namprd21.prod.outlook.com (2603:10b6:303:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.4; Mon, 12 Jul
 2021 21:58:18 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::6082:4114:68ee:f569]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::6082:4114:68ee:f569%5]) with mapi id 15.20.4352.007; Mon, 12 Jul 2021
 21:58:18 +0000
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
Subject: [PATCH v3 1/1] PCI: hv: Support for create interrupt v3
Thread-Topic: [PATCH v3 1/1] PCI: hv: Support for create interrupt v3
Thread-Index: Add3aLOcHePYP261SY2/sMpJ3p6saA==
Date:   Mon, 12 Jul 2021 21:58:18 +0000
Message-ID: <MW4PR21MB20026A6EA554A0B9EC696AA8C0159@MW4PR21MB2002.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13941fb0-25ce-4894-10de-08d945802850
x-ms-traffictypediagnostic: MW4PR21MB2003:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB20037E14E92B4FB8A8F60F70C0159@MW4PR21MB2003.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R1p0DYloXz9clUS+5dhvqH0Rgz6B8L4iD2GGALSERA04/Jk7HzLhM8keMPA0lXwBuAYF/Ri4661nJLNXhisGKUQm3Vf5q7MHvpeopoFIIRs4neaRUknd2MAGRQQ2I0YtA0ZuLhmqJuxMlZUnv/w4v0f59bOnA1zdiL2cPqspseBRObXy/ooNAAgTtWOKc/D2/zt3Z8eZEL37B+93SOAhK0wmzen+dOr8Rke9brhr07jDio9mDI+iEPSfYRlc6CjkirbSvKLnLyfKV5FDR6pyjD2gHrGiCooU3Xrm/LIJMSgqxYMl5sEp1yli/kp6hLGH4HFv656pl564bo7jYgnjB+RZpN/ozrdCvKaJ29LKDrUiDle2gfuPcPxv2l0JPeQPi0f2BMRUPMdp+FJAUb2OJxPdqxh/RZau/wROSYy7tecaa315ulzW1v8SuJ6es+va/pooeCQjjuajwlqBPKTIAASCTHQ6Gm+svVdPIZr2HIN+bSQTzPPdV2/pKXaJkizWD7VIYz0IKN+hVi/41irE/1l0kzwGAa/+bvq9wgkXLII0qAUQJ0jLRm/1ljXOf4V88jyqGq4ZWhvgUXJHyjMVb5ddKSurflY9KJaLxJHXEuQGJalIQGG6nVwWnS1W73Djp3zO97E7s98J9QA6gfIsxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(110136005)(66446008)(66476007)(71200400001)(82950400001)(66946007)(66556008)(82960400001)(478600001)(6636002)(4326008)(10290500003)(52536014)(9686003)(8676002)(7696005)(2906002)(186003)(8990500004)(6506007)(33656002)(8936002)(76116006)(55016002)(122000001)(316002)(83380400001)(38100700002)(86362001)(54906003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0bPcVWUJceOBsz82W8MgCCqC/GaA5C0oWhlLD3uKJrGs9TR+6e1LTKJ9c67l?=
 =?us-ascii?Q?Y5TkzzNNTewmlT5vd1DyLlohLUkI9jUOMIyjHE5P50mH8Kql0roZm6UppPZG?=
 =?us-ascii?Q?M2F/6tq75eps5s01kkiiJ4/QIoTaeAp4RduTOT9B7xDzL361U/kGD2zjr94h?=
 =?us-ascii?Q?NCzNBDb31mbpGIYzKpdhEEAqKaRHSX+sk4kkSFMaUcgSQrRsq8sQCWV3ChdY?=
 =?us-ascii?Q?zq1vI6CIHKATFcwoicMoCccigaso/56rvFFTeqPUHhqfIYIZs1TjA0z8Hrlj?=
 =?us-ascii?Q?FkIN0AcoCflqxfRwvigH+nV1sPvshmABmxgL6U9Zz6mKB5/To0wTuK6zUitd?=
 =?us-ascii?Q?B/Xm2ZCHV3+RJNcHAlNoBLtEBeokcvGbfX54Mtn1pMulGJGg7yoMLcSN0OpK?=
 =?us-ascii?Q?Dzk7fvNCIDQKOieS/cd59AgPgiftcrBPbmg90WZz3xq1+DITpnrHQpHjd6Jr?=
 =?us-ascii?Q?aF744aqfy8ISlOCvM1ao5fcurpfeZAliTMaJjlFy14KEhP/5bi55Z+iYN1ds?=
 =?us-ascii?Q?xjx97yL9U13yrNTt67XBbb544dEVszJPCeTvi/FVrEpQShuvTQ0eOrw8bP88?=
 =?us-ascii?Q?l3l9JTKT8CQCFCFF3A5FGd/NgXeAaQ9BlVfw3+cVjLHigL+FHlM74jqZ5v0A?=
 =?us-ascii?Q?1GIRtiFPI24KfRJAJ1GsBojgi1SiEUcrzZAxkGgL9rGRdwYk9/mgBcJqWaeS?=
 =?us-ascii?Q?0m4R2QFlixxUqMO83rLCcvG2OHR0gyL/JQswC6vuMyHvY+j7xOIzKXUmmsM9?=
 =?us-ascii?Q?Id5zTKy7k9zEJpZ+ad401unk6efozA5xDvx3OUcRxdOBL3O8zS+rHKRfK1s7?=
 =?us-ascii?Q?HfbYeH3AiyLaaGf74ysAKEu62ZpG0Nf9lUymgi++LvzbLGnSMxduH5cQDLS4?=
 =?us-ascii?Q?rmWrEmdMN/QEJqhaMfNvPW6a6ssSPLM7IpESIyun/Xpb8ndjFhenxS77xdys?=
 =?us-ascii?Q?94FKrz5SYD61HfCseBi5D3whnsu8sSbPt/qWOBrD95IXxa3g7SM5ylSVcBkp?=
 =?us-ascii?Q?0fN6K+dx7hxQTFEdPJLbLQ26l73ZDxMa2u9SPs3lW69gHSIZY5TPNlFBXCrP?=
 =?us-ascii?Q?GagsUGX3PEVj/bYKguB5ZdPGxiZESxx3LwMJ4bJNqm0UoFZILwZMf5xerxJ9?=
 =?us-ascii?Q?Ae69EP8VmyA4Uas15Z7WRec+6Ak+sWZ8PDGjT39jbEcs5oXO9aheJJvYOyPa?=
 =?us-ascii?Q?Afd7dP84A6lMD6vwYVwXUvvhBxwPjglVvWtgZkeb1F8XOx/4MWylEFpmpAYX?=
 =?us-ascii?Q?f6KNgJZNB3IeASya//X0S4FUL20pHTHxJGpGNMyAPPfZs4ze5Ho2CfPCGzIh?=
 =?us-ascii?Q?HQHCaEchi7BgAAX9mi8Cun1ZLbamiizTrn/tXSN5v/QGBVQTNzS/WLSKDl1O?=
 =?us-ascii?Q?t+a4WXKG6CzNiB1i8oPk2jfeUj9A?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13941fb0-25ce-4894-10de-08d945802850
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 21:58:18.3405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aDrD5ageceu1uNvj4vuQTDv8d2C6api+Y+TgN8iF6hkGJsF2aKUhADlbrdCKrGwLg8RIt6sQDyiO/3lAluv180RCPXpVTTfK6MtQoTUJELM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2003
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
In V2:
- Addressed comment from Wei Liu

In V3:
- Addressed feedback from Michael Kelley about incorrect comments.
---
 drivers/pci/controller/pci-hyperv.c | 67 ++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index bebe3eeebc4e..8d77dfbb39f8 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -64,6 +64,7 @@ enum pci_protocol_version_t {
 	PCI_PROTOCOL_VERSION_1_1 =3D PCI_MAKE_VERSION(1, 1),	/* Win10 */
 	PCI_PROTOCOL_VERSION_1_2 =3D PCI_MAKE_VERSION(1, 2),	/* RS1 */
 	PCI_PROTOCOL_VERSION_1_3 =3D PCI_MAKE_VERSION(1, 3),	/* Vibranium */
+	PCI_PROTOCOL_VERSION_1_4 =3D PCI_MAKE_VERSION(1, 4),	/* WS2022 */
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
+ *	Everything is the same as in 'hv_msi_desc2' except that the size of the
+ *	'vector' field is larger to support bigger vector values. For ex: LPI
+ *	vectors on ARM.
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
@@ -1334,6 +1359,15 @@ static u32 hv_compose_msi_req_v1(
 	return sizeof(*int_pkt);
 }
=20
+/*
+ * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
+ * by subsequent retarget in hv_irq_unmask().
+ */
+static int hv_compose_msi_req_get_cpu(struct cpumask *affinity)
+{
+	return cpumask_first_and(affinity, cpu_online_mask);
+}
+
 static u32 hv_compose_msi_req_v2(
 	struct pci_create_interrupt2 *int_pkt, struct cpumask *affinity,
 	u32 slot, u8 vector)
@@ -1345,12 +1379,27 @@ static u32 hv_compose_msi_req_v2(
 	int_pkt->int_desc.vector =3D vector;
 	int_pkt->int_desc.vector_count =3D 1;
 	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
+	cpu =3D hv_compose_msi_req_get_cpu(affinity);
+	int_pkt->int_desc.processor_array[0] =3D
+		hv_cpu_number_to_vp_number(cpu);
+	int_pkt->int_desc.processor_count =3D 1;
=20
-	/*
-	 * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
-	 * by subsequent retarget in hv_irq_unmask().
-	 */
-	cpu =3D cpumask_first_and(affinity, cpu_online_mask);
+	return sizeof(*int_pkt);
+}
+
+static u32 hv_compose_msi_req_v3(
+	struct pci_create_interrupt3 *int_pkt, struct cpumask *affinity,
+	u32 slot, u32 vector)
+{
+	int cpu;
+
+	int_pkt->message_type.type =3D PCI_CREATE_INTERRUPT_MESSAGE3;
+	int_pkt->wslot.slot =3D slot;
+	int_pkt->int_desc.vector =3D vector;
+	int_pkt->int_desc.reserved =3D 0;
+	int_pkt->int_desc.vector_count =3D 1;
+	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
+	cpu =3D hv_compose_msi_req_get_cpu(affinity);
 	int_pkt->int_desc.processor_array[0] =3D
 		hv_cpu_number_to_vp_number(cpu);
 	int_pkt->int_desc.processor_count =3D 1;
@@ -1385,6 +1434,7 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
 		union {
 			struct pci_create_interrupt v1;
 			struct pci_create_interrupt2 v2;
+			struct pci_create_interrupt3 v3;
 		} int_pkts;
 	} __packed ctxt;
=20
@@ -1432,6 +1482,13 @@ static void hv_compose_msi_msg(struct irq_data *data=
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
