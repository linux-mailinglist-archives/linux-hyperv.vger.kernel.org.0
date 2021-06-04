Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A6639BE7C
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jun 2021 19:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFDRXH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Jun 2021 13:23:07 -0400
Received: from mail-mw2nam08on2127.outbound.protection.outlook.com ([40.107.101.127]:19296
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229690AbhFDRXH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Jun 2021 13:23:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwZYQ/VwOQZvVJC7IwG/jrxUnjoFuPcgTFKsyYtpVIMRmscDPeqSA4DAwxJA1ygm2SYZj5SuE8pGCK5K+Eb1i9V3F6utTCXRkHXPMwJuGLwoi7oZQ4VTKqq5idO9nPgYTLgCJouQWUcQ7ufHQo6Esgl0SYqNf0atukafVGNq7dSwUq8Q0uMZ3A2eK9BdTZl1kzKd7FoyadHVUYb/whuUm6HI57iMqY75ZfgyrefBCOxETsgPk56dWMLlZmqf3RfFVfg/VQ434ZIyMW3UsSG2SB9angJQ3PkzszxU9zBhEKW6NZ9ApN6HC5YPeIkFkDSaDsgWByql+nvE3+kA60dLzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZuHQNdNcN6DuCV27VUBpQsCYnsSVs6U9q1ufy1MyTU=;
 b=AvLOwwpQNLNBMRyek8CMXSu+gkR+l/DcG7iR+PB4t/5RzY12Q/BPiSAu3ioKw8K57A+OYySDK5B+Vf7iV348TV41riC4fjCIdf23DlUUjITEqtstuZAgrb6jYFX/mhS61SiDnTCLsnfkc/3I3PoL93um6rE61VSGtFMO3ypmf50On92c22a7y7xfxM/U3te+MT482HiBpYhPCmv3whvdphiLdBdBKbv8sqmyFLlV4mBKYNclXDr/f4vfN7NQz5id3nQE95ZktRWmVsU1a7Q2F0CgNebxqDa7Xquz5O9YKD7QwOnWyCIj/P3j8nKGSwWPu0vqZUBINbyKBDfuP+m0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZuHQNdNcN6DuCV27VUBpQsCYnsSVs6U9q1ufy1MyTU=;
 b=LCZCv/ON5h2hVwB5iIvLkM8jxhhPSLyXRHMXF/2f2Uu0zpdvk6bppWnGCzv5dvEaxnkg/+Mq3grHQFyYIpceizc0wFIS1nXMhGHI62b1wV8PewuQxkUqM/9YRev+zAKqk0r/Zn6SH9cmzJFVuFjbL0iTQvowHcDAsOn1iUW5rPY=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB1111.namprd21.prod.outlook.com (2603:10b6:4:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9; Fri, 4 Jun
 2021 17:21:19 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588%6]) with mapi id 15.20.4219.012; Fri, 4 Jun 2021
 17:21:18 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, jejb@linux.ibm.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/3] scsi: storvsc: Miscellaneous code cleanups
