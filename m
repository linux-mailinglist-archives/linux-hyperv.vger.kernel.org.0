Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7315B4D2153
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Mar 2022 20:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbiCHTX4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Mar 2022 14:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbiCHTXz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Mar 2022 14:23:55 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020021.outbound.protection.outlook.com [52.101.61.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF4536161;
        Tue,  8 Mar 2022 11:22:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYx6Fml9FLjpYHSGwELJYozxAAv4TFxcZ+DWhlbmon/nSs41hVMpWm4LAA813IjdpXqEQSfySO3Bfd6FmTnlXL0h1BgX8Z+elmv1BfO3rY6s4XZGTrCCbmZwJKGoYfJjFHhKh/zgZtYz8lUSxUgoa5n/s9iQqGh0AJm2hfrfrpZtT1dq+rgjBl2k04oqHDq6a8z4rVkOxjTS7UdGRm8sIfhLmK6op6IfutVAQMqFqO7rYlPf4djxnVed/IKn+zNYwCdAIDaFZnxvvy4RmsD2BVnrApNCIU3q//eXtifanJMlR/1lZtdcom8pmNuVBPQ1CFT7QchtuZ9+q4Mm+U5Hiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPbb6xj7jyqDN188J6q+la7OP39vh/sKYWGnaf/5Cuc=;
 b=UNgXswzw2rv8OnjT/0dWsi3EkyqbnHs2wbKsKtovLg/TTrGdE+OYx0ZqzfdNWFprEscidfHxxfly5kF/pGnIJ98cDmso5n/PwCam1qC1Fo0qZesWas+qoaqN0FVCnFqBSJ6C/Fgia2idbJdztmKowZKcR+Hy+fwh4Uno1rSM+kHphu1ZZTrvewfuj8OT5VY/pc4cyn/OUM6TTyfxBpkLyyPiwA4m6nZDDUoUXFa/MsT/Cc8K3FP31xDJfHXuKcOEf15gYGReH74ktf0wAwQIC5XZ3flV/gyuqEn0360Gf7iy1vNd1waZcpZxBf4PAf7ClZ5WPyMSox+gZRw5/mSAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPbb6xj7jyqDN188J6q+la7OP39vh/sKYWGnaf/5Cuc=;
 b=PBwsM+nfan289Pr72XyUWISThH0wLM6mDrUPy7kvVjmIS1rWnLQ6eGX7rKJbzUaBZ3TqDTnrlTbMjjoglcWnSP0He0Qq9t3hd6jX6DooLta68f8N6N2qhEmmYm+yEYoZpZuEj8eaw7cxDEGslVim6OPlQ6A5S5C0VjA6IJKziCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by BN6PR21MB0836.namprd21.prod.outlook.com (2603:10b6:404:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.5; Tue, 8 Mar
 2022 19:22:55 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357%4]) with mapi id 15.20.5081.005; Tue, 8 Mar 2022
 19:22:55 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] x86/hyperv: Output host build info as normal Windows version number
