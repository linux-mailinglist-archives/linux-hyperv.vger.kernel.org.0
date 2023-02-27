Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30486A4743
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Feb 2023 17:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjB0QtW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 Feb 2023 11:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0QtV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 Feb 2023 11:49:21 -0500
Received: from BN6PR00CU002-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11021022.outbound.protection.outlook.com [52.101.57.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEED4C64F;
        Mon, 27 Feb 2023 08:49:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMLciWaEtZ+xbiNQdGgVQBQebaOcDH3BHM+T1p3pLH0BJAb6iHJJQMDmIHrO2VsGUrxb6RfbdkvGSEN7vprIctfz+VHMhBDmxALqEsAI8PdFXflSCz6WiOsMQUtKcn7QMc0QfPcObl/HDcK7KuIGXLPn2TO5Xcj6cupOi2NIYmczf1s3JIiQQEVdDo/071cUeAb6ULPqt7CA1S5YQy0F+ztqZFv1DF+wvb65EnsIiMYSBdX5Kajqhtwj3XQm+k03nSOGgcjL7XqNEpPRViEzZggzZT/RA+TH+Lr0+1qZx75XYwv2GSIZwlXu4MNxeMFehaeRkKOana2xNMOFHOmURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2dWn6v/H7vna7dpcQ0pLqdkbSVui02sL6eky1FotQM=;
 b=RpSwTXtlH28MgvEIMrwGPh4LiEzlUbTrqlgzJuw7iSc0r4j1a9k8vdiV0GLAzRlZQxYlco9LpZlQau69b/s2HLte5lxyuahtiz+go0v9ZxNH4xfeDsCtGfIuOWT84zBadLV+Cq/zdU1WUW3r+WX0oOXrRCzmood6786K8Coewvv5aCjooS4i746zwa2mwkNhgy6V/tnWo79siqPweg1sxadzXYNF2i03+w3RMlbR64BcCbkOfM9Rt0rBi5zhhaF7Fmqo1RYKsakjJKJcNkZUPl+KEyH8p+Pf04qJdyWYKTvyiqq1e9ujNIqCiRLloQg8njXfZkApz9eK1MQDOGOs9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2dWn6v/H7vna7dpcQ0pLqdkbSVui02sL6eky1FotQM=;
 b=bLRilD8jnYLfHD//CC/TgJAf/k47xzd1V/ykMGV0uiZ14dlO/wc3jkTatwdfunsxmDKPVSj0aH44qxV3ohVrcVwP/iE+HyxauT1tvTY+Mp88RPUD5PfE9FUrWHNHlQovRanwHlGXCzLltL8FRqavjPTf24LO0pt6ODGSlGQDfoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by PH0PR21MB2079.namprd21.prod.outlook.com (2603:10b6:510:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.4; Mon, 27 Feb
 2023 16:49:16 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::caf1:81fb:4297:bf17]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::caf1:81fb:4297:bf17%7]) with mapi id 15.20.6178.004; Mon, 27 Feb 2023
 16:49:16 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] scsi: storvsc: Handle BlockSize change in Hyper-V VHD/VHDX file
