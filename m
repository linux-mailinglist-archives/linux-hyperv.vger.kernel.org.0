Return-Path: <linux-hyperv+bounces-8256-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE847D16EA3
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 07:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98A8430184F2
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 06:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6AC369225;
	Tue, 13 Jan 2026 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwX9VvXc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F50350D62;
	Tue, 13 Jan 2026 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768287336; cv=none; b=Ut3GlWQ1E00C/imWk+w3xVyxBGWAbsboYnWjZc1xiTfdSTAPh5Jbe6L6HuTy8uO1SYZidt0Il1w5Jrv2Emz1pL4jmAoKqjwa94Klhu3AxlOHCWl4m8nkDC6zXGSkEDPWYAPQp3jWJO8pEafUDUAjHv/pqx5xn3+ipi/j19aBcng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768287336; c=relaxed/simple;
	bh=n2q+fJWEyo0mV6AKyU2NgixjB8rQdCeFy7wPDNt7Ixw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMDT/uKuJ0LbW67kJPGQQzx5Hipwxe/qjNRsTxFSqNffu/LeLywgxTuyxLVanQR4e+IzOpviY8ZJwzsOOJ/VVhlKZ8+ykN0hNZpVC3XIJz2AZ2NvLCt8DT7/m5Nfese0drj9rRXtnG8/dg7ksvdppgOWAle2pkonAu1l7FVG/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwX9VvXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536E5C116C6;
	Tue, 13 Jan 2026 06:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768287335;
	bh=n2q+fJWEyo0mV6AKyU2NgixjB8rQdCeFy7wPDNt7Ixw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwX9VvXcjdrskeQKOvbcv2HC+NL/RDz4FppQ9fnPtBQA1h/lZM5QudZv4iKoKJl1C
	 VQCaQU+hiUKx7q8EgGpIzV1Hn20fsOFwG6zqcIn/vl3U4GG2DoZuoBCdSCc9MIrVi6
	 2MHpiBSZFVQlABThX/kX+VNSm9NEDG583BF3gZqeCl8YnVq3DfJ/UB2vR++2E2jQ+/
	 fLslrBi9sfsC0XXL368jTALZsIRyCVk19M0zkW8jJecDCMGw6Svd8eEi3+2ow4H/MN
	 ppPLXp3SH5miS5Kp+TM4ntM0fIhbOm6ktZD6rGbuzWn5lDVqcsC7+tqrUBLCvxlmzQ
	 QPuSOGbMm9j6Q==
Date: Tue, 13 Jan 2026 06:55:34 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-hyperv@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>, Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v5 01/21] x86/paravirt: Remove not needed includes of
 paravirt.h
Message-ID: <20260113065534.GB3099059@liuwe-devbox-debian-v2.local>
References: <20260105110520.21356-1-jgross@suse.com>
 <20260105110520.21356-2-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105110520.21356-2-jgross@suse.com>

On Mon, Jan 05, 2026 at 12:05:00PM +0100, Juergen Gross wrote:
> In some places asm/paravirt.h is included without really being needed.
> 
> Remove the related #include statements.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> V3:
> - reinstate the include in mmu_context.h (kernel test robot)
> V4:
> - reinstate the include in arch/x86/kernel/x86_init.c (Boris Petkov)
> ---
>  arch/x86/entry/entry_64.S             | 1 -
>  arch/x86/entry/vsyscall/vsyscall_64.c | 1 -
>  arch/x86/hyperv/hv_spinlock.c         | 1 -

Acked-by: Wei Liu (Microsoft) <wei.liu@kernel.org>

