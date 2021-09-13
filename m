Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02063409ABC
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Sep 2021 19:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243313AbhIMRiH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Sep 2021 13:38:07 -0400
Received: from mail-oln040093003003.outbound.protection.outlook.com ([40.93.3.3]:4645
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238180AbhIMRiG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Sep 2021 13:38:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNV+Oh3NaHofBy+UEewZVdOElZuuqpiC0MN6/efrinyWAplEhWUdVnWj0m0cbZDIt+i5hzTsV4Pkc8EPJso906+TOjEHRGvq/3ZNUgHqvK5RpjZMAZgi89rvS4edowe6eodcp9I5zrxlmIukbLN6EWkJx15+MNUO34IoegCpgcKCGVtiCKdFYPdkH0ieFR/DT/zNDzW2bTBwo1O2duASqcoyNUoS5H3krZ755PPKTZ5gKsxuqt3FOBQRTi3yM5U9eM46v/jOt05L+tCdfRH1HQ4Zbq3iF3+DwkfyNKJHB3QTxPr3NyOHKUIrUCK6ghc/Sq/vRrYn+srI5tdk9YSpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Bqjwzcjy2bIUQyMyzt8ZOHCz2SAMCWTBOou43sef7Dk=;
 b=TmWw71itBeh5b9vj/blHFUHClTuIXQQiZyIPM1RLT6ThIcCf1l9T5ERXlgc9gduW5G6AzH/FXbYeE0jhrW6/+d+iApPO40fA9/yj7AJ8UeDicC4KSUeG2vYR1OZA2gSbjVV0DBiRnSvWlXuMffymF8QC5VdD79sepgYLLNAfJHkQwdNnoL+NlgDdcUMZ27NalbL1Uk4Hew/fCMWFRE71KgQFGlgSH/8jwEsQpisPj/FcR756WszFFfQ3DUdQAtw4Nrk0rrTC5cvds6tigOGXxTYOD8Q5ft1phQDKHbIulzoC25qPuuGBocnOF7bxf14l9e7nU6EQhVCK4rMUgvSDsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bqjwzcjy2bIUQyMyzt8ZOHCz2SAMCWTBOou43sef7Dk=;
 b=A7HWhlNm0RseSDl8U+4COySHk7M+MGZHbn/I2Vj9taGAvQdptB5+x4HvURRoVG3HFajzkDvj3xCelKm2him5oj53RzHjWVGQMzDrNOcKdevNfsjTpe3S63rxs3sP/4camb9WreWmpxRia6i/OSLzY+xwyzWlyh//BaP7IYdi3X0=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MWHPR21MB0830.namprd21.prod.outlook.com (2603:10b6:300:76::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8; Mon, 13 Sep
 2021 17:36:47 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::b134:7809:fcff:8c8b]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::b134:7809:fcff:8c8b%4]) with mapi id 15.20.4523.011; Mon, 13 Sep 2021
 17:36:47 +0000
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
Subject: [PATCH 1/2] PCI: hv: Make the code arch neutral
Thread-Topic: [PATCH 1/2] PCI: hv: Make the code arch neutral
Thread-Index: AdeoxSGQR+XTDCnuQJejgIDf8UzhEg==
Date:   Mon, 13 Sep 2021 17:36:46 +0000
Message-ID: <MW4PR21MB2002AE9B673A54D748BD1F2DC0D99@MW4PR21MB2002.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4fa2991-034c-423e-c0f3-08d976dd0ffc
x-ms-traffictypediagnostic: MWHPR21MB0830:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB08304B7A1DC9A0968022379FC0D99@MWHPR21MB0830.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DqBRif7FAoruaxdJ53Ii0Sg3FkxAjvlAZ319AKd9AHJ7EaZR7GLLtvjKumXP1aDBfEW+AeaLxkIydzdKM30P+5N4cgmZnfld3L8Yd8xclifxwP+ptzJXICDVDPr17ThIKNCX2+DKniPl/FEZWjw6wuvJtZ1WvTyh5tEq4kxsvuYwH7EYdVPu5nJRKPJ+xQZ6qpN5J2XIIs9vbs5URwrEsj7Y6e3IWA4SekQOveCw3qt2Ne3tJm01AlMpWRnczWn3isS4nWinZ4dLVXSI4ZpnkxPEnE0fWN5kCNPGE+j/sFUkY0MMUyt9DsIXmZQEmKrrLzqzK9lh/2kxOOXQMPzQ6lQ51joE2b+o3yVXYTqylahTcio4T3bHxf5KwmBbbvAqe24ogeJgtZySQfdG0vZap0fAQKvGIm37amjTHvxq7u7gm5Kx8mBX7JN3hTA3w+gOblU5LYLa9B/9vOwOXCiVutp6V0uKGDwaFUwCpIHKs0DX9HJUHo5IkqnwVCXTi6jWmcZvDC4vMtB7r8sbdAjDuMK/O5APAjEmQNljh5lgfVWeZ6gOLugUYvwEkxR5BsGRAKPH16Tl7exW5w9yp6HZkZkTujoXznA9BshXrQY9Trde46Pq88iF+Di0YI687DES5owKug/L0Hb2s0uMSWMaPfKqas0I1k6bTK97v/ie5uTYP0rFMWqI/scVc+q2amrWpFV9lV8NdvP6D3lqWKXMztJrTQ1w+lmwOCUEczDDojk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(9686003)(508600001)(76116006)(55016002)(52536014)(83380400001)(7696005)(38070700005)(71200400001)(33656002)(66446008)(64756008)(82950400001)(66556008)(66476007)(82960400001)(66946007)(86362001)(38100700002)(186003)(122000001)(921005)(8676002)(8936002)(8990500004)(2906002)(4326008)(316002)(54906003)(110136005)(10290500003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?8HKPSXME+4XyV06IYX5esN9sFEQ41PUqZk6Yv+1mWhIrjgf2MLx7o9CJxP?=
 =?iso-8859-2?Q?v4drbCMEbgk6UUVIXJqU7DhmWCIUMKkQsk3CLObT8hVsme1VL/ZoSa3GeP?=
 =?iso-8859-2?Q?pwbwJtkbeCZG1fDTldKibFg4A9F9DbqSv8OmhG9s9zaWcOMrkxSsG1kdoa?=
 =?iso-8859-2?Q?vyI6vy7LNg+sSblNsOkxOqlt8ye2tlbEMjwO9fSvrdmjdo0v5nNIkX89a5?=
 =?iso-8859-2?Q?ASD2EIgJVHfzK5NjO3LjGbIiMjrOuIwg2Bhv0dvD3dhG3YhIJmx3oFyOMd?=
 =?iso-8859-2?Q?YwZvz4wNFjUVmlD3XvgxFdmwS3HoaPfQMXtr5hMC/ClxmQDh5hzFisppGC?=
 =?iso-8859-2?Q?fRJNyObrZ6rjXQ6cLpiZP86mxeWPgDVqiK+pq0Ftors1T1YSQ6Ga6wZmK8?=
 =?iso-8859-2?Q?uurRw9YC+2jip2PifEFTy+lODwNIL0sAEPGpAul3P65P8J965JRKAaYNyY?=
 =?iso-8859-2?Q?iBRkXWSE92/r5ottYpBb5CFmXLkeUKKbhUEKwvyHFlLIeVL20FI3EoOaF3?=
 =?iso-8859-2?Q?wqDU4hex5tQWkk0we9xQBrhtcypYfM0bRGBi2EmzVLTsyu1Kt22LolFjsB?=
 =?iso-8859-2?Q?lKBd7FjuhyWDNcJ0Cp2woBrIY2SJTjckP5ojf4oOeBr/m+6McmOWkmeNwi?=
 =?iso-8859-2?Q?6doMXYPWoRAc2gCNPm6X2ZEroJwb7FwQx0yl3kGIM3H9nwasuQFuMm10tj?=
 =?iso-8859-2?Q?0Rr2D8G3l7dJAkWdgUj0DfdUot9Z6Z40bA/bQ0tulp58+cbZurDs/g8M6l?=
 =?iso-8859-2?Q?n5nC+hKBCjYMQl9Zx3v3d5DtN1dmaJcvgot0u+nNqSwBqliRSOEoNbMlRZ?=
 =?iso-8859-2?Q?pHTZ1Tc97Vzx37q+58jfiNsxcP+LcWYZrRAw0I43se/CRVeK+TD5zqJFBA?=
 =?iso-8859-2?Q?gTZVI4F8WgBfrZZ+qKKoyn30zBBCMXy9uF6AIw4OvgX7xOugcmiQMQFdqP?=
 =?iso-8859-2?Q?TqZa28KsemUWWa2aE04D6elU8aMAfgKQO4vACkMT8TAc8b7fo/6ZVurMuW?=
 =?iso-8859-2?Q?i4cy166LEGdl6Z8EkNHFKtb/fNCZvLtgjYDH3nZu/SxWtJgNrfd/ejr6qC?=
 =?iso-8859-2?Q?64FEMke+skkMZMjePhgvASOI0rQRnJX0qz6SJT7N7O25RCG4Srk2fpWRhX?=
 =?iso-8859-2?Q?kfgq6weQxYqLlx+wK+asjOXYYlm1BhHt6WUPpkoYzEJDG5XdzebeVmkKZp?=
 =?iso-8859-2?Q?WZJQg4f4WMByqq8AQw6AvApGFZmc09MSBLnZZ/IOO3EDNzKPFx2D/nlmCt?=
 =?iso-8859-2?Q?h00OckmtrbdOebWR2iPtvnl9sBZ2BjfxkNBXCGtM0kMlgzVcBVTe13MYjs?=
 =?iso-8859-2?Q?UD7BiTN6gJfZ/zdZRAU0F0EfWf81w8SKFHt930zqsR4WlhsaCf1zh8lFM1?=
 =?iso-8859-2?Q?AOx/py7YLkPKYrwIMeVDKjVMAdY439oRQNCfkr+IS2qjVo9E9L1gKFgCtG?=
 =?iso-8859-2?Q?fWuARoHG+tO0gvFC?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4fa2991-034c-423e-c0f3-08d976dd0ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 17:36:46.9225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dmWAksxVL+vkvdyDzSckacIUhdD//L39cZCzC2HHa39IX5iit+X/PypnJM7hH1WR5SrFBRZzwXq1AqL/c6xW5H4eRGvIhzf9LMPYDtcxa2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0830
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch makes the Hyper-V vPCI code architectural neutral by
moving the architectural dependent pieces into arch specific
code. This allows for the implementation of Hyper-V vPCI for
other architecture such as ARM64.

There are no functional changes expected from this patch.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 arch/x86/include/asm/hyperv-tlfs.h  | 33 ++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h     | 25 ++++++++++++++++
 drivers/pci/controller/pci-hyperv.c | 44 +++++++++++++++++++----------
 include/asm-generic/hyperv-tlfs.h   | 33 ----------------------
 4 files changed, 87 insertions(+), 48 deletions(-)

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
index adccbc209169..9c53dfef360c 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -10,6 +10,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
 #include <asm/mshyperv.h>
+#include <asm/msi.h>
=20
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
@@ -168,6 +169,30 @@ int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
 		u64 start_gfn, u64 end_gfn);
