Return-Path: <linux-hyperv+bounces-11710-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i5oQBwESRGrFnwoAu9opvQ
	(envelope-from <linux-hyperv+bounces-11710-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2026 20:59:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C936E75A3
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2026 20:59:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="I/3WEowT";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11710-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11710-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05A3F302F272
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2026 18:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CDD3E173B;
	Tue, 30 Jun 2026 18:59:05 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447673DF001
	for <linux-hyperv@vger.kernel.org>; Tue, 30 Jun 2026 18:59:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845945; cv=none; b=ePehZ4fgJcZt0odvgYxY8jYXPB/7iZs/kYv+gO+GZ5pTmW3g13F/SRlPz3HVjcC0e6hwo5xOzxBpDIQbpfR50MoHys6Sv5IRjuJLPUrR0vh00c1pjNawu9RPaqoQtaPIpAAzvfdu7VtcQ+G0RssusM71EAeCREnHXNyVkqh4z1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845945; c=relaxed/simple;
	bh=XGgg+xXUmnlRvAbgTK542VK34Jp1hfwPb9Na535wrug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BMgWJglRA2H8XklqDXZCgzUUOV5xVUKDCI5E6GVnaQD2VTNJ3baj3+QZZn9LWxXAJMNt49e4GOWvaSqiBvUJfkP5/BbwHOtFw06KidyUHcN78ikvxMdvihQH+vVma72ZADIEluClco1ocakZF2tvQoXqJYBouVscdQqiLMs4f+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/3WEowT; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c7f385887bso80357605ad.0
        for <linux-hyperv@vger.kernel.org>; Tue, 30 Jun 2026 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782845943; x=1783450743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+HRXjFGgcPzOleYtd12nce6K890KkClpjKYcrzynFs=;
        b=I/3WEowTJRiihaVlRhDqzwj+YFRhy3c6bZt1KMXwh9x+om89q3OC+JV0rMtABHuHPF
         qKTGPEF+LctDdirA+uM3nYkHMtqx7fzxbKIo7F/ANMmPr47Kwsrrnm8E9Yb1Y2eCZ8WT
         pb40zvGu2vMFonNzF5uChbhNUm+4Abp0wLfh+8tBFirSreUkERpYPrulspJkbT2ABs3t
         54e3TQ4JLV7EMB4ti1zVIN8Zf+GguCJY/CTwPz2Vs6GJbsvvrBWQB+i8mbiTIY3WqJ2b
         z/S25V9ZGlAtRn3L2wb//Dbu0OlwWKm5mOpsVZXv+wJ2t9RD6W6vx1WOb8AUFiiio86v
         g6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782845943; x=1783450743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+HRXjFGgcPzOleYtd12nce6K890KkClpjKYcrzynFs=;
        b=FYmpLdAhXqQqBinWefLR/ocsplvZpJpiM3RuUfBUxXVOXAWwgc87LSfO9H9kpUEGbB
         kgKA0iyf/cy19ec+pH09aJCtpWiZJOvxtpICN0uXiz7r5kFOSAD2xkAJJoTiHnD+bCTu
         fMZRT6wSphWwUsj62BIpx+k+x+IU52tI6TOy4HZhjbHM0rJnL+kKywdeG9SsorAk4Xla
         k0PIEPB3aXuvb8j6QHT5woc1AjKjX0XAphKolO7urQkg2DfwUXMm45rndCwqNhAgRBEl
         lqJBUeveLJXmoh5n4Fdhfn733cJpjGMlbZbczDZCT0aGgu6sXdSgl1fPIUfiPr8xviRX
         m1HA==
X-Forwarded-Encrypted: i=1; AHgh+RpoJiXr/Wg0r4SgbDb8A4JzolNeDkIu6T9XCLqScCzT8piVW9vEFFhnO257BN3g7Jq6QzBWukLMkaT05qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzynO//1f/WtqRnJh6OB7ZYutXxen9GaTrM+vlBPK8V4bHShPkE
	AZG8x9HPKN/Knw9Xd1L7Xusy07ZIy/lxMYRKAx/SCgGiNefFk4PgOSsBkQuLMidcvmIrvNKI3Od
	+RpQxYA==
X-Received: from plbko12.prod.google.com ([2002:a17:903:7cc:b0:2c6:9f66:d581])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:acd:b0:2c9:c517:d075
 with SMTP id d9443c01a7336-2ca5a581ab5mr15124165ad.15.1782845942348; Tue, 30
 Jun 2026 11:59:02 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:59:01 -0700
In-Reply-To: <akJUz0kYkEBdLSZ3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629060526.3638272-1-jgross@suse.com> <d7c1db52-529a-43cc-ac7d-38b52627e8bc@app.fastmail.com>
 <c1608c48-13c2-4290-826b-28b5ca51eaf7@suse.com> <7332feff-2649-496c-8e49-b0a19eb54a32@app.fastmail.com>
 <akJUz0kYkEBdLSZ3@gmail.com>
Message-ID: <akQR9YMtMHReJTfB@google.com>
Subject: Re: [PATCH 00/32] x86/msr: Drop 32-bit MSR interfaces
From: Sean Christopherson <seanjc@google.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, x86@kernel.org, linux-acpi@vger.kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-ide@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-crypto@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-hyperv@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>, 
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	Yazen Ghannam <yazen.ghannam@amd.com>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Pu Wen <puwen@hygon.cn>, 
	Bjorn Helgaas <bhelgaas@google.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Reinette Chatre <reinette.chatre@intel.com>, 
	Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>, 
	Babu Moger <babu.moger@amd.com>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Dave Airlie <airlied@redhat.com>, 
	Helge Deller <deller@gmx.de>, linux-geode@lists.infradead.org, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Guenter Roeck <linux@roeck-us.net>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Artem Bityutskiy <dedekind1@gmail.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Ashok Raj <ashok.raj.linux@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, 
	"Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, 
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, David E Box <david.e.box@intel.com>, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11710-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@kernel.org,m:arnd@arndb.de,m:jgross@suse.com,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-edac@vger.kernel.org,m:x86@kernel.org,m:linux-acpi@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-pci@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-ide@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fbdev@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-hwmon@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:platform-driver-x86@vger.kernel.org,m:rafael@kernel.org,m:daniel.lezcano@kernel.org,m:rui.zhang@intel.com,m:lukasz.luba@arm.com,m:jbaron@akamai.com,m:bp@alien8.de,m:tony.luck@intel.com,m:yazen.ghannam@amd.com,m:lenb@kernel.org,m:pavel@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:pbonzini@redhat.com,m:kas@kernel.org,m:rick.p.edgecombe@intel.
 com,m:puwen@hygon.cn,m:bhelgaas@google.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:viresh.kumar@linaro.org,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:TonyWWang-oc@zhaoxin.com,m:dlemoal@kernel.org,m:cassel@kernel.org,m:airlied@redhat.com,m:deller@gmx.de,m:linux-geode@lists.infradead.org,m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:linusw@kernel.org,m:brgl@kernel.org,m:gregkh@linuxfoundation.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux@roeck-us.net,m:peterz@infradead.org,m:acme@kernel.org,m:namhyung@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:james.clark@linaro.org,m:jpoimboe@kernel.org,m:pawan.kumar.gupta@linux.intel.com,m:vkuznets@redhat.com,m:luto@kernel.org,m:boris.ostrovsky@oracle.com,m:ray.hu
 ang@amd.com,m:mario.limonciello@amd.com,m:perry.yuan@amd.com,m:kprateek.nayak@amd.com,m:srinivas.pandruvada@linux.intel.com,m:artem.bityutskiy@linux.intel.com,m:dedekind1@gmail.com,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:ashok.raj.linux@gmail.com,m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:irenic.rajneesh@gmail.com,m:david.e.box@intel.com,m:xen-devel@lists.xenproject.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[arndb.de,suse.com,vger.kernel.org,kernel.org,lists.linux.dev,lists.freedesktop.org,lists.infradead.org,intel.com,arm.com,akamai.com,alien8.de,amd.com,redhat.com,linux.intel.com,zytor.com,hygon.cn,google.com,broadcom.com,linaro.org,zhaoxin.com,gmx.de,selenic.com,gondor.apana.org.au,linuxfoundation.org,microsoft.com,roeck-us.net,infradead.org,oracle.com,gmail.com,bootlin.com,nod.at,ti.com,lists.xenproject.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[96];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94C936E75A3

On Mon, Jun 29, 2026, Ingo Molnar wrote:
> * Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > >>> Note that most patches of this series are independent from each other.
> > >>> Only the patches removing a specific interface (patches 7, 15, 26 and
> > >>> 30) and the last two patches of the series depend on all previous
> > >>> patches.
> > >> 
> > >> It looks like you are touching most files twice or more here, to
> > >> first convert from rdmsr to rdmsrq and then to change the
> > >> two-argument rdmsrq() macro to a single-argument inline. If you
> > >> introduce the inline version of rdmsrq() first, you should be
> > >> able to skip the second step (patch 31) as they could be able
> > >> to coexist.
> > >
> > > I've discussed how to structure the series with Ingo Molnar before [1]. The
> > > current approach was his preference.
> > 
> > Ok.
> 
> Note that the individual patches are IMO significantly easier to review
> through the actual 32-bit => 64-bit variable assignment changes done
> in isolation (which sometimes include minor cleanups), while
> the Coccinelle semantic patch:
> 
>    { a(b,c) => c = a(b) }
> 
> which changes both the function signature and the order of terms as
> well, is just a single add-on treewide patch.

Is the plan for subsystem maintainers to pick up the relevant patches, and then
do the treewide change one release cycle later?