Date:   Tue,  8 Mar 2022 11:22:44 -0800
Message-Id: <1646767364-2234-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:303:2a::24) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 919adb83-197d-4687-8b1b-08da01390be7
X-MS-TrafficTypeDiagnostic: BN6PR21MB0836:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BN6PR21MB083658CEF87DFC887778F414D7099@BN6PR21MB0836.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uvv51oHMDlVUlaPhkiO8KyiBuOC/FTQ2ca7HdAtiuTjcYmHQg61Cs4oKZoWtBWXlS28+qygW0SaEwq3rMHyz2YA6w5lOX0X6Tod5zQaUaiZR1XxsPdHCkRPJJ0zXGrSbjtTGDk+kVOQfnida5peVOcE0xbavaEJwvrEX4rG9NgUneytmE23FnQtt9k0yzf/uIJFnXehhmK/gvhcuGS9Aa1iFpu0Aj8OBypsnkEe9zu7Wc/mQEt0LOMHjPv04a7gjtk6mVyqwAoOW5lIExVCAaxxZNdMuVORYwQeWQuiRZHwQz4hVKwzRXU0yCZCPBN2ntRs5c7MvuJi8U3KeLVTZT48jKHuF1wMb2wTrqKpqNp0ft94SmXev07PJjxGucJqW4k9UOQPCImytKB019huva1nrp3+tI7PRGAIYyENyUXl9IG945Q4FQXhgasQb+hAXYrxomTDut8e07CyR4ULW+vmsI49zr0EqOejdXK4CfFWNLrWxIHoDkIL9U3m8N6BpFw4LvKvauzRwkpyv6kN366gJgsJD8g3aiNyfuPc7W0MeUvKo00C4BadAC0FbNx7z1gShwRuXYSbShRWxfg7txIyAbTa5gSOK4EQa0Js5vSzo1nX44jGZVzZyO83iKmS5vB/5EvPkI3N0NemGrviezQ4M1Ukp79jba5R/5/dBa8X/94B/iVU5WXzNqyIoaXaFFkvjXnXwVEzRIX4DKAPHrRzBJnb6MPHSvgR8R6C5bxZsPRlxRtlYH+SaUnJSvA52KW0zf5bngYAwxd82yYdbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(66946007)(6486002)(82960400001)(4326008)(921005)(5660300002)(10290500003)(508600001)(8676002)(316002)(8936002)(36756003)(2906002)(26005)(6506007)(6512007)(186003)(6666004)(2616005)(52116002)(107886003)(83380400001)(82950400001)(86362001)(38100700002)(38350700002)(451199004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f1Jh7aecqLsCAq+maAGyMZJdVDiPWVTPpuGZ8MwfGDWDnMfCh9lETYoa+2w2?=
 =?us-ascii?Q?/6NiMO3RQ2yx/yImrj1/08c0OrCIR868+eyz/m+RMT4EpB8g+Mbn+DMP2Ys2?=
 =?us-ascii?Q?0Ts1J0cUt4w56aEgQJjOoszjgBoGDLL5QbRTXNW+BqebNHFWlwxjPAGinWGw?=
 =?us-ascii?Q?B5VPMSciqvroesQ7CniMDIirtreBIPZt/mKedzcvarSDueBnzLQMGu6oFSRc?=
 =?us-ascii?Q?7ArZvuO+89/fk5l5z4tgLDtQoN9bahmz/OAwlqitaD9HsNCvVwUbm0ehXWc3?=
 =?us-ascii?Q?7JCwU2YW9XHKKdDRZbpzHX+umAH3TBekZmHTVN5w6f9rGmfBZp3Sq22PYzBp?=
 =?us-ascii?Q?15pZhP0LG85FJ9EL9fU1ps250XTvPNv/Wh+CTPWdLs2e7i6Lmi7GQow/vfdQ?=
 =?us-ascii?Q?JM4P7OU1AnU+/iJljJwCyWUEqNKkqyzx5LjvMgGSxY+2wY8bzWQdG3HAm59Y?=
 =?us-ascii?Q?oyVuLMjdP7MJG2umg7NaSTMnVpppppIsA8pdwdWplxhyaYgWtM+eLnIsHLIQ?=
 =?us-ascii?Q?nVkrseh97x7Ag6w3ivLKeR47vkBWvo6PAAWbU6kKxth+eMFmZZ6b/c/7IRrS?=
 =?us-ascii?Q?uaNAH6Z39Zca41qM6NaoqLU9+qvt6FR2tNORZO7ox1/fhoeo+b74nD5DguHb?=
 =?us-ascii?Q?3/S8iSJmhXhr7HlZkarxUC0JBpyP+NOzO5ooKQ/Y/0jjSnRGLG3AnbpW3By1?=
 =?us-ascii?Q?oc+Ftb+Cb1I4U613g4W6WEDdTKWpVIro9Q8GH4Y3R28U2A2iMro0FlH/C3vb?=
 =?us-ascii?Q?RONjOhBGp7F4IDw74KTjfnBg/hAG/C1ltgQ/0P19FNDe8Lyp773SX/BcElNO?=
 =?us-ascii?Q?2szJHOWFAjH3f1I7zH51MVL2FdVF8MAs2N8OX/kOm42n8pHni7jYWPg1uKNp?=
 =?us-ascii?Q?BidwIBlUSSJiuMy3/C0JEzdfgU3yBxOynAoQbI6K5x1QdoRFyMg7Wvw97YGM?=
 =?us-ascii?Q?UF9TNEA+bvk0sVeQwL8M8/bPuNaNki02/fflC6F4jLXLlm5DT5l+s0oTxj/d?=
 =?us-ascii?Q?ZawTJyNB9gUuk27uQ8qdZbJ6xH6KswcRCGMafeLBGR9Fsxy04syuvWfckwLC?=
 =?us-ascii?Q?E9IXOXv0amsu6u8+9IQXECNGXG0W48JwpMe3nikTRHkiUFm1KOmrOtIUk8dP?=
 =?us-ascii?Q?GtseY3wz6+QZBpbgtPWwIjkMZmh6muNZHHCF5kDNhRl5z/A9ylMRr1VcMSEW?=
 =?us-ascii?Q?sThcGCRQRtriJBKHXiZjla8s5VOQ77PQHTPoiv9qgr0mxu/w4uJFLcyj5sIy?=
 =?us-ascii?Q?acfkVFGU6MckVX1yZUvuXduB8R1XRmRMWd9nRs9ypkWYgVMiQV+3ljQgiSD7?=
 =?us-ascii?Q?aEFmCxH6/fQXdkBt81Zw2vPeojx2EZqRR7EaOO4Y6sJxk1J3ssA/7dAHbwyM?=
 =?us-ascii?Q?x14uSfEAywu0x7ckBL+qqEFNltKknSG/Zy+GEJm+28Pf8FaMYHCcCMQ6Mipk?=
 =?us-ascii?Q?Mo+D+27xOJDl5R8iu55UKo0jxge5kyIVnBK8CBX1OAjp51X5mOo08w=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919adb83-197d-4687-8b1b-08da01390be7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 19:22:55.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kn4B3CKW/m/byXLkM5ImIpzQh/Wqilxmls+s2GpKNOkNMQf/W8at4C9gxhlKzg0hhp6uMDWXGZWlr/C2J5Heow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0836
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V provides host version number information that is output in
text form by a Linux guest when it boots. For whatever reason, the
formatting has historically been non-standard. Change it to output
in normal Windows version format for better readability.

Similar code for ARM64 guests already outputs in normal Windows
version format.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 5a99f99..6c4b6c6 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -309,10 +309,10 @@ static void __init ms_hyperv_init_platform(void)
 		hv_host_info_ecx = cpuid_ecx(HYPERV_CPUID_VERSION);
 		hv_host_info_edx = cpuid_edx(HYPERV_CPUID_VERSION);
 
-		pr_info("Hyper-V Host Build:%d-%d.%d-%d-%d.%d\n",
-			hv_host_info_eax, hv_host_info_ebx >> 16,
-			hv_host_info_ebx & 0xFFFF, hv_host_info_ecx,
-			hv_host_info_edx >> 24, hv_host_info_edx & 0xFFFFFF);
+		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
+			hv_host_info_ebx >> 16, hv_host_info_ebx & 0xFFFF,
+			hv_host_info_eax, hv_host_info_edx & 0xFFFFFF,
+			hv_host_info_ecx, hv_host_info_edx >> 24);
 	}
 
 	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
-- 
1.8.3.1