=20
+#define hv_msi_handler			handle_edge_irq
+#define hv_msi_handler_name		"edge"
+#define hv_msi_prepare			pci_msi_prepare
+#define hv_msi_irq_delivery_mode	APIC_DELIVERY_MODE_FIXED
+
+static inline struct irq_domain *hv_msi_parent_vector_domain(void)
+{
+	return x86_vector_domain;
+}
+
+static inline unsigned int hv_msi_get_int_vector(struct irq_data *data)
+{
+	struct irq_cfg *cfg =3D irqd_cfg(data);
+
+	return cfg->vector;
+}
+
+static inline int hv_pci_arch_init(void)
+{
+	return 0;
+}
+
+static inline void hv_pci_arch_free(void) {}
+
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
 void __init hv_init_spinlocks(void);
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 62dbe98d1fe1..b7213b57b4ec 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -44,8 +44,8 @@
 #include <linux/delay.h>
 #include <linux/semaphore.h>
 #include <linux/irqdomain.h>
-#include <asm/irqdomain.h>
-#include <asm/apic.h>
+//#include <asm/irqdomain.h>
+//#include <asm/apic.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/hyperv.h>
@@ -1192,7 +1192,6 @@ static void hv_irq_mask(struct irq_data *data)
 static void hv_irq_unmask(struct irq_data *data)
 {
 	struct msi_desc *msi_desc =3D irq_data_get_msi_desc(data);
-	struct irq_cfg *cfg =3D irqd_cfg(data);
 	struct hv_retarget_device_interrupt *params;
 	struct hv_pcibus_device *hbus;
 	struct cpumask *dest;
@@ -1221,11 +1220,12 @@ static void hv_irq_unmask(struct irq_data *data)
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
@@ -1322,7 +1322,7 @@ static u32 hv_compose_msi_req_v1(
 	int_pkt->wslot.slot =3D slot;
 	int_pkt->int_desc.vector =3D vector;
 	int_pkt->int_desc.vector_count =3D 1;
-	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
+	int_pkt->int_desc.delivery_mode =3D hv_msi_irq_delivery_mode;
=20
 	/*
 	 * Create MSI w/ dummy vCPU set, overwritten by subsequent retarget in
@@ -1343,7 +1343,7 @@ static u32 hv_compose_msi_req_v2(
 	int_pkt->wslot.slot =3D slot;
 	int_pkt->int_desc.vector =3D vector;
 	int_pkt->int_desc.vector_count =3D 1;
-	int_pkt->int_desc.delivery_mode =3D APIC_DELIVERY_MODE_FIXED;
+	int_pkt->int_desc.delivery_mode =3D hv_msi_irq_delivery_mode;
=20
 	/*
 	 * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
@@ -1370,7 +1370,6 @@ static u32 hv_compose_msi_req_v2(
  */
 static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct irq_cfg *cfg =3D irqd_cfg(data);
 	struct hv_pcibus_device *hbus;
 	struct vmbus_channel *channel;
 	struct hv_pci_dev *hpdev;
@@ -1420,7 +1419,7 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
 		size =3D hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
 					dest,
 					hpdev->desc.win_slot.slot,
-					cfg->vector);
+					hv_msi_get_int_vector(data));
 		break;
