Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB02A6232E4
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Nov 2022 19:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiKIStG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Nov 2022 13:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiKIStD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Nov 2022 13:49:03 -0500
Received: from DM6PR05CU003-vft-obe.outbound.protection.outlook.com (mail-centralusazon11023027.outbound.protection.outlook.com [52.101.64.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A1B13FBE;
        Wed,  9 Nov 2022 10:49:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdiM1pSw9/str7u2RkGxIqyk3g2bdO6WWPR3HjG2tCVoImUbplNfqMY63hwjivbvExzDs/twu0lhScOfgUQHC3rAA1z4JV3/hHdhSIQ1NlIRuYfKahxjLDLnEc6PMlIcWFxFvGSqTRDPHlZM/xfLy5mda9ataIdHn7HkZ9HGIzzpIzTpLDV2TagoCiZLY10C7TRTzAo5XPbIRBPp6RrnEbtFdnf5WQOasOxHg+bYD1bbIbQf/M9adt279mNof6sAgQ/bp+E6kSQ/hO+xZEnVf0TLxYidxMy53WGR+Nhd/Cby+xArekzrXth6CErY9CAHfT0OfHuw5ox4a5k+qcEvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Frha94tKlGYEgoA+aBA+xWrCY1Dh9ooNXYKSx9Rm1WA=;
 b=duejODoIrQpFZXkfk0LiAqmvFnKPdZ6VHw3JCuceF9qh0Xul7/Nb36xJvs8XWRYqq+CsRu0lYLwwBpeTxvHGSt3xG5TlhgZiELXfZQ6bJfbo1RdZnMy20YYnGunNJ9trz7tuitf8sRXe9570emxmL6GMKMqDfQpnw0N+1XHXcCmxq/Gh8jcdCh4CxS3UBxPZi0BraoGy0zuIhK6cGeFDCiAcg2q4OyHJ7kCzCstWyBTn0VWOToBn61KizBqmDwz2V/ZVFQdf5CW9INNlrGa1dcsqjcDY1sxoOej2luPJaJGecg//8qY9UOQ4oKoqxXnL6cn4CfN/9NYu/VMwvxying==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Frha94tKlGYEgoA+aBA+xWrCY1Dh9ooNXYKSx9Rm1WA=;
 b=aNmrh5BSd0WoFVzVr/JRPNe1zvagLvqTd/M6uhSwGR94fMGEAa5BX9VUbRYlq7iGUDYYo0w795Pn9ftRoLatUpW8VQ9saqeM9R2vxpgLnOvIslVb74GLWN4NC9o3rpESwgTEG6hRylPzkU6H8d7ZTWE4SxTIEVoiHSffkhUzcCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by DS7PR21MB3055.namprd21.prod.outlook.com (2603:10b6:8:73::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.2; Wed, 9 Nov
 2022 18:49:01 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::c3e3:a6ef:232c:299b]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::c3e3:a6ef:232c:299b%7]) with mapi id 15.20.5834.002; Wed, 9 Nov 2022
 18:49:00 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] scsi: storvsc: Fix handling of srb_status and capacity change events
