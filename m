Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97248262383
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Sep 2020 01:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIHXTA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Sep 2020 19:19:00 -0400
Received: from mail-bn8nam12on2120.outbound.protection.outlook.com ([40.107.237.120]:64609
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726591AbgIHXS6 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Sep 2020 19:18:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHq3iVx/xOoG+StaJdlG9ujNxf+7C2CTqBfVV7ZTbquHNkCjjRNy2vjvoQssX7gRgCU8DJ3ZEbUv6loLPBu1e6refRJU1E//r7X2sQH+tk/luVdFvTSAG6+JvQX1RA3QcljY9sl/4SR4uXGwSIkdToq8bp/AeLKkjPbo2L48jZGJs5m3CU/4e5q0CalqBN9RusZJpJCInrl/Yf4Cfb2aS0/WbIflZCrmhlHNxyfAwtyjV4ArDu+NzkkKC64/zoKY5XEE4jxCiG16dmVW0E5TgYViXHBgBYMXp42DkWZrFnRcyTH2D0JMpLX18/Xe/BFbfhkV8aQ5YjXNPbkppY0QNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfkt/1d3ZMkmTUE7MRYfjnlNa2bqgvksbIr4tAdswdo=;
 b=dG0aZCfAbsWEiZAiVshrKvOc6egvcVGARmo58cFt90SzxEzbW9TQg2RoDibCOaCeB2fLrTfBxcmaMj/EDbsI4LK8HEw1DHG10E6tW+cAts0elp1R0eNk5LNoQjcoL6Kw3x+GNSnRorhO1pcrjItdGD+7UDE3rgyc0/nWMqaPTpSpDgXqWiUGGBNqXEG1bk/Jr64G4nF2sSSEMroi+vzhmHsTHQsDqCw+2HxdRL1z61MNX4jS8BtWNA6418UQREIs7+kLalbU2OFcm+pTWTq9737YPdibLj76dtCIFEddNBBmRZRpjKFlLMBHt7ojq9S/YAXGASUEaJKVeWvCJZBZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfkt/1d3ZMkmTUE7MRYfjnlNa2bqgvksbIr4tAdswdo=;
 b=BiqUxbogLxa0HrMmgX66y00JTMOivPnhjAwrWs59upaFKSTpJOlKthO6+OWLJ/CBdAP4sRxuhIqvMhB7fCh1Oy0DMLksbdfI00Fnl3hF5d25IHwa8FyCgQlNURQvXx/tmcI6DfgXMo1QE364tHWnTufWk3TRfWR4y1mdmCEbcww=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from BN6PR21MB0162.namprd21.prod.outlook.com (2603:10b6:404:94::8)
 by BN6PR21MB0132.namprd21.prod.outlook.com (2603:10b6:404:93::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.2; Tue, 8 Sep
 2020 23:18:55 +0000
Received: from BN6PR21MB0162.namprd21.prod.outlook.com
 ([fe80::c189:fa0c:eb39:9b39]) by BN6PR21MB0162.namprd21.prod.outlook.com
 ([fe80::c189:fa0c:eb39:9b39%7]) with mapi id 15.20.3391.004; Tue, 8 Sep 2020
 23:18:55 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com
Cc:     jakeo@microsoft.com, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2] PCI: hv: Fix hibernation in case interrupts are not re-created
Date:   Tue,  8 Sep 2020 16:17:59 -0700
Message-Id: <20200908231759.13336-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-Originating-IP: [2001:4898:80e8:a:5994:e9e1:e2d1:ad29]
X-ClientProxiedBy: CO2PR06CA0058.namprd06.prod.outlook.com
 (2603:10b6:104:3::16) To BN6PR21MB0162.namprd21.prod.outlook.com
 (2603:10b6:404:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:a:5994:e9e1:e2d1:ad29) by CO2PR06CA0058.namprd06.prod.outlook.com (2603:10b6:104:3::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Tue, 8 Sep 2020 23:18:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 16a89b69-06db-4af2-c067-08d8544d8e24
X-MS-TrafficTypeDiagnostic: BN6PR21MB0132:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR21MB01320595EC67CD431E9AAE5DBF290@BN6PR21MB0132.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfrC+tLE4dZi95p0AgBU+U8xTCvhCGczC6e+D4ouhq7JU2IDOtZUBepm3r/coP69wRSF4eWFVyjOCazl6GJ0nROCcMYQ0/risHivVVcZ2ARQS1VG/WfdHbLDe0tnlObT9pcn7xOZk2vwPJwJeK5wtYWG1wmB9FgM2S4UfG803CuCTtSHMt1hk+kpNhT2kquWv4drQq6cgUP1KquEunGYCgUzXQDihiX1JqHbnc64d7VQLU/R8pgstnlTzfcyOMEP3u679iFQ90dGCvtwJKLmn5S/oUnaWEZTmkvrAuAXo6XR9poifNW6BAsZTCDrQTzE44qGpaXeLlp81S/z6ykEHASANFdn1yDE+Q8G6JAscwaKyDWG8ed34TPIQc8oEmGgEDsn+9mctaeGkbQ1RPGd37w9Xj4M28ASFfoIjlmIs6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0162.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(2906002)(6636002)(4326008)(1076003)(8936002)(107886003)(66476007)(478600001)(5660300002)(66946007)(10290500003)(66556008)(36756003)(83380400001)(16526019)(316002)(8676002)(6486002)(3450700001)(2616005)(86362001)(186003)(82960400001)(82950400001)(52116002)(7696005)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: i5XRnPRxmVGvGiL0Hw0P+75tKd3ATmpLGixJkvihY1hlydUzfvKyRdULDCUDAT3n6corAwIIIXFRNN7mCN5fuVb2XB/Bk0ntiWx9seZuXi6qDN1BdlBAX9CFxACFYhhtftzU5kDQBbGlMKx7cHDW1VCq/XAfdmQIUhtPm/oMROnwSoNYeacLeIgVo4tkRxA2oW/eiBIB4XRA6bHtoIoK2ttBTYRwpidagQmKfh0xSkmOywDUVEoQbfaDP3AzTLODxRtpCgBgqLIJFBBXbf4hWaX5M4UnPzvr2KXInAwjT23lSxoVycY4McOyDz6RhHhWUHsk7Jx6uMsg39cxP9x2AB29khjY/RV5wTK3oko0zUs3j//mBLViHDDlF/x/L3x278RjuGj/5i0NRNwUfm2raAKUupJMrFVW+TZ0j5dNaKcJxwu8TFakeBARz99A5/X06M6QwgGDCHI37it1gDt3Ajfu+WPId/CpQIM04axgMFQj29HLkm7y1ADO7ugKhc5dZCoz63MIi13yRYg0tLkhBXpaqF/AbRDkMv7hf//8wgYEu1A427YiYHJYvZZlOfz1OWg4h02+B54DBGqJumcrl9LlCY69mt6vZWYBbotgJobimKKCOTR2IH2IZ1jd/H0EZqFju0dWv5CI4P1gx30/NSLcUYOWyqHNYMX4ws6U7uTW9kHYrMS9JhfWh9ZUJSV9jJ0WMCIdxf87mW862rFNwQ==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a89b69-06db-4af2-c067-08d8544d8e24
X-MS-Exchange-CrossTenant-AuthSource: BN6PR21MB0162.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 23:18:55.4999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvXWZmp4r6vEwAnf/+mdH/nhaMYSn9Vs25DmWTOLqKidsxld/XRjsXqWRGhLs/GnUpMOhyyJ7sGTcuH7j9u57w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0132
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
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Jake Oshins <jakeo@microsoft.com>

---

Changes in v2:
    Fixed a typo in the comment in hv_irq_unmask. Thanks to Michael!
    Added Jake's Reviewed-by.

 drivers/pci/controller/pci-hyperv.c | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index fc4c3a15e570..dd21afb5d62b 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1211,6 +1211,21 @@ static void hv_irq_unmask(struct irq_data *data)
 	pbus = pdev->bus;
 	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
 
+	if (hbus->state == hv_pcibus_removing) {
+		/*
+		 * During hibernation, when a CPU is offlined, the kernel tries
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

