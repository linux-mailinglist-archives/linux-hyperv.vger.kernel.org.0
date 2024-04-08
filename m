Return-Path: <linux-hyperv+bounces-1927-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5556189B913
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Apr 2024 09:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26F91F210E0
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Apr 2024 07:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FDA3B19D;
	Mon,  8 Apr 2024 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="R0lW9IRV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D94528DBF
	for <linux-hyperv@vger.kernel.org>; Mon,  8 Apr 2024 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562424; cv=none; b=gEl8iRVJoTFFiyLuUa/8N5bDntbyIPpo28kmoFODf2s8NUECe+DaoKxwfDe97uqFaUoYUkIJ9J60Mxs1/rB3Hwf8Kj4bSnJbz+2pNbbnZOeMdLKBGEoGYmv/auFy7Wn7zriW7h0eQ24K6NNF7xhoR5XmZpr93b4ziVISmu+jxmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562424; c=relaxed/simple;
	bh=Yw7gXVy/DL5VfiZ97miPEyVcUDPjJaMAJFbpu/mcTYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nuoeislqNAXVfZV5v1bK+6Bz3n3CIpNrdXK+dy6FyCBT8r7X0qVh1xjt8VqH4NBhpdmFOejAaYb7EKEzhEIjsBLp0AN1DrAQVMttM4p1c9RN62dCVbadwB6lOPKA8M7b7zffrsrspbW1QcsSyjnwUk2PLg8pf8A8YgKiADE96Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=R0lW9IRV; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VCh4W5P57zKJH;
	Mon,  8 Apr 2024 09:46:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712562411;
	bh=Yw7gXVy/DL5VfiZ97miPEyVcUDPjJaMAJFbpu/mcTYE=;
	h=From:To:Cc:Subject:Date:From;
	b=R0lW9IRVvl6F/kPeybNuvjtYv0Teh9x++29SOplMcOGEWpreKFfNGb1GfENwY8zFC
	 JMNQaG4RhCByvaJuIJNhjJZHuZSDkl5xb7lOzgXF20FovjOxx7wh6SC9xzhzt1sSaN
	 wWC7mCG/ImOpzkRf23ynalfvoOww0LNTZ6fWhWtM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VCh4S5h81zSYJ;
	Mon,  8 Apr 2024 09:46:48 +0200 (CEST)
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
	kunit-dev@googlegroups.com,
	kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v4 RESEND 0/7] Handle faults in KUnit tests
Date: Mon,  8 Apr 2024 09:46:18 +0200
Message-ID: <20240408074625.65017-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

This patch series teaches KUnit to handle kthread faults as errors, and
it brings a few related fixes and improvements.

Shuah, everything should be OK now, could you please merge this series?

All these tests pass (on top of v6.8):
./tools/testing/kunit/kunit.py run --alltests
./tools/testing/kunit/kunit.py run --alltests --arch x86_64
./tools/testing/kunit/kunit.py run --alltests --arch arm64 \
  --cross_compile=aarch64-linux-gnu-

I also built and ran KUnit tests as a kernel module.

A new test case check NULL pointer dereference, which wasn't possible
before.

This is useful to test current kernel self-protection mechanisms or
future ones such as Heki: https://github.com/heki-linux

Previous versions:
v3: https://lore.kernel.org/r/20240319104857.70783-1-mic@digikod.net
v2: https://lore.kernel.org/r/20240301194037.532117-1-mic@digikod.net
v1: https://lore.kernel.org/r/20240229170409.365386-1-mic@digikod.net

Regards,

Mickaël Salaün (7):
  kunit: Handle thread creation error
  kunit: Fix kthread reference
  kunit: Fix timeout message
  kunit: Handle test faults
  kunit: Fix KUNIT_SUCCESS() calls in iov_iter tests
  kunit: Print last test location on fault
  kunit: Add tests for fault

 include/kunit/test.h      | 24 ++++++++++++++++++---
 include/kunit/try-catch.h |  3 ---
 kernel/kthread.c          |  1 +
 lib/kunit/kunit-test.c    | 45 ++++++++++++++++++++++++++++++++++++++-
 lib/kunit/try-catch.c     | 38 ++++++++++++++++++++++-----------
 lib/kunit_iov_iter.c      | 18 ++++++++--------
 6 files changed, 101 insertions(+), 28 deletions(-)


base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.44.0


