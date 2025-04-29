Return-Path: <linux-hyperv+bounces-5227-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55823AA14EA
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Apr 2025 19:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370C39851F6
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Apr 2025 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EA52517B6;
	Tue, 29 Apr 2025 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXu2MwBv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C6248878
	for <linux-hyperv@vger.kernel.org>; Tue, 29 Apr 2025 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946971; cv=none; b=GjBNhuKM5Iba59nbibKV/7XpBYjFzIw0ICzjXXVRNJ2TXx5oQ34CdPofLMMicC6JdIMYZOlK7/X/IMebc+CIt9IDHq5prpWLursWvgeQ/x4jPXYsJklKwpO6zljxyR65HBAa2weJLeyRwlhPeTbU/GS/Y4wqfkHuz2cCkZy5hNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946971; c=relaxed/simple;
	bh=7RreN82ADxQheU4kFlw/w2oqpyMciZ+CVjUxQ6PBPwM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TVep+NfO50q6sRWgaLIdpCVAyR9hRtl3xSChhriL77VL+PPGmsc/JpIX+fba3tO6oiWnV7NNO4/7Psl0osvJSxiK0asWwvVcDX+Uao3brv0nhs+iv97mTNEno87M6r6mEcqh59qZ3LRynV5qjbaQc/RC+R3P6Mly/OSID7Lb2BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bXu2MwBv; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-739525d4d7bso4608661b3a.2
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Apr 2025 10:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745946969; x=1746551769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rgg+yk6TbZkrf50JyHWvmpVTzHV3/+x6Tw/18oxSDfg=;
        b=bXu2MwBvNAlO8nBWeuN1zsR8XdKxHPAS6C4JsEKAfRG8mQZsVRB2ZvJQNFngWHiPwq
         8f86r3A/fz04l1GZ+hapVDWQEmt6OYRqjI93ZWfmBo5mZafkTTyguzbMUMh6FEwSUVDA
         eqRZ/N+ZaBpljcdcw7+D0/pOvoBI9lSdmbOj1unt6azWF6zHVGyihAOOs0ZMQyeMS3VU
         aa9udOfB9etW1XjNq8Pfd2oGUIXW9T2gAfRL8iZ6Ork//pkjxlpWhPKyxOlJ8QHyrW//
         jHLuWYLJ3GreKCV6b+WDvPT+KjUaGOvDWeMorKwUnl8XYpjSJCIJL6nLQbJ+loEn5Eqk
         5qtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745946969; x=1746551769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rgg+yk6TbZkrf50JyHWvmpVTzHV3/+x6Tw/18oxSDfg=;
        b=DZqFTlescE7xi8JdJVQ64/23fMxy2IB5PsO63Vrk6pArKPtlHzJiUXHQIlTrGwnMFR
         Uk9BZPIec03VAgs0+XuVwswuj1Wq1RxKm3t6Za2QL+YvquQCR2vbUrEpOvqL5EsB3zXL
         cCpca5eWhpU73sqLA7pJjytJXsDrlicdKvqwgus3YkEovoEwmxGzsbGxeca953xL6Pke
         AjP63z02cP4malKZpLpgzOLTDJVR+71QZSOYDkx1X28nNrNgHGBVNA2/rS6HlNFD/12u
         NGOgh9DuB8dn120I6Ke75B3PRcKZ4KDNOm0m/eEzCXMbFA08+D1Qpvy0LeN9na7BM2Rz
         eopg==
X-Forwarded-Encrypted: i=1; AJvYcCVzXnhBvZHqFloSnIuPrWwhOA2Yq2hgUSKXNF3QRfNLoE3DWCcnlAgg+J+ngxmylfqBLXR+LgepIlb0BVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNDhzaBLYsvhl/Ak5bbz/GFrI+lxqegRdKnsJCY+sCSnwS5F5
	HZNaSQB/c5nf56u8GCVkJ2ZDQ5JMRY0t9nj8I/Gj9+A6iP8laEoeloRmnRqew8DYQJwPjZ+GKcd
	LBQ==
X-Google-Smtp-Source: AGHT+IHnBsjJ2lHlGsUa7wfkhDlYoD1/JVsa8FRjr2Yl8wXuoJ1y4aqVn3VINpRePPFLsbZG8fx/ncC1Rgo=
X-Received: from pfbkq14.prod.google.com ([2002:a05:6a00:4b0e:b0:73e:1925:b94b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1814:b0:736:5f75:4a44
 with SMTP id d2e1a72fcca58-74038abcf18mr88925b3a.22.1745946969011; Tue, 29
 Apr 2025 10:16:09 -0700 (PDT)
Date: Tue, 29 Apr 2025 10:16:07 -0700
In-Reply-To: <20250429144631.GI4198@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414113754.172767741@infradead.org> <7vfbchsyhlsvdl4hszdtmapdghw32nrj2qd652f3pjzg3yb6vn@po3bsa54b6ta>
 <20250415074421.GI5600@noisy.programming.kicks-ass.net> <zgsycf7arbsadpphod643qljqqsk5rbmidrhhrnm2j7qie4gu2@g7pzud43yj4q>
 <20250416083859.GH4031@noisy.programming.kicks-ass.net> <20250426100134.GB4198@noisy.programming.kicks-ass.net>
 <aA-3OwNum9gzHLH1@google.com> <20250429100919.GH4198@noisy.programming.kicks-ass.net>
 <aBDcr49ez9B8u9qa@google.com> <20250429144631.GI4198@noisy.programming.kicks-ass.net>
Message-ID: <aBEJVzesMum9-Rem@google.com>
Subject: Re: [PATCH 3/6] x86/kvm/emulate: Avoid RET for fastops
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, pawan.kumar.gupta@linux.intel.com, 
	pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	samitolvanen@google.com, ojeda@kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 29, 2025, Peter Zijlstra wrote:
> On Tue, Apr 29, 2025 at 07:05:35AM -0700, Sean Christopherson wrote:
> > On Tue, Apr 29, 2025, Peter Zijlstra wrote:
> > > On Mon, Apr 28, 2025 at 10:13:31AM -0700, Sean Christopherson wrote:
> > > > On Sat, Apr 26, 2025, Peter Zijlstra wrote:
> > > > > On Wed, Apr 16, 2025 at 10:38:59AM +0200, Peter Zijlstra wrote:
> > > > > 
> > > > > > Yeah, I finally got there. I'll go cook up something else.
> > > > > 
> > > > > Sean, Paolo, can I once again ask how best to test this fastop crud?
> > > > 
> > > > Apply the below, build KVM selftests, 
> > > 
> > > Patch applied, my own hackery applied, host kernel built and booted,
> > > foce_emulation_prefix set, but now I'm stuck at this seemingly simple
> > > step..
> > > 
> > > $ cd tools/testing/selftests/kvm/
> > > $ make
> > > ... metric ton of fail ...
> > > 
> > > Clearly I'm doing something wrong :/
> > 
> > Did you install headers in the top level directory?  I.e. make headers_install.
> 
> No, of course not :-) I don't use the top directory to build anything,
> ever.
> 
> All my builds are into build directories, using make O=foo. This allows
> me to do parallel builds for multiple architectures etc. Also, much
> easier to wipe a complete build directory than it is to clean out the
> top level dir.

FWIW, you can do the same with KVM selftests (and presumably others?), although
the syntax is kinda weird (no idea why lib.mk uses OUTPUT instead of O).

E.g. to build KVM selftests in $HOME/build/selftests/x86

  make O=$HOME/build/selftests/x86 headers_install
  make OUTPUT=$HOME/build/selftests/x86

