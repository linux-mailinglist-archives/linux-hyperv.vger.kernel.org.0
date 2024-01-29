Return-Path: <linux-hyperv+bounces-1476-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D3383FE3C
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jan 2024 07:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3C21C224A9
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jan 2024 06:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C9A4F21A;
	Mon, 29 Jan 2024 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L+BQGoB0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2764D5AC;
	Mon, 29 Jan 2024 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509295; cv=none; b=A+zjDz3OteoA+f/fRXoR97NjXwJEEyoHZANL3wMH24RnwXsnsFWsUikMdtCKPg5KNA5GJ5FsobzcWE8MVKVcFkGrQ+zF/zhYrDCLC9g+TYCcg5eiRFXFwyTB/QGsVpOvPJJhzcXBmKpvIp7Aw89QJZ2I3qdB7qVkpfDwzKW2Xbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509295; c=relaxed/simple;
	bh=2TbGyVSXByR1bZJMjbZ9qzvNekm4PoMQJkQoldzGsDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UEYFrlbzfmgxCOJvW21doYaTY5etEl44/ske7Hl+TX0jGtw9HNIj0NrApoA5TgD/QYvtcneT7hG/JFO2v9w6PaEopwQ+im5EFDq/kJ96MqjFIqrRhmepyOfhXzKOvZcxqvRGVe5Fgo/IqdXoOgGTXaVZuB1leCSPE2XAlb23Y48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L+BQGoB0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id CEEE520E67D7; Sun, 28 Jan 2024 22:21:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CEEE520E67D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706509288;
	bh=ZPRu3SXlIUr+8W26d0LPvybxMOuIzrvNRUu535P0XZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+BQGoB0GLE+KyyR0PnFVug/r66VXfnIBCw46epW85csspHZObEUXpA36eCL+5aXG
	 FkaJ3jqMQoLOZsqelD/vHDM6Ja6B9RlA4q5ScoO7MIn7t/vAJgyYtq1RbDYMeYC+59
	 dUE+JuQXkzd2DGn8h3CGkjEUpMh1Cxd/15HY7InE=
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	yury.norov@gmail.com,
	leon@kernel.org,
	cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com,
	vkuznets@redhat.com,
	tglx@linutronix.de,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: schakrabarti@microsoft.com,
	paulros@microsoft.com
Subject: [PATCH 2/4 V3 net-next] cpumask: define cleanup function for cpumasks
Date: Sun, 28 Jan 2024 22:21:05 -0800
Message-Id: <1706509267-17754-3-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1706509267-17754-1-git-send-email-schakrabarti@linux.microsoft.com>
References: <1706509267-17754-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Yury Norov <yury.norov@gmail.com>

Now we can simplify code that allocates cpumasks for local needs.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 228c23eb36d2..1c29947db848 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -7,6 +7,7 @@
  * set of CPUs in a system, one bit position per CPU number.  In general,
  * only nr_cpu_ids (<= NR_CPUS) bits are valid.
  */
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/bitmap.h>
@@ -990,6 +991,8 @@ static inline bool cpumask_available(cpumask_var_t mask)
 }
 #endif /* CONFIG_CPUMASK_OFFSTACK */
 
+DEFINE_FREE(free_cpumask_var, struct cpumask *, if (_T) free_cpumask_var(_T));
+
 /* It's common to want to use cpu_all_mask in struct member initializers,
  * so it has to refer to an address rather than a pointer. */
 extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
-- 
2.34.1