=20
 	case PCI_PROTOCOL_VERSION_1_2:
@@ -1428,7 +1427,7 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
 		size =3D hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
 					dest,
 					hpdev->desc.win_slot.slot,
-					cfg->vector);
+					hv_msi_get_int_vector(data));
 		break;
=20
 	default:
@@ -1544,7 +1543,7 @@ static struct irq_chip hv_msi_irq_chip =3D {
 };
=20
 static struct msi_domain_ops hv_msi_ops =3D {
-	.msi_prepare	=3D pci_msi_prepare,
+	.msi_prepare	=3D hv_msi_prepare,
 	.msi_free	=3D hv_msi_free,
 };
=20
@@ -1563,17 +1562,26 @@ static struct msi_domain_ops hv_msi_ops =3D {
  */
 static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
 {
+	struct irq_domain *parent_domain;
+
+	parent_domain =3D hv_msi_parent_vector_domain();
+	if (!parent_domain) {
+		dev_err(&hbus->hdev->device,
+		    "Failed to get parent MSI domain\n");
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
 	hbus->irq_domain =3D pci_msi_create_irq_domain(hbus->fwnode,
 						     &hbus->msi_info,
-						     x86_vector_domain);
+						     parent_domain);
 	if (!hbus->irq_domain) {
 		dev_err(&hbus->hdev->device,
 			"Failed to build an MSI IRQ domain\n");
@@ -3478,9 +3486,15 @@ static void __exit exit_hv_pci_drv(void)
=20
 static int __init init_hv_pci_drv(void)
 {
+	int ret;
+
 	if (!hv_is_hyperv_initialized())
 		return -ENODEV;
=20
+	ret =3D hv_pci_arch_init();
+	if (ret)
+		return ret;
+
 	/* Set the invalid domain number's bit, so it will not be used */
 	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
=20
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

