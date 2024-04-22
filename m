Return-Path: <linux-hyperv+bounces-2035-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECDB8ADA96
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 02:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 652A4B29F80
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 00:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45356181B89;
	Mon, 22 Apr 2024 23:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3OOi8cX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DE1181B85;
	Mon, 22 Apr 2024 23:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830282; cv=none; b=IaPkvHacg6FPJ7bqlRZ/tIUUUOmhSHlPbOrG4/nZZ9nJqoGgx2EudTyRNgKszZxBwToG9qv8Oy79g3rJxrbM3+UYUCwMhnt8KwDrrgLqdGZpCcwvhsU94+vSn2RL4dMhSHOsvVnvSkYK7HKgz2oZQUwGKPUSXjdRCsMlztzVAf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830282; c=relaxed/simple;
	bh=6DH5Rwdcqy+9xB/0WqPMQDHvka0BwH6+dpCDTEw5Oj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIcbeiQp4XCRSVLi05GEuCMhKIPJTAJNymhOzYF6s1slU88mwnCVsR6kFxYyZqWgbl+L4BxcpYkjftLjEK0rtdai4F3RPF6pAWaTMLd/TkzyI4sjq6VoxxALUfQGxpDSl+lATpcg7Pc6suxXyBNauWviOBS+jDkrtAtxfOW1iKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3OOi8cX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3316C113CC;
	Mon, 22 Apr 2024 23:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830282;
	bh=6DH5Rwdcqy+9xB/0WqPMQDHvka0BwH6+dpCDTEw5Oj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3OOi8cXNEa+a1F28vveS+J8os0bvdixPo0OZFRjQBonNB/X9CIp84KeHxOhjlgsg
	 +9in8vRsvCVJfOWhi0hjcyAAhs/gcU9Jp5nND1UB47ImZ/DF01NXs5fOid7CmqPK6g
	 Flb6awJHD9ycjxOWWrYbEx9PzZSb/c7W4PrfE76w0fwy61zBK4XAODwcem7gZVfvXH
	 A2KGKNp64VYzO+JPP2FZxvYwyeKX7FmN7GLLNgBVBgQr/CI6r6A/2PSpdpzNXOILHP
	 hbB3q3LVUqKOg9Kq/ew2PKG5eWI+5CFMDYbr16yySnA84H7ogFPMn3w0V1UFJ06uuH
	 r4sOpEiAk/djg==
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
Subject: [PATCH AUTOSEL 6.1 18/19] Drivers: hv: vmbus: Don't free ring buffers that couldn't be re-encrypted
Date: Mon, 22 Apr 2024 19:18:32 -0400
Message-ID: <20240422231845.1607921-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231845.1607921-1-sashal@kernel.org>
References: <20240422231845.1607921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.87
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
index bb5abdcda18f8..47e1bd8de9fcf 100644
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


