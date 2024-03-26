Return-Path: <linux-hyperv+bounces-1829-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B70888BE53
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Mar 2024 10:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1891C38DDF
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Mar 2024 09:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CA1535CF;
	Tue, 26 Mar 2024 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="fBz727+u"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71DD45C18;
	Tue, 26 Mar 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446703; cv=none; b=YnaIj3zZs3hr6JuxuRUv78TtuRT5tLhtf+h291TM+kRD98SGTkghXG9LYB+zy+GhsM/zA8UdepEuMKuI8V0gLFP8TfrqcyWGWtO9xf2PUVznSgVbESqVMLnTgJsaggjvybhR6mELr+rzncnyszhn+sAMJ6DxkyI0V9IlBvMDz2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446703; c=relaxed/simple;
	bh=MbcjOzHQWG1uy0/n9TKIvjFVCyBlYV+x35dsmcifwBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADnopSv3dvArq6I7ARzNIZ6450y7BX4e9ov1LegJL0xsEMEXhG5t14PdreVuExJW7/ES4v+ot6+Q183Ot8vHQ5sHT9HziQPLz6LW0cqqx0ng3kkqDo/O+uDsm9WyFOnobw7I8Ng/8YhIRanaBPMFh/99S7mwdI649nCeH5AHgPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=fBz727+u; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V3lSS1Zm7zbNt;
	Tue, 26 Mar 2024 10:51:36 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4V3lSR3NKGz4GP;
	Tue, 26 Mar 2024 10:51:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711446696;
	bh=MbcjOzHQWG1uy0/n9TKIvjFVCyBlYV+x35dsmcifwBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fBz727+upC4lNytLKeOHMnAeW9WaMrgVWXcJfVYPnUWb22t9Ww5vhNDyxdJAnAxhv
	 igj2YdVE/+1OWb7R7n3bA+aJ70zrop1OZ2UdY33x4pEFsXptluTlHWnRLlQe4ZMRXt
	 tKZL08DOySJ2qWzNozt88NRJ+V7sbOqFG2VYsbQA=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Kees Cook <keescook@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marco Pagani <marpagan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>,
	kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v4 1/7] kunit: Handle thread creation error
Date: Tue, 26 Mar 2024 10:51:12 +0100
Message-ID: <20240326095118.126696-2-mic@digikod.net>
In-Reply-To: <20240326095118.126696-1-mic@digikod.net>
References: <20240326095118.126696-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Previously, if a thread creation failed (e.g. -ENOMEM), the function was
called (kunit_catch_run_case or kunit_catch_run_case_cleanup) without
marking the test as failed.  Instead, fill try_result with the error
code returned by kthread_run(), which will mark the test as failed and
print "internal error occurred...".

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240326095118.126696-2-mic@digikod.net
---

Changes since v2:
* Add Rae's and David's Reviewed-by.

Changes since v1:
* Add Kees's Reviewed-by.
---
 lib/kunit/try-catch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index f7825991d576..a5cb2ef70a25 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -69,6 +69,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 				  try_catch,
 				  "kunit_try_catch_thread");
 	if (IS_ERR(task_struct)) {
+		try_catch->try_result = PTR_ERR(task_struct);
 		try_catch->catch(try_catch->context);
 		return;
 	}
-- 
2.44.0


