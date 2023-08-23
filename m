Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28458784F36
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Aug 2023 05:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjHWDVa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Aug 2023 23:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjHWDV3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Aug 2023 23:21:29 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021027.outbound.protection.outlook.com [52.101.62.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AF4CDA;
        Tue, 22 Aug 2023 20:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPAEUofFiRpGxan4j3EFpivbTC1tPhJqubmB7V9QryLm99myOK9tCs7kAjfUxx04IQ3pMxEQ3RycTXPItzW/qEnVA+RC04wpg/rC4lRLKHPgRJKrDHTBPBKijhhFp+IRhXnV/UWzLQ6sNYmRVdlFxJWw0v7oXm/j6NIKSeiRWpZPSU3Wcjo9aYSncc9nQ/mheDe9LeGgfAUbL9unJJWcE6gebynuxRfR1SJ2hFpgPCo8lp3dVo/d47GBLMm8CWK9vyF4IsZAfQfKpaQVkMIY4V3bb0rp1XgG3Ji/Z2i0YIgK2DO5q0q9dN2oV9D+lBCPR5H0YAqxP+gUZzzQS8UtRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4MU/idsLDY5yWI/3BgHoxdQiGd04oS/zEIrFpGe87o=;
 b=PetEhPPVkS+0TX/5b8Zm0YQ6yGBgg/LpWpKnoUGyx9KcfKAm65AyhN0zvV8wahcEuMFPBtSSdMtdhowM9DCILoXeWjfDfpm5thP6OshkbhGsyivDAlS2RmOmm0rmyjLOhWoE7fcME8UkebV2r7mpqcanGeQrjngdQoqET+tW5Rpa2CUJAh9fPjxIBHdvopBg9Ac4wcw9t9hhQlkLGpwW2ZjshtBnO1zikjkgOH/pHKwdOolsdxrU9ExLrenULpQJCMj8K4VblQC/vGGquOoTeEQ4t1GhPACg06cgaJWya5IIf2PBx502YNYvOukEe1c8P6a/sUjFoiFSbj+UUJKyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4MU/idsLDY5yWI/3BgHoxdQiGd04oS/zEIrFpGe87o=;
 b=HeC7x/1ZnfOHeJawW2merlZP1VofwU/yssZVv/dDpQ8zX9CPA0CVWOoEm1rU2nefulDrLi3GwBqQFDS5kcHRZnL4y6MPJnIX279lzkrvmzfSdkUXQKGpxE77VJlrv+jIiGRxFyWwD7/zaeXaETJec2aVyMVBIp/XRnie6KXHxxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by SA1PR21MB2018.namprd21.prod.outlook.com
 (2603:10b6:806:1b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Wed, 23 Aug
 2023 03:21:24 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.005; Wed, 23 Aug 2023
 03:21:24 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-hyperv@vger.kernel.org,
        mikelley@microsoft.com, tiala@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, thomas.lendacky@amd.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86/hyperv: Fix undefined reference to isolation_type_en_snp without CONFIG_HYPERV
Date:   Tue, 22 Aug 2023 20:20:08 -0700
Message-Id: <20230823032008.18186-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:303:dc::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|SA1PR21MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2dc644-7fc3-4533-4f18-08dba3880688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBopzEUwAjvhgVcDj42+t1Hz9aooUWVg2xu91meqrqrycx6PtKR7Jbi6dcCvPd05Tc3s4sasqNVqYnUqDUW+iHfowdBj/G1z16pFTax53U3ZzuaZeAGWpZJZMioi2REyw12doKMAMjTVJwSCJp7MdcNOuKwZLF1a1l0mKaXddqrUrvl4SFE2i4nBGjL6ma2p6iNcTPhLnKwN64NDyJ6hc64LkstD1YHhyEvfjBclFkB3X+8IFHSesoBtp6mfdw/cLv4015uRPNsrQhrRtm4M56XTbqTuSJjBMLDXPo6dFH67ilmD+9sPpZYuV1hiSaPgtBxA7v2BkjKqsPvgRg1r2ph2cWikRguZGqhYICZ6HoG3FoznhXKCc+P1pJyDYCtplYEdaN2VNxAW/XEekG6E/PiyiXAbICPp4IFWDX8zfAnRqUklfDxw4fGl/TZgkxpszhxdxGrscEYhuKCNMD+POlBT7dK5sJj6D6c6JD8aQnGmhcL8P3bphjtu9MlfML03Q0HW+Y60UfFjBUORRPol55CFvQA1Q4m/0aAGulVT/oVfRTCBaSIzGeN0IEHCjLuLc4fdw0LvPOGxnuhqbfLsYJKcxgR6d9egJSoMNWPSu4gKKvcRHb5GTTnvb7YkZoqVg6mmi2Ijg6BATKQlzShNSy6gfprI2hqDxnEvqczAQBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199024)(186009)(1800799009)(5660300002)(12101799020)(921005)(6512007)(6486002)(6666004)(6506007)(52116002)(36756003)(86362001)(82950400001)(82960400001)(38100700002)(7416002)(1076003)(2616005)(2906002)(83380400001)(966005)(478600001)(8936002)(8676002)(10290500003)(41300700001)(4326008)(66476007)(66556008)(66946007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rj6Dx5FsM5Hxan7CKsviTfqOCZ31AtsZf7nPvMk0bTAmOOeemA0aWCZUfbvL?=
 =?us-ascii?Q?fQipD9JxXfSu8lDa8tM9akeChUrQ1yHSwKqowV81ym9q9NjknCz96QnZQtjG?=
 =?us-ascii?Q?LxKCdLpzQJTcYD+QW9nwjqdfJzF7EUQT/aZugRWngju/Uyp1g8ie3pvZI6KK?=
 =?us-ascii?Q?T81JOEcA9NyKcsa9hIQxsc7YVXG+d5nZiScynr3mRVEi/MvG/EW8g8+NYtlc?=
 =?us-ascii?Q?doUp6AKS3xNkUTHUk2qIU2T+Zv7ZzCfrfZ1crk6e1MIkQeG7ct5nJk7ptOXA?=
 =?us-ascii?Q?bcRBrCBBI3dPGkRY02QJKonwDAjLlumLO06Zdv8D5ZxJqWoy4EsLSH9gUtSv?=
 =?us-ascii?Q?sth4hbo+dM7MnlUb0frA2GfdNXeFmX8/Crbp2X6VsgKx0V8NGppK31GMDSUH?=
 =?us-ascii?Q?xS4Wmtj+FsdJZeOSfhBMGqHAnhAGoKvDfvz/8RkC9vcc3qDDGkRsM6XjqvhR?=
 =?us-ascii?Q?QsWXBHOx9RgR6NE2rHttiOKgpiOrJAFw/Hezz8KoetUGmRKJw747i1R+CDZ6?=
 =?us-ascii?Q?dzuwx0vOy0uc9JrdIIJkm9BczHLu6dD/1sQOAhqtUlHLmeaXMpq4ArH2Sgq+?=
 =?us-ascii?Q?dMgaMPjn6CYx812ubnV/F4YIZ23kxcqtulod7vFlF3IcskVDJydYqQYF7z2T?=
 =?us-ascii?Q?GykX2yGLb3Q22ltS3rZYGwWZOJUyJGwvPSveyutNDsaiYsH1miREY2iipwo6?=
 =?us-ascii?Q?5PlrKhVkbeIzMSzzuXrcdwy0Cbeg3KOo3HUt6d7wwODzbUmutopAmdgzNDpt?=
 =?us-ascii?Q?f7gY1Uqrko58gt7eZPe2ojRAtjKAKReSvXIBG+k9JfRxJl+8rfmZBcHFT1Ld?=
 =?us-ascii?Q?ZJLUvf6vcpyJdED6aLMRtSFoAr+9PFYbSK4fSMUtqJQymlqpNUDUYUWnk2EU?=
 =?us-ascii?Q?RIA64fo/dOtlvBMX05xQAKUMGy2qb2AeEZXeHn/2AfkL6gtw4+4HrqbcT/+q?=
 =?us-ascii?Q?59+YO6w1b0KrbkOj69FFc16Elf6CuVJeduuV8BA4021UjRpLZ2CKvfhb8NiC?=
 =?us-ascii?Q?mO919RpXpvxhszPPPheLVxDzosSAastskDtNQwiry9S/LcSpsus2sKSEoROB?=
 =?us-ascii?Q?Se1ZWjtK5ycBfO+FZobLyeWeLCxLmr4DMPO1kY7ZWWSIUOTQhDBw7dI87bD6?=
 =?us-ascii?Q?DRleaA1bKpNSg+BlnO/IIdpDRKDu116LsHp3Yy8VffJ64X9bbVBli4unJMXq?=
 =?us-ascii?Q?/AZ5H397GF6J5uEdXG8ztKnXJYty/F962z1WrpfurM5WKuvXD28sttWG869K?=
 =?us-ascii?Q?shMV5EKMjHoMZei+FF6q1p3BiNhdYYEhSP6oRQp7yTz3oBy+4/PHZeGFEqXE?=
 =?us-ascii?Q?WCzdS1DcgytwxXC/Ov4ddFeoyp49TmWN30uHvi9URB053Ta2zo0zUC1DdoQp?=
 =?us-ascii?Q?URW4Mn1y4GraMmsSA3pnMfLBNIvhPRNAflxwV93dqNNShF6x9ZMhCgcttCAR?=
 =?us-ascii?Q?VJiem3GG0OT6mRUNJXTD8jPgmDLO1gL77n2yN0tW/EKLzXnMPiV+3aHcDvNk?=
 =?us-ascii?Q?nhU1hYrTF2PsHxDaQE57lt6/l6ibqnWXnUq9pokrS0CFjw2iAMFapM75grvQ?=
 =?us-ascii?Q?V7ZYbV6cF9/5gW8L19s+S8gByf9dGmBUhiFWXAdx6NvLK3SKnqJJdM5mdjV9?=
 =?us-ascii?Q?OamdckLr7BGCXsZ+LHcKfCLAdHOwTTMIiPmLw12GNJzw?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2dc644-7fc3-4533-4f18-08dba3880688
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 03:21:23.8022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORaDcYif+HAxxgeZZWOKehmY4DKnjMxphLYg1UAy1UZmwTdbmH0EOMGss2jLdnBc6EfVrKeNZP1rQP4v0EAuzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When CONFIG_HYPERV is not set, arch/x86/hyperv/ivm.c is not built (see
arch/x86/Kbuild), so 'isolation_type_en_snp' in the ivm.c is not defined,
and this failure happens:

ld: arch/x86/kernel/cpu/mshyperv.o: in function `ms_hyperv_init_platform':
arch/x86/kernel/cpu/mshyperv.c:417: undefined reference to `isolation_type_en_snp'

Fix the failure by testing hv_get_isolation_type() and
ms_hyperv.paravisor_present for a fully enlightened SNP VM: when
CONFIG_HYPERV is not set, hv_get_isolation_type() is defined as a
static inline function that always returns HV_ISOLATION_TYPE_NONE
(see include/asm-generic/mshyperv.h), so the compiler won't generate any
code for the ms_hyperv.paravisor_present and static_branch_enable().

Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
Closes: https://lore.kernel.org/lkml/b4979997-23b9-0c43-574e-e4a3506500ff@amd.com/
Fixes: d6e2d6524437 ("x86/hyperv: Add sev-snp enlightened guest static key")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 26b9fcabd7d95..c8d3ca2b0e0ee 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -413,10 +413,11 @@ static void __init ms_hyperv_init_platform(void)
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
 
 
-		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
-			static_branch_enable(&isolation_type_en_snp);
-		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
-			static_branch_enable(&isolation_type_snp);
+		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
+			if (ms_hyperv.paravisor_present)
+				static_branch_enable(&isolation_type_snp);
+			else
+				static_branch_enable(&isolation_type_en_snp);
 		}
 	}
 
-- 
2.25.1

