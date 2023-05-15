Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623877037A6
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 May 2023 19:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbjEORX3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 15 May 2023 13:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244005AbjEORXL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 May 2023 13:23:11 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020015.outbound.protection.outlook.com [52.101.61.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636E312EAE;
        Mon, 15 May 2023 10:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFVTy6/zobOp54+I4jr8uuDyEvsc/pfEzKMYvCaxtWblov5bd95zJv2xlHzwU2dnHS1YcdVEVQCZsecokRKKtEZjgl2fxynKW5kaeovk3HPe3eP0LB/0lW0yXRRTqkXmo+vMeGbcRPATh5LiPzo6TcQWIOzbJ6D+h2jh3/C0DXkIkM1HFdprGvDm3VEA68o/269Msw6y5u1Aeqq0onv9jc0Az4OagxQy/q0IGqFVdY1eX206rTC0vHKMNeAYO+nvQKzxhx5eZuBsSq1zEg5peHI2tBmgPww3ifoObQmBuDk9ez0AyrLK3jBOU3daO3ebal0INz8kC/PpuW/BJ34pBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZ/fOsFcX+O9uqydeU5x8HFjOh2HId7io+MW7vqFR/w=;
 b=ljjWcmM/ydEjkeBv4b/+XekIFUDM/Z61p+LETDPEp694lnK1/F6w+kGtU5OKEwgz4U38XLramvWbzvZmDiNrq45NZdfznVq4Zq/EQ8Sd1NjEBs2WZ6L00IdhgM25aYvEFRGhoQaK3GsUTDkzz6z/Tgw+Zhgys3dS22ZATGIanZic5oP3YEc8+TCCLjiBhLIj5Fw9dZKQlrb/4rPZa8IxSIpaiZIKhuotrj4hCkQX/TYIuv1/dAmvCRbWkELDtormrt8ZYl1JqGqoJzZWg1WTNdkz6znkdfcPJI095a8SNEaeirjT1AGwP69kKH/dKWahPsgujSQikcLCySZnOz8ukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZ/fOsFcX+O9uqydeU5x8HFjOh2HId7io+MW7vqFR/w=;
 b=I1nnApywsF2UZBouxsj8/340IkQL3iJTdlZ8w7JOgZbhehU7D0GPffT23pQE79vYJvQOMj4nKmBhRAxhzMsAiU7jBihMrOf2fJo3+qyscqzJwZEwQ6CmSpJIPHrQwVN2NMYctKb/OstkhQVXl9lNaWTalYbHj16TCWPQqR6T/Co=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by BL1PR21MB3234.namprd21.prod.outlook.com (2603:10b6:208:39a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.3; Mon, 15 May
 2023 17:21:08 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%6]) with mapi id 15.20.6433.001; Mon, 15 May 2023
 17:21:08 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     mikelley@microsoft.com, stable@vger.kernel.org
Subject: [PATCH 1/1] scsi: storvsc: Don't pass unused PFNs to Hyper-V host
Date:   Mon, 15 May 2023 10:20:41 -0700
Message-Id: <1684171241-16209-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0215.namprd15.prod.outlook.com
 (2603:10b6:930:88::8) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|BL1PR21MB3234:EE_
