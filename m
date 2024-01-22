Return-Path: <linux-hyperv+bounces-1457-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3E8836C97
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jan 2024 18:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AF61F23953
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jan 2024 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B614D10D;
	Mon, 22 Jan 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AKDgAkWL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA5C4CDE6;
	Mon, 22 Jan 2024 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939267; cv=none; b=Bof/Fqf+LpVYyUVzZMf97H4TINowQb937cM845vpybQfe1NkqJa3I1M/P52Y5NBkeoNfrTFKkzFwvI/td2g/w1wecUr8o1NyhH4t/4Rv/oB2nCuKfPkvsIse6i2Os5YHbxrPgUbkvfVhGDiv4O6iMFZP8v7KtDy++l6vPrnGZbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939267; c=relaxed/simple;
	bh=2TbGyVSXByR1bZJMjbZ9qzvNekm4PoMQJkQoldzGsDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pSbwWUXbegyHh+hQK8hd4a0vbH8d/aGDOIPNCVMCJst6m39eixqMq1ieUaceiRWhsQ2LgzEmld/nlcQhhdRrPcqPhJGxDXEqRuPa9gFl6j/irw/VGh+v70SKOiQtu8HYoj1jV+NoU+QVW6FqQ3oNmNwFMp+R8lHlnXZuBNhRoSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AKDgAkWL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 9530920E2C0A; Mon, 22 Jan 2024 08:01:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9530920E2C0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705939265;
	bh=ZPRu3SXlIUr+8W26d0LPvybxMOuIzrvNRUu535P0XZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKDgAkWLzV0U2zIt5nj8Hi0D4OHGYOOGV3Jne5X/sd99ywR4usOMFH6coqLERn/l3
	 ndFr+yoL29aSILQLoy0OU/u+dBKEUp8egDYY0jczB8HT/jXsuEDIF1sZ69eQQ6RYMN
	 u4zD16Bf97ZboTWtoF3yKmvNaqYe321T80IICyjA=
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
Subject: [PATCH 2/4 V2 net-next] cpumask: define cleanup function for cpumasks
Date: Mon, 22 Jan 2024 08:00:57 -0800
Message-Id: <1705939259-2859-3-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1705939259-2859-1-git-send-email-schakrabarti@linux.microsoft.com>
References: <1705939259-2859-1-git-send-email-schakrabarti@linux.microsoft.com>
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


