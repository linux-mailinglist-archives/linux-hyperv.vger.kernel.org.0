Return-Path: <linux-hyperv+bounces-11879-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X6aoFcoMT2ogZwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11879-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 04:51:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7E572C298
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 04:51:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P5WxtAIe;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11879-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11879-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80A5B3009B04
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jul 2026 02:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE4536F90E;
	Thu,  9 Jul 2026 02:51:51 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169543368A4
	for <linux-hyperv@vger.kernel.org>; Thu,  9 Jul 2026 02:51:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783565511; cv=none; b=UPqPW5wtpThXBBvsc0kQR8x6qsBlS/wjQClCf3VxErxZTad6fYcohGi9HUGklUoPASkEZoshPmE430R5qLycysLekjk6yTf9DFhSEJmkCxL1b00B8EZR53zuWDiAQ9repjElUtIQDJMbBQ4Abt8NrJow+mIx+wf7M/on96yLfKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783565511; c=relaxed/simple;
	bh=BRmmFqPmusssNY82Jzt8JrMYWoZQKzcFvohk50YfR+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g7/g/EaoZSjPSugpL5+wY0Jk4UweajpgUCk1lQa3q06bXBqg6N7jIS8iasg1uja8wIWmvDh3MIbeoh6Djd2qgXgLHCqYSFSdHVJANPSeoO7hjHGB8G4xg9X86alfPGOTFmCoy2tPLiHzQrUTc2YY7xhG6KdkoqFbwWEnsTs4T2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5WxtAIe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982341F000E9;
	Thu,  9 Jul 2026 02:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783565509;
	bh=Auqq5kshxEvLsv0FZtT1vN28GXl2Rt/8BpkvgeDUl7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P5WxtAIe+6IK5T67hz3OlsNcxkeBDYbC4f9kH/vBK7LklhUCDvjydVROttwvKR8Ap
	 cdbLu5OBorQLo7iqcx35r/lVQJ+4tTeKXz4U9N8dd6FRIWPMs/Cz6nzY8x5610z1PU
	 55edkMEoAriNw5NQCXk2OhmOgCZd2rZMgLLGp8w6unlaHiEJmU56u1ci+fEPf6n/4X
	 lGyK3o5W+vXrVeb1g2qdSaQfNKI0trFVdp6X9Nw9mNNFU6U79T4EH8t/Y76bJhJi74
	 xAtdgnOm7CxKvT34nDysUAgXLtbtQCurrstYzUBiycnDo9yYHWX1dZLu4qZ4X6j9aJ
	 8hJ9QuYEmoi5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mshv: bounds-check cpu index in vtl mmap fault handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yi Xie" <xieyi@kylinos.cn>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260709021947.49436-1-xieyi@kylinos.cn>
References: <20260709021947.49436-1-xieyi@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 02:51:49 +0000
Message-Id: <20260709025149.982341F000E9@smtp.kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11879-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xieyi@kylinos.cn,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC7E572C298

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Returning VM_FAULT_NOPAGE for unmapped/invalid offsets in mshv_vtl=
_fault creates an infinite page fault loop.
- [High] A partial allocation failure of `reg_page` on a secondary CPU lead=
s to a NULL pointer dereference upon mmap fault, due to global state mismat=
ch.
- [High] Registering the character device before CPU contexts are initializ=
ed exposes uninitialized memory or causes kernel panics.
- [High] The module leaks an eventfd wait queue entry, leading to a guarant=
eed Use-After-Free (UAF) upon module unload.
- [High] Missing allocation failure checks lead to a NULL pointer dereferen=
ce in `mshv_vtl_hvcall_call`.
- [Medium] The CPU bounds check in `mshv_vtl_ioctl_set_poll_file` uses `num=
_possible_cpus()` instead of `nr_cpu_ids`, potentially rejecting valid CPUs.
--

--- Patch [1]: [PATCH] mshv: bounds-check cpu index in vtl mmap fault handl=
er ---
commit 8ac0cc752b2b67def52fafd91c16c26937bc5c16
Author: Yi Xie <xieyi@kylinos.cn>

mshv: bounds-check cpu index in vtl mmap fault handler

cpu is taken from pgoff & 0xffff.  cpu_online() does not reject cpu >=3D
nr_cpu_ids, and per_cpu_ptr() can then walk off __per_cpu_offset.

> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 0d3d4161974f8..fc50c44ac1bda 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -801,7 +801,7 @@ static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf)
>  	int cpu =3D vmf->pgoff & MSHV_PG_OFF_CPU_MASK;
>  	int real_off =3D vmf->pgoff >> MSHV_REAL_OFF_SHIFT;
> =20
> -	if (!cpu_online(cpu))
> +	if (cpu >=3D nr_cpu_ids || !cpu_online(cpu))
>  		return VM_FAULT_SIGBUS;

[Severity: High]
This is a pre-existing issue, but returning VM_FAULT_NOPAGE for unmapped or
invalid offsets in mshv_vtl_fault() can create an infinite page fault loop:

