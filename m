Return-Path: <linux-hyperv+bounces-2023-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB698AD9EB
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 02:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB822842AF
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 00:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F330015B11E;
	Mon, 22 Apr 2024 23:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0ffp71R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53AD15B114;
	Mon, 22 Apr 2024 23:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830130; cv=none; b=WuFL0oT1lBmXjeHYI4IaKyVshEnUQPv8p0ezIJkDTyCbbEIEieMWkvbPjW1uUYiFmsGdqfXFNvHuCkIqrCYvnK+cgDgJ54d98SDjLvTtMYNkeEFL4KSXC9M/gOu4f2wsD1BjHi1Sb/G5JgFJcXz7gXTvZMkL1U1PBpsac/2KNIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830130; c=relaxed/simple;
	bh=2ohdiVvEIOrEQz0rntP/pWeXmB6943ltgofx1Ntyu8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0bsodOxaghIUJsA/wVUKniMuLJ6d89IA8/d5juuItZnB2SSFfh4GJa2DlVyYkcxYFpgFQi5ypyaygYdsB3IspvYKFE5+jDnJQjxUWGzBqPsn0modfs8UwQ1C98XONhEaVAY/cztmWiU0ADOf/QpiwyL2UT5pFbU5uQxQxV63vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0ffp71R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61741C113CC;
	Mon, 22 Apr 2024 23:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830130;
	bh=2ohdiVvEIOrEQz0rntP/pWeXmB6943ltgofx1Ntyu8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i0ffp71RFJZQ4OOQLlfsW7SmYI5Z3ABjlDqoa9fvyR8JEWKwAqlM7XjKs26occWKK
	 KBNtnriWNYws6+4nPwz0WAIKzTfur3TpnTaUerVn4TIjUQVjXPySimpBYoFB6Cp171
	 sQhuyu2Xx7sQcMZKeaKeOzWhJLu7ctfDN+zgb5uJA3tpW4DcniUN5h7KbvTaJgHkxp
	 OTGZ3JPeIaa1JBfiMPqm4vXJYBy/92lqgs4fUW6BhiPcrFf+qIlmqJ1MrJupw7BQnj
	 iYLsL0Wgmp8HzMTIJ04kYnRZw3rT2fsZVxON4oaM6QMFtjn2CTG2xsYX9q2MGrUcgW
	 MfyeL5BxeUMJg==
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
	linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 35/43] Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails
Date: Mon, 22 Apr 2024 19:14:21 -0400
Message-ID: <20240422231521.1592991-35-sashal@kernel.org>
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

[ Upstream commit 03f5a999adba062456c8c818a683beb1b498983a ]

In CoCo VMs it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to
take care to handle these errors to avoid returning decrypted (shared)
memory to the page allocator, which could lead to functional or security
issues.

VMBus code could free decrypted pages if set_memory_encrypted()/decrypted()
fails. Leak the pages if this happens.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20240311161558.1310-2-mhklinux@outlook.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20240311161558.1310-2-mhklinux@outlook.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/connection.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 3cabeeabb1cac..f001ae880e1db 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -237,8 +237,17 @@ int vmbus_connect(void)
 				vmbus_connection.monitor_pages[0], 1);
 	ret |= set_memory_decrypted((unsigned long)
 				vmbus_connection.monitor_pages[1], 1);
-	if (ret)
+	if (ret) {
+		/*
+		 * If set_memory_decrypted() fails, the encryption state
+		 * of the memory is unknown. So leak the memory instead
+		 * of risking returning decrypted memory to the free list.
+		 * For simplicity, always handle both pages the same.
+		 */
+		vmbus_connection.monitor_pages[0] = NULL;
+		vmbus_connection.monitor_pages[1] = NULL;
 		goto cleanup;
+	}
 
 	/*
 	 * Set_memory_decrypted() will change the memory contents if
@@ -337,13 +346,19 @@ void vmbus_disconnect(void)
 		vmbus_connection.int_page = NULL;
 	}
 
-	set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[0], 1);
-	set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[1], 1);
+	if (vmbus_connection.monitor_pages[0]) {
+		if (!set_memory_encrypted(
+			(unsigned long)vmbus_connection.monitor_pages[0], 1))
+			hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
+		vmbus_connection.monitor_pages[0] = NULL;
+	}
 
-	hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
-	hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
-	vmbus_connection.monitor_pages[0] = NULL;
-	vmbus_connection.monitor_pages[1] = NULL;
+	if (vmbus_connection.monitor_pages[1]) {
+		if (!set_memory_encrypted(
+			(unsigned long)vmbus_connection.monitor_pages[1], 1))
+			hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
+		vmbus_connection.monitor_pages[1] = NULL;
+	}
 }
 
 /*
-- 
2.43.0


