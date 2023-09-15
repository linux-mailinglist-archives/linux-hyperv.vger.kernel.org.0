Return-Path: <linux-hyperv+bounces-86-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3745C7A12C6
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 03:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39142821B5
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 01:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1EE380;
	Fri, 15 Sep 2023 01:07:13 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C836A
	for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 01:07:11 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319D01FE8;
	Thu, 14 Sep 2023 18:07:11 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694740029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cRPJbRPbpPyl0DIKbunWuB6+IYtaMtGVInY/dfsbq0=;
	b=YUWamJ5Utp3OQKs0c96zn7z7qwtq5o7oz8CSYdDscALYnuLUGz8SVTh1fz7twIzwmSpsjE
	vsB7w4hBDv0GFnE1NN3xIKfUwohwgKJpgAgZtmggKQQqDjhO+FNlFRQL/GB+Kh6EPdNzpk
	zRoYVcfu1QT7x79DLIjnLloBqPeETIiVgYs2saYJniSZNoOL1AkKr2CHD3knl35LxG/dAt
	vl6bKdoPy0wCFCYinek/JPK3YjMQeQzqL0G4ogM7a0qh4LFhznuacNFS7LjyPTQFfrPXf8
	6OJcRCfY0/JSCSl7MingVERa+6SpAnCJXhzq6Sz5oSfPHvpIl+lN69R9ABcy8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694740029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cRPJbRPbpPyl0DIKbunWuB6+IYtaMtGVInY/dfsbq0=;
	b=YgXAAcfI7PqVQfPd3GS4BbveJ65cq2aLT9IHq5xExXqf946ewsDrQfSvPRljDdyjnuMZ8G
	TM8nzdItAHQpybAg==
To: andrew.cooper3@citrix.com, Jan Beulich <jbeulich@suse.com>, Juergen
 Gross <jgross@suse.com>
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, luto@kernel.org, pbonzini@redhat.com,
 seanjc@google.com, peterz@infradead.org, ravi.v.shankar@intel.com,
 mhiramat@kernel.org, jiangshanlai@gmail.com, Xin Li <xin3.li@intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v10 08/38] x86/cpufeatures: Add the cpu feature bit for
 FRED
In-Reply-To: <7d907488-d626-0801-3d4b-af42d00a5537@citrix.com>
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-9-xin3.li@intel.com>
 <d98a362d-d806-4458-9473-be5bea254db7@suse.com>
 <77ca8680-02e2-cdaa-a919-61058e2d5245@suse.com>
 <7d907488-d626-0801-3d4b-af42d00a5537@citrix.com>
Date: Fri, 15 Sep 2023 03:07:09 +0200
Message-ID: <87o7i41bya.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14 2023 at 14:15, andrew wrote:
> PV guests are never going to see FRED (or LKGS for that matter) because
> it advertises too much stuff which simply traps because the kernel is in
> CPL3.
>
> That said, the 64bit PV ABI is a whole lot closer to FRED than it is to
> IDT delivery.=C2=A0 (Almost as if we decided 15 years ago that giving the=
 PV
> guest kernel a good stack and GSbase was the right thing to do...)

No argument about that.

> In some copious free time, I think we ought to provide a
> minorly-paravirt FRED to PV guests because there are still some
> improvements available as low hanging fruit.
>
> My plan was to have a PV hypervisor leaf advertising paravirt versions
> of hardware features, so a guest could see "I don't have architectural
> FRED, but I do have paravirt-FRED which is as similar as we can
> reasonably make it".=C2=A0 The same goes for a whole bunch of other featu=
res.

*GROAN*

I told you before that we want less paravirt nonsense and not more. I'm
serious about that. XENPV CPL3 virtualization is a dead horse from a
technical POV. No point in wasting brain cycles to enhance the zombie
unless you can get rid of the existing PV nonsense, which you can't for
obvious reasons.

That said, we can debate this once the more fundamental issues of
XEN[PV] have been addressed. I expect that to happen quite some time
after I retired :)

Thanks,

        tglx

