Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 064521497AB
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 Jan 2020 20:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgAYTzP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 25 Jan 2020 14:55:15 -0500
Received: from mail-dm6nam11on2132.outbound.protection.outlook.com ([40.107.223.132]:55905
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729112AbgAYTzJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 25 Jan 2020 14:55:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P13o4VPJqVlSk4sFtsdqrycXHEGVCgSVm3V9oPAzrZGbbF6r2fLHIp760/sgqJIB1kW5v8t8CY8NUFqmYrUfAO0yyKDzyD8tX9LkekgIS1ZCdeCTPaJ9rzZx3BSykamDiUKds7RuGNt95P7QSsRKRUgeiVnJPPzHGgvgFxjH3CNccLmg/4eUm0QxUrHvpQJb9HG0lCsCipCRjaYCy5RKl3EOgdiebYptku62ASMlnwwiAQjGWQFYzXpvWLxSyfjBr3LC3V29+jO/iO1eiu+5dB55iI60sDc7f7urAAR7uLdDLEiuCc9hwQE8h88nvh5nc3vNtNbvEY7HzCZRtRY2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaDGQb8jyxISkO2/2gtdGzKQLu7RexM7RjVO390RHBY=;
 b=Tep1IT9FZbv34BKTda6hqn9kA8hkz40E14PFl1hpTeOvQFmKTplYjUSWeVXLDCRjH97mxjr6xoiNrNDRVWo+mCpePhR88zcZ+v9T6efSFsem0UCMl21WzFImDlVUxjjP9NPyZjGPEdn7R0zg72G+zB6v2B2RoMxRkZDyVVX/HKoxzkNpBiGL8UagKbMcsSsEpscqLcX95J4TU9mlU2fkRk7J/Q6GJqYHK3wnsaWFBx2vYlwErIpkmXOZkdtRO1aQ89xNUawGPOlWYKSm+SmSYyGn+EA2suLCXmeXupLkHmlUUBtWeF793hkVG8DQF6Of2cdNHT7nAsWZ9OPEK9G72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaDGQb8jyxISkO2/2gtdGzKQLu7RexM7RjVO390RHBY=;
 b=KfxK/CkpS7bedItE2ytX3SOCObmG1pAD7rHXTLNydEB+xLIAiRZRyS6oaweeaB7rmLfUErJZT2NIQoaSqwfII9iSUxxNvUd6qQ2J79pAPvIDu0ahuZ4buRF2lFfsc6+F8xYUQVeq2JRggWvvOevo3tiN/R8+hp2QfGx68N1N388=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1139.namprd21.prod.outlook.com (20.179.72.138) by
 BN8PR21MB1202.namprd21.prod.outlook.com (20.179.73.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.7; Sat, 25 Jan 2020 19:55:06 +0000
Received: from BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e]) by BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e%7]) with mapi id 15.20.2686.007; Sat, 25 Jan 2020
 19:55:06 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 4/4] hv_utils: Add the support of hibernation
Date:   Sat, 25 Jan 2020 11:53:56 -0800
Message-Id: <1579982036-121722-5-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579982036-121722-1-git-send-email-decui@microsoft.com>
References: <1579982036-121722-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15)
 To BN8PR21MB1139.namprd21.prod.outlook.com (2603:10b6:408:72::10)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Sat, 25 Jan 2020 19:55:05 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8f645c3-4bb8-411d-61de-08d7a1d079af
