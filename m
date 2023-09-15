Return-Path: <linux-hyperv+bounces-81-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836F47A1233
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 02:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5831C20AA0
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 00:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04010190;
	Fri, 15 Sep 2023 00:12:35 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733607E
	for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 00:12:33 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD1D2102;
	Thu, 14 Sep 2023 17:12:32 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694736750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KgPRsgSrxVNlEOyySaa1PIQm8JulpVoZGkS4WiKzu2Y=;
	b=Opufk+gWG3Yw6wgO+kfqspHQ/VgFO8K0Ud/Qg7tynRke3PDBgtKU+a460kKb/93gIiUO5L
	bzEoLG4ayaBS8fTrf6QlAolsiu8ly3FxA9C9EAuo7MZTffVz9n1bf7nSCIpvbZSVmXDYVW
	acMz0Jonv3RJ94KgCGiuk2sXBFifOrs6HKWprtunsu+B0FOomTyOogxJ0p7Ixnvh4aziKu
	tLsnvnhq16s2s3UxE26tnjrlvcrBGMLvc4cZsMLWD5evy/Gj658BwlQoIdcEyATUJU76k8
	bO2+R+GllHweAzkZON5NLUw8Xa8uqPVH57q4oEFbEYqLFZJkCnw//4Xc6xac6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694736750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KgPRsgSrxVNlEOyySaa1PIQm8JulpVoZGkS4WiKzu2Y=;
	b=LCuwmEnex0B5wafWqEhRbYoFiiceeuNdckfK2gNVmqyd/yygxlcSv5V67wVBfndBTx2X5k
	Wq/zjvIpWJ6zjYDg==
To: andrew.cooper3@citrix.com, Xin Li <xin3.li@intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, luto@kernel.org, pbonzini@redhat.com,
 seanjc@google.com, peterz@infradead.org, jgross@suse.com,
 ravi.v.shankar@intel.com, mhiramat@kernel.org, jiangshanlai@gmail.com
Subject: Re: [PATCH v10 03/38] x86/msr: Add the WRMSRNS instruction support
In-Reply-To: <7ba4ae3e-f75d-66a8-7669-b6eb17c1aa1c@citrix.com>
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-4-xin3.li@intel.com>
 <6f5678ff-f8b1-9ada-c8c7-f32cfb77263a@citrix.com> <87y1h81ht4.ffs@tglx>
 <7ba4ae3e-f75d-66a8-7669-b6eb17c1aa1c@citrix.com>
Date: Fri, 15 Sep 2023 02:12:29 +0200
Message-ID: <87v8cc1ehe.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 15 2023 at 00:46, andrew wrote:
> On 15/09/2023 12:00 am, Thomas Gleixner wrote:
>> So no. I'm fundamentally disagreeing with your recommendation. The way
>> forward is:
>>
>>   1) Provide the native variant for wrmsrns(), i.e. rename the proposed
>>      wrmsrns() to native_wrmsr_ns() and have the X86_FEATURE_WRMSRNS
>>      safety net as you pointed out.
>>
>>      That function can be used in code which is guaranteed to be not
>>      affected by the PV_XXL madness.
>>
>>   2) Come up with a sensible solution for the PV_XXL horrorshow
>>
>>   3) Implement a sane general variant of wrmsr_ns() which handles
>>      both X86_FEATURE_WRMSRNS and X86_MISFEATURE_PV_XXL
>>
>>   4) Convert other code which benefits from the non-serializing variant
>>      to wrmsr_ns()
>
> Well - point 1 is mostly work that needs reverting as part of completing
> point 3, and point 2 clearly needs doing irrespective of anything else.

No. #1 has a value on its own independent of the general variant in #3.

>>      That function can be used in code which is guaranteed to be not
>>      affected by the PV_XXL madness.

That makes a lot of sense because it's guaranteed to generate better
code than whatever we come up with for the PV_XXL nonsense.

Thanks,

        tglx

