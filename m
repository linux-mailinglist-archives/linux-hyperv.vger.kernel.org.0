Return-Path: <linux-hyperv+bounces-10053-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGk4JWRX1Wmu4wcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10053-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 21:13:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 115FB3B348C
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 21:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00EBB30082B4
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2026 19:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6718A34AAF7;
	Tue,  7 Apr 2026 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvluTWE0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD7344020
	for <linux-hyperv@vger.kernel.org>; Tue,  7 Apr 2026 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589217; cv=pass; b=XEAJybalu+ffl82Ac1mKU2Mi2PlGOfgi8151/4Sq5oZ84a0qqYSyh1C+jBwTojMpfnkLzEY+5dhn3RvYZoZro6SEu+kUsb0Lqzj3ZiPfmrs0e4HdpA13a4f9A2t4GzwoUBAOpX+HEhpG7hPrglAsnwUzMjTkpa5s+t4Sqt0t9OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589217; c=relaxed/simple;
	bh=70tWaAzZa+jzrQnDv2R9Rxn4KZ9eR0MLbNZz/k7omYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0zAmW9iIq6iOT4y30WdccEvjxIdDtbb6YbmHtaEETrxiv92u5fb3+32XtbTA3KRHCZs8nqAVKNNUiCxGFlTAZJo3Z3NuAMA0QNDgmjTzWpe/HTvsCqnBUcct2Et0AwMZ7I6apHNGydeuwO4MGKFc7wBegzi2EJReQxi0wKVRqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvluTWE0; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82cf636dac8so2512278b3a.3
        for <linux-hyperv@vger.kernel.org>; Tue, 07 Apr 2026 12:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775589215; cv=none;
        d=google.com; s=arc-20240605;
        b=Ts/Y8RVGVABX3woT1ZHzZGoE/z2xhZ3NxxA2xxWASspYnYap07MyG1fVsUzpnnySim
         RPMntnilNNeTJtbeH13VUhOqrYqVKnbIPJG8T1U+v5nsUWww4Ldi+14DXvvSgNMt7+Ou
         48Zxocl5kMZPcARdMEu+g3aVJ7APSEX5qoP491wbrc2rEkH+I2WWX+hpbAwdcqcBTFnP
         9Uu+0HmayYdtAnhTiVyuAQePk1BDVNMjqZPpPRqFAi6rfjOiy2GUAW0luKuCgAQfBYKo
         OQmvE2jNUjjINRugaUJ8JF3Om4cK7jklh1un+Dx243W0hZYNYCwU6MeUah0Oh6kO2Lwo
         HaQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKKNNefQ6F4KOIwdpnmoM01ICjxZ7ueWf3b8LgkodGg=;
        fh=3eqj7ejLguGjcSquybDZPOYcgnuM6DtctI3fpNT6/Oo=;
        b=QAtapFiZCrrHbAPlnL6Gn3/466LT3Yvyb7ZDPvb0yzBWLUhD71YDp7VhaSLuuxGOaI
         AhWSPO/IGJ/3ftJjLwsViy3XXj92WSHa0yEbulIH094JMbyAV766AbWDui6Qxx122RuL
         zaJkmL10aRtuYjc2TKYw9uAtOruYWGrsv3JZyLBaYQ/Atl5vEC67eEQCMh6IYrXJfoSl
         77RxWUu0gws/gjI3keo0ymGskjCMy7S3ymJ+Wev3s7Qo9ryHXGJiD2pCEISOdVdADEed
         i+TKGzkHOwRCJVsFRh4cKn+e6mSAUn355V1uRTADlNGs71aPWOYYOB5dyw64IgBDy5P4
         Fscw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775589215; x=1776194015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKKNNefQ6F4KOIwdpnmoM01ICjxZ7ueWf3b8LgkodGg=;
        b=OvluTWE0YhnreMuM0K9gWAZYMBLSYPuD/jIyvn5B/C7deIU1zqDjKrzyws17zmLUM3
         xsR1fi2Co8Ousq2u6cUTeAUSGyiczwL73NgpA5ECyLMj46E5g/E7BKUTP2nLsXiqYNb9
         1s1LctPWvcDkHo2G07zIfPMtaYVb3kWCBnDck4deQNqgN+EEyyHKTb8010ZSdACIhdUr
         48zq0Nimii9FsLKKk9eM4wWMc5USPm5YKiXxZqUqP76sm0YsTnmtSMatzWS/IraUR9nD
         mPSAOkXCROq+al+5UHftVqB3723JgKSmGK2TrmfAhRmokQw/6n8JP6d902/tGsRmncSt
         xRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775589215; x=1776194015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKKNNefQ6F4KOIwdpnmoM01ICjxZ7ueWf3b8LgkodGg=;
        b=ZVmrXQkoerZrMpZVZFUVouP+dTdNB9IxAuO83Jl5h4+08mkPuRMQdbipsmUtjx0ke9
         RWfoIdi7DpwWaYyAuTZ7QM2Hp3Nl4Tqr0wJzXuLZSD3bZyjjCOE3R2AKCLHSPTXnJzao
         b9bTCvZJUN5Vbw5zTTaKOAG/1ABXHlWFtrsd08QLu5QjFgxgca+72eupDGQOi6rZEZ4Y
         ZVj32nk5SyCIycppPM2tF+YRjXfPC6sYi+nVCdZlfLYquEqArBQYpuvHW3AkK9Fh91rn
         LthQn0VpkdcLHl9lIjq3GWNAP+t5uSrxNAeHp8yCp88RFcL+4PcVtnUMyHu6H6cURgXT
         w8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWtYeWxnnjyuzD4lOM4Au6rUupTVNcEgUwuOX8zESz85njC++uOXVwuOFL2zQTSbDfst/jDde0rhyYLsts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUq/jnEV5kDGy9AFjzTs800DEWO+49nVJPlGpK8WsL4g1H/6Lw
	KSzmOXiDDMXKls8rkZNLWoq37LuSOaBAEGG/YoCXmnyTixuhpgYa2oQmhC8SKHyEiipotk0YoJu
	rIgrCLK0git+HLHAiTzSyeY9qEOKQW7Lf3hH4
