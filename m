Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7734839BE81
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jun 2021 19:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhFDRXJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Jun 2021 13:23:09 -0400
Received: from mail-mw2nam08on2127.outbound.protection.outlook.com ([40.107.101.127]:19296
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230185AbhFDRXI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Jun 2021 13:23:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4XTuvxCBuInM9yZepcGN3ehwm+BdCBFTNvnLIdPynuX8BRSNdO5h0MEuBpB80+B06pZRFRgmBA3NwZlbG9Jj0bo6YqRycv5fsa0U99kHkNZmsrRVt8bIx/FcJJKL+wfxIabpE4pY0HLu/0H5vojDs7BJkVtCOEWNm31gopD90q71mFxkK6fw23zIEWSVy46KjyWFkvodlOxoby3IF07C7BJqoBooubPT1zoA679enHmrqRxVlpwXGDLQ3P6H2QGoCJIr2Vx1ekAap4Utb9+Wu3AkYZXCeFYk/tIL4zvR7sqE764BBweiQu0R9vHVIrZaaVYjNfhm6Vu4z6DUOy2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikvPagxwkKa5Rup2swZvXUX7cJCo2X9dx2/yGuqTMME=;
 b=lP40dP/UGE6+8dJebrFHMCXa3qflC+3PRi1g1TveUarg42s4lP7/2y6/NDg7BRkCC4pqVca5V+m1Rz8WOCPPO+Izcu9GzMhXbcp9BylDQyL1EEC9lb/d6FZbIbfLRFzW020ILZHC9u2KzZ8g1KwALM0nFcvN0qXtyCB3QpBmdweZVAcxAxJX0cdco8cR9a+EMwgjp0vGtFPUw0EfYDnDRnmrAePIOWCP6LEDldjrDb2M1s/PB92C9XK6Gbo8/xt3KYHmxAqR8Aukm/HBgtMt6y4G/tvB/VC9fbtAbIogKj9lruFDJtSQWVNZE5+wOJNt0q6+C7yp3Vt61v+6QNQNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikvPagxwkKa5Rup2swZvXUX7cJCo2X9dx2/yGuqTMME=;
 b=E7aUd4LAXICzrpQGRz1SG+XOtTyNoJtDj3Rn+OvN8IAOlY5KUbGZaedlE4hXD+CGZr2Gfs7vQ/oq5NAngUakjwE1bajjG057tiTPVlWEizAIflF+6lgqNEqy8d4FMGfE8padfh1GjVatTm1gk7cC1o3NIkeCpRZl+QpLp/cK9kg=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB1111.namprd21.prod.outlook.com (2603:10b6:4:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9; Fri, 4 Jun
 2021 17:21:20 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588%6]) with mapi id 15.20.4219.012; Fri, 4 Jun 2021
 17:21:20 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, jejb@linux.ibm.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 3/3] scsi: storvsc: Correctly handle multiple flags in srb_status