Date:   Fri,  4 Jun 2021 10:21:01 -0700
Message-Id: <1622827263-12516-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [131.107.160.144]
X-ClientProxiedBy: MWHPR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:300:6c::14) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.160.144) by MWHPR04CA0052.namprd04.prod.outlook.com (2603:10b6:300:6c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Fri, 4 Jun 2021 17:21:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45711ae1-dc2e-432a-c90e-08d9277d2a7a
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1111:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB1111DBC9F609172939A2C9BFD73B9@DM5PR2101MB1111.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dH6xzKdcaP6/zjw+DRpmMcn6DSjkuaJ9x4eOfMbgQkUWU32r2otzYkOi6hxmKr+EEHGYWJdAytV9jji8DxP2wX7eXW4pTqCK2hr90YuK5gyebXJbHr7dQzyl/Rr4vdyhPzvCTgt7Van1RVuJ/H26RPM3L9XG2cyGLdTIiy2JSZJMR145pFz2XKrVQ4f+qLo9Y19tUXmwYg15UvyXQBr7da887fiKFBwUmJw5YCk52Og22p9Iw8pP4a7oJ7801YaKSJqBGL6uRFynS5e1SQ5B0ZGvM+j8MNtm1i2LCnnz9iCckuYeKItAhG9+J1dO+R7yMnS2e8cqVByih6yS86jsxZ7u8tT1jVUvpVb8SGeDmMl3onLztLT3Bd7e02Masb6HSdKeJdzX+9ywXt0cRPIfnoAAqAHNNxuOYvsTIJvH+d6j7opifrUoeeMH5tkplFUZ/WRdM2kSTXAJ8H1QMYiCMIcHfrWGTHKo8bOjiJGUf3g3YxN0hBM73keKjCDvspl6w/F5+9pIbAG3xN7rBMVTdKusW1889rvAiTdGXHRnGldIE6RAEGn6m+D2PXUySaelwdvOQ2OmUOne+X0F/YgZpmVg7qu5Usk4I04ZS+d4nLZWnjLlFKz4oBUsUuuCFv9NqDt0EvKsIMg3L7LYW9JxH4q3Z3SR7sYf9kNBmTZc2oCnkP3X1aE49H2yO461W2GUIygoj5+CFg5MeGzaXvdVYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(6486002)(2616005)(107886003)(86362001)(478600001)(956004)(5660300002)(82960400001)(82950400001)(8936002)(36756003)(186003)(2906002)(66556008)(66946007)(66476007)(26005)(16526019)(8676002)(38350700002)(6666004)(4326008)(316002)(38100700002)(52116002)(7696005)(10290500003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ctb8Vc0iuMLhXAnH1gzHV44KMVxJBqCN7KxEOr35nRlFY3bdZT9yVrFDN+mY?=
 =?us-ascii?Q?3zG1XeAy8Dx/cWMZ28H/lbqIPoCxtFL7+xBRzyIPbSb5tsA59Z3iBnDwhQaN?=
 =?us-ascii?Q?VXNuGLqAPiw77pEbPIiRwgqO+SBoUgCQFBYGaZBlpdMXwSW6WWAUj42+C87E?=
 =?us-ascii?Q?Ya+HGIY86IKLmm494hnwte68ZeoCxG6eUMTzHuRuZIKXyJH70TmuXKFvmIzI?=
 =?us-ascii?Q?XdB662u9nlMHxrmKRExxVaDes2V0TOMBNdEMq/wxtDF11qQgZsCQek7nQCV2?=
 =?us-ascii?Q?1gWzmQ3TktSSeMOsPE5oQKECCHrzf4MI+PgfpLeVzlsJpDJUcSkdCtgkBimg?=
 =?us-ascii?Q?3dieQDOhYt9mpQTAKQsMdLZarlKFWka0jZZB/57/mOvFrCYRdGjp8MjHXvSs?=
 =?us-ascii?Q?VEqsDnkOYSuuK+dYREDhOjtqD7SSbL8qZ1Wb07NrkmrnpiwWuYokyN0stLGx?=
 =?us-ascii?Q?VZOFR+p/WxEsZdnKmFoYlKqp0FigDbzV5ul1hVFu9CwbfO8hJ6fwtA+rore4?=
 =?us-ascii?Q?rd/LabaPRGpHSzTWWIRZ5Ef6GLyH4GAUjUSclzriMdNO4ObvmxjvmPkjxqb+?=
 =?us-ascii?Q?7Ww8lykGy0tCDDRWqafXnchf7opgRt0Tb/YvNUzB4tWi84E/6Nfd/16OAwry?=
 =?us-ascii?Q?osYxQr+TUGUyThHb+HCUjqveUXS/rJ5fKVN1hFFrU3QXrmYgJsnAoNoZB7b8?=
 =?us-ascii?Q?zizhkK7N8HHnFw2UO81/y9SOKqRj4VGdne8p4He79TgEovKalYhH1z12kXq5?=
 =?us-ascii?Q?WCZiZykMyHKP7nXtUtFmkWOn4QXLTcDl+8VDK3NKrYEnWT3r1+oJqTiYxJ1D?=
 =?us-ascii?Q?avePWkmxDgQvnPjfDthKMpC0DQgpH6HN3UXO+amxHs9at/3GX7IL//40kZr9?=
 =?us-ascii?Q?SzaHHqqByxDLT2a6O2YNpkMVr1NI2fQm0OiJJfRNyYKPZJl+0wuheNP+vjse?=
 =?us-ascii?Q?Xhuhj6NoW02ECQOtMA5kCGTdvEHHF0dTeABP33jvuLupDw7pEU4yfK7AAGAR?=
 =?us-ascii?Q?zYw76yzbp38gFkK4iVbisslgLB3t8smdQjm8644XsvZZ35jV7UB7dXgl4TDu?=
 =?us-ascii?Q?7LKhCgPNT7TgSNGt+BVyt+iNxzd7sYdDrqIhX8Ak1/Vd6YGuSazRPol2/CzC?=
 =?us-ascii?Q?efFy0XfuqfXPfjHMnoiaVG30z/HFkEUHvQY9OJGHiXCTwm3MmC8t0sSZmXK4?=
 =?us-ascii?Q?xokJJqYAXfgUlSpoRESjy9eoLMavgHdYJkyPCUAnEPVdKzj1m9wNtRtjQg4E?=
 =?us-ascii?Q?GA+hrwiDz7H60DHxwu+/YvLFfJYL2nKI3dpOIcW35o8b27csePXPpla3E34y?=
 =?us-ascii?Q?GKB82WTuyVXAuN4/7lej4KLi?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45711ae1-dc2e-432a-c90e-08d9277d2a7a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 17:21:18.8035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgKDhutaSC3Krkd6lVFk05BCMoDqPkpTA9lGV0BbQtxpxru+JlgoLoA8naldqIu+a10UknqR+4/p2Texd494tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

As general cleanup and in preparation for subsequent patches:
* Use min() instead of open coding
* Use set_host_byte() and status_byte() instead of open coding
  access to scsi_status field
* Collapse nested "if" statements to reduce indentation
* Fix other indentation
* Remove extra blank lines

No functional changes.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index e6718a7..9996e8b 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1160,17 +1160,16 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 		vstor_packet->vm_srb.srb_status = SRB_STATUS_SUCCESS;
 	}
 
-
 	/* Copy over the status...etc */
 	stor_pkt->vm_srb.scsi_status = vstor_packet->vm_srb.scsi_status;
 	stor_pkt->vm_srb.srb_status = vstor_packet->vm_srb.srb_status;
 
-	/* Validate sense_info_length (from Hyper-V) */
-	if (vstor_packet->vm_srb.sense_info_length > sense_buffer_size)
-		vstor_packet->vm_srb.sense_info_length = sense_buffer_size;
-
-	stor_pkt->vm_srb.sense_info_length =
-	vstor_packet->vm_srb.sense_info_length;
+	/*
+	 * Copy over the sense_info_length, but limit to the known max
+	 * size if Hyper-V returns a bad value.
+	 */
+	stor_pkt->vm_srb.sense_info_length = min_t(u8, sense_buffer_size,
+		vstor_packet->vm_srb.sense_info_length);
 
 	if (vstor_packet->vm_srb.scsi_status != 0 ||
 	    vstor_packet->vm_srb.srb_status != SRB_STATUS_SUCCESS)
@@ -1180,33 +1179,26 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 			vstor_packet->vm_srb.scsi_status,
 			vstor_packet->vm_srb.srb_status);
 
