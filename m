Return-Path: <linux-hyperv+bounces-10042-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JDhK2jA1GmWwwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10042-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 10:29:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 468C03AB595
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 10:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 000D2302450E
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2026 08:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8903A3A3E7B;
	Tue,  7 Apr 2026 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKe+iuyC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="esjoUbqB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824863A4F35
	for <linux-hyperv@vger.kernel.org>; Tue,  7 Apr 2026 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550239; cv=none; b=HTIii2VTseNGm5AcvS3EeXkTGhJcikqBwZuSHDCHD7bIwBNzmN8EX9bvQJ6gaVB2KUcBV/zi7XVnDKfXuFOS9l6W4wprGBca82eOZQzD2wNKmQisvqAHLcfyUnkwZY26uXNCblLa3ueJwvJ6EpIcTXA42dOml38tF+6BfHSsDtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550239; c=relaxed/simple;
	bh=7JdMq9kmytCqlpCjS5mi3SWGG4qHYr2Qnwy647cvRuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dO//WfyJCcSGu8ImjD6eXxXa5ccmTzKQSnAy717/EY/KcNiAgY7O4HRW8PDVsByJsWq0y9E8myJjDMJ8PqhV+JV5x61P9i2ROO/XzpydRBXruUfefRLIELkJq5dEm1iWIJH/Azp/J952ftvxYPE5TUnBFYeqeOobIR5Jsd3fE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKe+iuyC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=esjoUbqB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775550236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kNFB5lwDrSxIziDXYQDXgILJBTEgQRgf+OrOIXGdJvw=;
	b=XKe+iuyCqH1c+2FLMtR3PGZGJO1iDLTNeykGZsgBiCIZ75Quf1Hy3wktI+uhxzMmWHF+5B
	fwa9gu1QPqpf0gwfhIeJzfmfynie4ZIqPSFA2Wuq+AVAG6l0z7hzLMSgEZFBR/QobRJrEn
	zy85zRlhabB8uV9HNguLs/V48F67nqs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-4R91pkIoO5G7jXXdscrzbw-1; Tue, 07 Apr 2026 04:23:55 -0400
X-MC-Unique: 4R91pkIoO5G7jXXdscrzbw-1
X-Mimecast-MFC-AGG-ID: 4R91pkIoO5G7jXXdscrzbw_1775550234
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d121c4271so3295179f8f.3
        for <linux-hyperv@vger.kernel.org>; Tue, 07 Apr 2026 01:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775550234; x=1776155034; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kNFB5lwDrSxIziDXYQDXgILJBTEgQRgf+OrOIXGdJvw=;
        b=esjoUbqBN7Rw7Q60NGlT1E8SZAlGdJqIXLPYzoCEe54ehPvK6VFlU8557WOr4BOcyv
         AclMd0wAOn6XaqwIB/nfYh6WXMrFor+wXC59QUNPEmuIG7svqteLrepEVOljeWM9jVqe
         tizctbhSRisXbv5Ki4hif1TVS5q+9JUxd9gFmDhjD+rh6qbK7/jRJWW1oKTq4+aTJbnp
         z0TEfjO+/WvEVaIPs33w9V79mJ8N+FstwlKmrUmcwdTv5cR/mjjG6wJOajcjyIc/52o9
         7E8igD8F6a2DX3encwC8XK5pJorRrHZNJiPz+mVPw0E7j6MqUyOUYpRG9TD2Y+AMLWiw
         2QbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550234; x=1776155034;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNFB5lwDrSxIziDXYQDXgILJBTEgQRgf+OrOIXGdJvw=;
        b=VNneRBydOSHndjQaaOCB2mxAqVqp/mzR2aVi4IEn6GXEhvJBNzIXU9vOZzz0xYGuWy
         4c5j+O+SkeaJ87Wa+HZ+YLuZPdfefhme1YMEktp8dmbshvYz5VvuG5yeCjyd4Otb/Wi/
         vckF4cnEYtssLT190cBZ82M6kkYyQ62AvT9pwg8buZEyHuOst7xR6Q9pemr+A0GTZ+ZX
         lSiTfpIuCuKdOlCT1QjmWWwzzZubTDuvJfWLuUJYVKrdXh0G8yrQla3nvA18ltPcDUd+
         zI2lq3nQNgjhX7m9tURtz+DFMMX4n88bQKfpqP3reGIiOs3lSWNlh2iMjE8JUl3flHkF
         xzdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK1iNhRGQwZHvCPRUpI34qx377s8d+NCTrlBHbaGjrpaD0/MKRBr84dO4go+TZfuHyE7ABBAdRrllAdOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhX9C9PjXd43z3HR5L9DxV+IT4AAMfQ1GIFnfM8mNgXDzsEqOk
	D41h1aj4QXqDoqfid5e/hk8J0K589La0RWl+v1RxKnej0U/LXEhyUawTz5pr/nmAd2SZSsqVl2w
	PwZAYDM3sdLqGTIS+V+I1H1OxN+P6mYo/UyWqnpErWqCnmbAjCECH2AX/2Wvnxw3/bxMMBtyq4m
	RmJqoR5HPAfz3ApvJzO3ejrKNiDzk2LnOytT9EQo6XTrU4kEGqZyv7
