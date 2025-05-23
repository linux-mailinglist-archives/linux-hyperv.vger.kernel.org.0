Return-Path: <linux-hyperv+bounces-5626-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE951AC1845
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 01:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17578178654
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 May 2025 23:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F722D1F73;
	Thu, 22 May 2025 23:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FO48EHXM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A62E2D1F52
	for <linux-hyperv@vger.kernel.org>; Thu, 22 May 2025 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957960; cv=none; b=VcOMfaR0Zkbf1SDUmyGAV0j1eW1GWwFEfpzrOuAOvvOZuxVm89Am8fgExHvhRoFW/gTCB3cb+dKcd9BfnrX1+dMLVhnWij4aV7OyjIJwXp8+QfykrRaMrOJFbfTuMW9nvYOJbsfPQTOKFR/Eis8pjoXIa8JbV4WyHS1TbPZT9bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957960; c=relaxed/simple;
	bh=FDCJRuUBom6tgSithRuLUJxsTxJG1RjcxbgGSLyCb6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mpTAW4wdXJmlmV1lYXSPNm3P3+eQSY7OExfvBEAn6F2uv/sW1YI6fv7xEFgBdmS8N7c16PMooO2FiFC+8bgptTKpPaRBaFvah0wjdMJ3CY70T06Fs2Mfi7fZIOdDrpWAg1DH7zHL4GVrixxOb2A5Le8d4pnraOorJTPcoJawT5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FO48EHXM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30ed6bd1b4cso7380218a91.0
        for <linux-hyperv@vger.kernel.org>; Thu, 22 May 2025 16:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747957958; x=1748562758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tVNl4A6Kx8naMJGZ1E0eQITkQbAsVFllM1f24lX+kzQ=;
        b=FO48EHXM3g4ZCLKZEK3LbIF73cPjmm7e7Liu+jQ4qHBcU9RASxWUpo24FrXLalqjZo
         zNrmjloD79YSVN/3ylTp49dIRs+LCFLNOr2ctT0sR8xG6WC0EHRQE6QrV1yLul/NyJha
         3DeoBzeUuezIpkgWc/kCAZMEt6p7C1Hfxg+Om1l7uw+CrpTU+WWizv/SKvJsgXwutFsr
         58w7q7qULVR90RZFRLcKzqul4S8Rli0v4wUTm75SfNUqhKgISaRsaXGG+v8K3SD/MBbQ
         nWH48Pk5iOLXz3t13TqeOXhdd6NCgYNciT2daZq7gOjci9JB+lcAlpuHknarcHQLguu4
         wNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747957958; x=1748562758;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVNl4A6Kx8naMJGZ1E0eQITkQbAsVFllM1f24lX+kzQ=;
        b=ENogvdEoQCf5hzIbq+nIwH+vjwVfrHgpmpz1Swl0wQnzE/A0uD32FFPbuJq7Vz7azN
         B7WD062wzMcnyLOrj0Q5oULY441fyKZt9FoVRKgBWW4hyCgiGgkDNuzdzPHwCHogk/tL
         +f8kMRvOevyNWmhyZBzVn/h5ybeYNBwjaNLZJ0QXOAnx3mYZ0ZvT1I4bOJJMkoz4skgA
         OuoMQhK3kAh0PSQMcNsBuHYk9/YRzbdeZSgZBKvQOcyjjWGWNBYtmi2SCQwFj1HUpEZv
         rVlXRgRqusRSJnOCopBpDov1YDZzD78RufuLqzkUyVQkbu8w1Esw+a8gmOjPNwaaSoEE
         u81w==
X-Forwarded-Encrypted: i=1; AJvYcCXqBIfy8JT9TQ9xrqxrF4no7zbMENkfFKei0tVBUkHa8PwS6lnH6tqHjYbE43UuNT5ajTr6OSQuNhGZya4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ9bUBBe0gPCwmo2rvKIDi5d2ndDr0wbHGbTuhws/YPIXgHG0Z
	eOGTo3JnRFUf7DvFMWbmS7qKSiZVETQB3UXrAN6SSNRzFY3fqttG49O6HUMSye83QS+j/5MFGP8
	Jfbx6GQ==
X-Google-Smtp-Source: AGHT+IE81WM2WL+8EnB/6FCP5IRyDnOFUDXq+HJraLf558ghdMXYLyDo9m5RHDzKNMgflX319IgqoMhIQGU=
X-Received: from pjg13.prod.google.com ([2002:a17:90b:3f4d:b0:2ee:4a90:3d06])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e70f:b0:30a:2173:9f0b
 with SMTP id 98e67ed59e1d1-30e8322596bmr38028577a91.28.1747957957818; Thu, 22
 May 2025 16:52:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 16:52:12 -0700
In-Reply-To: <20250522235223.3178519-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522235223.3178519-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522235223.3178519-3-seanjc@google.com>
Subject: [PATCH v3 02/13] KVM: Acquire SCRU lock outside of irqfds.lock during assignment
From: Sean Christopherson <seanjc@google.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, K Prateek Nayak <kprateek.nayak@amd.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Acquire SRCU outside of irqfds.lock so that the locking is symmetrical,
and add a comment explaining why on earth KVM holds SRCU for so long.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/eventfd.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 39e42b19d9f7..42c02c35e542 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -401,6 +401,18 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	 */
 	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
 
+	/*
+	 * Set the irqfd routing and add it to KVM's list before registering
+	 * the irqfd with the eventfd, so that the routing information is valid
+	 * and stays valid, e.g. if there are GSI routing changes, prior to
+	 * making the irqfd visible, i.e. before it might be signaled.
+	 *
+	 * Note, holding SRCU ensures a stable read of routing information, and
+	 * also prevents irqfd_shutdown() from freeing the irqfd before it's
+	 * fully initialized.
+	 */
+	idx = srcu_read_lock(&kvm->irq_srcu);
+
 	spin_lock_irq(&kvm->irqfds.lock);
 
 	ret = 0;
@@ -409,11 +421,9 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 			continue;
 		/* This fd is used for another irq already. */
 		ret = -EBUSY;
-		spin_unlock_irq(&kvm->irqfds.lock);
-		goto fail;
+		goto fail_duplicate;
 	}
 
-	idx = srcu_read_lock(&kvm->irq_srcu);
 	irqfd_update(kvm, irqfd);
 
 	list_add_tail(&irqfd->list, &kvm->irqfds.items);
@@ -449,6 +459,9 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	srcu_read_unlock(&kvm->irq_srcu, idx);
 	return 0;
 
+fail_duplicate:
+	spin_unlock_irq(&kvm->irqfds.lock);
+	srcu_read_unlock(&kvm->irq_srcu, idx);
 fail:
 	if (irqfd->resampler)
 		irqfd_resampler_shutdown(irqfd);
-- 
2.49.0.1151.ga128411c76-goog


