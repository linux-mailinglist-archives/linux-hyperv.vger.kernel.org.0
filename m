Return-Path: <linux-hyperv+bounces-11706-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CvUwHVkvQmrH1QkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11706-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 10:39:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5946D794C
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 10:39:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arndb.de header.s=fm1 header.b=gYKRp3Mk;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="T moJafj";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11706-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11706-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arndb.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 535A930103B3
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 08:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE183F7A96;
	Mon, 29 Jun 2026 08:39:08 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3ED3F5BD7;
	Mon, 29 Jun 2026 08:39:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722348; cv=none; b=CtVCGy2gySlaU3YnT9DzDuR10K+PZNAJvp+uvfnTbutfc2eUxpfPnbXqySKae5S4yJHwGwdwT9DONe+x8cEIouT694TynLz12HvdLtYnZmYnqY5VmEs6xVVbzn9DsEsCNiZASsoSCf3U2BCWHFUSvyenONmAqJtXldvC/cQuIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722348; c=relaxed/simple;
	bh=rdZ86aUfALzyRtzacvcgkegXDBksip2sdcpEEPNGzdw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jlxbUD4NrENS1tfZKlJKZdLuyMN1VpwAcxxpQh8El0+IoyNRicS4406VtvPsMXpkd6r3wihKlBWxdujTtoeIrMWMlfH/UBeF/J6yMAdcjK2sar21gZm9Q3B0QRMDyO4crt1mRkm/jD6l/FFwqMHd21wAXPD41yFI5QD+Zh884oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gYKRp3Mk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TmoJafjB; arc=none smtp.client-ip=103.168.172.137
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id ED49E1380289;
	Mon, 29 Jun 2026 04:39:05 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 04:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782722345;
	 x=1782729545; bh=/vdY4J8WqpgsSSAPKxCtlbdJGPE0BXIq61EW+S6j6P4=; b=
	gYKRp3MkalTZcfjiyB1FWwOhagCvw7SptaL4XpUAHt9qYHSGuoiB6JpTDfeluC3Q
	rh4Aal4qSJB9FlmFMuZBGVV3Dx7WxE4URmh/8SrliuKwrNTUxDpN5M0oqIvsfjsi
	v/1VEbMFCoVKG4zgmmv8bWa1ApMxljOc9oVaEnz9RMWWBfn1NNGGQG4h+0zPBM2t
	iE4ZNSm4dlaaqkxGqpIYsAjT7stL06NVaG0wkBIsDJ79kINTzAEWrhL8L7qa9xLg
	O3+f3LvOp1joCWZj+Qj+cokk9VL0UCCg+7t2GAEkDKyIX138l7MoA7c6+0ANJpex
	b+u4XAzlz6AfSSaqRN2B+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782722345; x=
	1782729545; bh=/vdY4J8WqpgsSSAPKxCtlbdJGPE0BXIq61EW+S6j6P4=; b=T
	moJafjBCQd2OcjAkPYpzobQBAomX1YnWDBRu3nLVcnTUyhNbi9yqP7rAKao74kvK
	W9Pyd82evV5x0oejCQ0bKAnh1OzcJ+lyR04VaBZ2mhymZiRP3GIGHdp3wRdPJAA2
	qlGUDJUJqr9OHkULgg6JVf2xPVApuQhlXvg2QIeF+hrIx5wofbMZ7ViQL+Q14vqD
	thuwp23CCztH4wo0hMRwalZDAOtGeBL9A3r2yk/KroDYmS7keKhb+A+1OFjil0iN
	BkaqZbBQ3aEgZtPAPZ9N1KDwfQ/I6E2wqsbVnBvR4gpiegR3RSa67VUyYlbj9RXz
	NOlJ/GRInhzHItsNT5WuQ==
X-ME-Sender: <xms:Jy9CajGgRjsplzBg2AtFgVQfIg8_cVyBgfhU3z9iIIWNAladEIyTng>
    <xme:Jy9CarIOubeU2rUQNxElTNzHTUc1VSiC0q76P0JncQ51McW6xYkKnxEdv3WLCricH
    AoTGPUTTEMZF6yAdwb8oDGyXnmPuUbczXMANRC2Ne84a15jGqlpK04>