X-Gm-Gg: AeBDiesozAH4jDudB0WITCb3tC8CRrWJCzUdhfIXmXXq+zZcr+oPTFOZ7R1Ix9yr6MY
	EGWvgNL/BQ6JQ/9LDCsSf5EslrbYjnM94+DNmCxDAmPk8kugrvpiP/GyAhyXZUwRtJfzyzlVEgb
	lvXkLesuRW72kU5V4AlyurHfIaNvt919HdIVG/sx9/89L+aCZYWH+DRWps3e0XkBSR3XML2jYci
	9py2kfr8pSuAY3Fct64awwxvgxz+vOHXwUtF5z4rM1a+yk8CyliqmxnKpC/rissG+W2Axtqhwxs
	h63H1RzfOAcQZdh8m8Pje2oNAkjb/2PTsEWSwUdnsaYcCFWcQIo=
X-Received: by 2002:a05:6a00:13a3:b0:82c:6aee:b232 with SMTP id
 d2e1a72fcca58-82d0dbb6bcemr17847195b3a.45.1775589215239; Tue, 07 Apr 2026
 12:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
 <87v7e3mbgj.fsf@redhat.com> <adU0LAW1h8q9HsGu@google.com> <SN6PR02MB4157F82E4907C1B3305E86D5D45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157F82E4907C1B3305E86D5D45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Thomas Lefebvre <thomas.lefebvre3@gmail.com>
Date: Tue, 7 Apr 2026 12:13:24 -0700
X-Gm-Features: AQROBzB6n2L3p3eiSH6AzW8E7pKt0evKvgrqHUehDDdOUES-tfa9ZTYQ7r_VkSM
Message-ID: <CAKdXbaXdSWq-NYk8z6_OtSgb6xsp+GJxrnF2iBMRdk0nfYne=A@mail.gmail.com>
Subject: Re: [BUG] KVM: x86: kvmclock jumps ~253 years on Hyper-V nested virt
 due to cross-CPU raw TSC inconsistency
