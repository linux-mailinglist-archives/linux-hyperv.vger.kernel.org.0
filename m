Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62D4110350C
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Nov 2019 08:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfKTHRX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Nov 2019 02:17:23 -0500
Received: from mail-eopbgr720133.outbound.protection.outlook.com ([40.107.72.133]:51631
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727670AbfKTHRW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Nov 2019 02:17:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBl+K/S4vYmfsBdQ/tyymdFRPNlmFznfiGHTtKWvAXHM5JoDkUwQ286u/qWSCoWeNi1zCz1HaUZXU0p7AwufuakSwyGjjB/ejtoo3ihFWWoT1hzz/RGwxWqTlTMThTqC75o0+uejbwznSE4fCtMR6zJeX96OMnV2PWGFQLhXewT1T7xXoaISMAIT98ypRs9EcT1dROebRUmF2/juH63VfShqhLLhggH4qDZf5njZHbn6g/Fh+01WRpu3jMKhMSQHHMrgFlk9C0hL6fGaFGpY9Pugdd9pAJo4VtFd7c2pO8oGnhcx2lP4Ed9ytam+LK9nkXRLGx9dlqUph8RyD4rUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QecmJbecI4m5UIXgnD35Z33oc/QS05Ga5gawtJStTZc=;
 b=fO3SdOTwgei6FtSwWemEoIoL4/PR1oIx9hWtKNiGg2FKjcODjTarQjPrOnSPeVaAnyBtF4tvKew+CqkswZRKZmIBKQtnmSjBRF8Na4jQUr/QTSXnPUx/k05u8S4Bc4HJTTEO0cb6zlr0pEfAKPHSwUmwyaAbuSGp0yo0Sl2jcmPMWXCL2/QzCHn4KDOUkRo9eLz2i3wX7uFKTQmUzjvhDYf6HH7PgNKK2WhyLSRKUnVCWMNJXqUPJUsvQ3GlRPsd3cIRPVe39vMNtwpT3FiPEQE3Igeq7PeOSY8wMuzlAiID72XtG7UXNyl9EAzMG7d/HajUd7xD0fsq+KCOdtpHFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QecmJbecI4m5UIXgnD35Z33oc/QS05Ga5gawtJStTZc=;
 b=JvIjHJkslOnrJRlfHz9HePG1Mb5OFzrnLqq/CKh89QtVwL7WvfDwofwZlXdPQiTsCdvPpgE/QaOIvmnYs7tyaEf3Fj2keHSEP/8mQvhXrK8XG/TmqQrcTlXuFXKJp3XLPmA8nhykc8BiZtWxJDGE1NOcVK4VJwikBLMc/Fv5q94=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1137.namprd21.prod.outlook.com (20.179.72.96) by
 BN8PR21MB1251.namprd21.prod.outlook.com (20.179.74.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.3; Wed, 20 Nov 2019 07:17:18 +0000
Received: from BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d]) by BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d%2]) with mapi id 15.20.2495.006; Wed, 20 Nov 2019
 07:17:18 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 2/4] PCI: hv: Add the support of hibernation
Date:   Tue, 19 Nov 2019 23:16:56 -0800
Message-Id: <1574234218-49195-3-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574234218-49195-1-git-send-email-decui@microsoft.com>
References: <1574234218-49195-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR2001CA0022.namprd20.prod.outlook.com
 (2603:10b6:301:15::32) To BN8PR21MB1137.namprd21.prod.outlook.com
 (2603:10b6:408:71::32)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR2001CA0022.namprd20.prod.outlook.com (2603:10b6:301:15::32) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 20 Nov 2019 07:17:17 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17d8c894-c9fe-4c03-e6d8-08d76d89ad6b
