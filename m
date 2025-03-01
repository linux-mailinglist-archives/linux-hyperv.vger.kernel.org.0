Return-Path: <linux-hyperv+bounces-4186-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84237A4A7D3
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Mar 2025 03:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAAB3BC38A
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Mar 2025 02:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB02834CF5;
	Sat,  1 Mar 2025 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bxcd4zIP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2131.outbound.protection.outlook.com [40.107.94.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437BB3595A;
	Sat,  1 Mar 2025 02:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740794685; cv=fail; b=fzXilfS5MIwzEfcOYSUYybBSYH866Usdr6VvRpukxAeOJ78Aak4kbRp6g0fpsZox/J9ABCREFKRhxpmajJ0XTiDLYA4Fge2ZciNJSrvT0lpOBXZXeNdwEvs5sx7uj0riIx4zfdSHDlRSbOWourzGCmGSXQQMVjUliUm23CXyuj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740794685; c=relaxed/simple;
	bh=iU7EB8ieAmgNUkfg/UNFjj/Tf0dJyN5ilq8GW46SJW8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S/c8v5ScsNRGD7jRRgRxhtHCbWZ+3QCZB5xE76epFM0H7TLgaqhQbr8XWE00aIkNGFDrD7ccoDkXpJ6IKA6PtxrUxWbkhC7eXTUWXui+veRq4k+xuER01xlQTKsuiMGS+9Sm2wOcTPdQk+VgzWa4k4ri7pYdBNMRfxy8I1KAi0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=bxcd4zIP; arc=fail smtp.client-ip=40.107.94.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHMC3YGOg0/cQLXnX6vCZEObwgjcW3lMONjlqxzNH+L57fyTKtNTI7tMv6kdeFik7gV//CqRfC4C6OcCuJ0WocfMvZHWtx18txoe5zP7LV6EdisqvK79GzlvYxaDArTHGotnqAtP7Obr6HNeWU6NzlWRFNYpVroKm+Qqge3FRf38CLjENq7qEuSS8dzCGClK4NGkJwhGoDS99jw/K4n/vOeHX5nZKY+4O2O6Yi0UYi8y6BdTx5fthXnF3sMDhvxSFfiLcQlef12Es7OSB6bkpCZH5wLGlO79MYAfc0AR4RwUOcEMEp4iojodNjHrrQI5IRiiPC6/mYAAQswHO+qmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqzAPYNeJTdldjBsKQe0QDqi0eV6DRSDWzJQjgx/vAM=;
 b=hSO81tR/xsJrpTZpBjR3wRm9qwRdaMPrttkoW7WA28HzDhQv0LEETHhmu3Fk0tGtNsiX1+AuwJNW1HY6rqUuOIp8wPlPdUe+qhowmfN6B2B+U+eci3D6jJpEBcnrpfu65oRK7q54/O7i8iYR03EjMl76kQUcl2PnJKzK/ojHemuY+LkmFiHS/a312Ppx2XP/8NPXiCElpBrG9/krtrGO3p/PbaY32Z9bZEMmwBco7fSH9Ue/030Fmnngv+811Zc9c6Em6NAdAyuUjH1EBJ4c5KamuIOs1EF8MmzvJ5CI60N/w2NUNAy9v1iZU2kPA+JD2gINthwMDqVmMVAeuEKrvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqzAPYNeJTdldjBsKQe0QDqi0eV6DRSDWzJQjgx/vAM=;
 b=bxcd4zIPYK70gR50kR6d2Iy5RIvBZWXrapulB5ZYszazC77GETlZijHQHGRlvOEH6lXZ3rdPhcevYOf6J+rJEmuSQgre7tMPiOfgVdpk8o23GMjCBbyo7ASmSNVp0tvD+PK3PNuVv7XD8AG2NVsGLP9XgWskh4q9/BtDLP4yD/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by BY1PR21MB3967.namprd21.prod.outlook.com (2603:10b6:a03:529::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.11; Sat, 1 Mar
 2025 02:04:40 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::5490:14c7:52e2:e12f]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::5490:14c7:52e2:e12f%6]) with mapi id 15.20.8511.008; Sat, 1 Mar 2025
 02:04:40 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	kys@microsoft.com,
	paulros@microsoft.com,
	olaf@aepfle.de,
	vkuznets@redhat.com,
	davem@davemloft.net,
	wei.liu@kernel.org,
	longli@microsoft.com,
	linux-kernel@vger.kernel.org,
	linyunsheng@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH] mm: page_frag: Fix refill handling in __page_frag_alloc_align()
