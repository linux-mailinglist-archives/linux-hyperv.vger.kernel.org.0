Return-Path: <linux-hyperv+bounces-11858-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Um+ZOVSrTWqo8gEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11858-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 03:43:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D71F720E57
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 03:43:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DcsHFIpj;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11858-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11858-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 039543008D03
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jul 2026 01:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAFF3A9D80;
	Wed,  8 Jul 2026 01:42:54 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2948A364045
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Jul 2026 01:42:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474974; cv=none; b=QfvwlGRcTgQZVJk2tTy6ECfcBsrlNrkx65qMYSfZ91Uh0mu8Wf5tSACDX7aZhnxSelYDDP2PhEFR7o+1bK/1ATH3acN0zv6N3Agb9yO3pu4u+EA/d8f1h8ZnRmGywAfdH5jDG/LeSCvmHBjc8f0MQlam0OPWF7kePe/66z6JIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474974; c=relaxed/simple;
	bh=VOqv4HZDjvAeMcc7HZB+4oHAmr1t45HpKkkByzNAFSI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PoTss3SKBumk9NlrPGR/IaxrksDwOov1OlBCX8PseKF2PtTVF7Rc6h7fZww/LoYfC9OcRdSpsxPeAX0OnjaheG1hQ/UuToYSnxG+1/oCqomqr69jVISwNgjwy9heN7WE7YgJxeDEktv8JXSi3fnxjpc7EsXutsjIFfTECXE/eKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcsHFIpj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914811F000E9;
	Wed,  8 Jul 2026 01:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783474972;
	bh=8Gl8z+TVGYZTVsRD3InwPShzxCjg5hopqaLRaUpw77c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DcsHFIpjIOqwTuac56Gs/litHjpReX9tqnHAP48xvgbYhU3bPdBDxLKPegT/cE0t8
	 60zsRH1IbOtrfHE2XVyw2V/rflyuaEIVtrNaZMblRyGsIY/vdBC3Fb665IaQ53ZnOr
	 wtRaqkdRK2J70jDsyo1JZN+2r0Su+0BpClaYcYuwjM/J9VLPMdpLg7QZswhl2x6+xS
	 YHY1rR71v1zF5jlHxf37ielfFHLJhN/uJTNyy64ravjVkbsVZeaLc9HJq1pHf1P7jH
	 yv8ue1k3dssHRweGFB1we/+7ZRh4Fkq1a1BfRaa6hVHaOYhUTab7GWhvdd5ZDWGpRZ
	 LV9QgnYUrzEjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mshv: fix fd leak in mshv_ioctl_create_vtl()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yi Xie" <xieyi@kylinos.cn>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260708012852.36824-1-xieyi@kylinos.cn>
References: <20260708012852.36824-1-xieyi@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 01:42:52 +0000
Message-Id: <20260708014252.914811F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11858-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xieyi@kylinos.cn,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D71F720E57

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The `mshv_vtl_fault` mmap fault handler fails to bounds-check =
the user-controlled `cpu` index against `nr_cpu_ids`.
--

--- Patch [1]: [PATCH] mshv: fix fd leak in mshv_ioctl_create_vtl() ---
commit 2e3734b84c858c82d0ec893b4137e370673f6928
Author: Yi Xie <xieyi@kylinos.cn>

mshv: fix fd leak in mshv_ioctl_create_vtl()

This commit addresses a file descriptor leak in mshv_ioctl_create_vtl().
It ensures put_unused_fd() is called when anon_inode_getfile() fails,
freeing the allocated file descriptor before returning an error.

> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 0d3d4161974f8..897a41b08d026 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -129,6 +129,7 @@ mshv_ioctl_create_vtl(void __user *user_arg, struct d=
evice *module_dev)
>  	file =3D anon_inode_getfile("mshv_vtl", &mshv_vtl_fops,
>  				  vtl, O_RDWR);
>  	if (IS_ERR(file)) {
> +		put_unused_fd(fd);
>  		kfree(vtl);
>  		return PTR_ERR(file);
>  	}

[Severity: Critical]
This is a pre-existing issue, but while reviewing this file I noticed an
insufficient bounds check in the mmap fault handler.

Does this missing validation allow an out-of-bounds pointer arithmetic
regression?

drivers/hv/mshv_vtl_main.c:mshv_vtl_fault() {
	struct page *page;
	int cpu =3D vmf->pgoff & MSHV_PG_OFF_CPU_MASK;
	int real_off =3D vmf->pgoff >> MSHV_REAL_OFF_SHIFT;

	if (!cpu_online(cpu))
		return VM_FAULT_SIGBUS;

A VMA with a large offset can cause vmf->pgoff to yield an arbitrary
cpu index. The only validation is cpu_online(cpu), which uses an
unbounds-checked test_bit() against cpu_online_mask.

If the out-of-bounds read hits a set bit, the check passes. Execution then
proceeds to mshv_vtl_cpu_run(cpu), calling per_cpu_ptr() which reads from
the __per_cpu_offset array out-of-bounds.=20

The resulting garbage pointer is passed to virt_to_page(), and get_page()
incorrectly increments a reference count, potentially mapping arbitrary
physical memory into userspace.

Should this code check the cpu index against nr_cpu_ids before passing it
to cpu_online()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708012852.3682=
4-1-xieyi@kylinos.cn?part=3D1

