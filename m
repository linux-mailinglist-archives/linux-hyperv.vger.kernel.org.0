Return-Path: <linux-hyperv+bounces-5631-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8B5AC1885
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 01:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4346DA418EF
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 May 2025 23:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00D02D4B78;
	Thu, 22 May 2025 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzNquj/f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB792D3A78
	for <linux-hyperv@vger.kernel.org>; Thu, 22 May 2025 23:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957968; cv=none; b=ZO7la7EK5Iwt5aysOd7J4C6gSpUtjvUB+XoSuJ6Up/xfcZ8zdEnH2hQQ8pzphtTofpllmgkgkF07/hgRRX4TL5O5ssENcjLlE1YhwWitil33jRTqZq8Z5+hWmS7NEuZYB5tpqaEy7Es3zEJNDAehNxkWzQl/t6Fu6WHbKe2kxQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957968; c=relaxed/simple;
	bh=Xjq+huymn2c342iWWiY1CbwR9+2osfFq6dqedGxHGtA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tfNJU3vilE0z4CRYNA63vDGPzsYKUrXWh+EtoKTxTuuwx/AC88sp5WUvaQEHy0sOXpyHnlWo7n1tkLGyWL56kR216CB/hA0lNdBmABliOS215EMydOmU5YHe5OIu2ntyLLOZOffF31n3PKL7eIyAumP5W7k4LVal11JKOfbup1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fzNquj/f; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-745e89b0c32so1323984b3a.3
        for <linux-hyperv@vger.kernel.org>; Thu, 22 May 2025 16:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747957966; x=1748562766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rhj01gCo8zRE4ihm7mjL7ntGfsdvBwkWydK82rp0ihs=;
        b=fzNquj/fhOTTgsHJHG8cKybKfCiPTn7g38z+zY2tFCRYgAnLXKxC3j0IqhrLfRNYuE
         WBZpV22YWTqqJ56zJ3nRI+JPNEtoT8c9aXTnj3PCgfXtveLCp4S/0EEUK05VLme5esFS
         eofAWTXdlInU2TSjQ1iW/1mCxbhJUM/TIL+ekZ05tcW6TiSiUlUO9wxAHxRFckfg1X8X
         UbKU50xYHUAK3kumKuyKAcdkrB+4uoAXC1dkEcMrKYV+yuBTcm37ZsjJK1h0MBfg7zDc
         3wPVB9cuabrogf0dvueAJEvwOevRneC2LSi2rrRa57GuEETcuxxUT5HzW/HUqW8gIYjz
         ZYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747957966; x=1748562766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhj01gCo8zRE4ihm7mjL7ntGfsdvBwkWydK82rp0ihs=;
        b=tI5CdOlXHGqonuJ1NL9p+YbFR+l9ETHohtodt8LLFMQPQOXCaQZUWJWG4+SJrMmi4T
         VEwQl4hdBPtl4N4fL5klmEcPby7ZAoX2ZUmneHP5y7Vaeinld+TZu8j3cZIcOvcJoTHh
         u9oKpkQXHa2n7sybxv02owB+PTEopUeEvaxm/6TK1bdqFA4c2oSHEYf06UF9U2FATcod
         F94lguzYRQlOlIQeDvAWE5SozpNcKAhIhzXelnV1A2QW5lvG7oW3i6d+3H8SdQOOSSS+
         krCaZKXXHexx3RPG87FMFLnsCZ/NjTpFK6vAOb+smv8+uRhrCUAQnjFfv8eg+Jl0iqyR
         Espg==
X-Forwarded-Encrypted: i=1; AJvYcCWca4lNwxfzdyMA7uv0XdC2pQ5YNKrwW/BZCo8e7p0uJSDLLfTYnkmmfqp5Vs24fn9dm5D59NGsS7+Q4xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZZh2VcPRveAiCJX12Zacq93HOGRZzd1L8svfcIGWegt2Wf8c
	HRx4XgCCwyhpYHa0GY8A20HZmQ01PKVib8uEEMM5srzKNt9s+IMyDP3KVixhM79jPQlemTyZJrD
	4B4sdMQ==
X-Google-Smtp-Source: AGHT+IFcXQOzVhyYyYRvvhxCpwMSPB5FWKzf2e+esBNAhvIROXYgtUD8Jyc4OswUVSapVQEWgVgXYmNxl9c=
X-Received: from pfbhd3.prod.google.com ([2002:a05:6a00:6583:b0:742:a60b:3336])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8594:b0:740:9a42:a356
 with SMTP id d2e1a72fcca58-742acce36c5mr31613679b3a.11.1747957966116; Thu, 22
 May 2025 16:52:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 16:52:17 -0700
In-Reply-To: <20250522235223.3178519-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522235223.3178519-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522235223.3178519-8-seanjc@google.com>
Subject: [PATCH v3 07/13] xen: privcmd: Don't mark eventfd waiter as EXCLUSIVE
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

Don't set WQ_FLAG_EXCLUSIVE when adding an irqfd to a wait queue, as
irqfd_wakeup() unconditionally returns '0', i.e. doesn't actually operate
in exclusive mode.

Note, the use of WQ_FLAG_PRIORITY is also dubious, but that's a problem
for another day.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/xen/privcmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index c08ec8a7d27c..13a10f3294a8 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -957,7 +957,6 @@ irqfd_poll_func(struct file *file, wait_queue_head_t *wqh, poll_table *pt)
 	struct privcmd_kernel_irqfd *kirqfd =
 		container_of(pt, struct privcmd_kernel_irqfd, pt);
 
-	kirqfd->wait.flags |= WQ_FLAG_EXCLUSIVE;
 	add_wait_queue_priority(wqh, &kirqfd->wait);
 }
 
-- 
2.49.0.1151.ga128411c76-goog