X-MS-TrafficTypeDiagnostic: BN8PR21MB1202:|BN8PR21MB1202:|BN8PR21MB1202:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB1202D11E1C442C148E0D2649BF090@BN8PR21MB1202.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0293D40691
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(199004)(189003)(81156014)(81166006)(8936002)(478600001)(2906002)(8676002)(86362001)(6486002)(30864003)(186003)(4326008)(26005)(6506007)(36756003)(5660300002)(10290500003)(16526019)(3450700001)(52116002)(66476007)(6512007)(956004)(66946007)(2616005)(316002)(66556008)(107886003)(6666004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1202;H:BN8PR21MB1139.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ON2TNv8KuU9TIMNnD4yzD41RBIeKFVagArGZ/Y411S5LlUz0WgcCnweA2w4Mb2PWaZUpM4LD6Sme/im5hvO2JXDNVom/G8XyNMeL+tEQdMJXp8Sa+uMefonsUlbSPA0hIExA5SX7k3Iw/c8XoYdacVRFMhO+1K5TQcD7uP5rDbl6KoOrgR1l8Gzm/jR6InCSLS3J5orwQUnpVADbgC5ABQdjO3qiDVidH+afTzlgo2ZPM3bLYFJk/NI+YoflmuWL2/1oozEEU6BW7tSoSXOkoOK6hhuOIibM+zokO6F74g6sig1Omh5jZ2TDohuNQjDp7UbSm6OhDak+0sDqNrgNp1JXG+sSRk1bHwdDtnJkX58Y2uQeyGNeR5zo7jVgKMPVbWYbUZU1DBPwN0SoZeow1/VuADnhvkrvPC7T5v4XhQ9hVXISZGWNgiw+oHO/RGBz
X-MS-Exchange-AntiSpam-MessageData: ZwuiG8cXc7wsfSrtuqW28eOzk/EeHrBOHwvCQxxJ8bVWROlM0HInF9nFRv+VUIslXFBNiax/1sNDVXow6INiGfiPOX5DVQ1Ddv/re6AvEO8wBJfdKEh7aFJ7Il0T0CpsNLq8TpVw4KqbtulP6lAvZw==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f645c3-4bb8-411d-61de-08d7a1d079af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2020 19:55:06.6439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1w/XOrwVFgg6HQWjH4pH+R8GL3I0z0LVe7T6lE9ZWJcO4R0+rKUef2wIKEKa+hcFLUE2h4KJqdeT98UOsxOFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1202
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add util_pre_suspend() and util_pre_resume() for some hv_utils devices
(e.g. kvp/vss/fcopy), because they need special handling before
util_suspend() calls vmbus_close().

For kvp, all the possible pending work items should be cancelled.

For vss and fcopy, some extra clean-up needs to be done, i.e. fake a
THAW message for hv_vss_daemon and fake a CANCEL_FCOPY message for
hv_fcopy_daemon, otherwise when the VM resums back, the daemons
can end up in an inconsistent state (i.e. the file systems are
frozen but will never be thawed; the file transmitted via fcopy
may not be complete). Note: there is an extra patch for the daemons:
"Tools: hv: Reopen the devices if read() or write() returns errors",
because the hv_utils driver can not guarantee the whole transaction
finishes completely once util_suspend() starts to run (at this time,
all the userspace processes are frozen).

util_probe() disables channel->callback_event to avoid the race with
the channel callback.

Signed-off-by: Dexuan Cui <decui@microsoft.com>

---
Changes in v2:
    Handles fcopy/vss specially to avoid possible inconsistent states.

Changes in v3 (I addressed Michael's comments):
    Removed unneeded blank lines.
    Simplified the error handling logic by allocating memory earlier.
    Added a comment before util_suspend(): when we're in the function,
      all the userspace processes have been frozen.

 drivers/hv/hv_fcopy.c     | 54 +++++++++++++++++++++++++++++++++-
 drivers/hv/hv_kvp.c       | 43 +++++++++++++++++++++++++--
 drivers/hv/hv_snapshot.c  | 55 ++++++++++++++++++++++++++++++++--
 drivers/hv/hv_util.c      | 62 ++++++++++++++++++++++++++++++++++++++-
 drivers/hv/hyperv_vmbus.h |  6 ++++
 include/linux/hyperv.h    |  2 ++
 6 files changed, 216 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv_fcopy.c b/drivers/hv/hv_fcopy.c
index 08fa4a5de644..bb9ba3f7c794 100644
--- a/drivers/hv/hv_fcopy.c
+++ b/drivers/hv/hv_fcopy.c
@@ -346,9 +346,61 @@ int hv_fcopy_init(struct hv_util_service *srv)
 	return 0;
 }
 
+static void hv_fcopy_cancel_work(void)
+{
+	cancel_delayed_work_sync(&fcopy_timeout_work);
+	cancel_work_sync(&fcopy_send_work);
+}
+
+int hv_fcopy_pre_suspend(void)
+{
+	struct vmbus_channel *channel = fcopy_transaction.recv_channel;
+	struct hv_fcopy_hdr *fcopy_msg;
+
+	/*
+	 * Fake a CANCEL_FCOPY message for the user space daemon in case the
+	 * daemon is in the middle of copying some file. It doesn't matter if
+	 * there is already a message pending to be delivered to the user
+	 * space since we force fcopy_transaction.state to be HVUTIL_READY, so
+	 * the user space daemon's write() will fail with EINVAL (see
+	 * fcopy_on_msg()), and the daemon will reset the device by closing
+	 * and re-opening it.
+	 */
+	fcopy_msg = kzalloc(sizeof(*fcopy_msg), GFP_KERNEL);
+	if (!fcopy_msg)
+		return -ENOMEM;
+
+	tasklet_disable(&channel->callback_event);
+
+	fcopy_msg->operation = CANCEL_FCOPY;
+
+	hv_fcopy_cancel_work();
+
+	/* We don't care about the return value. */
+	hvutil_transport_send(hvt, fcopy_msg, sizeof(*fcopy_msg), NULL);
+
+	kfree(fcopy_msg);
+
+	fcopy_transaction.state = HVUTIL_READY;
+
+	/* tasklet_enable() will be called in hv_fcopy_pre_resume(). */
+	return 0;
+}
+
+int hv_fcopy_pre_resume(void)
+{
+	struct vmbus_channel *channel = fcopy_transaction.recv_channel;
+
+	tasklet_enable(&channel->callback_event);
+
+	return 0;
+}
+
 void hv_fcopy_deinit(void)
 {
 	fcopy_transaction.state = HVUTIL_DEVICE_DYING;
-	cancel_delayed_work_sync(&fcopy_timeout_work);
+
+	hv_fcopy_cancel_work();
+
 	hvutil_transport_destroy(hvt);
 }
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index ae7c028dc5a8..e74b144b8f3d 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -758,11 +758,50 @@ hv_kvp_init(struct hv_util_service *srv)
 	return 0;
 }
 
