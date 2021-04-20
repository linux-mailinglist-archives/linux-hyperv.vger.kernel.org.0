Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8236D36519A
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Apr 2021 06:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhDTEtM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Apr 2021 00:49:12 -0400
Received: from mail-bn8nam11on2139.outbound.protection.outlook.com ([40.107.236.139]:18529
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229563AbhDTEtL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Apr 2021 00:49:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5S9Nh/aKn/UWqayy+RKzF3o75wnJ+1FeDNjZ1KRt4B/VmnlrT0QNZwJsbxbfjaEJuSRenFR/NDFsftpPC4PRPUUoOXeXahr3NyNLGRxMM39nnpWlBSe6NaO4zrvQGtqwPj69LZSGUq79ZTV2IBQ8sLg8cQ9SRk1o70Q3qFW6ngerH+Os1X8R/1z52upIOq085xuT0XLcII8xMZS69NkmWwOAbzJSKrJr8fm0BdxXdGIxgrwJeeJrUh7bOca3s1ZU391mUxwHkIMoqfqxJLc7BpnhdX7h0FriE9/fjHVzoq9wWxaY/Rg2yuYyEQATHzxqyReBLe/w8CjWLsuSRabjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMz43/A7bcE+aM643Ot97R622BivB6nYyxRnveWnESw=;
 b=PrIFaeQs3B3z0cvb7kTX0n5XG8ZJL2BBRJ0sBfGVsw1M2CYh2zlW2hc5M0jb/9jOoQEaY6C6nf6IFVqsmGJA9w1aLvAT5umwxtx/83zuZOYPGqACnklQg0RaZr31kxHwgyDwGu0NpRsFs4GDCF1OCfnUkm4kBDcIGFs/ET4VFJKctzvHaDQuYLzZ0/6nSsttLYARidmSJv30mIPxL/vsrXR5kpm+tc9+Q6RjgEqCHO52qvfplEum6e4N9iOOpk6Uw2CcRyTRBe6PLpQlscF6UXnf5gqnIC8OydpnslHlV+CSnpFMUOExYK9ckB9+BD/y1ZNHlz6SzFG7xau18V7tqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMz43/A7bcE+aM643Ot97R622BivB6nYyxRnveWnESw=;
 b=f9z/T9ebN0x21xJ+CpBm40tKxgaASvBR+PL63ORi2sf1iDlFVS6b9pjQtT0fBBTd4pUPh2ckFMm/fb8LaxRq22a5dzhOnyhS3gDUMAE6t2t07+u1mYr4HddJfhHeU1ivpL+aA9EKGr/Xr/9/BtBCL88Qx2lv7Ca0lNCAEJQ+X3M=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from BY5PR21MB1508.namprd21.prod.outlook.com (2603:10b6:a03:23a::12)
 by BY5PR21MB1395.namprd21.prod.outlook.com (2603:10b6:a03:238::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.2; Tue, 20 Apr
 2021 04:48:37 +0000
Received: from BY5PR21MB1508.namprd21.prod.outlook.com
 ([fe80::70b5:c3aa:34a6:f7d2]) by BY5PR21MB1508.namprd21.prod.outlook.com
 ([fe80::70b5:c3aa:34a6:f7d2%6]) with mapi id 15.20.4087.014; Tue, 20 Apr 2021
 04:48:37 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, vkuznets@redhat.com,
        decui@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v2 1/1] Drivers: hv: vmbus: Increase wait time for VMbus unload
Date:   Mon, 19 Apr 2021 21:48:09 -0700
Message-Id: <1618894089-126662-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [167.220.2.144]
X-ClientProxiedBy: MWHPR08CA0041.namprd08.prod.outlook.com
 (2603:10b6:300:c0::15) To BY5PR21MB1508.namprd21.prod.outlook.com
 (2603:10b6:a03:23a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (167.220.2.144) by MWHPR08CA0041.namprd08.prod.outlook.com (2603:10b6:300:c0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 04:48:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66c32c93-beaf-4222-9295-08d903b78fa2
X-MS-TrafficTypeDiagnostic: BY5PR21MB1395:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BY5PR21MB13951104D408A2D95DAE7DFBD7489@BY5PR21MB1395.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7T2AArh2ttt9PZIrFGSnibVjwk9KGUitn1JfJEOAIGbsmpIP3B+QgYDpDy9JBI8m2qU3JffPnavj5Kj7POVNWuy6h4tZai0G+zGBwfYwI8jRE+/WBqNZfW2Mn0HnVxV6tq+t2x7PDBvjJqKrkIM7agwhgZMDisXv39s8a6dMMOBZ8wdxRWRD3uz9glVnGroxtgvNgrxYOVBcr11BzMEa6vb6DVFp0JeP2iQwfO8zr+BXtqr2kgsdlNAqYLLYrEuDppmzpo4G9Q25HYkpeCzMDelhmiMBicOHAjqQ0eSal0RXpBB2XY16YGf+vKXQ+MDwHZnPo+NWWUsEVAsFDbP1wiznvU95QJ1OoC1dV//xBaWa4YU/tJoQhR3ZfPcTH+FkfwotFN/9+ZQKul4S3r7o8L9Bp7nFUhE0qjAv8LHsr4/6YLbTdPoqlPVUGa/CNpxtwhqrOSg8cSt1lhTktFVWzbdXjjMRlhGEoaHvf7mXOWQsBvApasn5OtpR/59rEiy2l+rAO89DfEEVn0csPKxfAnhWxPm+2a94Py6xa1x12n2hFCFuK64ykGYfpMP6gYbSsxjxvNaOg9eAEg94WRmtt9icnUBr+WkfY+qOBhiPDZkFeRMwVxDebK1iHaCXvjjsHUWlBpj7VFnem22dh/AiEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1508.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(38350700002)(5660300002)(316002)(2616005)(66556008)(8936002)(66476007)(478600001)(2906002)(107886003)(36756003)(7696005)(66946007)(38100700002)(186003)(16526019)(83380400001)(6486002)(86362001)(10290500003)(26005)(8676002)(82960400001)(82950400001)(6666004)(956004)(52116002)(6636002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6A7fXL1z4wX9qfE11krU0B8yIK3nDh4cM10Ef7GnmohCwf0tMhyZHjhskYO5?=
 =?us-ascii?Q?cPz6rELBoA6hbDfaouUQWesOW+vTLa8FKMxWTACooeXgN1nL+Y04q+fU1vvr?=
 =?us-ascii?Q?zfxv7dNua77s4uyNmEEji84jYcNouwK2S7I3aZMw2S1R1CTRoF17IoQMOrWJ?=
 =?us-ascii?Q?CiFRx+QFKaRBuNXCvbjuq7ExajrzY10TTPcW6xU+hvRuc5t7QbE7wd35Cquc?=
 =?us-ascii?Q?9VxfSxnVVq5xoCtN4S/0tgWR8mb1B78b9a2Prcx+APuxSmlInJ2oWIbrJxPi?=
 =?us-ascii?Q?OFi7DL9deK2SDFLG0kx9RaPvIzQ0DakKamNL6muGyNYXt7oBe0JHQ6X3bMUe?=
 =?us-ascii?Q?nydKOC9a/F7BbClw+BC2OVS5UwCI8Euad+/IvBVA2vbqafWy2MxCWbV72yF+?=
 =?us-ascii?Q?qoiKm5x76EgwM3XPDIaJ2rwYO9ACyQMnzb+UM3NZRaX8LnX6Ec5c89cFWuQr?=
 =?us-ascii?Q?dv5zxcSkQVqrz8F+4S7EgGJn3fy8QhgrxXCGyeCyy/pg9MrASg/ZfEyehnUW?=
 =?us-ascii?Q?Ab2k2N8arc4Dx+aKPouDjBVTVxlDD5FDotEKYS56sfQedyqinYrtqVDHfrJR?=
 =?us-ascii?Q?CMYUA/CuQddi4OEj7lX1oi9MPljjWH5nqsU/KAMghOa96wWXjz4KrhUc1WWT?=
 =?us-ascii?Q?YHvd8Hd8WiVuS+RVTH7tiZyjLFt/HbmS0OKP72KgQaOEk76snENJdfv21M4y?=
 =?us-ascii?Q?eA9Zzg+PIvz8FopfM1t9odv+UFUtIEu45KYpAFUoI67Stfm0QcUqOVPBzhN2?=
 =?us-ascii?Q?PFs18LOon/+gA4gG5S0sL1n1Xcx08wGYslkKmQwbMxdOsxmx0nlPBvm8SiLf?=
 =?us-ascii?Q?R/oOaIQQA+YpiHQZ58WHVw8Zvsxqnvu70AU9V2EW5Vqec4N1UuCQx/7a/3QI?=
 =?us-ascii?Q?drdcEgpCaO12/Q1VH66k/S3u7lM8fNnmHMdJ2hQ+1Dems63rMqa7nS1/RABP?=
 =?us-ascii?Q?HnO6jt5ABctPTThOyaZMnEvbGhwrS9fq4uH1RLcUtFmmFEY5ocN1/a3RnKSu?=
 =?us-ascii?Q?MTqFsUuoB+R7F4yaehID298Pitffk3NsAh+m25EfWapX+c0KqqTiPGLDokVE?=
 =?us-ascii?Q?PTY6brrGv3GHrqALPy5f44efiOXKhgboU09rj5j1FLH/nmlRjqsU1sZX8fw4?=
 =?us-ascii?Q?bl/gbqfLBCaEUy/u0swvuRKTvy6zX/Dlp3DZMUcWoUMRzSE1sniZGEpNe5FY?=
 =?us-ascii?Q?AfNaFMmzcQityTzgF0TZdqxvn/bNVDMAGeaZs3qiHXBC0xwFK3qkFfqxVsyZ?=
 =?us-ascii?Q?EXHziMcoIVLIbNrfPWnpNtzeN8dGgZjIh1tkdlctbCxRDmyMNh84mQQIdpoi?=
 =?us-ascii?Q?XXSTWXHlrEyOHIdATC9vm2Bn?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c32c93-beaf-4222-9295-08d903b78fa2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1508.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 04:48:37.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLCiEqYf+TMz4szj3mwLAgMbcqFsdmuOGwIfPqDsyJIZ1sXbQ9DRbVlQk/vS4wakVlVa1+1EB/Oy+QEP0zyfmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1395
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When running in Azure, disks may be connected to a Linux VM with
read/write caching enabled. If a VM panics and issues a VMbus
UNLOAD request to Hyper-V, the response is delayed until all dirty
data in the disk cache is flushed.  In extreme cases, this flushing
can take 10's of seconds, depending on the disk speed and the amount
of dirty data. If kdump is configured for the VM, the current 10 second
timeout in vmbus_wait_for_unload() may be exceeded, and the UNLOAD
complete message may arrive well after the kdump kernel is already
running, causing problems.  Note that no problem occurs if kdump is
not enabled because Hyper-V waits for the cache flush before doing
a reboot through the BIOS/UEFI code.

Fix this problem by increasing the timeout in vmbus_wait_for_unload()
to 100 seconds. Also output periodic messages so that if anyone is
watching the serial console, they won't think the VM is completely
hung.

Fixes: 911e1987efc8 ("Drivers: hv: vmbus: Add timeout to vmbus_wait_for_unload")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---

Changed in v2: Fixed silly error in the argument to mdelay()

---
 drivers/hv/channel_mgmt.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index f3cf4af..ef4685c 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -755,6 +755,12 @@ static void init_vp_index(struct vmbus_channel *channel)
 	free_cpumask_var(available_mask);
 }
 
+#define UNLOAD_DELAY_UNIT_MS	10		/* 10 milliseconds */
+#define UNLOAD_WAIT_MS		(100*1000)	/* 100 seconds */
+#define UNLOAD_WAIT_LOOPS	(UNLOAD_WAIT_MS/UNLOAD_DELAY_UNIT_MS)
+#define UNLOAD_MSG_MS		(5*1000)	/* Every 5 seconds */
+#define UNLOAD_MSG_LOOPS	(UNLOAD_MSG_MS/UNLOAD_DELAY_UNIT_MS)
+
 static void vmbus_wait_for_unload(void)
 {
 	int cpu;
@@ -772,12 +778,17 @@ static void vmbus_wait_for_unload(void)
 	 * vmbus_connection.unload_event. If not, the last thing we can do is
 	 * read message pages for all CPUs directly.
 	 *
-	 * Wait no more than 10 seconds so that the panic path can't get
-	 * hung forever in case the response message isn't seen.
+	 * Wait up to 100 seconds since an Azure host must writeback any dirty
+	 * data in its disk cache before the VMbus UNLOAD request will
+	 * complete. This flushing has been empirically observed to take up
+	 * to 50 seconds in cases with a lot of dirty data, so allow additional
+	 * leeway and for inaccuracies in mdelay(). But eventually time out so
+	 * that the panic path can't get hung forever in case the response
+	 * message isn't seen.
 	 */
-	for (i = 0; i < 1000; i++) {
+	for (i = 1; i <= UNLOAD_WAIT_LOOPS; i++) {
 		if (completion_done(&vmbus_connection.unload_event))
-			break;
+			goto completed;
 
 		for_each_online_cpu(cpu) {
 			struct hv_per_cpu_context *hv_cpu
@@ -800,9 +811,18 @@ static void vmbus_wait_for_unload(void)
 			vmbus_signal_eom(msg, message_type);
 		}
 
-		mdelay(10);
+		/*
+		 * Give a notice periodically so someone watching the
+		 * serial output won't think it is completely hung.
+		 */
+		if (!(i % UNLOAD_MSG_LOOPS))
+			pr_notice("Waiting for VMBus UNLOAD to complete\n");
+
+		mdelay(UNLOAD_DELAY_UNIT_MS);
 	}
+	pr_err("Continuing even though VMBus UNLOAD did not complete\n");
 
+completed:
 	/*
 	 * We're crashing and already got the UNLOAD_RESPONSE, cleanup all
 	 * maybe-pending messages on all CPUs to be able to receive new
-- 
1.8.3.1

