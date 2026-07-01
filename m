Return-Path: <linux-hyperv+bounces-11794-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dq9cHSN8RWrEAwsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11794-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:44:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DD66F18D5
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:44:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=VwfB1yqm;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11794-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11794-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE886300938E
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 20:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66DE3A71AD;
	Wed,  1 Jul 2026 20:43:07 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6B338332E
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 20:43:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938587; cv=none; b=WhuQ2+EXdIr9eqRMbP8K7mtrUhFDOufu0MtMQoaXRIpFhLeDowr1iu21X9OBErJzdj9Cu7mE56zRlKxMiWRQBgfSMRStT4SMGRwt43ZeiVhz/0dUUMi34gQraUODh+n03qOzzcxOLKAqcT0D22THZC8VaMJ4V/v9rS4zACCkm9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938587; c=relaxed/simple;
	bh=MJHAY/0lOZtESReKmEZbrT/tBa8Uv8X4qGxYXF2Xvm4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L+GO8RJCbOxoljm8Mp++2NAxqd0VHBBj05PGG5tz5vR1Ptglm6WPR57AnrDwHRmeSzggs7AlmQaO1+6E7w4ygCqoEoLX3yIA7OK/YqQfUjX3hfRkjEk6/+94ptuLGau+OnLlJBbDXqL5rb8h+EtxtBINhDltaAF2aqGC/DrW1Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VwfB1yqm; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c9b71388fbso22127385ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 13:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782938586; x=1783543386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul4KfkOuOrRVfcOqe8UUYQTjm8np2xMi7aWFEy9eSTw=;
        b=VwfB1yqm00QIqg/S42/9JTfGZe9/EKbHe+FtDGHxY23fc62s9CUL/emsZghT9XB2jY
         KKl/htZiejIevLAfnxG7JydFsJThnhvaGgQIJhpgnvfQ8U9qLIh8jG5r610gMiwL07GY
         iKJyMMgxZsPog4eKe+0ZcCH2lVw+kuR29/gFpCQpqFz6V59mkYoMnIIbC7gVQHC1427j
         pfc3z1nMgrXK0Fy6ryR6V2KhFU/t4upNUlUIilBEuJnHd7v8MB6kbD0Akka0tfj1HBsv
         LO8qCSxt1gr+p6YLcxmsrKJQ8BZk/m3E6aWM6j+HECBmqY5BYmGZFNGnGBwWuWyBoqJ8
         9OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938586; x=1783543386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul4KfkOuOrRVfcOqe8UUYQTjm8np2xMi7aWFEy9eSTw=;
        b=g6mMmpdD9pYySbpZ54pFC7pCuXhhDyoFIpN7WL89x7siKBDIXBv6ta78QBw7156pLq
         N8QiBnw+oCGP7gv48oFb+R+hy4DIdwkgr4Gq/NRJH+oe/TrWy9iYpFh7I/582ubKa+Gu
         mfYYvRPadaERcKCXkuD9U33zeMOIMfszCvH5SMwupSHPXrMjbwDfcH3X+NFBZJp1pOHa
         Kl++Vo3NKgGmVkye3l5zunw9OnZSE2wUd7aXNJPKw3iQ2jMyT0VUzdMflziy6I26C134
         VaIx+X/NLitsygWa8xidE9sMH5e0nPJT5N1+AbT1xb/IQNWHv3GeNL6V1CLln8c86tWp
         LVJg==
X-Forwarded-Encrypted: i=1; AHgh+RqL+KzKFkFk78DZ1U4RroXA5jggIUNzFZUM+r2fmlNFkBKSWDfveSX6sWZ8aKLKtxtvzo4nr2VIhsX1cac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53FySLqjBJyrhXqfYzd2WGiXcD/DsajgMo4e2Yj+xaGaxd3oO
	Z2NcLhVFuGc2xoozS084TgbFocCJ5M+WLS0+8bemDqF6NVdVPDlXpK7oefX1KQ27DD8RjIfqe3W
	O0tTa5A==
X-Received: from plbla16.prod.google.com ([2002:a17:902:fa10:b0:2bd:4b8c:fd31])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e785:b0:2c9:c16f:eda6
 with SMTP id d9443c01a7336-2ca7e8a899dmr38410135ad.39.1782938585487; Wed, 01
 Jul 2026 13:43:05 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:43:04 -0700
In-Reply-To: <20260701200318.B83061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com> <20260701193212.749551-30-seanjc@google.com>
 <20260701200318.B83061F000E9@smtp.kernel.org>
Message-ID: <akV72B0ORjG1rOch@google.com>
Subject: Re: [PATCH v5 29/51] x86/kvm: Don't disable kvmclock on BSP in syscore_suspend()
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11794-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71DD66F18D5

On Wed, Jul 01, 2026, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does this change inadvertently leave the BSP's kvmclock enabled when
> powering off the machine for ACPI S4 hibernation?
> 
> Looking at the final S4 power-off path in hibernation_platform_enter() in
> kernel/power/hibernate.c, it calls syscore_suspend() but does not call
> save_processor_state(). Because this patch removes the unconditional BSP
> kvmclock_disable() from syscore_suspend() and relies on
> kvm_save_sched_clock_state() (which only fires during image creation),
> kvmclock appears to remain fully enabled during the S4 power-off.

No?

  hibernate()
  |
  -> hibernation_snapshot()
  |  |
  |  -> create_image()
  |     |
  |     -> save_processor_state()
  |
  -> power_down()
     |
     -> hibernation_platform_enter()

I'm not familiar with the /dev/snapshot interface, but I gotta imagine userspace
needs to do SNAPSHOT_CREATE_IMAGE before SNAPSHOT_POWER_OFF if it actually wants
to restore state after S4.

> [Severity: Critical]
> This isn't a bug introduced by this patch, but is there a use-after-free
> risk with the stack-allocated waitqueue head in the async page fault
> handling in arch/x86/kernel/kvm.c?

And I thought I had a problem with scope creep during review...

> When a guest task waits for an async page fault in
> kvm_async_pf_task_wait_schedule(), it waits on a stack-allocated struct
> kvm_task_sleep_node. Concurrently, when a waker CPU executes
> apf_task_wake_one(), it unhashes the node via hlist_del_init().
> 
> The waiter checks hlist_unhashed() locklessly. If it observes the unhashed
> state before the waker is finished, the waiter can break its loop, return,
> and destroy the stack frame. The waker might then dereference the
> deallocated waitqueue head to call swake_up_one(), potentially corrupting
> stack memory.
> 
> Can this sequence occur during concurrent page fault completions?

No idea, definitely something to sort out at a different time.

