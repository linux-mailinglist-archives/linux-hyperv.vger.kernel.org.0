Return-Path: <linux-hyperv+bounces-1650-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A35E86E9DB
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 20:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C061F2599C
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 19:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D313FB01;
	Fri,  1 Mar 2024 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="VDYJfzHt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D393E494
	for <linux-hyperv@vger.kernel.org>; Fri,  1 Mar 2024 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709322068; cv=none; b=lfJQpvB1R4wXmTt///c1+t2Lwu0O7Hfc4nWfo8xGziQWiJpaoActN5ZjmHtwOw31bpt8V8x1UbfB3tN4CZ1pp+I3AxRp4wRfkS5py6ln0Bo+cdHBzZzXE+uhWDK8LXjf6nQhxdQWRCrVMmvP5LwtvvlFkpcq3MZ3RJZOj1VQJBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709322068; c=relaxed/simple;
	bh=Zn01zuCUL7jYKmhPGGsYWvoLxWhB+s/jq3mkvb6/ZEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBcIebNKwf+2/bzzS5bUnHIWlOWaVrUwosQKd5zfl562A8afFWdlOeqhb0rgg4HNglBX8ruAXsIa1IjnhYIL5zIzWR5g9p9gDh1XqBXxnMClsMGHrcuw1zMAXNN6j3m70x6XigTc36WAIgxN6ivL0BpEo4rb9vGsRT8ovqtfo9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=VDYJfzHt; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tmdk22LWYzMwZVM;
	Fri,  1 Mar 2024 20:40:58 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tmdk14tbDzqC6;
	Fri,  1 Mar 2024 20:40:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709322058;
	bh=Zn01zuCUL7jYKmhPGGsYWvoLxWhB+s/jq3mkvb6/ZEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VDYJfzHt2LaPKgpmTPQ8FfoDl4fZMp4bz5zmD1Ri9Q3wHIaKCyhdS3F46fzxcVwa/
	 mMQvT6uOyUAH/LEQv1+pkW/jjuA8iG8X5UpGLmdao8jrTNR1jjxdSGOet/fXklrBrF
	 k7nDQJ6iJ7kAszmD1OsNH4oWIl2mNaVVGrUWGqaU=
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
Subject: [PATCH v2 7/7] kunit: Add tests for fault
Date: Fri,  1 Mar 2024 20:40:37 +0100
Message-ID: <20240301194037.532117-8-mic@digikod.net>
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

Add a test case to check NULL pointer dereference and make sure it would
result as a failed test.

The full kunit_fault test suite is marked as skipped when run on UML
because it would result to a kernel panic.

Tested with:
./tools/testing/kunit/kunit.py run --arch x86_64 kunit_fault
./tools/testing/kunit/kunit.py run --arch arm64 \
  --cross_compile=aarch64-linux-gnu- kunit_fault

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240301194037.532117-8-mic@digikod.net
---

Changes since v1:
* Removed the rodata and const test cases for now.
* Replace CONFIG_X86 check with !CONFIG_UML, and remove the "_x86"
  references.
---
 lib/kunit/kunit-test.c | 45 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index f7980ef236a3..0fdca5fffaec 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -109,6 +109,48 @@ static struct kunit_suite kunit_try_catch_test_suite = {
 	.test_cases = kunit_try_catch_test_cases,
 };
 
+#ifndef CONFIG_UML
+
+static void kunit_test_null_dereference(void *data)
+{
+	struct kunit *test = data;
+	int *null = NULL;
+
+	*null = 0;
+
+	KUNIT_FAIL(test, "This line should never be reached\n");
+}
+
+static void kunit_test_fault_null_dereference(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_test_null_dereference,
+			     kunit_test_catch);
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_EQ(test, try_catch->try_result, -EINTR);
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+#endif /* !CONFIG_UML */
+
+static struct kunit_case kunit_fault_test_cases[] = {
+#ifndef CONFIG_UML
+	KUNIT_CASE(kunit_test_fault_null_dereference),
+#endif /* !CONFIG_UML */
+	{}
+};
+
+static struct kunit_suite kunit_fault_test_suite = {
+	.name = "kunit_fault",
+	.init = kunit_try_catch_test_init,
+	.test_cases = kunit_fault_test_cases,
+};
+
 /*
  * Context for testing test managed resources
  * is_resource_initialized is used to test arbitrary resources
@@ -826,6 +868,7 @@ static struct kunit_suite kunit_current_test_suite = {
 
 kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
 		  &kunit_log_test_suite, &kunit_status_test_suite,
-		  &kunit_current_test_suite, &kunit_device_test_suite);
+		  &kunit_current_test_suite, &kunit_device_test_suite,
+		  &kunit_fault_test_suite);
 
 MODULE_LICENSE("GPL v2");
-- 
2.44.0


