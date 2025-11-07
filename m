Return-Path: <linux-hyperv+bounces-7458-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FFDC401C0
	for <lists+linux-hyperv@lfdr.de>; Fri, 07 Nov 2025 14:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED1E189BC52
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Nov 2025 13:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975AD2DE6F1;
	Fri,  7 Nov 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fjst45OB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E322DCF5D
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Nov 2025 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522044; cv=none; b=Fx6+vZp7KKwenrMFMvCn0SO/M4VN7Mwp9RQArppo7yJcnB3j/m3uDhr/sVvJ7L1XH0gypvB7+kQqP6Yenrn4kqrfxIM5THUEQuFvb9c1/1hqCpxDoynyCQJztMvYPa8GzbUD6On6S7Vwd19cg2QaVtlyqsY5iL6xxv08SY7SxFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522044; c=relaxed/simple;
	bh=xOgIgUMI+BwDiOq38R4O8HSLT6TrQvpp/zCzKFcAC5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eXsc38x0tJ3ugnOXD+HBIdaFfjq/ulG2F0NDlG/w0BnO6HNTMIVUO3X6wpky9AOW3ACin4TSMLAcSRd3BvoD2iDTr7N23uo7I2AVLNbybzHQimgBCfkmOhu7rCv/3kpxjLZuTIWmGrmi2/AmK5Fhee5GpmiyiiW3UAunMErent8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fjst45OB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429b895458cso400292f8f.1
        for <linux-hyperv@vger.kernel.org>; Fri, 07 Nov 2025 05:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762522040; x=1763126840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gpDBdHac69yHdTxfS3btmvWgT1JTkvIR7tXnz5+sQMg=;
        b=Fjst45OBz35+4Bm29+PhAJ7YQZmD2SYiwbQ/UXlJDFH30ESQ2Ao83E3ervY7mhqzLD
         CIiKqEQ1iZq6yMKqUwtmUEfknXQxMs/3ZQGzLgqsVBAGKfUC4CtCc0U2GQCg+ntn8hLP
         8GNQe0SdW00QkMOhlAKEWPymraLckuZarBm3lBlRVBx5ttT75/hHe8Qwv5/vpehTD2lJ
         7jTrIR78ILxK8zULOBRDB4capkWnpXH7kzrNTwfrDG0+yR+Jv95NOtdOh2Rai8SnrSyC
         Cb8AIVQ3q+vuegvMPTl09EBIaH8eeqb+Xqo2OQTKtaCNmcUJzU0d59lNhXaTQtb8eAzH
         2ffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762522040; x=1763126840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpDBdHac69yHdTxfS3btmvWgT1JTkvIR7tXnz5+sQMg=;
        b=BAhcRVsXYq3fZIFOCVYTyy3o7hr4ZKnOXfHl7/61ooA4BFF+wEGYkFs+JMKrb8H1lS
         ZvumO7dRga764Y39KR2iOn7zK+G2u47cgWN7UWrHWgc+KUnbXoToQESLOrJFY/SyMMEr
         WoV7Cg9FaYh4SLJ5xBQazXCLxQeCnWmS72+51XbPjGUC4cKHeq0frXmLYvSn7dtu0xjn
         YKWJpTiaHy1SHIu3Hx3kFjHREyDlJ7pTNvmZtSKeB9qWKBLyxtadT+OKJuY/J5ZSPqXk
         oKJzqYONLq+Bu67UFhBJwx3hocPX2zmLl27oRIEfYlSLQqGtPsimI78+1KvmW+wq9CVN
         PJPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeU+Cj5YAcoI507f9A1D4dBgO5nvFOphwMYRIr76w9YFzICWVBfav7Z9eFoPurnSVlbmMTfarLw6Uv3DE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn5oYkGbALf5P4gZ4QLhn8X+wpLk+TbM1sqrEBTQTiR4E5HtR5
	57wdlRci0WHSjxiDY0jpYMmoza9322kiZjoPC7iKJmOVo6S4PzjK7Jol6GFNlgvP8Lk=
X-Gm-Gg: ASbGncuWrqHvcqtOZChTeokDE1tyyaqgXGyAiPqhIca3LYL3bjbB6yozDECUcWL6Mtg
	YuU7v+21+fVv1pjMSnqd/8CGGD5Qd3cc/lRqG9ShMUUvlB27NpGZeZzcZ7HnrTe+6nooGYerg0c
	LIxyAZMVDyXStYLzIPLmRELhh/Nmj7upv5I38kPFK565Xy+fjPc9lL/R3hrrcvr55IiIjB4aH76
	degKK8ExuVXCMcb7K+4QBR+UYHb4AovtNLeSoY4s4hHD5OyGTWtTQZncxASlrcRex3LkSTiOYL5
	9SsaD3tu2uV2WebztjI+wCrFyn7mncT/3ZsXwWV3ddlYe1K5Ssbvl5vX72NcZ5y+Vdk08zZ0q/x
	WoMk/OWFnDpG8QCBuxuK9bEvvhqupgSXOAgptPd1FduuMUjRN/DZuN7mMJb7jDIuvjEooLyA6zg
	teXDppJGM23r2wsuQRGlKBUX4P
X-Google-Smtp-Source: AGHT+IGXoQU2aKwjfhm9zFbD1wEw86QWRNpD8ObJ2BhZ4tbaRurd6UaGdy791fVPME62ucuMSvHuLQ==
X-Received: by 2002:a5d:5d06:0:b0:427:921:8985 with SMTP id ffacd0b85a97d-42ae5ac206bmr2453743f8f.40.1762522040253;
        Fri, 07 Nov 2025 05:27:20 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b29e4b9bdsm907220f8f.32.2025.11.07.05.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:27:18 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] mshv_eventfd: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 14:27:12 +0100
Message-ID: <20251107132712.182499-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/hv/mshv_eventfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 806674722868..2a80af1d610a 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -592,7 +592,7 @@ static void mshv_irqfd_release(struct mshv_partition *pt)
 
 int mshv_irqfd_wq_init(void)
 {
-	irqfd_cleanup_wq = alloc_workqueue("mshv-irqfd-cleanup", 0, 0);
+	irqfd_cleanup_wq = alloc_workqueue("mshv-irqfd-cleanup", WQ_PERCPU, 0);
 	if (!irqfd_cleanup_wq)
 		return -ENOMEM;
 
-- 
2.51.1