To: Michael Kelley <mhklinux@outlook.com>
Cc: Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-10053-lists,linux-hyperv=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomaslefebvre3@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,outlook.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 115FB3B348C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi everyone, thank you for your attention to this bug report.

Michael,

1. No, lscpu in the L1 guest does not show the flags "tsc_reliable"
and "constant_tsc".
$ lscpu | grep tsc_reliable
$ lscpu | grep constant_tsc
$ cat /sys/devices/system/clocksource/clocksource0/current_clocksource
hyperv_clocksource_tsc_page

2. Windows 10
Version 22H2 (OS Build 19045.6466)

3. Hyper-V: privilege flags low 0x2e7f, high 0x3b8030, ext 0x2, hints
0x24e24, misc 0xbed7b2

4. Yes, the laptop hibernates and then resumes.
When the problem occurred, the laptop had gone through multiple
hibernate and resume cycles.
I haven't seen it happen after a full reboot before a hibernate/resume cycl=
e.

Thomas

On Tue, Apr 7, 2026 at 11:37=E2=80=AFAM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Sean Christopherson <seanjc@google.com> Sent: Tuesday, April 7, 202=
6 9:43 AM
> >
> > +Michael
> >
> > On Tue, Apr 07, 2026, Vitaly Kuznetsov wrote:
> > > Thomas Lefebvre <thomas.lefebvre3@gmail.com> writes:
> > > > Under Hyper-V, raw RDTSC values are not consistent across vCPUs.
> > > > The hypervisor corrects them only through the TSC page scale/offset=
.
> > > > If pvclock_update_vm_gtod_copy() runs on CPU 0 and __get_kvmclock()
> > > > later runs on CPU 1 where the raw TSC is lower, the unsigned
> > > > subtraction wraps.
> > > >
> > >
> > > According to the TLFS, reference TSC page is partition wide:
> > >
> > > "The hypervisor provides a partition-wide virtual reference TSC page
> > > which is overlaid on the partition=E2=80=99s GPA space. A partition=
=E2=80=99s reference
> > > time stamp counter page is accessed through the Reference TSC MSR."
> > >
> > > so if as you say RAW rdtsc value is inconsistent across vCPUs, I can
> > > hardly see how we can use this time source at all, even without
> > > KVM. scale/offset are the same for all vCPUs.
> > >
> > > I think the fix here is to avoid setting up Hyper-V TSC page clocksou=
rce
> > > in L1. Unfortunately, with unsynchronized TSCs this will leave us the
> > > only choice for a sane clocksource: raw HV_X64_MSR_TIME_REF_COUNT MSR
> > > reads.
> >
> > This feels like either a Hyper-V bug or a Linux-as-a-guest bug.  For "R=
eference
> > Counter"[1]:
> >
> >   The hypervisor maintains a per-partition reference time counter. It h=
as the
> >   characteristic that successive accesses to it return strictly monoton=
ically
> >   increasing (time) values as seen by any and all virtual processors of=
 a
> >   partition. Furthermore, the reference counter is rate constant and un=
affected
> >   by processor or bus speed transitions or deep processor power savings=
 states. A
> >   partition=E2=80=99s reference time counter is initialized to zero whe=
n the partition is
> >   created. The reference counter for all partitions count at the same r=
ate, but
> >   at any time, their absolute values will typically differ because part=
itions
> >   will have different creation times.
> >
> >   The reference counter continues to count up as long as at least one v=
irtual
> >   processor is not explicitly suspended.
> >
> >
> > And then "Partition Reference Time Enlightenment"[2]:
> >
> >   The partition reference time enlightenment presents a reference time =
source to
> >   a partition which does not require an intercept into the hypervisor. =
This
> >   enlightenment is available only when the underlying platform provides=
 support
