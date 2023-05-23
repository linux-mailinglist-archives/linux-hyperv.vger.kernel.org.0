Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B370E380
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 May 2023 19:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbjEWRcv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 May 2023 13:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbjEWRcu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 May 2023 13:32:50 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D34BE54;
        Tue, 23 May 2023 10:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yk8G+0l8Clkq50x5IBrqOtNFDaQIvf6IOb5Eom2Ug4cjmJIfha/g2bkjizq0PQmYehI2S2l26UHPsc8ovTmQDfoRvTBKsBG62BegNKvZEVdO9X9j/eV/boIWhuswzOgLYYRf8q2OVDkJc+cEiz3YR21onxK2r84tR5GxCWy9g2D1F2kRrwrChtOCwt+yX5gFhc+gR2IQs30xQRoxhjl6Q4/A7otl/0+DsZZbncrxkrKWnxwGe6bdTxxR5eES/2F9TfY6GpA3zfgtg4gCJEyC+AOXuz5znHfcwABYuGCnBkfOvcKhhxi8JKA7iVtpdNNLkKGorrxnp8s+EzsGyBOg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gk7P7mm085GcOFy/QlJ6VB8iwPpBiBi9YxJ2vj1nW4=;
 b=l672DVXn+Yi/UevSjii5ZD9M1wbPIOIdLSp/ibhdTZQMijbnUJlsZQKCsbPJxGEemtLEQBrr/DXHwT3IwF0yMwwxCA0tXaCS42OZhTBqBKOqIVtY9Ptqg5EdnF4+f1CSvw+437BSkhoX3arfPntU832lHSLot0Px4NuoWCUStx5Um9N/+hM4d3AsUxT6nDohCkb5pWDIBJTxKiAjHnu93YvwfQhF3MKnxerCAqVcQfDw89XuFu8b9ejYGRTUPhDOi4qaeq2wHsZdmEioZO1x/EuHuxRMZZgn3149ZLh3U5/JU06FkkhGM95vMaoCXmTqaG7Nh7m5jxnkV+cNUc9lew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gk7P7mm085GcOFy/QlJ6VB8iwPpBiBi9YxJ2vj1nW4=;
 b=FlhlveoAGJ+nOGpnMeCpKHh4P+mAQLTydN9J4/d8qvUHlttTnaWtWaLS7NXi2oNv13DuCnzqw7TVDtFLCNu/pAzwhvL83bgmKhP0F/ffJuqa6SAbedch/nf64/YXsif0gb4kt+rbztsLzn55flmKn1jMEINc2jz03Q9uaWPUoAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by SA3PR21MB3866.namprd21.prod.outlook.com (2603:10b6:806:2fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.6; Tue, 23 May
 2023 17:15:00 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%6]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 17:15:00 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v2 2/2] arm64/hyperv: Use CPUHP_AP_HYPERV_ONLINE state to fix CPU online sequencing
