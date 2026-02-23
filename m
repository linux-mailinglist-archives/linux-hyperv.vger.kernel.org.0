Return-Path: <linux-hyperv+bounces-8946-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLBkL4dLnGnYDQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8946-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 13:43:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 349AD17658F
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 13:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8468A30D0F7E
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 12:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C78E36681F;
	Mon, 23 Feb 2026 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Omq1bgeX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA61936922C;
	Mon, 23 Feb 2026 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850293; cv=none; b=cLicoHrWF21bMHtplQJ17awYe/mDBTk/1UDj6yiIsKBy2fZB+bVCn6+Fii/jtPPRFcXRV4oDU63bKd1/U0fQJ/U38R4mqHlKLzu17gpU7KP9UgihuG676RoNobh6iMC2m5O/P4mtynH+hQW24Syevk+czxWZSQUEdkwGoi0BbsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850293; c=relaxed/simple;
	bh=nY/v9SYsp2G3sHqyLBAJhO39T4dkycHk/4QUhAf0jaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkRQmulHxMct/qWfi8xmrHjWAsXFvIEu3J9K+3J4xzoTirdKoa6Dzuwvhqx2cHWGzeJJiKzCX/Jt6cvkHWF4+KljT8B5AECgUIFFJ0efdBhSPZU+rURrScJ559f2I7jvJlHuU0Paw8embKwVw8hd6kyymxFqv8uz57m02EJjkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Omq1bgeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B026C116D0;
	Mon, 23 Feb 2026 12:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771850292;
	bh=nY/v9SYsp2G3sHqyLBAJhO39T4dkycHk/4QUhAf0jaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Omq1bgeXAq4B70CRkuYvjWXQXStIN5A/HChGMzg8AHuNx/Z6e7jQrYukDnRYhZSlF
	 GWaVWRLs7zB2MfyjLXlOECq84f4RhFMemckoEpjgIfdl4iX8EYaJfxDy0KJqQr71To
	 2cy5HGAW9bm6B6MdatVc8zVeNLyJ38ZZAtFPpbYWP6hwLSLwoi/ctZXuhY8OLKF5ej
	 FoOxKNEj5DMHNXZF+6EmxaBV74mAIqW035f2h2hoNoANHw2ugXQHZgHLs4AHUp6vRj
	 E1jRF0Fp5NvGOla7vo1zq9omZOhz2tgjj7cY1gi887tnAjgmdKhbxlRODhmQCOWGnL
	 qDzA5ZfzsCfUA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] mshv: clear eventfd counter on irqfd shutdown
Date: Mon, 23 Feb 2026 07:37:27 -0500
Message-ID: <20260223123738.1532940-22-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223123738.1532940-1-sashal@kernel.org>
References: <20260223123738.1532940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.3
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8946-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 349AD17658F
X-Rspamd-Action: no action

From: Carlos López <clopez@suse.de>

[ Upstream commit 2b4246153e2184e3a3b4edc8cc35337d7a2455a6 ]

While unhooking from the irqfd waitqueue, clear the internal eventfd
counter by using eventfd_ctx_remove_wait_queue() instead of
remove_wait_queue(), preventing potential spurious interrupts. This
removes the need to store a pointer into the workqueue, as the eventfd
already keeps track of it.

This mimicks what other similar subsystems do on their equivalent paths
with their irqfds (KVM, Xen, ACRN support, etc).

Signed-off-by: Carlos López <clopez@suse.de>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a clear picture. Let me provide my analysis.

## Analysis

### 1. Commit Message Analysis

The commit replaces `remove_wait_queue()` with
`eventfd_ctx_remove_wait_queue()` in `mshv_irqfd_shutdown()`. The key
claim is that this "prevents potential spurious interrupts" by clearing
the eventfd counter atomically when unhooking from the waitqueue. The
commit also removes the now-unnecessary `irqfd_wqh` pointer from the
struct.

The phrase "potential spurious interrupts" uses the word "potential" —
suggesting this is a preventive/hardening fix rather than a response to
an observed bug.

### 2. Code Change Analysis

The change is small and well-defined:
- **`mshv_irqfd_shutdown()`**: `remove_wait_queue(irqfd->irqfd_wqh,
  &irqfd->irqfd_wait)` →
  `eventfd_ctx_remove_wait_queue(irqfd->irqfd_eventfd_ctx,
  &irqfd->irqfd_wait, &cnt)`. The new call atomically removes the waiter
  AND resets the eventfd counter to zero.
- **`mshv_irqfd_queue_proc()`**: Removes `irqfd->irqfd_wqh = wqh` since
  the field is no longer needed.
- **`struct mshv_irqfd`**: Removes the `irqfd_wqh` field.

Without clearing the counter, if an eventfd had been signaled before
shutdown completes, stale events could remain in the counter. This is a
real correctness concern, though labeled as "potential."

### 3. Pattern Match with KVM/Xen/ACRN/VFIO

All four analogous subsystems use `eventfd_ctx_remove_wait_queue()` in
their irqfd shutdown paths:
- `virt/kvm/eventfd.c:136`
- `drivers/xen/privcmd.c:906`
- `drivers/virt/acrn/irqfd.c:55`
- `drivers/vfio/virqfd.c:90`

