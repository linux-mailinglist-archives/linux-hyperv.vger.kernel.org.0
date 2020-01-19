Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5C61420E8
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2020 00:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgASX35 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 19 Jan 2020 18:29:57 -0500
Received: from mail-dm6nam12on2092.outbound.protection.outlook.com ([40.107.243.92]:19425
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728886AbgASX35 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 19 Jan 2020 18:29:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RY9anz3ReA5vStzdyn7+Z/jN6vrVpI9gB+JSiZLycdrpdbTToYi8aWWeyvdfpN6hdJxpH1RlUEPEDLe+mHRg0ZsbCKj8ar7Lq3FRa9XroEsNcN2Oy3T3dgSPAeY6neou5Dv9swCDjNNyZBoVf1swxoriz+XMhfyJPeOfq80xbfwE9dq3FCOTeBUWGQ8eYg6rH5PtSdsWhHlu0rnktZBnqjdsUJ/A2c0YqdEOCHAUYkHh1fIxo1z2n7yJVelQVW3SyGhrJ20myvEY0p/q4d9BxjggdsTd99TmooiFisHqEG/uhu7gGTl0tJXtVKDp3KQ4ZuYrRwz2/vCAEoPL1BqpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El6qEesUZ02ULdUNMQW/zW482zv8eKBU/6d3uHZX8gc=;
 b=d2qi1Ee8sfN+SZ6CZzmfwxpfcfR7b89J488noST5m2iBld1ATe/i7J+lqU+vEKSDnlE10WVAj9Ld6Ag3asyawhkRHNJ9Eosegri1GuikqbpKQYLrFQ/4WOM6cA3frnwQLpXE1gZFKGnOCWIMYqAhCRswjcE6mM1wD0HnwN4s8g9Tyq2GqSfIbd8+FDstHL42+iWEEKyzn06PGN6mvcmbau75nn6/Rw3RjtpJzkzJaxxKCw+EQeXeIvOZpfXr5MCSs+QcAOTs5XNFiqqtJiAi153SRSIqVxThtXrrHri0xM6DQjoYkAktflUNZColo52S0Y/TsntLRd28cAIqwpGMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El6qEesUZ02ULdUNMQW/zW482zv8eKBU/6d3uHZX8gc=;
 b=CCUuTYF0hJ0gjq1lvGNb+NzDkNkAnLtLLEuhLedYh8IK+ht/lMD6wBjRBKU2STalQ5bZMjpDR+QzzNtf0RXpUf8xReRjCel/VMUqvGtQtX1eTeYc+Wjzg4GeA3mpNln6tf+H7xnQFS3f/hmnEAs3jqcFpFSkEBw1Tq0itg/Ny20=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from CY4PR21MB0775.namprd21.prod.outlook.com (10.173.192.21) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.3; Sun, 19 Jan 2020 23:29:54 +0000
Received: from CY4PR21MB0775.namprd21.prod.outlook.com
 ([fe80::6155:bc1d:1d39:977b]) by CY4PR21MB0775.namprd21.prod.outlook.com
 ([fe80::6155:bc1d:1d39:977b%8]) with mapi id 15.20.2644.024; Sun, 19 Jan 2020
 23:29:53 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     sunilmut@microsoft.com, Andrea.Parri@microsoft.com,
        weh@microsoft.com, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2] Drivers: hv: vmbus: Ignore CHANNELMSG_TL_CONNECT_RESULT(23)
