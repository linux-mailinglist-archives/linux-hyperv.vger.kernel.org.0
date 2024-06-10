Return-Path: <linux-hyperv+bounces-2372-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572749022C8
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jun 2024 15:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B121C21A23
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jun 2024 13:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BE9824BB;
	Mon, 10 Jun 2024 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RAgqE/J7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1D07CF18;
	Mon, 10 Jun 2024 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718026861; cv=none; b=aNSKbtiZvuyeUK7gYLB3Nv049WNvqXdfu3uIQajLLXqyfpv5k2TtUTFPnrjAk984wB2uUUBzgr/0wUtpuTLkOT+kZtBAr1/Gl7qZw1a3VGr91fbI7tR5FOFeXqLYoPzdsO28QIOZpkpeevV7jigjCr7zIoT7+19gpahqLfzL/vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718026861; c=relaxed/simple;
	bh=JuxtQK8wJ8d18l/WXYXjUxW+m/Hl3f1aDqb0jspQ4Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObQxXIlt/u99lzzediHZLrf+g0H/yf+ASOQo99R7RiSkbq2ftfbzsTk7EkoNWgJlKcxmOyo9OOQIxP2YhKLKHAy2gTe7oxGkBs0KULV3qk0hSKSLJBB4UUPaVCiJ+h9WoRti7xeHIOJgHVR+oBy8JqLhw86NiKF4RYc86m+KN3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RAgqE/J7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9026440E0027;
	Mon, 10 Jun 2024 13:40:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BUFwCUSrFD-r; Mon, 10 Jun 2024 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718026853; bh=TKZL5OH/kDVlLa031KsOxyH44GZqkwpf2xf/NrcUB1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAgqE/J7Ok93ksM7RtpCaB8UMngdFS25e57JRb50u3sKy2aXLEYs7ZIJdXRh7770b
	 8tJ38vJJfmF+2lks4s0Kk3L/O+E7DpVBgirqSTwXmN3Cg7h7aT+WJYcRwIREzYTXSA
	 mGbgyz1EAd+LdfCkO2rOre+Yh6CX9BLqgetnFzrQIPY0kIICIb66Q4u09EhKZMSTDG
	 whB4l+lf1iWiRuB9BudtYv0l0x1J3FTCg7jIOIJJzqT5+NNZFZfYj/vbMf/Hry6HfV
	 HLWaqUrB6VrKkNKzVnyQ4pBboypnsi9vczV76jjy92uNm+0gNXz9tI1tm8f4Ke5gJB
	 b1cq0aTjHTOGxqbRJ5L7votIQoLRGdmrLnbyqVRT4NiziZA7kWChfTowkyg1YHQoML
	 JDUghCIg2Uq3ihZyMHw8FccJb4I5I6GjkK5d9RUkEc96pPkoRqgZZkKiPRAGAlbtBc
	 q2BzF8SqutNpMl2dbt6IUyNL09xMU+gAOx8Ye8U6g7A9OzNIgh0BYlG/LHBrg8ZXIG
	 ZKyF/y73C3djtMnu47EvtxsSp+VwqSmHw73qy20s/VpKX2vv85A0fw/gXMJtG9pegE
	 ex9NTXqzBQRFZyChjWvcJGcOPhpsYz+xR0FfBItTSftmPtuGCU4zCERIzXImhReePM
	 BIhyBxa03PlP5oHNxuJxtal8=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0E4FB40E0081;
	Mon, 10 Jun 2024 13:40:26 +0000 (UTC)
Date: Mon, 10 Jun 2024 15:40:20 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 18/19] x86/acpi: Add support for CPU offlining for
 ACPI MADT wakeup method
Message-ID: <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
 <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
 <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>

On Fri, Jun 07, 2024 at 06:14:28PM +0300, Kirill A. Shutemov wrote:
>   I was able to address this issue by switching cpa_lock to a mutex.
>   However, this solution will only work if the callers for set_memory
>   interfaces are not called from an atomic context. I need to verify if
>   this is the case.

Dunno, I'd be nervous about this. Althouth from looking at

   ad5ca55f6bdb ("x86, cpa: srlz cpa(), global flush tlb after splitting big page and before doing cpa")

I don't see how "So that we don't allow any other cpu" can't be done
with a mutex. Perhaps the set_memory* interfaces should be usable in as
many contexts as possible.

Have you run this with lockdep enabled?

> - The function __flush_tlb_all() in kernel_(un)map_pages_in_pgd() must be
>   called with preemption disabled. Once again, I am unsure why this has
>   not caused issues in the EFI case.

It could be because EFI does all that setup on the BSP only before the
others have arrived but I don't remember anymore... It is more than
a decade ago when I did this...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

