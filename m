Return-Path: <linux-hyperv+bounces-11711-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wNDXDQ8mRGoNpgoAu9opvQ
	(envelope-from <linux-hyperv+bounces-11711-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2026 22:24:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D115B6E7C9A
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2026 22:24:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=zytor.com header.s=2026062701 header.b=K5lFI3Zq;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11711-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11711-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=zytor.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EB3C3035EE6
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2026 20:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD70478E53;
	Tue, 30 Jun 2026 20:24:44 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6DD47887A;
	Tue, 30 Jun 2026 20:24:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851084; cv=none; b=mK9HGYVl0eaAGcYURX+8clQ7rxB24mkSrmM1fgZ5JaUPomCZ6Tv1ONHO22Ldr+DKfBLyLl/FDuBJm7uMIAdNRpcD3ZL8FzpDPWt1xvnSi3LuiatPTGb6m8LZoR1EhixK4VPk51ZmYLq+K40m1qrSM685+jXXmyHlMFyWCOA8zco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851084; c=relaxed/simple;
	bh=lvnSDXwnO2IamEnDSVp9Sr31rByjrt2f9gYfHAIvtUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlSAlkFRxFow8ZVhUjnE8VZbPacHYiyC5FmqRtpFlgEBQOF249CIyNGQMgMZm+mdFvICDK+gvSkzaN7i52a2O80KKilhLtxvFrTEjbUsXrza9JdjeO+hmSaa9OIhKUaDTLgVe9WMXRBB1IAKyMNuiLNPxEPYrRi15ji0NEbz+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=K5lFI3Zq; arc=none smtp.client-ip=198.137.202.136
Received: from [IPV6:2601:646:8081:7da1:c71f:dfcf:59c7:993c] ([IPv6:2601:646:8081:7da1:c71f:dfcf:59c7:993c])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 65UK6ofd3661806
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 30 Jun 2026 13:06:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 65UK6ofd3661806
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782850020;
	bh=i2G6UAafySOmb8rY0Of+scGPJBnbme4rl6a4zKkZXos=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K5lFI3Zq4F/mIozRU6/PLoKoYWvuV/6E6cXfs0gd3x7InpQddwy7n7lCqU9zTol6p
	 iERjS1DYHe87ViLOQDzm87qe53A2nTT739eUJgh3GED1sB/6THV4FmbnfKfjF+gZM6
	 V3hs8AlxsrgKHqVEonk0hhP6kKL9gYgNa+4EuHtRIhIHX/70mvzshRnY18tWCCdI5w
	 Ll1EMcK2sxp8iMYsZYSnfeyWpSYeZ1t3FhRicQwouhz9KMqYRLpgCuNpQxbhJ9r8I9
	 ZsFBJMIoIbws3i0Y3H2zHi5XFwogldA2J2JWZnvAJa/cf38a+7JjgFWPQpcUApHU2I
	 YRs6tPbYTSHfg==
Message-ID: <ccd35c56-08ac-46b1-9c76-2554d5a234a9@zytor.com>
Date: Tue, 30 Jun 2026 13:06:44 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/32] x86/msr: Drop 32-bit MSR interfaces
To: Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        x86@kernel.org, linux-acpi@vger.kernel.org, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
        virtualization@lists.linux.dev, linux-ide@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-mtd@lists.infradead.org,
        platform-driver-x86@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
        Jason Baron
 <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini
 <pbonzini@redhat.com>,
        "Kirill A. Shutemov" <kas@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, Pu Wen <puwen@hygon.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ajay Kaher <ajay.kaher@broadcom.com>,
        Alexey Makhalov <alexey.makhalov@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Dave Airlie <airlied@redhat.com>, Helge Deller <deller@gmx.de>,
        linux-geode@lists.infradead.org, Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark
 <james.clark@linaro.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Huang Rui <ray.huang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <perry.yuan@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ashok Raj <ashok.raj.linux@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>, xen-devel@lists.xenproject.org
