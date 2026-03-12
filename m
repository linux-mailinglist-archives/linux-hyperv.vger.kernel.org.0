Return-Path: <linux-hyperv+bounces-9346-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMQlIMlAsmnwKQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9346-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 05:27:53 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF40726D186
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 05:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0906302B528
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 04:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477A03932F9;
	Thu, 12 Mar 2026 04:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgdNRk6Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245EB38F63F;
	Thu, 12 Mar 2026 04:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773289671; cv=none; b=SLT1OLquZ2uY8dpPffsEA3rtbVWTESny6Vb4iPSCZumsb4oHOVj4IgADSwFGUGvFP9NNFA1UPdJ6u9CmSLPVDd8qfvSehKBHlQjc6WgG/hecMvNijJIVMULD1OQjJGVKMti+3skkzu4fI/+p3IndcM28Tq6R1Qk5yn+HudYydcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773289671; c=relaxed/simple;
	bh=4Mpyxg9/rf4ZrGSfdyJI04v+4J2Wc8dE7ld4nEc+qFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvQ5uEm7Vo3h3aeLU6Cruv2uuoPzk1Pa7d7aMvddw11MMHy5rLWAC3j+Wj+bAC6NoikU7qe+Tr0gfDYoL2PF9qOB2zYmjEsW2wvf3IMraqsRyVmqV2VlXz17cYKGtP+WlRS9jwwjG+LNh2VnHE/edP7nPObA/olflBihB4sVh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgdNRk6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F90DC4CEF7;
	Thu, 12 Mar 2026 04:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773289670;
	bh=4Mpyxg9/rf4ZrGSfdyJI04v+4J2Wc8dE7ld4nEc+qFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KgdNRk6Q4c3T5V7DfeU82/DNFC9LepvjnQOBP2CP+oye1vcrm6nBmHCsD/Si9dNUa
	 u+jE/oQ0L9vyGj/5n05uXpVOkt1WXYqwYAnBo0nYEUe8hvn5/LSANYDUqplx2ePR6U
	 a8XjZjeTzzwjTzXh9Axvsd0n22DMPiN3plbA7SABXJKJLSP/Jr8Q1C94KGvmS3+Zm8
	 DTzVVgu427hFFRlWlDAKUzppllUw3B4OHFjxqwjDiF3glKZrG2xpxaD8hpuhz0YPjF
	 roZNyOh0rqnrEsE0PTrfsy3LRSO9LiPY2nQ5S14Zd3gHtoXrIYrtZodSVGsM5YinGr
	 rmVFqn8zjecBQ==
Date: Thu, 12 Mar 2026 04:27:49 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -hyperv 1/3] x86/hyperv: Save segment registers directly
 to memory in hv_hvcrash_ctxt_save()
Message-ID: <20260312042749.GH3612627@liuwe-devbox-debian-v2.local>
References: <20260311102658.215693-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311102658.215693-1-ubizjak@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9346-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,liuwe-devbox-debian-v2.local:mid,zytor.com:email]
X-Rspamd-Queue-Id: EF40726D186
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 11:25:58AM +0100, Uros Bizjak wrote:
> hv_hvcrash_ctxt_save() in arch/x86/hyperv/hv_crash.c currently saves
> segment registers via a general-purpose register (%eax). Update the
> code to save segment registers (cs, ss, ds, es, fs, gs) directly to
> the crash context memory using movw. This avoids unnecessary use of
> a general-purpose register, making the code simpler and more efficient.
> 
> The size of the corresponding object file improves as follows:
> 
>    text    data     bss     dec     hex filename
>    4167     176     200    4543    11bf hv_crash-old.o
>    4151     176     200    4527    11af hv_crash-new.o
> 
> No functional change occurs to the saved context contents; this is
> purely a code-quality improvement.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Long Li <longli@microsoft.com>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>

Series applied to hyperv-fixes. Thanks.

