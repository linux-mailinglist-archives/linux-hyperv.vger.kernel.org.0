Return-Path: <linux-hyperv+bounces-2662-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A18945412
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 23:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A86B22858
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 21:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BBC1494DD;
	Thu,  1 Aug 2024 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eu+4qHJJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MbKL/NwU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E474519478;
	Thu,  1 Aug 2024 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722547380; cv=none; b=NXo7VIctE9b7Uq2iIhkJq2no9LCxqp0IUER/WVoDr+HQ6O5WfY+G3sxPhnRc2jSgfb6CiLoikZRO1t5jwjUdtYmAVVaMVW19tyo9OGB+n0dVyJmBLt27aMx6OVlhXPohoCn6l+RNf++sjFB9obSOjaCVq69DQiJnGfnGNKdRPIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722547380; c=relaxed/simple;
	bh=dFyJ1Q1cJL2fBef+NoPPOosTuPOsoSCxnLcPU8Linzw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RCCZAqa2YGwt8IvqCtAAkp+kficOC/6fpDv5A+rWYr4yaI716c7a2icjbHGU+oN9PjU8FUzfpAIKUdzjJ3qucBMSG9Xv+eHyePxiQ+yWSVDs+GnDpg42lwcRTYRV2dmNPXi6rPKVVWT+3CBapFKBJABIE+T5K+QAC9KqMeZ9RYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eu+4qHJJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MbKL/NwU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722547377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/bPQx+ZKDBbmM1PYjMWLaq6zuMAkaUkfDAk5SMqXxu8=;
	b=Eu+4qHJJQudXZZZGa4I7HYG1WPxOAEV1rPMCy9rsFrNAp2Ud2k9eoD5AtMus4yTaWhiyGY
	Uf7YwRKfMWVq0ARM7aH8JRSD4kB1CZz6E9JDG38f1nLS7KMrCZPyvRDjl+D81q16CQLYf+
	tLfx+LSqlTDaV6GxFl1JSbhNnAN5FoBFiOnMoqCrBTSW/bSaDYePPMdor5v56fbjQkaROj
	n0cDkl1uusLzUFV/rtwBQLQJFaVncpcrG3LhL+E1Tf8djElVK+34ayyuTanaI/e8AovhHO
	lQRUZhfuCf3p9mPncRzNJh9p8WrEsKB+sTxmSVocus80u7HsdomsKPKsrYhAUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722547377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/bPQx+ZKDBbmM1PYjMWLaq6zuMAkaUkfDAk5SMqXxu8=;
	b=MbKL/NwUhsd5vNeoepPWx9FK61ULCVASuXRpqaRabWkO+aVNotQGDkYEEyarzsxcpWpgAD
	6uYMs74F8zX7rFAQ==
To: David Woodhouse <dwmw2@infradead.org>, lirongqing@baidu.com,
 seanjc@google.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
In-Reply-To: <bb8c97ea2b3596f605b9e1b27a221a1c64727e59.camel@infradead.org>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
 <87ttg42uju.ffs@tglx>
 <e9a9fb03a4fd47ebddc3bf984726c0f789d94489.camel@infradead.org>
 <87ikwk2hcs.ffs@tglx>
 <cf5bf4eec7cb36eec0b673353ff027bee853dd48.camel@infradead.org>
 <87a5hw2euf.ffs@tglx>
 <bb8c97ea2b3596f605b9e1b27a221a1c64727e59.camel@infradead.org>
Date: Thu, 01 Aug 2024 23:22:56 +0200
Message-ID: <871q382b0v.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 01 2024 at 21:49, David Woodhouse wrote:
> On Thu, 2024-08-01 at 22:00 +0200, Thomas Gleixner wrote:
>> > I justify my cowardice on the basis that it doesn't *matter* if a
>> > hardware implementation is still toggling the IRQ pin; in that case
>> > it's only a few irrelevant transistors which are busy, and it doesn't
>> > translate to steal time.
>> 
>> On real hardware it translates to power...
>
> Perhaps, although I'd guess it's a negligible amount. Still, happy to
> be brave and make it unconditional. Want a new version of the patch?

Let'ss fix the shutdown sequence first (See Michaels latest mail) and
then do the clockevents_i8253_init() change on top.

Thanks,

        tglx

