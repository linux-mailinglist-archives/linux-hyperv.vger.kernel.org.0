Return-Path: <linux-hyperv+bounces-2766-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9FF94FE05
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Aug 2024 08:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF231F21D0A
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Aug 2024 06:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAD63BBC5;
	Tue, 13 Aug 2024 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P7rkgZDX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBFA1CD23;
	Tue, 13 Aug 2024 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723531216; cv=none; b=QLEt0GTrZJOD8tAs65Ta5FDcc0k2ivOh45JNZvO/U1r7fGuhbXa9ea4oFoHJze/hFytcdSPU7zvm6bo5/wy2d8p0HZJ6BoVzY/dQkOytaWzjZCSH1jfZFOzcl86XimYP4RCsK2V5GmntIB5LqzgnOpilW6VesUepbyQ4bZMVIgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723531216; c=relaxed/simple;
	bh=eiYImyIe+mYjjDD8xoPOCd/hI2KuNIuxHNorm1aWa00=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Q+omTF25YDllZbJs0CVXvvwiPwS9BG6vdSoAcSsP0bo0hH/WP1xEWCeshUu5f+/Ipv/m4kOFxnJEmwO3sbjDiOJpmxrSXyZhxG3mjklxiNJ4+9xiFu6StZ5XV8vMtzK9QdLf2H8HaJEKDnOM39+sMyj6l0q9sipTTHTYAcHhIT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P7rkgZDX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=x6xW72eBbWVaT+8NJmpt2BbFpDPPo+52uKh39Es5tzM=; b=P7rkgZDXPAcSh3DJ7mBNjP3z6s
	ItrrNL1K6IJAE9O4ITaSiUeL8R5XscIDB7ozUMlRHM4Jmbokwg9YAsXB1hyFxwrcIg9FvB2NB0kV1
	t5a9QuJYN099pcrF7/ugyTvo2r4D9BYino8Wmho2ycwT6ETMg1zjy1Z072huUF5DsohEeWX9uB4Io
	sewVC04a7CuG2boXbTOCFdQohPYscvJBg4Gr+LDWnFYjtDtaZj6xn6mi+KUo+I/eX2B/DWDz4sv99
	98vO/d3Ny1UKvVst7PtKN5pUsw57D7dHPZmGb+2Qm295m2EZixSoJUHhFyWfa6YgCAN0sQZvwjhAs
	rqhip9tQ==;
Received: from [2a00:23ee:1958:1906:2ed8:c63c:8737:bcca] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdlCF-00000007iJU-1EG0;
	Tue, 13 Aug 2024 06:39:56 +0000
Date: Tue, 13 Aug 2024 07:39:51 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Michael Kelley <mhklinux@outlook.com>,
 "lirongqing@baidu.com" <lirongqing@baidu.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_clockevents/drivers/i8253=3A?=
 =?US-ASCII?Q?_Do_not_zero_timer_counter_in_shutdown?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Zrqh7GlPMRVOVtvY@google.com>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com> <87ttg42uju.ffs@tglx> <SN6PR02MB41571AE611E7D249DABFE56DD4B22@SN6PR02MB4157.namprd02.prod.outlook.com> <87o76c2hw2.ffs@tglx> <30eb7680b3c7ae5370dfbf7510e664181f38b80e.camel@infradead.org> <ZqzzVRQYCmUwD0OL@google.com> <35624750846f564e6789c22801300a542cafa7fb.camel@infradead.org> <Zrqh7GlPMRVOVtvY@google.com>
Message-ID: <B8008048-5D99-4B78-B63F-862207F78D73@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 13 August 2024 00:59:40 BST, Sean Christopherson <seanjc@google=2Ecom> w=
rote:
>On Fri, Aug 02, 2024, David Woodhouse wrote:
>> On Fri, 2024-08-02 at 07:55 -0700, Sean Christopherson wrote:
>> > On Fri, Aug 02, 2024, David Woodhouse wrote:
>> > > On Thu, 2024-08-01 at 20:54 +0200, Thomas Gleixner wrote:
>> > > > On Thu, Aug 01 2024 at 16:14, Michael Kelley wrote:
>> > > > > I don't have a convenient way to test my sequence on KVM=2E
>> > > >=20
>> > > > But still fails in KVM
>> > >=20
>> > > By KVM you mean the in-kernel one that we want to kill because ever=
yone
>> > > should be using userspace IRQ chips these days?
>> >=20
>> > What exactly do you want to kill?=C2=A0 In-kernel local APIC obviousl=
y needs to stay
>> > for APICv/AVIC=2E
>>=20
>> The legacy PIT, PIC and I/O APIC=2E
>>=20
>> > And IMO, encouraging userspace I/O APIC emulation is a net negative f=
or KVM and
>> > the community as a whole, as the number of VMMs in use these days res=
ults in a
>> > decent amount of duplicated work in userspace VMMs, especially when a=
ccounting
>> > for hardware and software quirks=2E
>>=20
>> I don't particularly care, but I thought the general trend was towards
>> split irqchip mode, with the local APIC in-kernel but i8259 PIC and I/O
>> APIC (and the i8254 PIT, which was the topic of this discussion) being
>> done in userspace=2E
>
>Yeah, that's where most everyone is headed, if not already there=2E  Lett=
ing the
>I/O APIC live in userspace is probably the right direction long term, I j=
ust don't
>love that every VMM seems to have it's own slightly different version=2E =
 But I think
>the answer to that is to build a library for (legacy?) device emulation s=
o that
>VMMs can link to an implementation instead of copy+pasting from somwhere =
else and
>inevitably ending up with code that's frozen in time=2E

Some would say the right answer is to present a micro-vm machine model tha=
t doesn't have any of that crap at all=2E

Sadly we're going in the wrong direction=2E For >255 vCPUs on AMD machines=
 it looks like we even have to emulate a full virtual IOMMU with DMA transl=
ation support=2E Well done, AMD!

(Linux is OK with the 15-bit Extended Destination ID, but not Windows)