The mshv code was the sole outlier using plain `remove_wait_queue()`.
This is a well-established pattern for correct irqfd teardown.

### 4. Driver Age and Stable Tree Applicability

The mshv driver was introduced in v6.15-rc1 (commit `621191d709b14`). It
would only exist in stable trees 6.15.y and newer (6.16.y, 6.17.y,
6.18.y). It does NOT exist in any LTS trees (6.12.y, 6.6.y, 6.1.y,
5.15.y).

### 5. Risk Assessment

- **Size**: Very small — changes 2 files, net removal of code (removes a
  struct field and an assignment)
- **Risk**: Very low — uses a well-understood API that's already used by
  KVM, Xen, ACRN, and VFIO
- **Scope**: Confined to mshv irqfd shutdown path only

### 6. Bug Severity

Without this fix, if the eventfd counter is non-zero during shutdown,
leftover events could trigger spurious interrupt injection into the
guest VM. In a hypervisor context, spurious interrupts can cause guest
OS instability. While this is described as "potential" (no specific bug
report), the failure mode is real and the fix is straightforward.

### 7. Stable Criteria Assessment

- **Obviously correct**: YES — follows the exact pattern used by KVM,
  Xen, ACRN, VFIO
- **Fixes a real bug**: Borderline — fixes a latent correctness issue
  rather than a reported crash
- **Small and contained**: YES — minimal change
- **No new features**: YES — this is purely a correctness fix
- **Tested**: It mirrors established code in KVM and other subsystems

### Verification

- `git log --follow --diff-filter=A -- drivers/hv/mshv_eventfd.c`
  confirmed the file was introduced in commit `621191d709b14` ("Drivers:
  hv: Introduce mshv_root module")
- `git describe --tags --contains 621191d709b14` confirmed this was
  introduced in v6.15-rc1
- Grep for `eventfd_ctx_remove_wait_queue` confirmed all four analogous
  subsystems (KVM, Xen, ACRN, VFIO) use this API in their shutdown paths
- Read of `drivers/hv/mshv_eventfd.c` confirmed the pre-patch code uses
  `remove_wait_queue()` with the stored `irqfd_wqh` pointer (line 255)
- Verified stable tree tags exist for 6.15.y through 6.18.y that would
  contain this driver
- Could NOT verify any specific user-reported bugs caused by the lack of
  counter clearing (unverified — commit only says "potential")

### Conclusion

This is a small, low-risk correctness fix that aligns mshv with the
well-established pattern used by KVM, Xen, ACRN, and VFIO for irqfd
shutdown. It prevents stale eventfd events from potentially causing
spurious interrupts in guest VMs. The fix is obviously correct, tiny in
scope, and carries essentially zero regression risk. While it addresses
a "potential" rather than actively reported issue, the fix is clearly
the right thing to do for stable users running Microsoft Hypervisor
workloads on 6.15+ kernels.

**YES**

 drivers/hv/mshv_eventfd.c | 5 ++---
 drivers/hv/mshv_eventfd.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 0b75ff1edb735..cb8b24b81cd5e 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -247,12 +247,13 @@ static void mshv_irqfd_shutdown(struct work_struct *work)
 {
 	struct mshv_irqfd *irqfd =
 			container_of(work, struct mshv_irqfd, irqfd_shutdown);
+	u64 cnt;
 
 	/*
 	 * Synchronize with the wait-queue and unhook ourselves to prevent
 	 * further events.
 	 */
-	remove_wait_queue(irqfd->irqfd_wqh, &irqfd->irqfd_wait);
+	eventfd_ctx_remove_wait_queue(irqfd->irqfd_eventfd_ctx, &irqfd->irqfd_wait, &cnt);
 
 	if (irqfd->irqfd_resampler) {
 		mshv_irqfd_resampler_shutdown(irqfd);
@@ -371,8 +372,6 @@ static void mshv_irqfd_queue_proc(struct file *file, wait_queue_head_t *wqh,
 	struct mshv_irqfd *irqfd =
 			container_of(polltbl, struct mshv_irqfd, irqfd_polltbl);
 
-	irqfd->irqfd_wqh = wqh;
-
 	/*
 	 * TODO: Ensure there isn't already an exclusive, priority waiter, e.g.
 	 * that the irqfd isn't already bound to another partition.  Only the
diff --git a/drivers/hv/mshv_eventfd.h b/drivers/hv/mshv_eventfd.h
index 332e7670a3442..464c6b81ab336 100644
--- a/drivers/hv/mshv_eventfd.h
+++ b/drivers/hv/mshv_eventfd.h
@@ -32,7 +32,6 @@ struct mshv_irqfd {
 	struct mshv_lapic_irq		     irqfd_lapic_irq;
 	struct hlist_node		     irqfd_hnode;
 	poll_table			     irqfd_polltbl;
-	wait_queue_head_t		    *irqfd_wqh;
 	wait_queue_entry_t		     irqfd_wait;
 	struct work_struct		     irqfd_shutdown;
 	struct mshv_irqfd_resampler	    *irqfd_resampler;
-- 
2.51.0


