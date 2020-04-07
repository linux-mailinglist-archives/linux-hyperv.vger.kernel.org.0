Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA431A17A4
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2020 00:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgDGWCY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Apr 2020 18:02:24 -0400
Received: from mail-dm6nam10on2125.outbound.protection.outlook.com ([40.107.93.125]:64608
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbgDGWCY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Apr 2020 18:02:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9Opdko9NLGQ8PqgZ6jvERpsx6eGzfPVIXvF1l3cQmxXADjWCYXm5IRyaRDOUy7OhKfGjSvfg5A5PTGAhGpQFyUwCCs9bzKQ/ee6Tb0T9sp86Qak6tBfyfdLEXb00EbU+Onw/p1egqgyJGlqpIMldBArOaNbtFKM6dUsgbgfutYG7qis2mjRx4W6i8eIg3qfU4N6mdPn4ayrKr5IyxLAyDVp16TDCFw18OWxQQ3/VHdKPaXIn0ln8CNjJgaW3eZLYCVKKvxKDNtIan0jXDEj4eLcT2bl6ZKfZIre2FqskFJurjAt/qGhdZnGGZkm4AA3muPyE4OyVp/fOlQUXzXtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbdcxXwOXL0nVGyeok9m22g2TilFPUjw5QCZwWcj+aE=;
 b=i+zLnIZsxdr+uBUcdQIJPNvCkS23ZILjf/EA9pqBImHMcfTyl0KRSHf45by1rupg6+xfZa9FE+wWZ29y4wKXMYFdF6+0RUex7vrKrCuNgKreBzYVblkpAcPGzQQwlwnZhL1UJ7UQskt9y4L6/45kIvXdGOT/79KC3XDusJJ+OA38X5Hu0asx1IUOp7HrCnR1AWkwhjwX/38jgVs2n4M8yy/6bR8caMoXbuP5S5Yr3pyTB/RsZ7p9sJr+OSb4r8O64wXj/F6u96H1mCIUifAilxOv5ivIKZzqa84JSiV4F4iXdCMC0jNpuFgCWfJFf2jWjZ/8f4J1zUeMwLhzJ3LoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbdcxXwOXL0nVGyeok9m22g2TilFPUjw5QCZwWcj+aE=;
 b=TcL/sCTaNhnji9mbWGV7DFXS2NnDg8RglhK5X2Qy+WYTpWUwa6tEClTvsgyacorW6tB7IEUkGZDQd/562BGRuDsfkn2AWKWADeHt/3Zm01cKmc20CA3lybYeHB0bvYLmLNiqJ5qBtMWNTntXGZ8RWiRDI/Of05hDF9R8iR23Kpo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1139.namprd21.prod.outlook.com (2603:10b6:408:72::10)
 by BN8PR21MB1187.namprd21.prod.outlook.com (2603:10b6:408:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.4; Tue, 7 Apr
 2020 22:02:21 +0000
Received: from BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b5da:34dd:f205:560b]) by BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b5da:34dd:f205:560b%4]) with mapi id 15.20.2900.010; Tue, 7 Apr 2020
 22:02:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] Drivers: hv: vmbus: Disallow the freeze PM operation
