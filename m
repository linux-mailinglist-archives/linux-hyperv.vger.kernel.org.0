Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7FD1C8142
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2020 07:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgEGFCp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 May 2020 01:02:45 -0400
Received: from mail-eopbgr760131.outbound.protection.outlook.com ([40.107.76.131]:19651
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbgEGFCp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 May 2020 01:02:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/TPkzE5sVmhjoc0Md0NpRggwQpccx2x27hAAW3PBJiMIWBw8Fm6GX/TpxYfySRR4BtrZt44SerTI9LiCRth+zDnXXJVDsGmOrItI+cmqiffoQ2ibouXH+FMTHFzGrIXONalrO3lBBgqg6Hd7/cY5BtNbATWDsZ4syjMv7xlL52eoD9YvewJkMHcwEbFrWR19JpH/Pg6k4Pc14hWl4L+Jz10aEHr5pGwvYICk9sftedRMfxll+RxEHPlLNLBcK810ZTWx5Y3npaVVxeXnxef/jkDCqnxZzxPS7A/F8mpyaSMklX5edP8KIZ+BDepk6K4h6wOcPuO05ta+VuEsm0iiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQaNSgKHCD+G1afG00asYiqCpzBjZS7h3kfEg6+aj74=;
 b=hZP9URLHuSVSg8p5tz89RGpqFMrLZ+ZGIHQ5GlA/W1iIjax/8zEfuvLwKhM66Cl8w1aGOlXeDbL0vjSsIBUzjeEqhloO399rPc08ePkz+JpGEkqKe/Zy4Q5kjlMHC0zqIOJqdaURJzcGXyckSVUvGc3FBhuOhVTtoj2rWXo2V5AnDDvCUyyHO95kvZKR/B8oqaNg3U9TpPE/ebsVanhLp8JlZIIdTUQtKiUGk2ElkKEtfcWwF4ZDGedPp19BtsIrpfnl51rXGqZ4vGYoVYkDwN9C9me9NYn2xxLpHlPULD6YVzfK6UCMF+634ZVgDtfrEjxQirJU+sRIsGZTzP8czg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQaNSgKHCD+G1afG00asYiqCpzBjZS7h3kfEg6+aj74=;
 b=FODBNIR63sTJ/4KRea+mxCSoeuTgBOo5w8YwAOEad/zNr9n8XkKJIZdR+btmOph2L8mlEFYTFzEqIeJ/94pgzLr4FX6bpijeglS0uQQY2LSLzZHmT2MisPTIsbFgrfKUBVPj5DjH1zlCtAYk8WGNcbmuF7/ZL5VK+9hMjhHB/jg=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from SN6PR2101MB1021.namprd21.prod.outlook.com (2603:10b6:805:8::12)
 by SN4PR2101MB1584.namprd21.prod.outlook.com (2603:10b6:803:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.3; Thu, 7 May
 2020 05:02:39 +0000
Received: from SN6PR2101MB1021.namprd21.prod.outlook.com
 ([fe80::a9e6:4244:f67e:c55]) by SN6PR2101MB1021.namprd21.prod.outlook.com
 ([fe80::a9e6:4244:f67e:c55%6]) with mapi id 15.20.3000.004; Thu, 7 May 2020
 05:02:39 +0000
From:   Wei Hu <weh@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Cc:     Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 1/2] PCI: hv: Fix the PCI HyperV probe failure path to release resource properly
Date:   Thu,  7 May 2020 13:02:11 +0800
Message-Id: <20200507050211.10923-1-weh@microsoft.com>
X-Mailer: git-send-email 2.20.1
Reply-To: weh@microsoft.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0601CA0019.apcprd06.prod.outlook.com (2603:1096:3::29)
 To SN6PR2101MB1021.namprd21.prod.outlook.com (2603:10b6:805:8::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weh-g1-u1904d-testwin10.corp.microsoft.com (167.220.255.113) by SG2PR0601CA0019.apcprd06.prod.outlook.com (2603:1096:3::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Thu, 7 May 2020 05:02:35 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [167.220.255.113]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 94021301-1cd5-4b28-5809-08d7f243dd7c
X-MS-TrafficTypeDiagnostic: SN4PR2101MB1584:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN4PR2101MB1584911C10F8BD980534F2C5BBA50@SN4PR2101MB1584.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zaUdJaQysS0I/FYUdgUW4nOK5dX8kKl7cQCqHG5sHPIv61GOpD6Nrjs773MjAX2dFb2FKeILF4JlSlcPk4Hy+KacAWlhsFBlNnmC8vbNQRi5BQwkfqZXtxSNUJ8YYWWUsVPy4kRigEzWkaGAxWN5I7yvFATi8SJGRwdZu4Hk7bOil7R9R5ODvQ9OmoB3xSBXNk3HuzW8Y9So4z23h58rbeBWxhjdPt0/Mbv+o6cKdWSv9f6fqzykdISrcIUigoODcgQTn6E8tKFiqCaGQOyy6Rcuw2UJSz2bscS5lcow7igkrA4PQPXZs9WyBn3Js+o/YvEsgndWWI1a8hyRX8D5swBjseL2b81VYvE4bfmJmY384UKHn4DkNcTIgOdc2KzTaJxS79qL8dhXzY06gpPWCcuVrhGogvyTYFvIsLFr6rGsLul3ivJ1vFO3xZo+HZgNfgRnXQB9J7xhaC5ljT+6yByQIuyzY0Hm/l5XRViEVp3SWItqSTNFhkS7rP73blnIaHkxog2FmzpcthtOYK4Bum6WUFuijNUjcY57ofV0sE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1021.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(33430700001)(82950400001)(5660300002)(2616005)(956004)(478600001)(10290500003)(316002)(1076003)(83300400001)(83280400001)(83320400001)(83310400001)(83290400001)(66946007)(3450700001)(82960400001)(4326008)(6636002)(107886003)(26005)(7696005)(52116002)(36756003)(33440700001)(86362001)(6666004)(66476007)(8676002)(186003)(6486002)(66556008)(2906002)(16526019)(8936002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Mz9foqbUM4dLf9gSrycvn4IqOzeDA31cBZtKO24gmsJvGFhpTpw9DJuvJ2iTuhlzD/DyZU+BpQUF9LBlr0eRBgnMRB7pTsh8aum3EW5CQmOTiq1wwPxqTpHB8rZBYz/qlYGQH+tBVFXKRFVxrkN0iZgRnksfkVhOrDWTwZrLmsc8t5zaWN4IVxq3WPQP796w5/FgUXAiyj9Zz0Y6HjL8EaLU+NFZ9c8cmaN39glrRl1OIBBWsVEKEolnYUxQPlqIyQWdiSFKPCA74RrI5mcw4mWaflpdP0O6QSLIbf0BmYvAAsaXkAZofHgD45cxDQvCgSuJO0TopMA+nb9P3wf3vxIyqQ+TLuxMTVyAvVFPSbSQYSE/xs6UVz4cdCaRM7+wBth2yQv0cn+zLflj3wXYdHjRJcKv8RNFIW3a7Rxf/Wh4+nrMl16aNVCXRvMKrvxB1r3+Kerl+22m39smvDVYoAuOn7RBdrE2WVb+rybuXYJqWYeHQe4cYhdNYyyvuwj/DBx5Dy8kQ3Zsy6QciyyhKzgCc/gzRAplBM86nrUMEAHRbfks9qIJnqbdDC8HW+noHH1v0kFjgIsm5lzSiQZ1tz1ES2Y39Y+g2LzyOaYHx4VAWOUtVp0APF2oaR/ifWjmySnhXDSPuhHwAd4jsSugaAhzGEtpJRXaKZIVjIYNa7czRz2WDL16hwTo5X6R22fGm1MtO0LozennlGnsPLfmfqyKTRVyHwEyLD0GDSo7MS1H08oEoZQ0RX1oBTZ+4E6h93mBRGPy/VziCZeazjS16yzeSSXUNAPyO1a8i9TU+ozpDC4m49WSYDJvQdX4Yiy9
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94021301-1cd5-4b28-5809-08d7f243dd7c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 05:02:39.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDgMtfyxT+p2imBUfX3SDYayNCkR0d3wofFgkhFpD/Y85r/W/gu5DXmEeYgub+vX8A2FcfGyuzsbxZFjoBki+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB1584
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In some error cases in hv_pci_probe(), allocated resources are not freed.
Fix this by adding a field to keep track of the high water mark for slots
that have resources allocated to them.  In case of an error, this high
water mark is used to know which slots have resources that must be released.
Since slots are numbered starting with zero, a value of -1 indicates no
slots have been allocated resources.  There may be unused slots in the range
between slot 0 and the high water mark slot, but these slots are already
ignored by the existing code in the allocate and release loops with the call
to get_pcichild_wslot().

Signed-off-by: Wei Hu <weh@microsoft.com>
---
    v3: Add detailed explanation of this patch in commit log per Lorenzo
    Pieralisi's suggestions.

 drivers/pci/controller/pci-hyperv.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e15022ff63e3..e6fac0187722 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -480,6 +480,9 @@ struct hv_pcibus_device {
 
 	struct workqueue_struct *wq;
 
+	/* Highest slot of child device with resources allocated */
+	int wslot_res_allocated;
+
 	/* hypercall arg, must not cross page boundary */
 	struct hv_retarget_device_interrupt retarget_msi_interrupt_params;
 
@@ -2847,7 +2850,7 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
 	struct hv_pci_dev *hpdev;
 	struct pci_packet *pkt;
 	size_t size_res;
-	u32 wslot;
+	int wslot;
 	int ret;
 
 	size_res = (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2)
@@ -2900,6 +2903,8 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
 				comp_pkt.completion_status);
 			break;
 		}
+
+		hbus->wslot_res_allocated = wslot;
 	}
 
 	kfree(pkt);
@@ -2918,10 +2923,10 @@ static int hv_send_resources_released(struct hv_device *hdev)
 	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
 	struct pci_child_message pkt;
 	struct hv_pci_dev *hpdev;
-	u32 wslot;
+	int wslot;
 	int ret;
 
-	for (wslot = 0; wslot < 256; wslot++) {
+	for (wslot = hbus->wslot_res_allocated; wslot >= 0; wslot--) {
 		hpdev = get_pcichild_wslot(hbus, wslot);
 		if (!hpdev)
 			continue;
@@ -2936,8 +2941,12 @@ static int hv_send_resources_released(struct hv_device *hdev)
 				       VM_PKT_DATA_INBAND, 0);
 		if (ret)
 			return ret;
+
+		hbus->wslot_res_allocated = wslot - 1;
 	}
 
+	hbus->wslot_res_allocated = -1;
+
 	return 0;
 }
 
@@ -3037,6 +3046,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	if (!hbus)
 		return -ENOMEM;
 	hbus->state = hv_pcibus_init;
+	hbus->wslot_res_allocated = -1;
 
 	/*
 	 * The PCI bus "domain" is what is called "segment" in ACPI and other
@@ -3136,7 +3146,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 
 	ret = hv_pci_allocate_bridge_windows(hbus);
 	if (ret)
-		goto free_irq_domain;
+		goto exit_d0;
 
 	ret = hv_send_resources_allocated(hdev);
 	if (ret)
@@ -3154,6 +3164,8 @@ static int hv_pci_probe(struct hv_device *hdev,
 
 free_windows:
 	hv_pci_free_bridge_windows(hbus);
+exit_d0:
+	(void) hv_pci_bus_exit(hdev, true);
 free_irq_domain:
 	irq_domain_remove(hbus->irq_domain);
 free_fwnode:
-- 
2.20.1