-	if ((vstor_packet->vm_srb.scsi_status & 0xFF) == 0x02) {
-		/* CHECK_CONDITION */
-		if (vstor_packet->vm_srb.srb_status &
-			SRB_STATUS_AUTOSENSE_VALID) {
-			/* autosense data available */
-
-			storvsc_log(device, STORVSC_LOGGING_WARN,
-				"stor pkt %p autosense data valid - len %d\n",
-				request, vstor_packet->vm_srb.sense_info_length);
+	if (status_byte(vstor_packet->vm_srb.scsi_status) == CHECK_CONDITION
+	   && (vstor_packet->vm_srb.srb_status & SRB_STATUS_AUTOSENSE_VALID)) {
 
-			memcpy(request->cmd->sense_buffer,
-			       vstor_packet->vm_srb.sense_data,
-			       vstor_packet->vm_srb.sense_info_length);
+		storvsc_log(device, STORVSC_LOGGING_WARN,
+			"stor pkt %p autosense data valid - len %d\n",
+			request, vstor_packet->vm_srb.sense_info_length);
 
-		}
+		memcpy(request->cmd->sense_buffer,
+		       vstor_packet->vm_srb.sense_data,
+		       stor_pkt->vm_srb.sense_info_length);
 	}
 
 	stor_pkt->vm_srb.data_transfer_length =
-	vstor_packet->vm_srb.data_transfer_length;
+			vstor_packet->vm_srb.data_transfer_length;
 
 	storvsc_command_completion(request, stor_device);
 
 	if (atomic_dec_and_test(&stor_device->num_outstanding_req) &&
 		stor_device->drain_notify)
 		wake_up(&stor_device->waiting_to_drain);
-
-
 }
 
 static void storvsc_on_receive(struct storvsc_device *stor_device,
@@ -1675,7 +1667,7 @@ static bool storvsc_scsi_cmd_ok(struct scsi_cmnd *scmnd)
 	 * this. So, don't send it.
 	 */
 	case SET_WINDOW:
-		scmnd->result = DID_ERROR << 16;
+		set_host_byte(scmnd, DID_ERROR);
 		allowed = false;
 		break;
 	default:
-- 
1.8.3.1