Date:   Sun, 19 Jan 2020 15:29:22 -0800
Message-Id: <1579476562-125673-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:300:115::32) To CY4PR21MB0775.namprd21.prod.outlook.com
 (2603:10b6:903:b8::21)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR11CA0046.namprd11.prod.outlook.com (2603:10b6:300:115::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Sun, 19 Jan 2020 23:29:53 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b93688e8-f67f-42a5-9ac6-08d79d377cb2
X-MS-TrafficTypeDiagnostic: CY4PR21MB0502:|CY4PR21MB0502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR21MB0502BAE4EA90D4CE9B2F24D8BF330@CY4PR21MB0502.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0287BBA78D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(189003)(199004)(316002)(6486002)(86362001)(186003)(26005)(10290500003)(66946007)(52116002)(478600001)(6506007)(6666004)(66476007)(66556008)(6512007)(5660300002)(2906002)(16526019)(107886003)(3450700001)(81166006)(8676002)(8936002)(81156014)(2616005)(36756003)(4326008)(6636002)(956004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0775.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZrrviadH03D3DwWr7S52uEp7QVSiyBXiC6mC1Sfgm8LHx7fMdnxWdDXdYEWx3jFLlDaU3bXuWTZvkfa6Z0ldgdf5ZhIrpiuP2mQB4+GPl9yTpZG73ysdKdUezJKeWFWVSXv5/n6hC4sdQdUhKFQmbBTpJIB3dyWt/78F6Jwreb/nGdykvkL8q1+dKKVBFPMHqSqpKMVNr5nUXvsGBMJ01vE2iJtyXdyPHCBE7NrBgi0JbUgKlbWssqK2l1DXcgU0LGGW/Htq0fsmBkwv32ETK7xno18jSimv+gZjaQG2FNGzow6H/5wEWCqaXMH7Dz9YOuRfja6VP8hle+GXdA/5CCuGM3O/GF6e/uHjSIFk+hqoG21PynbS61PLTExIK76/vfo1Wz4NmseTL66H368HxyAgSUe9i3ZdX4Wc6FC7dO00c6cTnDeJKmmiJvdMtOi
X-MS-Exchange-AntiSpam-MessageData: DZEwSShZslJsVOLWvdBlgYe1eNs4zyH5lJqEjoWUJxFQ9nlDs3O3gLiCz0KHe64dPLo4PrXmVJfAzNfzLCi/7naW+FXRSD9hZMmStrXy1oxED5bUsXtHbtuM08lwCOEm17y5PsZ04LOBd140HmCaaQ==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93688e8-f67f-42a5-9ac6-08d79d377cb2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2020 23:29:53.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9oliTmAc3iTzyQ5Njtltr4fJUlUUMsPkj6C1XGjgMbPnvGTafME/SZw6ToI2JvJmnw+/+Xyfb5wIAVxtP8aXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
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

In v2 (followed Michael Kelley's suggestions):
    Removed the redundant code in vmbus_onmessage()
    Added the new enries into channel_message_table[].

 drivers/hv/channel_mgmt.c | 21 +++++++--------------
 drivers/hv/vmbus_drv.c    |  4 ++++
 include/linux/hyperv.h    |  2 ++
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 8eb167540b4f..0370364169c4 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1351,6 +1351,8 @@ channel_message_table[CHANNELMSG_COUNT] = {
 	{ CHANNELMSG_19,			0, NULL },
 	{ CHANNELMSG_20,			0, NULL },
 	{ CHANNELMSG_TL_CONNECT_REQUEST,	0, NULL },
+	{ CHANNELMSG_22,			0, NULL },
+	{ CHANNELMSG_TL_CONNECT_RESULT,		0, NULL },
 };
 
 /*
@@ -1362,25 +1364,16 @@ void vmbus_onmessage(void *context)
 {
 	struct hv_message *msg = context;
 	struct vmbus_channel_message_header *hdr;
-	int size;
 
 	hdr = (struct vmbus_channel_message_header *)msg->u.payload;
-	size = msg->header.payload_size;
 
 	trace_vmbus_on_message(hdr);
 
-	if (hdr->msgtype >= CHANNELMSG_COUNT) {
-		pr_err("Received invalid channel message type %d size %d\n",
-			   hdr->msgtype, size);
-		print_hex_dump_bytes("", DUMP_PREFIX_NONE,
-				     (unsigned char *)msg->u.payload, size);
-		return;
-	}
-
-	if (channel_message_table[hdr->msgtype].message_handler)
-		channel_message_table[hdr->msgtype].message_handler(hdr);
-	else
-		pr_err("Unhandled channel message type %d\n", hdr->msgtype);
+	/*
+	 * vmbus_on_msg_dpc() makes sure the hdr->msgtype here can not go
+	 * out of bound and the message_handler pointer can not be NULL.
+	 */
+	channel_message_table[hdr->msgtype].message_handler(hdr);
 }
 
 /*
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 4ef5a66df680..029378c27421 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1033,6 +1033,10 @@ void vmbus_on_msg_dpc(unsigned long data)
 	}
 
 	entry = &channel_message_table[hdr->msgtype];
+
+	if (!entry->message_handler)
+		goto msg_handled;
+
 	if (entry->handler_type	== VMHT_BLOCKING) {
 		ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
 		if (ctx == NULL)
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 8fa0938f9aee..692c89ccf5df 100644
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

