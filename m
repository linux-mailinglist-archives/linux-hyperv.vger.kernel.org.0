Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5B825E520
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Sep 2020 04:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgIECz1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Sep 2020 22:55:27 -0400
Received: from mail-bn8nam12on2121.outbound.protection.outlook.com ([40.107.237.121]:37216
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgIECz0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Sep 2020 22:55:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtBb3y2Xhc78l37wP8rlyGxZ2eMoxRYYe6TWbkdtNCUqORloFcA9py0SrVPArZViJBgm2Ix8uJ7VYHM7c02X9om8FeyX8HnsdN0E0p0iNl0aOs6PYzU78OWfo7wgkQNAJtGjgNSE279WqvkOoSArO7XUaRBZjW0v+4CVVYC6n3aXZHNkXq6S/0K4T8SWtGFKWwIIcGEYL6XxYeK3cP3G62TS4tlJ+yyrcEbAlWOOvT6Ozhaxufh02X3+tIqexdNrnC/9jPZw1YHcgDOerIHfXOAMrDDWU41nlsWUHYqCp3QMx4F8P+UFPXTolpolIEYNgPfOFd5IxOKRyFvbUUNAYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5C+XEFPcWknUqMq7fZjjeCFpX0cxU6AsYfoOb2HPiws=;
 b=FDVJwqcHJjXqwE1qsyFc64TpLuGLT8eUBrfsBYyKxmLj51kHqBM8cUQ36Z0iMrZMpjs34mtm9ZSysO8gLQT5/LEtAq42gbxwq4066G81YiITxQb/9g3yGk+U/w1o1VsDowhCIvKis76tbcrshZwnO84t40XY3BKaTLhVaY2t5WtY+aT+lodP51YoVTCdY+Y5+10syBVKlkWU4cioje5O7MMND2XAwJgXmg3LI4AmqsxwNelO4Py14eBjPHgmQxvwSPZxFeB5wuKhDO+Cq9iC1lidXVOuQrTYGlb4Qy+RAlx8NICpvwQaTbanLtzGT/Ifplvu9e95iG44/bZlLXWU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5C+XEFPcWknUqMq7fZjjeCFpX0cxU6AsYfoOb2HPiws=;
 b=fpE3VFybu2+NT3YSWQd1D0enWFVpdfQOXbxNKNqEhaz2aKpajTi3k0GGFbUh6/LBxQ/tfWgFTXZ6vHai9/s4aMes7Frss2g3raxt1hwwgym5xWXwu+JCWSPaiCEDIx/WRgX5c3EUfmIdh85ezJWcA0Su5WzUdgckw/Vo4YJtZG8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from BN6PR21MB0162.namprd21.prod.outlook.com (2603:10b6:404:94::8)
 by BN8PR21MB1155.namprd21.prod.outlook.com (2603:10b6:408:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.1; Sat, 5 Sep
 2020 02:55:22 +0000
Received: from BN6PR21MB0162.namprd21.prod.outlook.com
 ([fe80::85e9:34fc:95a2:1260]) by BN6PR21MB0162.namprd21.prod.outlook.com
 ([fe80::85e9:34fc:95a2:1260%14]) with mapi id 15.20.3370.014; Sat, 5 Sep 2020
 02:55:22 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>, Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH] PCI: hv: Fix hibernation in case interrupts are not re-created
Date:   Fri,  4 Sep 2020 19:54:50 -0700
Message-Id: <20200905025450.45528-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-Originating-IP: [2001:4898:80e8:0:d8e7:275a:eb59:9dcf]
X-ClientProxiedBy: MWHPR1401CA0001.namprd14.prod.outlook.com
 (2603:10b6:301:4b::11) To BN6PR21MB0162.namprd21.prod.outlook.com
 (2603:10b6:404:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:0:d8e7:275a:eb59:9dcf) by MWHPR1401CA0001.namprd14.prod.outlook.com (2603:10b6:301:4b::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Sat, 5 Sep 2020 02:55:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7920f781-fab6-4200-21b7-08d8514721c4
X-MS-TrafficTypeDiagnostic: BN8PR21MB1155:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR21MB11550838FA87DF820BFBDDB3BF2A0@BN8PR21MB1155.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXxW2DR3/sRoHg6h8E34L1RFL/pvzpRpt/8I09v7GrOO8mXcSAlz4DtSbYtlg1XgwXipVscq8PIvLCGYXSqfTMu083JRYksyZ1afP8d1AIS6TtG04VDc6UCoU0n/MyneAgsuXGgRCWa1MAoDVgrvk2qjdH1rdf5O8ryIvEVBnGR7LmuLwNGI/0vjrwHsXeS7B9/y0Zt6X7McSARHIu7CrmI2BW6f3sSHL6Kka8ZFxVsiSImp1mVdxcq1UwTmk5WlBrIaDvjjC4TxGPrpvzNojNUChFpDYCAeAUAJegITdv2kwK7uNQ7XgsPb1/rFyRmwVI6785CbGdLSwgC7B0oONoaTrujarP6mgynvw477t2YO8o0gRxfQasHPlbm7ccS5K2dv4hFTvqHwjE2Qyurw/GES1Y8iFO7575WwzbPAqj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0162.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(2616005)(82950400001)(82960400001)(186003)(52116002)(316002)(83380400001)(8676002)(54906003)(36756003)(8936002)(3450700001)(107886003)(478600001)(6486002)(66476007)(7696005)(16526019)(10290500003)(2906002)(6666004)(1076003)(86362001)(66556008)(6636002)(66946007)(5660300002)(4326008)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: FduD1BcwQLLWDd5pvplUhT5h8suw93h9GTIsAwd5Zuq/Fiv//W+v4CvhahDiji/AlEN0CvrbrqJ14Kbb3AgBnh3t4UaIbt9tICIKRPR5QvoJHr/Ylx8+rkR3jeVc8aDzq8odeOxZH7U0ss1mc13TAEnANR0/7ewRk2aOJudGCHh/IUvwyiwcl+ju/8cUv5OQqAm/STPpweB6By+4ISZczlGSh7aSRrBRLVlgWSl3xaen0A7U35q0hI058SnHzH5wQcIayrn4FqdfBe4xee3xz7MbWYu3bnj23eL5dg8cccxFZv87xFkzX4ioKZE9Ti01n0U+RVw27/3x6MUG8YeO5rlAaKrqlgg9+CXuC5hvLVM7kU+NiyaslOkYE3YoBmAaTyrfQc+k6eGtXTNF5713anUtkgQouFe78Wj3OKP4vyc9lGFsw8wnxlQvNSC6ll5P5pU07P7rbn9VOMaclmkNiw6GPayowOA78owT40kYFo8uPTH28AswgV02WnT0GxNSwoiP2RVCHIKGCPvP5ffpndpyV/RxMYNp1pj0NREwsEX86FEIEi18dpmp8P8S85SZCYkHP9mluy1clASREG67ORRsI7a9pLlyztQjWQMj8N4EU/nGHpIVT/Alq3FKI0fQy7AdMc9MSdvk5O9ucDzAQft785v8SIzuRI+Pu4m5TWAlumnKEvXyxNp+toIWWAgUt1z7Qc8N8OxNzLpjwEWlbQ==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7920f781-fab6-4200-21b7-08d8514721c4
X-MS-Exchange-CrossTenant-AuthSource: BN6PR21MB0162.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2020 02:55:22.6383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxnvLSxg23GCIji/7Dy35ydYcxOrDxfNrK0mOIhD9aS8UZFVWUpD3MMDQZG9sKOA8pqS/L8rmmOciryAHl1VHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1155
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V doesn't trap and emulate the accesses to the MSI/MSI-X registers,
and we must use hv_compose_msi_msg() to ask Hyper-V to create the IOMMU
Interrupt Remapping Table Entries. This is not an issue for a lot of
PCI device drivers (e.g. NVMe driver, Mellanox NIC drivers), which
destroy and re-create the interrupts across hibernation, so
hv_compose_msi_msg() is called automatically. However, some other PCI
device drivers (e.g. the Nvidia driver) may not destroy and re-create
the interrupts across hibernation, so hv_pci_resume() has to call
hv_compose_msi_msg(), otherwise the PCI device drivers can no longer
receive MSI/MSI-X interrupts after hibernation.

Fixes: ac82fc832708 ("PCI: hv: Add hibernation support")
Cc: Jake Oshins <jakeo@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index fc4c3a15e570..abefff9a20e1 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1211,6 +1211,21 @@ static void hv_irq_unmask(struct irq_data *data)
 	pbus = pdev->bus;
 	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
 
+	if (hbus->state == hv_pcibus_removing) {
+		/*
+		 * During hibernatin, when a CPU is offlined, the kernel tries
+		 * to move the interrupt to the remaining CPUs that haven't
+		 * been offlined yet. In this case, the below hv_do_hypercall()
+		 * always fails since the vmbus channel has been closed, so we
+		 * should not call the hypercall, but we still need
+		 * pci_msi_unmask_irq() to reset the mask bit in desc->masked:
+		 * see cpu_disable_common() -> fixup_irqs() ->
+		 * irq_migrate_all_off_this_cpu() -> migrate_one_irq().
+		 */
+		pci_msi_unmask_irq(data);
+		return;
+	}
+
 	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
 
 	params = &hbus->retarget_msi_interrupt_params;
@@ -3372,6 +3387,33 @@ static int hv_pci_suspend(struct hv_device *hdev)
 	return 0;
 }
 
+static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
+{
+	struct msi_desc *entry;
+	struct irq_data *irq_data;
+
+	for_each_pci_msi_entry(entry, pdev) {
+		irq_data = irq_get_irq_data(entry->irq);
+		if (WARN_ON_ONCE(!irq_data))
+			return -EINVAL;
+
+		hv_compose_msi_msg(irq_data, &entry->msg);
+	}
+
+	return 0;
+}
+
+/*
+ * Upon resume, pci_restore_msi_state() -> ... ->  __pci_write_msi_msg()
+ * re-writes the MSI/MSI-X registers, but since Hyper-V doesn't trap and
+ * emulate the accesses, we have to call hv_compose_msi_msg() to ask
+ * Hyper-V to re-create the IOMMU Interrupt Remapping Table Entries.
+ */
+static void hv_pci_restore_msi_state(struct hv_pcibus_device *hbus)
+{
+	pci_walk_bus(hbus->pci_bus, hv_pci_restore_msi_msg, NULL);
+}
+
 static int hv_pci_resume(struct hv_device *hdev)
 {
 	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
@@ -3405,6 +3447,8 @@ static int hv_pci_resume(struct hv_device *hdev)
 
 	prepopulate_bars(hbus);
 
+	hv_pci_restore_msi_state(hbus);
+
 	hbus->state = hv_pcibus_installed;
 	return 0;
 out:
-- 
2.19.1

