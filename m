Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DC13C634A
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jul 2021 21:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbhGLTMm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Jul 2021 15:12:42 -0400
Received: from mail-bn7nam10on2107.outbound.protection.outlook.com ([40.107.92.107]:54880
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236086AbhGLTMm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Jul 2021 15:12:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMPL5Hce2CWUUXu4MiaX8uEuc9v/U05N8ijmBh6k0QFkAQAMCHhEAG5a8ZqnH1eB1R2AH1okJs1hZImJqRXsvD8DzBJbCPfdS/syZIkrvVNNdE5zLBSE4R8u7LujMhMDkHeFGonFRe88OY5+rDIaOgv49DQz1TMZSYnm4H3eF2nbfrqP2NMlh5DkMMRr13iBz2bzE9qf5R5YgJuBV4gWKpeP1WF5QHUCbNnwlhdR/E2gK4qQkKodyWcqkzmqc3ny+GW7GMm1ftrdNb/h3gfRf388CxpfNJLknRdgx/DWv/XxRGbfkupHH1JRIo0plwkGefsrsXAIQILS8p74mdC0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eJluQU2FjG7D4aiCtAae7F4EFYKhwPyrn/jlrFw2+U=;
 b=ZE9vGO0m1USczJhywTHMDFcmMUfRDgq4qvT1G0zAsukECvs7Qy0mO+CAf60flrq3Y5gi085jGmQ+bBiSU/qC97hExsgQzGr3NjN/3k/3p8zDd41UXaA/PNvUAswuRweY2ta8GRrHxst+rzFzQgB+S8OTMZbcphHrwM6vbgbzcbdGvsr1jWVxfqstVgPNrLwa6kqAuqyONcFgJD7s34zBssI/q5g4IAs1o/DgM7h1F/jY1AYyP0Vl7tOCiawAXSGyyy+91UWHEOx7ggi2B3AvKSRp+Oheg8jN56Tu9UC+JWqXShaIx/8cjOy832svd23qehBRE50cmFv5cfpvyJ/f5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eJluQU2FjG7D4aiCtAae7F4EFYKhwPyrn/jlrFw2+U=;
 b=Yuf3Vf2/xAcLhKQZdI/CzauQd4b/91L8uJGNhZpYUuoy131hl2MuwPpteeIWHTliF9qhLbYjZqE2JBeat4Q5EtlIg8gxG+CmuuSSDU5MiXyseNo9RJERIpmcMemrNTa6oIxPpiE42Ke9zZWUuH0iG53J1PsORQ1i7gO+atrcwPU=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MWHPR21MB0190.namprd21.prod.outlook.com (2603:10b6:300:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.2; Mon, 12 Jul
 2021 19:09:50 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::6082:4114:68ee:f569]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::6082:4114:68ee:f569%5]) with mapi id 15.20.4352.007; Mon, 12 Jul 2021
 19:09:50 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/1] PCI: hv: Support for create interrupt v3
