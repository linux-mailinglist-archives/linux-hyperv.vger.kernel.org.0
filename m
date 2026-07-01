Return-Path: <linux-hyperv+bounces-11787-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7Z7DFOR0RWpkAgsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11787-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:13:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FD96F1588
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 22:13:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="iFHG2W/f";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11787-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11787-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44F51307F1FF
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 20:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4612417D1;
	Wed,  1 Jul 2026 20:03:21 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A37431E6A;
	Wed,  1 Jul 2026 20:03:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936200; cv=none; b=USSJBHcxXeB8fSd+UYW4lkYAKmV6lmEcfXhfm50M4bEhC8kvY1lUJILVbomoIEff4uwz8N2R5e+r0Gn/1bQU0ChR5OtQzoghqCBbs6s4SVeBNEKbeZDBlBvsnWeetEVdISgyt2vYc/oRu7H/4Tz5yx9hi7s/q7Vqrx6PnrIV6LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936200; c=relaxed/simple;
	bh=Tz8cKxTQeiAYB4n232us/322HReF4v78djaSm6UhgiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n0my80NqqxZpaAq8k7+ZxCP9Hi5kwL9Z0Tb26Vrl6g9+bc3v+/pXmp/GrlB7Ers9uVsWZ18uf500gU//ccL6BQtpZc5xxrnTPG50lwQCHNDWm1/z97xiJkJFKG7vH1T7uDm3pIuefvcMrPQ3caG7HhDeJREBP/LQ47A/jOVguxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFHG2W/f; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83061F000E9;
	Wed,  1 Jul 2026 20:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782936199;
	bh=Tz8cKxTQeiAYB4n232us/322HReF4v78djaSm6UhgiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iFHG2W/fvrPVXqYjSJyJ9vuQbRvCjZ1P3GlWLDo5GSUlJyCm1gS20Q3D8BaZgV/nt
	 mxLkQsAFbXrMsaHjcJqhFPJkVR6B8Ypg0yXWSU2Jdv7TlI/Udl8d+izul2jSmdl29H
	 FSAO2iJtTrd9ydb1py7yIcfgtx8vi13iCeNobMWqBmVpAI/7yVJvJSR2jzR7JGJnoi
	 CQVRDVFf5NbuWdMdfQMdL65+Z6K1aJd3rAzg0e1Vw9/VUERiu/WzJ/WmvxJ+I/V5dY
	 HjxdGDipmMhujOj/m1DVhBcz02b6hQWwOpqEg93GTBhDvq/CswAfTXOoQhoxgxD97G
	 DX61/XN7PxLXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 29/51] x86/kvm: Don't disable kvmclock on BSP in
 syscore_suspend()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260701193212.749551-30-seanjc@google.com>
References: <20260701193212.749551-1-seanjc@google.com>
 <20260701193212.749551-30-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 20:03:18 +0000
Message-Id: <20260701200318.B83061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11787-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:kvm@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0FD96F1588

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch inadvertently leaves the BSP's kvmclock enabled when pow=
ering off the machine for ACPI S4 hibernation, leading to potential memory =
corruption when the VM awakens.

Pre-existing issues:
- [Critical] Stack-allocated waitqueue head use-after-free in async page fa=
ult handling.
--

Note: The standard inline diff format has been altered to a free-form
summary due to patch recitation restrictions.

commit 03858970f2d7a88b91bdd5b16c1573166126d3c4
Author: Sean Christopherson <seanjc@google.com>
Subject: x86/kvm: Don't disable kvmclock on BSP in syscore_suspend()

This patch modifies the guest suspend logic so that kvmclock is not disabled
on the BSP during syscore_suspend(), relying instead on the sched_clock
restore callback.

[Severity: High]
Does this change inadvertently leave the BSP's kvmclock enabled when
powering off the machine for ACPI S4 hibernation?

Looking at the final S4 power-off path in hibernation_platform_enter() in
kernel/power/hibernate.c, it calls syscore_suspend() but does not call
save_processor_state(). Because this patch removes the unconditional BSP
kvmclock_disable() from syscore_suspend() and relies on
kvm_save_sched_clock_state() (which only fires during image creation),
kvmclock appears to remain fully enabled during the S4 power-off.

Could this lead to memory corruption when the VM awakens, since the
hypervisor might continue writing to the old kvmclock address?

[Severity: Critical]
This isn't a bug introduced by this patch, but is there a use-after-free
risk with the stack-allocated waitqueue head in the async page fault
handling in arch/x86/kernel/kvm.c?

When a guest task waits for an async page fault in
kvm_async_pf_task_wait_schedule(), it waits on a stack-allocated struct
kvm_task_sleep_node. Concurrently, when a waker CPU executes
apf_task_wake_one(), it unhashes the node via hlist_del_init().

The waiter checks hlist_unhashed() locklessly. If it observes the unhashed
state before the waker is finished, the waiter can break its loop, return,
and destroy the stack frame. The waker might then dereference the
deallocated waitqueue head to call swake_up_one(), potentially corrupting
stack memory.

Can this sequence occur during concurrent page fault completions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701193212.7495=
51-1-seanjc@google.com?part=3D29

