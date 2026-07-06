Return-Path: <linux-hyperv+bounces-11841-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2Q/jCRjzS2pKdgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11841-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Jul 2026 20:25:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 236127147A3
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Jul 2026 20:25:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LOBiwStq;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11841-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11841-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AB343000B87
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jul 2026 18:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470813B27F3;
	Mon,  6 Jul 2026 18:16:13 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228963B1035
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Jul 2026 18:16:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361773; cv=none; b=caHmbH1n4XFF+QgHabjSIAudb/WyFO1qBo9M5ytMqpG94UNiBXGVwH8rciDE2GE5IrSWYNYe0hPpP5ULPmkuvmnkrQuaEwf6imEiFaUJ5wb76Y1C2mEdO6TSk5/Qahtw0DkTEgWviJx4riZDbq0Z0lJjgEzgksXpyo+zFw2JuRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361773; c=relaxed/simple;
	bh=f57K3IvHsfR+pF2lEEomyaOmmZffYzLzsmfoeMRhfy8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HKya9OGPIynwea8cuUDgn09shCeH+1QO55U+FYgAW2YlEUuTzRWWS39AALmwTr3EUFiB9adFqzJOwixrOIp32XDXoZgozbJUe8gSfWKWfoXfij8eeaDeH/t8S0sOgvciwJ/zzDzPuxCEzBV6W2pHXA8WMpKa0nVGt8/c3mPOp7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOBiwStq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830E31F000E9;
	Mon,  6 Jul 2026 18:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783361771;
	bh=kcqbawFMjk5sFdQKrGa/9pJWGHzYjBlFdPRE/d7crgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LOBiwStqqkgMP6NV6IFDNLzhQKsXnjxckUYedi185UdAU0CyMCKvAg4CuZuH+NZOC
	 8D2hAfDWFYij4PMIv/hd+xCmSugXI2fAoYLyp8Jw/6Besnjmc8OLXFXHEehkRdahK0
	 IDQGxB2zixESuy0V/PDI7r744hdRNxuSpB8QlJMnT2rWrymsKEy96J8jNXzxRDPBx8
	 wXB91kxxjoP90pdhbEGSewstdrvVAD3XqeaFtCaGPq4TjIThLB7AX6uXIK+CJeaejb
	 tTaeMkhIWrYgElr6nAQ3SiWt1zVCdXeGEpuKU8Q5CQ29SCqEnaW7gI6YaW8IqzpeC2
	 PLAjxVjxoVhUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] mm/hmm: add hmm_range_fault_unlocked() for mmap
 lock-drop support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <178336050736.504354.6052508493877924780.stgit@skinsburskii>
References: <178336023903.504354.7500950448226027718.stgit@skinsburskii>
 <178336050736.504354.6052508493877924780.stgit@skinsburskii>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 18:16:11 +0000
Message-Id: <20260706181611.830E31F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11841-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skinsburskii@gmail.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 236127147A3

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] `hmm_range_fault_unlocked()` uses uninterruptible `mmap_read_lock(=
)` inside a retry sequence, which can delay or block fatal signals.
- [High] Unconditional dereference of `hmm_vma_walk->locked` in `hmm_do_fau=
lt()` can cause a kernel panic if a buggy fault handler returns `VM_FAULT_R=
ETRY` or `VM_FAULT_COMPLETED` without `FAULT_FLAG_ALLOW_RETRY`.
--

commit 0808f6917e681bb06bd68894103530cfbabe07b9
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

mm/hmm: add hmm_range_fault_unlocked() for mmap lock-drop support

This commit adds hmm_range_fault_unlocked() for callers that do not
need to hold mmap_lock across any work outside the HMM fault itself.
It takes mmap_read_lock() internally and allows handle_mm_fault() to
drop it during fault handling.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index 2129b1ee4c35b..316116994209c 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
[ ... ]
> @@ -651,37 +663,33 @@ static int hmm_do_fault(struct mm_struct *mm,
>  		fault_flags |=3D FAULT_FLAG_WRITE;
>  	}
> =20
> -	for (; addr < end; addr +=3D PAGE_SIZE)
> -		if (handle_mm_fault(vma, addr, fault_flags, NULL) &
> -		    VM_FAULT_ERROR)
> -			return -EFAULT;
> +	for (; addr < end; addr +=3D PAGE_SIZE) {
> +		vm_fault_t ret;
> +
> +		ret =3D handle_mm_fault(vma, addr, fault_flags, NULL);
> +
> +		if (ret & (VM_FAULT_COMPLETED | VM_FAULT_RETRY)) {
> +			*hmm_vma_walk->locked =3D 0;

[Severity: High]
Can this result in a NULL pointer dereference?

When the legacy hmm_range_fault() is called, it passes NULL for the
locked parameter, meaning hmm_vma_walk->locked will be NULL.

If a buggy fault handler incorrectly returns VM_FAULT_RETRY even when
FAULT_FLAG_ALLOW_RETRY is not set, it seems this would unconditionally
dereference the NULL pointer here.

> +			return HMM_FAULT_UNLOCKED;
> +		}
[ ... ]
> +int hmm_range_fault_unlocked(struct hmm_range *range)
> +{
> +	struct mm_struct *mm =3D range->notifier->mm;
> +	int locked =3D 1;
> +	int ret;
> +
> +	mmap_read_lock(mm);

[Severity: High]
Should this use mmap_read_lock_killable() instead of the uninterruptible
mmap_read_lock()?

Since this function is designed to be called inside a retry loop, if the
mmap lock is highly contended, it appears a task could enter an
uninterruptible sleep here and block fatal signals indefinitely. This might
defeat the purpose of the FAULT_FLAG_KILLABLE flag that is set during the
actual fault.

> +	ret =3D hmm_range_fault_locked(range, &locked);
> +	if (locked)
> +		mmap_read_unlock(mm);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(hmm_range_fault_unlocked);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178336023903.504354=
.7500950448226027718.stgit@skinsburskii?part=3D2