drivers/hv/mshv_vtl_main.c:mshv_vtl_fault() {
...
	if (real_off =3D=3D MSHV_RUN_PAGE_OFFSET) {
		page =3D virt_to_page(mshv_vtl_cpu_run(cpu));
	} else if (real_off =3D=3D MSHV_REG_PAGE_OFFSET) {
		if (!mshv_has_reg_page)
			return VM_FAULT_SIGBUS;
		page =3D mshv_vtl_cpu_reg_page(cpu);
	} else {
		return VM_FAULT_NOPAGE;
	}
...

Since VM_FAULT_NOPAGE indicates the fault was successfully handled without
installing a PTE, won't the CPU infinitely re-fault on the same instruction
and lock up the core if userspace accesses an unmapped offset? Should this
return VM_FAULT_SIGBUS instead?


[Severity: High]
This is a pre-existing issue, but does a partial allocation failure on a
secondary CPU lead to a NULL pointer dereference upon mmap fault?

If alloc_page() fails in mshv_vtl_configure_reg_page() for a specific CPU,
it returns without initializing the per-CPU reg_page:

drivers/hv/mshv_vtl_main.c:mshv_vtl_configure_reg_page() {
...
	reg_page =3D alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL);
	if (!reg_page) {
		WARN(1, "failed to allocate register page\n");
		return;
	}
...

However, the fault handler relies on the global mshv_has_reg_page flag
instead of checking if the per-CPU page is actually valid:

drivers/hv/mshv_vtl_main.c:mshv_vtl_fault() {
...
	} else if (real_off =3D=3D MSHV_REG_PAGE_OFFSET) {
		if (!mshv_has_reg_page)
			return VM_FAULT_SIGBUS;
		page =3D mshv_vtl_cpu_reg_page(cpu);
	}
...
	get_page(page);

If the global flag is set by another CPU's successful allocation, won't
mshv_vtl_fault() bypass the safety check and call get_page(NULL) for the
failing CPU?


[Severity: High]
This is a pre-existing issue, but does registering the character device
before CPU contexts are initialized expose uninitialized memory?

drivers/hv/mshv_vtl_main.c:mshv_vtl_init() {
...
	ret =3D misc_register(&mshv_dev);
	if (ret) {
...
	ret =3D hv_vtl_setup_synic();
...

Since misc_register() exposes /dev/mshv to userspace before
hv_vtl_setup_synic() allocates the per-CPU run and reg_page pointers, can a
fast userspace process mmap the device and trigger a page fault resulting in
virt_to_page(NULL) or get_page(NULL)?


[Severity: Medium]
This is a pre-existing issue, but does the bounds check in
mshv_vtl_ioctl_set_poll_file() incorrectly reject valid CPUs on sparse
topologies?

drivers/hv/mshv_vtl_main.c:mshv_vtl_ioctl_set_poll_file() {
...
	if (input.cpu >=3D num_possible_cpus() || !cpu_online(input.cpu))
		return -EINVAL;
...

If the system has a sparse CPU possible mask, num_possible_cpus() could be
lower than a valid CPU ID. Should this use nr_cpu_ids instead?


[Severity: High]
This is a pre-existing issue, but does the module leak an eventfd wait queue
entry leading to a use-after-free upon module unload?

drivers/hv/mshv_vtl_main.c:mshv_vtl_ioctl_set_poll_file() {
...
	if (file) {
		init_waitqueue_func_entry(&poll_file->wait, mshv_vtl_poll_file_wake);
		init_poll_funcptr(&poll_file->pt, mshv_vtl_ptable_queue_proc);
		vfs_poll(file, &poll_file->pt);
	}
...

drivers/hv/mshv_vtl_main.c:mshv_vtl_exit() {
...
	device_del(mem_dev);
	kfree(mem_dev);
	misc_deregister(&mshv_vtl_low);
...

The MSHV_SET_POLL_FILE ioctl permanently adds the global per-CPU
poll_file->wait entry into the user-provided eventfd's wait queue. Since
mshv_vtl_exit() doesn't remove the wait queue entry or release the eventfd
reference, won't signaling the eventfd after module unload cause the kernel
to traverse the wait queue and dereference freed memory?


[Severity: High]
This is a pre-existing issue, but are missing allocation failure checks
causing a NULL pointer dereference in mshv_vtl_hvcall_call()?

drivers/hv/mshv_vtl_main.c:mshv_vtl_hvcall_call() {
...
	in =3D (void *)__get_free_page(GFP_KERNEL);
	out =3D (void *)__get_free_page(GFP_KERNEL);

	if (copy_from_user(in, (void __user *)hvcall.input_ptr, hvcall.input_size)=
) {
...

If __get_free_page() returns 0 (NULL) due to memory pressure, the
subsequent copy_from_user() will attempt to copy user-supplied data
to a NULL pointer. Shouldn't the return values of __get_free_page() be
validated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709021947.4943=
6-1-xieyi@kylinos.cn?part=3D1