Date:   Wed,  9 Nov 2022 10:48:42 -0800
Message-Id: <1668019722-1983-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::24) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|DS7PR21MB3055:EE_
X-MS-Office365-Filtering-Correlation-Id: 207debd4-d4cd-4863-08cb-08dac28310e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5BswYHVaFcc+Kh+ZbCWZSZ8KRMNjLWSImiukSlMbAC9V69hSEKgD9Es6TVgF+XStOZYPo+emDYHA6te7WJjkis7Jg2+fUkfwLmbYIbFF3PrUlUXJ/AbvqeopWRRoKR2dOPosC0CrzrBkjO14TytcA+FJQcBxCQ71s9l3hQilYOA/Sj3l+tELvopeVCSj/uEUabVNNOBhA3rOzaj5aEoc89pTBDldlSZPVKBtCxgYTeHqUDf/BGWdNImVhSeje6am5ZfCVL5/kmzAJl/xRwMDi7ccxDpyqLgj4cWfzfzkLaZPCNscBkTiti2zig1fV/gwECqzSBq0Pat5gpoiGl1wmluhh10a0tmmubOTNzQCcFdHZ6F7x5MaYEi4z4k9jUrRs9mXSM/1mB4ROoD7Dfb1PTjMPDdlezGzviR8/8UrPq/eX2vDpA4jzZ4ABHLxpTJIuLvCs+lxJzUHE3oT9+IFXRz8jY7J5bJsXqGw7s8KCRWY79luw7Ee9sBeaF175vLtY7M5ksnrHUV8B90qmS/oF7v5JPYpRoLFTIBYQ3DAApV2JUFMG3Bj6f0WcxTjqL6CeZPNN0wgXq0K8QW7pqjb9QvNA2cBKPfpRX68whOE1iLJ+9VMKMPv/lddYEYrTXtDqJis9y/CuNxEEAEDF3LRPKgXL5fnkqgD69wuHr1BXK/kvZAnjLlMW8OzeTdzjg2hvJNxakbnTOSLob0z5CBtIL01sJRULzA3zzyIqiNfJpEr1hqe1KPS+DyDsLTfM2rDsQ5jntQaxZsLPBvalH2ncPk7xZkmGWPcgOVNPPX7kllJlJ95pVLX5O6tkLfeA+Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199015)(186003)(2616005)(66899015)(36756003)(6512007)(86362001)(8936002)(26005)(38350700002)(82960400001)(38100700002)(82950400001)(83380400001)(10290500003)(52116002)(6506007)(2906002)(5660300002)(66476007)(41300700001)(66946007)(4326008)(8676002)(66556008)(6486002)(107886003)(6666004)(478600001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rZ0j3jypBYXisKQgsUyulj2wCdBMSUEgjPECLJjiOSPqTLoQo5cIN0V+N0cd?=
 =?us-ascii?Q?dgOJtqEoez2wEFMedj7NuMiP6CQh4KiutAFh6OSE5pt8qCy4zSmGEEyCCk2K?=
 =?us-ascii?Q?KK/8SS6S1MaN2YJLWkTZZBN+FsRQSJGR1ADtgd6edHnGsGlyREgtidXOf1fl?=
 =?us-ascii?Q?g4hMqqlFPIdFQePebJzSugiFfeAHkEs0d3mdjX5vLHwrcL+EOfzCcUkdB+YD?=
 =?us-ascii?Q?YlaDtJfsVdMXI/F1IvZCmlQUwwRfcGQdFJ8rivOquWMfDJmYzom2BtJtup+W?=
 =?us-ascii?Q?1mb9vRDRFSyNR+73v1j2Xqyu/kQhIcr5BWAgjU1Q6Hw9vwYTI0GlLdwrzrb/?=
 =?us-ascii?Q?+/PyHAtamHuPLbLMl8Qwh2cFdcF40hZs2zBq6+UWKgkbX002StBQeB9q/Ybz?=
 =?us-ascii?Q?/3wjRqVh5acbgn1B512t1Q3kL10PUiyy6sEYHzlkDGZEevoe4EHA6SMA1wmU?=
 =?us-ascii?Q?IOKig4qF6OWIxUm+52sZQJrqryLCkheBgxrgI6iqeEuat+L1VD1EcweaQC2+?=
 =?us-ascii?Q?a6lbFYUaIcygL+KiXg/woLSYOkJ1ChzMU2hyoq5I3/Dof6xGe0XyMa+9BTEh?=
 =?us-ascii?Q?P49yaSh5y/a6j3oYUN2QpFtNKK9303cvcAejtxes2rgQV9yx1QNLIOkRZUwO?=
 =?us-ascii?Q?RbGphCWIHTW9njXXncpqYGxF4Odc8T5G8USZSYAy22wd8tylgoL2ipUf/3pn?=
 =?us-ascii?Q?WM4LrhVJEXynby9pVIlGq6JWfMN+ohEiM8YY4YwSTLsjud4SQ722l9rmxzVa?=
 =?us-ascii?Q?42UNXO0MM8Dwf1bMWf8zpS7faGXHaCBqiLQIdkrZXFyzLo95TnezUVp3VEJa?=
 =?us-ascii?Q?BrNMuBo3B6r1LQu6KEcvOt/OyF0rJjw8duivy9pXio9VY0zN8ZUu7bYmNMCa?=
 =?us-ascii?Q?PiFMsWkhzBeXt5R0hcsJ6Dx3ud3I/2yKO4ZNOTROw1uVN/goYy65noSnBAxX?=
 =?us-ascii?Q?SHMxFKk9vlpY2SJnd5CvrMcOjS3UXRTyaExeevt2acDwhLJf9e+Bnpy85aqd?=
 =?us-ascii?Q?MT+X/AUBG8MJ4emy/tnYENbYZQQWlhBQ3Sq3xQ6F9zHcBkYEjg/asQcmfmj5?=
 =?us-ascii?Q?CrJ6rH3Nfq4kbfnMQPekszTnWzobKdiisgm83SwfhlcmN898MrM4YjRCONwK?=
 =?us-ascii?Q?TrkTu96u6/rOiMPAuMPi8FV50eL3uComhGqE1Mboe/DhCdZEYQNcae+akdhL?=
 =?us-ascii?Q?gVUw9d2ODKy9umbDeLP4gdnmu8nDumC6gSyOD1a91R9OHqcu0YW+wdF+0BZb?=
 =?us-ascii?Q?Ooj6dX7A591je2WR8/TZ5ANo+DwwXL5vHUbBI72qNVf2YNQI2WxGXcvwqx5X?=
 =?us-ascii?Q?TINpkTlSQPR6SY7UgXJxaMOpKrA+nz+1l1hNfXgtpQFNfN/Ue10f3DjCCtPY?=
 =?us-ascii?Q?I16wNi4aIHzk/D35VPD7wr5vVZm5y6TgFJWl993xYZDGyA2cBZpRHJ0+U8Km?=
 =?us-ascii?Q?EpOlDOzrLvzABXwE/00clGW7jVdHKJOHefqWz9NqUTmIVkwNx5bC9EpiMuYu?=
 =?us-ascii?Q?muvaZgtyy25HeYBDZvAo8sOkrbKhxe6Fgm2Zb8sd9FluOmkRU8LLEdF4eEWv?=
 =?us-ascii?Q?9+H9MXOO1UmErQb7UYrUjjy9yfo0Nf/7r/u9EeYe?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207debd4-d4cd-4863-08cb-08dac28310e4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 18:49:00.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGW0J3b2SSFpK2EQs3pMXv7Lx9xyYyk/6PeYRbinU9qhAVvOyKCk8mqutEAvvvof6Z/PIpF6mMRZzzSK+bthOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3055
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Current handling of the srb_status is incorrect. Commit 52e1b3b3daa9
("scsi: storvsc: Correctly handle multiple flags in srb_status")
is based on srb_status being a set of flags, when in fact only the
2 high order bits are flags and the remaining 6 bits are an integer
status. Because the integer values of interest mostly look like flags,
the code actually works when treated that way.

But in the interest of correctness going forward, fix this by treating
the low 6 bits of srb_status as an integer status code. Add handling
for SRB_STATUS_INVALID_REQUEST, which was the original intent of commit
52e1b3b3daa9. Furthermore, treat the ERROR, ABORTED, and INVALID_REQUEST
srb status codes as essentially equivalent for the cases we care about.
There's no harm in doing so, and it isn't always clear which status code
current or older versions of Hyper-V report for particular conditions.

Treating the srb status codes as equivalent has the additional benefit
of ensuring that capacity change events result in an immediate rescan
so that the new size is known to Linux. Existing code checks SCSI
sense data for capacity change events when the srb status is ABORTED.
But capacity change events are also being observed when Hyper-V reports
the srb status as ERROR. Without the immediate rescan, the new size
isn't known until something else causes a rescan (such as running
fdisk to expand a partition), and in the meantime, tools such as "lsblk"
continue to report the old size.

