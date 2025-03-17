Return-Path: <linux-hyperv+bounces-4554-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330B9A65872
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 17:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2356188F3D7
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519BF1C8627;
	Mon, 17 Mar 2025 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9pmoBWF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD81C861B;
	Mon, 17 Mar 2025 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229465; cv=none; b=aaCWT+B7pQKqpopYRnR13u6lVaB2Fp52lAJ3+J1j8tjNs1lG+gBsbay/J6iuKlQSr5pZNIwTV1AMUTU4k+NL01kISbvh1dXTHht50l4XkFgSQMNp0cp7Gdsb7aOEZYMjP65qWWEm/KwlVRnWxtNHjzfdaiqvNLYx2rPXGIwu1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229465; c=relaxed/simple;
	bh=ez+Mlc49SVeCDXALcZWv9rZXJfvdsfDSLb5oQSflokg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mPJmnkNG8ajVYg+STWIDBET7QdiFnX8fI4MjVknBCpEY8gCA9pEc++AxWhxduLp6yjL2Sdq4CD7v0L+l4OXZjCZW8pDX+ZhE6gnXOA+tjl5Vc6ykws1JLnfeGSOBbgjG68hhYh0gQ5p+MGP9J8w5rvtN2MMAdriwvpcCO0M1+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9pmoBWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF44C4CEEF;
	Mon, 17 Mar 2025 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229464;
	bh=ez+Mlc49SVeCDXALcZWv9rZXJfvdsfDSLb5oQSflokg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h9pmoBWFYche1/hq3fbZ4VNy+isIfI/M1SBgKosEq9rpLSs8XjhWbgXVdkRytNobR
	 dInG3G+rcR/6m7OkNN53im/X41Xs17hrsPghK7UACC8nMt5vPARdxnB7yOHQ/bKinw
	 oxfHOZApy13tdH0/8T/zKvh9hWWhDJchWnjDZ/iXTfAS6wGJGH8WcEHQ3LZoxy+KNn
	 jmJ6cxFT0Bxomu4eRjvW5BYJfwxjqv3rsnS1V4Ukiws1hhxHeILIcGGHxQRaM8FdDi
	 7cHn4PY1Xgm64OG1+3x3XHefC/sMcQ91cZX4hj1fh2cu7InAi1PqOR3q0UN+wCNUUk
	 sDh07yl2FLwVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Kelley <mhklinux@outlook.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 08/16] x86/hyperv: Fix output argument to hypercall that changes page visibility
Date: Mon, 17 Mar 2025 12:37:17 -0400
Message-Id: <20250317163725.1892824-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163725.1892824-1-sashal@kernel.org>
References: <20250317163725.1892824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.7
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

[ Upstream commit 09beefefb57bbc3a06d98f319d85db4d719d7bcb ]

The hypercall in hv_mark_gpa_visibility() is invoked with an input
argument and an output argument. The output argument ostensibly returns
the number of pages that were processed. But in fact, the hypercall does
not provide any output, so the output argument is spurious.

The spurious argument is harmless because Hyper-V ignores it, but in the
interest of correctness and to avoid the potential for future problems,
remove it.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250226200612.2062-2-mhklinux@outlook.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20250226200612.2062-2-mhklinux@outlook.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/ivm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 60fc3ed728304..aa8befc4d9013 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -465,7 +465,6 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 			   enum hv_mem_host_visibility visibility)
 {
 	struct hv_gpa_range_for_visibility *input;
-	u16 pages_processed;
 	u64 hv_status;
 	unsigned long flags;
 
@@ -494,7 +493,7 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 	memcpy((void *)input->gpa_page_list, pfn, count * sizeof(*pfn));
 	hv_status = hv_do_rep_hypercall(
 			HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY, count,
-			0, input, &pages_processed);
+			0, input, NULL);
 	local_irq_restore(flags);
 
 	if (hv_result_success(hv_status))
-- 
2.39.5


