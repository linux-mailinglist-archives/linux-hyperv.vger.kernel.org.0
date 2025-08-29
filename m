Return-Path: <linux-hyperv+bounces-6665-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2301DB3BA0F
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 13:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780CF1896675
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 11:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C17C2D23B6;
	Fri, 29 Aug 2025 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBfX1eDl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41A0257AEC;
	Fri, 29 Aug 2025 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467732; cv=none; b=ba1DdkZfZEXbBDuS/4c/SLdXa6uXdg9CzIujt/C4dTzYlok8rFB5TWv+24XWDaSFTuPi9RO5yS2qzyOm5xUlA+obw3GMv1Xpy9eaiKxfCNGvkuSflJB6zSSq43XIwyGUuMPSGevsKVq2EqJo3zrFi7jnQGqwbfDIdwveTZDTNWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467732; c=relaxed/simple;
	bh=mGCJapa3IJ0+IehasQuuYXSnKezNpFS2eVXdXMDPA7g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sBPMcvPGqovCBgBSPcKmqZ4qAHf9i1o3k7UVovVthlaQx8d4TAaeAjfnxbEHExtGg+tSLe2Nglgm2m7TN99qDxraLBSafrHfB8xuEvjMeqa6KOAUdrgB8iGl7f0yh1QMCa4iJPQAtYWujFyGf/lo8qAgisEa0cKal1E8adnKSXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBfX1eDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E82C4CEF0;
	Fri, 29 Aug 2025 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756467732;
	bh=mGCJapa3IJ0+IehasQuuYXSnKezNpFS2eVXdXMDPA7g=;
	h=Date:From:To:Cc:Subject:From;
	b=XBfX1eDlFphW7kw45SYhUUbftjExKsu1A0WI3T+9sqJSt/eTy2fBFbCG17kdAskXm
	 Uvr0KGP3iiiCQqzMsOcRvJ2oPaoUV/hBeuPV2Nq2a2FIoMZzNZ36emag8EcjWFuIyT
	 8xZbCbBA7L0fqp+ZH+AidKHFlhxruyls15wJqu9J4Ec82icw2HEAZSJD4e4nopSQI8
	 P4ytcpuSfRNWdNij/B9zayemNmPOcY4fW5NrK1/D+gUvChCNoPxGcUQxEOU7CwY9Z/
	 mgOAvP1l+MKjQsG+9sJ2GkSdWwi5/0uNIZWOvJGXbAxSy4pxrqCPv71baYKt/Pv9b5
	 X7a8sAo4mjmxA==
Date: Fri, 29 Aug 2025 13:42:06 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] hyperv: Avoid a hundred -Wflex-array-member-at-end
 warnings
Message-ID: <aLGSDpi4xDjUUYVm@kspp>
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
---
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


