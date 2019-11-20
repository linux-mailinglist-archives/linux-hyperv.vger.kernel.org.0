Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD64A1034E8
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Nov 2019 08:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfKTHPI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Nov 2019 02:15:08 -0500
Received: from mail-eopbgr720138.outbound.protection.outlook.com ([40.107.72.138]:25376
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfKTHPI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Nov 2019 02:15:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVEKr9ruT8bpCRNOkcwQW2Tg9x2Qx/mTEWs7bMTytFa9/BQKspTwy2sa3pyps4eZJphLf/eFsa1X0vKtzDIzc9giyKViFsU0XzoQlRr69R7IwcC06mlqqmLqyV56RKaQ/+4eW0ZkMCXWraqHe6gCVTQT+W8eGkwrjidWueAq4MniB4vsvtYWi1Fqz7fcfgUOD4B5vP45ojnBwtCJPocIWemaHetfHkvnpmEpd+1CASxU3kp0icZx5XqCU5HILpiIe9DDcPIs4eO5wiQwCMYY0gZ1gUMwSVHeNvFIdGB4mL6VpTtmEOegwEAAoEFkmcqe7A+FNvvsms9Ybvjyv/Iuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P15rWuOlm/J4PXd5DAQOnbMS1fEWyCY3EHRZuWYPfQA=;
 b=Q7wtway0Y3mgpHZTs000fG7upQ4v6rPPwArTUTsKh2YSv2z82jY+zkMvLZOr0KvK9HORyT3t1cMF3oEs0XcT3NtzPqPfG1YFxuV8FmSUooNd26tmFJhx3B9c5l/ZCFBfLAIFQsx7jz7WZvh7c9zwdVhMHxR+fGWOfxVF+RNizxwiOsDiyJr5TBESZSlcq3iusGy7AHChKcFSC7pa/JcJko+opR6MAAzG2bQ+ETLEUzOshNqKAThBYk992vPp1fQzZ3LFDtT74MBHkxpCqjgGSpQUk/n8M4O0xSp+xs3WYSxbbrrIw4C39fmD3935EQhBJRlTSxs2k8+cRHA6nrZ2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P15rWuOlm/J4PXd5DAQOnbMS1fEWyCY3EHRZuWYPfQA=;
 b=Ig9P+nZU9JxIZC7+RdTnj8TnmcCsYCVbY/hxAXAxz1JkNL/y513EfcxUE4m2znTiSNgosa4SqMv1Ln8IyJlZVmb7lGjxv2YtcIL/xdsy9s6d3CRQGZ7dBH+ctalUo4lGSy0r+5GjJYtlnnFhTiV+coz9tzU0XBhOB8TIaluc0/s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1137.namprd21.prod.outlook.com (20.179.72.96) by
 BN8PR21MB1251.namprd21.prod.outlook.com (20.179.74.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.3; Wed, 20 Nov 2019 07:15:04 +0000
Received: from BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d]) by BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d%2]) with mapi id 15.20.2495.006; Wed, 20 Nov 2019
 07:15:04 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2] HID: hyperv: Add the support of hibernation
Date:   Tue, 19 Nov 2019 23:14:56 -0800
Message-Id: <1574234096-48767-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR2001CA0013.namprd20.prod.outlook.com
 (2603:10b6:301:15::23) To BN8PR21MB1137.namprd21.prod.outlook.com
 (2603:10b6:408:71::32)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR2001CA0013.namprd20.prod.outlook.com (2603:10b6:301:15::23) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 20 Nov 2019 07:15:03 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a3e3771-45a0-4e3f-74b3-08d76d895d81
