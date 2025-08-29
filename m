Return-Path: <linux-hyperv+bounces-6666-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2F3B3BA16
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 13:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 847147AE2A2
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 11:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351872D2497;
	Fri, 29 Aug 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvkHMjga"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07181238C0A;
	Fri, 29 Aug 2025 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467868; cv=none; b=oNkSlUZziQPiWrRsa7kB05Z0WMWudVpekk0a5PHpxHWJoNP2uUZyyuw2641PUYHkrt1iax0YzTx3/9bTQKJzkPLCCK5A3NN1yurGnzgK9LFq4iatNymS6iAvRRCLuZRmuyOXe+XR2rj/4ZY2vOvRMGQorxcXtmEEPzWGZzJUusM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467868; c=relaxed/simple;
	bh=Bw5aq1MAC51vcC+p3rrqm2KEnbn3uHb0txX6ChldSMg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fw6p1NjXkopporq+CgZqyROfnUBdHij2iF1K3xs1VIkYQR8z0XBD5uGO+JEh11jHwpJFRwgVGkluU4aF67jYRn5I27g3GiaWwjw+bE6bZrGr+Ec9kZgi1QC87WtKZ3phtByabbpkt9MviqN2X4L46ZPLix2ImJmvrDU8Fdpni5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvkHMjga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3959AC4CEF0;
	Fri, 29 Aug 2025 11:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756467867;
	bh=Bw5aq1MAC51vcC+p3rrqm2KEnbn3uHb0txX6ChldSMg=;
	h=Date:From:To:Cc:Subject:From;
	b=uvkHMjgaPQX4mLJAH6CkmgPjBhJAjffcE7/hhiQjzjOPbEHoTu2vAf6Jwh0UKhIqN
	 I/L5DVwnQ0RUe6jbEtwBgE2ToQ3IEi/uuMmxPTZDCY9EWG0LIy4CV71zAvprKjvmLD
	 FEinkVqSLzyaSsOu3DVc7QvFS5mi5lNCtDN/3oW6YtvBX6qygW6Ky3C+cXzscMCmT3
	 c3KKPrmgTMeKWXndI4gQGou2ffTR5Y+Ce5mUQHNJLLhTR0sy9hx2+LoHnPCHUTXEwH
	 pjybc2juz2vd5EWE4QfTm2Rv61WueWeXFaPymHfQDbQYYHBoHnk8+9rC7v4esY3J1N
	 JJLolw3G2MNNg==
Date: Fri, 29 Aug 2025 13:44:21 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] hyperv: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <aLGSlaa6Llqz7jkJ@kspp>
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

Use the new TRAILING_OVERLAP() helper to fix 159 of the following type
of warnings:

    159 ./include/linux/hyperv.h:711:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM)
and a set of members that would otherwise follow it. This overlays
the trailing members onto the FAM while preserving the original
memory layout.

Also, move `struct vmbus_close_msg close_msg;` at the end of
`struct vmbus_channel`, as `struct vmbus_channel_msginfo,` ends
in a flexible array member.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
--
Changes in v2:
 - Fix subject line.

v1:
 - Link: https://lore.kernel.org/linux-hardening/aLGSDpi4xDjUUYVm@kspp/

 include/linux/hyperv.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index a59c5c3e95fb..efdd570669fa 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -708,8 +708,9 @@ struct vmbus_channel_msginfo {
 };
 
 struct vmbus_close_msg {
-	struct vmbus_channel_msginfo info;
-	struct vmbus_channel_close_channel msg;
+	TRAILING_OVERLAP(struct vmbus_channel_msginfo, info, msg,
+		struct vmbus_channel_close_channel msg;
+	);
 };
 
 enum vmbus_device_type {
@@ -800,8 +801,6 @@ struct vmbus_channel {
 	struct hv_ring_buffer_info outbound;	/* send to parent */
 	struct hv_ring_buffer_info inbound;	/* receive from parent */
 
-	struct vmbus_close_msg close_msg;
-
 	/* Statistics */
 	u64	interrupts;	/* Host to Guest interrupts */
 	u64	sig_events;	/* Guest to Host events */
@@ -1008,6 +1007,9 @@ struct vmbus_channel {
 
 	/* boolean to control visibility of sysfs for ring buffer */
 	bool ring_sysfs_visible;
+
+	/* Must be last --ends in a flexible-array member. */
+	struct vmbus_close_msg close_msg;
 };
 
 #define lock_requestor(channel, flags)					\
-- 
2.43.0