-void hv_kvp_deinit(void)
+static void hv_kvp_cancel_work(void)
 {
-	kvp_transaction.state = HVUTIL_DEVICE_DYING;
 	cancel_delayed_work_sync(&kvp_host_handshake_work);
 	cancel_delayed_work_sync(&kvp_timeout_work);
 	cancel_work_sync(&kvp_sendkey_work);
+}
+
+int hv_kvp_pre_suspend(void)
+{
+	struct vmbus_channel *channel = kvp_transaction.recv_channel;
+
+	tasklet_disable(&channel->callback_event);
+
+	/*
+	 * If there is a pending transtion, it's unnecessary to tell the host
+	 * that the transaction will fail, because that is implied when
+	 * util_suspend() calls vmbus_close() later.
+	 */
+	hv_kvp_cancel_work();
+
+	/*
+	 * Forece the state to READY to handle the ICMSGTYPE_NEGOTIATE message
+	 * later. The user space daemon may go out of order and its write()
+	 * may fail with EINVAL: this doesn't matter since the daemon will
+	 * reset the device by closing and re-opening it.
+	 */
+	kvp_transaction.state = HVUTIL_READY;
+	return 0;
+}
+
+int hv_kvp_pre_resume(void)
+{
+	struct vmbus_channel *channel = kvp_transaction.recv_channel;
+
+	tasklet_enable(&channel->callback_event);
+
+	return 0;
+}
+
+void hv_kvp_deinit(void)
+{
+	kvp_transaction.state = HVUTIL_DEVICE_DYING;
+
+	hv_kvp_cancel_work();
+
 	hvutil_transport_destroy(hvt);
 }
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 03b6454268b3..1c75b38f0d6d 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -379,10 +379,61 @@ hv_vss_init(struct hv_util_service *srv)
 	return 0;
 }
 
