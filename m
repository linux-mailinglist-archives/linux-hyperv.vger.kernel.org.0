Return-Path: <linux-hyperv+bounces-6723-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295FBB437B7
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Sep 2025 11:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED763AAA2C
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Sep 2025 09:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4D22E229E;
	Thu,  4 Sep 2025 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rn+Org61";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h/q0DZkE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC02D4B5F;
	Thu,  4 Sep 2025 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979864; cv=none; b=NXi/OtyN9M56EQsQs21PUTlgNIEqOQBpMakNHvkcHoR9yHtBNbUJdkt0PUL0gil/BNZoWHPUDWuHy9pbXv/WwUxyfkTTvpfyuFPQKvWRaFhmqASWuZ8aFe/00QuGiKdM5kqt/654ep52iHAiwjIzpI7vzTW9FB7eumM0qjZMt6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979864; c=relaxed/simple;
	bh=jCWWS9thhqHI6WorjKVJ4Omd+zzp5g47xyBO8dkSAPI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nXvMSSU3tQXTgxwXAn8+LjHEtfWbaJpREW3g5NhFAUXMt97vwQ2gDKpeId7L22MGARgTrhiootvVr8oCYwsDCaun8517uuF0XXHlS1ZLG5BtGkX4jSXQmq+2p0CrC/9coNeNoBlM5BXjbNML1XUZwwV6UenId2c6FipsM6WLtGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rn+Org61; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h/q0DZkE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756979860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lmxUDcVQGvGH5AiF2LAsdAfRz+R12LPp/Ke3ofTCeYo=;
	b=Rn+Org61hauTNhCUylxzKqCb9uCYSrtylMDSEI+qtGUvF6TN03J3Ui9ylUvWK60MvvqMsR
	SKox1lhDWuqillbAolGmzfB4vcUP1FSwLaqOtn1wbvgiZlLAQpQNfxXrT4b4RRj5xpzicF
	jQrQRQMoaTSh8A6Ob6PsLgwJAKrZV7/D8VKA90Ksn0mztVDyi7IOh/2QM8CwrbxNk7YqK4
	EKLul63PCeMgP+ROm/enfTs3XQ3jvXlOPvfJwxYNSlOK11gEfdRQonuQZ8cv3MLNTPNs8j
	rhDm/a7+FbQuSY6Jny1Y6qfL57txEi2B7OZm0QgkjL7ANxr3z/rIwA5nE4K4lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756979860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lmxUDcVQGvGH5AiF2LAsdAfRz+R12LPp/Ke3ofTCeYo=;
	b=h/q0DZkEQFvuC1q0khezrE5jkkUSq3+igljP7KCmENo5CHpWJwus2234LjAEt1+jTR5gdG
	2hzRKoGJwdp6Y3BQ==
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, Nam Cao
 <namcao@linutronix.de>, "K . Y . Srinivasan" <kys@microsoft.com>, Marc
 Zyngier <maz@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin"
 <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] x86/hyperv: Switch to
 msi_create_parent_irq_domain()
In-Reply-To: <0105fb29-1d42-49cb-8146-d2dfcb600843@linux.microsoft.com>
References: <cover.1752868165.git.namcao@linutronix.de>
 <45df1cc0088057cbf60cb84d8e9f9ff09f12f670.1752868165.git.namcao@linutronix.de>
 <0105fb29-1d42-49cb-8146-d2dfcb600843@linux.microsoft.com>
Date: Thu, 04 Sep 2025 11:57:39 +0200
Message-ID: <87o6rqy1yk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 03 2025 at 12:40, Nuno Das Neves wrote:
> On 7/18/2025 12:57 PM, Nam Cao wrote:
>> Move away from the legacy MSI domain setup, switch to use
>> msi_create_parent_irq_domain().
>> 
>> While doing the conversion, I noticed that hv_irq_compose_msi_msg() is
>> doing more than it is supposed to (composing message content). The
>> interrupt allocation bits should be moved into hv_msi_domain_alloc().
>> However, I have no hardware to test this change, therefore I leave a TODO
>> note.
>> 
>> Signed-off-by: Nam Cao <namcao@linutronix.de>
>> ---
>>  arch/x86/hyperv/irqdomain.c | 111 ++++++++++++++++++++++++------------
>>  drivers/hv/Kconfig          |   1 +
>>  2 files changed, 77 insertions(+), 35 deletions(-)
>
> Tested on nested root partition.
>
> Looks good, thanks.
>
> Tested-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

I assume this goes through the hyper-V tree.

Acked-by: Thomas Gleixner <tglx@linutronix.de>

