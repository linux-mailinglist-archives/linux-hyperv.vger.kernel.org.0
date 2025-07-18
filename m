Return-Path: <linux-hyperv+bounces-6298-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFFEB0AA8A
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 21:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E837D1C824F7
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 19:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37502E7197;
	Fri, 18 Jul 2025 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eQgNWxYs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m+OhRVKV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433611BD9CE;
	Fri, 18 Jul 2025 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752865738; cv=none; b=eYtSymQgaKiLycf0lqcVdCD9LysKaWW608DorbbdZjNusL3cfWwLrhFSghVlsVnq3ZTh0bbpmKMb38CwXiAJ2ZJNLu4Z2nN+kLko79lQwKBeq1PrLM+Ili5lSmuJk7DaSXtnbDkAsBGDNAcI+vpifUTht5mKOqwALATvQMW7dkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752865738; c=relaxed/simple;
	bh=Pzo0MPLwRuN97EgZNXgPSWUy4Yzutdk0XtSOSJtCt3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FifmZx7QAjLikCS+RO5saXTaGgVGdiOz7+67bCk+sLLlBHNMBr+fgk6SpcgUMyLVqZWScCQ9tC9Rf7YAr6OiNKAQ2K+VPgX1UTQxABNOZO2IkBJssX4Ht3gX70zaLIl0URFSHuHGorxG0uQdUW/LU3Y4XCLiW5FLWv1AXQwp5RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eQgNWxYs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m+OhRVKV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752865735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V8r0rppQDHjmVj5vpwx1UbfKmxxZSTrgp9dHaxLIUl0=;
	b=eQgNWxYs+OojHD+P4Y1lNYA8nRl5EISY6uS6cqMouXjIGvt+LNNCxD9Bv33JF/C9eJwP4m
	PejkT4DeABC0wS9fPw4ek3ZwooVD6hw9FViB1Rt7mmMQLLF7KXhqMjYX6xQzbi2g5ID+82
	R7nTI5Pnq2Ar8eoCAp54bxJBiFH4lycI0dydQHgKtp/UH4UA3IPnVdxOzc6uoCzi2E1cfw
	w5tYmH8AvO4G3Mnm3KM+zfrIRZkG/OateibkA3uWWU62d+DZUtsYQAp4p/i8XCNtQxY+p9
	xKSpGvh9YO1A70EB4rjqEHtq5E8mOFK8OK8uFfEJoCShouTipxXGbrXDuSYPxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752865735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V8r0rppQDHjmVj5vpwx1UbfKmxxZSTrgp9dHaxLIUl0=;
	b=m+OhRVKVyGPBAoU1FI4VZsqfXYJT7bEeg+oYz4dbu3jWHWOXg1rwQrWX2fPXtsN9W0t7p+
	3oTM5Jo57mdII3AQ==
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Nam Cao <namcao@linutronix.de>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>, Marc Zyngier <maz@kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin"
 <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/hyperv: Switch to
 msi_create_parent_irq_domain()
In-Reply-To: <c145aebb-4deb-4f1e-95aa-2ba13bf0c453@linux.microsoft.com>
References: <cover.1751277765.git.namcao@linutronix.de>
 <5c0ada725449176dfeeb1f7aa98c324066c39d2c.1751277765.git.namcao@linutronix.de>
 <aG7932u1SvvAYh2l@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
 <c145aebb-4deb-4f1e-95aa-2ba13bf0c453@linux.microsoft.com>
Date: Fri, 18 Jul 2025 21:08:54 +0200
Message-ID: <87cy9xwc3d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 15 2025 at 12:09, Nuno Das Neves wrote:
> On 7/9/2025 4:40 PM, Wei Liu wrote:
>> CC Nuno who is also touching on this file.
>> 
>> Nam, thanks for this patch. 
>> 
>> Nuno's patches fix a few bugs with the current implementation. I expect
>> those patches to have contextual conflicts with this patch. I would like
>> to commit Nuno's patches first since those are bug fixes, and then
>> circle back to this one.
>> 
>> Nuno, can you please review this patch?
>> 
>
> I don't think I can give a Reviewed-by since I don't have the context
> for these changes.

The cover letter provides the information along with a link for deeper
information:

  https://lore.kernel.org/all/cover.1751277765.git.namcao@linutronix.de

> It doesn't look like this conflicts with the changes in my patches.

It might not look like it, but reality tells a different story:

Applying patch _PATCH_v2_2_2_x86_hyperv_Switch_to_msi_create_parent_irq_domain_.patch
patching file arch/x86/hyperv/irqdomain.c
Hunk #1 FAILED at 10.
Hunk #2 FAILED at 276.
2 out of 2 hunks FAILED -- rejects in file arch/x86/hyperv/irqdomain.c
patching file drivers/hv/Kconfig
Hunk #1 FAILED at 10.
1 out of 1 hunk FAILED -- rejects in file drivers/hv/Kconfig

Nam, can you please redo the patch against the hyperv tree?

Thanks,

        tglx