Date: Fri, 28 Feb 2025 18:03:33 -0800
Message-Id: <1740794613-30500-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:303:2a::7) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|BY1PR21MB3967:EE_
X-MS-Office365-Filtering-Correlation-Id: f21ea94e-89bb-4aac-ff09-08dd58656d45
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?QBhs4fOqiMpSdyquC5zwgrBACqDh8rMAmbhlw8sJ+FxBfPly9yWCf3N1tf4N?=
 =?us-ascii?Q?Mlc3eGDhNayOmVduSNit+YiGX6gzBfEMg2FMbvhn2MlExA3X55PHW25eGEiN?=
 =?us-ascii?Q?SBam9zVroUcjB/qUE2HkUZEGWWd6fHNEYB2E0GzLpmGtDG2sdGFSAuBGhTqh?=
 =?us-ascii?Q?RW1dIca0L3NMXccoDhsSEcZAg5gXHa6VtiSwvo8+f2qWlQAxoGT9vV9IyKt8?=
 =?us-ascii?Q?qTphP6PwcGSGANLloQvDyf9jspXROYioBzYy+cniK593FGAujZKLlhnYlEQt?=
 =?us-ascii?Q?jUrQm/KUWHjsKETbTjZXHdO3CixwYESwYt4z/a7MyMloW8YolLcNiuEwLRR8?=
 =?us-ascii?Q?t74OXGr+hazIoxLas3Qpd2cvvNe575ckvFwVgnaUg43oVzvB8gScb/wsPMS5?=
 =?us-ascii?Q?ckfgAhyN6Pj0Wz7ZAg7DWuxQmqFPtm1iTtgMOf9mlawm+VbYfj590CCTmqZ4?=
 =?us-ascii?Q?6nNclfCCCscDh4CS4xSxXUYGdeXNPYmKl65ZPf2w5AZQC2be5zVSJvV1amBz?=
 =?us-ascii?Q?uuxnWiBd4+QQKbQDgBq/cqeRTPalZ1m7coiFKjnlB8Dm2Er6jFvzrq4EXpAR?=
 =?us-ascii?Q?jU8yIgFK4ccCAuhvAQdTW5UB/kMLcGylp5fl83i9/w5EzQiYKzG1yZhGbsj8?=
 =?us-ascii?Q?Zio7mSBBwMOHd7nQrd14LhQdCmZ1/FZFn4B3KJ/Uw3R9M6/lxcxTYh6muUTn?=
 =?us-ascii?Q?ryKBupkGP+ITwlbiGBIL1K/hM2WRSMWTrKluC4cmL7+LMhlh3nD/z0s5i+/m?=
 =?us-ascii?Q?MXNXdkHYsMibqSNsvjmQlfdf57ZpEbjoDXBE8Va6Pxut7Ln05p/yrozloVRS?=
 =?us-ascii?Q?8q+D6OWZH3ZrGVXG0X8OOCfxv8j0IJH6UdXIYnIoTHZjRc0Fn0d4cTIIyCVm?=
 =?us-ascii?Q?Q3F+JBw4WvwyvBZDFXL2jpjUwMQjW+ZQOYaqm9+hYPkWq4K189rpZRYLEKgP?=
 =?us-ascii?Q?89xXTP1n4tp+TzA1HhehD7aoo4iDBC2xgArML5Uzk7lujoKAdjKRZqagvEEo?=
 =?us-ascii?Q?vfcAzmSsw/9hsLOWXRDnjGbUZ/rWi35JvlTk6MtMz/aiEC8LIGqBuBTBCKpZ?=
 =?us-ascii?Q?jVlL23VoI++5ZedM3uodTNTcaBE42QDkrVqsK7FFvpGaI0JTPF2+GvS1crNC?=
 =?us-ascii?Q?z7SbFBeTM4Utr36r2j7YZaKiUet0cUp9qbS0I8mMyOQYcUgASdgIJwrP6Zzb?=
 =?us-ascii?Q?/8gl4Nto9YSz+R+26JOKTuaktuKp23y7SPG7HWrempYaY/P0y9KVySKOGcIO?=
 =?us-ascii?Q?Mm4ZctKIcI5QTTKUTe0mF4YeDNczVXAiqgjs0oXXAl6jBwsCk9hcuou92Nvb?=
 =?us-ascii?Q?1x/nlE1+ujoMfybKO4I+zS7KRommTdcYkt51mQIFaNN6KQDeu5QOuOr89Jo7?=
 =?us-ascii?Q?WTJk8RQWCYu35GQqeqdsyuw4LAkBcTaAoicyTWEezq8RxcYkrm8PYrGgpRYf?=
 =?us-ascii?Q?0IscGjYvTsXpqMcN46uRdkyaVahmRUer?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?TwXdOV6yaBW8AQXq7ylTLWidrvPXBdmX/FZNiEkkYT+YVMH7Cr27F+fQhP0Y?=
 =?us-ascii?Q?EGsVoYokdFR5cFWGOuIHFqZGdP7Dx3v8m741gmpgHWDJVvwKD1UpD71CRSwy?=
 =?us-ascii?Q?JECb3baKSaI67hKxPUnxbecqa6bFv6ohPT9UsEHz+jE5GeAwQM8SvlDzlpXh?=
 =?us-ascii?Q?ePz+7urw4TJQaUNBhwFVM3pAZRUuwr2bkNDBi4ahFnOMPQN++JQENHvAqWl9?=
 =?us-ascii?Q?YXr93B0hZH6Mgt8ulrzNJXfWz3Q/QErb5D58dYLxZyxjFjMsJAdJzGJLt/wJ?=
 =?us-ascii?Q?mwItula9MEB/GnUWXd4hlNqn87l5m3hX5xsiqSoq+r0CADX+muCxk1w7PvaV?=
 =?us-ascii?Q?ZCb1F7m6wPoqsDcNZ3nXFuUV/kPFBvOCn3/Aabn6Ng2R4Kov6CQqnBze/IR0?=
 =?us-ascii?Q?VBeHj2ITFHA8Z3WR+GVneDBM4fn5ESKRMXpDp3sAGtD5i47g3FJK/P/+t14a?=
 =?us-ascii?Q?JkcVHzzoBe8UT7T4XWmysQFtYl1YKfcLizeQu1Wj3+iuGpNYmLdDTHDOK57A?=
 =?us-ascii?Q?Y5Pln+iLLfUzrDvJ3kAAh3tkdtl3CCrV0IGhzMOxcpafeLeg+tjBckY6TreY?=
 =?us-ascii?Q?j++vnLYalLvC9nA+ml/wtXZKi9E2PxoKT30tt9vf8OKpZmmEhrmbV53qbcYl?=
 =?us-ascii?Q?r7VvQXRdQoDt5CxXpQVKg2HRkPpRDImq6rzRGR+wzmTuAA5MJAXs0e71rQ3J?=
 =?us-ascii?Q?F3KmuAtF6mq8/wklXAGslV/7LfA+hwykORNqdU70zKYo7ETVspAl9pNkDp0x?=
 =?us-ascii?Q?KYEZeqMwWdDt5U4/ok8BouoLU1cTlixc5oS8GBB8gbe19NyxW/CLSUhNSDrZ?=
 =?us-ascii?Q?RHcnEuV1vy7B7L63zBacSunwr0A8SajK8Xmp/9/Wu8Gdh19ZU7yNE3vAN26g?=
 =?us-ascii?Q?6W6BPgPtSk0FsW4SV1w8KJfcsWALIFiYx/i8g+GfDXxm6g0l8zqe4F2jLqGV?=
 =?us-ascii?Q?9s/Luiv5I0l3Cpbc6e5qkYI5jxD1hzHFFTkM+ialeUdgwVYI1FopDssgxP96?=
 =?us-ascii?Q?RTwSgT4DKV0z59puLs8GqPUvQbT3yMFX2eka2VY64bchthj+f5sbsAtWn8TT?=
 =?us-ascii?Q?RBHSiyYhQL4aQdhCw7hCfWgczrVwHhWrzrDgSWCTQYYkZtWmrwa+M6sACz2s?=
 =?us-ascii?Q?j4QGZf8Fpms3JfZWvQKO51v6qIpbgZn7p1o8jupx9QFenlbqFGRqWLFp9EzD?=
 =?us-ascii?Q?0BQKLYkziUo4h5tDjY4aHantCdauYDgV/r5i91Pn5pnXOKFlKjUdVEbMpF36?=
 =?us-ascii?Q?ZGMUGCKHkIy63DnTq4HMo//eFi7MLAe7/TRh+AMwI7FUaEHNkJKaWyMqeENS?=
 =?us-ascii?Q?JYpwt1HK3j+e0n39lvsCU3W6MRZNlHnFeOrVXx/cUV3vYzyrb2I6uBoSMvEQ?=
 =?us-ascii?Q?Uew5hzHCqJTCAeNbubaV1+pg8t0VxgjFAiUgheFwsaQA9sLhsrAFSDG/QMp7?=
 =?us-ascii?Q?IpJg/Hfw/kYn6AXA3x7hpYMmfzBT8fF4YF15pso2Cf8+M7Fnr8iPwKbwe+Q9?=
 =?us-ascii?Q?lCfXTrF1R+B5XetuFRgE1m9AWaExuenmb0QxnlG4YNyRPdg+gBspAWbzl2Z9?=
 =?us-ascii?Q?51RMBmJ9MeydJp8mH2dOg2fJk3PejUNBFiIjFOpH?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21ea94e-89bb-4aac-ff09-08dd58656d45
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 02:04:40.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQ/dOA/auH+W6rAIFqWqIoKQKRcExi19uWt6PQnvxg0Ul88YpUa1uTzZOp8Z9U/UevUTqB6C/7e6p8gaCHHBug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB3967

