Return-Path: <linux-hyperv+bounces-7592-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 779FFC5E1A8
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 17:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32645503DBB
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AE1337686;
	Fri, 14 Nov 2025 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M8PzqMn5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4433710D
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Nov 2025 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763135256; cv=none; b=cChHhMHLAnag95snuwGDV1/uYj4iwvvEzRCz70LcoZIut67l5X1lAEOCZoJSTCn0060lV2gvsHwJW3jGHfwwUXPNBJBBzveBCmgrgK4HcU62N43BJ070OXlpQ4Nxw5k0OXp/3lsIftP3yn1ORG/KD39kcvo/2HS5uX6zDmSW4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763135256; c=relaxed/simple;
	bh=GOO3wfMsD8xMrynd0VaTlbVF069hyj1iI813x4ydm2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=AmA3Yy+RZMu+D432OnGFhNxML+V/gIImkY38/Q+SbdIoj1FCSU+TydgT2Bi9N3ng4FcFHRYocPvbLgqD4czwW0LOLaFsgYgiTIY6tAmft72+i1J+mbHZQYAaCRigdeDjNGWab5Bhd4rGqHkvsYTD+UmpDWkfu88jce9KTAC6Ntk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M8PzqMn5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-343bf6ded5cso4913113a91.0
        for <linux-hyperv@vger.kernel.org>; Fri, 14 Nov 2025 07:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763135254; x=1763740054; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heBeYHJOLj8+/qTp+grjTVtU5A1aEwQDuOhI6nPQQBU=;
        b=M8PzqMn5M1tk/9ytM+gEY0BBzxcXo+zbGZxGz4GT9Wo+SKGqOb33HTDmfYdwr5rZ6T
         DQ0oQNf+BSukXDbXIj3K8YV3p2PQmX9vMuRCyLL9irFWLv2tyA9HRWmBexV7e3dTmZ0w
         fwM6QpupAzSGPQ8j3KWWrK0qMaMA1ObdB6gG7n6Jn/rWiOi7R+ri1UyLnjegBLVH2uFR
         eBkAovaJlqpOyHRTy+gytKQLEOiNhDsN7LGZjbDtKBXxxyhZJ3HFO1ru7/kq2jIb9qD0
         PCFeNZCSQr/tQRwKkM36VObupKuMtEMM34wl8ROp+tfsewwPJNuDr3bu/3TW0CMjMXk4
         Y5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135254; x=1763740054;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heBeYHJOLj8+/qTp+grjTVtU5A1aEwQDuOhI6nPQQBU=;
        b=Z+tSQ3wtyk/fjfv4hqJkhlBnsibCopPXEGOwBTCSYUcLGR/lxrsDyizc8sjw+QanIU
         n7+W9YGYKblXBxLQWmI4XmNY0bIgZwiUztnH49aPx+vwKGJJXhFmuBJeqr/uC/Agi8qq
         tBpE2VK9OUERU3BTaiDDfJZX3/VMWq9wyYMv3tc89RRLkwYi0nlRNhA7/k4GlhtmVKrx
         awJsV95TJycB+PU3O7Qnq2D1dlOkKNcllbt1GUKQar5AqGwwXaorJlFaxSghvZEZCmFe
         fyRyLDBUXOYmLp3OY0gOoHTMfDmISDM4VwLsNW01MDHsS1668YCSMfKclreZR+z77bQL
         g0jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK9gklOQRlfIEY2xPe/yzLtJqw/m4xPhPZpSJxfrLvtFVBwqgNYAcLI/V9Q13qupPHvA+kFfuafE5NVls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoUaC63bQQ/WSeCUrNlmLA+xGoZy3glZ2YkiiuvKvB8Ylpu3Ef
	Whv4taJdWRX8U26k1bopnmBO4FyqnaqKAEQw4RYZ4SFu1DR8gI2dlWlYyMP3SxYn11mEPXOHSzk
	t8esWAA==
X-Google-Smtp-Source: AGHT+IGIYZcT5u9nbOtd9YML18W8Ko3CKgWeqcBXWxA6E9yCrbdnMoXwj99UvMUQpdMGahG7aUUxfvwx6K8=
X-Received: from pjblt11.prod.google.com ([2002:a17:90b:354b:b0:33b:51fe:1a83])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55cf:b0:32e:7bbc:bf13
 with SMTP id 98e67ed59e1d1-343fa76af6dmr3644471a91.34.1763135254562; Fri, 14
 Nov 2025 07:47:34 -0800 (PST)
Date: Fri, 14 Nov 2025 07:47:32 -0800
In-Reply-To: <aRdKa9jVMt0Rn5tj@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113225621.1688428-1-seanjc@google.com> <20251113225621.1688428-8-seanjc@google.com>
 <aRdKa9jVMt0Rn5tj@google.com>
Message-ID: <aRdPFEF0XS7Zz5Fx@google.com>
Subject: Re: [PATCH 7/9] KVM: SVM: Treat exit_code as an unsigned 64-bit value
 through all of KVM
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 14, 2025, Sean Christopherson wrote:
> _and_ the hyperv_svm_test selftest fails.  *sigh*

And the weekend can't come soon enough.  The kernel I'm testing doesn't even have
these patches.  /facepalm

