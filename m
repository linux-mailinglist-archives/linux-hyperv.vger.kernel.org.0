Return-Path: <linux-hyperv+bounces-8041-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B46E3CC539A
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 22:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0E49300BAE9
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 21:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AE933C1BE;
	Tue, 16 Dec 2025 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ/kMbZT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9884133C1A9;
	Tue, 16 Dec 2025 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765920986; cv=none; b=OvrwpHrOsuChB8BsZuORvZfnfWvKfjT/N+Nrii6iYZSGtGRAX3WKhWtH/TjaPBNuQDCxtLexU6lutV3k0NmC4Bpm6dm6/p14MEBWEGsGtTnjECe9KBtp3o8tK3/P9qV43fPa8jp0k4bqNSC/k6469wmRM2AFv1NMgTPcC/9ixcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765920986; c=relaxed/simple;
	bh=CZm4Ou8GmB3GBrOhF3DE0tNwCjN+vQZb6UE6ul2Gdlk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CjPS561P6HPf5oekUM/WLYeHcCGyWKhCImWSgKyk1Q57B0HXIo/Z6gQ+zkOmKcPo/q8YG/XXcdbTLdNnIR6Shn2Aop49axVTXT/nBnJQyrPoUDUCu1LZKGY1HZEJnkkTKWoznhmZ+JtkdpYKyqbjgpJ68w9c8rBJsvNGamDXwUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJ/kMbZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A0EC4CEF1;
	Tue, 16 Dec 2025 21:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765920985;
	bh=CZm4Ou8GmB3GBrOhF3DE0tNwCjN+vQZb6UE6ul2Gdlk=;
	h=From:To:Cc:Subject:Date:From;
	b=ZJ/kMbZT33FGwibWbMg8SlB58dbdkvFFelCNiexwc0CfKc2aSmfkD+8c71Q3/DzDf
	 0CUnVHZzCEKNH1O8thK7Zt0LbHGcCMjVtQ68kYLGQNMjY5IwTNR7P0n5VvghiQ1RlC
	 cR7kgitpK+r/OnYE1t5a0Wj4abRikpGv20Twhi+uJL8jkuDzEi8qJUIcg70Qyk2P9M
	 H/TlYb2YJMIHRGi/GoAqyHDS+vk089+mR8jnX3JZQFuLNZk0z/Y26OlH2aK336uNn7
	 HKO2nsusaAYASUEMakXJt15e/71ru3QZ+FC9JNdjLT+qY+OsFJEtqjivuN5Uc5ti62
	 zEhaZ452R2hUw==
From: Arnd Bergmann <arnd@kernel.org>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Stansialv Kinsburskii <skinsburskii@linux.miscrosoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Anatol Belski <anbelski@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Sean Christopherson <seanjc@google.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mshv: hide x86-specific functions on arm64
Date: Tue, 16 Dec 2025 22:36:12 +0100
Message-Id: <20251216213619.115259-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The hv_sleep_notifiers_register() and hv_machine_power_off() functions are
only called and declared on x86, but cause a warning on arm64:

drivers/hv/mshv_common.c:210:6: error: no previous prototype for 'hv_sleep_notifiers_register' [-Werror=missing-prototypes]
  210 | void hv_sleep_notifiers_register(void)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/hv/mshv_common.c:224:6: error: no previous prototype for 'hv_machine_power_off' [-Werror=missing-prototypes]
  224 | void hv_machine_power_off(void)
      |      ^~~~~~~~~~~~~~~~~~~~

Hide both inside of an #ifdef block.

Fixes: f0be2600ac55 ("mshv: Use reboot notifier to configure sleep state")
Fixes: 615a6e7d83f9 ("mshv: Cleanly shutdown root partition with MSHV")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hv/mshv_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
index 58027b23c206..63f09bb5136e 100644
--- a/drivers/hv/mshv_common.c
+++ b/drivers/hv/mshv_common.c
@@ -142,6 +142,7 @@ int hv_call_get_partition_property(u64 partition_id,
 }
 EXPORT_SYMBOL_GPL(hv_call_get_partition_property);
 
+#ifdef CONFIG_X86
 /*
  * Corresponding sleep states have to be initialized in order for a subsequent
  * HVCALL_ENTER_SLEEP_STATE call to succeed. Currently only S5 state as per
@@ -237,3 +238,4 @@ void hv_machine_power_off(void)
 	BUG();
 
 }
+#endif
-- 
2.39.5


