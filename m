Return-Path: <linux-hyperv+bounces-3931-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A82A332EF
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Feb 2025 23:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFDD77A2FF7
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Feb 2025 22:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2F520AF66;
	Wed, 12 Feb 2025 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0+oa/YGN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC923204587
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Feb 2025 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739400944; cv=none; b=jLdzL7WOMsPP9E1r1ryZL9q6UI7aSaM8UCk91jZAUtguaV4KLXhsYt9jcavCQzm+y84ivHZ4ToApeDjVRUQcVPxuGJqycATvImtimwcukXJnSxCm18sBDKO5Zwqs0nWYg3xzG4vsbdgAMmMnw/RajDpMVlRfpGcQTSO7VMBsSjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739400944; c=relaxed/simple;
	bh=M/JEAtm/aKqZQpUcIkbOx1V5MbhNPluJ7A9OR2+JsF8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O0tj4trzwKlFwT5YsZV3sjHzRY/nfNqk665saiv+a0+h7Bby6xqy+C+fllEjt4km1Jgyu1SYp3Qh0U9Y/6vKgOd9BcgknhKye6Q/n2W/b+mv9ekK3P5DwxNWu6STYhGdK1vg3NkdnbZFx6+2lgBjcEd/gjZJl1k3ARG9kiRo80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0+oa/YGN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f022fc6a3so5009055ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Feb 2025 14:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739400942; x=1740005742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4pJwe4WBZK7j0Qn81lTWodsKOqME7mNPJqkDCUIDvw=;
        b=0+oa/YGNFhfNfAvc1DakAtTUGsb5fIjUlQ8FgLTRkg4g1oQyavX/X3Goe3VKnShPef
         sathwRfPc14c/SS/26TodPkSpcyzfl3XYEr9eD3+NKhZ05MA8IpZOeWBer9yGZdhkcZg
         vYzPXJsuWtL36f/RQOOZ6ZGR0NpUaTqI7oN/qOUKlOn8bvDfB5QLFBFv0wQAHb7EYZZh
         kMeayyeRT8PqJE3MHyteMkdaI14XvZfIVt0dUvMYtIEAGznLN65J37HiJGuZe3Ih2/nK
         SaRuIN8GhT2SwQG9cLxEL2bY5wKx/5x8+sumghXwYfj0es1OJMTZcsxVPzpCpT8g64ko
         5HHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739400942; x=1740005742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4pJwe4WBZK7j0Qn81lTWodsKOqME7mNPJqkDCUIDvw=;
        b=ZF/d/ha1BM2EXoQsYZ7iVz5IkjWCDVrOlb5Ud/mIYNCndNvT9FMtlgM3VwWkUks/yj
         PW9bR0t5/bPgXfEjLwQLTRy5lymTO6qXiea1ITiDg2CseZyBPUAEiqLhgf4kIWozkFcN
         LpqRbUvWo8eyBvuk6ClWT87uSFf5iT483aXpFlLMY56yFxKJ8v2XPiWvLGENAiiTkhWW
         Yx83rB0D7DIcrBzsbwxzIQtT4JnWpHt6thtjWlJAEmd94LdoXE6Mp4/gvfHeHXpa797A
         3tC/FBWtvjFbF9zfzWLEC4g1xfpt8BUiypfRWf9hTORCNZs6n5r0H86S3m2tIyHcLLXD
         q33Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzQ0u9rN7Y6cg4Wpdniu7Am0F3m/PkThU7ODtpweiRkYufrKdw6QfMBbkz2yEAuw+7L6SsE+UDu9FKrsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYVIeY6edwlI1tKm7uxQ1fsNMSTUa1ebrxS4irSGSAa/9b6fke
	ElIpiuIodGXWFAr6p9PQX0oWRipNABbqjNovjwogKhYIaxXfbM0R2/yORElyjZbh+MVEM9tjoV+
	5Jg==
X-Google-Smtp-Source: AGHT+IFCvprC2FVz2MYwofAu+gOZ+t6GzfO0x6W16EewccF+NjWJufThiJaaDpuXjWvbsRckLewQnEmSOUI=
X-Received: from plbb4.prod.google.com ([2002:a17:903:c04:b0:21f:14cc:68b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94e:b0:220:c2bf:e8ba
 with SMTP id d9443c01a7336-220d3528cc9mr11030295ad.14.1739400941927; Wed, 12
 Feb 2025 14:55:41 -0800 (PST)
Date: Wed, 12 Feb 2025 14:55:36 -0800
In-Reply-To: <SN6PR02MB4157DBAF1E3BB0E4FFD2C92DD4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com> <20250201021718.699411-17-seanjc@google.com>
 <Z6ZBjNdoULymGgxz@google.com> <SN6PR02MB4157A85EC0B1B2D45CB611FAD4F02@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z6onnUthSBUVAklf@google.com> <SN6PR02MB4157DBAF1E3BB0E4FFD2C92DD4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Message-ID: <Z60m6NiOlCmy4-q0@google.com>
Subject: Re: [PATCH 16/16] x86/kvmclock: Use TSC for sched_clock if it's
 constant and non-stop
From: Sean Christopherson <seanjc@google.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Nikunj A Dadhania <nikunj@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 12, 2025, Michael Kelley wrote:
> From: Sean Christopherson <seanjc@google.com> Sent: Monday, February 10, 2025 8:22 AM
> > On Sat, Feb 08, 2025, Michael Kelley wrote:
> > > But I would be good with some restructuring so that setting the sched clock
> > > save/restore hooks is more closely tied to the sched clock choice,
> > 
> > Yeah, this is the intent of my ranting.  After the dust settles, the code can
> > look like this.
> 
> I'm good with what you are proposing. And if you want, there's no real need
> for hv_ref_counter_at_suspend and hv_save/restore_sched_clock_state()
> to be in the #ifdef sequence since the code has no architecture dependencies.

Right, but because they will be local/static and there are no users outside of
x86, the compiler will complain about unused variables/functions on other
architectures.

