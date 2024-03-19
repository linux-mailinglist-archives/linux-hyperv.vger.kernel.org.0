Return-Path: <linux-hyperv+bounces-1790-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ECA87FC5D
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Mar 2024 11:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684981F23032
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Mar 2024 10:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC797BAFB;
	Tue, 19 Mar 2024 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="dt6Wd9v9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6854A7E56F
	for <linux-hyperv@vger.kernel.org>; Tue, 19 Mar 2024 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845740; cv=none; b=CQc9H8IxeVhqvjHL0Q3YZHtNUD1bUz2mFePrX1NuWOU4aZTf0qLAiJsh3ZqL/RdG99sK+CBV4AnP5nJRokIhGPYB8VmM9aClkRpNiewUBiFob+GQhkdsuBqEnoxqgc7dzwfGGsYobtKuFM4WKp8rXH50QhXzA+68vY4fRKOG1mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845740; c=relaxed/simple;
	bh=b6/DRUF/Rej8WDS7Bj3R2nQv56pPXANLpZULDArZAX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ndg9JVX59egjiwtHZ3aoGqZGOCPlkihME5w/hbG3E2xB7Z82CS4j4T2ZMOn4HmMAiMVGM+ib3KeYk/8Qws6R5RU3iyAtAECih7IC5lIDrODUP3iMbD+GlKrN2hxuUOMDhjEqXN7B6Eo2XFvO2mvyZeBidWw9LFw/w16papOA/CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=dt6Wd9v9; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TzT4N1nM1zKyh;
	Tue, 19 Mar 2024 11:49:24 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TzT4M2rN3zMppDq;
	Tue, 19 Mar 2024 11:49:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1710845364;
	bh=b6/DRUF/Rej8WDS7Bj3R2nQv56pPXANLpZULDArZAX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dt6Wd9v9s7y2a0+SICu9bRRW5ZYPFD8oy+ZMCaCtsDYCSZ772nsFkAmsLbvW9vagO
	 +DYD6TNXy2wutdveoSRAxgdxsaIN64tLPy9SgQkojHLXaCU6C93LMlilcvWuZ8zKuk
	 fiHo+SHrG/SK0M1I8pU7gd8w30m8uUqDYk5YZ4CM=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
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
	Wanpeng Li <wanpengli@tencent.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>,
	kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v3 5/7] kunit: Fix KUNIT_SUCCESS() calls in iov_iter tests
Date: Tue, 19 Mar 2024 11:48:55 +0100
Message-ID: <20240319104857.70783-6-mic@digikod.net>
In-Reply-To: <20240319104857.70783-1-mic@digikod.net>
References: <20240319104857.70783-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Fix KUNIT_SUCCESS() calls to pass a test argument.

This is a no-op for now because this macro does nothing, but it will be
required for the next commit.

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240319104857.70783-6-mic@digikod.net
---

Changes since v2:
* Add David's Reviewed-by.

Changes since v1:
* Add Kees's Reviewed-by.
---
 lib/kunit_iov_iter.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 859b67c4d697..27e0c8ee71d8 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -139,7 +139,7 @@ static void __init iov_kunit_copy_to_kvec(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -194,7 +194,7 @@ static void __init iov_kunit_copy_from_kvec(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 struct bvec_test_range {
@@ -302,7 +302,7 @@ static void __init iov_kunit_copy_to_bvec(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -359,7 +359,7 @@ static void __init iov_kunit_copy_from_bvec(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 static void iov_kunit_destroy_xarray(void *data)
@@ -453,7 +453,7 @@ static void __init iov_kunit_copy_to_xarray(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -516,7 +516,7 @@ static void __init iov_kunit_copy_from_xarray(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -596,7 +596,7 @@ static void __init iov_kunit_extract_pages_kvec(struct kunit *test)
 stop:
 	KUNIT_EXPECT_EQ(test, size, 0);
 	KUNIT_EXPECT_EQ(test, iter.count, 0);
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -674,7 +674,7 @@ static void __init iov_kunit_extract_pages_bvec(struct kunit *test)
 stop:
 	KUNIT_EXPECT_EQ(test, size, 0);
 	KUNIT_EXPECT_EQ(test, iter.count, 0);
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -753,7 +753,7 @@ static void __init iov_kunit_extract_pages_xarray(struct kunit *test)
 	}
 
 stop:
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 static struct kunit_case __refdata iov_kunit_cases[] = {
-- 
2.44.0