-void hv_vss_deinit(void)
+static void hv_vss_cancel_work(void)
 {
-	vss_transaction.state = HVUTIL_DEVICE_DYING;
 	cancel_delayed_work_sync(&vss_timeout_work);
 	cancel_work_sync(&vss_handle_request_work);
+}
+
+int hv_vss_pre_suspend(void)
+{
+	struct vmbus_channel *channel = vss_transaction.recv_channel;
+	struct hv_vss_msg *vss_msg;
+
+	/*
+	 * Fake a THAW message for the user space daemon in case the daemon
+	 * has frozen the file systems. It doesn't matter if there is already
+	 * a message pending to be delivered to the user space since we force
+	 * vss_transaction.state to be HVUTIL_READY, so the user space daemon's
+	 * write() will fail with EINVAL (see vss_on_msg()), and the daemon
+	 * will reset the device by closing and re-opening it.
+	 */
+	vss_msg = kzalloc(sizeof(*vss_msg), GFP_KERNEL);
+	if (!vss_msg)
+		return -ENOMEM;
+
+	tasklet_disable(&channel->callback_event);
+
+	vss_msg->vss_hdr.operation = VSS_OP_THAW;
+
+	/* Cancel any possible pending work. */
+	hv_vss_cancel_work();
+
+	/* We don't care about the return value. */
+	hvutil_transport_send(hvt, vss_msg, sizeof(*vss_msg), NULL);
+
+	kfree(vss_msg);
+
+	vss_transaction.state = HVUTIL_READY;
+
+	/* tasklet_enable() will be called in hv_vss_pre_resume(). */
+	return 0;
+}
+
+int hv_vss_pre_resume(void)
+{
+	struct vmbus_channel *channel = vss_transaction.recv_channel;
+
+	tasklet_enable(&channel->callback_event);
+
+	return 0;
+}
+
+void hv_vss_deinit(void)
+{
+	vss_transaction.state = HVUTIL_DEVICE_DYING;
+
+	hv_vss_cancel_work();
+
 	hvutil_transport_destroy(hvt);
 }
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index e07197dfb4a2..0fe5ff845d07 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -123,12 +123,14 @@ static struct hv_util_service util_shutdown = {
 };
 
 static int hv_timesync_init(struct hv_util_service *srv);
+static int hv_timesync_pre_suspend(void);
 static void hv_timesync_deinit(void);
 
 static void timesync_onchannelcallback(void *context);
 static struct hv_util_service util_timesynch = {
 	.util_cb = timesync_onchannelcallback,
 	.util_init = hv_timesync_init,
+	.util_pre_suspend = hv_timesync_pre_suspend,
 	.util_deinit = hv_timesync_deinit,
 };
 
@@ -140,18 +142,24 @@ static struct hv_util_service util_heartbeat = {
 static struct hv_util_service util_kvp = {
 	.util_cb = hv_kvp_onchannelcallback,
 	.util_init = hv_kvp_init,
+	.util_pre_suspend = hv_kvp_pre_suspend,
+	.util_pre_resume = hv_kvp_pre_resume,
 	.util_deinit = hv_kvp_deinit,
 };
 
 static struct hv_util_service util_vss = {
 	.util_cb = hv_vss_onchannelcallback,
 	.util_init = hv_vss_init,
+	.util_pre_suspend = hv_vss_pre_suspend,
+	.util_pre_resume = hv_vss_pre_resume,
 	.util_deinit = hv_vss_deinit,
 };
 
 static struct hv_util_service util_fcopy = {
 	.util_cb = hv_fcopy_onchannelcallback,
 	.util_init = hv_fcopy_init,
+	.util_pre_suspend = hv_fcopy_pre_suspend,
+	.util_pre_resume = hv_fcopy_pre_resume,
 	.util_deinit = hv_fcopy_deinit,
 };
 
@@ -521,6 +529,44 @@ static int util_remove(struct hv_device *dev)
 	return 0;
 }
 
