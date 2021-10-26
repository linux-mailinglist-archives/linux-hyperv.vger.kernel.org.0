Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB98543B144
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Oct 2021 13:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhJZLff (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Oct 2021 07:35:35 -0400
Received: from mail-eopbgr1310122.outbound.protection.outlook.com ([40.107.131.122]:43334
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230442AbhJZLff (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Oct 2021 07:35:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNgBqDK+zRoCe3ZtPOFMxEWlKs/y3X2KVBL0ZrU46vTApRNSQ47uHZ7M7zMqVykT2N+SvxnjqmFXySetbRLmji4ivTHtNscUtPt7TE8ci+RKjWuWT14WmKCuYI7QuxoK1PAEAA6UUnWpgqda58n0PhpmyJHxZjwYJhLic7aRoJpmmz9UUY9tq/miExoKt5QqVlxbH1pn6uvVt67C3iy+m6KsksgYORIn4VYyAhOzwcpJ8q7h17/QaCmFJuueF0sOnPucLoEE+XwMTCVi5k+UP8C9tyeQe7cm09fOCxmGaMZGd9LZUs7IK0KlPgQNI/tjznmRswDjvTTu6IOxMXT7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoppHjeuf3FV1j75g4mw75fjLGGp+O8RdgFIotWGZTQ=;
 b=Sc9j6ANdDf6SU/SXOAbkzLkzIJRziyNV4twUxDAVUw1l4NAnwaYWMlPQaz323NLviK8g8ktrKhWtFLmwwj9BxkirVxVcQdSsqIF6yDh02+qMCgsVbSQv1RLBHR/w23aEAnr4vEmRruBovsH2ORLuMIL676jE7Krr8/F8Wh+8Ue4jAMLZM40CwRRWnzv2LiYnCHXATLLpu9xBdsi3zRc7J9heZ3ASFQWp9Wp55k2kFsqXFpFjuyBRcb0z1JYSiMRiPhBdq7P1SebR0ArcyPjxQ7gTnQUixxuvFy/0S4ZyzHMIlK2niwc5PT0+gp9JNzZWiJZ+gT1bwJzxVIVMYwBVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoppHjeuf3FV1j75g4mw75fjLGGp+O8RdgFIotWGZTQ=;
 b=YjjjHCTt/g1eeLnROshlwUaRrv6nd3vqMUaiO+i1FgtYCkYhUSMef4cSZLznJULukYTRU1sFjErPMdAXQNTqoC20BgYLstHGxuYYFSNcbnn0MdPbKmkQ3RLuDrudrqc6r7ohzJ40OGlpz2doOfdWH1qeVEwoFoy7Ig8SlVwf/iE=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB2121.apcprd06.prod.outlook.com (2603:1096:4:9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Tue, 26 Oct 2021 11:33:06 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 11:33:05 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] x86/hyperv: Remove duplicated include in hv_init
Date:   Tue, 26 Oct 2021 07:32:49 -0400
Message-Id: <20211026113249.30481-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:203:b0::18) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (218.213.202.190) by HK0PR03CA0102.apcprd03.prod.outlook.com (2603:1096:203:b0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend Transport; Tue, 26 Oct 2021 11:33:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fbb92b2-2365-452c-1bd7-08d998746059
X-MS-TrafficTypeDiagnostic: SG2PR06MB2121:
X-Microsoft-Antispam-PRVS: <SG2PR06MB21219EE9743509FD57E41726AB849@SG2PR06MB2121.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /gIlDjWGo9R8Zytqc1MEhu8oFkgbg9junUVLLr2G7MJd0SuUcVlAJNmuE3KNNM7DzbIafL0gC+Jt6GQv6HOVN0gfB+MTEjHe4bXSdwQMPGIEabxuMmZEtg4Ac0/pLi2Urb3MPF9TWw7/ts9dZSMxeQHtgUr2750GfN7m1513xnCQ4r9I6m2GfgBJu2nJznP452PxjpU5E6o9i3dKAJHQdw0NBJOIASTmkLyLN82het46M+Y3oO7I6jLXXyH402XGRZLKfu5ageLiVigqUsapXMITqDbucvzRcDhPqbRDjRij5an2de0ZgTLXPvXQuVwlwgd5lnw6WXOdcYUNaiuM5T7BbpL9zh054mQ2Wl+p0VgGiu3eQn65u0gDkx1pxvspli6SmTEp0+LJseVZRYZ1ItIoR9hNU8qgM7o0IkLUDz40XW7A8AKgf4vKl+865hu1CGbRoGypLpnWyoGRwT5/pIfnwwQzoMtPYpfm1hZpXyMi2IArKj2UMaxaW69eK0rTw8lrrig3gci7+A2GpXBQIchzvS2WD7sUcy/z3JJbXEOtwdCgXiejflKgblVguUrAf4P+dPVB3JIeof8WyOIzNLi2MICWHorbhMNmjudwIOpB2PexBqEQsgjmOqjbSCSw7JU9mJ0pnJR8STnJDlJz8y9Mlwkw/qFN31Txl0HQudi6nLHt6MSANTV13Vqc4laQcgvdozyt/+bnV/tREX/7XlomPvBWgrsuNTVtZ90tPa8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(186003)(316002)(83380400001)(6666004)(1076003)(2616005)(956004)(66556008)(66946007)(8936002)(8676002)(66476007)(36756003)(508600001)(4326008)(6486002)(6506007)(26005)(107886003)(2906002)(6512007)(921005)(52116002)(38100700002)(7416002)(38350700002)(86362001)(110136005)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KzDyB0NbYs31dl03d+bo3EsJGE07/Ot+4G0wBOdFbvqEMqu7J2qrf75PFiGA?=
 =?us-ascii?Q?mWZoNiqjnWwhCVO8rIw1p+l7t1lX8F+T/P1NrFpW3xYNzWtKgEmdVCIWmeO9?=
 =?us-ascii?Q?hlNt1VcUF15rMOmCeB5ge0GG/mSCpfLNhjooACk84oA7Omb73Ue7Og9OYKj/?=
 =?us-ascii?Q?KwrEvi+dnYTYkXC2+l+9hQt4vqot8dfZ8hELpU1i845X+CpzsRZvgPK2pnil?=
 =?us-ascii?Q?6m11UA7mfxy5JQ2xoH/IBcxXg0vZfTigjstt8uihNWa5dbH8+m2LxJLKQjZ5?=
 =?us-ascii?Q?GkFLyL2G+r0Di8JGMjMBcl2D6GtIyBRQSWRTPI/hbqV344CWE+4igXe3rF12?=
 =?us-ascii?Q?F7kcgTMKekA7e6jMkMtBUgUbqDI3//tnCfjLnzcbaRnehRzA5MI17xVMIdhE?=
 =?us-ascii?Q?e9WrKX6DC+o2RA+oVWcqYX9lhAlgClkHOfhWSTRy1NvDFznpVuW+WBCioy2B?=
 =?us-ascii?Q?y7TrySdNH4dMVi5CGr792S5c6sy5LbHuo8ywl/KiagNocBxmGgavaXTevdCq?=
 =?us-ascii?Q?I077sM7Epdcbhq+47+sWndYYT0WveGsY4M5y8b+BWyqPn8fiFXoLOR0uk7YN?=
 =?us-ascii?Q?mV7j96RbMOCNWxBEXHoImE0ydTbWbfFFQgvL+92tnc9toHft7AiH+rvRaSsF?=
 =?us-ascii?Q?haPG32TGt7cJCddAW3b84sudu/uer2acHWib27LWFRJuhZGaRI7uaKm6wPTw?=
 =?us-ascii?Q?/5Ulqs5r8NV8L3ruLSUV13brkiyguWm3XBIp84yaeugo+OAxbGrNj0dAnOlN?=
 =?us-ascii?Q?9VN9Mr5iia1b1Klkum6eKTsXZI4LdMH/wq6aqSIpjx7R7lQ/M0DIC6OzWM1G?=
 =?us-ascii?Q?hWhtiDTHv4kO3Bt8SKvCnX00QnurWaZyxTNI6cERbKh2+9D4mLB6Vz5YS78/?=
 =?us-ascii?Q?VwGJRekw8irN2uNj3LMKtR5JgbD4Uu0gsj2vTfFc0wAghWJFdr2xwEonD1x1?=
 =?us-ascii?Q?gYWYBPK7hwUoaAuQwh5Kc2xU/I4d33eE/Y+0+ZOZ+MiALS3GJQY8CTmVAVNt?=
 =?us-ascii?Q?gWID1OmDXPU9zOe8zL5DbtDnVO/f0e+RZDgyAHdllijpO+paNMmeHl6OvP7Y?=
 =?us-ascii?Q?bqGllZzl+kvn+wq3R+AUkz59i6jLIOST/Mq6Lc6TJkrXxzsr4wRhgJVForZj?=
 =?us-ascii?Q?tufRtm4PcLl6I7T/7U2yRvYYQ6bjYR85iEPM7AVdw6RvRjQGaOqGY2L1wL62?=
 =?us-ascii?Q?8tEs5cVSIM3qb4I+oEcn1Y/NegGnEIiF+AUeVUtvqeAHB7KcUpGmQHNFWf34?=
 =?us-ascii?Q?R2ZAaPq5EVdLJCLlT9tZUkUKSkEXEgqcQtY7dHY+1edlUwuFt3bGEGENZ9TO?=
 =?us-ascii?Q?Kopq2cBWBB9RFmchgmNQta+9a3Vtaej5g9UepIiggnGtKFm6FgSojqKDEnQy?=
 =?us-ascii?Q?0oupR1QByqFUwXAI631HPF5+ru9keYpB7Kr9UzHdLNS7ASRVGxPMJwFICn71?=
 =?us-ascii?Q?DugAUhuBbFSqVfheU2dOqUEqKIEyfKZ5ySi2QOBx8SMxnY4a3Dan5Fj6mWVV?=
 =?us-ascii?Q?ySNQtRxUZYNoQtyB0hFTSObHTPef/A2C2Q2XeRZRZQA22CeP+UOOE7piWG1c?=
 =?us-ascii?Q?PyadD2mj1Hs/VtMxL15/aMmBf9FPiN56Ng2qcZyuX5JPbWcDc8f7KasxRl/y?=
 =?us-ascii?Q?dd7+vJuDv8o87Z2SLG2uTVw=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbb92b2-2365-452c-1bd7-08d998746059
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 11:33:05.2535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvqw5Fof3L7UKWxx3wczu0ilNgmQec5O6AHslL6OBKJjHiahMlkTTjdt8um6MXSsWxNrm52zn2NRR6K/i8BD7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2121
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fix following checkinclude.pl warning:
./arch/x86/hyperv/hv_init.c: linux/io.h is included more than once.

The include is in line 13. Remove the duplicated here.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/x86/hyperv/hv_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index a16a83e46a30..4fb7c7bb164e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -20,7 +20,6 @@
 #include <linux/kexec.h>
 #include <linux/version.h>
 #include <linux/vmalloc.h>
-#include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/hyperv.h>
 #include <linux/slab.h>
-- 
2.20.1

