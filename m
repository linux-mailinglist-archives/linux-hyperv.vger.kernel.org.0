Return-Path: <linux-hyperv+bounces-8945-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBqiJ+lLnGnYDQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8945-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 13:45:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CCC176610
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 13:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D125D3061471
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 12:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B91369221;
	Mon, 23 Feb 2026 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaUKuM/O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9498036921C;
	Mon, 23 Feb 2026 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850291; cv=none; b=RofL7zGEoYWFWeYRAI2AQ1OA8GdEtltUBONE6EKvUbb1tqMPeWqni646UVPQr5k5JSgNcb/c8wk/OVP/ChH3Xh7hDOS3/O7Ud2fdmzNNZnub662teAi2P9EMp6XxYZeSt63Xw0knGtpkcwmn1/qu8I6PWFc+mUIMzFpmGrAWBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850291; c=relaxed/simple;
	bh=nv52MAiDCjo37hjYdpvqZ9EtjP+ua8bDtuEVQevLy3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfcv49l56JHWFJ92BMGVjPH3jRJynGpb08FPkaNk+FjySib3EUcT+g7J/C5F347alUSaWX4QWVQN1n0oiuzxlSX6Q+d/GfW3Lfsf/Oq2DEifQyLXjVN1sOk6g+u3I/NDXBkc1nqSNp3JoY3Cb6+Gnjwu/J57W89Yox20x3FOlF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaUKuM/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3499C116C6;
	Mon, 23 Feb 2026 12:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771850291;
	bh=nv52MAiDCjo37hjYdpvqZ9EtjP+ua8bDtuEVQevLy3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gaUKuM/Ogl+3K00Oq77V0SMOeEffg4wOkmOUMlQOSQlHz1hbmXHYedjprrC1V3y79
	 dLp0Wg8kC2s4q1+esBGPzSd6ilY5goRAEKyb34gu5vpC7r9cNIfTztk+7YBNI34tvJ
	 Z2XOw3wsmVtD2Kb0E/TO8E3ImBbDC3U5S6S4dHkTYKbYEWE376/Wk4KnGDztX6k2Hb
	 gMRBvTSDKvUjSUdcbFRtIYLb/dkFhx/WcWyOnRnr+JkwlYXKkZkVyc2DERR3F3M46b
	 7IVxxzoWbcUy7lWJZ9Me4IxLKvS/9HOLudj9IxgaWsAvKKpz8I0KYhKg5SHABMNop7
	 Q1Jp9A3ztkMgQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mukesh R <mrathor@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19] x86/hyperv: Move hv crash init after hypercall pg setup
Date: Mon, 23 Feb 2026 07:37:26 -0500
Message-ID: <20260223123738.1532940-21-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223123738.1532940-1-sashal@kernel.org>
References: <20260223123738.1532940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8945-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24CCC176610
X-Rspamd-Action: no action

From: Mukesh R <mrathor@linux.microsoft.com>

[ Upstream commit c3a6ae7ea2d3f507cbddb5818ccc65b9d84d6dc7 ]

hv_root_crash_init() is not setting up the hypervisor crash collection
for baremetal cases because when it's called, hypervisor page is not
setup.

Fix is simple, just move the crash init call after the hypercall
page setup.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a clear picture. Let me write my analysis.

## Analysis

### What the commit does

This commit fixes an initialization ordering bug in the Hyper-V root
partition crash dump setup on x86. The function `hv_root_crash_init()`
needs to make hypercalls (specifically `HVCALL_GET_SYSTEM_PROPERTY`) to
set up crash dump collection for the root partition. However, it was
being called **before** `hv_set_hypercall_pg()`, which is the function
that installs the hypercall page into the static call trampoline.
Without `hv_set_hypercall_pg()` having run, any hypercalls made by
`hv_root_crash_init()` would fail silently (or call the `__hv_hyperfail`
stub), meaning crash collection was never properly set up on baremetal
Hyper-V root partitions.

The fix is small and surgical: move the `hv_root_crash_init()` call from
inside the `if (hv_root_partition())` block (before
`hv_set_hypercall_pg()`) to after `hv_set_hypercall_pg()`, with an
explicit `hv_root_partition()` guard.

### Does it fix a real bug?

Yes. On baremetal Hyper-V root partitions, crash dump collection was
completely non-functional. This is a real bug that affects kernel crash
diagnostics in production Hyper-V environments.

### Size and scope

Very small: 1 file, 3 lines added, 1 line removed. The change is a
simple reordering of an existing function call.

### Dependency analysis - CRITICAL ISSUE

The prerequisite commit `77c860d2dbb72` ("x86/hyperv: Enable build of
hypervisor crashdump collection files") that **introduced**
`hv_root_crash_init()` was first merged in **v6.19-rc1**. It is NOT
present in v6.18.y or any earlier stable trees.

This means:
- The code being fixed (`hv_root_crash_init()`) does not exist in any
  stable tree prior to 6.19.y
- The bug was introduced in v6.19-rc1 and this fix targets the same
  v6.19.y tree
- For stable trees 6.18.y and older, there is nothing to fix — the buggy
  code doesn't exist there

### Risk assessment

For 6.19.y stable: Very low risk. The change is a simple reordering of
an initialization call, only affects Hyper-V root partition (baremetal)
configurations, and the commit is authored by the same developer who
introduced the feature.

### Stable kernel criteria

- Obviously correct: Yes, the ordering dependency is clear
- Fixes a real bug: Yes, crash dump collection fails on root partitions
- Small and contained: Yes, 4-line change in 1 file
- No new features: Correct, just reorders existing initialization

### Verdict

This is a valid bugfix for v6.19.y stable. It fixes code that was
introduced in v6.19-rc1 and is only relevant to the 6.19.y stable tree.
For that tree, it should be backported.

### Verification

- **git log** confirmed `77c860d2dbb72` introduced
  `hv_root_crash_init()` on 2025-10-06
- **git tag --contains** confirmed `77c860d2dbb72` is in v6.19-rc1 and
  v6.19 but NOT in v6.18.13
- **git merge-base --is-ancestor** confirmed the prerequisite is NOT in
  v6.18.y stable
- **Read of hv_init.c:63-70** confirmed `hv_set_hypercall_pg()` sets up
  the static call trampoline needed for hypercalls to work
- **Read of hv_init.c:530-589** confirmed the ordering:
  `hv_root_crash_init()` was called at line 561, before
  `hv_set_hypercall_pg()` at line 568
- The fix commit `c3a6ae7ea2d3f` changes 1 file, 3 insertions, 1
  deletion — verified via `git show --stat`
- The Explore agent confirmed `hv_root_crash_init()` makes hypercalls
  (`HVCALL_GET_SYSTEM_PROPERTY`) that require the hypercall page to be
  set up

**YES**

 arch/x86/hyperv/hv_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 14de43f4bc6c1..7f3301bd081ec 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -558,7 +558,6 @@ void __init hyperv_init(void)
 		memunmap(src);
 
 		hv_remap_tsc_clocksource();
-		hv_root_crash_init();
 		hv_sleep_notifiers_register();
 	} else {
 		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
@@ -567,6 +566,9 @@ void __init hyperv_init(void)
 
 	hv_set_hypercall_pg(hv_hypercall_pg);
 
+	if (hv_root_partition())        /* after set hypercall pg */
+		hv_root_crash_init();
+
 skip_hypercall_pg_init:
 	/*
 	 * hyperv_init() is called before LAPIC is initialized: see
-- 
2.51.0