Date:   Fri,  4 Jun 2021 10:21:03 -0700
Message-Id: <1622827263-12516-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622827263-12516-1-git-send-email-mikelley@microsoft.com>
References: <1622827263-12516-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.160.144]
X-ClientProxiedBy: MWHPR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:300:6c::14) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.160.144) by MWHPR04CA0052.namprd04.prod.outlook.com (2603:10b6:300:6c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Fri, 4 Jun 2021 17:21:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1b70761-d317-4e5b-0587-08d9277d2bb6
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1111:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB11112376CF9654C0E7B1320FD73B9@DM5PR2101MB1111.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ed26oTbOdB2rliGQ7Fqhaqa605ZZNQ8IfrzFErkxcqFW8mHwoDFWntDbKFAb3/fwWABFsBtbsCf6+xxtvUMfBxMdJaMhOGzhlOLPbrkJB+1gWJkgLEwNXKoXZXnlqzNl79Mhuuxm6pWowmR+D/UKvXgHOwofB1tKdx8rMjSQrgwOvby14Wjfs9gH0Hl7lbSOcprte91rW1sfRX6oUk46cQm2/w7J3h7cNz+aKAoCGS3u45gOr2XuB9G6OrJ5uOv79s7KEGugB2IHxZWRYCoNfp+dRb/14DXEI37UggIqkR211uOPPI42BbYea39ZjRQwE5XdRgmUqehTeGUXB/BJ+zr5U9Wrs+8PVzhIJfk2HkglEFGss/uF0I2uongdy8Wy70pIAwdOL0mOM0eQFqv6YH6jrJ1BFIwW0CNwhBLieya16YbkGSPRGGj5YxmhNSvzLOxlmQU6oKnDcc3GykZtWjhLyKqKMTxqse+9cg2NvXeDF5vcJDAb7uh9MeqM9f9CzjsrZ7P9k3Ddmvcl3NM9NZBqYpeV4eUpI+MHa8KP/lJCarxWcVShrpVZjlf8PAI1WNea7qvu75npkp/vlw9QF6JMXCPkiurRPCHIL1kjskwZLLY1wIYIjtYtvtZFGQ3a4gE3HO/6rNo+eE863N6/TukivijJl2LpwVkdYpjda8/0QtuhWjGlmiwq1tQPXujKXoa9ztkSZxF9owVNlovGNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(6486002)(2616005)(107886003)(86362001)(478600001)(956004)(5660300002)(82960400001)(82950400001)(8936002)(36756003)(186003)(2906002)(66556008)(66946007)(66476007)(26005)(16526019)(8676002)(38350700002)(6666004)(4326008)(316002)(38100700002)(52116002)(7696005)(10290500003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DvWOxvdSTiJamK5n2B3hHsQeFmswBFIlWNYtysOqQ5osabF4t/X4yLLqG5v6?=
 =?us-ascii?Q?qu7irowYXjTJmVpIK7OIjK5FAPryjTIjhPOUM9hLBc2yJ/qwchJtVYkV1Qks?=
 =?us-ascii?Q?mg1SD+H+L2uSmuGc3r18UzKS/IBQZxKzIJmu8eYXu8gtkS71wyaqPKGQaM3k?=
 =?us-ascii?Q?DryOSRpgWj9kjHEdnKjGaf7e9L0wpY/Q1E4PC0TaPKTyEMTDIf+RUq7ACeK2?=
 =?us-ascii?Q?RMDtslgmBA8G/yj2aDr9mVsxdqAn4hAw10SAerqCDOeINilh5Fe8QSkMaz7J?=
 =?us-ascii?Q?xVyPcd2PHlBkHrVDLUi3A/UyAeii0ODTnG4YGESt+nzk1WGXuND76Qslp+fS?=
 =?us-ascii?Q?JVAh7mMqpODck7w+kAGD9MQz+T26sb8Qr+H/NfDdIjett6Ztde+1Uxc5U58l?=
 =?us-ascii?Q?f6s9RiuZQ3TNVUDZxvaZYJNnxhjlHon3fI9pncGcPk9V/0FCzWWFk/VuGvhs?=
 =?us-ascii?Q?j7GFyQiZlFgjUfT7CAW2IvywGgzjAPh9TICJVcFfR+OVIJqClWxH9f8itYTD?=
 =?us-ascii?Q?fGinaxJXY9JpXhdTQguZbtVTneI1TsQQiRJakUR815VFuHkfQc978JrEfeAn?=
 =?us-ascii?Q?yWXXTj4U1SDvl2CN2vfHrQ6Q0tV94+gL6IqcaV49wav7JZ7P+KN+Bcgn5AFG?=
 =?us-ascii?Q?VHn2xCdvMVOoA9o6LB62nA4qTyEL6SR4+9bSggr01JrB6D7dNWY8NPRze/R2?=
 =?us-ascii?Q?/M8zegkEXIzrBLNbr5LlelNjAjUGDp0DqLco0MBeatUeXceYFrApcN1251SH?=
 =?us-ascii?Q?mls+d0uR2aCPMUsTIWRyqgg0QiEXi+fajC7H0LAalxWxoFJbgH/+jVXntl9c?=
 =?us-ascii?Q?2hT6KJVPcQnJgQ0Fbe08dHq+mFtZE42Ju32TImBVl7jivPk3CT3rDGpkOzCx?=
 =?us-ascii?Q?hjKxuDEp/opm7rJbqmAGDvgEMdFrlFtXrGlZaFxWdVeKIY9IH484yW8m44uM?=
 =?us-ascii?Q?cpXOt43cTlYQTJe/Dao8aHx/Lus09l4q6RG7P81Zgu/QPtXxswyfyMPeDkZY?=
 =?us-ascii?Q?VUOsnhW1urguKNF37nPTGZAmBDzIcYkFg7w1B6c+tFc+SnYf/l3pM4/BPzol?=
 =?us-ascii?Q?7J+5O5jC2/URIsJc7RDZYDQnjartFwbX2ieQ4jPLtZ5V2SLKYo7KCIEPntgr?=
 =?us-ascii?Q?FFn8lfvYFRBNTrjNtFd2Nx79HgzOf1hNH6D39+QYULw5pDFEe1RkULfqAY0L?=
 =?us-ascii?Q?yxIfo+187ADPcd1Vt00euk68taaJ5uj9/G8t4UoK+pX62micMlaFb5LQleep?=
 =?us-ascii?Q?7wdEmbYalQqCw/zm3g9/pQ48XW7jfR7BaNTIwkGTp1A21DmpujL5Bdie7b2+?=
 =?us-ascii?Q?H4dOxXXNpo6eb3Y+uYalIviK?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b70761-d317-4e5b-0587-08d9277d2bb6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 17:21:20.8644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQYxqCEelw0uS1qU+/RqsxFuttqteDmTy3F/EFKT6VZ2hXvbcqQvxL0Miyj1D1Ah+6V9fsy7g1r8Vme5LOOUbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V is observed to sometimes set multiple flags in the
srb_status, such as ABORTED and ERROR. Current code in
storvsc_handle_error() handles only a single flag being set,
and does nothing when multiple flags are set.  Fix this by
changing the case statement into a series of "if" statements
testing individual flags. The functionality for handling each
flag is unchanged.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 61 +++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index fff9441..e96d2aa 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1009,17 +1009,40 @@ static void storvsc_handle_error(struct vmscsi_request *vm_srb,
 	struct storvsc_scan_work *wrk;
 	void (*process_err_fn)(struct work_struct *work);
 	struct hv_host_device *host_dev = shost_priv(host);
-	bool do_work = false;
 
-	switch (SRB_STATUS(vm_srb->srb_status)) {
-	case SRB_STATUS_ERROR:
+	/*
+	 * In some situations, Hyper-V sets multiple bits in the
+	 * srb_status, such as ABORTED and ERROR. So process them
+	 * individually, with the most specific bits first.
+	 */
+
+	if (vm_srb->srb_status & SRB_STATUS_INVALID_LUN) {
+		set_host_byte(scmnd, DID_NO_CONNECT);
+		process_err_fn = storvsc_remove_lun;
+		goto do_work;
+	}
+
+	if (vm_srb->srb_status & SRB_STATUS_ABORTED) {
+		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID &&
+		    /* Capacity data has changed */
+		    (asc == 0x2a) && (ascq == 0x9)) {
+			process_err_fn = storvsc_device_scan;
+			/*
+			 * Retry the I/O that triggered this.
+			 */
+			set_host_byte(scmnd, DID_REQUEUE);
+			goto do_work;
+		}
+	}
+
+	if (vm_srb->srb_status & SRB_STATUS_ERROR) {
 		/*
 		 * Let upper layer deal with error when
 		 * sense message is present.
 		 */
-
 		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID)
-			break;
+			return;
+
 		/*
 		 * If there is an error; offline the device since all
 		 * error recovery strategies would have already been
@@ -1032,37 +1055,19 @@ static void storvsc_handle_error(struct vmscsi_request *vm_srb,
 			set_host_byte(scmnd, DID_PASSTHROUGH);
 			break;
 		/*
-		 * On Some Windows hosts TEST_UNIT_READY command can return
-		 * SRB_STATUS_ERROR, let the upper level code deal with it
-		 * based on the sense information.
+		 * On some Hyper-V hosts TEST_UNIT_READY command can
+		 * return SRB_STATUS_ERROR. Let the upper level code
+		 * deal with it based on the sense information.
 		 */
 		case TEST_UNIT_READY:
 			break;
 		default:
 			set_host_byte(scmnd, DID_ERROR);
 		}
-		break;
-	case SRB_STATUS_INVALID_LUN:
-		set_host_byte(scmnd, DID_NO_CONNECT);
-		do_work = true;
-		process_err_fn = storvsc_remove_lun;
-		break;
-	case SRB_STATUS_ABORTED:
-		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID &&
-		    (asc == 0x2a) && (ascq == 0x9)) {
-			do_work = true;
-			process_err_fn = storvsc_device_scan;
-			/*
-			 * Retry the I/O that triggered this.
-			 */
-			set_host_byte(scmnd, DID_REQUEUE);
-		}
-		break;
 	}
+	return;
 
-	if (!do_work)
-		return;
-
+do_work:
 	/*
 	 * We need to schedule work to process this error; schedule it.
 	 */
-- 
1.8.3.1

