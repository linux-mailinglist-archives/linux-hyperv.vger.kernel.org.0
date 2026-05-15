Return-Path: <linux-hyperv+bounces-10972-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIKMFUl6B2pL4QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10972-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:55:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC0155728C
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64F4C3001CEC
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA5B36F8F9;
	Fri, 15 May 2026 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dqdyydw+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3F135E1DD
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874950; cv=none; b=lJowF/qdCowDRnuAUT9M6HWAGkawKJlVvDfBaENbWAlhcKGl2fXFgPAF6i28WbwwINm9eiYk/N0H5z6gfXE1V3PRWPME65XLNuv2lciJjmrIHDO9aHTWHkERtNWaT++GT0FqgPoY0kasqvEok8I09S+kJvhk08qZ5F0qlSFP8Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874950; c=relaxed/simple;
	bh=sBx9rMVz5IEWScB5CRoCk46xfqJcHRsvD0GfZd9K3xs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SyKWr7nspiMj2vF+nBYF6BuXLPF0axB3PXdOS10Da0+uK+mYNq/bTPTXfKbiTBegg++gonfdjhxHXkd/B+l54nTJ8LMLXXVHkw94DFDLQx2KJrNqXyKryn5crBvH1KQdqxGhq7An+HQuxWMtu2GYbrHZs6dTtM4OcqNWtp/ysVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dqdyydw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE29DC2BCB0;
	Fri, 15 May 2026 19:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778874950;
	bh=sBx9rMVz5IEWScB5CRoCk46xfqJcHRsvD0GfZd9K3xs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Dqdyydw+hgQ6h/lOKJinh1JCm2sp3fViaOAKk2f9KjK3ertszsYDQGjZLQI67kz36
	 2t+wKVRiLl35vo9G7uGedsoDZGc8j5AJ38VAyie3kDC+rs7iXtbsIMAq4dfQN8wmZj
	 MI/L2xAEuIHqSA1GifjmVvyI3g18HBG+NGiiPZohgDemKw0RUAI1lIWHdHuMVUymru
	 YJITYL7KGP78TnygAA73raYFCICTyBWvem12Jh5m2oNWKDUIGLArCcbMft7LuvJbqf
	 7oovSD/GWH9c9r10s+asLf4qiMTYcaANM57YIeDp6OmuXyJ83mpwrgkS0XKdwYHiRA
	 X4Lu5bNAZoqMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/41] x86/tsc: WARN if TSC sched_clock save/restore
 used with PV sched_clock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260515191942.1892718-18-seanjc@google.com>
References: <20260515191942.1892718-18-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 19:55:49 +0000
Message-Id: <20260515195549.EE29DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: AAC0155728C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10972-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Setting `x86_platform.save_sched_clock_state` and `restore_sch=
ed_clock_state` to NULL for PV clocksources causes a fatal kernel panic on =
S3/S4 suspend and resume.
--

commit 4d4877d2e739eb2258c919e41775916ae05af732
Author: Sean Christopherson <seanjc@google.com>

x86/tsc: WARN if TSC sched_clock save/restore used with PV sched_clock

This commit adds a warning to guard against regressions when the default
TSC sched_clock save and restore hooks are called while using a PV
sched_clock.

> Now that all PV clocksources override the sched_clock save/restore hooks
> when overriding sched_clock, WARN if the "default" TSC hooks are invoked
> when using a PV sched_clock, e.g. to guard against regressions.

Earlier patches in this series appear to override these hooks by setting th=
em
to NULL, such as setting x86_platform.save_sched_clock_state =3D NULL. Could
this lead to a panic during suspend and resume?

Looking at the callers in arch/x86/power/cpu.c, save_processor_state() and
restore_processor_state() unconditionally invoke these function pointers
without checking for NULL:

void save_processor_state(void)
{
        __save_processor_state(&saved_context);
        x86_platform.save_sched_clock_state();
}

When VMware or Xen HVM guests attempt to suspend or hibernate, won't the
kernel execute the NULL pointer and crash?

Would it be better for PV clocksources to override the hooks to a safe no-op
function like x86_init_noop rather than NULL, or for the callers in
power/cpu.c to explicitly check for NULL before invocation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515191942.1892=
718-1-seanjc@google.com?part=3D17

