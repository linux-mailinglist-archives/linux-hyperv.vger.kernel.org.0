Return-Path: <linux-hyperv+bounces-780-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316C17E5C4A
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 18:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4758B20F22
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F7F31A98;
	Wed,  8 Nov 2023 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRvVLLMt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AA3315AB
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Nov 2023 17:20:40 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5521FFF
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Nov 2023 09:20:40 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b59662ff67so8119567b3.0
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Nov 2023 09:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699464039; x=1700068839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uBbKC3JkdJ0oQ9YroQVJM/5WimY0jXaEi0yPTCtmdW4=;
        b=KRvVLLMtR/ldoVMkhZYwEz3RWr0mpd3q5HfMo6E1eymtRVrr5IAbiIZ8LsF395Qram
         8U7JFDCycq8uKe7RzwefkyuCukw8fzhErpmZOdil+naNZKM6sWGRZ4WpaNQnXMtqSikb
         3ty2xBNBcEriOWRl9OxHVD6pPajuEE5knKH6S57r17BoprX44Gl/rSR3TRYqZeFJ62Il
         bVm9palqUFrSLRAzw1ZLo8ogkmXmYd8/NIfuwIu3ROmq/vKmqEfI+u1Fnrk/hLMeJP6e
         bXpibw2MNE18Tn2o7decAmTzFWU4qYSlMGPyDZIplL2U4Ray5FKt58c/+Iawd+2d/tL5
         FsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699464039; x=1700068839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBbKC3JkdJ0oQ9YroQVJM/5WimY0jXaEi0yPTCtmdW4=;
        b=SUWu+R0KYsN/rAghW0/FoEW5mLSOomOgGMmRgm/85+15j9pxfT2DVttrI4Jbwxjy+W
         Q4Oc1UGZ150xdcU/KQXs6UdXN/bYWyidJIfzhrXBl0n0kjk1CYWbfleljpC0/DU8sXH0
         vV83rD5Xn/992Q6ZR/rr3oEdN/PT0hu950rWc1gkd7tA9L8aA9WRfUz7qfJ3ZpP5rP5s
         SwGK2QFawk/cqd3mpsYL2QWWjq1IV0nvau+FP4xHKGgi6qCsjQ6obqxsbvfI3kWuYN4U
         BqJn0NIb3bsk02z82sqfxIXFZ+x6YHuEKXhq+ePfkEmIQrghiYexg6F8CwFM7Xt+Gbkj
         La3w==
X-Gm-Message-State: AOJu0Yy2bBy1VGqfgBJ9xjkx6VYHYC6GXbC1G/ZlZt9A23KRpVCC7Jn/
	eJCmIlbqlwLPLG8GIc1Um7CSZKyMCbk=
X-Google-Smtp-Source: AGHT+IGphpWQHHEDy2ukCPCGjyPMd0Bw17ZH9MJZhu3SATwjM2+XVm/rjVukAqXpoj9DXdfpGc+wU3Ua940=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4047:b0:59b:b0b1:d75a with SMTP id
 ga7-20020a05690c404700b0059bb0b1d75amr122541ywb.4.1699464039546; Wed, 08 Nov
 2023 09:20:39 -0800 (PST)
Date: Wed, 8 Nov 2023 09:20:37 -0800
In-Reply-To: <20231108111806.92604-30-nsaenz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-30-nsaenz@amazon.com>
Message-ID: <ZUvDZUbUR4s_9VNG@google.com>
Subject: Re: [RFC 29/33] KVM: VMX: Save instruction length on EPT violation
From: Sean Christopherson <seanjc@google.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, pbonzini@redhat.com, vkuznets@redhat.com, 
	anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com, 
	corbert@lwn.net, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com, x86@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 08, 2023, Nicolas Saenz Julienne wrote:
> Save the length of the instruction that triggered an EPT violation in
> struct kvm_vcpu_arch. This will be used to populate Hyper-V VSM memory
> intercept messages.

This is silly and unnecessarily obfuscates *why* (as my response regarding SVM
shows), i.e. that this is "needed" becuase the value is consumed by a *different*
vCPU, not because of performance concerns.

It's also broken, AFAICT nothing prevents the intercepted vCPU from hitting a
different EPT violation before the target vCPU consumes exit_instruction_len.

Holy cow.  All of deliver_gpa_intercept() is wildly unsafe.  Aside from race
conditions, which in and of themselves are a non-starter, nothing guarantees that
the intercepted vCPU actually cached all of the information that is held in its VMCS.

The sane way to do this is to snapshot *all* information on the intercepted vCPU,
and then hand that off as a payload to the target vCPU.  That is, assuming the
cross-vCPU stuff is actually necessary.  At a glance, I don't see anything that
explains *why*.

