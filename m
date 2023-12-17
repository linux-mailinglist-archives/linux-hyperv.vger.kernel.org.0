Return-Path: <linux-hyperv+bounces-1348-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404AD81626C
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 Dec 2023 22:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA89E282509
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 Dec 2023 21:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D58B4A9A2;
	Sun, 17 Dec 2023 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgIDyJup"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A532495FE;
	Sun, 17 Dec 2023 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4274fd310c2so15778991cf.3;
        Sun, 17 Dec 2023 13:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702848740; x=1703453540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpzqsz/EY8Rq2EqPBcLuvwzIwmdW6wTukR95VYfZ1CM=;
        b=IgIDyJupFClZoNgCuvM1/sUlMo6Cw+hjm7qrbaiZkto2eW3R6F+RUzay1Ql7ldABYp
         ExVMfZSPIk49fOFoi6NceX2hxbioqcq0bMmo2RpsouhEgTxYdXElaGFlDZoVj5rOq13d
         Qbgp2zP0wqQWGAXXJCeF8rb9+rrA4Jyua4DgVNRHtpQh5TsJRTOdFLi1VRnyjq5J5rOk
         QFR1vmvNBGwRHeYSJ8M8WhLOgxehJlBYo1B8XjkKthPDhwPgUd04+ECtff5QU6LTb9YB
         wZA0JSX/hbWw+Ova5chG1Ln3lVWg+dYihPQb5K5UDWLhRxQJ7STEHAhN2Mr1sh730cjj
         cQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702848740; x=1703453540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpzqsz/EY8Rq2EqPBcLuvwzIwmdW6wTukR95VYfZ1CM=;
        b=B5+itcPcoYxZqTuxOg5NJtxqMJLNzeG5WynDO6OnZljgwVmp+xc88N+TcejCOU4Zkr
         FT4vEY7TH2aawsEaAOKZh+0AdtfSj8z4i1FqdWC+fTeNvA0aJ+vjwSM32EI4AEX+Bnhv
         nDpoZpswlVXzO+QPwi9Apnct+4v5oe55qZIjk8Vfm1yYdX72bMdka7CyWpGUYEWMBD8p
         uGhYVwxzEe+VTkP7op4ipsdZjGkMhJC3EU1TgFVxK0GY9ElrHBjxX1+7aU4ofDhTbOQ5
         Hr71gDm4f1VkO2Z/NBAyc81wWxbGrg3h/nLbqZ1XqdgRNj/J1C955VIMPva+f0Dejvh3
         DcQA==
X-Gm-Message-State: AOJu0YzqvHoDDsekiC7qm5QzmwyuR2gnZFvt1pKs2nwKz0edjHY+s/pn
	Sx2AXSJLqvQQkN3Y6twVAf8=
X-Google-Smtp-Source: AGHT+IEZVQkdZq/1iUqyA9DBOS4LYVte6GxBq8TXOHZIg5QPSd3+cDqAgWalYEOrgwQSUGHOemvrcw==
X-Received: by 2002:a05:620a:2456:b0:77f:2496:4988 with SMTP id h22-20020a05620a245600b0077f24964988mr20524359qkn.14.1702848740308;
        Sun, 17 Dec 2023 13:32:20 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:9c41:1dd2:7d5d:e008])
        by smtp.gmail.com with ESMTPSA id p191-20020a0de6c8000000b005e3cbaa5ac3sm1564107ywe.105.2023.12.17.13.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 13:32:19 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	kys@microsoft.com,
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
Subject: [PATCH 2/3] cpumask: define cleanup function for cpumasks
Date: Sun, 17 Dec 2023 13:32:13 -0800
Message-Id: <20231217213214.1905481-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231217213214.1905481-1-yury.norov@gmail.com>
References: <20231217213214.1905481-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.40.1


