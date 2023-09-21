Return-Path: <linux-hyperv+bounces-143-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E037A987D
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Sep 2023 19:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F23F28278B
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Sep 2023 17:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53786168BD;
	Thu, 21 Sep 2023 17:22:33 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B82168B4
	for <linux-hyperv@vger.kernel.org>; Thu, 21 Sep 2023 17:22:28 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BDB51018;
	Thu, 21 Sep 2023 10:15:29 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695290903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGuV725+A52UkxEuSgzeQeAhaGDz2ANft+qmFiacDG8=;
	b=Uc1XkSaloHBlxYQ1zN6hh9geAvtQDrA6rzrrOm0XEDhASCCuiOJd0ZUQDVk5pu7smVlZfM
	YcyVj5MIlW6dCw0gZAVps0Rws2yHAHtHT3yI0KmpTXMdgnz/3Z1IfNIMpPSXeG2C1xVIZa
	RVC8GvYWzw2wNPbssRcVWZprhIJD5GCzDZQZel4mnlA7NNIdTJN8FZXnfD5refPia6Z4Ep
	NvWaLlqsVp24Afci/BqY4B8bDTeZUFFOfG/ZbjsHOCaUcJSGcTEfuO29KH+o6OntuQsdt1
	Yeu0DTomo1WSKteeMcOT97KH0jVECo7ht6Xx698kxrEZHO2MRgqhLwxglLtcag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695290903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGuV725+A52UkxEuSgzeQeAhaGDz2ANft+qmFiacDG8=;
	b=YhxFLYB1hUEgCK9ZzqoixCOcdsJ9EkBa/RsLR3qBRdXVZTcXsEUrSFZvzIKcv5QclewR1g
	FaT5gQjP7YRGAsBA==
To: Nikolay Borisov <nik.borisov@suse.com>, Xin Li <xin3.li@intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, luto@kernel.org, pbonzini@redhat.com,
 seanjc@google.com, peterz@infradead.org, jgross@suse.com,
 ravi.v.shankar@intel.com, mhiramat@kernel.org, andrew.cooper3@citrix.com,
 jiangshanlai@gmail.com
Subject: Re: [PATCH v10 28/38] x86/fred: FRED entry/exit and dispatch code
In-Reply-To: <22921663-0e5e-58c0-c6c8-c45f991790ea@suse.com>
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-29-xin3.li@intel.com>
 <22921663-0e5e-58c0-c6c8-c45f991790ea@suse.com>
Date: Thu, 21 Sep 2023 12:08:23 +0200
Message-ID: <871qerj0tk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21 2023 at 12:48, Nikolay Borisov wrote:
> On 14.09.23 =D0=B3. 7:47 =D1=87., Xin Li wrote:
>> +
>> +	/* INT80 */
>> +	case IA32_SYSCALL_VECTOR:
>> +		if (likely(IS_ENABLED(CONFIG_IA32_EMULATION))) {
>
> Since future kernels will support boottime toggling of whether 32bit=20
> syscall interface should be enabled or not as per:
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=3Dx=
86/entry&id=3D1da5c9bc119d3a749b519596b93f9b2667e93c4a
>
> It will make more sense to replace this with ia32_enabled() invocation.=20
> I guess this could be done as a follow-up patch based on when this is=20
> merged as the ia32_enbaled changes are going to be merged in 6.7.

The simplest solution is to rebase the series to tip x86/entry and just
do it right away :)

