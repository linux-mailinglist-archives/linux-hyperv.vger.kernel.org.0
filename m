Return-Path: <linux-hyperv+bounces-4558-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF65A658BE
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 17:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD1A420B73
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 16:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E1D206F21;
	Mon, 17 Mar 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW5NTGWX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D35D206F1B;
	Mon, 17 Mar 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229552; cv=none; b=S1QL8i7SN/EIgujPmVrMhvf7/R5HGDWK7gUtRwoJz8R1euFbFjF9+B3HF4ptHmKbJEvFp+nlEg45bWnWpJTFJO9xdQDT5dMPhAMyQ77lEGSEzdaWwLBeSyev3FeajGiSnwMJ2QtVsPAbKn3KmGYKg/kIMXOVfnrG4f0CXT/OGs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229552; c=relaxed/simple;
	bh=hby0KqjpVt/WiDmHp7hjyCPjRh8jJjsN0+fPR4eCDyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P5DXziRaGTdJP+jhfvkjMUntEKea5YCRI6QT1tZLo/vSdys6v7tTGnRuBNaVP3Vc+iCuJ7cyhn6GZl8GhIgTy2y2p/LiNv+78xl6TFg8ep1rzpa+n5ldLkc0Vdsj3ilfEFXo0zhhzjOEQZfbN+shAXuCZldCi/mdP5J6U8fZ72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW5NTGWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED80AC4CEEC;
	Mon, 17 Mar 2025 16:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229551;
	bh=hby0KqjpVt/WiDmHp7hjyCPjRh8jJjsN0+fPR4eCDyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dW5NTGWXBrbx11n1wZpkkvJp+0uo+iSt36iuwVqMX+jG0hkK6AMT4wIfByWbFK1dz
	 hGpoy8loGneSg/3EuJ07T9Fjab5yE6RwGXDiyi4l/tQfgGPs/1x9wKnDuH3iqySl7t
	 Iy4yswj91Ke2EXuEMyip7ty20GUWsoSebrPoeMpWwX6PnI2yu5IYuCtor+R80wS4cv
	 6zU+7JP+GdZPihnNTk+aZZCQdX080BdMCQMcEgtcbwISIfVIxPwtjOFarzgETVrEFZ
	 dLhKPzlkI4F2J/eSVEh4bXwWWqxZAm/A/pJqi5BclPsllufc0xBMWkB02ZoSVJQepv
	 780CxMtH4gv4g==
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
Subject: [PATCH AUTOSEL 6.6 4/8] x86/hyperv: Fix output argument to hypercall that changes page visibility
Date: Mon, 17 Mar 2025 12:38:58 -0400
Message-Id: <20250317163902.1893378-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163902.1893378-1-sashal@kernel.org>
References: <20250317163902.1893378-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.83
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
index 8c6bf07f7d2b8..e50e43d1d4c87 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -464,7 +464,6 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 			   enum hv_mem_host_visibility visibility)
 {
 	struct hv_gpa_range_for_visibility *input;
-	u16 pages_processed;
 	u64 hv_status;
 	unsigned long flags;
 
@@ -493,7 +492,7 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 	memcpy((void *)input->gpa_page_list, pfn, count * sizeof(*pfn));
 	hv_status = hv_do_rep_hypercall(
 			HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY, count,
-			0, input, &pages_processed);
+			0, input, NULL);
 	local_irq_restore(flags);
 
 	if (hv_result_success(hv_status))
-- 
2.39.5


