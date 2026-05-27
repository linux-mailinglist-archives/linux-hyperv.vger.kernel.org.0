Return-Path: <linux-hyperv+bounces-11215-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCWIArGrFmofoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11215-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 10:30:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A0E5E121C
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 10:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11F0C3034AA7
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5603DDDBD;
	Wed, 27 May 2026 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByyduOCB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAg1kkvK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF73D1702
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870629; cv=none; b=n9iJLJeidpswhhcg50Yy2SsiObChvwn1OeUi5HlfClsT2fnmyr0AbO3eKf2d8z6rRf5BhMxVLt7eN5cJoON3s7cq1z7QVPab8sctPHyDYEkTU9iTiZSswkvb/XyuoAiTqdEOyQhGVaf/v7dkZwVHVtIqmRA1UKEDpQASWTbQ45I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870629; c=relaxed/simple;
	bh=kb0kwkVN2uMNWgaZMcdmA3g/oFDrgoG1+NS2Kk3BKEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c62nrw6gNxqsTRQ1ldmTpDMj25dsZ84/o0XF2w9CqSlXUGUQF46AjJkrKxvVNFPHMaBDjHiZkLz674x1NDf4GdiE/VkfGUZMJPGE0NaivHyttatO+M6E7k8iggXWHLubU+Qt3YHmuQ0ns64T+InZvBi9a6tRQ9CLVTqvm6OaLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByyduOCB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAg1kkvK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779870627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kb0kwkVN2uMNWgaZMcdmA3g/oFDrgoG1+NS2Kk3BKEU=;
	b=ByyduOCBIr00CMPT9Sd6j7zq4IS05pzMaXxEM2OfIqbNEzszQhjUVqlVdaHdhb0DDQt/1X
	P4CCGBVeNCHxX/wcJgqLnZkGwnczFCKrabZNC+7uYrsTYDoMNOguNHOVJomciQLqMclNid
	vmAHkTsKax8k2W085yoTUhOKGe0wAg8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-foIiYhsKOraoFTGvCJEigQ-1; Wed, 27 May 2026 04:30:25 -0400
X-MC-Unique: foIiYhsKOraoFTGvCJEigQ-1
X-Mimecast-MFC-AGG-ID: foIiYhsKOraoFTGvCJEigQ_1779870624
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fd396daedso63117895e9.0
        for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 01:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779870624; x=1780475424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kb0kwkVN2uMNWgaZMcdmA3g/oFDrgoG1+NS2Kk3BKEU=;
        b=HAg1kkvKsWuSUCwPOEiR6veHzbkgEBW48Uzjl2faeT2S01GfsgZtKDKsiI+GKNZVhC
         lXFBx35af+SY1k+zNbv0dG495NTPulDNW0n3h2k227SfLB3LPJ/PiSA31s+gqSPnE1Kj
         dYYhwcXzQNtXOb2FmC63GeKwlffuwBTCElN/55WIRU6Kj6jVhUKnBV5JHZxqBjNFt8zv
         ZKVvw4GvckRK61hpppS2Fwl0Ww8tH9K3LhMr6p8NYh/zDW8U0kPaT/Ts2x6Aya/N5cLD
         DfDbzFJce9Srg8B+pa2SeWOxgzUC9eR4G9QRVloQfcHnsEGgG4fXJwRsIyZtKtEa+Nnn
         xViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779870624; x=1780475424;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kb0kwkVN2uMNWgaZMcdmA3g/oFDrgoG1+NS2Kk3BKEU=;
        b=QoEH2eh1Y5acgfEKXfBF6nq3MLHqZGE9KU9v48/wYAnoI7pgjtIkOWR0G3OGqF5abe
         I1Dh/Zbo7qOx/7mCrIkter6oWj42j8L+2RkgLXXBJiBeG2uSPFZbcw+VsRF51/aTG4nc
         dxS/eIl6dNHiIpMQA85aQ+ar0/9dEzcBmsZUs8eb4bN2TDMKZXCcM+ItDnbIdVIMY9vx
         JyaLv7yV3SR1iA47mv7yYk0Jj0LpYIQedpruQCA3tmauJ4c01gk4zz5nnsFAXaC56BQ2
         xO3IeV9ODFVqS87h3FSRdnF3oPIb3X+i7gEcXz8aVgqP6KQCk+x/Mxgf6moo+mQLEx9A
         RW/g==
X-Forwarded-Encrypted: i=1; AFNElJ92TwjoNVZaQczGijKZHFU3EzOGtuKiA9KXfNEwDkaseqdJDK8UrhI2JmKz4gfFRGXsTo/dzny28OkapZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN7cfGfxkGCkCitzEQj0pKaOwf3onI7wA3mFE7d04N/Hstk5br
	YWUoeXv8QerkdjLADYoNd7RCoVGYv0byh/y78Y5d1XjSW+H3IKPqNA2thWx0RW60SsmQnu2hiXF
	+RbP8L0FrvBgzX63PgGsflOwjCqVFzakhZcrz+manHrF6a9FCu5q1obN26su0rrs36w==