> >   of an invariant processor Time Stamp Counter (TSC), or iTSC. In such =
platforms,
> >   the processor TSC frequency remains constant irrespective of changes =
in the
> >   processor=E2=80=99s clock frequency due to the use of power managemen=
t states such as
> >   ACPI processor performance states, processor idle sleep states (ACPI =
C-states),
> >   etc.
> >
> >   The partition reference time enlightenment uses a virtual TSC value, =
an offset
> >   and a multiplier to enable a guest partition to compute the normalize=
d
> >   reference time since partition creation, in 100nS units. The mechanis=
m also
> >   allows a guest partition to atomically compute the reference time whe=
n the
> >   guest partition is migrated to a platform with a different TSC rate, =
and
> >   provides a fallback mechanism to support migration to platforms witho=
ut the
> >   constant rate TSC feature.
> >
> > My read of "Partition Reference Time Enlightenment" is that it should o=
nly be
> > advertised if the TSC is synchronized and constant.  I can't figure out=
 where
> > that feature is actually advertised though, because IIUC it's not the s=
ame as
> > HV_ACCESS_TSC_INVARIANT, which says that the virtual TSC is guaranteed =
to be
> > invariant even across live migration.  And it's not HV_MSR_REFERENCE_TS=
C_AVAILABLE,
> > because I'm pretty sure that just says HV_MSR_REFERENCE_TSC is availabl=
e.
> >
> > Michael, help?
> >
> > [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows=
/tlfs/timers#reference-counter
> > [2] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows=
/tlfs/timers#partition-reference-time-enlightenment
>
> Yes, TSC page enlightenment is per VM, so it does not compensate for
> discrepancies in raw TSC values across physical CPUs. RDTSC in a
> Hyper-V VM is executed directly by the hardware (i.e., does not trap to
> the hypervisor), so there's no opportunity for the hypervisor to compensa=
te
> for discrepancies. The hypervisor is expected to present a VM with TSCs
> that are already synchronized. I'll need to double-check, but I don't thi=
nk
> Linux guests on Hyper-V run their own TSC synchronization.
>
> The relevant Hyper-V flags are:
> * HV_MSR_TIME_REF_COUNT_AVAILABLE:  The synthetic MSR for reading
>    the partition reference time is available.
> * HV_MSR_REFERENCE_TSC_AVAILABLE: The partition reference time
>    enlightenment (i.e., "the TSC page") is available as a faster way to r=
ead
>    the reference counter.
> * HV_ACCESS_TSC_INVARIANT: As Sean said, this says the hardware and
>    Hyper-V support TSC scaling, so live migration can be done across host=
s
>    without the guest seeing a change in TSC frequency.
>
> Yes, this does feel like an issue where Hyper-V is not presenting the gue=
st
> with TSCs that are already synchronized. But I'm not aware of having seen
> such a problem before. I'll try to imagine a scenario where a problem lik=
e
> this could happen via some other path.
>
> @Thomas Lefebvre:  Let me double-check a few things via these follow-up
> questions/actions:
>
> 1. You said the clocksource is hyperv_clocksource_tsc_page. Just to
> confirm, that's for the L1 guest, right? Does the output of the "lscpu"
> command in the L1 guest show the flags "tsc_reliable" and "constant_tsc"?
> I'm assume "no", since if these flags were set, the clocksource (i.e.,
> /sys/devices/system/clocksource/clocksource0/current_clocksource)
> should be the standard "tsc". I've got a laptop with a i7-13700H processo=
r,
> and my L1 VMs show "tsc" as the clocksource, but I haven't been running
> KVM with L2 nested VMs.
>
> 2. What is the version of Windows/Hyper-V you are running? Get the
> output of the "winver.exe" command. It should be something like this:
>
> Windows 11 [as the top banner]
> Version 25H2 (OS Build 26200.8037)
>
> 3. In the dmesg output of your L1 VM, find the line like this one and rep=
ly
> with what you have:
>
>     Hyper-V: privilege flags low 0xae7f, high 0x3b8030, hints 0x9a4e24, m=
isc 0xe0bed7b2
>
> From there, I can decode the Hyper-V settings and see if anything jumps o=
ut
> as anomalous.
>
> 4. Does the laptop where you are seeing this problem ever hibernate and
> then resume? If so, do you recall if the problem occurs after a full rebo=
ot but
> before it ever does a hibernate/resume cycle?
>
> Michael

