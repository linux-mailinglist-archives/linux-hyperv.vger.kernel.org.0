Return-Path: <linux-hyperv+bounces-2032-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B6C8ADA53
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 02:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B37AB25FCF
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 00:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BDE16F8EC;
	Mon, 22 Apr 2024 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/zfL1Co"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67D616F847;
	Mon, 22 Apr 2024 23:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830230; cv=none; b=rdBGNnk2BdyTxoRvAzM5qPOh9PVa/n1BCbEr4dBsMX4Pw9/iBPDk0L4+acxvHF3g+cEZPbv9AtLpq/xcVVwwtLE7fh0jGLnAywvAZ9C8PUY08OZ7cCb4J2JUShYw5nfbpFAS4sfA8QsqQyptG1Nk9hccIIXbq5XwX/qcA9uIfro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830230; c=relaxed/simple;
	bh=6DH5Rwdcqy+9xB/0WqPMQDHvka0BwH6+dpCDTEw5Oj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AC3ItXn8l6a8gRvettyd9diwQPR+pOvt103z4h/9BkVk6XbBLXGkEJy7x5yfxNKD5So4glaj81v4U16fKeJuwEp6v2XsSaBSXU5xP09w6dYPRvYD2KbXqW2Sd50SeCAYroAlIHPgjAMetl2MClnQX+w/gX+tnZjhl/jy6jtAC4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/zfL1Co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C70C2BD11;
	Mon, 22 Apr 2024 23:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830229;
	bh=6DH5Rwdcqy+9xB/0WqPMQDHvka0BwH6+dpCDTEw5Oj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/zfL1CoS0/G0NjrhKMunvW3M8GfOQ2GBJMJ+19qwUBThIfGcRNY+cpNR2HwJWF40
	 NQaYLSrCB9POxKHrsxAV819tNG8nz8PZbr4vyHP/qcdRHLyidNFAWLQbx+SClS+z7l
	 c5D9LCLUHUxfmVaIIidJLG/fcLIYbkBxP7sROM6vghBaqH/zodisiYJJMyAqnbmRo2
	 vsJ3ZhhVWRGCZ5gZmNhW04F7rLAjQ1s9F5Uy2CeEUp2ssgXB6dTqscusGzlGBCf9IT
	 3Hr8+1zY/6u4pwlGx1Rc93u/IMLkxtna8dfcGmFJRMVpNXpTp7Lvmh8mKx2DEqwHFz
	 Hf2C6mwpkEjWQ==
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
Subject: [PATCH AUTOSEL 6.6 27/29] Drivers: hv: vmbus: Don't free ring buffers that couldn't be re-encrypted
Date: Mon, 22 Apr 2024 19:17:08 -0400
Message-ID: <20240422231730.1601976-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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


