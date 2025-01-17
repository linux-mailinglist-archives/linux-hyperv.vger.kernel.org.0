Return-Path: <linux-hyperv+bounces-3713-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782BEA158A5
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 21:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B463A2081
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 20:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0AC1A9B23;
	Fri, 17 Jan 2025 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MVgnmWOT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0571A83EF;
	Fri, 17 Jan 2025 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737146015; cv=none; b=Jail6xUd4jDvq743DDEQtdbF7bzBb4mqd2y9+Zt5xdGFzC7DqQb5r6OIRSvMvNP7ld1SRA1vGdlThsKTW35Lz+kAShBk0d9Pa+Kx/8qOnTg0Hy31WTLOXL0Rxe3Uo1MxGI0AfODocJzPhbOphtxqa2/18i1JGSO6ymQFNpsKEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737146015; c=relaxed/simple;
	bh=EqbNNsCU1XfO2wEjygjj+QbPHSZ2UOOYqSZVpAoZD9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jTk/PJ9utm9XUQv2A8ZRYerdmqNP28x1UFNDIzvnWVrwGFXV0Dfpx12QTmiZSYh/Hz7xsOzh7UsJi4Etluz66TNLsDBHxnL6BIYSzYTrYUKFDZPwcnuGLEUxhg6eqzhtlMEBT4jmueoeDNd8y5X/uk6GASqzwlae4N7vsTPa44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MVgnmWOT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2.lan (bras-base-toroon4332w-grc-51-184-146-177-43.dsl.bell.ca [184.146.177.43])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2DDB920BEBE1;
	Fri, 17 Jan 2025 12:33:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2DDB920BEBE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737146013;
	bh=7Ovg88zOLpANDZJa86QlAf8OUoOOYFxu2051KnVhpQI=;
	h=From:To:Cc:Subject:Date:From;
	b=MVgnmWOTgvbOlMVrHuQsUbbwtO28knFbGPWKZxIQQj5ebvcHgVEZAp+HgoT1Pj9VE
	 nXzyhxlr8v1hLxwxrSiiA1ZEEp5eCOvgqDDdN9ZNGWPxk8Tnw27ZY0hqP9FetETTAv
	 Si4nr+8cx5TojJCvqCx3hKw36IL0BJ4je0IyI5E0=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] cpu: export lockdep_assert_cpus_held()
Date: Fri, 17 Jan 2025 15:33:06 -0500
Message-ID: <20250117203309.192072-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_HYPERV=m, lockdep_assert_cpus_held() is undefined for HyperV.
So, export the function so that GPL drivers can use it more broadly.

Cc: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
v5: new to the series
---
 kernel/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index b605334f8ee6..d3c848d66908 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -526,6 +526,7 @@ void lockdep_assert_cpus_held(void)
 
 	percpu_rwsem_assert_held(&cpu_hotplug_lock);
 }
+EXPORT_SYMBOL_GPL(lockdep_assert_cpus_held);
 
 #ifdef CONFIG_LOCKDEP
 int lockdep_is_cpus_held(void)
-- 
2.47.1