Date:   Mon, 27 Feb 2023 08:48:34 -0800
Message-Id: <1677516514-86060-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:303:6b::22) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|PH0PR21MB2079:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ec4f80-ff97-4fdb-006c-08db18e29042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dk9Vf3osD0OIcVngO0dpMPr3cmS0PCR1megyxF5mkxbsmNV3dqylzF1B7AO0xI2P/gfbe27QxNWG5bSGDSSfDOGNqBO1tx2wqzCtcvsUPBdsl0pewzAA13ogpw0e1lnBYBg9TXm74oHCS4aig+V+fZcKi42HbcSIrkwor1EP1dkUx0I9Vk0ux5DFETLqXbCbMUJnCTO4fz77JjxdGxRq9sWBXbbkk8vbflkxI27U1nOTfQg/Aa5UqWlrxAKOWpEX6nnyNjX5dy7TuaoMDr/gnVOfak67X7wJRNDD1V/nseyb8KZoQTio/ecFGdze141VdFOgVN4D0fzOyMeu/oJRTA552c3R3P5eg2qN3xOIQtm+utoVUqWnJoNJnHiiMOKHunLQkMngTEZifPCkm/pL82M4vXsXaaQ36AunpVls/wEHyhco+Wv88zg6cIgCV9KAsBSe8mz80YWRxxOqkH6p4khXxoJOW85I84yUzTyC6M7q3pJF8Rky5p2vr8np/jXaLRD1bo0GFEakX2HbdpD8FIPwRp6PqUQbV4KiFy2khuTN+4KjvQtl7nfJ3ey6dfrzKjHUv0B1B6YAFI9M9+RmmtiUeCB+10ig2t0c3fui5STdUN+lszQpp6cfgrWMgvoDCl3vm8m4qO+eEgiPzCmUwlulMJjEhRSZLCAZuiGXDq83iOi3pHskNHAQqwvgMtmJ+G3+KB5SH54V4Okwob+RZ2l5HsGVcoI/4ywJJ4B0nfxBF/9qxltADbFBpGc8yc6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199018)(38350700002)(38100700002)(82950400001)(82960400001)(83380400001)(316002)(8936002)(41300700001)(66476007)(2906002)(6512007)(66946007)(4326008)(8676002)(66556008)(5660300002)(52116002)(10290500003)(478600001)(6506007)(26005)(2616005)(6666004)(107886003)(186003)(6486002)(36756003)(86362001)(66899018);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0a/oi/BGp3VTGM4yAh6ycVN8u59W/GqwsRFrL5VC7ieaMWmHnn88ggQOYLfV?=
 =?us-ascii?Q?nyV0Mv+hRnyL1OwyTttdle6/6PDsnETs8AU5RqTchG5vw7T5w0GD65ytpsY/?=
 =?us-ascii?Q?C7umE8VS/yL5q59eZe/VWiFpMPLyvl4Uy25ZitrHpeehDCC5MguX+CJiLZ4O?=
 =?us-ascii?Q?TlfYmtfazLotLZJ1l76tGKY8PaqVgU7ONlwpDt+9Z9p/drLABeECDwTerUMO?=
 =?us-ascii?Q?U8GL6U+tnAJZF04GFkAuRNenGiWznfyJWPvTxpFjZyfG63hFGa7IKcRMS0xs?=
 =?us-ascii?Q?aNJxUI/SCt/RM2KQP3+iUtHE3w8oApQu49QwZx7yrnFel1Iui1oEVqLv05mi?=
 =?us-ascii?Q?ix4ZSpj5YY7F5C2uK34vewpkwM5/giTxr9zSBpCbOXRT+YfEgF3syNmooeN5?=
 =?us-ascii?Q?+M4frsnqqnmJ0aRect3m7ssUE/Fwicof7GFmAUEH68Iue9Jsx+JsxiAL82CI?=
 =?us-ascii?Q?wj8niKs1dxUgdB+FRxZQ91BD+Vy7NzMUgnzeW0GSzm+xbdtcDZz5iIt9Jq+x?=
 =?us-ascii?Q?J8PX+3FtlS8Ncjf6AGhyHQicxOMKwaqlAlzaFMtEN2HzF5dlXBAPCYaF93tu?=
 =?us-ascii?Q?WCaQ7+HDNlyUJfEuEK4deZBBU6S/zjner4RlxNrZ53SPqP77EW/mz6zxVHTM?=
 =?us-ascii?Q?DgopnfARqYHCFGkJKP3kuP4qKf1dxvjCSCtHFtTXXmJ+c2oEPe9CDCXB73eY?=
 =?us-ascii?Q?lDW/Nc+LUbGdyHx+Cgg+M+CskUvUL8+RS+aUIABSQ+WDa2s6pQ2opYydJoYc?=
 =?us-ascii?Q?kmELxV3WTgq6L3KeLwqpuCNvAn11z0wQAiYRfmNaWxl8EOy7H1v1AStViA51?=
 =?us-ascii?Q?CKAulBqMK9lINv5h4zhNcJErTgiOCz9JuSt6oNlMeHZbB+ru6LaHoprmijcQ?=
 =?us-ascii?Q?lFyWbzFWxKmNDKb9KzYIR3qaeZr2AUG1p6BNBK0Kdb8zguCVc7VGShAdaoR0?=
 =?us-ascii?Q?hUvMc3ajlJ4oMmrETtUeQvT4FXliIFy13Wyo35HuWH3zMJOXmfkUm9AifBW5?=
 =?us-ascii?Q?e9ee7m5umQbdEg7diBatYpbeFACUuDjNKR8LAqpJJ/hzeyYh/jNAO0qcLbP8?=
 =?us-ascii?Q?tmdOlVZ+euTdjhDSiR901m3Vt60Cyz4VMAAFas9hwiVSJffal5/jzgH3uqUF?=
 =?us-ascii?Q?npuicDrNmd7Ob9Dt2V/cbPLyKxdmdtyb+TuKBZBbioh2Ot1QjuK+bWRiwPlY?=
 =?us-ascii?Q?1vWxnRc9IImf7GuhxAJ9hLVGt/YpG3NDQNLG/yGOxEC1P+lAosnSqyiDJwS6?=
 =?us-ascii?Q?MWjiK6pyY4ReZHBOmKiuyVCHszLFUb1si6f3C957qAJ60B/I70m4ZhdktP6/?=
 =?us-ascii?Q?g6PW3AMAXG8Fw/JHVPmCv2s/X3is9xUiE+kSP25gqkowz5SRd9TTzjCfYHfa?=
 =?us-ascii?Q?AWyLwHB8BBMZKxdZ7nn1kU5PTutUXdlqCAkVb80Aj764BgYhKNzplcpmU8Xa?=
 =?us-ascii?Q?D4PzeK7BdpP4yucSEnwO5BcnvgkN961SNl6mNTXRjYt4hp7jK+64hJRS+LJn?=
 =?us-ascii?Q?5SfTWBAwcy/IUEDtHhKlJk4yzK2+TcfsRqVWRsduzreQMqA8jPm/wH+ASDDm?=
 =?us-ascii?Q?BFbO9kxAA/enpvcng5TjcNcbyQwveGs8/NilQja23YPNGH0AjoOlrhlx311x?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ec4f80-ff97-4fdb-006c-08db18e29042
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 16:49:16.6695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2s6Rpw6K9TZpsRqbF/xHN1vD1l6iXDYC4rbjMqsiQbT7Y37vjFWoWtyRcQqNzWyEqY0vM7BB/93N/M0lqOcV4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB2079
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V uses a VHD or VHDX file on the host as the underlying storage for
a virtual disk.  The VHD/VHDX file format is a sparse format where real
disk space on the host is assigned in chunks that the VHD/VHDX file
format calls the BlockSize.  This BlockSize is not to be confused with
the 512-byte (or 4096-byte) sector size of the underlying storage device.
The default block size for a new VHD/VHDX file is 32 Mbytes.  When a
guest VM touches any disk space within a 32 Mbyte chunk of the VHD/VHDX
file, Hyper-V allocates 32 Mbytes of real disk space for that section of
the VHD/VHDX. Similiarly, if a discard operation is done that covers an
entire 32 Mbyte chunk, Hyper-V will free the real disk space for that
portion of the VHD/VHDX.  This BlockSize is surfaced in Linux as the
"discard_granularity" in /sys/block/sd<x>/queue, which makes sense.

