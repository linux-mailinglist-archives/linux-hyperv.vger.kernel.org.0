Return-Path: <linux-hyperv+bounces-786-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191C87E5D45
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 19:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9A51C20BCA
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 18:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7093F36B0E;
	Wed,  8 Nov 2023 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uFaeB68V"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D236B18
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Nov 2023 18:33:14 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E4C2107
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Nov 2023 10:33:14 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5af592fed43so85682367b3.2
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Nov 2023 10:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699468393; x=1700073193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=50ipMfBLEUA7xDJ0NQzorJYtn8bk8XRkn5YPeYvT/r0=;
        b=uFaeB68VTHrGLbgfLw3MxRn1VfxX8HS5w6+ut3fXoq/g75D7YJRACneD44JdFfngkV
         mvUxjBwP2uuwjEMwKcnmT7q730uXmqiC7j4WpeNZFwI7nP84ei59J7QfxeT0srfBG1HA
         5TtxaSyoudUXmRc+6pDkIgjPYOirCSryyw2mTLwHQ+rBSNe/6medhZwG8+6xXk+k3JBW
         u9OBVMN1Zf0tR7S99r3a1Jxl2RoTQW7011X5R4kf8kD/UiWwcpschgeIo3AA6RYEzt0L
         /M2oc3sRO3PUX9ynqIKlOCHrACijBZQvF3dW3cVWvIRdeQ+cYqmnIEpS2HYI2a86WnHd
         cRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699468393; x=1700073193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50ipMfBLEUA7xDJ0NQzorJYtn8bk8XRkn5YPeYvT/r0=;
        b=vz107lDN+meoI2FEzsNHIYiu92nJN513Uz0/Av4Kb9mjkyIYll4fXymGwXsE2IfIw1
         DyZTrcrf0pKUf54aRcyYgu/z70/S2Omvm7y5YPdiuCh+n5RoPAsojRFiZzDTpgpuci4H
         8mbOnMJHxzI2o6ae1IQDBl8y/06eu6ExCMFHwMJFIkbHFwjpP6tMEH3vswphUnRA1mGA
         UX3iug10RFmkvwckX50ELxBntBpZmWUn5YGvARmIPlZa07hx3zvkVq4kcLCR6YSIcHwo
         YUVU7h4yMgOhKYIZ1H0Nn9SrcvPG71zv3dKKHLNO+RUjccqW+5YXbkr5Eohk+jMCybkY
         2/9A==
X-Gm-Message-State: AOJu0YyV1O2GnuXytDhHNKBC+mZwW58IvQmxWO2dcwFgJ8tvfseAKoP8
	nO7yhVE9V7Av8HgQ+FuZ+/z92gFDEQQ=
X-Google-Smtp-Source: AGHT+IFHQg/YDcEIocO0Ni0JZ0CPuBXAmwWA3839QbB/g3j7+q1xZZYyE3IrNG+D7YVTAx/aop/3By26fig=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:701:b0:d9a:6007:223a with SMTP id
 k1-20020a056902070100b00d9a6007223amr60840ybt.8.1699468393385; Wed, 08 Nov
 2023 10:33:13 -0800 (PST)
Date: Wed, 8 Nov 2023 10:33:11 -0800
In-Reply-To: <ZUu9lwJHasi2vKGg@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <ZUu9lwJHasi2vKGg@google.com>
Message-ID: <ZUvUZytj1AabvvrB@google.com>
Subject: Re: [RFC 0/33] KVM: x86: hyperv: Introduce VSM support
From: Sean Christopherson <seanjc@google.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, pbonzini@redhat.com, vkuznets@redhat.com, 
	anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com, 
	corbert@lwn.net, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com, x86@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 08, 2023, Sean Christopherson wrote:
> On Wed, Nov 08, 2023, Nicolas Saenz Julienne wrote:
> > This RFC series introduces the necessary infrastructure to emulate VSM
> > enabled guests. It is a snapshot of the progress we made so far, and its
> > main goal is to gather design feedback.
> 
> Heh, then please provide an overview of the design, and ideally context and/or
> justification for various design decisions.  It doesn't need to be a proper design
> doc, and you can certainly point at other documentation for explaining VSM/VTLs,
> but a few paragraphs and/or verbose bullet points would go a long way.
> 
> The documentation in patch 33 provides an explanation of VSM itself, and a little
> insight into how userspace can utilize the KVM implementation.  But the documentation
> provides no explanation of the mechanics that KVM *developers* care about, e.g.
> the use of memory attributes, how memory attributes are enforced, whether or not
> an in-kernel local APIC is required, etc.
> 
> Nor does the documentation explain *why*, e.g. why store a separate set of memory
> attributes per VTL "device", which by the by is broken and unnecessary.

After speed reading the series..  An overview of the design, why you made certain
choices, and the tradeoffs between various options is definitely needed.

A few questions off the top of my head:

 - What is the split between userspace and KVM?  How did you arrive at that split?

 - How much *needs* to be in KVM?  I.e. how much can be pushed to userspace while
   maintaininly good performance?
   
 - Why not make VTLs a first-party concept in KVM?  E.g. rather than bury info
   in a VTL device and APIC ID groups, why not modify "struct kvm" to support
   replicating state that needs to be tracked per-VTL?  Because of how memory
   attributes affect hugepages, duplicating *memslots* might actually be easier
   than teaching memslots to be VTL-aware.

 - Is "struct kvm_vcpu" the best representation of an execution context (if I'm
   getting the terminology right)?  E.g. if 90% of the state is guaranteed to be
   identical for a given vCPU across execution contexts, then modeling that with
   separate kvm_vcpu structures is very inefficient.  I highly doubt it's 90%,
   but it might be quite high depending on how much the TFLS restricts the state
   of the vCPU, e.g. if it's 64-bit only.

The more info you can provide before LPC, the better, e.g. so that we can spend
time discussing options instead of you getting peppered with questions about the
requirements and whatnot.

