Return-Path: <linux-hyperv+bounces-11066-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NJhM/D5DWq75AUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11066-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 20:14:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B089B5959CD
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 20:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC05D308A131
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 17:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2C23F44CD;
	Wed, 20 May 2026 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNQ7b4HH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973973EF0C1
	for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299800; cv=none; b=tXWMZBPDq1qB7bopfNxXEubpZH4dW5EskR88Q2kIHZ7ijYFp5cCkwjoKHvQ0RrEWBX9QZrvFVC9VqMEmXWTqYZlPAOzxdgR0Uom88lOGKQtmV5BR+rtdiBYinWkArnLw+QgD9Y0uSkfQvfaJwvhkyodc9P4nkgeftU+N/erM/+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299800; c=relaxed/simple;
	bh=Dublram4OvvOps1rJjL7126QT2HdDhXkpgA6+9a2oHg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nBPqgcwaUDc2zojORYqy9N4AlimzwdsKHrRFrBNlZgBC975I88k61wPdVLcHI7tLjAOd9ax/jYgXgYE3CPhgGx8mHUAQkze3ARnmJ+QdyUUXZOjLmPRzRpu0QSeOoB7njrjPGZHxN7lg5IqJ3L/W8Y4xopk7cz8UJkm+ptCyAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZNQ7b4HH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c799ee56bd6so2623464a12.2
        for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779299799; x=1779904599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6+hlvnmwj5Awnxfo2Fw5NZ8DPJZlHGIf0en9UEe6nA=;
        b=ZNQ7b4HHVu8R6qv8LTUxL4dR44jD44MWk/MDl1BNiCE+5uh+0JKmlS4fhp+HURwFrj
         Gk6pKnB7FMsWp1amzm9rKvj802x7figPjLERIP0w/cvVMgyUsmXA1WDM92duiJDqm5L7
         0b/U3tx85vj52U7yNmk7LNe1uBRY5rdqRP8hyE+NbZc1DMbKer/esShw+o1AnxSFyR3Z
         Y7t1U+Uh4ZqONM3Yoe/MPEXohGKeA6W3q/IvWAYS+1mEL8A18+HK1QjbbzrCMa0ZEgo9
         g8FI1jzEMHqInZQ5ly+TjyIWBAdpCe2p72j178NEcrsL2YaDcmJbNmxIQUoXamIXADoA
         rTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779299799; x=1779904599;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s6+hlvnmwj5Awnxfo2Fw5NZ8DPJZlHGIf0en9UEe6nA=;
        b=MaQ1L9mySpnp9viOeos/4hkB7Y9rLVsn7PwDBu+pLTFxa7Xv7evkLiEPJCUJNsGV1m
         7r91br5ljCtvd0R9hqz8fDss+79FYpxk+jLWSXsZjdJo0/L3sOyRv2Wf0SxtYNYs+YX4
         oGZDHDqE5S/8dYVOH73aCCv1sHMn+uCVKrvutMOTYSt41ghICjyFcNwNf0f78WiZv8c6
         3K+neerqiurvPZmX7OZaeExn0BHfBU2Jb0LhGqT3kLsokvP+wXLmOVTKlZU/IfSq1B/K
         4iHNte7B034VPHefmUsEOuCtuN3EdB+b88Zbk4j0JYofy7r2oNR8AxffqvnGvRQKC9EG
         48aQ==
X-Forwarded-Encrypted: i=1; AFNElJ90qO6662aSxr5hOJutCderJ8lBiQLrSt8KqExtfGK/+tBrKQG/VmzaMfuYVd/Gwuu0OdBlSCZI7hgysGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHhk3vxsE1IetGjGKcvu88mTKtizy1mVB2gzyzSk4NbPSUyvbV
	rAnBhD94chOxypbYgQPBc6GBKoAPIjv96pI8JvwjSkgM3d8Q/85p1LcvWIajNwKpNssZR5U7BAT
	tWCT5NA==
X-Received: from pfdc18.prod.google.com ([2002:aa7:8c12:0:b0:834:df9e:8e02])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3028:b0:837:8c8f:8f51
 with SMTP id d2e1a72fcca58-83f33db3f0dmr25728027b3a.47.1779299798653; Wed, 20
 May 2026 10:56:38 -0700 (PDT)
Date: Wed, 20 May 2026 10:56:38 -0700
In-Reply-To: <949e39aec749f019b18fa41c2a42bcc9231288b9.camel@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-3-seanjc@google.com>
 <949e39aec749f019b18fa41c2a42bcc9231288b9.camel@amazon.co.uk>
Message-ID: <ag311hHnqrCGR9Jc@google.com>
Subject: Re: [PATCH v3 02/41] x86/tsc: Add helper to register CPU and TSC freq
 calibration routines
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: "tglx@kernel.org" <tglx@kernel.org>, "longli@microsoft.com" <longli@microsoft.com>, 
	"luto@kernel.org" <luto@kernel.org>, 
	"alexey.makhalov@broadcom.com" <alexey.makhalov@broadcom.com>, "jstultz@google.com" <jstultz@google.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"ajay.kaher@broadcom.com" <ajay.kaher@broadcom.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "kas@kernel.org" <kas@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kys@microsoft.com" <kys@microsoft.com>, 
	"decui@microsoft.com" <decui@microsoft.com>, 
	"daniel.lezcano@kernel.org" <daniel.lezcano@kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "jgross@suse.com" <jgross@suse.com>, 
	"boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"mhklinux@outlook.com" <mhklinux@outlook.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "nikunj@amd.com" <nikunj@amd.com>, 
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "sboyd@kernel.org" <sboyd@kernel.org>, 
	"x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11066-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,broadcom.com,google.com,linux.intel.com,siemens.com,redhat.com,infradead.org,suse.com,oracle.com,lists.linux.dev,vger.kernel.org,outlook.com,amd.com,linutronix.de,lists.xenproject.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B089B5959CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026, David Woodhouse wrote:
> On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> >=20
> > --- a/arch/x86/xen/time.c
> > +++ b/arch/x86/xen/time.c
> > @@ -569,7 +569,7 @@ static void __init xen_init_time_common(void)
> > =C2=A0	static_call_update(pv_steal_clock, xen_steal_clock);
> > =C2=A0	paravirt_set_sched_clock(xen_sched_clock);
> > =C2=A0
> > -	x86_platform.calibrate_tsc =3D xen_tsc_khz;
> > +	tsc_register_calibration_routines(xen_tsc_khz, NULL);
> > =C2=A0	x86_platform.get_wallclock =3D xen_get_wallclock;
> > =C2=A0}
> > =C2=A0
>=20
> xen_tsc_khz() doesn't use CPUID but really *should*.
>=20
> Care to pull in
> https://lore.kernel.org/all/20260509224824.3264567-31-dwmw2@infradead.org=
/
> to your next round please?
>=20
> (Without the misplaced changes in kvm/x86.c that should have been in
> two different prior commits, and are now folded into those correctly in
> my kvmclock5 branch ready for the next posting of that).

Ya, will do.  What's one more patch...