Hyper-V also has differencing disks that can overlay a VHD/VHDX file to
capture changes to the VHD/VHDX while preserving the original VHD/VHDX.
One example of this differencing functionality is for VM snapshots.
When a snapshot is created, a differencing disk is created.  If the
snapshot is rolled back, Hyper-V can just delete the differencing disk,
and the VM will see the original disk contents at the time the snapshot
was taken. Differencing disks are used in other scenarios as well.

The BlockSize for a differencing disk defaults to 2 Mbytes, not 32 Mbytes.
The smaller default is used because changes to differencing disks are
typically scattered all over, and Hyper-V doesn't want to allocate 32
Mbytes of real disk space for a stray write here or there.  The smaller
BlockSize provides more efficient use of real disk space.

When a differencing disk is added to a VHD/VHDX, Hyper-V reports
UNIT_ATTENTION with a sense code indicating "Operating parameters have
changed", because the value of discard_granularity should be changed to
2 Mbytes. When the differencing disk is removed, discard_granularity
should be changed back to 32 Mbytes.  However, current code simply
reports a message from scsi_report_sense() and the value of
/sys/block/sd<x>/queue/discard_granularity is not updated. The message
isn't very actionable by a sysadmin.

Fix this by having the storvsc driver check for the sense code indicating
that the underly VHD/VHDX block size has changed, and do a rescan of the
device to pick up the new discard_granularity.  With this change the
entire transition to/from differencing disks is handled automatically
and transparently, with no confusing messages being output.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index d7a84c0..e79002d 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -988,6 +988,22 @@ static void storvsc_handle_error(struct vmscsi_request *vm_srb,
 			}
 
 			/*
+			 * Check for "Operating parameters have changed"
+			 * due to Hyper-V changing the VHD/VHDX BlockSize
+			 * when adding/removing a differencing disk. This
+			 * causes discard_granularity to change, so do a
+			 * rescan to pick up the new granularity. We don't
+			 * want scsi_report_sense() to output a message
+			 * that a sysadmin wouldn't know what to do with.
+			 */
+			if ((asc == 0x3f) && (ascq != 0x03) &&
+					(ascq != 0x0e)) {
+				process_err_fn = storvsc_device_scan;
+				set_host_byte(scmnd, DID_REQUEUE);
+				goto do_work;
+			}
+
+			/*
 			 * Otherwise, let upper layer deal with the
 			 * error when sense message is present
 			 */
-- 
1.8.3.1