X-MS-Office365-Filtering-Correlation-Id: cde45c9a-5a30-45ef-f578-08db5568c562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwVWI5yvFyaEeYb/TBUgpugf3Cl+tBet5jNk+INxb/q/iZKjgYMxzxP0qJk2Py/W4FEd4B/wiWXMewPH7wHVsT25xe1yOMzIJX8oJw3A/ZxMimQgKYL/wwiVz+s8YygyfEwJ/MmcWtY84MzCV9B8qW7MxTJC3uf2+kv0PvG6W9KGsZhqlrv6sKpqzVQfU8tOQN37E0djXQgn9PYnv/2s8OyyzKIzSHbc/Uy2k14hb6psTbx0i4Si8BTAhra3+dg41H+P1eqARNHJ0Br1HGiJCd5JCzcb0ZbDl6migYW+SnNl2mw/GxFpRZb2vz+7Kr7Nl/ZyqdeEYlDftU7fDe7aPfqiqjy+dpRrL2fhHYb4atlaHYvh0hDeMg72REr7STffSPmAiop7Zyr81WuUK4yntGfdbp0+Ua9xMZnvhp9KghyYVwbTlDPKn24RDUwCe/PniYg7K0ifBC+HDpLkNoiLMjNaSBQS6FKNo9pUa2TWiWzf2ZPRBot3ceM8eFECLXy32Fw/fI3QfxxSD9SYeJRhFh9MNZaHikS1L4l2n3bo5YcwFHPk7akdrxDw6WhwTQ1ifOME0WLXETcuKINc648/syHHeXnGhF860msx4gNnBHNVFEVg7IL9drmVrq06gaZKzFqoN03jpCoh6tRM2Ke6cbBtNuAJxqndhfx6uLBqOmU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(4326008)(2616005)(2906002)(6666004)(83380400001)(52116002)(6486002)(66476007)(66946007)(66556008)(478600001)(10290500003)(8936002)(8676002)(26005)(186003)(6512007)(6506007)(5660300002)(41300700001)(786003)(316002)(86362001)(82950400001)(82960400001)(38100700002)(38350700002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NIEmsAsLQzEmB/Dq4JHHSqT4Yo2dCACwKuQQLjXwUCm0umozIXdYiaDF0TpE?=
 =?us-ascii?Q?3dboYPLuZ2NeB1gD6aM5h02YbPn46FmnvYAplEXJ5hZuEx45bFnQlcXtixRq?=
 =?us-ascii?Q?niYDRQpcw1ldAVq4Y5oW6keSO1WDiu9P/K08S6DgGu0hBAE241nnpcAIOsb6?=
 =?us-ascii?Q?XDZXdbmyi+QmmwLuFI1QEzHXFDgS7ed6RONpNm9CRRON11ZE4VB4pD4BNz6+?=
 =?us-ascii?Q?xr7iP0nixFhcXvABcqi4YOuP89kn/3sYBCHbQx5fV5E0Zj13VgVGwNG5X5Op?=
 =?us-ascii?Q?vrw86sDPeXEBwbKoyVIRwjF063Cg5awDg28rZWFbmD0olEz1VLJniR3lQND0?=
 =?us-ascii?Q?QTHO9D78UuqLmVDfd6OvD9caQDDHr5PrqFxONd+viTE0LXE4+qJvQbW5aw8W?=
 =?us-ascii?Q?IaXp3P0zVztMNowhMh7UgJlc9WMOhSz3Qz0BLTX7iAlv79/a6sR+7DWmS6b/?=
 =?us-ascii?Q?TiL4mX2vlez+k7xdZqmxVI/yKBiwyETeDyw+Z06r3bqaracYvfh5OclFM/Bu?=
 =?us-ascii?Q?ev+abrrKuLankohB+EEIji4OqLz9WCKZup+YC3PbhLogJrOg1l11OEpzH2os?=
 =?us-ascii?Q?HvL/7/f4DAEz7LKzFJoy5clxEENkJ3wwPuu7qaNC8qzsQWeKKfmGoaU4a9yb?=
 =?us-ascii?Q?AvidqCA3BcViA9mFDFeKcqklb9LTVq9ov9e+0NlYD2dGMXElwlxQ23KGQ7z6?=
 =?us-ascii?Q?H2nr+O7UUlpdTXkit9Nf1b3od7QcHny9v90skJ/GxHcqv/7A2PMJ3qiCjCMu?=
 =?us-ascii?Q?LZ+W5g2a1iPUFMNCAjj4jTTFGUXu/dJ0ZcJj6B7MPf6hIVFDG0m/8XRyunEi?=
 =?us-ascii?Q?W74RMZTdQzw+8OElVOwoilVAbxVKlek1MNb0I80DJcP0Kw5GPoje5WJdv7om?=
 =?us-ascii?Q?/qg2h8Q2rwj+LXktoxDNK9WhLJ+QTwF3P9TPbLsgohegqVoQlVo9PESHL25T?=
 =?us-ascii?Q?RZSPWL5bSamMglY+24HyAujqGubWPvenzrhk8VOJf/KsCWR/1MKe9OiJ8Gfb?=
 =?us-ascii?Q?Xy5mwPR4WkBHcDNFgxnW2jZ26ac0L1I8wvXu+EyDrAVRRh5gtwcQGG+8pfqJ?=
 =?us-ascii?Q?MaGWWV4YHORoAdJVgwN3twapSSkyUaTSs3bFi+PF+DLBDLsArnSVFFstRnAl?=
 =?us-ascii?Q?Lyp+qsCrsNldqr8dH9zmXX7pQOJpJEU7YtUVS1Ur6xV7qwndcvsMlySQ/OvO?=
 =?us-ascii?Q?xUVM/w0NeQ+ZidRgnh1h1OM2fEwP1/YW1PamzzfGV72eAcwNlLwiV1CaOuQZ?=
 =?us-ascii?Q?9Vik00x4th9+CFQGyA1IMzC/xPn7nHxlie+rj9/Hp7pXlnfP/cOdqi0ak6Xf?=
 =?us-ascii?Q?OwlQUT6U5IsP6NZ19JoyXtGIQ7siiJhBWpskuc3UvQnvuCaBXYX9p2SEmUGN?=
 =?us-ascii?Q?XpyW/RF6dUR6t7EQiPnBTyUMNzpkvjg4+v+7Ev7/N0mD37KHQvmdadWSxyRc?=
 =?us-ascii?Q?oOBan1cU1+TrUOXqSmLLUVhInDl+q3VgCIhRCfJoHklw2J06U2yRgBfcb+7T?=
 =?us-ascii?Q?G2VLaI2YNumorq+UVk6/7BSsxMAfn5ZOo37jhMQUGN3C+2kcfnLJ625uDvdN?=
 =?us-ascii?Q?j79NCECpYQxeJoAYJJOpFOk7VRFY9is33NEtH5OW?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde45c9a-5a30-45ef-f578-08db5568c562
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 17:21:08.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAcHKslXNnmxKt5jBBAoY3E751KRFJNN3PXF4QnP5zuO2xDhFU5bu/vlGURTAPlspZWykRSfh/jQ5Gffa3gFbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In a SCSI request, storvsc pre-allocates space for up to
MAX_PAGE_BUFFER_COUNT physical frame numbers to be passed to Hyper-V.
If the size of the I/O request requires more PFNs, a separate memory
area of exactly the correct size is dynamically allocated.

But when the pre-allocated area is used, current code always passes
MAX_PAGE_BUFFER_COUNT PFNs to Hyper-V, even if fewer are needed.  While
this doesn't break anything because the additional PFNs are always zero,
more bytes than necessary are copied into the VMBus channel ring buffer.
This takes CPU cycles and wastes space in the ring buffer. For a typical
4 Kbyte I/O that requires only a single PFN, 248 unnecessary bytes are
copied.

Fix this by setting the payload_sz based on the actual number of PFNs
required, not the size of the pre-allocated space.

Reported-by: John Starks <jostarks@microsoft.com>
Fixes: 8f43710543ef ("scsi: storvsc: Support PAGE_SIZE larger than 4K")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index d9ce379..e6bc622 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1780,7 +1780,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 
 	length = scsi_bufflen(scmnd);
 	payload = (struct vmbus_packet_mpb_array *)&cmd_request->mpb;
-	payload_sz = sizeof(cmd_request->mpb);
+	payload_sz = 0;
 
 	if (scsi_sg_count(scmnd)) {
 		unsigned long offset_in_hvpg = offset_in_hvpage(sgl->offset);
@@ -1789,10 +1789,10 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		unsigned long hvpfn, hvpfns_to_add;
 		int j, i = 0, sg_count;
 
-		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
+		payload_sz = (hvpg_count * sizeof(u64) +
+			      sizeof(struct vmbus_packet_mpb_array));
 
-			payload_sz = (hvpg_count * sizeof(u64) +
-				      sizeof(struct vmbus_packet_mpb_array));
+		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
 			payload = kzalloc(payload_sz, GFP_ATOMIC);
 			if (!payload)
 				return SCSI_MLQUEUE_DEVICE_BUSY;
-- 
1.8.3.1

