Return-Path: <linux-hyperv+bounces-11140-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GsYFc5sD2qOLAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11140-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 22:36:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AD15ABD14
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 22:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40C48302A042
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 20:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD0B40911C;
	Thu, 21 May 2026 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+9WImWb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4BE374756
	for <linux-hyperv@vger.kernel.org>; Thu, 21 May 2026 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395668; cv=none; b=TqeyZ1eMuPtzeW8H7xTXdxffqZEqsAeesGhTf5WHpylVJPV7OnbH/X1jEeorXuamRD/OYjGrccIVqOlEDcJ1Wa/x9i6Q0//BRZKT2h26uhh55aWKhqOl4x10GU8ybyJE+/vbQXVKeh34ZQ+7gpl1MNjr1Q9L3dFUbIWtRYO+ZaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395668; c=relaxed/simple;
	bh=Vidk3LDEKL2XnrVS0/5PJ+6dbEOeauOpV9iuOcmzzjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qHTRBvwx57mbtYz2bZitfhR+tO/dy7rz5I/dNfr6SgHvBzyyDy714BAlI4SBbJsnHEeFJkq1IaH2KmnKoBITl3xo58zz7DHz7eh5537v6SmagOvNTCB7zXq0R/bIndXgmrq0jpIPII/QoIM7LQSAlemL/1hDyxr/nL3MnLYFqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o+9WImWb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc763c7256so150496115ad.3
        for <linux-hyperv@vger.kernel.org>; Thu, 21 May 2026 13:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779395666; x=1780000466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dIireasEnp8AQZjS+o0HC63+VEosuYCnO+TKDPQR05s=;
        b=o+9WImWbeAbOLztvLMTB+MdER7K+60tboDKwyKU9bSRbhkvTfZYUs0v4XkM2QeRety
         jTmwLKveG81OJBnWOQqPX8e/6+KmgGV5gzQRWwdmKRKP4oBsw7P0ibo1BzukWptlK0KA
         TScf/zDsLe1K02dtWTh/nt80ijybeo/UMrVrgzwhieF41ecwBQiNAS5VoLeLOz784tPR
         U3HMnH1xJnDX89cUe0SvelQAGIt4VC7yBZUvYbdoOUuWdWqJYDzAsN/G4+901+Hjc2qW
         /hZCQHQiSvMzfztTkUiIiX55aJ46HPK6tkLKWjODNb7O3xpcl/PPp/1351Xl/FPNQCkX
         8mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779395666; x=1780000466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIireasEnp8AQZjS+o0HC63+VEosuYCnO+TKDPQR05s=;
        b=r+xaLO63j71TRpOi8vDHI/Y7EHz5hpKOV1WZmI+ycJZTqdyLH6K7kq93rzK/gPp/yM
         aqKplsQ8F39mBEx4IArfyUpsWi/QkiNdG4GFDR+y59reV/qijbsF1N7/UhD8lSt1Ylv2
         Q4lKmbic5qJWRm1G1POsONe6VT9GyAi7RJcZAaKHJAFnWH1CdMya53ZOW9PEdWUFcEzg
         TcSuL+TVW+CJeTSnmOXyEJ+Qy9OAr++RhDlvuunHTp9sAynAcVCEWJ+hVfUEjKIlFUXc
         UzActO11BDgI8WjhpQyBG+sdSiKA9vUR3au+dHMZO5+O06mjaxLe6BbGBdsfilIsRhUF
         aOnA==
X-Forwarded-Encrypted: i=1; AFNElJ/f9j1mmE4RB1QgPmfw4+YgQmOSfZsakS2j7mgAoq4g10DYPHGkSvTZJo/J9v0u7rVF6W71dORX3X0L7rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY5I7YkNy7lRFq1Kezgc9Y4/wVIsx7Wvlo5eYrfrlewaWhsyvV
	i/HOHWmjjOFDavzmHo5xpjO+jTi2U9AkMZXS6ssq7w8NYwI3blDgw4RShCSCJTGeBmh/2wjTHPd
	Gr+PqKw==
X-Received: from plip15.prod.google.com ([2002:a17:903:38cf:b0:2bc:ae06:63be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4405:b0:2b9:6458:1a2c
 with SMTP id d9443c01a7336-2beb06733bemr4530925ad.13.1779395665926; Thu, 21
 May 2026 13:34:25 -0700 (PDT)
Date: Thu, 21 May 2026 13:34:24 -0700
In-Reply-To: <7489ff3cc1ff402bf0ade38272fc52dcbcc75fc1.camel@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-37-seanjc@google.com>
 <7489ff3cc1ff402bf0ade38272fc52dcbcc75fc1.camel@amazon.co.uk>
Message-ID: <ag9sUI8pBJda0Ml5@google.com>
Subject: Re: [PATCH v3 36/41] x86/kvmclock: Get local APIC bus frequency from
 PV CPUID Timing Info
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
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11140-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,broadcom.com,google.com,linux.intel.com,siemens.com,redhat.com,infradead.org,suse.com,oracle.com,lists.linux.dev,vger.kernel.org,outlook.com,amd.com,linutronix.de,lists.xenproject.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E8AD15ABD14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026, David Woodhouse wrote:
> On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> > When running as a KVM guest with kvmclock support enabled, stuff the APIC
> > timer period/frequency with the local APIC bus frequency reported in
> > CPUID.0x40000010.EBX instead of trying to calibrate/guess the frequency.
> > 
> > See Documentation/virt/kvm/x86/cpuid.rst for details.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> I still don't much like the way this is done inside kvm_get_tsc_khz().

Yeah, I don't like it either (understatement).  Aha!  native_calibrate_tsc() is
the oddball, all of the PV flows stuff lapic_timer_period when parsing the initial
timing info.  I'll just do that.  Blindly writing a global is all kinds of fugly,
but that's a future
problem to solve.

> We also probably ought to be looking for the timing leaf on other
> hypervisors including VMware 

VMware gets the frequency via hypercall.  Why, I have no idea.  I'll let the
VMware folks deal with that.

	eax = vmware_hypercall3(VMWARE_CMD_GETHZ, UINT_MAX, &ebx, &ecx);

> and probably Bhyve too.  Should it be done somewhere else?

I'm not opposed to that, though I don't know that it'd be a net positive. The
"hard" part of getting the info is finding the CPUID base and checking if the
leaf is available.  Unlike the native CPUID leaf, no math is necessary, and so
once the leaf is obtained, getting the frequency is trivial.

Regardless, I definitely don't want to take it on in this series. :-)


