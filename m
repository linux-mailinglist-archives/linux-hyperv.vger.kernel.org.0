Return-Path: <linux-hyperv+bounces-154-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443D57AB44B
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 17:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 021F01C20908
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED871EA9A;
	Fri, 22 Sep 2023 15:00:08 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49F0171AA
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 15:00:06 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1CE196;
	Fri, 22 Sep 2023 08:00:04 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695394802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yymdn5Ib3vdedE1bKPjXhrIk07DP2toWMx0YBeOSCKc=;
	b=JCA+KUnb692VWlx1fmj161S4ivDwYTrM1u8X2p5arIqoauHvahJMRyQgJNnCijDhvdZTN5
	2vhPfci1iBhuF4Qy2zYMF8JGpNHrq0VAOBaIOZz4r3zSiAs1S0WjK2Y/a5ZLPZiRHiR72P
	REbPguOF78kSQmQ7J0MndgAQ5u9+VLIa/hw1U5uaXSml+++MgocMsUUHEo8yUUBhh55/dy
	QQw13O85IYkSyENm5eCNprEvBu0VGY6MYJBQev1Uj1n9rrZjN0zSSXrLOJq5WBnRYuLa3i
	/YCovSEvga/R0iW5oDIVClJYgWEFtXfzNaoHbWAAyTqcD536K6Nb5/nqacqCUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695394802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yymdn5Ib3vdedE1bKPjXhrIk07DP2toWMx0YBeOSCKc=;
	b=CIDz5h5BcX/Bz/jkuzgX2qYw3Xx+SDJYkCZCT8rgToE1CkxZkoLWZYWz8rraUAqGtvF28b
	64aTOX6aC7JwbuBQ==
To: "Li, Xin3" <xin3.li@intel.com>, "Li, Xin3" <xin3.li@intel.com>, Nikolay
 Borisov <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
 <linux-edac@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "Lutomirski, Andy" <luto@kernel.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "Christopherson,, Sean" <seanjc@google.com>,
 "peterz@infradead.org" <peterz@infradead.org>, "Gross, Jurgen"
 <jgross@suse.com>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 "mhiramat@kernel.org" <mhiramat@kernel.org>, "andrew.cooper3@citrix.com"
 <andrew.cooper3@citrix.com>, "jiangshanlai@gmail.com"
 <jiangshanlai@gmail.com>
Subject: RE: [PATCH v10 03/38] x86/msr: Add the WRMSRNS instruction support
In-Reply-To: <SA1PR11MB6734445986E951E686172419A8FFA@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-4-xin3.li@intel.com>
 <dda01248-f456-d8d7-5021-ef6b2e7ade2c@suse.com>
 <SA1PR11MB6734F205C2171425415E4F00A8F9A@SA1PR11MB6734.namprd11.prod.outlook.com>
 <SA1PR11MB6734445986E951E686172419A8FFA@SA1PR11MB6734.namprd11.prod.outlook.com>
Date: Fri, 22 Sep 2023 17:00:02 +0200
Message-ID: <87o7hugsnh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22 2023 at 08:16, Xin3 Li wrote:
>> > > +static __always_inline void __wrmsrns(u32 msr, u32 low, u32 high)
>> >
>> > Shouldn't this be named wrmsrns_safe since it has exception handling, similar
>> to
>> > the current wrmsrl_safe.
>> >
>> 
>> Both safe and unsafe versions have exception handling, while the safe
>> version returns an integer to its caller to indicate an exception did
>> happen or not.
>
> I notice there are several call sites using the safe version w/o
> checking the return value, should the unsafe version be a better
> choice in such cases?

Depends. The safe version does not emit a warning on fail. So if the
callsite truly does not care about the error it's fine.

