Return-Path: <linux-hyperv+bounces-4556-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2475DA658A8
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 17:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1764B189FD8A
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A9320485B;
	Mon, 17 Mar 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCby0aMp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65121B0F30;
	Mon, 17 Mar 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229517; cv=none; b=GrCy4Bq6VWr1OuIIgQIlte7dV7kgf1Rsc8D1doZSB2uXCD4o3NklU88R57BtFSOT3IYlnMuvMncEtk6d4q7ykKzphny2vdWLYnWvvRfb95tsg26fA4nigys568ABYnpIlGBiMtgQL+kOhdv0TOQHlVoiFyG45Snacq4WO43XfHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229517; c=relaxed/simple;
	bh=ez+Mlc49SVeCDXALcZWv9rZXJfvdsfDSLb5oQSflokg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXYRrJF4x7JUhJFycqwWjOzpUw53bB4gtzA4kNZ+ezAhLGJHZTfIrX1ki1BMfFRCZ3pJNwZFdL5q2PJVp23vzVr+zKAZAXriLgTJ2P3hgO4yKz0UiYeD47Fsrx0If6T1OhPnuC5eTVfAMP3BYQhN9aENsfwC/p/oInocgnlVARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCby0aMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E616AC4CEED;
	Mon, 17 Mar 2025 16:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229517;
	bh=ez+Mlc49SVeCDXALcZWv9rZXJfvdsfDSLb5oQSflokg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCby0aMpvaOKvMABAl0R1XJ3U07kiSSgtJhVz4lUIFZL+/RPLoostYnrrF4ToA4OV
	 D8RIDyQ51dHnZ2rFTRczkVm7pyWGi9KvBL+Z1Z3GLBkmqNa9NRn7Sfs9C1kAa1XlM1
	 NlncgAS4QXDOcl/XgXDcE8c6NwaufFsuC9AkHTSuIzKSUJxdGM+qpLKx/UnDzSjATt
	 yhWSUIFp+rL8oo8iXMeXYYcwQ+bQv7M5Osrf+Gj9IV/uL3oVFnHZHt1k/9N/EVtw20
	 VVEFnM4p2jsqvzLtWMwhhI9Rf2Dyu35uswRxPXKAU7rCzJJHKmzX5m1AGWvgU9C4J+
	 7vRlneRLE1qLQ==
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
Subject: [PATCH AUTOSEL 6.12 07/13] x86/hyperv: Fix output argument to hypercall that changes page visibility
Date: Mon, 17 Mar 2025 12:38:12 -0400
Message-Id: <20250317163818.1893102-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163818.1893102-1-sashal@kernel.org>
References: <20250317163818.1893102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.19
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


