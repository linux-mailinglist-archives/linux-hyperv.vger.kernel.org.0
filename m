Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C4910886D
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2019 06:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfKYFiT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Nov 2019 00:38:19 -0500
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:7331
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfKYFiT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Nov 2019 00:38:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J727B7+1r45LJ+kzG/N1xFVquMlw5ZMIrK69clew/pFNhor4bopqDyknaNRDmGTQ/SuHs9wh2d+JxdJEhKjsNw95W2TQIYEX3fvTgxNawA6wbl2nHH1f7xUFkWKqDur3Bb4YrrgcXbNW697FSlmGSRJTKVHYaNLe37Trrf6ajbDFC3eTmDmnVHNu7m7pszwQk4gKN9s1QH6siSfdBezL+ygXdEdbuwe/s1rXXoDTeJVlZmwkX54Y0SwRSUOcppeuFCgYI4GY+J0ggiB+3epqFjAT9kThweSZX78SGqf7t8xifLaxhctYjYIv1ttY6loHn8c4cyDdTg0z/tLjFPZGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9vqP/9OMnBq4PWc3YRBg0/Eteu06Bqp8qfNu+jf7pQ=;
 b=QIDOBqtAfjvHswCBDwsrNBBH1S5Gb2iIoUkm9xOKScWPf1sEiLTogR4ZYmDoN2b0jAzFtLk2bwnGYdA5HlC7oNkcAAw+bj7zzJCWc8zEsjsFtUCIk66EUZX6DTld0/adb19j71WBOJkaddFsHe703sD+95GHsS8Jif/4EFZ3Zs9RmcWK3TGh/XmXlfX1YZYnyHdragHMUcR0Am81+IBIz2rZLFj/BA9c+RtbuIfP1+do4TBcYDC4KRRpNDW67ylLkFlQEEEuzP2kEO/okRs0EkEt56UCHES3TU9OyY77eniFIgo1rTurb6QI4P98SrnsR35iQAM2ALco3w/2L/UrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9vqP/9OMnBq4PWc3YRBg0/Eteu06Bqp8qfNu+jf7pQ=;
 b=BRIfs3FNe8kyV7SGQzwFviOIrV1HmnlTmP9iehp81RiLYvTyUqriGRE7LlUnGd0J+JsU9iWZcn+E6DsyVw4hm2I6+W2cq8bnka2S9gaYMot0bdN8H5IqOkF/N1jozrl2bILhiF60832fXbDHWJa74cIX4rcicV4A+A20R9BbmDM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BYAPR21MB1141.namprd21.prod.outlook.com (20.179.57.138) by
 BYAPR21MB1189.namprd21.prod.outlook.com (20.179.57.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.1; Mon, 25 Nov 2019 05:34:09 +0000
Received: from BYAPR21MB1141.namprd21.prod.outlook.com
 ([fe80::5d0f:2e49:3464:7c89]) by BYAPR21MB1141.namprd21.prod.outlook.com
 ([fe80::5d0f:2e49:3464:7c89%3]) with mapi id 15.20.2495.014; Mon, 25 Nov 2019
 05:34:09 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 2/4] PCI: hv: Add the support of hibernation
