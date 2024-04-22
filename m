Return-Path: <linux-hyperv+bounces-2027-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8E38AD9F9
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 02:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCFD0B228A4
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 00:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE11915D5CE;
	Mon, 22 Apr 2024 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmenZkOd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931FD15D5C8;
	Mon, 22 Apr 2024 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830138; cv=none; b=s/PH9nrJspjnd1vN5+21PIoe/RRpaWZ78tRD4dbHrAp3c0r6EuhIZ4HZhp8S9AcUJcfkoWLffII7uPyYMmDGFTTO/A+inMfEpysXdXKfPJcUW5v0uidtCiQvedNgsFaYZnQQsJ7Za3VeI9lECNupkSBO7OzzD0BiJ8ZCYL8ePLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830138; c=relaxed/simple;
	bh=dqQoY69A4VHgwPnhwclSyQBt2D3ST16MryARgm3ENbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hU52cP/bkvyPrDu4t+ZD6KisljEhfNBZR5es/Var/E5DD4KieCOE729rhscMHRkRqgcnkEi/ldyTYAtZNyXdxTnRyx2YhzCx2FpX8GoPht8/iRhgT3gnh4yoMLyMWUoAF41tDpwfj+UbI2dlqOigBV73d6HL4vpQ+6v+xwhV2eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmenZkOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EB9C32786;
	Mon, 22 Apr 2024 23:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830138;
	bh=dqQoY69A4VHgwPnhwclSyQBt2D3ST16MryARgm3ENbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OmenZkOd+v8gS4rAA1/x9ZtT1CLn9j99A/tRjFsXwSbkFfwasmwB8cTvfGNPDRER6
	 pzhi2XI1aCq29IhiQC2Q8nypAH5zQv0lsC6IKuDujin3tRI8Kj2AHWMRHFwZ7k26/L
	 ZErL5rRifyVkBlRzUHGO2042d81aN0H44vaxjGhF7eBO9LQNqWGEtDmsRm5mL/V+j2
	 LfSQTWuUHGTTHz2Cw6DLGMaFwDbTv/vjDx12BpmKvVv/3r2FFq6jr8nAgqHfDmJmqh
	 RgqMWzWNCzx0mXiGD8/VsteHOfr2yk7sQF8eG1Cbzj06x07np+TymKh/LOBP2DK4PF
	 MsxW06uetv5xA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Kelley <mhklinux@outlook.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 39/43] Drivers: hv: vmbus: Don't free ring buffers that couldn't be re-encrypted
Date: Mon, 22 Apr 2024 19:14:25 -0400
Message-ID: <20240422231521.1592991-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

[ Upstream commit 30d18df6567be09c1433e81993e35e3da573ac48 ]

In CoCo VMs it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to
take care to handle these errors to avoid returning decrypted (shared)
memory to the page allocator, which could lead to functional or security
issues.

The VMBus ring buffer code could free decrypted/shared pages if
set_memory_decrypted() fails. Check the decrypted field in the struct
vmbus_gpadl for the ring buffers to decide whether to free the memory.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20240311161558.1310-6-mhklinux@outlook.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20240311161558.1310-6-mhklinux@outlook.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/channel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 98259b4925029..fb8cd8469328e 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -153,7 +153,9 @@ void vmbus_free_ring(struct vmbus_channel *channel)
 	hv_ringbuffer_cleanup(&channel->inbound);
 
 	if (channel->ringbuffer_page) {
-		__free_pages(channel->ringbuffer_page,
+		/* In a CoCo VM leak the memory if it didn't get re-encrypted */
+		if (!channel->ringbuffer_gpadlhandle.decrypted)
+			__free_pages(channel->ringbuffer_page,
 			     get_order(channel->ringbuffer_pagecount
 				       << PAGE_SHIFT));
 		channel->ringbuffer_page = NULL;
-- 
2.43.0


