Return-Path: <linux-hyperv+bounces-11217-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIoPNS+wFmokogcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11217-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 10:49:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC125E14F7
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 10:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53903300B76B
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 08:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827273E2768;
	Wed, 27 May 2026 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qt8hjK6T"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7349218ADD
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871789; cv=none; b=OHopazmpPjEFYcDftqMTHFi7aeeMwFnt5u9k1VceGOQjqqT6rMLfwDJUCyNUdkJUBbwrcQduaZ561ZFZzNPtZ1Jdz0z7P4nQAJmHrifH+lvtKzL8s9nhAbmoL9cFf4mCcMJrcCRRJiLVJv0y73GCjWX8w/Krs7UNVunwbQyhM4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871789; c=relaxed/simple;
	bh=8mwV/3RT8AF7FRSpqsuS9Hn/ROGx+ckdxnqbnTpmGh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kD2lspwegQhXxdPAxlQun/RtA8mB14fqdywe7ATyVpFJNuYgdKc0aXmKNyeO4KNswTWbW2o0k1n9rYEgVBboxHuqMRs5jYPxgKxuDiTVed/+4Y/mcJvxZNmA3b+/xwsxjFmoQWJS7X/S69cS/mIdh0Pl7W3Xd7Yb6IHy6jHAe20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qt8hjK6T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779871787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2NLOfdHH3QksKJfjHy1RgDXCNjFEJ10Iq9DHsTH8IKA=;
	b=Qt8hjK6TZtshCYAvIMmmjtcLyvhrEptUxV7+t7lDeb9qSN9v0ucJkxYr9OUDe4Mduu2Ovk
	+6acuYls/uR7vzV46sOryT2swN2b9Xy8XKwXoyBidEA7k90t4F/evPEhuNRh3uKWGxNeTA
	v8ufgS00pqhdt5krCJIx8jC1ql9+TOo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-U_1MO9hpMFSgFy6qA43fGg-1; Wed,
 27 May 2026 04:49:42 -0400
X-MC-Unique: U_1MO9hpMFSgFy6qA43fGg-1
X-Mimecast-MFC-AGG-ID: U_1MO9hpMFSgFy6qA43fGg_1779871779
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22326195604F;
	Wed, 27 May 2026 08:49:38 +0000 (UTC)
Received: from [10.44.32.217] (unknown [10.44.32.217])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4ED1D1800357;
	Wed, 27 May 2026 08:49:30 +0000 (UTC)
Message-ID: <d68c60d1-1475-494b-9abb-d0ec2b52b99a@redhat.com>
Date: Wed, 27 May 2026 10:49:28 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] KVM/x86: Killing kvm_get_time_and_clockread() in favour of
 ktime_get_snapshot()
To: David Woodhouse <dwmw2@infradead.org>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
 John Stultz <jstultz@google.com>, Michael Kelley <mhklinux@outlook.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Christopher S. Hall" <christopher.s.hall@intel.com>,
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
References: <b4895a532344ba6a879d922be8536f9000cd398c.camel@infradead.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <b4895a532344ba6a879d922be8536f9000cd398c.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11217-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[infradead.org,google.com,kernel.org,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4CC125E14F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 15:57, David Woodhouse wrote:
> In 2012, as part of implementing the "master clock" mode for kvmclock,
> Marcelo added kvm_get_time_and_clockread() in commit d828199e8444
> ("KVM: x86: implement PVCLOCK_TSC_STABLE_BIT pvclock flag").
> 
> In 2016, Christopher Hall added the generic ktime_get_snapshot() in
> commit 9da0f49c8767 ("time: Add timekeeping snapshot code capturing
> system time and counter"), which provides the same paired read of
> { time, counter } through the core timekeeping code.
> 
> Then in 2018, Vitaly Kuznetsov added Hyper-V TSC page support in
> commit b0c39dc68e3b ("x86/kvm: Pass stable clocksource to guests when
> running nested on Hyper-V"), which extended vgettsc() to handle the
> HVCLOCK case.
> 
> I'd quite like to kill it all with fire and make KVM use
> ktime_get_snapshot() instead.
> 
> However, to correlate with the TSC provided to guests, KVM needs the
> underlying host TSC counter value, *not* the cycles count from the
> hyperv_clocksource_tsc_page clocksource which is scaled to 10MHz.
> 
> If we wanted to support master clock mode while nesting under KVM and
> bizarrely using the kvmclock for system timing, we'd have the same
> problem with the kvmclock clocksource, which similarly scales to 1GHz.
> 
> One option is to say "Don't Do That Then™": if you want to provide a
> masterclock kvmclock to guests then *don't* use the silly pvclocks for
> your own kernel's timekeeping, use the damn TSC. Because if the TSC
> *isn't* reliable then you can't do masterclock mode for your guests
> anyway.
> 
> Perhaps that should have been the response when commit b0c39dc68e3b was
> submitted, but I guess we're stuck supporting that mode now. But I
> really do want to kill the KVM hacks and use ktime_get_snapshot().
> 
> Reverse-engineering the original TSC reading from the clocksource
> counter value doesn't look sane, without a loss of precision and/or
> 128-bit division.
> 
> One simple option that occurs to me would be to add a 'cycles_raw'
> value to the system_time_snapshot, for PV clocksources like hyperv and
> kvmclock to populate with the original TSC reading.
> 
> That might actually let us clean up some of the PTP code that currently
> has to deal with TSC vs. kvmclock in counter snapshots too. I think I
> could kill the use of get_cycles() in vmclock for the kvmclock case,
> which might make Thomas happy...

Yeah, when reading I was thinking of PTP as well.  Seems worthwhile.

Paolo