X-MS-TrafficTypeDiagnostic: BN8PR21MB1251:|BN8PR21MB1251:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR21MB1251FBA876FF5957C32AB73ABF4F0@BN8PR21MB1251.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(10090500001)(36756003)(8936002)(50226002)(81166006)(81156014)(8676002)(14444005)(6436002)(6486002)(1511001)(86362001)(7736002)(2906002)(5660300002)(478600001)(10290500003)(4720700003)(6636002)(3846002)(6116002)(25786009)(3450700001)(66946007)(66556008)(66476007)(305945005)(316002)(386003)(6666004)(4326008)(6506007)(22452003)(26005)(16586007)(186003)(16526019)(107886003)(76176011)(51416003)(52116002)(66066001)(48376002)(47776003)(50466002)(446003)(11346002)(43066004)(956004)(2616005)(476003)(486006)(6512007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1251;H:BN8PR21MB1137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WuOMyEb/BeQlcapCJR1LSb1XpUtNER3T/sgd61CZdZC+Y7PACrn5y9OQvaBMH3rw4eNg6CWZfiRS5xLNSQVxWGZ+IxfijaBdeO0pvmW1TM3YSgM6iMr8YgB38mYHxlgYhIZkhdlOu0Mj4KJnmwVpr8AlEdkHTe21mdcqVNE4jwskW8W702J01b3VMFBFbaKcqckmZ2L64hWM8HV4bGnVxKnB5zbuDEOaVrzclm/eNtS4KJ9Vh+a4mXvCDI5ZnULXRBdjrsd96OUCe7XRgE8O9m74R2qcsH7uiDtvV1sOfWQwidIBhjTQBSfIkI2pTrMHuC7G9Wnu2DTfBbbfA3XdS4AIrmwDaycK7RrhA4TvwZTsAzCdGbGCoZTB4CgsACZvWwRUdfnwH5QrQpYz0+eGzerP6ct6t47ki4gxq9k8pVqXJz2UMj3FPToRtqyroiP9
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d8c894-c9fe-4c03-e6d8-08d76d89ad6b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 07:17:18.6823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUlEFDMdPsiwm8UQogxw0zoLrs1Tgcwf0f5Q2UcPcxsc1u2SmKjPqome6Fm+XTKhAKXG5S1s7TEf2P1FFM/AgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1251
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implement the suspend/resume callbacks.

We must make sure there is no pending work items before we call
vmbus_close().

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2: this patch is a simple merge of 2 previous smaller patches,
accordign to the suggestion of Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>.

 drivers/pci/controller/pci-hyperv.c | 107 +++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 65f18f840ce9..e71eb6e0bfdd 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -455,6 +455,7 @@ enum hv_pcibus_state {
 	hv_pcibus_init = 0,
 	hv_pcibus_probed,
 	hv_pcibus_installed,
+	hv_pcibus_removing,
 	hv_pcibus_removed,
 	hv_pcibus_maximum
 };
@@ -1681,6 +1682,23 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
 
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
 
+	/*
+	 * Clear the memory enable bit, in case it's already set. This occurs
+	 * in the suspend path of hibernation, where the device is suspended,
+	 * resumed and suspended again: see hibernation_snapshot() and
+	 * hibernation_platform_enter().
+	 *
+	 * If the memory enable bit is already set, Hyper-V sliently ignores
+	 * the below BAR updates, and the related PCI device driver can not
+	 * work, because reading from the device register(s) always returns
+	 * 0xFFFFFFFF.
+	 */
+	list_for_each_entry(hpdev, &hbus->children, list_entry) {
+		_hv_pcifront_read_config(hpdev, PCI_COMMAND, 2, &command);
+		command &= ~PCI_COMMAND_MEMORY;
+		_hv_pcifront_write_config(hpdev, PCI_COMMAND, 2, command);
+	}
+
 	/* Pick addresses for the BARs. */
 	do {
 		list_for_each_entry(hpdev, &hbus->children, list_entry) {
@@ -2107,6 +2125,12 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
 	unsigned long flags;
 	bool pending_dr;
 
+	if (hbus->state == hv_pcibus_removing) {
+		dev_info(&hbus->hdev->device,
+			 "PCI VMBus BUS_RELATIONS: ignored\n");
+		return;
+	}
+
 	dr_wrk = kzalloc(sizeof(*dr_wrk), GFP_NOWAIT);
 	if (!dr_wrk)
 		return;
@@ -2223,11 +2247,19 @@ static void hv_eject_device_work(struct work_struct *work)
  */
 static void hv_pci_eject_device(struct hv_pci_dev *hpdev)
 {
+	struct hv_pcibus_device *hbus = hpdev->hbus;
+	struct hv_device *hdev = hbus->hdev;
+
+	if (hbus->state == hv_pcibus_removing) {
+		dev_info(&hdev->device, "PCI VMBus EJECT: ignored\n");
+		return;
+	}
+
 	hpdev->state = hv_pcichild_ejecting;
 	get_pcichild(hpdev);
 	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
-	get_hvpcibus(hpdev->hbus);
-	queue_work(hpdev->hbus->wq, &hpdev->wrk);
+	get_hvpcibus(hbus);
+	queue_work(hbus->wq, &hpdev->wrk);
 }
 
 /**
@@ -3107,6 +3139,75 @@ static int hv_pci_remove(struct hv_device *hdev)
 	return ret;
 }
 
+static int hv_pci_suspend(struct hv_device *hdev)
+{
+	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
+	enum hv_pcibus_state old_state;
+	int ret;
+
+	tasklet_disable(&hdev->channel->callback_event);
+
+	/* Change the hbus state to prevent new work items. */
+	old_state = hbus->state;
+	if (hbus->state == hv_pcibus_installed)
+		hbus->state = hv_pcibus_removing;
+
+	tasklet_enable(&hdev->channel->callback_event);
+
+	if (old_state != hv_pcibus_installed)
+		return -EINVAL;
+
+	flush_workqueue(hbus->wq);
+
+	ret = hv_pci_bus_exit(hdev, true);
+	if (ret)
+		return ret;
+
+	vmbus_close(hdev->channel);
+
+	return 0;
+}
+
+static int hv_pci_resume(struct hv_device *hdev)
+{
+	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
+	enum pci_protocol_version_t version[1];
+	int ret;
+
+	hbus->state = hv_pcibus_init;
+
+	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
+			 hv_pci_onchannelcallback, hbus);
+	if (ret)
+		return ret;
+
+	/* Only use the version that was in use before hibernation. */
+	version[0] = pci_protocol_version;
+	ret = hv_pci_protocol_negotiation(hdev, version, 1);
+	if (ret)
+		goto out;
+
+	ret = hv_pci_query_relations(hdev);
+	if (ret)
+		goto out;
+
+	ret = hv_pci_enter_d0(hdev);
+	if (ret)
+		goto out;
+
+	ret = hv_send_resources_allocated(hdev);
+	if (ret)
+		goto out;
+
+	prepopulate_bars(hbus);
+
+	hbus->state = hv_pcibus_installed;
+	return 0;
+out:
+	vmbus_close(hdev->channel);
+	return ret;
+}
+
 static const struct hv_vmbus_device_id hv_pci_id_table[] = {
 	/* PCI Pass-through Class ID */
 	/* 44C4F61D-4444-4400-9D52-802E27EDE19F */
@@ -3121,6 +3222,8 @@ static struct hv_driver hv_pci_drv = {
 	.id_table	= hv_pci_id_table,
 	.probe		= hv_pci_probe,
 	.remove		= hv_pci_remove,
+	.suspend	= hv_pci_suspend,
+	.resume		= hv_pci_resume,
 };
 
 static void __exit exit_hv_pci_drv(void)
-- 
2.19.1

