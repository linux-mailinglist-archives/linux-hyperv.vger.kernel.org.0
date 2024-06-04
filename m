Return-Path: <linux-hyperv+bounces-2317-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 004798FBB35
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 20:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0815EB216D4
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 18:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CFA14A0B8;
	Tue,  4 Jun 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Qcd3QTnu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40F4149006;
	Tue,  4 Jun 2024 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524392; cv=none; b=F42oYbWXWDS8TAhusjENPn8h95SXoN8bWrKuA08Q7QfShkXHdlO9rFXKojo/hsv4secAqpRFin0+BpTNh93dtxIN3WY6N4pD9qnogpmF3PRBlkgVKiq9UFg0Yajc90QE+2X+VSWFUfqzOnUSqYE5DELM1VUEFNaEHC1XlpgZw/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524392; c=relaxed/simple;
	bh=wO7W7vb+/AxcklDnL0MSQsYaiZgoy9/y22Xrp2mnyfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejAPPvsJ8qtDaN7FkObSuqYnEwRn/ONIbsw6vqoWcofpbhZCIZqVTChAon/oFrZqmrSDrF1XwKeZfsWbsgN3EGU6eO+dcTFrBXfgqL67pahudy+oLzn3hKzDZci7rMqOZOJVa9tbhkH3BOgLxbMUN6IwTGhEjJ9qFLiRBCjtpbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Qcd3QTnu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0479840E0081;
	Tue,  4 Jun 2024 18:06:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aODJicEVTnQO; Tue,  4 Jun 2024 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717524384; bh=meS63MnlFXX/qkUgab/1h3yFeTOB2Up4cbcyhv6eQF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qcd3QTnuRZDQQm/WVb/kDGKGIpKkoDMDIl29qUOVk6IaxfBNHQnzuQDtyt3xEbmAH
	 IOM9C4JdKAGGTQXzVzIzefFqProE8Rt4rDQVjOV9kNQF9DUtTllwV+9FLs08PyBlGY
	 q+bJelC25FNaCJkKW857MzL7VncyvOyYS6aCpZhFHUmQ1lW7V5RmvTWjXUZDfw3k81
	 TNSnu8YrHoI2PL8KtLePPs9P3iF3SPGJWtYUbpeeTnafko0PVz65UuMt9VtWA5pjcI
	 fdVZlnTjckoOiFrxcmVsoYv49oM6R+GqdtVlQtmhZfJvgFws8n0ofh42pG13ggDO+Y
	 D7twSe/5QDvNqlY9hRtyqNJn9uqtUc7WVSQjWvLIgNEYgiCAPvTIiFpbOkmMzrUrp6
	 MeG7p3zMGl6w7Z0FM6ibJvMdlW4l3wMlZTN57RvoXToXJnBELOqoYv7KLTY1s5InD+
	 bOdkt8HsRuCXWXLxgAz9NkFSJzI8IQK6jYt/lh6FhwqBo5Zbh2KO9ZMbvmUqqGtAY+
	 VMk0ek/yLx7IS7AHpI/CfdH6AXooAyDqNwTLcQjEpmipTiAwUA9BmVhOt2MPqCP5/e
	 DbnB9bTDYGSNTsIJk7mxnKbAB7Du7Rfm+s7W5czyESBY91PK4AlHZ9QnV2JDOKUDyi
	 95STKxzaeIVOQ4XnMKySMkIs=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCCBA40E016A;
	Tue,  4 Jun 2024 18:05:55 +0000 (UTC)
Date: Tue, 4 Jun 2024 20:05:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, adrian.hunter@intel.com,
	ardb@kernel.org, ashish.kalra@amd.com, bhe@redhat.com,
	dave.hansen@linux.intel.com, elena.reshetova@intel.com,
	haiyangz@microsoft.com, hpa@zytor.com, jun.nakajima@intel.com,
	kai.huang@intel.com, kexec@lists.infradead.org, kys@microsoft.com,
	linux-acpi@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	ltao@redhat.com, mingo@redhat.com, peterz@infradead.org,
	rafael@kernel.org, rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv11.1 11/19] x86/tdx: Convert shared memory back to
 private on kexec
Message-ID: <20240604180554.GIZl9XgscEI3PUvR-W@fat_crate.local>
References: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
 <20240602142303.3263551-1-kirill.shutemov@linux.intel.com>
 <20240603083754.GAZl2A4uXvVB5w4l9u@fat_crate.local>
 <noym2bqgxqcyhhdzoax7gvdfzhh7rtw7cv236fhzpqh3wqf76e@2jj733skv7y4>
 <78d33a31-0ef2-417b-a240-b2880b64518e@intel.com>
 <u3hg3fqc2nxsjtfugjmmzlahwriyqlebnkxrbzgrxlkj6l3k36@yd3yudglgevi>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <u3hg3fqc2nxsjtfugjmmzlahwriyqlebnkxrbzgrxlkj6l3k36@yd3yudglgevi>

On Tue, Jun 04, 2024 at 07:14:00PM +0300, Kirill A. Shutemov wrote:
> 			/*
> 			 * If tdx_enc_status_changed() fails, it leaves memory
> 			 * in an unknown state. If the memory remains shared,
> 			 * it can result in an unrecoverable guest shutdown on
> 			 * the first accessed through a private mapping.

"access"

So this sentence above can go too, right?

Because that comment is in tdx_kexec_finish() and we're basically going
off to kexec. So can a guest even access it through a private mapping?
We're shutting down so nothing is running anymore...

> 			 * The kdump kernel boot is not impacted as it uses
> 			 * a pre-reserved memory range that is always private.
> 			 * However, gathering crash information could lead to
> 			 * a crash if it accesses unconverted memory through
> 			 * a private mapping.

When does the kexec kernel even get such a private mapping? It is not
even up yet...

> 			 * pr_err() may assist in understanding such crashes.

"Print error info in order to leave bread crumbs for debugging." is what
I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