Fixes: 52e1b3b3daa9 ("scsi: storvsc: Correctly handle multiple flags in srb_status")
Reported-by: Juan Tian <juantian@microsoft.com>
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 69 +++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index bc46721..3c5b7e4 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -303,16 +303,21 @@ enum storvsc_request_type {
 };
 
 /*
- * SRB status codes and masks; a subset of the codes used here.
+ * SRB status codes and masks. In the 8-bit field, the two high order bits
+ * are flags, while the remaining 6 bits are an integer status code.  The
+ * definitions here include only the subset of the integer status codes that
+ * are tested for in this driver.
  */
-
 #define SRB_STATUS_AUTOSENSE_VALID	0x80
 #define SRB_STATUS_QUEUE_FROZEN		0x40
-#define SRB_STATUS_INVALID_LUN	0x20
-#define SRB_STATUS_SUCCESS	0x01
-#define SRB_STATUS_ABORTED	0x02
-#define SRB_STATUS_ERROR	0x04
-#define SRB_STATUS_DATA_OVERRUN	0x12
+
+/* SRB status integer codes */
+#define SRB_STATUS_SUCCESS		0x01
+#define SRB_STATUS_ABORTED		0x02
+#define SRB_STATUS_ERROR		0x04
+#define SRB_STATUS_INVALID_REQUEST	0x06
+#define SRB_STATUS_DATA_OVERRUN		0x12
+#define SRB_STATUS_INVALID_LUN		0x20
 
 #define SRB_STATUS(status) \
 	(status & ~(SRB_STATUS_AUTOSENSE_VALID | SRB_STATUS_QUEUE_FROZEN))