X-Gm-Gg: AeBDiet3wMLVFg40wC4gYFFf2Iv/Gbba6q7+r1NU2BawbSLklNOVF8Evwjf5D1s0931
	3YUVf63cA+5qX+3KW7UEqBKSgLw6AP7e+0HTB8Q2N3fO1RyqXysEEwECshfdyCZD283dmIFSJwR
	ApdRH3KBu2wd6+TadeL5WC5ZdkTVAR6UGrUCuGb+IJgEz466SkAfY3GGIAU4NcWyUXXB7WOj+BU
	RTDmbJWL/3J3zKsVER1KCPfdNUM2cZvBz/WVnbdzYqrKzdbz+7aWQRq8ZlTIIje4MCABEJakddV
	XfKq35dzmgDh0wlrZ9o8WERfW5GLw9xeBqs350KfScA34g5xhep9vVBJrXE5RTfP29ITQT83qJA
	YKZMfOSZkbtedP51wvg==
X-Received: by 2002:a05:6000:4201:b0:43c:f5d7:94dd with SMTP id ffacd0b85a97d-43d29293a79mr23352465f8f.11.1775550234127;
        Tue, 07 Apr 2026 01:23:54 -0700 (PDT)
X-Received: by 2002:a05:6000:4201:b0:43c:f5d7:94dd with SMTP id ffacd0b85a97d-43d29293a79mr23352405f8f.11.1775550233497;
        Tue, 07 Apr 2026 01:23:53 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e56fesm46130731f8f.27.2026.04.07.01.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:23:53 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Thomas Lefebvre
 <thomas.lefebvre3@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
Subject: Re: [BUG] KVM: x86: kvmclock jumps ~253 years on Hyper-V nested
 virt due to cross-CPU raw TSC inconsistency
In-Reply-To: <adO_EYdKtl_TXooI@google.com>
References: <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
 <adO_EYdKtl_TXooI@google.com>
Date: Tue, 07 Apr 2026 10:23:52 +0200
Message-ID: <87se97mb53.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10042-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkuznets@redhat.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 468C03AB595
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sean Christopherson <seanjc@google.com> writes:

