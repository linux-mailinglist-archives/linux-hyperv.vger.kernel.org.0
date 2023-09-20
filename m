Return-Path: <linux-hyperv+bounces-124-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4B37A759E
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Sep 2023 10:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65F1281897
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Sep 2023 08:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0052F9F5;
	Wed, 20 Sep 2023 08:18:19 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CB9C8E0
	for <linux-hyperv@vger.kernel.org>; Wed, 20 Sep 2023 08:18:18 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29C4C6;
	Wed, 20 Sep 2023 01:18:16 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695197895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q8uz0fUswbzg4UfjUJDAWIyPtio4hXNctFhBDoWkw/I=;
	b=kE/H84Nol6C9LIOlDt6z28xGW+kuawtQTv4FXD6iVW+kmib/dyQry2HI8I77EmhgQxDLZN
	qEgTzgAv1sc4W8HrHuYKBXOEmd8iy0FrKPG0MFuz1/fda8E0rqXYkyIrrou5ubORAkaYRw
	p/nmM4quiOpVL9qhS6zLuMV3cIchMR6hkqbICxaE2zL+k7xlPk9j6ykjGGBeLVRZLYxq9d
	0yAWuJ54kFHbV4NDCNTZcx3eiPlzoAXMv/tX0K20Ws4eVdY8naRzGbrZMxHDQrwNOmAl0h
	eNDf8z882Z8cKy1r7YZcGyfp0iUOwDRibsCZp79oHbYnnohNl6oaYDjetCot7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695197895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q8uz0fUswbzg4UfjUJDAWIyPtio4hXNctFhBDoWkw/I=;
	b=mIUwG0wXtMRC39Lg+Y7W8a/xQn0/l7mkpzZwYbL3zGlQ4h/qPTWoa7xXLmtN9Dgsu0o4pK
	pbN9cV12I/qCJfAw==
To: "Li, Xin3" <xin3.li@intel.com>, "linux-doc@vger.kernel.org"
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
Subject: RE: [PATCH v10 36/38] x86/fred: Add fred_syscall_init()
In-Reply-To: <SA1PR11MB6734C02FFB973B2074EC6CC8A8F9A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-37-xin3.li@intel.com> <87v8c6woqo.ffs@tglx>
 <SA1PR11MB6734C02FFB973B2074EC6CC8A8F9A@SA1PR11MB6734.namprd11.prod.outlook.com>
Date: Wed, 20 Sep 2023 10:18:14 +0200
Message-ID: <87h6npuuk9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20 2023 at 04:33, Li, Xin3 wrote:
>> > +static inline void fred_syscall_init(void) {
>> > +	/*
>> > +	 * Per FRED spec 5.0, FRED uses the ring 3 FRED entrypoint for SYSCALL
>> > +	 * and SYSENTER, and ERETU is the only legit instruction to return to
>> > +	 * ring 3, as a result there is _no_ need to setup the SYSCALL and
>> > +	 * SYSENTER MSRs.
>> > +	 *
>> > +	 * Note, both sysexit and sysret cause #UD when FRED is enabled.
>> > +	 */
>> > +	wrmsrl(MSR_LSTAR, 0ULL);
>> > +	wrmsrl_cstar(0ULL);
>> 
>> That write is pointless. See the comment in wrmsrl_cstar().
>
> What I heard is that AMD is going to support FRED.
>
> Both LSTAR and CSTAR have no function when FRED is enabled, so maybe
> just do NOT write to them?

Right. If AMD needs to clear it then it's trivial enough to add a
wrmsrl_cstar(0) to it.