+/*
+ * When we're in util_suspend(), all the userspace processes have been frozen
+ * (refer to hibernate() -> freeze_processes()). The userspace is thawed only
+ * after the whole resume procedure, including util_resume(), finishes.
+ */
+static int util_suspend(struct hv_device *dev)
+{
+	struct hv_util_service *srv = hv_get_drvdata(dev);
+	int ret = 0;
+
+	if (srv->util_pre_suspend) {
+		ret = srv->util_pre_suspend();
+		if (ret)
+			return ret;
+	}
+
+	vmbus_close(dev->channel);
+
+	return 0;
+}
+
+static int util_resume(struct hv_device *dev)
+{
+	struct hv_util_service *srv = hv_get_drvdata(dev);
+	int ret = 0;
+
+	if (srv->util_pre_resume) {
+		ret = srv->util_pre_resume();
+		if (ret)
+			return ret;
+	}
+
+	ret = vmbus_open(dev->channel, 4 * HV_HYP_PAGE_SIZE,
+			 4 * HV_HYP_PAGE_SIZE, NULL, 0, srv->util_cb,
+			 dev->channel);
+	return ret;
+}
+
 static const struct hv_vmbus_device_id id_table[] = {
 	/* Shutdown guid */
 	{ HV_SHUTDOWN_GUID,
@@ -557,6 +603,8 @@ static  struct hv_driver util_drv = {
 	.id_table = id_table,
 	.probe =  util_probe,
 	.remove =  util_remove,
+	.suspend = util_suspend,
+	.resume =  util_resume,
 	.driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
@@ -626,11 +674,23 @@ static int hv_timesync_init(struct hv_util_service *srv)
 	return 0;
 }
 
+static void hv_timesync_cancel_work(void)
+{
+	cancel_work_sync(&adj_time_work);
+}
+
+static int hv_timesync_pre_suspend(void)
+{
+	hv_timesync_cancel_work();
+	return 0;
+}
+
 static void hv_timesync_deinit(void)
 {
 	if (hv_ptp_clock)
 		ptp_clock_unregister(hv_ptp_clock);
-	cancel_work_sync(&adj_time_work);
+
+	hv_timesync_cancel_work();
 }
 
 static int __init init_hyperv_utils(void)
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 20edcfd3b96c..f5fa3b3c9baf 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -352,14 +352,20 @@ void vmbus_on_msg_dpc(unsigned long data);
 
 int hv_kvp_init(struct hv_util_service *srv);
 void hv_kvp_deinit(void);
+int hv_kvp_pre_suspend(void);
+int hv_kvp_pre_resume(void);
 void hv_kvp_onchannelcallback(void *context);
 
 int hv_vss_init(struct hv_util_service *srv);
 void hv_vss_deinit(void);
+int hv_vss_pre_suspend(void);
+int hv_vss_pre_resume(void);
 void hv_vss_onchannelcallback(void *context);
 
 int hv_fcopy_init(struct hv_util_service *srv);
 void hv_fcopy_deinit(void);
+int hv_fcopy_pre_suspend(void);
+int hv_fcopy_pre_resume(void);
 void hv_fcopy_onchannelcallback(void *context);
 void vmbus_initiate_unload(bool crash);
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 41c58011431e..692c89ccf5df 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1435,6 +1435,8 @@ struct hv_util_service {
 	void (*util_cb)(void *);
 	int (*util_init)(struct hv_util_service *);
 	void (*util_deinit)(void);
+	int (*util_pre_suspend)(void);
+	int (*util_pre_resume)(void);
 };
 
 struct vmbuspipe_hdr {
-- 
2.19.1

