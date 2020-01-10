Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF2A91364B4
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2020 02:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgAJBZo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Jan 2020 20:25:44 -0500
Received: from mail-dm6nam12on2098.outbound.protection.outlook.com ([40.107.243.98]:10849
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730539AbgAJBZo (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Jan 2020 20:25:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrD4XSZGQn2J+wvtEqrszvkJal9JRJck51ajSGk7KPObF/KrupVMzG9k6Xcvzfd4y5AERf0mTefx07hdJcQzS9VpODo/4WwuOpVPmsoyMhDu4fHef68bC+zeNu5g86KoDOEGJ891VmQvUcp5fgcNAoyp+rem8E1c8wT3RgEB8VennipWfl+0q9ZzCbsPuMGcaB/lKGQmiC/HMK2ieMgz/Wq3L5opUgeYAJMgBEqNKMut+KoA+2arYo2XiCkEAdoNYvm/FbG1J5dAawnD6+vYy5L4lCMkymwwi/iZnreKuP1VCjaWHHk/co4hznhR0HkweD8Ybg6Jp2KIROId4+mdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWTF0UuXY5vntRu2Ca5bOl2YVc2MwejTZ78rX9V3iSk=;
 b=AwUDQkVflhVLBzKEEzHP+i0+OeaV2kbX4IbRvy2/fOuX3CgeulOLIupUQ0A1n7wnNmo9mcpeMNx8NUN6p+puFcYKgbCe3CpqQX3dWa0BnGVhBzRCKepP36ATUAYAcOd2VC/oi01G7984PS3g+ib2DahxArkU4XKm8mqO90R4JucT6NmOHPs9uEkz7C3sSiW/+IcgbPY/DKO2KPDC4N0wgLUWryO/XnGk9O19vcZBM1rXW1qe4dt3mstoO4UeSI6O85TInDv8JS11Q88RICN+fyg+u+PwOUGhL6V1zWYarUPnU1zJt9bwhwddorpgEYom67JTb6AZrdGJ+Yj17qocfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWTF0UuXY5vntRu2Ca5bOl2YVc2MwejTZ78rX9V3iSk=;
 b=jy6oBnQ1kpo8KOXuya8h2TDIb36uZXkECaf4Iy1dVssPUpkGGCBRcweNzFlHAMk6QC3HxMq8g8g6naDnELZVKsVBo/AWtsouij7ZukYv84IwwI8VrNjxW+8ZCxKYCgQwdh732bIT3uomekD97pF/Tp6kuIAvQvcogKOHYannD7o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from DM5PR21MB0779.namprd21.prod.outlook.com (10.173.172.149) by
 DM5PR21MB0858.namprd21.prod.outlook.com (10.173.172.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.3; Fri, 10 Jan 2020 01:25:42 +0000
Received: from DM5PR21MB0779.namprd21.prod.outlook.com
 ([fe80::4dbb:1abc:e1c1:decb]) by DM5PR21MB0779.namprd21.prod.outlook.com
 ([fe80::4dbb:1abc:e1c1:decb%12]) with mapi id 15.20.2644.010; Fri, 10 Jan
 2020 01:25:41 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     sunilmut@microsoft.com, Andrea.Parri@microsoft.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] Drivers: hv: vmbus: Ignore CHANNELMSG_TL_CONNECT_RESULT(23)
Date:   Thu,  9 Jan 2020 17:25:15 -0800
Message-Id: <1578619515-115811-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0071.namprd22.prod.outlook.com
 (2603:10b6:300:12a::33) To DM5PR21MB0779.namprd21.prod.outlook.com
 (2603:10b6:3:a4::21)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR22CA0071.namprd22.prod.outlook.com (2603:10b6:300:12a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.11 via Frontend Transport; Fri, 10 Jan 2020 01:25:40 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a0a26289-b1d6-4845-587c-08d7956c01c2
X-MS-TrafficTypeDiagnostic: DM5PR21MB0858:|DM5PR21MB0858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR21MB0858621B85824228092476AABF380@DM5PR21MB0858.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(2616005)(956004)(36756003)(186003)(66476007)(4326008)(16526019)(6506007)(26005)(52116002)(66556008)(81156014)(81166006)(8936002)(8676002)(3450700001)(66946007)(5660300002)(2906002)(86362001)(6512007)(107886003)(6486002)(6636002)(316002)(6666004)(478600001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0858;H:DM5PR21MB0779.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTZwHh1aGO8ZZHKJBAxN92UtYpJMv6xQcCCConnOuceW3xGk967F1wzkyPGQk8PFzxoCVOQNXCRofVMPiEbOsxVTBgIFBdf2mdwiRpbPbVS3+MTbAfZxLETG1QuDzT4YPtNw+6XM11rez6Muiei9wq2P++m6zlbpIc+0o1FinvoJLNQs2HpOZB0nmYNqhOsWpAvc2iK6DpN0fM7C3Wwn9xh35tARzt/kTwSqYM3Gm2aTq0lrX8GlmmGxxUdcrsuP6YaSWd2lk2H74yAxWGnELHcKUvql4gRiAT8PKloeTWJsqBbBRez5q2HLBnsiMOLg2iCDfOPmbyOheQVbZmLCdwBCXPA1ciAUA7BvUSKMP5alsQ+5KOsaxxoX3InmUG1XR9jVjHw8Ks1RcZ+xyPuug+6D1MLoO+8at9ksGuTr9ar4X2y7ITlFC6ek00z+0oCs
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a26289-b1d6-4845-587c-08d7956c01c2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 01:25:41.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EQ8BpjH4wIW936CWUYqUfXB8NIhwSGXKam3a+TCBxH8oL8vKoLAmBvVfyn0XBVUSvTGDZrEkZHBPivWz5KlIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0858
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When a Linux hv_sock app tries to connect to a Service GUID on which no
host app is listening, a recent host (RS3+) sends a
CHANNELMSG_TL_CONNECT_RESULT (23) message to Linux and this triggers such
a warning:

unknown msgtype=23
WARNING: CPU: 2 PID: 0 at drivers/hv/vmbus_drv.c:1031 vmbus_on_msg_dpc

Actually Linux can safely ignore the message because the Linux app's
connect() will time out in 2 seconds: see VSOCK_DEFAULT_CONNECT_TIMEOUT
and vsock_stream_connect(). We don't bother to make use of the message
because: 1) it's only supported on recent hosts; 2) a non-trivial effort
is required to use the message in Linux, but the benefit is small.

So, let's not see the warning by silently ignoring the message.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 5 +++++
 include/linux/hyperv.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 4ef5a66df680..c838b6f5f726 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1033,6 +1033,11 @@ void vmbus_on_msg_dpc(unsigned long data)
 	}
 
 	entry = &channel_message_table[hdr->msgtype];
+
+	/* Linux ignores some messages, e.g. CHANNELMSG_TL_CONNECT_RESULT. */
+	if (!entry->message_handler)
+		goto msg_handled;
+
 	if (entry->handler_type	== VMHT_BLOCKING) {
 		ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
 		if (ctx == NULL)
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 26f3aeeae1ca..41c58011431e 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -425,6 +425,8 @@ enum vmbus_channel_message_type {
 	CHANNELMSG_19				= 19,
 	CHANNELMSG_20				= 20,
 	CHANNELMSG_TL_CONNECT_REQUEST		= 21,
+	CHANNELMSG_22				= 22,
+	CHANNELMSG_TL_CONNECT_RESULT		= 23,
 	CHANNELMSG_COUNT
 };
 
-- 
2.19.1

