Return-Path: <linux-hyperv+bounces-1605-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB0886D00E
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Feb 2024 18:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738831C22CDE
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Feb 2024 17:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D3270AF9;
	Thu, 29 Feb 2024 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="g3VQrtX/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1B35B1E7
	for <linux-hyperv@vger.kernel.org>; Thu, 29 Feb 2024 17:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226278; cv=none; b=obUe6TqDw29asIefJsmtEx0LshwblAZ5rOHumjt+9dEI7hZ2y4lcj3K1iVrK8SLrjr4E0sHSdbaVY/DHeqcvcpjmGIvV9NPNzSSBZ5rKkzMNwLpeEHAqdDQKCeBmC6gmVBDGWxqKpM+hen9FXfrEsI5vBGD6oyt7T2YY+bPkiNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226278; c=relaxed/simple;
	bh=uBMChHU5UNMlEl3ATgwx20Pp9VOumM9CW4wvZ2gv728=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEl3vjwPSzO/2LLv2rRYXyGpQi4ntseKY2mFP/0TlWlZAsK7LT6NYZJjoWBWnZhUElFpTNVIDEbAs2MR82cC/s7uYH231zgqFpjnSm0l3nYc1IK2uQChgKtMvgKqnFNSXYTk2Z6lXXEMwimNibaj1acrAtcsViqJFNk+0iIOu2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=g3VQrtX/; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TlyHv6JJjzMrkvR;
	Thu, 29 Feb 2024 18:04:27 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TlyHv0Y1GzMppV9;
	Thu, 29 Feb 2024 18:04:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709226267;
	bh=uBMChHU5UNMlEl3ATgwx20Pp9VOumM9CW4wvZ2gv728=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3VQrtX/j4mrYOK5lCD4XPwom/SI0/y/0R4myV2rOLoAWJbQXs3vRNiqY7hBGvPKt
	 IWhFH8Ae2AB6sbRZrZYR+D0SJT6lcgzTL2uwOpY7ATOhYsFr6lnwl26n6gEktkAfAl
	 F696GqV8G1WnaDB4mg5K41u90uy9ksSd19IE4k0Q=
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
Subject: [PATCH v1 4/8] kunit: Fix timeout message
Date: Thu, 29 Feb 2024 18:04:05 +0100
Message-ID: <20240229170409.365386-5-mic@digikod.net>
In-Reply-To: <20240229170409.365386-1-mic@digikod.net>
References: <20240229170409.365386-1-mic@digikod.net>
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
Signed-off-by: Mickaël Salaün <mic@digikod.net>
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


