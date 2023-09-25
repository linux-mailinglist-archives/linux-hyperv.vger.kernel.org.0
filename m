Return-Path: <linux-hyperv+bounces-272-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B997ADF54
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Sep 2023 20:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 753971F24C1D
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Sep 2023 18:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1435224C6;
	Mon, 25 Sep 2023 18:56:42 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1CF1C29A
	for <linux-hyperv@vger.kernel.org>; Mon, 25 Sep 2023 18:56:40 +0000 (UTC)
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43A3B3;
	Mon, 25 Sep 2023 11:56:39 -0700 (PDT)
Received: from [127.0.0.1] ([98.35.210.218])
	(authenticated bits=0)
	by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 38PItrU61594472
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 25 Sep 2023 11:55:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 38PItrU61594472
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023091101; t=1695668155;
	bh=+Wk81MPh67CoIuv1N5UsWm+ABYR52enaoMH5X3S/E48=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=U9AXizoIZ2cgdmQqbEb/gMZHT1paPtcyR4HTtYsA4abVlRgQNaDJo3Xs5rSVjuTYL
	 4PGq94Op6XVwbf0cbOD82XobVAPbL5L31ZWCHS3a3X4RI6/Br1wZUcjU9wJcisiGsL
	 R76oVPfn+eh04Mz+CBo3TCnCPT9uq/nzM81rqtqcQ2XeSKfnFkez/TmST6HZikGxGA
	 PsrWR9jA/RsQgk/uTSShBKZg38lMORnnCn0m4eroue4/Wyn4Q9kDL7dOaZvODeOcM9
	 YkqKBwdY/pmfScNcBV8sBi6RmZz2+eUmwpiqblpLrGBAJsC+E3hM6GPrV4rDvbgLWW
	 ZuOnGMLj15MXA==
Date: Mon, 25 Sep 2023 11:55:50 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Li, Xin3" <xin3.li@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
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
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_v11_35/37=5D_x86/syscall=3A_Split_ID?= =?US-ASCII?Q?T_syscall_setup_code_into_idt=5Fsyscall=5Finit=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <SA1PR11MB673481413BA6522B01218297A8FCA@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230923094212.26520-1-xin3.li@intel.com> <20230923094212.26520-36-xin3.li@intel.com> <D4167CD5-B619-448D-B660-24ABC0786E0A@zytor.com> <SA1PR11MB673481413BA6522B01218297A8FCA@SA1PR11MB6734.namprd11.prod.outlook.com>
Message-ID: <69867C92-3A02-469A-9B77-2E202A4D4A0F@zytor.com>
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
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On September 25, 2023 10:56:44 AM PDT, "Li, Xin3" <xin3=2Eli@intel=2Ecom> w=
rote:
>> >diff --git a/arch/x86/kernel/cpu/common=2Ec
>> >b/arch/x86/kernel/cpu/common=2Ec index 20bbedbf6dcb=2E=2E2ee4e7b597a3 =
100644
>> >--- a/arch/x86/kernel/cpu/common=2Ec
>> >+++ b/arch/x86/kernel/cpu/common=2Ec
>> >@@ -2071,10 +2071,8 @@ static void wrmsrl_cstar(unsigned long val)
>> > 		wrmsrl(MSR_CSTAR, val);
>> > }
>> >
>> >-/* May not be marked __init: used by software suspend */ -void
>> >syscall_init(void)
>> >+static inline void idt_syscall_init(void)
>> > {
>> >-	wrmsr(MSR_STAR, 0, (__USER32_CS << 16) | __KERNEL_CS);
>> > 	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
>> >
>> > 	if (ia32_enabled()) {
>> >@@ -2108,6 +2106,15 @@ void syscall_init(void)
>> > 	       X86_EFLAGS_AC|X86_EFLAGS_ID);
>> > }
>> >
>> >+/* May not be marked __init: used by software suspend */ void
>> >+syscall_init(void) {
>> >+	/* The default user and kernel segments */
>> >+	wrmsr(MSR_STAR, 0, (__USER32_CS << 16) | __KERNEL_CS);
>> >+
>> >+	idt_syscall_init();
>> >+}
>> >+
>> > #else	/* CONFIG_X86_64 */
>> >
>> > #ifdef CONFIG_STACKPROTECTOR
>>=20
>> Am I missing something, or is this patch a noop?
>
>Yes, this is a noop, just a cleanup patch w/o functionality change=2E
>
>

It just seems to be completely redundant=2E We can just drop it, no? If we=
 aren't going to explicitly clobber the registers there is no harm in setti=
ng them up for IDT unconditionally=2E