X-ME-Proxy-Cause: dmFkZTGQ1+/zMJ6FRO/nrenBVaK3dgNV80cEWVcq9a0FUfwQpoRgAtHfD6iB9yAigOgUR+
    jj7UAkKII4IB5gEkT+Gq3x2a1TlJ8/9Us6NCf+Z6ozVZwwfkmtIK8B6WD3KkL3WjRWyNlq
    RY0/S5hiTmQ6/MWQZUqPxfXAFF22LmbgigARUbvZheMrxzFjsfmoo1zWrVptpHF0V+jwar
    WA4RBlo40U0z1fWy4AebOsp8HnYzB68Slr7XO9JmQmLKgIV8Fjf814MXW+8uJ77ByBAQuJ
    BGA9VM2uzadc0UNHVRSjRdmVsmOH4QsX2FHPkz6ZWqk9Mgajdyl3+bXK90tycrhFehfmXt
    Fn1W9kCa2R5qpJDYtP8FRGr1MDXzZevPPYc1/sMmYgs8yRZCCQEwPqkd6EtSRnZrYDpqiX
    r83RR5Axps70SB/YmbIacE3AvmD3xsZz6p9dt8AkDdsOc4PoBCQp+2L4l6Jczg6Hv+mjus
    wDNXfIn1FImLLVX6BBE/OD945b3OnLpEQHvjR6yFG8qsjgmGutFbt6SDv0KgUxVeb4fL5C
    4ryLUX6BjWQwb2s9pTrOmAipI+MJOoWjtsdHbN1E9hLWMLIym+D+jilNl4niSZiN/vQal8
    sGsjvTbjRleHQMEsz8fFh1nDAI8nT1w6DiLhtWhC1MqN9cKnNagMl1USoB+A
X-ME-Proxy: <xmx:Jy9CaiU4saJaD8ZZTc3oT4aVP9FZ-2KzZY1OMbt54FSVdp8C4GojwQ>
    <xmx:Jy9CarAKcIjUEzh0n01SmH8Fvdf-c-CEw6HC4kX3-wpjrz_bK_Gd2A>
    <xmx:Jy9CalRy7x7F70ztTSBlebo27l1W3InI7iznAUqc9uqjK3_xcNs__g>
    <xmx:Jy9CavcxY2931rRj96HnQy4Q94ZUMjaepmrx-pZGBtzBliSD2KlD8g>
    <xmx:KS9CaoujF5_4WrC5b_ziAcwJh2y7aclJij4MlWb0bwqEh9ZP_Ar7Yvo4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 770CC182007E; Mon, 29 Jun 2026 04:39:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApSqBjiSqQZ-
Date: Mon, 29 Jun 2026 10:38:16 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Juergen Gross" <jgross@suse.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, x86@kernel.org,
 linux-acpi@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
 linux-ide@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-crypto@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-hyperv@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-mtd@lists.infradead.org,
 platform-driver-x86@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 "Daniel Lezcano" <daniel.lezcano@kernel.org>,
 "Zhang Rui" <rui.zhang@intel.com>,
 "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
 "Jason Baron" <jbaron@akamai.com>, "Borislav Petkov" <bp@alien8.de>,
 "Tony Luck" <tony.luck@intel.com>,
 "Yazen Ghannam" <yazen.ghannam@amd.com>, "Len Brown" <lenb@kernel.org>,
 "Pavel Machek" <pavel@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Sean Christopherson" <seanjc@google.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Kirill A. Shutemov" <kas@kernel.org>,
 "Rick Edgecombe" <rick.p.edgecombe@intel.com>, "Pu Wen" <puwen@hygon.cn>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Ajay Kaher" <ajay.kaher@broadcom.com>,
 "Alexey Makhalov" <alexey.makhalov@broadcom.com>,
 "Broadcom internal kernel review list"
 <bcm-kernel-feedback-list@broadcom.com>,
 "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Reinette Chatre" <reinette.chatre@intel.com>,
 "Dave Martin" <Dave.Martin@arm.com>, "James Morse" <james.morse@arm.com>,
 "Babu Moger" <babu.moger@amd.com>,
 "Tony W Wang-oc" <TonyWWang-oc@zhaoxin.com>,
 "Damien Le Moal" <dlemoal@kernel.org>,
 "Niklas Cassel" <cassel@kernel.org>, "Dave Airlie" <airlied@redhat.com>,
 "Helge Deller" <deller@gmx.de>, linux-geode@lists.infradead.org,
 "Olivia Mackall" <olivia@selenic.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>,
 "Dexuan Cui" <decui@microsoft.com>, "Long Li" <longli@microsoft.com>,
 "Guenter Roeck" <linux@roeck-us.net>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Namhyung Kim" <namhyung@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "James Clark" <james.clark@linaro.org>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>,
 "Vitaly Kuznetsov" <vkuznets@redhat.com>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 "Huang Rui" <ray.huang@amd.com>,
 "Mario Limonciello" <mario.limonciello@amd.com>,
 "Perry Yuan" <perry.yuan@amd.com>,
 "K Prateek Nayak" <kprateek.nayak@amd.com>,
 "srinivas.pandruvada@linux.intel.com"
 <srinivas.pandruvada@linux.intel.com>,
 "Artem Bityutskiy" <artem.bityutskiy@linux.intel.com>,
 "Artem Bityutskiy" <dedekind1@gmail.com>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Ashok Raj" <ashok.raj.linux@gmail.com>,
 "Hans de Goede" <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Rajneesh Bhardwaj" <irenic.rajneesh@gmail.com>,
 "David E Box" <david.e.box@intel.com>, xen-devel@lists.xenproject.org