Date:   Tue,  7 Apr 2020 15:01:47 -0700
Message-Id: <1586296907-53744-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR18CA0033.namprd18.prod.outlook.com
 (2603:10b6:320:31::19) To BN8PR21MB1139.namprd21.prod.outlook.com
 (2603:10b6:408:72::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR18CA0033.namprd18.prod.outlook.com (2603:10b6:320:31::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Tue, 7 Apr 2020 22:02:19 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0fbbfea9-d3dd-4434-1553-08d7db3f57f8
X-MS-TrafficTypeDiagnostic: BN8PR21MB1187:|BN8PR21MB1187:|BN8PR21MB1187:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB11877A7866968607CD260EF3BFC30@BN8PR21MB1187.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1139.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(82950400001)(5660300002)(2616005)(10290500003)(186003)(107886003)(956004)(6666004)(26005)(8676002)(82960400001)(8936002)(81156014)(6512007)(81166006)(36756003)(66946007)(316002)(66476007)(2906002)(52116002)(478600001)(3450700001)(66556008)(86362001)(6506007)(6486002)(16526019)(4326008);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JBTJXCwhe2DM7bzlvuxHccA1Gl90jS2TTANA6rouUMf75IFmZ0Zb+fg3Uox993T2daugclhpow4EEiVgMvgxWWu3WdGb1q3pccMVHB3ssFq/yTTXD1DQ+5ONRpgYPACbOpSPY5brBx++NhaFIj/oB8QnciLF4juoHnDXcU9b2ZS0Y+IonTEDcp9qY7wAN6qc9uIT8glnoWxd8DLJJVfM2i2OexMfF0m32ot25TKft2BFUBlGRhuPUlEjvdxX3BEznqsNoqY+BSmAoPIejPvqsxSHOWnwTMHUia3XG9nOKC1Cqq6N6QT28HJ2YxvctsOHBwyPmFmsqb39L+rhuZ88Lf9QfwHVW+rF7nq9FibCzo8HPp/j9z6o5Bee0h05a6pGyBwFSHBIgvOqgp40Lhlp/vsdgjFKGfxtTOn2NndytTGZlDQcmQNGUoGfqa3C+5a
X-MS-Exchange-AntiSpam-MessageData: 0xSRjifgMf925bdY9diu1/+mLY40TsbDJ1hZ9AN+l+TzrBHBp5MXFT6t4ct71Acv3V1IXBLSioU2vK9r0KScxZWxT/rJFrLZGZ5P9V5vijs6hW9ETs34HIwP6AWi7ruKKjQjo7nGuVGoAF00nccyFg==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbbfea9-d3dd-4434-1553-08d7db3f57f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 22:02:20.6840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RN2JsBvhC0j83hHCzHEUIH/VNwmK+KeLJQxK/V6ad9QOVUYIv9Kfojvaq6fz2SQoNJZKOUo+d65XOKW5RL49Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1187
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Before the hibernation patchset (e.g. f53335e3289f), a Linux VM on Hyper-V
can run "echo freeze > /sys/power/state" (or "systemctl suspend")
to freeze the system. The user can press the keyboard or move the mouse
to wake up the VM. Note: the two aforementioned commands are equivalent
here, because Hyper-V doesn't support the guest ACPI S3 state.

With the hibernation patchset, a Linux VM on Hyper-V can hibernate to disk
and resume back; however, the 'freeze' operation is broken for Hyper-V
Generation-2 VM (which doesn't have a legacy keyboard/mouse): when the
vmbus devices are suspended, the VM can not receive any interrupt from
the synthetic keyboard/mouse devices, so there is no way to wake up the
VM. This is not an issue for Generaton-1 VM, because it looks the legacy
keyboard/mouse devices can still be used to wake up the VM in my test.

IMO 'freeze' in a Linux VM on Hyper-V is not really useful in practice,
so let's disallow the operation for both Gen-1 and Gen-2 VMs, even if
it's not an issue for Gen-1 VMs.

Fixes: f53335e3289f ("Drivers: hv: vmbus: Suspend/resume the vmbus itself for hibernation")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 029378c..82a4327 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -28,6 +28,7 @@
 #include <linux/notifier.h>
 #include <linux/ptrace.h>
 #include <linux/screen_info.h>
+#include <linux/suspend.h>
 #include <linux/kdebug.h>
 #include <linux/efi.h>
 #include <linux/random.h>
@@ -2357,6 +2358,23 @@ static void hv_synic_resume(void)
 	.resume = hv_synic_resume,
 };
 
+/*
+ * Note: "freeze/suspend" here means "systemctl suspend".
+ * "systemctl hibernate" is still supported.
+ */
+static int hv_pm_notify(struct notifier_block *nb,
+			unsigned long val, void *ign)
+{
+	if (val == PM_SUSPEND_PREPARE) {
+		pr_info("freeze/suspend is not supported\n");
+		return NOTIFY_BAD;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block hv_pm_nb;
+
 static int __init hv_acpi_init(void)
 {
 	int ret, t;
@@ -2389,6 +2407,8 @@ static int __init hv_acpi_init(void)
 	hv_setup_crash_handler(hv_crash_handler);
 
 	register_syscore_ops(&hv_synic_syscore_ops);
+	hv_pm_nb.notifier_call = hv_pm_notify;
+	register_pm_notifier(&hv_pm_nb);
 
 	return 0;
 
@@ -2402,6 +2422,7 @@ static void __exit vmbus_exit(void)
 {
 	int cpu;
 
+	unregister_pm_notifier(&hv_pm_nb);
 	unregister_syscore_ops(&hv_synic_syscore_ops);
 
 	hv_remove_kexec_handler();
-- 
1.8.3.1