Date:   Sun, 24 Nov 2019 21:33:52 -0800
Message-Id: <1574660034-98780-3-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574660034-98780-1-git-send-email-decui@microsoft.com>
References: <1574660034-98780-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:300:13d::21) To BYAPR21MB1141.namprd21.prod.outlook.com
 (2603:10b6:a03:108::10)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR20CA0011.namprd20.prod.outlook.com (2603:10b6:300:13d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 25 Nov 2019 05:34:08 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0dd4cf78-adbb-4da6-5d8e-08d771691851
X-MS-TrafficTypeDiagnostic: BYAPR21MB1189:|BYAPR21MB1189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR21MB118901524EEA5885224A3546BF4A0@BYAPR21MB1189.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(366004)(136003)(346002)(189003)(199004)(6116002)(3846002)(4326008)(107886003)(6486002)(6436002)(10090500001)(3450700001)(2906002)(14444005)(50466002)(48376002)(25786009)(6512007)(76176011)(26005)(6506007)(386003)(51416003)(52116002)(66946007)(66556008)(66476007)(6636002)(4720700003)(86362001)(7736002)(186003)(2616005)(956004)(16526019)(36756003)(11346002)(446003)(66066001)(8936002)(8676002)(5660300002)(81156014)(47776003)(81166006)(1511001)(50226002)(10290500003)(478600001)(316002)(305945005)(6666004)(16586007)(43066004)(22452003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1189;H:BYAPR21MB1141.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDiYusnySB1OkwPh+HcX2gIchH0lcsCzal1X1AyIBfO3TXGK/RrPUO62CXdQlXNmZ9Xxquyf6a3UNVw2eNB0dXvUtjjqpRhJZb1jIkNnMrEKKHAokEhTMKa07cXar6xDufAhW6cT8GsPOpvqw/uB1HPRFz/+WKOAI8x8Gn4Yl9n/Xca9MSKHcq9PDDJc5mTPk6N9TH1KNUGtPgnR9VDXzanhK4cMk0vgwYE2DQcrIEjIK4AuUD6NriVvj29xz26aNHx/45LHYmb3LM0dBs7eJb5VtYoryeWeke2VKV75yIeeID4hF6ZImwWTpeZXOenXbakM1EdtUWounfx0bjTWAEkLsCKXj4Ab5NodHoW1aLiUKJghwWBipzwf/4QlpSsyFyvn9mztbqHy/AuLuWdLW6WDTiVuKB1B4ZfV6BJJtUmLjKhmyhvAj/EHnnlovbTS
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd4cf78-adbb-4da6-5d8e-08d771691851
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 05:34:09.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83UU6rd9ae9SazHyMLLWCk92KCw773TuOQAR77IAR8fBU3XXSHJkIhkFBLzG2m9rMK6SLTLYNW//HfEAsVeHRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1189
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add suspend() and resume() functions so that Hyper-V virtual PCI devices are
handled properly when the VM hibernates and resumes from hibernation.

Note that the suspend() function must make sure there are no pending work
items before calling vmbus_close(), since it runs in a process context as a
callback in dpm_suspend().  When it starts to run, the channel callback
hv_pci_onchannelcallback(), which runs in a tasklet context, can be still running
concurrently and scheduling new work items onto hbus->wq in
hv_pci_devices_present() and hv_pci_eject_device(), and the work item
handlers can access the vmbus channel, which can be being closed by
hv_pci_suspend(), e.g. the work item handler pci_devices_present_work() ->
new_pcichild_device() writes to the vmbus channel.

To eliminate the race, hv_pci_suspend() disables the channel callback
tasklet, sets hbus->state to hv_pcibus_removing, and re-enables the tasklet.
This way, when hv_pci_suspend() proceeds, it knows that no new work item
can be scheduled, and then it flushes hbus->wq and safely closes the vmbus
channel.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 125 +++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 65f18f840ce9..3c4996b073ca 100644
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
@@ -3107,6 +3139,93 @@ static int hv_pci_remove(struct hv_device *hdev)
 	return ret;
 }
 
+static int hv_pci_suspend(struct hv_device *hdev)
+{
+	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
+	enum hv_pcibus_state old_state;
+	int ret;
+
+	/*
+	 * hv_pci_suspend() must make sure there are no pending work items
+	 * before calling vmbus_close(), since it runs in a process context
+	 * as a callback in dpm_suspend().  When it starts to run, the channel
+	 * callback hv_pci_onchannelcallback(), which runs in a tasklet
+	 * context, can be still running concurrently and scheduling new work
+	 * items onto hbus->wq in hv_pci_devices_present() and
+	 * hv_pci_eject_device(), and the work item handlers can access the
+	 * vmbus channel, which can be being closed by hv_pci_suspend(), e.g.
+	 * the work item handler pci_devices_present_work() ->
+	 * new_pcichild_device() writes to the vmbus channel.
+	 *
+	 * To eliminate the race, hv_pci_suspend() disables the channel
+	 * callback tasklet, sets hbus->state to hv_pcibus_removing, and
+	 * re-enables the tasklet. This way, when hv_pci_suspend() proceeds,
+	 * it knows that no new work item can be scheduled, and then it flushes
+	 * hbus->wq and safely closes the vmbus channel.
+	 */
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
@@ -3121,6 +3240,8 @@ static struct hv_driver hv_pci_drv = {
 	.id_table	= hv_pci_id_table,
 	.probe		= hv_pci_probe,
 	.remove		= hv_pci_remove,
+	.suspend	= hv_pci_suspend,
+	.resume		= hv_pci_resume,
 };
 
 static void __exit exit_hv_pci_drv(void)
-- 
2.19.1

