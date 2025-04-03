Return-Path: <linux-hyperv+bounces-4793-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39BAA7B117
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Apr 2025 23:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1334D17C772
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Apr 2025 21:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5BE1A3AB8;
	Thu,  3 Apr 2025 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="T4cFawEI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023094.outbound.protection.outlook.com [40.93.201.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDB8610B;
	Thu,  3 Apr 2025 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715381; cv=fail; b=CLR6xpNBtjuMwVwDe75BKw2cZAg0An6bBpkWOMmfp3MX3uW80sPYR0xgG11ZrE/9rMnD16yZuB5pNFEZGtZbvIRC9wUGWHVDCbzhu1X71ZxyxyanvnZsjh4vD5sD5vWg5G6pL/XfHCK/6mH2qQQqTko8oAab6hsIJK7AuW/pcc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715381; c=relaxed/simple;
	bh=MFOUsGld58Db5KmB6ey+xvflRPPSw4Fd/F35ImGWuMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aIiA3oWwPGAM7E+E7kSSTFcTKMH1l+Qze4WcQiE/E+ilnZ6wuN8HCzBn/QYSXZkaMfrwtRqa7nFeJVqqzYH30h8jbLcHucg2/9v3FJu5pita3gPS6+NNB7gZ99UsIcQNnrv3JvNcBulP+NW+h4cU413IInPoPYSox1xHkKcWvjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=T4cFawEI; arc=fail smtp.client-ip=40.93.201.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SykC9SeFKGjYYfqW1oEBqIHHx86i29thNhk5eBUQmLgst1pHbRaaTyoHxeMOVoIUY59kFh7q6A/hTqxOVCJf2Ek7Dq+s2bfnAyxnsmn5L36y6uBo74COKW09KSTcyAOPXCiilSjItsHdC7BnnjlM9NRm0oHolS3xK3ANAj1qf53Fb0BJqQ1oQ7ovIPBtuwpa+CPfzJNf85ZxooZkdgORr8gDlbtCvuGJxNH+b7hLwgz+8jri8iDtsG95lRHMl7c/KK+G+K/w4MB9GuHlqyx716LwJn/0LFwcLkZIhkJiCRXjEHlUxQoQ26DHJ5Su3dmPQl3t2DtsYSIF+wSaaPWMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFPblPYOVdQOlmBDt/4Up7fcC0sBiRNP6F8I3o6HrZg=;
 b=ehZAFDizFJGesGDMjiOtrYrs4yvdHZplSEHVQMKXj9vrbWDArkp67InGlcGd6xhw0cxt+9g3pzkutHJEMNxtT7QVakULNAiSenZAZrEne04CjbQH3/uZPLilVQJvgPE5M+RRUT6htmLPMzYtkf0mqdoTvuRTevm6M9kiGMOfIkBbT9cHaO8ON7RQHVTNxEm0zrFearaPy5z2SsunfOcLd7IZdT7btyQPe4bAH3tsOiYPf9InNibsiAL6czz4NDFsWJWfbblA9UBDFQOrQkLv9uoKeHpcTVSWUweHSHkYmYwaEEOE52TNjCjC1UgduNdJ7WcvAu7bbStapvS3D/UPbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFPblPYOVdQOlmBDt/4Up7fcC0sBiRNP6F8I3o6HrZg=;
 b=T4cFawEIFuIQO29vzTrFKdYh8760TXDW2Cqij1PcHiDneM+Cgg3FKPRLEf25A+tM21CoD8SWCH4vb0eg5rwFvuRiiE2JGEXyI0Oy76EhjwpTbL1ABso2Epmg+igfvuYYLqs9w+yoluooDv8Qpsjf6sJmMY0Hj+x/pbmRSp0WrUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1451.namprd21.prod.outlook.com (2603:10b6:5:25c::16)
 by DM4PR21MB3154.namprd21.prod.outlook.com (2603:10b6:8:66::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.9; Thu, 3 Apr 2025 21:22:57 +0000
Received: from DM6PR21MB1451.namprd21.prod.outlook.com
 ([fe80::7a3a:a395:66:b992]) by DM6PR21MB1451.namprd21.prod.outlook.com
 ([fe80::7a3a:a395:66:b992%4]) with mapi id 15.20.8606.022; Thu, 3 Apr 2025
 21:22:57 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	kys@microsoft.com,
	paulros@microsoft.com,
	olaf@aepfle.de,
	vkuznets@redhat.com,
	davem@davemloft.net,
	wei.liu@kernel.org,
	longli@microsoft.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: page_frag: Check fragsz at the beginning of __page_frag_alloc_align()
Date: Thu,  3 Apr 2025 14:21:48 -0700
Message-Id: <1743715309-318-2-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1743715309-318-1-git-send-email-haiyangz@microsoft.com>
References: <1743715309-318-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To DM6PR21MB1451.namprd21.prod.outlook.com
 (2603:10b6:5:25c::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1451:EE_|DM4PR21MB3154:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0ea461-3c88-450c-4555-08dd72f5b42c
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?OrlDZaeFgjh/eJb93eNfmei+SehZHcFIB6ut4ovpZVLdZDRtRG458bPW1etx?=
 =?us-ascii?Q?MGVrz9Ue+rmrKxs/W1ae/j3865KjCSkhb5CpIXwW28KpFgWkgjF41163e6dZ?=
 =?us-ascii?Q?JV1R+Wp6jYGMBVF9xkrFoWmj147xBoEGLKG6fU+jIUnc0l3w2Jvw5YpMAh+E?=
 =?us-ascii?Q?ue7J2VaR/qvDlK5o3CilnNc09fe+XtfVhG91cAkNxea2hqrO9trCbAUwKi89?=
 =?us-ascii?Q?Br5Mnia4OnwYNdwjYW4Z1sglQe+6nYjMhRpMx1sZwelUzTmZvycb8tNALtEM?=
 =?us-ascii?Q?0SljYMrC2MkIEfr8FAHA6pD0BXisugNrJ3II/aTczhFOkT7roInbyZ3k4kjj?=
 =?us-ascii?Q?JqOw6c/Ov6C9FDriJW75iHMIK8yRucZerC/9uFTqc2O6K8lO7ZWSCF/EbmIp?=
 =?us-ascii?Q?Uwbi0Z1fWWwfgfrZ7/zwT40HXoKKZUEteejXvS53TbD3YlXLuj3TRC5O8qDh?=
 =?us-ascii?Q?x88TfbSdCCxP20+ZBBBmHH+AD9DjyG3CEF/dl9ooOGVTysKq+R+SXo4ZQsVo?=
 =?us-ascii?Q?QDppr9kB0SfufIQvAc3hEqX0+Xd82GAPheccw5rgYOdLkHHqkPwJk94KHYOu?=
 =?us-ascii?Q?FeM8LIVK4y/Gt+7ar8wwChwbdeXaLM10AMcmHf5ERgH1dKSCS5d0QByuzPQf?=
 =?us-ascii?Q?A3c6AWa1DfA7yBhluZVeBD8DQZU3Kkpz7MZnWggtjsDmh5N11tt4XaYjepKd?=
 =?us-ascii?Q?vGcG3PQhILPzyQpG2B5VB6ppuznkiHn7bjEyJjx4PtQsUhUSt+j4QAL2LMtX?=
 =?us-ascii?Q?OAWJyUutseFW+qrSeYdMqd2MgnDGg9rYNTKvseyYn80ST8BfrlhQCorT855z?=
 =?us-ascii?Q?E+V2VBA6XCW2qYhPn/7mE9/lehwOuAaqcNuo0amvCFhnTTRjecbYHd/5eTq2?=
 =?us-ascii?Q?4ytYldmRm/klAuI/YeXzsV1aIjEqKk0GvChQwMhQ9HY0IWQF8uG1xi/q9SgG?=
 =?us-ascii?Q?IXT8Cc0OWzM9tFrn0b+UJ/7p7wljU3pjUbaXdCVPpyz+vaoP42XECKR7WU7I?=
 =?us-ascii?Q?Gffe5ecPKWbgfNbrgLXZ/nVuWx3jV358p/Fa/sa/05O35cqyeen9inBNimKj?=
 =?us-ascii?Q?ZWpvkKL8anxefb/FFuFvcAyPCiqVgJrBByw7dzqZR/90hC19+Y9Ck0Aj7lPS?=
 =?us-ascii?Q?6tn/feuzEUYZT+7Xv3vBGHX4rCjoaq91P3UZMUsibnQ+4DnMkNxPeOOb8HU2?=
 =?us-ascii?Q?Lr6VVZFT739zMQgkmC1W/zuDwcgBOdzHdJDD89Cgr90pPrFDhuXhZ0FvEcLH?=
 =?us-ascii?Q?Oj5d98GqPEWhNJbyfsyrzenHPVSBpooBx5oVyOmqx/Xb4DP6odiXNFOcvptZ?=
 =?us-ascii?Q?3KDbthyux9VgZ1fDRCQgHRr61E7LdB25s8/UDtY0hbQVGlk75LaYlVPiaF6h?=
 =?us-ascii?Q?Bxp8GheknifAxAk6jPXEo8axP1XdsIR3OoqVUME50T3vA0JcMfPOubpcfYyS?=
 =?us-ascii?Q?tnCpReWu+WpOa5EX3pWYX/HWmBHnn3JWoooImgel97QURZjuWoj4/w=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1451.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?cjUvpgXHGYh8wP4M/QMQ/DeJymNWkF4hRFgDlMpZe/pN9q9stjT1OivnoqDE?=
 =?us-ascii?Q?ILIoCBcThqjtdcCM/iGe70pkv9bS2bFazEPTBB6wNhIneiLpWG7di21jAq9t?=
 =?us-ascii?Q?9njRHcG6dJCSNecBHCKIkzHzzxWoXxu++aLDQXesBd0k8Uyn0nJRvkLIOR+U?=
 =?us-ascii?Q?XJldORk9gu3+vrFlY93BZjOhAzfPBRP6apvJLcc+07mH6FKX/Fj8d27HkpcX?=
 =?us-ascii?Q?VEbLY48zSAHGGgRUZ/lJL8hJ5+RBPS4Acvhfpr/y9atGQEFn6dDelzsvAGl9?=
 =?us-ascii?Q?6WAnrlrnIETD2pTRZqEmAlMx17TeCIQk6B/wXgitdjTL/a4i+GWaqtPVx1p4?=
 =?us-ascii?Q?/Jac2TlYsKCAEBRuql3vogdmgU0d0ZZSVdoC1ys0Neu/FoarRl79HmuMc2jM?=
 =?us-ascii?Q?RKpamMIdRhfvSeJLke4bv+LN+QDr08UeGaKhHgkgaaLVK3KkrUkm3yr6Btk7?=
 =?us-ascii?Q?CsGtf0VRm6voa3OF/STmKs3T6N3iIMVkmCrYV4IhiQJZQZ78LZnXRcOKZaWy?=
 =?us-ascii?Q?lm9g2W2PHVi9c9DrX7Czei4Jbd+1VxgKF7VslWkFs/Yuy5t1/LZ7gYwhU+OK?=
 =?us-ascii?Q?Huf+ldowLAkULsmB8ty0CafdNZoq3DsRWcFYNj0VxdP8m5TDVpWYPQZTVVjx?=
 =?us-ascii?Q?NP1YBSh/taopeuEZ8NSCpM3BoLC3rICPgaspc7JpFZJGqjSni80dOXWOV0xa?=
 =?us-ascii?Q?PrBtwVpITN8B2rMkOLh5GfuBIDzBAvrM3ZU2p+f5n0KgnHBxOr8xCoud0l+3?=
 =?us-ascii?Q?XE6RvGIrK8eK9z7Fs8dKT0b/IvIs+ZgJncXelJGDOc2F63jjGHjSkJHLvoUG?=
 =?us-ascii?Q?afgO90WT6GFzTmDHD1UBUvPwUsZ5t2nZAyGGRCmzcv5BZ9kvfVr1r3YtmQ+y?=
 =?us-ascii?Q?sYrjliPI911Zfv4WiIb1e2EYqjE8MyrWzH4nVwjNLagniB1liNv9G0L0q3oK?=
 =?us-ascii?Q?yrO/6HZ4kmiAvds1gTMmQGibYP9VhIY9jImJwtuLNb9Ky5zgzmT6L7tY2pcd?=
 =?us-ascii?Q?DybTMcsulDxvMoI8OEHIzlWU314u7gJjVR2aKaNIulagRre2j0hyblX2TLVZ?=
 =?us-ascii?Q?ZwfHPKhefHz3OyJHFP9beG7kjtWWyyIHetGNf581Rfv9e/b4CnFoG+3nhdav?=
 =?us-ascii?Q?TtqRiDcWzuGUufnL8MGvKuy663WEGnIohgAAowNFh0BNwYblMmFZu07jAh85?=
 =?us-ascii?Q?LwVUzwdPg/gO8JBwx4+p3WSddJhkYCMfAGL7Ov+JW2Ge/KBQcPuT9DYjN1Vt?=
 =?us-ascii?Q?TRW79vlKAnjVIY1NXAWBJmFi4L0dW1TNBySQCfl1WyqGo+avCyTlEUsms6tw?=
 =?us-ascii?Q?vL0e4tPauc1OMR3b/K5riTjDsj20Uqh7AnIheKMacFOQ1ArCQrqSM3WwZ2QR?=
 =?us-ascii?Q?fu7j/HW+FBE+dAU0Xdz1gHtYw7jlF8+2bgCwL93fPTcWWU4uO73V08P81jrS?=
 =?us-ascii?Q?cdzDay2LgJiPWLgbSouyKAYEdOh1EVoqeXW80pc7elfahWxbde8NmaqVOdTo?=
 =?us-ascii?Q?8q/RcN+ngorvZU20FqnAXG3IgocACt80Gt93RdnTOVOhhXTTLD/lGkBPgy1q?=
 =?us-ascii?Q?0RgvH9amv14vJH+zuRlJOTFDVK7BjNjWfu9On7r+?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0ea461-3c88-450c-4555-08dd72f5b42c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1451.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 21:22:57.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yMvcM+u0JUubLeveGFRVw47ua6LsEix84GZhPUKDdGr+B+FaGb4P0CNIniOqZXCxeK5nRAkyS4wZBIIM+0TIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3154

Frag allocator is not designed for fragsz > PAGE_SIZE. So, check and return
the error at the beginning of __page_frag_alloc_align(), instead of
succeed for a few times, then fail due to not refilling the cache.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 mm/page_frag_cache.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index d2423f30577e..d6bf022087e7 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -98,6 +98,15 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 	unsigned int size, offset;
 	struct page *page;
 
+	if (unlikely(fragsz > PAGE_SIZE)) {
+		/*
+		 * The caller is trying to allocate a fragment
+		 * with fragsz > PAGE_SIZE which is not supported
+		 * by design. So we simply return NULL here.
+		 */
+		return NULL;
+	}
+
 	if (unlikely(!encoded_page)) {
 refill:
 		page = __page_frag_cache_refill(nc, gfp_mask);
@@ -119,19 +128,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
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
-- 
2.34.1


