Return-Path: <linux-hyperv+bounces-2025-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D148AD9F2
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 02:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C2EB26E7C
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 00:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77FA15B96B;
	Mon, 22 Apr 2024 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmMNefCi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C015B575;
	Mon, 22 Apr 2024 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830134; cv=none; b=HICNhFgnbxvS9/Ahlf32FkfP/wJWkodjNE92iIj8Aa9Kv+hM/UxNBhOth1rtyPtVK1s7bhwrExWjYppsGQAbJe9Em75xw+drEH0bL6k8Z1KD2hnbgQ9MgK4ah+iWjuVCQAgbuuRQ4yFiZXTVoUD8Tmq2GrBBvtbtq+CLYFrjFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830134; c=relaxed/simple;
	bh=WrcENzlMWj81bXD8h4Oy1nbVfXMzWJChZl026RY/cDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgTsGxw+ngdh2rvQxtr7D8qvAA0Vaj7AogoOnJUt59y6z9n2mxt2onWrHgtdwVEgB53XB4OJpJMDU7smhI8d8mVWXDoi1uIgMom7hTnIduMkioxPG7xaC+TyOMpGm/ECjUnaA/F57qWo58fOEcDdgbfSFaw5KHTHC6MnWHfOU64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmMNefCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAD0C32782;
	Mon, 22 Apr 2024 23:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830134;
	bh=WrcENzlMWj81bXD8h4Oy1nbVfXMzWJChZl026RY/cDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmMNefCiwZcq2KKFkyh1Jsom5W859BQuFjLtZ8i+NZpd7z0Yspm7CZi8+FANlk/HC
	 3PF7p/3Np4e+qVTs1tvx30AmZ8c4lNue0hB+lmvIsejx4Beo36V7Q/8lNLFqBg4ytz
	 PkRVbTZvMUVMtrByRsWZzH9D/YO2soQ71oRH/bqZfAyplkE+Uk7XKYg1nvRCSanOeB
	 KuN5gNfAzlcjnWqtotXh+3WjPehYEmjZcqKCnBMlcVdVOzmCafqNBVSwxL0dz6fjWs
	 wQNHjHxmez92HABhle8cZ4R9vmU4e2atFS/q27ENsCTHkHkPYS07VOmLs4ZKyhyLmr
	 kaD/G1N3+9YOQ==
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
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 37/43] hv_netvsc: Don't free decrypted memory
Date: Mon, 22 Apr 2024 19:14:23 -0400
Message-ID: <20240422231521.1592991-37-sashal@kernel.org>
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

[ Upstream commit bbf9ac34677b57506a13682b31a2a718934c0e31 ]

In CoCo VMs it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to
take care to handle these errors to avoid returning decrypted (shared)
memory to the page allocator, which could lead to functional or security
issues.

The netvsc driver could free decrypted/shared pages if
set_memory_decrypted() fails. Check the decrypted field in the gpadl
to decide whether to free the memory.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20240311161558.1310-4-mhklinux@outlook.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20240311161558.1310-4-mhklinux@outlook.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index a6fcbda64ecc6..2b6ec979a62f2 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -154,8 +154,11 @@ static void free_netvsc_device(struct rcu_head *head)
 	int i;
 
 	kfree(nvdev->extension);
-	vfree(nvdev->recv_buf);
-	vfree(nvdev->send_buf);
+
+	if (!nvdev->recv_buf_gpadl_handle.decrypted)
+		vfree(nvdev->recv_buf);
+	if (!nvdev->send_buf_gpadl_handle.decrypted)
+		vfree(nvdev->send_buf);
 	bitmap_free(nvdev->send_section_map);
 
 	for (i = 0; i < VRSS_CHANNEL_MAX; i++) {
-- 
2.43.0


