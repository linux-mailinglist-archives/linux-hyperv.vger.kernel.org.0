Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF85520158
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 May 2022 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbiEIPsv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 May 2022 11:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiEIPsu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 May 2022 11:48:50 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020018.outbound.protection.outlook.com [52.101.61.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFB3248E25;
        Mon,  9 May 2022 08:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Maf6WrImUpSwew+c1vtIc9cXsLMvBuc/ZwMurFV3HHYFzokyzYp3eHuxBpBW486wzH4SZuH3h6fd9OwO9IRMZvgzeA4Gw0U43RkyMoMYMOnNjf2Paf5D9lZNoBpjkm+5qoI3GFtRJgGt1jxYEOK8fjWhKVzrKOPz4na3UalXSYjMf939CiR7xiLDiB8Pc6mOFY4Y/wRX6qj2GwZ+2Z0ozeSbB7Jm+WFbWvzKqN2P3ZQ0++zOHuEyRqY/k6QnmxMIV25IxAc4BlOXmbxaDICWFbNM1SUWF8v1V9+lqUJlQWpdxqCLlJgJhiHpb76n1arlAOysPRSuI6U27SkNp9uNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzRA2V9vqI+OVzyyxRNmHHBpbTde/RWyLzB04bZWcQg=;
 b=MrsPb8m5Lrj427MbkbIycVHNjEtX0SuDs0uQFZ+6AHzox3uylY+E0Nh4vw73R+mf2rE8MZfzukG1XnGlU0hvdxLO8BXiaoncVuihRSMncBce7a9+iY7kiEbycKIlDevUM11Kq51ttrgK+v5MV/RbsoawZLCBqxxylyNdecCviBPM0wpyQf13Sz+j+xleOQcfZiwf+AoVopJBJBRHyWr8jugb9RuwaR5BW1yvgX1SUKtKySPmJYLpSVq2yEXoKpnyTRSgsrjedTN48Uv7ht9t+7K83dReO8Z0GZNiZmQqm4CP8EAGiYx1pOM+34ASsgtPJ9flCf/rYMHkYxKYoAI03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzRA2V9vqI+OVzyyxRNmHHBpbTde/RWyLzB04bZWcQg=;
 b=bfyyByxRYlnmcIBDRlFvApPG6PcxVszfWk+hvOKd0nzkga8jpTff5Q5zges6r/uCggAQ2KmAALbaBM+0gcb7UWVemVEBZOzKy4wNLBcN/AnyrL14iHdNhLXf+iaxv11gELW0cD47tDTeQhQlgfadnRil+VHifobEQI9diuUoWHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by MWHPR2101MB0873.namprd21.prod.outlook.com (2603:10b6:301:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.4; Mon, 9 May
 2022 15:44:53 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::9cb4:220e:396:42a9]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::9cb4:220e:396:42a9%5]) with mapi id 15.20.5273.004; Mon, 9 May 2022
 15:44:52 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] x86/hyperv: Disable hardlockup detector by default in Hyper-V guests
Date:   Mon,  9 May 2022 08:44:23 -0700
Message-Id: <1652111063-6535-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0276.namprd04.prod.outlook.com
 (2603:10b6:303:89::11) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88888478-607c-4207-008a-08da31d2dbcb
