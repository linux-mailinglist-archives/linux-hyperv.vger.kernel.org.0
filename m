Return-Path: <linux-hyperv+bounces-2269-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80FE8D68B1
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 May 2024 20:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4A228773C
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 May 2024 18:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D1216EC13;
	Fri, 31 May 2024 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FxR+oEX2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C057BB01;
	Fri, 31 May 2024 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178807; cv=none; b=pt2mDCBvJVM62u0+IUvJbtX/f47omBx1mIq7nJdv+1VQfuzMw5stx5oenndjEXPj+Nx6a25j3DBu1J5lDBOMXEP6MAqiXjjeVGEKYSaYHTZ7wc2nyFsDEwApAh4r2Y28n7WyhXMVO8pkBA4Nokl6ss7ffr1KJUcIKLRUTpILYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178807; c=relaxed/simple;
	bh=VWCDVEqpi15SHunGQViPjo+WwhIMz+rFMlZ3zNVC0rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxvnZZiUl/t38/KBxAOR2q5lFU2eQZjOZQ2V3MzyGP2BiD82YoXrsw0DbXB4I3SpUohwmiPAkqYkQ4w3Fkbz9TuNL3Cx/5tX2nzlBJgHI8tUdM7TzBNs7vr/MPKIPDVx8es+10bCvshwz09B9Ww7QzOpxdJbgQhNcO6cFR5LsQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FxR+oEX2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EE39040E02B2;
	Fri, 31 May 2024 18:06:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m6MIu8_PAQTt; Fri, 31 May 2024 18:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717178796; bh=A27r4FWltFYQLEwV274qXhTGvbQe8LtfwbJef5gbm3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxR+oEX2YaMrYOfacRiEJfU04L3Q36UzDdt4OclAKTWGprF3XaaHfqd2kdpUnuJtY
	 UR6zJT7Hu2gg+RU3VJntQmg2tDHvtd6BliJI5+ro0iJYe74T4AoJP1bCA7zjdu9akg
	 L7GAMxdO7bE3FYyjwOAJ0fH3xUoXW3I6wkq3gkAzXc8w6N6205NccyQ/M0fRmmnyXJ
	 jj3nO/s0GyYlKl0Dq889EPpdXJmMhIYuNiG4R3AY32tvhnu9cyBQniz1k2sEOnEcnv
	 myEaiUAc9APw/VOwvFk7ghtryNB2C/zBxjS4lFenHBncAh+cIOdRJ3HJC6xdrRW4BO
	 fl1Mdv4vQdjYcNi9lCW5vaAzhHKte8kyhqRIMKax6gDoKsiVe3uvMG/EfaYeVlvaJZ
	 /Y4sjViJ+7UuWSv0p7RMu29slFoB7h3GaY3iOJQSu6F2lIGb0JHPGJncv4dhPgkL1u
	 FwuXH6HE8oQlpns540LGY2kEPYbx0qpwWb0b+YIh6CN3uNVvRnV4np0d3fA99EZ3m9
	 r7jhw5jXFlW3b4QVVzr1gu6x9LFnfLBXPz/3dhadvh1M6kMToWuQYDrn163BFZFOpc
	 oo9Xa67Z6ESrSd+rmNYcKwbMV59zk0nGZyqBQBghH1dCpFqU6FbHThjGrH4dudhQBD
	 DKs+NDxUxb0GqFLMSbaHN5HU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FA1740E02B7;
	Fri, 31 May 2024 18:06:09 +0000 (UTC)
Date: Fri, 31 May 2024 20:06:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 11/19] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <20240531180602.GIZloRisrPdjLhaVBG@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-12-kirill.shutemov@linux.intel.com>
 <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
 <75cb309b-b05c-42a0-a3ca-de08fa1cae59@amd.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75cb309b-b05c-42a0-a3ca-de08fa1cae59@amd.com>

On Fri, May 31, 2024 at 12:34:49PM -0500, Kalra, Ashish wrote:
> SNP guest kexec patches are based on top of this patch-series and SNP guests
> also need this exclusive mem_enc_lock protection, so CC_ATTR_MEM_ENCRYPT
> makes sense to be used here.

Well, for the future, I'd encourage you to always send an Acked-by: you
or Reviewed-by: you as a reply to such patches so that it is clear that
such a change is desired.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