> On Sun, Apr 05, 2026, Thomas Lefebvre wrote:
>> Hi,
>> 
>> I'm seeing KVM_GET_CLOCK return values ~253 years in the future when
>> running KVM inside a Hyper-V VM (nested virtualization).  I tracked
>> it down to an unsigned wraparound in __get_kvmclock() and have
>> bpftrace data showing the exact failure.
>> 
>> Setup:
>>   - Intel i7-11800H laptop running Windows with Hyper-V
>>   - L1 guest: Ubuntu 24.04, kernel 6.8.0, 4 vCPUs
>>   - Clocksource: hyperv_clocksource_tsc_page (VDSO_CLOCKMODE_HVCLOCK)
>>   - KVM running inside L1, hosting L2 guests
>> 
>> Root cause:
>> 
>> __get_kvmclock() does:
>> 
>>     hv_clock.tsc_timestamp = ka->master_cycle_now;
>>     hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
>>     ...
>>     data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
>> 
>> and __pvclock_read_cycles() does:
>> 
>>     delta = tsc - src->tsc_timestamp;    /* unsigned */
>> 
>> master_cycle_now is a raw RDTSC captured by
>> pvclock_update_vm_gtod_copy().  host_tsc is a raw RDTSC read by
>> __get_kvmclock() on the current CPU.  Both go through the vgettsc()
>> HVCLOCK path which calls hv_read_tsc_page_tsc() -- this computes a
>> cross-CPU-consistent reference counter via scale/offset, but stores
>> the *raw* RDTSC in tsc_timestamp as a side effect.
>> 
>> Under Hyper-V, raw RDTSC values are not consistent across vCPUs.
>> The hypervisor corrects them only through the TSC page scale/offset.
>> If pvclock_update_vm_gtod_copy() runs on CPU 0 and __get_kvmclock()
>> later runs on CPU 1 where the raw TSC is lower, the unsigned
>> subtraction wraps.
>> 
>> I wrote a bpftrace tracer (included below) to instrument both
>> functions and captured two corruption events:
>> 
>>   Event 1:
>> 
>>     [GTOD_COPY] pid=2117649 cpu=0->0 use_master=1
>>                 mcn=598992030530137 mkn=259977082393200
>> 
>>     [GET_CLOCK] pid=2117649 entry_cpu=1 exit_cpu=1 use_master=1
>>       clock=8006399342167092479 host_tsc=598991848289183
>>       master_cycle_now=598992030530137
>>       system_time(mkn+off)=5175860260
>>       TSC DEFICIT: 182240954 cycles
>> 
>>     master_cycle_now captured on CPU 0, host_tsc read on CPU 1.
>>     CPU 1's raw RDTSC was 182M cycles lower.
>> 
>>       598991848289183 - 598992030530137 = 18446744073527310662 (u64)
>> 
>>     Returned clock: 8,006,399,342,167,092,479 ns (~253.7 years)
>>     Correct system_time: 5,175,860,260 ns (~5.2 seconds)
>> 
>>   Event 2:
>> 
>>     [GTOD_COPY] pid=2117953 cpu=0->0 use_master=1
>>                 mcn=599040238416510
>> 
>>     [GET_CLOCK] pid=2117953 entry_cpu=3 exit_cpu=3 use_master=1
>>       clock=8006399342464295526 host_tsc=599040211994220
>>       master_cycle_now=599040238416510
>>       TSC DEFICIT: 26422290 cycles
>> 
>>     Same pattern, CPU 0 vs CPU 3, 26M cycle deficit.
>> 
>> kvm_get_wall_clock_epoch() has the same pattern -- fresh host_tsc
>> vs stale master_cycle_now passed to __pvclock_read_cycles().
>> 
>> The simplest fix I can think of is guarding the __pvclock_read_cycles
>> call in __get_kvmclock():
>> 
>>     if (data->host_tsc >= hv_clock.tsc_timestamp)
>>         data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
>>     else
>>         data->clock = hv_clock.system_time;
>
> That might kinda sorta work for one KVM-as-the-host path, but it's not a proper
> fix.  The actual guest-side (L2) reads in __pvclock_clocksource_read() will also
> be broken, because PVCLOCK_TSC_STABLE_BIT will be set.
>
> I don't see how this scenario can possibly work, KVM is effectively mixing two
> time domains.  The stable timestamp from the TSC page is (obviously) *derived*
> from the raw, *unstable* TSC, but they are two distinct domains.
>
> What really confuses me is why we thought this would work for Hyper-V but not for
> kvmclock (i.e. KVM-on-KVM).  Hyper-V's TSC page and kvmclock are the exact same
> concept, but vgettsc() only special cases VDSO_CLOCKMODE_HVCLOCK, not
> VDSO_CLOCKMODE_PVCLOCK.
>
> Shouldn't we just revert b0c39dc68e3b ("x86/kvm: Pass stable clocksource to guests
> when running nested on Hyper-V")?
>
> Vitaly, what am I missing?
>

It's probably me who's missing somethings :-) but my understanding is
that we can't be using TSC page clocksource with unsyncronized TSCs in
L1 at all as TSC page (unlike kvmclock) is always partition-wide and
thus can't lead to a sane result in case raw TSC readings diverge. The
idea of b0c39dc68e3b was that in Hyper-V guests *with stable,
syncronized TSC* we may still be using Hyper-V TSC page clocksource and
thus we can pass it to L2.

-- 
Vitaly


