Return-Path: <linux-hyperv+bounces-1645-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8A486E9CB
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 20:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85CA287E9C
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 19:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603C63CF51;
	Fri,  1 Mar 2024 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="u9Fo3mrb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015383B282
	for <linux-hyperv@vger.kernel.org>; Fri,  1 Mar 2024 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709322057; cv=none; b=TKLXUPFIaFQs1yyh0JbTnss3g1D8culsBBO1q1lUNG/orFmti3FlwBIoSA5eqZQ8VMdG+YQMnLjVqK96sI+Nnx+RnehKDH2u7ged07WJbnAxTUxG+6dU220TtBJBLvzk+5VefA8TXt/y9rsYJz+QHR00sW/drILZ82pgWOr/XOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709322057; c=relaxed/simple;
	bh=ALcC3CaJfmLivYATmbVgo8sZG5WxbJSNk2vIXJaBKx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAXcmhhpP/ahmR6HNq5dGAGh1NeqU8ZmXsv+ctaO3WfIDMbFtaNPuu6FAuuLVfwGsBNYkHS3sj05usVpADVoROmqWrChcUZUseSGaDFS1UTD309YuQGpcuQCIfcZFuNcOjLw+zEXHE4w9OYOSVlLjF4vGTx3Mnecxw5HzdmlTl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=u9Fo3mrb; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tmdjx2frwzktW;
	Fri,  1 Mar 2024 20:40:53 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tmdjw3y19zq0s;
	Fri,  1 Mar 2024 20:40:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709322053;
	bh=ALcC3CaJfmLivYATmbVgo8sZG5WxbJSNk2vIXJaBKx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9Fo3mrbl+44096yxCQqPJrxB9Bv0UdKRFIxq9dJBpVvCydwx9rXQ6mjH/NsGOLfA
	 2bUnjD3vO4V6KmPD6bW8Y938TLqRPJMs4C0K1COoDdxa8dquqmPIFKJExCqnEdghWE
	 Wc/zD+duRRuF5SzUY+RAhKgkL9Kr1oVplaska6p4=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	Kees Cook <keescook@chromium.org>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marco Pagani <marpagan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>,
	kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v2 3/7] kunit: Fix timeout message
Date: Fri,  1 Mar 2024 20:40:33 +0100
Message-ID: <20240301194037.532117-4-mic@digikod.net>
In-Reply-To: <20240301194037.532117-1-mic@digikod.net>
References: <20240301194037.532117-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The exit code is always checked, so let's properly handle the -ETIMEDOUT
error code.

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240301194037.532117-4-mic@digikod.net
---

Changes since v1:
* Added Kees's Reviewed-by.
---
 lib/kunit/try-catch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 73f5007f20ea..cab8b24b5d5a 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -79,7 +79,6 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 	time_remaining = wait_for_completion_timeout(&try_completion,
 						     kunit_test_timeout());
 	if (time_remaining == 0) {
-		kunit_err(test, "try timed out\n");
 		try_catch->try_result = -ETIMEDOUT;
 		kthread_stop(task_struct);
 	}
@@ -94,6 +93,8 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 		try_catch->try_result = 0;
 	else if (exit_code == -EINTR)
 		kunit_err(test, "wake_up_process() was never called\n");
+	else if (exit_code == -ETIMEDOUT)
+		kunit_err(test, "try timed out\n");
 	else if (exit_code)
 		kunit_err(test, "Unknown error: %d\n", exit_code);
 
-- 
2.44.0


