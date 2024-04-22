Return-Path: <linux-hyperv+bounces-2026-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5887A8AD9F5
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 02:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D8E1C213FB
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 00:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB30A15CD6B;
	Mon, 22 Apr 2024 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="au1NTd3t"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916F815CD57;
	Mon, 22 Apr 2024 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830136; cv=none; b=B9NONhY+flrWGcvPMpwHf3GQP/7qEXpClR8GxO5ruYIIo48MdeSfOIiBu8hVwSe7oWSz/xs8UAnPu8Z7xtPHfj5AuvsGv2/hzFWrePpZyS7Gvy6HipOpJut2Wz498BdJ+IytKTHDx3fzwwp3F81IVPimE4WRCg8dSTblYsc/r8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830136; c=relaxed/simple;
	bh=MfFI79FceBQkgI4UAXMBbRBGaLZv1F2MGplGVU2Fm98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUPm5/O76V91vEGgHDzkbdempv2jnCihiUabM1d7eBIs0TqakuzUy9VO+rspu2MGXuPaSEBZ8Tpb7fJE17LM4DqbNS1Vg8kNkuUdpUTrLpRHKLZ5Y0f0wXaC8QGsOquWGtqDlvvQvXwIA+4TDRm01USY1IgxX8rOBXdykMgT4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=au1NTd3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170DAC3277B;
	Mon, 22 Apr 2024 23:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830136;
	bh=MfFI79FceBQkgI4UAXMBbRBGaLZv1F2MGplGVU2Fm98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=au1NTd3tqOqAbApI8iUdDWfhHa7MW1TCs63vMPrEFoxT/pwEzC2kH55cUg1ok1Cjw
	 YxXe4Li8Ug2fTkMHr6dA5xlgVxHV4BgppUhBbgDyEhstuWRkATCQTNT7WA2ABaY5dT
	 FgD7t40l2lUtFngHUVXiQPZM7XrfdQnrSLhs36t5Sub3uwMBZX9dVA3llMt2USwRYy
	 I1yGavPnhes0HCdjJ2bQmDHuSxuHdRwkIUInGDTmkWWDiILc8zGjPS/hg2buc9pFHn
	 oAfawdoh/WnJUmHZCT1domvd1zStilKlymJ+gnKB9u3B5TKjr019UjPwgGjp2jBF5l
	 vO4vmUUIl4yQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 38/43] uio_hv_generic: Don't free decrypted memory
Date: Mon, 22 Apr 2024 19:14:24 -0400
Message-ID: <20240422231521.1592991-38-sashal@kernel.org>
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

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

[ Upstream commit 3d788b2fbe6a1a1a9e3db09742b90809d51638b7 ]

In CoCo VMs it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to
take care to handle these errors to avoid returning decrypted (shared)
memory to the page allocator, which could lead to functional or security
issues.

The VMBus device UIO driver could free decrypted/shared pages if
set_memory_decrypted() fails. Check the decrypted field in the gpadl
to decide whether to free the memory.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20240311161558.1310-5-mhklinux@outlook.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20240311161558.1310-5-mhklinux@outlook.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/uio/uio_hv_generic.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 20d9762331bd7..6be3462b109ff 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -181,12 +181,14 @@ hv_uio_cleanup(struct hv_device *dev, struct hv_uio_private_data *pdata)
 {
 	if (pdata->send_gpadl.gpadl_handle) {
 		vmbus_teardown_gpadl(dev->channel, &pdata->send_gpadl);
-		vfree(pdata->send_buf);
+		if (!pdata->send_gpadl.decrypted)
+			vfree(pdata->send_buf);
 	}
 
 	if (pdata->recv_gpadl.gpadl_handle) {
 		vmbus_teardown_gpadl(dev->channel, &pdata->recv_gpadl);
-		vfree(pdata->recv_buf);
+		if (!pdata->recv_gpadl.decrypted)
+			vfree(pdata->recv_buf);
 	}
 }
 
@@ -295,7 +297,8 @@ hv_uio_probe(struct hv_device *dev,
 	ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
 				    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
 	if (ret) {
-		vfree(pdata->recv_buf);
+		if (!pdata->recv_gpadl.decrypted)
+			vfree(pdata->recv_buf);
 		goto fail_close;
 	}
 
@@ -317,7 +320,8 @@ hv_uio_probe(struct hv_device *dev,
 	ret = vmbus_establish_gpadl(channel, pdata->send_buf,
 				    SEND_BUFFER_SIZE, &pdata->send_gpadl);
 	if (ret) {
-		vfree(pdata->send_buf);
+		if (!pdata->send_gpadl.decrypted)
+			vfree(pdata->send_buf);
 		goto fail_close;
 	}
 
-- 
2.43.0


