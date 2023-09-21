Return-Path: <linux-hyperv+bounces-137-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5717A90E0
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Sep 2023 04:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16CD81C20805
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Sep 2023 02:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0F617C2;
	Thu, 21 Sep 2023 02:25:53 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737215A4
	for <linux-hyperv@vger.kernel.org>; Thu, 21 Sep 2023 02:25:51 +0000 (UTC)
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB2BD3;
	Wed, 20 Sep 2023 19:25:49 -0700 (PDT)
Received: from [127.0.0.1] ([98.35.210.218])
	(authenticated bits=0)
	by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 38L2Ojrq2878666
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 20 Sep 2023 19:24:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 38L2Ojrq2878666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023091101; t=1695263088;
	bh=WciaewRbFVCG7f/TWCqOhh4NlX/euw7ehl3BKDv4D2s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Ljqz95c2+2ctrUrqDTYh4QJqwX6aq8mwwAySkJYOLB/rmPNr+SnxWAYlU/KQSCT5Y
	 tz1ezsYWqK0Q4cbXNch6WmSJ06yICbg3IW6efg/D3UscvInNuY+tdrl12AD0aOeABS
	 jJnQKYPibz2ODD7CuZvST50wrsGNzOQdvKs4ffKVf6+Dzir4Me4tyjJ9yIDffI8iep
	 PiaHLNeUMu9OkEdAJ0K0iskn+vI9N9gg/LhElcG3QQu2b49nd1vPLUf+lmlguTs+9v
	 aCY/LfiHWkB5ORkGwlNjhb+7FcMKMnOnZzBWQVPbPpuDO2ZZDvqBIwYYvhyazgjB9h
	 NhSAU3+MJhZIw==
Date: Wed, 20 Sep 2023 19:24:43 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Thomas Gleixner <tglx@linutronix.de>, "Li, Xin3" <xin3.li@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
CC: "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>
Subject: RE: [PATCH v10 36/38] x86/fred: Add fred_syscall_init()
User-Agent: K-9 Mail for Android
In-Reply-To: <87h6npuuk9.ffs@tglx>
References: <20230914044805.301390-1-xin3.li@intel.com> <20230914044805.301390-37-xin3.li@intel.com> <87v8c6woqo.ffs@tglx> <SA1PR11MB6734C02FFB973B2074EC6CC8A8F9A@SA1PR11MB6734.namprd11.prod.outlook.com> <87h6npuuk9.ffs@tglx>
Message-ID: <4578F690-1501-46C3-9048-5AED97EAD001@zytor.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On September 20, 2023 1:18:14 AM PDT, Thomas Gleixner <tglx@linutronix=2Ede=
> wrote:
>On Wed, Sep 20 2023 at 04:33, Li, Xin3 wrote:
>>> > +static inline void fred_syscall_init(void) {
>>> > +	/*
>>> > +	 * Per FRED spec 5=2E0, FRED uses the ring 3 FRED entrypoint for S=
YSCALL
>>> > +	 * and SYSENTER, and ERETU is the only legit instruction to return=
 to
>>> > +	 * ring 3, as a result there is _no_ need to setup the SYSCALL and
>>> > +	 * SYSENTER MSRs=2E
>>> > +	 *
>>> > +	 * Note, both sysexit and sysret cause #UD when FRED is enabled=2E
>>> > +	 */
>>> > +	wrmsrl(MSR_LSTAR, 0ULL);
>>> > +	wrmsrl_cstar(0ULL);
>>>=20
>>> That write is pointless=2E See the comment in wrmsrl_cstar()=2E
>>
>> What I heard is that AMD is going to support FRED=2E
>>
>> Both LSTAR and CSTAR have no function when FRED is enabled, so maybe
>> just do NOT write to them?
>
>Right=2E If AMD needs to clear it then it's trivial enough to add a
>wrmsrl_cstar(0) to it=2E

Just to clarify: the only reason I added the writes here was to possibly m=
ake bugs easier to track down=2E There is indeed no functional reason=2E