X-MS-TrafficTypeDiagnostic: BN8PR21MB1251:|BN8PR21MB1251:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR21MB1251ED5AD29398CC81DDB1A2BF4F0@BN8PR21MB1251.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(10090500001)(36756003)(8936002)(50226002)(81166006)(81156014)(8676002)(14444005)(6436002)(6486002)(1511001)(86362001)(7736002)(2906002)(5660300002)(478600001)(10290500003)(966005)(4720700003)(6636002)(3846002)(6116002)(25786009)(3450700001)(66946007)(66556008)(66476007)(305945005)(316002)(386003)(6666004)(4326008)(6506007)(22452003)(26005)(16586007)(186003)(16526019)(107886003)(51416003)(52116002)(66066001)(48376002)(47776003)(50466002)(43066004)(956004)(2616005)(476003)(486006)(6512007)(6306002)(921003)(21314003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1251;H:BN8PR21MB1137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oBElm30y8BLgjWj9IU/nrudVj+GGjjr9zbJfgLGUQMKXGL2bsLMlX/mq14mcSgBi5i4BtNJiC7ByK5Es2WGcQ9QDHFnfRQEaiXC3bgKku7QqsABeN7nKidwVuSD9JII54+5Dlr63dhNiU1jwBV2svT2L/TYEZOQaIVoKPwiUJGr2UJz59KpjoiCTNl7p5UljR65IKHrsIQINFnKnaBF6qjV+yLhU6ebmaoz12KhtPsDt/ojzY9ET81v/AfOwgPjPQ9fvLTKCtEnWmBsoiUcJbKwtMRQ4QmDnkyF0Ow7WIktnoH85aamWzXZrRt+9NKkuJy3VHayf9UNqNqWzaDiiqZ/9SHy4nWnQ+6Oh7T0VkrkK68tBjLtb/cEtrmjt7dpF/MuNY5uH+SaSHGE5AB3MFjXc/2qJQmuicluqlmNXNCMk8lW4MCg+iraZjAgM7jka
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3e3771-45a0-4e3f-74b3-08d76d895d81
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 07:15:04.5888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kh7zn7Lqc3qiAgzKOyTBYYTI0stUVzfN8QrGfgzh+4UdtpnwfazqgM5JMDE4UgtmZ2YgfEu1I7WsiKJ2KdrsKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1251
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

During the suspend process and resume process, if there is any mouse
event, there is a small chance the suspend and the resume process can be
aborted because of mousevsc_on_receive() -> pm_wakeup_hard_event().

This behavior can be avoided by disabling the Hyper-V mouse device as
a wakeup source:

echo disabled > /sys/bus/vmbus/drivers/hid_hyperv/XXX/power/wakeup
(XXX is the device's GUID).

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
---

Changes in v2:
  Removed the "struct notifier_block pm_nb;" after the discussion
with Dmitry Torokhov:
  https://lore.kernel.org/lkml/PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM/T/#m8948c711301220a36a1a413eead74cd2fb6dcac1

 drivers/hid/hid-hyperv.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 79a28fc91521..dddfca555df9 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -192,6 +192,9 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 	if (desc->bLength == 0)
 		goto cleanup;
 
+	/* The pointer is not NULL when we resume from hibernation */
+	if (input_device->hid_desc != NULL)
+		kfree(input_device->hid_desc);
 	input_device->hid_desc = kmemdup(desc, desc->bLength, GFP_ATOMIC);
 
 	if (!input_device->hid_desc)
@@ -203,6 +206,9 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 		goto cleanup;
 	}
 
+	/* The pointer is not NULL when we resume from hibernation */
+	if (input_device->report_desc != NULL)
+		kfree(input_device->report_desc);
 	input_device->report_desc = kzalloc(input_device->report_desc_size,
 					  GFP_ATOMIC);
 
@@ -342,6 +348,8 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 	struct mousevsc_prt_msg *request;
 	struct mousevsc_prt_msg *response;
 
+	reinit_completion(&input_dev->wait_event);
+
 	request = &input_dev->protocol_req;
 	memset(request, 0, sizeof(struct mousevsc_prt_msg));
 
@@ -541,6 +549,30 @@ static int mousevsc_remove(struct hv_device *dev)
 	return 0;
 }
 
+static int mousevsc_suspend(struct hv_device *dev)
+{
+	vmbus_close(dev->channel);
+
+	return 0;
+}
+
+static int mousevsc_resume(struct hv_device *dev)
+{
+	int ret;
+
+	ret = vmbus_open(dev->channel,
+			 INPUTVSC_SEND_RING_BUFFER_SIZE,
+			 INPUTVSC_RECV_RING_BUFFER_SIZE,
+			 NULL, 0,
+			 mousevsc_on_channel_callback,
+			 dev);
+	if (ret)
+		return ret;
+
+	ret = mousevsc_connect_to_vsp(dev);
+	return ret;
+}
+
 static const struct hv_vmbus_device_id id_table[] = {
 	/* Mouse guid */
 	{ HV_MOUSE_GUID, },
@@ -554,6 +586,8 @@ static struct  hv_driver mousevsc_drv = {
 	.id_table = id_table,
 	.probe = mousevsc_probe,
 	.remove = mousevsc_remove,
+	.suspend = mousevsc_suspend,
+	.resume = mousevsc_resume,
 	.driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
-- 
2.19.1