@@ -969,38 +974,25 @@ static void storvsc_handle_error(struct vmscsi_request *vm_srb,
 	void (*process_err_fn)(struct work_struct *work);
 	struct hv_host_device *host_dev = shost_priv(host);
 
-	/*
-	 * In some situations, Hyper-V sets multiple bits in the
-	 * srb_status, such as ABORTED and ERROR. So process them
-	 * individually, with the most specific bits first.
-	 */
-
-	if (vm_srb->srb_status & SRB_STATUS_INVALID_LUN) {
-		set_host_byte(scmnd, DID_NO_CONNECT);
-		process_err_fn = storvsc_remove_lun;
-		goto do_work;
-	}
+	switch (SRB_STATUS(vm_srb->srb_status)) {
+	case SRB_STATUS_ERROR:
+	case SRB_STATUS_ABORTED:
+	case SRB_STATUS_INVALID_REQUEST:
+		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID) {
+			/* Check for capacity change */
+			if ((asc == 0x2a) && (ascq == 0x9)) {
+				process_err_fn = storvsc_device_scan;
+				/* Retry the I/O that triggered this. */
+				set_host_byte(scmnd, DID_REQUEUE);
+				goto do_work;
+			}
 
-	if (vm_srb->srb_status & SRB_STATUS_ABORTED) {
-		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID &&
-		    /* Capacity data has changed */
-		    (asc == 0x2a) && (ascq == 0x9)) {
-			process_err_fn = storvsc_device_scan;
 			/*
-			 * Retry the I/O that triggered this.
+			 * Otherwise, let upper layer deal with the
+			 * error when sense message is present
 			 */
-			set_host_byte(scmnd, DID_REQUEUE);
-			goto do_work;
-		}
-	}
-
-	if (vm_srb->srb_status & SRB_STATUS_ERROR) {
-		/*
-		 * Let upper layer deal with error when
-		 * sense message is present.
-		 */
-		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID)
 			return;
+		}
 
 		/*
 		 * If there is an error; offline the device since all
@@ -1023,6 +1015,13 @@ static void storvsc_handle_error(struct vmscsi_request *vm_srb,
 		default:
 			set_host_byte(scmnd, DID_ERROR);
 		}
+		return;
+
+	case SRB_STATUS_INVALID_LUN:
+		set_host_byte(scmnd, DID_NO_CONNECT);
+		process_err_fn = storvsc_remove_lun;
+		goto do_work;
+
 	}
 	return;
 
-- 
1.8.3.1