X-MS-TrafficTypeDiagnostic: MWHPR2101MB0873:EE_
X-Microsoft-Antispam-PRVS: <MWHPR2101MB087388C9E2ABC49911B0787FD7C69@MWHPR2101MB0873.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GSzZ7F5nls6m5zH39uncmYVTfLOtjOMk437HrxFzfMhVlaTCBeaByx/V71DWQNk5XORkpfvYVItdcpe2cxxe9Fgwr2v/TcyBIIFOj4SaaIHdCMDc4kfx9sDaj35bpCmOYf0N+ZfxwMm7ZSH6LnhzLYkF34IQmUFtEa59wMA0lcVQv/ontZg3rRQRA1uwTxl+OugNKuUOfrfz2lYTITFY3SN3MO4RjojfsN5xBHn/hXE13apbHeDNe4jhjMhWoxASHWUACuz0PYYpXqQx/CULZe4sfaExoY/nvgknoGcBq/x//RsHYP2OBGu678L5M8ej2zHZcIqLruI//W0C+Vfsx0lRsLa5bVWSejZesDSIaN9Z5AYl0CGLzzOVjL/AZMUwSdwfSMrVnxOYJcso4tHsBjLJgs7xLI/2OJ4/qWcXN/zn1NlXSuc2zcFJThZ15DaTZxXzXE0ov/wrGJ7QRQC6zyAZHUqbbBreIAG368ayfFOkAre1MYH6MeTO14BKPLR2PuJ1cNMTzmv+vLb5qbeymFKzI1+dtADsqOe9lBpjf6yCW0knJstbPsjGNil7P43k6MBSG5BIb63aHma1QLIcYnxdMhfRXX97gR5HVJVDdGlb/S71Ta294FodJpOOxNQc33rSyrC6P+8BOye2FK/2Ks02tCyMXzPqdVKxFUcVuHKABxpJ/+QsKIj+RlTf+QrRphNrfH5FMvM13HhxLpSTOro6+E/ghBg7rRTRUY3st1XsJH5rFCF+O/GqzZGGc3/MwsrypbFfu632Zgsq3CZamQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(186003)(26005)(6666004)(6512007)(52116002)(6486002)(66476007)(86362001)(6506007)(2906002)(508600001)(66556008)(66946007)(8676002)(4326008)(36756003)(107886003)(83380400001)(2616005)(921005)(10290500003)(82960400001)(82950400001)(316002)(5660300002)(38350700002)(8936002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m58dEOXfsZVkxNL0zaeP4h3xcqD6o09Btd5hdEzrs7QQbJAZuBDES5DCZQ5j?=
 =?us-ascii?Q?+tC38+0BV1GZof0Ji45l6OFOi/dzQVl6yNNJ8OH9IH5vBsjV8BipM0xDN3Xy?=
 =?us-ascii?Q?ZJUL4qt1X3zhMlEQh7XFxzi7TD1cYfpckhDSrJI9ntDA5KO344NprSy+cL6j?=
 =?us-ascii?Q?HPayw7g6/9IYaOCyvk92wKPE3YDJIwa4gfN+fr0lD44oOsszSFzyucIH2ibL?=
 =?us-ascii?Q?PX+pgOFTQkUTHgecwddCJIfSrgKbv1zdTCp00107cADPwNL0CYz0c9IXxO8B?=
 =?us-ascii?Q?ko2+HYIzJPbrpwEaZKT14X4v7jcA8nKpWu/PseIvbBNpjc3z88lfijuCL5LW?=
 =?us-ascii?Q?t+JPmlU8XkA3Pkuk1ATxps0hpt9ZadQJOucYZhH7atiWvV8xpkYo4E+W4Ju9?=
 =?us-ascii?Q?YAhAZA1fBS0KZ4104sC+4XwOtmbdSB6S8OG9n/at+1WMXjFyWgf8Usr6V/+c?=
 =?us-ascii?Q?gQ8GIb3mx8Auu/8jWi1mO6HjcD25vg1wB9H/gxBZLYB+ot5Kj+ZblQYqKsdT?=
 =?us-ascii?Q?wyHUx6a/qPpnOs1yFV251Ode3eyZbUOrME18rXCAhrHXKFAHvN8KK1vBY2R+?=
 =?us-ascii?Q?Dm6UflmMo0i2W2Omi4B9XjgmvDjA2P+Kf7+maDByOPPL6x02vxsVIIYOCbcw?=
 =?us-ascii?Q?eAJ+7q+EJDSTfEdw+1LHmW9NxSYEoTyJJCH22o6oDgu90rC8pLkk4ArSK26W?=
 =?us-ascii?Q?minP5CTAWEDv9GT15LxVBLGA/U5Bvy6uEH9RrqkQIo7I9C0zV1OVX0yA7Pq/?=
 =?us-ascii?Q?Xm3ohUATOG7ucGQx+tGFjfvnzbQ+DzZvHNVw9Q8VZjYZTLK5wAgem8X4XSbf?=
 =?us-ascii?Q?uyPthwyCRoq8Ql2oBRpyOJmcYB+whM0Rr9rscwKIRZ7K7VvzBsEdmvqc7nhw?=
 =?us-ascii?Q?HZb4LH5SLtHEetjpVVM8ir2WVdmf2tRPq+z+S0Xrq4Cs02lEjvmz1bw8u4nW?=
 =?us-ascii?Q?adTTYxIx6Q08T66pfolsTwFw9YwJgalamA4sL2zCNANZcCX/Ljy/uzqPyt+Z?=
 =?us-ascii?Q?b967sts5nF/tgo5L+5Pi/5dBLdqrYZk+0TeVH49gjuj7jkNvYv5dx1zwY5c1?=
 =?us-ascii?Q?0YPSusfObKWHy5Imk78+dNTmdanmPMUFUhjPvAGOQGxJJvUEOQotaAoItKMy?=
 =?us-ascii?Q?LBJfa7Dr4RlNdZmILFH3NMAxID//w1b1zt+OsbXjCGcFIk/GUuZh8LOXcu2v?=
 =?us-ascii?Q?WzPiAPr9afuk9eRLq6QEaG5hG+a5C2EB8LafhiSoJlU2Y8so/PwZCQdWrAzl?=
 =?us-ascii?Q?5fT+rD60z7+mEQ1M2p0I79yRr/CHrzvrzYJTVBB2R20VBS8EsWwi1RQFBld0?=
 =?us-ascii?Q?v/w1t1miCA4KKA//jgy6srpgGK87CXYX2E5xkOpRcrs9zsY5mAxI+u1+qID5?=
 =?us-ascii?Q?uu4nNieacG3hXOQT1gtgfxdxNBfYyVIMXIvhiuCPJtVf/LI7iWXkfnj8cFXD?=
 =?us-ascii?Q?21F5MS9WTL11YGLScAObV0xNKnhMEqZI2u4wPvxy2KIsi4vnpkk3crk8BENu?=
 =?us-ascii?Q?oWo0c29DMfn5/mqFsZKwSvKt2ugXddoaber3VCP9SHUZiamk7OrvfjcJ32BV?=
 =?us-ascii?Q?l2naMW/i6ObVSq5uTYgWXD5vcmRKmBVDZEoQnRyLN/9PxUl31oNRCYqqe7IS?=
 =?us-ascii?Q?l57oCZnmYnbLH9G97s9Qznb2dIjThwctmQyY51BBLEqX1dlT2gGXnC1BGqh4?=
 =?us-ascii?Q?Tmw/zLoPLJsGnMNR/wUZiWIEr2JQ0TEPhQNSVnrtpglCCpzAVbMNb1k+Yu7a?=
 =?us-ascii?Q?Acsw/Iu68iFcTS2Wk0clO7cTp3z+vX8=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88888478-607c-4207-008a-08da31d2dbcb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 15:44:52.7903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nL39en3llB7P1hTmNvF91ZwxLyPKCYi+umRYAyDTNjEaxiVMG68T+GiSLT5F4OHOZAFj0QKg1/bWGKw/AemrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0873
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In newer versions of Hyper-V, the x86/x64 PMU can be virtualized
into guest VMs by explicitly enabling it. Linux kernels are typically
built to automatically enable the hardlockup detector if the PMU is
found. To prevent the possibility of false positives due to the
vagaries of VM scheduling, disable the PMU-based hardlockup detector
by default in a VM on Hyper-V.  The hardlockup detector can still be
enabled by overriding the default with the nmi_watchdog=1 option on
the kernel boot line or via sysctl at runtime.

This change mimics the approach taken with KVM guests in
commit 692297d8f968 ("watchdog: introduce the hardlockup_detector_disable()
function").

Linux on ARM64 does not provide a PMU-based hardlockup detector, so
there's no corresponding disable in the Hyper-V init code on ARM64.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 5b8f2c3..8316139 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -457,6 +457,8 @@ static void __init ms_hyperv_init_platform(void)
 	 */
 	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
 		mark_tsc_unstable("running on Hyper-V");
+
+	hardlockup_detector_disable();
 }
 
 static bool __init ms_hyperv_x2apic_available(void)
-- 
1.8.3.1

