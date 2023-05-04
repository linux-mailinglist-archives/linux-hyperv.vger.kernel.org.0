Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6936F7947
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 May 2023 00:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjEDWmj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 May 2023 18:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEDWmj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 May 2023 18:42:39 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D1893F7;
        Thu,  4 May 2023 15:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncehkhobfwsaXvl6p9TaFquRMnyM+7b96t7qtKEzlXlzSDciGtdHCXdE16R7m61kuRRateRld44I7/TmE8NkSnFnZoN8UZrXcCcz1eLACko4IArKwfpOyboYRtEd/QXm6D9M9NG8jODYYyHdgaCJX+eixGknCW9Qaq5QPLkWi6lAgKC2HhYS5jWn8noiENO77sckgGfMgykvMpeh9X81WRO5LaBlCzuPdIAqaTSKZzuaR4O6GG52o2j06pVFWZSa7k0hPgPWNOdqijwIOkvi827XsXFVe9D/iLZp0XZgdXyL/c8JFDrOvOd42PDw7o0KTTf/UsUzpGmwXZc5TQ5V4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNapLHSUwTCXrhl5V/HtrkJiqWNqGnw3g24Z2PvY1C0=;
 b=iY+scX3Z+uIEB3vgUSI4iIMRBiZb9fvV29NmB235WwMhQlI7C2T6SLPehZYdAZEt4TrbJ+D38GbqBg/JVZW60ZH9HW5qS4WL49NtLoS4YbRqsvXnPT6s2Y6pe/cG8nI5jXSmnt+FK3Tw4CQ1fFPgM4P/GY7JqmE8xjUl9jWv4hgZMhL1nGvrM33ZIRXa1tja5PMrkx3Bsq/2/3FWYMTwd4dBdqeA7R0LH6wJEcXaB4LekpJX1rifEprN1IFpDYjLtnDgtlEyrQA2hlHp4gNUa1Y5EiGr4uWHLcY4YDg7ZEAzUIxKOyW3MHxni599rE9T6ZuiI9qSjnFDV29N1aZF6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNapLHSUwTCXrhl5V/HtrkJiqWNqGnw3g24Z2PvY1C0=;
 b=KU562w7Kq/JqdbAg4IujX3W0OgYdc13IBT7tmCZWtJqlhHxQS5w3eLATM9uw1yigDxL5Q0ey6xgyx7O2chYhyGb3h0BrZcbnkTQ0l80sAnWssYonQbeYzBtFFd+jRE9eV3d7wQOpq1+1rsvpNRODO03/kDIgMV7wwrJZz9VFeXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by SA1PR21MB3811.namprd21.prod.outlook.com
 (2603:10b6:806:2b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.11; Thu, 4 May
 2023 22:42:22 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::13da:fdfb:f037:e2c2]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::13da:fdfb:f037:e2c2%3]) with mapi id 15.20.6387.011; Thu, 4 May 2023
 22:42:17 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        stable@kernel.org
