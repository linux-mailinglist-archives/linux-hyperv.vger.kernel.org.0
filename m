Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F621B1244
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2020 18:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgDTQt4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Apr 2020 12:49:56 -0400
Received: from mail-bn7nam10on2132.outbound.protection.outlook.com ([40.107.92.132]:64417
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbgDTQt4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Apr 2020 12:49:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcjKyiIF+GWzJGroIBjS65VWWhbLr4vglc+Dh9tIhKIYh0hF5Tbq1zHAc2lG4usl6QWUKkJRkQU4sRpNGwk4+Ia7jJ9yjXyo3bsm49Qg5mBqlNhFjomLE6Qz+wvcComwbit7ZtUqpcrAy5xMU149GqWFnX/8k+imdMK6NP4IDVkx2+egEMtQMDJG5J/Bn6kUFQEXeKmxiE4fCGRj1gM842BDQZH/Nh9E3iMlyc+Z6H9EbgNKrIPz8idheiLztncgQiAp3GPwJNLx20k1UilHdMZTlapDSL+n4MJOLUACX2/QXH6lN4ww1aqo7m14UFzjvTpGOuTUUMMbg8hhzKRNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TrsWHmGMfVK3UsEYXAjfO2qhKkDM+pHIevmr4NNyzg=;
 b=cbp2QrNfm0MWHxkVfejrJTW4qQxLa2AKTYVA/RfYRo9v/4uo2qbTrfS4elZfgsbe6JrjNg2QdEK+l9EQv3AayrJGuKnjYfUacb9htJgoJDPonAGt5fV47gvVAbb0rMII7zltm4vgjas74z7aukqJXSpj89hDOltBjSquQIIklHZi6qFJtGn3STgQebN4ysiF9DAdiaIjKg8eQEMW5gn22Bb0zUfwflRsbLgAlDgcQkZcd12va5NHBxCltyKn3uT3yFg8amOOoTWO1GaAVoLlxu0fbfMtqMMoBLr7jmntk4tqtnaDd45r4qgxbZs72A87ndFK7/0ih4zGI4ouwaqTvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TrsWHmGMfVK3UsEYXAjfO2qhKkDM+pHIevmr4NNyzg=;
 b=aB/kj+RCCYGjAnSJeDe+VBxbzeVpjX2vEsIFKq8Gb/piWcdo3pFN/T9ZHWw/cv9IfC4aEIMjHXf91ITRX8pneODMZd645SBrw7ITbeIn1ayiPoYyxy0szpgLrG7VgwqN4SuPndzQkMpM18WCJoTpbL3t/RxXb1Ar1NvT/tQrniw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
Received: from BN6PR21MB0178.namprd21.prod.outlook.com (2603:10b6:404:94::12)
 by BN6PR21MB0626.namprd21.prod.outlook.com (2603:10b6:404:11a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.2; Mon, 20 Apr
 2020 16:49:53 +0000
Received: from BN6PR21MB0178.namprd21.prod.outlook.com
 ([fe80::a97c:360c:9ed2:12ec]) by BN6PR21MB0178.namprd21.prod.outlook.com
 ([fe80::a97c:360c:9ed2:12ec%11]) with mapi id 15.20.2958.001; Mon, 20 Apr
 2020 16:49:53 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] Drivers: hv: Move AEOI determination to architecture dependent code
Date:   Mon, 20 Apr 2020 09:49:26 -0700
Message-Id: <20200420164926.24471-1-mikelley@microsoft.com>
X-Mailer: git-send-email 2.18.2
Content-Type: text/plain
X-ClientProxiedBy: MWHPR12CA0063.namprd12.prod.outlook.com
 (2603:10b6:300:103::25) To BN6PR21MB0178.namprd21.prod.outlook.com
 (2603:10b6:404:94::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MHKdev.corp.microsoft.com (131.107.160.108) by MWHPR12CA0063.namprd12.prod.outlook.com (2603:10b6:300:103::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 16:49:51 +0000
X-Mailer: git-send-email 2.18.2
X-Originating-IP: [131.107.160.108]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ddde19f2-bc7d-4b0a-0e44-08d7e54ad918
X-MS-TrafficTypeDiagnostic: BN6PR21MB0626:|BN6PR21MB0626:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR21MB06268DD8A41858390973AE52D7D40@BN6PR21MB0626.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0178.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(36756003)(5660300002)(52116002)(66476007)(66556008)(6486002)(7696005)(66946007)(10290500003)(4326008)(2906002)(478600001)(2616005)(956004)(6666004)(107886003)(8936002)(82960400001)(82950400001)(8676002)(26005)(81156014)(316002)(86362001)(1076003)(16526019)(186003)(921003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8Bm5UGk5bJoWscR5lZsCApfJbmBfMSjuN8ZBumklCt5JyAtUOCBaAH6RVYrGpO81KOBTTYu4G7L1LnEC5AkVaRfcBJZBahHG81gm/ubLzCLhhH3FviaaZP2K+SkupEPgaq0QEiSJCu1CwsGN/hKFEg9Ri3a/zWB2EJNcjjt7//hLq6wqfH2vksyDfj09DAQLNZf4qNOUFIaY6NwBgZyTfGyHJ8Jk3dx/AojDmRmcoyADe1+DN04OBaMKY1Ox0XEd36TG9a5M+SwUIV3giIqCW2zIKK/fkY/JZwAcFkO3FVosyh/hqv00SjWFAdaL4bwPIItsSeRMJrxWCQypYLqTAQ4sD303jO9Gba+TY6YLZmCuAOVEf83ZI0Cf4A56ZcvMxpF2pK+Cs6KFKTkHjjyH1JhPMgbAWsmvM2Mm2NW9lXqSk4y8LievWpIXHXZYJMHz/uPKHXrugpvzSZiSBs+kvPIz+wNA0vo6GdKFBdCdyk=
X-MS-Exchange-AntiSpam-MessageData: SBBx8QmRvzF1TqZbt4NjeO9wEX/xuByUr9ReupOY8euHcTYKpNzviEFW/uhV2PElVwKdcWK9TpZDIscqbFu1XUhz41bC4Ili2YAhT03kIhbCRmWWwox13BOcNY1ncHwgX9OQkVclkcLmHgfJoFiPFhjJCLDG+3Xplloq56vu5LAu/rBdjoj+IP//Kt5RA0zDGoIs1BPjrODlDTN857+/Q5tHp9Gt8xXPLalBJNw5fLo4gD07hdWg3/Ox23bmeZ1McWh6+Ua3d1mJhdn6APoO+Rv6p1kqTBfgcbGjHAwsrDu+12c1PyvY/42YnmspdBSFGFtXwReyJzjX/Mt56zLZ+33IU+RwxWs8Se+PEcncrDVZ6zHV8dF3vnyiLrdRXM6u5UbFeFzZzwAHNdRMZ/69wUM1DNoSHXyRTsqn+xcL1jdDtmRxilzvO8roq2zxpIU7YamDunw44pyLwMBHjvpefELW1o/VOh+nQtFpeytd39jSUFrZFE1nRX5wmG6gRuBtdzrZuq8stLcCqcH+OyGD1mxi4ywl0dlVzqadv+GqsIjbSSAt2+UjdjTFmp6VvcGdh79RpkpRfDdk3Jy++cjggYLBtgfBvq15Za8226Rm4CQ4Vo5Ikfem9E/UPyzN11n3iPldlgXHBVbwD2z0/ySk/E4uKER8E/VotqEO2gDkxAzE4WP6ZVpLrjqckvOK9GJglP+C6zSxCGmDdJiXNXw0chfrb69axXDDAJEyjgL1wovF6fCMMZw1dPFr5oRkr1V/XEMzsEJeE3hvUwFNFq4gtkgvC2XOldvKNkjtiOHVeqAX0tD/7dZ7K5lNWxNalOwb
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddde19f2-bc7d-4b0a-0e44-08d7e54ad918
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 16:49:53.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjKkDVFuhSXZxIoCZnk7qud4n5pEvFXyEm7wH+yP7J6VOVgWlh3CmGmrXGIU4uGAUzTzRwTp1FPXE74YraLDqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0626
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V on ARM64 doesn't provide a flag for the AEOI recommendation
in ms_hyperv.hints, so having the test in architecture independent
code doesn't work. Resolve this by moving the check of the flag
to an architecture dependent helper function. No functionality is
changed.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 2 ++
 drivers/hv/hv.c                 | 6 +-----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 1c42ecbe75cb..d30805ed323e 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -35,6 +35,8 @@ typedef int (*hyperv_fill_flush_list_func)(
 	rdmsrl(HV_X64_MSR_SINT0 + int_num, val)
 #define hv_set_synint_state(int_num, val) \
 	wrmsrl(HV_X64_MSR_SINT0 + int_num, val)
+#define hv_recommend_using_aeoi() \
+	(!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED))
 
 #define hv_get_crash_ctl(val) \
 	rdmsrl(HV_X64_MSR_CRASH_CTL, val)
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 6098e0cbdb4b..533c8b82b344 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -184,11 +184,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 
 	shared_sint.vector = HYPERVISOR_CALLBACK_VECTOR;
 	shared_sint.masked = false;
-	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
-		shared_sint.auto_eoi = false;
-	else
-		shared_sint.auto_eoi = true;
-
+	shared_sint.auto_eoi = hv_recommend_using_aeoi();
 	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	/* Enable the global synic bit */
-- 
2.18.2