In commit 8218f62c9c9b ("mm: page_frag: use initial zero offset for
page_frag_alloc_align()"), the check for fragsz is moved earlier.
So when the cache is used up, and if the fragsz > PAGE_SIZE, it won't
try to refill, and just return NULL.
I tested it with fragsz:8192, cache-size:32768. After the initial four
successful allocations, it failed, even there is plenty of free memory
in the system.
To fix, revert the refill logic like before: the refill is attempted
before the check & return NULL.

Cc: linyunsheng@huawei.com
Cc: stable@vger.kernel.org
Fixes: 8218f62c9c9b ("mm: page_frag: use initial zero offset for page_frag_alloc_align()")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 mm/page_frag_cache.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index d2423f30577e..82935d7e53de 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -119,19 +119,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 	size = PAGE_SIZE << encoded_page_decode_order(encoded_page);
 	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
 	if (unlikely(offset + fragsz > size)) {
-		if (unlikely(fragsz > PAGE_SIZE)) {
-			/*
-			 * The caller is trying to allocate a fragment
-			 * with fragsz > PAGE_SIZE but the cache isn't big
-			 * enough to satisfy the request, this may
-			 * happen in low memory conditions.
-			 * We don't release the cache page because
-			 * it could make memory pressure worse
-			 * so we simply return NULL here.
-			 */
-			return NULL;
-		}
-
 		page = encoded_page_decode_page(encoded_page);
 
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
@@ -149,6 +136,19 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		/* reset page count bias and offset to start of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		offset = 0;
+
+		if (unlikely(fragsz > size)) {
+			/*
+			 * The caller is trying to allocate a fragment
+			 * with fragsz > size but the cache isn't big
+			 * enough to satisfy the request, this may
+			 * happen in low memory conditions.
+			 * We don't release the cache page because
+			 * it could make memory pressure worse
+			 * so we simply return NULL here.
+			 */
+			return NULL;
+		}
 	}
 
 	nc->pagecnt_bias--;
-- 
2.34.1