Message-Id: <d315e0a8-e4e9-4f7e-80a9-7c236849eabd@app.fastmail.com>
In-Reply-To: <9acced19-573d-4923-9329-8be408d2e555@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
 <d7c1db52-529a-43cc-ac7d-38b52627e8bc@app.fastmail.com>
 <c1608c48-13c2-4290-826b-28b5ca51eaf7@suse.com>
 <7332feff-2649-496c-8e49-b0a19eb54a32@app.fastmail.com>
 <9acced19-573d-4923-9329-8be408d2e555@suse.com>
Subject: Re: [PATCH 00/32] x86/msr: Drop 32-bit MSR interfaces
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11706-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[arnd@arndb.de,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgross@suse.com,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-edac@vger.kernel.org,m:x86@kernel.org,m:linux-acpi@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-pci@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-ide@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fbdev@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-hwmon@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:platform-driver-x86@vger.kernel.org,m:rafael@kernel.org,m:daniel.lezcano@kernel.org,m:rui.zhang@intel.com,m:lukasz.luba@arm.com,m:jbaron@akamai.com,m:bp@alien8.de,m:tony.luck@intel.com,m:yazen.ghannam@amd.com,m:lenb@kernel.org,m:pavel@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:seanjc@google.com,m:pbonzini@redhat.com,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:puwen@hyg
 on.cn,m:bhelgaas@google.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:viresh.kumar@linaro.org,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:TonyWWang-oc@zhaoxin.com,m:dlemoal@kernel.org,m:cassel@kernel.org,m:airlied@redhat.com,m:deller@gmx.de,m:linux-geode@lists.infradead.org,m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:linusw@kernel.org,m:brgl@kernel.org,m:gregkh@linuxfoundation.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux@roeck-us.net,m:peterz@infradead.org,m:acme@kernel.org,m:namhyung@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:james.clark@linaro.org,m:jpoimboe@kernel.org,m:pawan.kumar.gupta@linux.intel.com,m:vkuznets@redhat.com,m:luto@kernel.org,m:boris.ostrovsky@oracle.com,m:ray.huang@amd.com,m:m
 ario.limonciello@amd.com,m:perry.yuan@amd.com,m:kprateek.nayak@amd.com,m:srinivas.pandruvada@linux.intel.com,m:artem.bityutskiy@linux.intel.com,m:dedekind1@gmail.com,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:ashok.raj.linux@gmail.com,m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:irenic.rajneesh@gmail.com,m:david.e.box@intel.com,m:xen-devel@lists.xenproject.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,arm.com,akamai.com,alien8.de,amd.com,redhat.com,linux.intel.com,zytor.com,google.com,hygon.cn,broadcom.com,linaro.org,zhaoxin.com,gmx.de,lists.infradead.org,selenic.com,gondor.apana.org.au,linuxfoundation.org,microsoft.com,roeck-us.net,infradead.org,oracle.com,gmail.com,bootlin.com,nod.at,ti.com,lists.xenproject.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCPT_COUNT_GT_50(0.00)[95];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:dkim,arndb.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,app.fastmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF5946D794C

On Mon, Jun 29, 2026, at 10:15, J=C3=BCrgen Gro=C3=9F wrote:
> On 29.06.26 10:06, Arnd Bergmann wrote:
>> On Mon, Jun 29, 2026, at 09:01, J=C3=BCrgen Gro=C3=9F wrote:
>>> On 29.06.26 08:52, Arnd Bergmann wrote:
>>>> On Mon, Jun 29, 2026, at 08:04, Juergen Gross wrote:
>>>>
>>>> I assume this is fine, but since you don't mention it explicitly he=
re,
>>>> please clarify what this means for 32-bit CPUs without the rdmsrq
>>>> instruction. Those will continue using the same instructions as bef=
ore
>>>> and just change the calling conventions, right?
>>>
>>> Yes. I thought this would be clear from the following:
>>>
>>>     - They are based on primitives using 64-bit sized values anyway.
>>=20
>> Right, that was my reading of it as well, but it's not entirely
>> clear when the function name is the same as the mnemonic of an
>> instruction that only exists on newer CPUs and the later patch
>
> There is no RDMSRQ instruction on any x86 CPU. Are you mixing this up =
with
> WRMSRNS/RDMSR using an immediate for addressing the MSR?

Yes, I was just confused about the exact definition here and assumed
the single-register output version was actually called rdmsrq.

     Arnd