Subject: [PATCH] Drivers: hv: vmbus: Call hv_synic_free() if hv_synic_alloc() fails
Date:   Thu,  4 May 2023 15:41:55 -0700
Message-Id: <20230504224155.10484-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:302:1::14) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|SA1PR21MB3811:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd14c0c-5645-4b79-ce4e-08db4cf0cfea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jD4Adv84Jo7HHDZ19/wT1KPc3/4UzsOZX2tSnk1GkaIxHZ8jd+gqtIhBZIled0IT+lUKzerzcfPHgj/GaoeTC2m5NSwRMzOmOmkWqvOkBPS2JcV+WW/vhKuduohm4yTugbqGwuarXdUVsVuH4UPSlJI4br/uS+dHUWeVeAeuFcUFlqY0jB1T7XKwEa4GWaUSEAI3dJjJRNk3hcgtT3xikZRzxV/zMMh9XL4hClrPEcBHSOD2mXUz2IjqfaRvp4IFD/KgrgmhwUXUOg7G8ugD7MSd1yU2VWNfq1K2LeLnR7DtfAvje8+g0C2XHziPLdA4+rkvb3tH9PXNq+PQLB+3TgMuTI67+YQIWCaDz7OQNsUdqKY7fywqIAKCsWuOwSPM/VTGpSeTkOSV5RSOk9q9jopvBP2Vj8iul3BL7yfvLxmbW/+gd+Zx1BRQUWMQvCDRuES1g1oqAZgwBBIpabo58dr7O9zmSk/iuXpTiVnaqehl+wg8sNIkOJ8h2pgRdG2M/zUATDEOusJwuSjsW071fIBFr1ZSdkWIq4OpLxylr+rA2rOjoqBZZ8V+2rZk6U1/ATsuXD0NP0KNkrOnPq2HtuHg6kUx9Jw7U1hwjTdr8pk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(66556008)(2906002)(8676002)(41300700001)(8936002)(5660300002)(316002)(786003)(66476007)(6636002)(4326008)(66946007)(86362001)(478600001)(10290500003)(38100700002)(6666004)(82960400001)(52116002)(82950400001)(83380400001)(6486002)(36756003)(2616005)(6506007)(1076003)(186003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h58+JBdo4xC3DWw/+3Io77eT37pQCr55sw8ZFu3o8Y5xC1AbU9DPXR/un9VR?=
 =?us-ascii?Q?gxe+YwQO+AmGbbunQ6rHW4fW1tiQengIObmbSUBRU1g36+3Ej0LKLKMhsCc3?=
 =?us-ascii?Q?T3ir/3SZyyFA0eluuuAUAjik/kIlJXFLonmAiTQ67p5Or0qhDmrNckxgyK2x?=
 =?us-ascii?Q?qgatiikH4pJbLVDsHbtEWpp/eBRBeE02tGpuR5FYj1p7dirW/lYyZRbXZ35N?=
 =?us-ascii?Q?O/g+Cps6d5xKQtG2rR9+/RMUIZR+W/DKt1DcrvphcBft+XRpjRZ5ube3bJ02?=
 =?us-ascii?Q?OpNl6sPFJuH8Qyg8EDS4XpfhNhnf+G7c+zdJ+VbeqNH5Hrr8hbBlciIDagn4?=
 =?us-ascii?Q?4pQv3Bp5P78SIzHpWq1ubMxk8ACZ+JgMMVe+jMrRk/1htKetqezGjsyMU7PE?=
 =?us-ascii?Q?jH03Db0nbQojWf8XBv9A+Jq0xtJqABSFqURo0s66HDab3Ido2NFGWwVj2T7K?=
 =?us-ascii?Q?9YMvO4yakCBNIdHun2te23gxE+79vQJX+bzJA5JyORgiVZCXCznhwkeljlI2?=
 =?us-ascii?Q?whsxGqiIj6PyAztJw/e8dzpMwd5+Exb8Oz/8Ljw1rSat0mYXd+Y820TxjmWU?=
 =?us-ascii?Q?3ZKrpatNZ1w0T7WxbQZG8PmfYF/mBYI6qNAl23dG1UGHwarTR7Z23kV3t2JI?=
 =?us-ascii?Q?m6zEAXXCVEil/kKzQNoUikRpgbMj+FwCPSqeVdo1RwrvWZbkPQq1U8q4+N+j?=
 =?us-ascii?Q?T4qb9WspNrtbekqik6BAaFn7F7+NZ4ywVly+EtXCWzV7PzCU1sfCWCZG7x7b?=
 =?us-ascii?Q?vtlEYX4erG8LBQ/jE82v8PX8aycvYhGXpEX/UefKtwpahC9CoPYLsgweJmeE?=
 =?us-ascii?Q?LpEGGqxArKOaRdmTWX9czdg7b9fs6AtP/zBPeTEzK8CXDRfDBHBqTXPptU0L?=
 =?us-ascii?Q?fRFon5ooU1XZpYZfnSpgnO2RYyk8+0WVPInXoJ70vtDEZW4S+wRBgTxVZmTn?=
 =?us-ascii?Q?adnCPCkIzmk0OzsTAT+aZ0CaimVSi3hV0ptZiZ80nIa+IoYrxjC5Ed3TehFY?=
 =?us-ascii?Q?zuG0Mmhq27bO27dAySi1TuM4NV81AQuyIH8nxbcFkdUR0i1GKUB9PJr//Alq?=
 =?us-ascii?Q?qX1K6da9RVt4U1PMlR9iylkDF/caaujnJ/ZM8m5Y4QviXpVC1eeA7qiN3mfV?=
 =?us-ascii?Q?AcfPB2M+anMFVudhegQRfOgMH5InbGzmdAg7iTYr+9KtqjHc6HUHd5CKy6qR?=
 =?us-ascii?Q?oR2sIRd+dw7ew87bO9aBEny1Qz0lPPxQwmLYfzcEbWmLjgpIMuzyrOAbo3Hv?=
 =?us-ascii?Q?HUkwon6tnmfqbPIHDRmvRHRClkXKsBMMNrYfWDSYiALb9wIePTBFpf0a0dFD?=
 =?us-ascii?Q?iAC3eOtEyP1TcGSy5/weMQGtNjDsDA9mIHp+s1iPxc+OFSKlpTWRkVPq9KDG?=
 =?us-ascii?Q?iB9zVQuortRrmxU3aK3bpFmvC+CcBO3FWea2jvfrtrGCwBcwSwHqGFLozg32?=
 =?us-ascii?Q?exzRajJbmXo95DgqEsymdbCcTp5+NaoJW+b+WptxiOEP1QbubqTC5xDmGswm?=
 =?us-ascii?Q?qEgMD+HmM27XTgUBf5EoyPfNnsr7x1vkIzux/pd4b/vtlRcYpfJOzeurqu/T?=
 =?us-ascii?Q?ddkYV66bzOGm72Bz4Zvw1p5Mr9rfiIC46UiZ3eWobPQCdPWHjqv2E5Y7P28F?=
 =?us-ascii?Q?ylU6jwhTsu8sH/3MakrVU56MgmV1xgLOMxulq1vPLOQd?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd14c0c-5645-4b79-ce4e-08db4cf0cfea
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 22:42:17.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btYeW4h5gspf7egypWBLFwejnkCSuAQ4eMVZB5iEur5pjbIPwfosBKb3ryjQYVFWrRlklPJ6P0D3WD/drd8/6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB3811
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Commit 572086325ce9 ("Drivers: hv: vmbus: Cleanup synic memory free path")
says "Any memory allocations that succeeded will be freed when the caller
cleans up by calling hv_synic_free()", but if the get_zeroed_page() in
hv_synic_alloc() fails, currently hv_synic_free() is not really called
in vmbus_bus_init(), consequently there will be a memory lead, e.g.
hv_context.hv_numa_map is not freed in the error path. Fix this by
updating the goto lables.

Cc: stable@kernel.org
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 59eb5fad12e7..c41e6ad0cf64 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1525,7 +1525,7 @@ static int vmbus_bus_init(void)
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
 				hv_synic_init, hv_synic_cleanup);
 	if (ret < 0)
-		goto err_cpuhp;
+		goto err_alloc;
 	hyperv_cpuhp_online = ret;
 
 	ret = vmbus_connect();
@@ -1577,9 +1577,8 @@ static int vmbus_bus_init(void)
 
 err_connect:
 	cpuhp_remove_state(hyperv_cpuhp_online);
-err_cpuhp:
-	hv_synic_free();
 err_alloc:
+	hv_synic_free();
 	if (vmbus_irq == -1) {
 		hv_remove_vmbus_handler();
 	} else {
-- 
2.25.1