References: <20260629060526.3638272-1-jgross@suse.com>
 <d7c1db52-529a-43cc-ac7d-38b52627e8bc@app.fastmail.com>
 <c1608c48-13c2-4290-826b-28b5ca51eaf7@suse.com>
 <7332feff-2649-496c-8e49-b0a19eb54a32@app.fastmail.com>
 <9acced19-573d-4923-9329-8be408d2e555@suse.com>
 <d315e0a8-e4e9-4f7e-80a9-7c236849eabd@app.fastmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <d315e0a8-e4e9-4f7e-80a9-7c236849eabd@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026062701];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11711-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:arnd@arndb.de,m:jgross@suse.com,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-edac@vger.kernel.org,m:x86@kernel.org,m:linux-acpi@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-pci@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-ide@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fbdev@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-hwmon@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:platform-driver-x86@vger.kernel.org,m:rafael@kernel.org,m:daniel.lezcano@kernel.org,m:rui.zhang@intel.com,m:lukasz.luba@arm.com,m:jbaron@akamai.com,m:bp@alien8.de,m:tony.luck@intel.com,m:yazen.ghannam@amd.com,m:lenb@kernel.org,m:pavel@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:seanjc@google.com,m:pbonzini@redhat.com,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:puwen@hyg
 on.cn,m:bhelgaas@google.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:viresh.kumar@linaro.org,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:TonyWWang-oc@zhaoxin.com,m:dlemoal@kernel.org,m:cassel@kernel.org,m:airlied@redhat.com,m:deller@gmx.de,m:linux-geode@lists.infradead.org,m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:linusw@kernel.org,m:brgl@kernel.org,m:gregkh@linuxfoundation.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux@roeck-us.net,m:peterz@infradead.org,m:acme@kernel.org,m:namhyung@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:james.clark@linaro.org,m:jpoimboe@kernel.org,m:pawan.kumar.gupta@linux.intel.com,m:vkuznets@redhat.com,m:luto@kernel.org,m:boris.ostrovsky@oracle.com,m:ray.huang@amd.com,m:m
 ario.limonciello@amd.com,m:perry.yuan@amd.com,m:kprateek.nayak@amd.com,m:srinivas.pandruvada@linux.intel.com,m:artem.bityutskiy@linux.intel.com,m:dedekind1@gmail.com,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:ashok.raj.linux@gmail.com,m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:irenic.rajneesh@gmail.com,m:david.e.box@intel.com,m:xen-devel@lists.xenproject.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,arm.com,akamai.com,alien8.de,amd.com,redhat.com,linux.intel.com,google.com,hygon.cn,broadcom.com,linaro.org,zhaoxin.com,gmx.de,lists.infradead.org,selenic.com,gondor.apana.org.au,linuxfoundation.org,microsoft.com,roeck-us.net,infradead.org,oracle.com,gmail.com,bootlin.com,nod.at,ti.com,lists.xenproject.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[hpa@zytor.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[95];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[zytor.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,zytor.com:dkim,zytor.com:mid,zytor.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D115B6E7C9A

On 2026-06-29 01:38, Arnd Bergmann wrote:
>>
>> There is no RDMSRQ instruction on any x86 CPU. Are you mixing this up with
>> WRMSRNS/RDMSR using an immediate for addressing the MSR?
> 
> Yes, I was just confused about the exact definition here and assumed
> the single-register output version was actually called rdmsrq.
> 
So just to be clear:

There are three instructions(*):

	wrmsr		- implicit form only
	wrmsrns		- implicit or immediate
	rdmsr		- implicit or immediate

The implicit form are the same on 32 and 64 bits (and, in fact, 16 bits): they
take a MSR register address in %ecx and the data as two 32-bit words in
%edx:%eax. This interface predates x86-64 by about a decade, and the Linux MSR
interfaces were designed when Linux was 32-bit only, so it made sense at the
time to treat them as two halves, especially since MSRs often are various
kinds of bitfields. It didn't help that gcc at the time was extremely
inefficient in its handling of multiword arithmetic (it is much better now),
so using a u64 would have made for much worse code.

The immediate forms are 64-bit only and use a single arbitrary 64-bit
register; the MSR address is kept in an immediate in the instruction, just
like they are for most other register types. The only thing that is "special"
there is that the possible register address space is very large (2^32)
although in practice a very small fraction of that is (currently) used.

The immediate forms are expected to be faster, and provide for further
performance improvements in future microarchitectures. This is important,
because it provides a fine-grain uniform architecture for supervisor-only
state, instead of having to give a bulk ISA (XSAVES/XRSTORS) that is different
from the fine-grained architecture, and still get good performance. This gives
the kernel very fine level control over the context switch flows, for one thing.

WRMSRNS is a non-serializing form of WRMSR, which is defined as an
architecturally hard-serializing instruction, although some MSRs have been
retconned as non-serializing (and the set is different between vendors.) We
want to switch that over to the model where the kernel explicitly opts in to
nonserialization, but that means using alternatives since not all CPUs have
the WRMSRNS instruction.

Furthermore, we want to use alternatives so we can make use of the
immediate-format instructions when the MSR address is known at compile time,
which it is in *nearly* all cases. If we are smart about it we can also use
this to let the tracing framework be specific about what MSRs to trace, since
some MSRs are frequently accessed, but many are set at startup and then
rarely, if ever, touched.


(*) There are actually two more instructions:

	RDMSRLIST
	WRMSRLIST

... which are bulk versions of RDMSR and WRMSRNS respectively. They can be
useful to save and restore entire groups of MSRs in one shot, such as
performance counter configurations. By architecturally allowing the memory
operations and MSR operations to operate asynchronously, they give some of the
pipeline benefits of the immediate MSR operations without requiring the MSR
set to have been set at compile time or code to be dynamically generated.

However, they expose an entirely different programming model, whereas the
immediate- and -NS instruction choices can be entirely hidden at the C level.


