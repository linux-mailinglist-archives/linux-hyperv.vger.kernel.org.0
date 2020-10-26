Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B01299009
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Oct 2020 15:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782226AbgJZOxz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Oct 2020 10:53:55 -0400
Received: from mail-eopbgr690095.outbound.protection.outlook.com ([40.107.69.95]:52100
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1782213AbgJZOxy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Oct 2020 10:53:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Clr7/8OQeW9BEId/a/3ivewXnf6eNCjk2UuSHAliJJ6yLcVCC5HSBj+APBNm3xrep4WpDr5SyePpXcHvJhtlwriyYNlMyz/L/Gj4cEJ8rgW3YtdzdnyMxdLpfiWvbTi91Gyzy3hi1LLOaaShbk2V1VdSFuAXErZMTsGIRMT6ngVCFrP1CsY+xAtbcd6Zoj3d0SF81kiL7SCA6eTjJXgs9pVnKJRXKqveQiI14KmoGRqed12QPXg2RMZqAZGgu3rJ3bRP5N0o5mtwrBF34zNAOOQCALd4uqAGrJ5Kx3LdmnH3vkEdbfZuLbC0AYClmplu+aZBnw/ooUSGMP4JPCLXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxBRYOxNVOlLqF65LkfLnpnI89PrgYu+YGlQrtVIkDw=;
 b=LnBv4mcLuk4QLmDwHo3kl/4B/L6MLteeLM2Ttr4m5D3qrf6UI7EmBBNJaTBktPIQ8zmMNphk2Ag/vvzDkVk3TUaGXbj5BZIj6/GTbR2uyhqBlRX+6aJ8FKREOKNyjafDzxCEcVAc1VtMkdmIlnrPM7c+g5aT5v0zQ+x+puZvmcK6iLlK+tbWKgOfB4COBHbsBP93DBR2UUz1A7KthcobUmTu/SlB6K3ywcyFwUc5C46sosC6PtJKAwpXUIz1db4aJwzU8Cgftz7yNhkSu/zx1DhcZ8wz+7umYefjgHLp7ppnzg5p3svbZuR3bIyU+tZqns0xSYldssvuX4q/vGYEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxBRYOxNVOlLqF65LkfLnpnI89PrgYu+YGlQrtVIkDw=;
 b=CXrk6g9oIg0bgYnYzemaf1q+6xExkOro4VqRJjgSRH3oGBduginGjYVUeCTrtf/07xto0GdTbxuTJYa3Bm127xOewLyZe+DASwp4npX55c3YOdYKQRkMCh7mPLPMKZw+AYyTUxZ8oVv20mNFtOGSEp9gkOBjTCLbdbtTP3Sz5WY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
Received: from BN6PR21MB0626.namprd21.prod.outlook.com (2603:10b6:404:11a::12)
 by BN8PR21MB1154.namprd21.prod.outlook.com (2603:10b6:408:72::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.3; Mon, 26 Oct
 2020 14:53:51 +0000
Received: from BN6PR21MB0626.namprd21.prod.outlook.com
 ([fe80::4803:32a2:a082:e24a]) by BN6PR21MB0626.namprd21.prod.outlook.com
 ([fe80::4803:32a2:a082:e24a%7]) with mapi id 15.20.3499.015; Mon, 26 Oct 2020
 14:53:51 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, kys@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] x86/hyperv: Clarify comment on x2apic mode
Date:   Mon, 26 Oct 2020 07:52:52 -0700
Message-Id: <1603723972-81303-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [131.107.147.144]
X-ClientProxiedBy: MWHPR14CA0043.namprd14.prod.outlook.com
 (2603:10b6:300:12b::29) To BN6PR21MB0626.namprd21.prod.outlook.com
 (2603:10b6:404:11a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.147.144) by MWHPR14CA0043.namprd14.prod.outlook.com (2603:10b6:300:12b::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 26 Oct 2020 14:53:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b480c1c3-7803-418c-9ae7-08d879bef39d
X-MS-TrafficTypeDiagnostic: BN8PR21MB1154:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR21MB11544A9F93C05607B8299592D7190@BN8PR21MB1154.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmfJ51XzbA0bLkpiJcDRJa3y3PDvBPIkLKMCsKAWptXF10HP4yF4mUlxDsqTvJCvcLiMkoED6/cNov2+L52cl3epB86lP18GLYmpCTwIb2fctr2vuhn2wtLsXw4anLdaJfgW+Ga3jTtIGw8lWAMKS8M+e+54Mlc0CQCICiQ7lD1molnqbx314PQiVLYXjw60QTCS8N/iQZeSrv5vBymAF60jMJHIJKBTMWM8VqwOrw2KwOuo+59MJ7hfa24ZHaAK5ASWbWZkxyFoo9qQr5RpEN2smRm1xgGkjt4OjSTAhejqOoM++FfulOcbBhCJReHZDh65wl9qeLmnEMuobu6T/tCprfMbmR5i7zHxkVLaVEpzWCx4uyZewOiMMmsa2a+l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0626.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(10290500003)(82960400001)(107886003)(7696005)(186003)(26005)(4326008)(5660300002)(66556008)(36756003)(66946007)(2906002)(83380400001)(52116002)(66476007)(956004)(2616005)(82950400001)(478600001)(6486002)(316002)(16526019)(8676002)(86362001)(8936002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: EMseo6FJLPRFWlP9F7HK3mvkdmD5TULj40REkEAjxpqfw0b8VDfCB7TXRTeUQDLMe7RPYlcClr1ww4y7Ii710WDyVwxF5oXrNjlnSD/nR5fefQwY+qQeEZ3q/YLAgA/xe0bDLsRZMAYT+/0OtLoTskdD1cJ56wvXI8KGg8nwzGNT2IqY1xYyJa5xffhm4lUR/t6kAfO22toRcpvGpyzdkBENe6lRieNtsELME8AtsoZjarOikqiCaRozCjFXxLk71FIjiDFjwND3RB0ZQjfUHYrXwLD6C3TXzwBWsDpTqjhjbmbdbgKJKDnGiZZwdmLCXkC/qwM3vU4qwthD6cipAiE2LXnX53cb4Wrkz4dtiMbwX0EDNDld1gNKx+JF9rjA+4mvM/rjsIfc90cCOzThme1BL1WuwYbkYipgi23lMCuUxbMT+djHw2WJvR3bheOmAyy5sAysYXUZHEt0R30hwix2FC0iO8vnJdjUrxSs38NmamGAXBgWKmycgC8oh6Sxu2CzsnVB0ZulvdWLb7B6zNLncznCRVxVctzqheJzCPoM/XDs7vhfyU7LC28XvHmbrhY0c1r0CUdK2MtfCbnldiiB7Ll9fPfT4QMAwUmkNCNBJQOPmtRWqy6BiHJ0gDzY4gKpEsSnykYehUYO54970A==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b480c1c3-7803-418c-9ae7-08d879bef39d
X-MS-Exchange-CrossTenant-AuthSource: BN6PR21MB0626.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 14:53:51.3753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cu0Arp1SiWwu1Br2Igag+dInu7z20BKxih5Uko3klRarxuGUsJ5+1MuiKJpQGG7UV0oZeNUbvVjPdo+Ext7/7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1154
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The comment about Hyper-V accessors is unclear regarding their
potential use in x2apic mode, as is the associated commit message
in e211288b72f1.  Clarify that while the architectural and
synthetic MSRs are equivalent in x2apic mode, the full set of xapic
accessors cannot be used because of register layout differences.

Fixes: e211288b72f1 ("x86/hyperv: Make vapic support x2apic mode")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 40e0e32..284e736 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -273,11 +273,15 @@ void __init hv_apic_init(void)
 		pr_info("Hyper-V: Using enlightened APIC (%s mode)",
 			x2apic_enabled() ? "x2apic" : "xapic");
 		/*
-		 * With x2apic, architectural x2apic MSRs are equivalent to the
-		 * respective synthetic MSRs, so there's no need to override
-		 * the apic accessors.  The only exception is
-		 * hv_apic_eoi_write, because it benefits from lazy EOI when
-		 * available, but it works for both xapic and x2apic modes.
+		 * When in x2apic mode, don't use the Hyper-V specific APIC
+		 * accessors since the field layout in the ICR register is
+		 * different in x2apic mode. Furthermore, the architectural
+		 * x2apic MSRs function just as well as the Hyper-V
+		 * synthetic APIC MSRs, so there's no benefit in having
+		 * separate Hyper-V accessors for x2apic mode. The only
+		 * exception is hv_apic_eoi_write, because it benefits from
+		 * lazy EOI when available, but the same accessor works for
+		 * both xapic and x2apic because the field layout is the same.
 		 */
 		apic_set_eoi_write(hv_apic_eoi_write);
 		if (!x2apic_enabled()) {
-- 
1.8.3.1