Thread-Topic: [PATCH v2 1/1] PCI: hv: Support for create interrupt v3
Thread-Index: Add3UREaVumtinnJQyibcOLYfYv1uA==
Date:   Mon, 12 Jul 2021 19:09:50 +0000
Message-ID: <MW4PR21MB20026EFF5A1F6EB4F8FDC0DDC0159@MW4PR21MB2002.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b646a78a-72b8-45b4-c78f-08d945689f9f
x-ms-traffictypediagnostic: MWHPR21MB0190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0190B05DBF60EB0383376C92C0159@MWHPR21MB0190.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HnewDxR1ukImnkb/YFQLzmCFFMF/7+e0+/lSciPwRXxOexZn0BwrjAr98Z+FOKKpWXGmotz0y+9bNia/kUba2sQcnaollBXkQs1mzjOMv5N5pkeIZxvpXqYUYmQnSUAaR+7ZMa9o+ymSdPol3y0zgAGgKcfBm9LK0JmUu54UraGy/CM7Q00dBOAEABLWtBYTVRJPLaZ5ZcjiTbusz2TR7WaebbvBZXaiR4sCsVwgoIXOcmdp5Jl62ffFHlqlDnLT76YeO955t4euLkSo40RxZ5msdJ7Pqy7IPwlofUhWr9HAgyICI9QgxKD/ssQUpWxAa4l97cIjqCTPg7juJtn35i3El1pOsU8EGKd3lsufCJa8AVigLA4tyu7UY5r/3+DcGeSuRS1zdTPXLuUtd5dPAcHXAIrbJrfzEVQHF2JRNrU7ZmzsuCEVxMPNqRxGqVn2H73XoI6ajzWRSOMRjBYkP28YMMbeq4G2R9+/jTaw3q3dSEXx7wWqT6ocM185M8Y40VNu9LjsIMoiOhqvuk9CShaA7cEGf52zywj6vcRat/ZspsTdCtKdw1G6tVI4Hq5vo/mO33B/iVN45tzFjmt99ynjcpkgOryjm4ELlU0KzR269PEImX9laWmhMaX2RCFu8ywhB3GSdMp3OOmGAB5fkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(2906002)(4326008)(66476007)(83380400001)(82950400001)(10290500003)(122000001)(478600001)(82960400001)(9686003)(6506007)(76116006)(71200400001)(5660300002)(54906003)(64756008)(8936002)(66946007)(66556008)(55016002)(7696005)(52536014)(8990500004)(8676002)(316002)(186003)(110136005)(86362001)(33656002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aoaWyKLVzGAUOsw/avxYd611xST0QWyeRdLnlFA7iwB46ITAg+8Coxjw/aq6?=
 =?us-ascii?Q?M8+ofsNv9FX1+GaHUi1J59uOXElaZCuYfGWhNYZHI1fI1V9kl8LzLKPtedeZ?=
 =?us-ascii?Q?5gXv1okp1xm3lj8NEeGzPbQXD2K5djRoiYes1FYwuANme9vKiGFOMZj5WQwu?=
 =?us-ascii?Q?3/+M/vmKzM3gTIcZx3nGdK/PVhcyil/i7o/QGRW9vsrDQuN4aRVqkBryCev5?=
 =?us-ascii?Q?KUDdoLrMhrEyJGdPm1pDoRsRqrCU/KHgyUmjA7icwFXg/01ax1KdILxvssm0?=
 =?us-ascii?Q?MFOotIkZTewZUYwGvRjnSFxMta8IkodBRjPJv2XzodCP4K0gedUjaLlpNRcC?=
 =?us-ascii?Q?+evLH49vHcwaTbd1PALEc5HykNnmuaH/zES//GuLvEcquytMo5fhT1bNGTwd?=
 =?us-ascii?Q?t2nnrXJTwdsUSJz/+vd4pbwfRivIFbsntIneUyfZhrzx8ZHEKuHHmcLbraa5?=
 =?us-ascii?Q?ZZdWtPSMod/W8k6+I3/q2SMUFj4DPL3SfDjXy3SlRRcQb/xcnDhMq2FJhwy/?=
 =?us-ascii?Q?Rx6nfwmbYPgbVyRQ1txOu+e4xe7wbu0HalW+3K+Q7lkKSEupebYYqTSM6IgH?=
 =?us-ascii?Q?d/83zQaEbKOFP0D4WpCpXEsaYpLX41wVVqddclnQ5YiIYknCP/OOzeUMmJE4?=
 =?us-ascii?Q?oQLEMwMvztlrkMdjlmXtkwscHHbF01Byhlq4IqXaTn66D1H1A45QlDxFho3T?=
 =?us-ascii?Q?VHlobyqeLRlChsd+rS29BhGipxlRZFs2/fKS/TWm4qqfErhMU8jwI7IR7Odo?=
 =?us-ascii?Q?OhtxXedrhPkCtdsRS41FQTV6OZsmGIP5PGWgu/h2amP1HQcFqpgeQokC/sPF?=
 =?us-ascii?Q?22otOtlpjQI2ABaJaYfFtFnKmRUmCvz2k2PohYeyzlvPHKJAwFlWbh+viHZ+?=
 =?us-ascii?Q?9dcIQdcslOa+2LTy/qzZ8PZHHkBqUUQKYyMFIG2MCThXn2xXnir9uCTjQcps?=
 =?us-ascii?Q?EmIaW0G0fAYCcB+4EeZ20xkYR/WjQwfJccnzxXq6oqyCR8mT3KRtHrckodPk?=
 =?us-ascii?Q?TJ/KaL15MMX0O5ZbTB1OkCFN8y6vrU5hCNtceES3+VVZVZL0O6emCsIVsAy7?=
 =?us-ascii?Q?ES9etxathePuPuHVlFfpEm9XymUD7Yktzn2K3Tc9IJBCZrdLxuvJLyTvmiCW?=
 =?us-ascii?Q?oWAMi7EIeCvTnNoM2tqz1QXyZJtlAdqsyGJXGiFCefLMQgi45pDMrha8vBjd?=
 =?us-ascii?Q?YCa+JlVOqaLcsQyds9ggZ7qevP0YDX9w6ipOSNH2IqsCE+pq/5qydyxaTZSq?=
 =?us-ascii?Q?7Sddr4P9P7QoEXqR7SQkyeXX5imcxlVml/qIx/dP4MU8qlGSCx9E83jHOuAa?=
 =?us-ascii?Q?S5N2sEFLMfsoRBlpPZf9Ta+Z6wqc/NOpeDGVq8J2eWf/5dJi2rI46+rGfbO/?=
 =?us-ascii?Q?NsIgth4gIciMOrovudz2qmyJpvYs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b646a78a-72b8-45b4-c78f-08d945689f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 19:09:50.4648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34Y/dS8Rtz8VmqeQyK8zqqU4veiuOcNi5eXbOqQAetob4CEiahlWEKO8YkFdw/dNja7+oRbjmGR7SslYlpPx+3skNinPE0pcXN6+gIzGg0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0190
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
---
 drivers/pci/controller/pci-hyperv.c | 67 ++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index bebe3eeebc4e..9d2f29de1f70 100644
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

