Return-Path: <linux-hyperv+bounces-2277-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4905C8D7D87
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Jun 2024 10:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4871C21E52
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Jun 2024 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF876A032;
	Mon,  3 Jun 2024 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CMOwbPY5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7B5FBB7;
	Mon,  3 Jun 2024 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403928; cv=none; b=pFmdlxXhO/TgPYUYgdTOHwwTIrMkMJmrL7igSUYqDuvuOl6CnUeE8Puk9RMSvew0Vlu42QfH6EQt2dEP8EnWCKZ53sReE3MPhP2PG64toliERYqHzsmUnyD4831kUq0mu6W+u+Td+rsDW99+KDPTQXXV1NFtYp6KFdePyQ3z9R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403928; c=relaxed/simple;
	bh=xq/iv7/1UpOy2/SAgTcm001eqgY4V+DhBntkistF5Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7z/nelkkR/ccn2XME6dSLgFsww55QnoboaevHMt5SpADpgn+wnSgG3QhK39B3SB7rKBwRg/jLzF70hB8FhCD+zsmEtCubK4ssuMZyxsLetquYRIxUwomcpFPhIOxtXqZ2Z6T2dMSjaOuocQyZrwlcX6OFGRAFgPAr7gTcGa4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CMOwbPY5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6917840E00C9;
	Mon,  3 Jun 2024 08:38:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4GQLSIrfu4S4; Mon,  3 Jun 2024 08:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717403909; bh=BG3hb7ew7HGc4e/mugY/JUXZY8h86mXig+erbW8q7XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMOwbPY5ydMRRAo9yxpECji56YyZLc9to2N3M0UH40rL7M1cdzFmhRSKjILeb/fWz
	 VbV4iQlaylyC8P6mER1AzTRdG168qiGA8fQvMdxxJOb8x32A1CsUGl9o3W6XtkeqQI
	 ZnEWE2HfkQbG03MHxJGc7xZAY2uF0mE4W+wKZBZ0sqp1cD2yLXZgHgAcpaO+Vp5si7
	 L3ZGKsSVy8VKnYF5i/fs6EQioBpme9vNMDYRweAg23f+y4DF/zEw7d2WTJDWU/xzEh
	 XdyOXtRcYO6WO7QPWRRYHKtI9kuhynyJCOkO1w8oIaG1Rll96C6pPlqtlQ7F8AIn+d
	 x1vEBlZaVr+v8BtqgNZ/Szv5MbpmnR6TuMwcHeTa2E4i//QHBUgyLAbT0YAqlJy2aF
	 mPSZKtThfqFoDZbR68X1lC8/SVxSo6dQZYw7qV6QK9uMtdor+eDl9rz7b/4JlRss5+
	 xRVpGybmecmE/AzRqaR08oFnnMcL0Z5TUjjiDxiBesVuhioskmFCgt38nZOewuFh4y
	 uF787/CefGr1UqSyHmK507XUU8Id0jRLzV6J5MtgDCaOyuoYp9gX7OS2nxSxTmTWqf
	 G2NZ8cpcmeIUfDFMiFaVVtbk9vVq4YeQ3X92eSp4gptgoYo5t+BwIwRoBql1/r3DRp
	 SzXb5Sa6NZ30gENATXVTzY4w=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5119B40E016E;
	Mon,  3 Jun 2024 08:38:02 +0000 (UTC)
Date: Mon, 3 Jun 2024 10:37:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: adrian.hunter@intel.com, ardb@kernel.org, ashish.kalra@amd.com,
	bhe@redhat.com, dave.hansen@linux.intel.com,
	elena.reshetova@intel.com, haiyangz@microsoft.com, hpa@zytor.com,
	jun.nakajima@intel.com, kai.huang@intel.com,
	kexec@lists.infradead.org, kys@microsoft.com,
	linux-acpi@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	ltao@redhat.com, mingo@redhat.com, peterz@infradead.org,
	rafael@kernel.org, rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv11.1 11/19] x86/tdx: Convert shared memory back to
 private on kexec
Message-ID: <20240603083754.GAZl2A4uXvVB5w4l9u@fat_crate.local>
References: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
 <20240602142303.3263551-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240602142303.3263551-1-kirill.shutemov@linux.intel.com>

On Sun, Jun 02, 2024 at 05:23:03PM +0300, Kirill A. Shutemov wrote:
> +			/*
> +			 * The only thing one can do at this point on failure
> +			 * is panic. It is reasonable to proceed.

It makes even less sense now: panic() means "all stops and we die" and
you say it is reasonable to proceed.

I'm confused.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