X-Gm-Gg: Acq92OEGxwO3z2ESmHQLmsnkTSeW0Ju0mQ0jdBBQIncy7dcicQhZuhue1a0u5KIq37X
	6woSWdHlYfFHoDbSkE1H+wJ5v5GAHBDwmh2szDmYUEJV+KD1ApeYK2/EUePKqMCEC2/vZPgwhwa
	CkIRKaY3+/kGkGALVL+OZycbqapbmLhf6dgikDHHeGLTz8JUUgIlhzfqYjjdPhF5hD+X/yp4hWC
	VlNjlEYG7tVEUFNGvV0tmJ98eD3/glcKB9jFjlq1ehnOwihkPi+NPixpXsZv08ZOOczx+0JN10t
	JNfEzvLbPb784xdfIvd0CA+KOVhL1swhoNMayza+w9Lwwn7go9JglcraaiqJNKlmw1ARh0LRfLy
	+1ex5zZp8zEZdY5sx+Re/0rSM3qAiAguqbA==
X-Received: by 2002:a05:600d:8499:20b0:48a:5970:1fe1 with SMTP id 5b1f17b1804b1-4904248ad4cmr277017185e9.4.1779870624320;
        Wed, 27 May 2026 01:30:24 -0700 (PDT)
X-Received: by 2002:a05:600d:8499:20b0:48a:5970:1fe1 with SMTP id 5b1f17b1804b1-4904248ad4cmr277016485e9.4.1779870623765;
        Wed, 27 May 2026 01:30:23 -0700 (PDT)
Received: from fedora (nat-20.ign.cz. [91.219.240.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908098f782sm11525835e9.17.2026.05.27.01.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:30:23 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner
 <tglx@kernel.org>, John Stultz <jstultz@google.com>, Michael Kelley
 <mhklinux@outlook.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, "Christopher S. Hall"
 <christopher.s.hall@intel.com>, Stephen Boyd <sboyd@kernel.org>, Miroslav
 Lichvar <mlichvar@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] KVM/x86: Killing kvm_get_time_and_clockread() in favour
 of ktime_get_snapshot()
In-Reply-To: <b4895a532344ba6a879d922be8536f9000cd398c.camel@infradead.org>
References: <b4895a532344ba6a879d922be8536f9000cd398c.camel@infradead.org>
Date: Wed, 27 May 2026 10:30:21 +0200
Message-ID: <87zf1ljluq.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11215-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[infradead.org,google.com,redhat.com,kernel.org,outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkuznets@redhat.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Queue-Id: 75A0E5E121C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Woodhouse <dwmw2@infradead.org> writes:

...

>
> Then in 2018, Vitaly Kuznetsov added Hyper-V TSC page support in
> commit b0c39dc68e3b ("x86/kvm: Pass stable clocksource to guests when
> running nested on Hyper-V"), which extended vgettsc() to handle the
> HVCLOCK case.
>
> I'd quite like to kill it all with fire and make KVM use
> ktime_get_snapshot() instead.

The main motivation is reducing the complexity of KVM's timekeeping code
I guess?

>
> However, to correlate with the TSC provided to guests, KVM needs the
> underlying host TSC counter value, *not* the cycles count from the
> hyperv_clocksource_tsc_page clocksource which is scaled to 10MHz.
>
> If we wanted to support master clock mode while nesting under KVM and
> bizarrely using the kvmclock for system timing, we'd have the same
> problem with the kvmclock clocksource, which similarly scales to 1GHz.
>
> One option is to say "Don't Do That Then=E2=84=A2": if you want to provid=
e a
> masterclock kvmclock to guests then *don't* use the silly pvclocks for
> your own kernel's timekeeping, use the damn TSC. Because if the TSC
> *isn't* reliable then you can't do masterclock mode for your guests
> anyway.

The statement "TSC isn't reliable" deserves a book of its own :-)
Historically, we've seen all sorts of issues with it, but by the time of
b0c39dc68e3b, they were mostly gone. The real problem the Hyper-V/Azure
folks were solving back then was that while the TSC *was* reliable
(synchronized across CPUs, not jumping backwards, stable frequency,
...), tons of hardware out there (Azure is quite big) did not support
TSC scaling. VMs on Azure don't migrate very often, but they do migrate
when hardware maintenance is needed. Migrating to a host with a
different TSC frequency would've been a problem, so the Hyper-V TSC page
was introduced. Note: it is a *single* page for all CPUs, so the
clocksource was never intended to be used in a situation where TSCs are
unsynchronized across CPUs.

To deal with migrations, the Hyper-V folks came up with a mechanism
called 'reenlightenment notifications', and we support it in KVM. It's
not really great, as we need to stop all the nested VMs, but it does the
job: we can re-compute guest PV clocksources (kvmclock, TSC page,
... Xen?) and live happily ever after.

>
> Perhaps that should have been the response when commit b0c39dc68e3b was
> submitted, but I guess we're stuck supporting that mode now.

Times are changing, and it is becoming increasingly difficult to find
x86 hardware without TSC scaling support. Linux guests on Hyper-V now
prefer TSC if possible (HV_ACCESS_TSC_INVARIANT; see, e.g., commit
4c78738ead4e), so I expect that in a few years, there will be no need
for the Hyper-V TSC page clocksource or the reenlightenment logic
anyway.

> But I really do want to kill the KVM hacks and use ktime_get_snapshot().
>
> Reverse-engineering the original TSC reading from the clocksource
> counter value doesn't look sane, without a loss of precision and/or
> 128-bit division.
>
> One simple option that occurs to me would be to add a 'cycles_raw'
> value to the system_time_snapshot, for PV clocksources like hyperv and
> kvmclock to populate with the original TSC reading.

Personally, I don't see this as such an ugly hack.

>
> That might actually let us clean up some of the PTP code that currently
> has to deal with TSC vs. kvmclock in counter snapshots too. I think I
> could kill the use of get_cycles() in vmclock for the kvmclock case,
> which might make Thomas happy...
>
> Any better ideas?

--=20
Vitaly


