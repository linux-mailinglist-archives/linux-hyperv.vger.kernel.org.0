Return-Path: <linux-hyperv+bounces-5290-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0A2AA62DC
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 20:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259F71B65711
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 18:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01772222A0;
	Thu,  1 May 2025 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/DQatTt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE420C014
	for <linux-hyperv@vger.kernel.org>; Thu,  1 May 2025 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746124454; cv=none; b=Kv5Eov+pbb8q/MjCii7S2qTEqCAZ4uXsOtq+VA5c/35qvGAHUVLNO3E+Qt5QC2mgZFOV4axqsZ0BBdydDlngyxRk1HX4nOedwVMxwnNk7KsG9d3zoSrbR0zxBTtAMLDa+xX/nyEZe+esC8Kt9aCMouDbYcnNhiNSMfwhbEso1aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746124454; c=relaxed/simple;
	bh=+DAZETPgGKlVNaxrjII/8WTA3PntLOU1NMdtZAGUhfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVAlNQ/b+dMZmq+sp2dc0eROOoq08l4gOIvdRw3fzsu8KUx+ljpVscxqLre0vrtIdv/BbRWZikXXhTqbH+5XxEIp1HH8uonGCjsTN5dGzn4nclpTKKwLbHvAuI47cguUH+H1SuqukJoUtlK7cam41DauUv2gm7hrliXVjwcMvJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/DQatTt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746124451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qKIEW/lhMjwEMGxy/raOMlbK5hykaujRDE/weD2Tms=;
	b=g/DQatTtN+vBNTuQaMKc7EzIeicYNSSyR+oQ3L+4X9EcyTNg9YyzEHKA0q3eayI8/zgnkG
	2wiu1jl21E88IdSup3E/7YDcta3Z2ggHeVMeenLSQaTz4hkjs4nCOf1mtDHU/dbfnUyp6+
	DCqmLTyQSKcKU4ECoMerZfsxcBBydFA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-XWFPVkskPfK5KGmC-3yV_Q-1; Thu, 01 May 2025 14:34:10 -0400
X-MC-Unique: XWFPVkskPfK5KGmC-3yV_Q-1
X-Mimecast-MFC-AGG-ID: XWFPVkskPfK5KGmC-3yV_Q_1746124449
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912fe32b08so466983f8f.3
        for <linux-hyperv@vger.kernel.org>; Thu, 01 May 2025 11:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746124449; x=1746729249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qKIEW/lhMjwEMGxy/raOMlbK5hykaujRDE/weD2Tms=;
        b=QSbCbBD0kRQcIZBnlqKt3bgaOlU76HH6z/TSMMeTpDaiw7dz0fzd/qh4MOHabM+Z8k
         uqRU886sHcr1e1mn3+LfrGU02qKSR49fFHsZ265Q/WPRMigJ0p2GWzZ53ERia81xfw07
         2FMTjRjB1LLOpG8sh+9P8Qtp8UGW2+kdim3X53LaJq529RU9hE+QVOJiYvoCny4l9C39
         3Trlbx854z02GsrP16sm1DWklZjTVf/wIrn7iJ8ncPAbETxJhyjbV3DFfW28S40u5b6U
         YFrHSsBd6ibdUqo8yF4HinBS/+t8KUQoP1oGhfAaDkmMCL0RREqB8NCgvTKos4uCv+x6
         Pk5A==
X-Forwarded-Encrypted: i=1; AJvYcCXGVoEWKZw3KnG4Oanj/u8up1wc0bd66tobNpONhp/zzjLYUHMF0fRInn0XebDNSQ3lbiPbVfvN0ZLmD/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9UGN+W/ZuhGa0XgqbNjJOX6AUDkz7a9I4lqj7aSRbH3mPY+8
	6kCMckKkN7n2jTC02KxMNGmvc/b6VbDAtf8QaCvGGR3j5cfK2YRwAyts09Pq7QKVAPvnIf3qLKL
	2a+DHMQTTGBF0wwor8z3fijWBFfCiXRawxKClKBudTmRru0fRJdpyq7lGirMsrE8N2bP77ryFnb
	MLL7Wzfo8QxMd6ubpQ2O/gjqSbCfK7XgFUNLXk
X-Gm-Gg: ASbGncsR+1l6cizcadW72Pt3ZYpfosBFrtEydQ53QQ//G5wCURg1FMYIF7ZsPjuM4vz
	h0j7hK4IIrydMzxS77a2u2xoQ7SpAlMIennCZEV1+cdc2tKXfpJ+uOVo1ITyNTRCyGihT
X-Received: by 2002:a05:6000:2cb:b0:38f:28dc:ec23 with SMTP id ffacd0b85a97d-3a08f761e95mr6926086f8f.19.1746124449422;
        Thu, 01 May 2025 11:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8pyZZxNLsDKgK+s6EiT/5Z0RvhAJbHB3j6sE0QEEuK4GrGOmkb5NB8jNyV3jUBy2M6Ty7WMK3PucatHbyoBs=
X-Received: by 2002:a05:6000:2cb:b0:38f:28dc:ec23 with SMTP id
 ffacd0b85a97d-3a08f761e95mr6926061f8f.19.1746124449084; Thu, 01 May 2025
 11:34:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430110734.392235199@infradead.org>
In-Reply-To: <20250430110734.392235199@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 1 May 2025 20:33:57 +0200
X-Gm-Features: ATxdqUGj_DEOILwA7gJmdwUbmKq2o1Nt9LtM9RStnzYMraMRgnH01086KHJWMt8
Message-ID: <CABgObfZQ2n6PB0i4Uc6k4Rm9bVESt0aafOcdLzW4hwX3sN-ExA@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls in
 __nocfi functions
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, seanjc@google.com, 
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	gregkh@linuxfoundation.org, jpoimboe@kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	samitolvanen@google.com, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 1:26=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> Notably the KVM fastop emulation stuff -- which I've completely rewritten=
 for
> this version -- the generated code doesn't look horrific, but is slightly=
 more
> verbose. I'm running on the assumption that instruction emulation is not =
super
> performance critical these days of zero VM-exit VMs etc.

It's definitely going to be slower, but I guess it's okay these days.
It's really only somewhat hot with really old processors
(pre-Westmere) and only when running big real mode code.

Paolo

> KVM has another; the VMX interrupt injection stuff calls the IDT handler
> directly.  Is there an alternative? Can we keep a table of Linux function=
s
> slighly higher up the call stack (asm_\cfunc ?) and add CFI to those?
>
> HyperV hypercall page stuff, which I've previously suggested use direct c=
alls,
> and which I've now converted (after getting properly annoyed with that co=
de).
>
> Also available at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/core
>
> Changes since v1:
>
>  - complete rewrite of the fastop stuff
>  - HyperV tweaks (Michael)
>  - objtool changes (Josh)
>
>
> [1] https://lkml.kernel.org/r/20250410154556.GB9003@noisy.programming.kic=
ks-ass.net
> [2] https://lkml.kernel.org/r/20250410194334.GA3248459@google.com
>


