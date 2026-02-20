Return-Path: <linux-hyperv+bounces-8926-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCVJK4bfl2ne9gIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8926-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 05:13:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C22B2164978
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 05:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03C80302BB87
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 04:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64232FF170;
	Fri, 20 Feb 2026 04:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDXlT4Na"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932E5321F5F;
	Fri, 20 Feb 2026 04:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560647; cv=none; b=DLipQIA1RIqaQuUx9pdk9WyXWmxU88v5sSzUEPgc8r+IqVcffoF5s3umcBV39axMqk63Bt3xOXO0pECJeBgJlGaFfN0MmHXmSVhoiU63NWClhlhz/jwT5TSK0jSIFXfpZC76DNVixQcAWoeHYu7XhOyHPJ+X7YwFkWu4KS8r/yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560647; c=relaxed/simple;
	bh=DjnngyKQ6dmi0gCTo1xCIRCHL1ludrKw3TKGvuwo0Ug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ijMXuoWZmpIXiMdgYw9diCF91Wvp3Q+dSAzyZhE/bTLV+Zq1HIDWMw2Sf2gQaAGHP/cVz8E/Wl0D+3nsduEfjsWcoqgjWVJjPMxmCSaJBFCOdtV2nu/k0ge7bc0HIrcLYGgFOuoPFdn+d1RXPFyJyk25mUorCSH6Up9gbmzKEpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDXlT4Na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219E5C2BC86;
	Fri, 20 Feb 2026 04:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560647;
	bh=DjnngyKQ6dmi0gCTo1xCIRCHL1ludrKw3TKGvuwo0Ug=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UDXlT4NaQgzahQOt/dvMDQ39sYRD52/c4qNbvdVS19EyX+doX2VR1jGpM6fKTK5hg
	 rCFmqTKrXa0b5vcg1CKJuJbKtS2lu3bnOvOY1ZcjS8kyszRsQ2ihER7WY0j0/TjBVf
	 ESR58G8Wv5UXiZfVQgBBL/VOfCL/cCWmW3eJdCd7YiiZjvIc5PshOYVmUb7FMpdqCZ
	 VR22LNGw4/8tgtnLSks4YTRJWofn1TLmsJ8G9rz+7byiQ7KQhujWiVq++1aXqr5MNK
	 QsNQ2UwnhyOvc9Xw93nbkQEhuN5Pu9Vx+F7bxbEBDe/gC+mfrfvQgRuyWi/5t61Vpf
	 lawUTNXKdiYlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1363809A88;
	Fri, 20 Feb 2026 04:10:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 00/21] paravirt: cleanup and reorg
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156065529.189817.17016822219300820690.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:10:55 +0000
References: <20251006074606.1266-1-jgross@suse.com>
In-Reply-To: <20251006074606.1266-1-jgross@suse.com>
To: =?utf-8?b?SsO8cmdlbiBHcm/DnyA8amdyb3NzQHN1c2UuY29tPg==?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 peterz@infradead.org, will@kernel.org, boqun.feng@gmail.com,
 longman@redhat.com, jikos@kernel.org, jpoimboe@kernel.org,
 pawan.kumar.gupta@linux.intel.com, boris.ostrovsky@oracle.com,
 xen-devel@lists.xenproject.org, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 linux@armlinux.org.uk, catalin.marinas@arm.com, chenhuacai@kernel.org,
 kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-arm-kernel@lists.infradead.org,
 pbonzini@redhat.com, vkuznets@redhat.com, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, daniel.lezcano@linaro.org, oleg@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,kernel.org,lists.linux.dev,lists.ozlabs.org,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,microsoft.com,infradead.org,gmail.com,oracle.com,lists.xenproject.org,broadcom.com,armlinux.org.uk,arm.com,xen0n.name,linux.ibm.com,ellerman.id.au,csgroup.eu,dabbelt.com,eecs.berkeley.edu,ghiti.fr,linaro.org,goodmis.org,google.com,suse.de,epam.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8926-lists,linux-hyperv=lfdr.de,linux-riscv];
	NEURAL_SPAM(0.00)[0.383];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_GT_50(0.00)[57];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C22B2164978
X-Rspamd-Action: no action

Hello:

This series was applied to riscv/linux.git (fixes)
by Borislav Petkov (AMD) <bp@alien8.de>:

On Mon,  6 Oct 2025 09:45:45 +0200 you wrote:
> Some cleanups and reorg of paravirt code and headers:
> 
> - The first 2 patches should be not controversial at all, as they
>   remove just some no longer needed #include and struct forward
>   declarations.
> 
> - The 3rd patch is removing CONFIG_PARAVIRT_DEBUG, which IMO has
>   no real value, as it just changes a crash to a BUG() (the stack
>   trace will basically be the same). As the maintainer of the main
>   paravirt user (Xen) I have never seen this crash/BUG() to happen.
> 
> [...]

Here is the summary with links:
  - [v3,05/21] paravirt: Remove asm/paravirt_api_clock.h
    https://git.kernel.org/riscv/c/68b10fd40d49
  - [v3,06/21] sched: Move clock related paravirt code to kernel/sched
    (no matching commit)
  - [v3,10/21] riscv/paravirt: Use common code for paravirt_steal_clock()
    https://git.kernel.org/riscv/c/ee9ffcf99f07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