Date:   Tue, 23 May 2023 10:14:22 -0700
Message-Id: <1684862062-51576-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1684862062-51576-1-git-send-email-mikelley@microsoft.com>
References: <1684862062-51576-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:930:d1::7) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|SA3PR21MB3866:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c2af2a-798e-43d3-5358-08db5bb13dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhrF2z2/IgBo1t0yJ4rp7EEvUsWcN2mknhMqS9cweIjmcHscvS2GmwfeBtEODepCZ/gu93nw1eqwa6eZdSc8aXhRQ75LkUruw0IeH+iKWfVMhj3aWvdAD3CsfMo0G5Bfqj34laFHYDt7yJKK2ytOJPRBnGeom27iuRTp5cBqVnbHD+JeJks1hdb+omvyciXgFtSa79s0nA5nxYLK/yJqCmCmJNRlVzYu6XxUiSDb2xKdCJvumCRfONjWeEZQwPyAsdzMUjMQ71jIfxKbsEgAKyvRv80A7LvtaKuh6h6tMy7kEh8yxs91cCweAm/Xj6Sdu/nPtquIl8skDj46SDdbSTpeLXtWYiAy/CQYqeDg7HD80W61FEpQBRTZ4tkKlCdn9G+i0o1gJ99QIj7LJqD1JnohJtAcLujraeZN6eRLKMP+DLX/dW254KloAjgfmb/U7n02BXjLPjsmcyCay+MkRJoJMoUayl48uLC8zavmO/21FbnHmOm65QEcXnp1SDFmLdH0Qmmi2xrPY1FnkqYysRzG/xArRLXJkMBd8i6P+cb17VerNxgo+kQlHGqs198OHFDC7UvOXMoBFjZU4IrBMTzhc6nVFZ04zKesfOiISYmAsV2zkbETzef0lrEBrLRr4rbaULV0/kp1N4+r9WqzGTIXf2iab7uWpjbU5CpO02Gwp05DM4G4iRzxTih1CKLv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(6486002)(6666004)(66946007)(8936002)(786003)(52116002)(316002)(41300700001)(8676002)(10290500003)(107886003)(478600001)(7416002)(4326008)(66556008)(66476007)(2906002)(4744005)(186003)(6506007)(6512007)(26005)(82950400001)(2616005)(83380400001)(82960400001)(36756003)(86362001)(38350700002)(921005)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AbT7skfBffANSrpGwxja+Rl+6kWkc83P9IcOxGwd1TCHlS50kOd1XaPai8G1?=
 =?us-ascii?Q?ZbTrPnB4aYyriPgKsSnNyYjVMc+y/tofqKXIpSyVKmx7yIEWSge4vFkJRUNj?=
 =?us-ascii?Q?YhBYLH0FEYFSAEPMpI8Qt9bumjT2TMLBch3MUAgnGMoUalfth91RSAa6i5vH?=
 =?us-ascii?Q?M36mFExEJrfou+839Cj8tCx7bSy7ogs94lzxHFXyJHcUG3iOf5h6mDewyneQ?=
 =?us-ascii?Q?hhWBgjSO/oTggb8xyVbz08p1IBOLL+GZ+BcCZ/DtWsvZnvmQv3i0q6FheOBE?=
 =?us-ascii?Q?H7J8FhJ7lHwJpbH47VAyEunseMJ047xEZcS8+pQeSGLGe7gd4Q5HfnIfPdl5?=
 =?us-ascii?Q?0TFgp0wNXaR3CaDmnqIW6Daj+oh+QnQ9efTaOPynYBquoTmL9rUqNL6JbveK?=
 =?us-ascii?Q?odeGlyTQwyai0oLy/2wF+T4USz/OAH/e6ss5eZeSXKZbHhTfmIs8254wMbye?=
 =?us-ascii?Q?Ko/YDoHVniba9wVrnSZ2o/T5YQFeI7Veyfci+/LxgLSXoZQlMP3z8berxgcc?=
 =?us-ascii?Q?2RjHNqQuS3UmQXQ0Fa3sbVG15JcvtP2A/eVP/OjfGgx4fYiruiKhi3YM4/kd?=
 =?us-ascii?Q?dMWW2Be8YdVDWyyGXPG7E/1Pks2o93544anZJFeMzSv2zfAiTKUwBbcFSt2P?=
 =?us-ascii?Q?DtZEKalbW9M/uCnzHk7g+LEF3eZKdaS6UfQqqGtrrBBiK+5z8aU5VCVxQwBe?=
 =?us-ascii?Q?g/sRilfhMVywRF/4cGh+jVwmIKCoXwGZzR0kc3V3uBtJDxwZs8xP9Ys3wEFz?=
 =?us-ascii?Q?IxgjQKwlgzTz2g5A07kO57yvrgsXLQrVzLsZ2f2i0o0nci9+yJ9MNTBS3VYn?=
 =?us-ascii?Q?UmlxJVnePOmCNqIT9gZwzn8n6qMqo2EZ/uwWCwOJUZML7GNZ+XQysYPtSPRC?=
 =?us-ascii?Q?JtxHpZYt4LB47JIpgHHLhFYlZGD7UBiQpPdc+Kw4qeJkTQ5LKvV2QLYj+/2c?=
 =?us-ascii?Q?orhQzEwwP4ZkOxVgbzZ4F5UQ1K0CtGGPC66+/SGIe6+aUfFCnjIXE1Q27J9o?=
 =?us-ascii?Q?xwcNTs+Q/q50sQW0Pv7K2tekvd2Zx9QiTEYUFFCLpkvbvdWjt6Cfvof7N9+v?=
 =?us-ascii?Q?8VShv78/nQ2iVEE2zPLxm0QSm3KXVRWY48dA7rdPz58Odt2+VvdVjSQxGuB8?=
 =?us-ascii?Q?Vxu5x9IwMIqqrdlNM30osfIv2CiAUk+6MDuE2jA2WX0dXvkwmYA9Oc9rnqK6?=
 =?us-ascii?Q?oDi67Na1bXwuHqYO7eWsnG15QCyPezaxPKE5FyiAwGQ7im/9wH27EaMNehHW?=
 =?us-ascii?Q?1NvlEe2/lE/L0K/9gQOA9LFUShnv4jedN9DJcXKZn5YR4flBZTYgBSg1JeQQ?=
 =?us-ascii?Q?MnCGRhtKxCUAx4zllJqpY++p5gmuppVFdzmRZ140gXWF+neyHx/A1Z0tGC2G?=
 =?us-ascii?Q?3svMMf7KX9UJpGNfKKKp78zKUbyqNUELTiLprQIp76EEZO+fQYDxtImu9NUp?=
 =?us-ascii?Q?aufEcoaLGJHSDYZ+/LO2cfVl/Bs+7atNYmk8ZB0I73Ou2nDzkY1q7dJgcLdt?=
 =?us-ascii?Q?lWkyMQkVutH209e8wB670xpFP6CDhq0tTZU/H7+LTjHp0LFJjsZx9NqZydWm?=
 =?us-ascii?Q?xMbgaKRK+xatyPuP70JaJR2rt1TQGXg2Kv6L9jny?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c2af2a-798e-43d3-5358-08db5bb13dba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 17:15:00.7278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8oyL+4Edss9HBk//W0Q1AjatefwftlQQrk7FBl0i2fnVWGMbjNzncLEgrztxsvZAzpAjR9scJu6v70KgLNnug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3866
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

State CPUHP_AP_HYPERV_ONLINE has been introduced to correctly sequence the
initialization of hyperv_pcpu_input_arg. Use this new state for Hyper-V
initialization so that hyperv_pcpu_input_arg is allocated early enough.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---

Changes in v2:
* Fixed typo in commit message [Dexuan Cui]

 arch/arm64/hyperv/mshyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index a406454..f1b8a04 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -67,7 +67,7 @@ static int __init hyperv_init(void)
 	if (ret)
 		return ret;
 
-	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/hyperv_init:online",
+	ret = cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "arm64/hyperv_init:online",
 				hv_common_cpu_init, hv_common_cpu_die);
 	if (ret < 0) {
 		hv_common_free();
-- 
1.8.3.1

