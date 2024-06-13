Return-Path: <linux-hyperv+bounces-2411-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2D79075D7
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jun 2024 16:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60761F24E91
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jun 2024 14:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57566148848;
	Thu, 13 Jun 2024 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ja3zVbuE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747F14883C;
	Thu, 13 Jun 2024 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290646; cv=none; b=GytmrOLUwwZF460L7F0JMRj/T89RyM2rIMP83uf4fkmyX3EsZzMVdGRFdFG7qxEkG8TzTD5K/DOJY3witxcHHrJH595Xbc6fobYPDuJquuoq4bal6VjoskrRvWMToclg8Pzu5kW0Wi2Zd4Rf6pX8TRpZ90bHVNJf/krcYhO8Utk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290646; c=relaxed/simple;
	bh=nGI5SQtPbmjFzz0oS2g0Vv0q9MObkyinZcCMmyUMgc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh26RsvfRPL+SrXga36708VA17mccW5gd+F5Pq3skatVx/v55HSoq2MYu85mVZHrMXnmBvg/pclW6IapnTOyXas5lPF5LsSRSRQXH+VmdeaE84FXhHZbPaypk0cBxVbe0y9i9CpreP7PwTd1O2mt040NogFYc+zilw+csosbARo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ja3zVbuE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 371AB40E00C9;
	Thu, 13 Jun 2024 14:57:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VxFUwAUY_gPk; Thu, 13 Jun 2024 14:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718290629; bh=4PpkPfFOmQteTZnPUEGfiyHPxl3RB0xgm8bItFqnfk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ja3zVbuEKXRUlqooI8H7OOrG10geSsCj9PBH5w2Id4s1ieQGglEfA7XJoKDFTF9JX
	 epVhd/OSmSar4OcKkNykGLcf6rMfDeLqA2tharfM0zkRXHajeBWf4w7K+StiHBaYy+
	 UmDqQGt6Gj6JW1RRmZEYjjYb9ugcch3i4wkay5YCl94poFAL1newXDTzG4cEGkoLWv
	 NFTAg/aE+yDOGGuge2S6Ph8C9MIGPr1cm1iHz/TOedm1P4nH3dzgcwu7Oq6QCyNBwk
	 QYqYkNMfTqbbiiMnckCwDq3Z5e6kt+LlkdDk1O4x9qCwldl17tWmfZ2BUKjgNxXRbB
	 2/ckNhH1LU+HhGZC8VmO3+KkBDwJ8D7mUE2I63WKZGNOlnQdQt1ZalHutsPPm9fnfa
	 iiRJCFaTfi8wE5Zdz7IPFHXJpdKwMeCYplQvoz0iM+RgxPC9lN1fMVR9b3Ih9nGfd2
	 tHvDFD2YFDfqZ4+ljm6uk/Z4rpLfmpRIevGB+ZBZS5tJ12HYHcKp+jttN8SVc+N/uO
	 lNQqFpWTSFrXj2kUWtXUw/aAhSIR0kw7wNt9hBDphnTPZeQDgkW48SqxzTM10A7j0b
	 yquOA/Sp4tsEXR60IN3GhEe0pX6itv6tdbmM/O81pLhEwP+hGqkFA2xUtwPTWTTM8k
	 x1TfveMz3kITMZ845FfSr1YE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC90040E0031;
	Thu, 13 Jun 2024 14:56:41 +0000 (UTC)
Date: Thu, 13 Jun 2024 16:56:36 +0200
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
Message-ID: <20240613145636.GGZmsIpHn16R04QlaN@fat_crate.local>
References: <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
 <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
 <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
 <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
 <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>
 <nh7cihzlsjtoddtec6m62biqdn62k3ka5svs6m64qekhpebu5z@dkplwad2urgp>
 <20240611194653.GGZmiprSNzK0JSJL17@fat_crate.local>
 <2kc27uzrsvpevtvos2harqj3bgfkizi5dhhxkigswlylpnogr5@lk6fi2okv53i>
 <20240612092943.GCZmlqh7O662JB-yGu@fat_crate.local>
 <w6ohbffl5wwmralg255ec7nozxksge4z4nnkmwncthxzhuv46d@qq46r2wrjlog>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w6ohbffl5wwmralg255ec7nozxksge4z4nnkmwncthxzhuv46d@qq46r2wrjlog>

On Thu, Jun 13, 2024 at 04:41:00PM +0300, Kirill A. Shutemov wrote:
> It is easy enough to do. See the patch below.

Thanks, will have a look.

> But I am not sure if I can justify it properly. If someone doesn't really
> need 5-level paging, disabling it at compile-time would save ~34K of
> kernel code with the configuration.
> 
> Is it worth saving ~100 lines of code?

Well, it goes both ways: is it worth saving ~34K kernel text and for that make
the code a lot less conditional, more readable, contain less ugly ifdeffery,
...?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

