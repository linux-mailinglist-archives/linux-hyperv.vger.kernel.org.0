Return-Path: <linux-hyperv+bounces-8018-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD2CCB80C2
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Dec 2025 07:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F6D7303B18F
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Dec 2025 06:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9F930DD3D;
	Fri, 12 Dec 2025 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI306TVe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4AE272803;
	Fri, 12 Dec 2025 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765521895; cv=none; b=tSy29qRktkA5le94MHZZpKOUEoYQHQBh+oL50hAXr1cpSzPuWHqWaAlqplNxKp0WJ+1ij6TlmyyJxUYbiD+KUwfPJRwZGxwPXW2eLkC2jhFFxteD8tCCi2hoyJOSEcwtf2ZfX/v6ehl+7stVijbcWYa0vUGgpdudgKsQPAcJ2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765521895; c=relaxed/simple;
	bh=dWhA5QFgq3iyHkTDshDNefjIA53nUnedjKtEf1pDEhM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LYXSh6bWR9OSzBucpMhSU0LN0EGozzmXEmg/euuQhgDOOnKkm5y0W/DMkxjYmOJHjTdPTsAKvfF0EPSLxWpyVPG4o1g95mEh23dOdNY48Wi66guzzMGcqHa4JlrTr3vfZj4KGjfnsvmqJz0RxzjlHPjDcbHp6pqoBEcvrx8LU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI306TVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373DFC4CEF1;
	Fri, 12 Dec 2025 06:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765521895;
	bh=dWhA5QFgq3iyHkTDshDNefjIA53nUnedjKtEf1pDEhM=;
	h=Date:From:To:Cc:Subject:From;
	b=aI306TVetaP8qpyYbr6dvVaBK0wp0hJA4IV8S+A5FsMGEivSmM7Q9/DCIe/qaHY18
	 qxgZPpIV22R8rqhyfHDvlOQCTBN5PQDrOT2GxIkjCsMlmhiQUgl9iTKfLd3hY8Yqv3
	 iFbDJPTLBViFlLgMzEsiwZIhnlqRv9J7m2zLOuu136TMcPdSkKt9GtP02R9ggjy493
	 4i1HzrUNguPy0uy+jtkQ1ENYt802FEQEpRUzKwJUsZr88GyIIXz06kbVCHkBvMrfHO
	 QOU5ucZVAx9zeRrfwpOySsErLZKnil8aP9jyMk+MQiU+zUPs0Jc0D6hWs1gzdII1O8
	 BNevnveCJrcFg==
Date: Fri, 12 Dec 2025 15:44:50 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] hyperv: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <aTu54qH2iHLKScRW@kspp>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the new __TRAILING_OVERLAP() helper to fix the following warning:

include/hyperv/hvgdk_mini.h:581:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM) and a
set of MEMBERS that would otherwise follow it.

This overlays the trailing MEMBER u64 gva_list[]; onto the FAM
struct hv_tlb_flush_ex::hv_vp_set.bank_contents[], while keeping
the FAM and the start of MEMBER aligned.

The static_assert() ensures this alignment remains, and it's
intentionally placed inmediately after the related structure --no
blank line in between.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/hyperv/hvgdk_mini.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 04b18d0e37af..30fbbde81c5c 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -578,9 +578,12 @@ struct hv_tlb_flush {	 /* HV_INPUT_FLUSH_VIRTUAL_ADDRESS_LIST */
 struct hv_tlb_flush_ex {
 	u64 address_space;
 	u64 flags;
-	struct hv_vpset hv_vp_set;
-	u64 gva_list[];
+	__TRAILING_OVERLAP(struct hv_vpset, hv_vp_set, bank_contents, __packed,
+		u64 gva_list[];
+	);
 } __packed;
+static_assert(offsetof(struct hv_tlb_flush_ex, hv_vp_set.bank_contents) ==
+	      offsetof(struct hv_tlb_flush_ex, gva_list));
 
 struct ms_hyperv_tsc_page {	 /* HV_REFERENCE_TSC_PAGE */
 	volatile u32 tsc_sequence;
-- 
2.43.0


