Return-Path: <linux-hyperv+bounces-4102-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2DFA4726A
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DF33B4BC0
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A94D215053;
	Thu, 27 Feb 2025 02:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u0Xr9RMN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B01F78F3
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622775; cv=none; b=TnYr7mqkFPk2Mtw6xus5Wanq0kot8wORlJmMgH+azF4nrOCNUxM86nuFkqok1df2lq9GBT1eDUn/BNDw1LnjbQkbvKlCwyKKUv6X3j5TTQ2QuxxXy3tA8WajJQdVhwUnr5MvC8PnzXwm59OjFJglKPP27pvBl5j4fskOP5Js64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622775; c=relaxed/simple;
	bh=P0O5mmkSnDe0SpsR7bTvnzJu0+xYte77F3QT24wbpm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C7JnJARFt6qq57BN5Wb4m0qJDeYogJeoJpWpzQ9e4+/FLUqy+GV2NPhyDo4Fb0XqtV9ewmngVDH7K7tniS8ZMQne1B3AdOcQk5yGuf1Iu8hzR6FBX0kskZ1Z6SAcUZZOisnPM5rQusZxqpzKuUtqjPPkMH8QMQMOsy8LdYzlB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u0Xr9RMN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22349ce68a9so12413645ad.0
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622773; x=1741227573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iUPGjlm6EABKAwlimnT9Yj0uy9Y0kc3vikfZk6zMyUM=;
        b=u0Xr9RMNsxVJE42Vyec4L7wv5hwQgKsHPCI3qt4/2eAdpgqeuhscM35oaMtq/TN3P2
         0OL5Txkr+v59vkD/mQGlG90xMPNHr40hnGkbTwftTkLVtbOsVSgmfMBTB2/okKnbuO6U
         I08xs79VLD3mMj0ZX2U1dFjUshA+JEDeSWuZjbvha2ZGCyzE1VmYZVwWkUxNTfFlmEwW
         +CXuxQD+e14M/diL8RKMkb93imPLoOwAJz/t5B8BqysLfCdpBRmyYfe8JsKHa2ayQ0NZ
         oCSyKNzdol48LlKRhGIhJrUhnIssbmQX/do7B4kVJDZqguvFRCbsK1mAWt8mim4PFa3z
         P1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622773; x=1741227573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUPGjlm6EABKAwlimnT9Yj0uy9Y0kc3vikfZk6zMyUM=;
        b=XPoaZ0mUxjW0Uqun99yioUsyAyliMSu5nl4nGxm8k29rbGNVucrQPjqAxp97RD05KU
         a0vkx7LfIvO0kA3AoBCbVYTR+UdLRh+7j6VBynig17IUk/05p7rQrVmGyJpYmAB4hzuQ
         eeyA7Sr5GeWU/x4ElSyDGBRcJjYD3fo0ZzHiW1kJByOcqnQKrlXQIybsAmF7wRS3AktU
         wE7kMFROKtIvTdLp9E0YvBbT2ShIbl3fFfbum4U7aV4/Yk2G2U6VMoFbR8JgohhHyMtA
         TP4khHOw6+Ru1OihyOXS77JqjrvSwwGOrOCB2I2robUJO/cgonU4Rz7eWmm4oob/uIjj
         i+dw==
X-Forwarded-Encrypted: i=1; AJvYcCW2Hn6o6Rz0vjee9QDJDvy4qhnNFKEjEHpkMPWqouYICMszKkj0iOgYM9P/7aJdbDKz+0hNRhZ9z673RnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwweOjpeM57cpApX+Kv27mEWdQZUhXzEgfoSXHThtP3sFJgGfWh
	dxKo01V8WKx6MjsGwY+nua1+FsbKcav3am9T47J+JqJ7AcVpAGarUm5WIP1k9aQF52WAZ+d/i/9
	qrA==
X-Google-Smtp-Source: AGHT+IESbVD77xvo7C+ciGzHtrGqGL0Rj+DzLIK2/TaODo5QawXajXsWSJTUc7OSugj7U0H5GgKBaGLNEhI=
X-Received: from pfld12.prod.google.com ([2002:a05:6a00:198c:b0:732:7e28:8f7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1813:b0:732:6221:7180
 with SMTP id d2e1a72fcca58-73426c943c4mr38161657b3a.5.1740622772828; Wed, 26
 Feb 2025 18:19:32 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:33 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-18-seanjc@google.com>
Subject: [PATCH v2 17/38] x86/tsc: WARN if TSC sched_clock save/restore used
 with PV sched_clock
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

Now that all PV clocksources override the sched_clock save/restore hooks
when overriding sched_clock, WARN if the "default" TSC hooks are invoked
when using a PV sched_clock, e.g. to guard against regressions.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 472d6c71d3a5..5501d76243c8 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -990,7 +990,7 @@ static unsigned long long cyc2ns_suspend;
 
 void tsc_save_sched_clock_state(void)
 {
-	if (!sched_clock_stable())
+	if (!sched_clock_stable() || WARN_ON_ONCE(!using_native_sched_clock()))
 		return;
 
 	cyc2ns_suspend = sched_clock();
@@ -1010,7 +1010,7 @@ void tsc_restore_sched_clock_state(void)
 	unsigned long flags;
 	int cpu;
 
-	if (!sched_clock_stable())
+	if (!sched_clock_stable() || WARN_ON_ONCE(!using_native_sched_clock()))
 		return;
 
 	local_irq_save(flags);
-- 
2.48.1.711.g2feabab25a-goog


