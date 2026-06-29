Return-Path: <linux-hyperv+bounces-11699-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jSNsJWkXQmo20AkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11699-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 08:57:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F88E6D6A3D
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 08:57:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arndb.de header.s=fm1 header.b=moVeurPh;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="h B46Z3K";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11699-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11699-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arndb.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50D40305CAFD
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 06:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403943ADBAF;
	Mon, 29 Jun 2026 06:52:45 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E493A7F46;
	Mon, 29 Jun 2026 06:52:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715965; cv=none; b=WNukvshhnJkMqJBrSROazgTBp/aNL0z0aSUiHeCC6lGNic7EZyj+kn4BZPp511yrNGQzSO9mLPx8eMBB6Y4JKaUeEDc7JIOSEWa3XQxLTNB+xV1Hx3kj8WQpMUV8OHsibPk5XTDpdUs8xtMr3DUSlSDsUqaQxKARfHh4Gkw6WFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715965; c=relaxed/simple;
	bh=H2lwxsHZZ7EtTub4WwMeUp/eTT8kysSLHLDVR3xxm8k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KKsoXH/8hwsJhExR7X/khsHMbB7QJFaGcun7LAMsYVzgiT2v9Nj0k5bb5CUtCwnI3/Xdih9pJMKgmIsPi4P2Vch0y1pk7Zz2UPHXeDNvN8qCHD4TS6pDMoQ8xIiDYdNsOv5N2LPdSo8l/an2SMNPKT1n/2SmZ3b7zLshmlsZyco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=moVeurPh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hB46Z3Kr; arc=none smtp.client-ip=103.168.172.142
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 8ADB1138013F;
	Mon, 29 Jun 2026 02:52:41 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 02:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782715961;
	 x=1782723161; bh=tOv4MTUTsrDaiEgHTG/NX+h1I0Ci3tUDRjXnSX8B8ZY=; b=
	moVeurPh2zmNrJzP8rbqUPqQIFGV1KR17RcUSPE3wJu/2S/XINfbBToo5f9RQh1/
	clf/45HkV8kiwjLDnKA0ZGB+xXs/LxQ97UYdGp3mAyhY1rMWfb2ut8ebDlQumP3M
	VdcxoT0cWYJThMe3tHYwBYuJA8gYjCl4dkRIsx+Q/6emrBa3QY8Idt3PtT6T4gzt
	pjXS/9QEWhZ2jfyda0VyMgxTDzLco04X3qt/vrJYJWvdC+PMyVwHCjEhVeOyJIAS
	gEH+rz/z5nLfxJeyVUnha0jbbsfFFgbhjlE2+BlgPqMCXL8vkYcgC6UiT7hGGY74
	xGTwwQphEUZ53wLPdY/lOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782715961; x=
	1782723161; bh=tOv4MTUTsrDaiEgHTG/NX+h1I0Ci3tUDRjXnSX8B8ZY=; b=h
	B46Z3KrfXyr5c4NuJHJwRpFO3VNQg2XJYEDC6YUGKJUsEhIcM3CblEFDPTT7wsQg
	LH0S5A3tvITWrXHqFdF1EkeHZjTnuQT+pgHJLOdtZCOrRZh456xh3Sx0k+T+zXCp
	kNYUxD9xFRSmKJKTjyfm848VuBVywgSQdS0Y1730vc3RugkRsZPqt6GHmPUgFsPs
	4nONFFGrtMfsX7i/XMkZbKMKnAy+BEdiCfia6dBPn42W2/ZviCTsT6LG5Oj/ruof
	ficdFWVRuGB5I8j63MB1URziScDM3F1SM330Kw/lKTbew/mmDBQO8+P/9fMGp4QQ
	AUBT5DiFaGcisBboaL0uQ==
X-ME-Sender: <xms:NxZCaklUX7qMSFvSQI3f1it9KkLu2jpq-bfNhuZJai7DIcz_l7yaVw>
    <xme:NxZCaupMK91NnfDxBP2Jl6u4UEarGr4W4BjRkQiIO7vCuXpmdFgh7w7Ak6Ow7kDLB
    GwQtBq3A_KdmViF1Mt2hB3V4JkgKSjPIp_adeSQyOs0PGQS4AmZ4t8m>
X-ME-Proxy-Cause: dmFkZTGwOHixY05HMZ27iS84Skvde8o1DDsiwY6D60DzXWO2ZVrwdRrpSa8R1278jed1uY
    wlWCiz3tDrtZHQkvMp/MBP5v/ghF2ufPQuFtrtJ4F0wh9DtG/XVpt0pROqEThSmUEDgCf0
    eTVEoMiS68VQPXRPt6VCUkkecnFqx+ZBjUZbbdMDP3RsDcc++iQYtFCDsx7qN3zPyVD3xY
    9i6Bzl+AIdZTqf3H9PE4La2YJtJbmBtGNvfDerKjWxD0tIQdIxc4ff6CyIl+oAxSN3L67g
    IQoXuyz4qEo4Q1DYv/YVlijZQSf0JOEgla6HGT0QZP1hJCRQsFe920XNZ7JCBQqZpPrjbH
    Tnk4/qORnBMbT1wfL00kYIifWwvRfHEzwO8X4XjYvXGKPupOF+Aih7SyjMueufJZIiNJhm
    gk+r3F4ioudpLQgLl8s2Bai/sQm/lpFYJPWmS816rZo8N1I3fGaKF8vaCjnsPMfwksRvl0
    6Af/2BtixmkFEnOpg4axh9H+xCdn89MnkDhmnuoJzY/popvh/LfTLliWEeyDWOhpCgCE4O
    h18zdmDtHrrW/u8WZmRXrY3iQ3r0wTSENEm+dusuNb8xtIAhju1BiHn0naN+53TgzSbvzd
    yzmZYCi7ifaUifdFk2wMrmhMIjP1c9DeNzX5Xx4Sctv2yWtIBtVWa0+zIeZw
X-ME-Proxy: <xmx:NxZCavqymErkIRztjouBu-7V0slB3o25MfBbVM9KSCex8QOrTFeOZg>
    <xmx:NxZCan2DdzgvxbYRzX6pYCwK3xwrIk-cU2tFN57SqHbLubX7sFp6RQ>
    <xmx:NxZCaigvrzp3oRkZE6LwBiBQXYgj4l_X1hgb0NxTXofsjKmlb0-Pzg>
    <xmx:NxZCamzJNW0pQlTHLc_D5xB2Wj8XraMxhsaupP8Tsn_eAmCJi2chTA>
    <xmx:ORZCasPFEmYzO9oCU9bgbYUUKaJzQAtBQ2CkEcKsKYO_AOQRt9ou1Eza>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 54A63182007E; Mon, 29 Jun 2026 02:52:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApSqBjiSqQZ-
Date: Mon, 29 Jun 2026 08:52:18 +0200
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
Message-Id: <d7c1db52-529a-43cc-ac7d-38b52627e8bc@app.fastmail.com>
In-Reply-To: <20260629060526.3638272-1-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
Subject: Re: [PATCH 00/32] x86/msr: Drop 32-bit MSR interfaces
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11699-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:dkim,arndb.de:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,messagingengine.com:dkim,app.fastmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F88E6D6A3D

On Mon, Jun 29, 2026, at 08:04, Juergen Gross wrote:
> For accessing the MSR registers on the local CPU, there are 2 types of
> interfaces: the "modern" 64-bit ones (rdmsrq() etc.) and the 32-bit
> ones (rdmsr() etc.) which are using the upper and lower 32-bit halves
> of the 64-bit wide MSR register values.
>
> The 32-bit interfaces are not optimal for 3 reasons:
>
> - They are based on primitives using 64-bit sized values anyway.
>
> - Modern x86 CPUs have added support for MSR access instructions using
>   an immediate value instead of a register for addressing the MSR,
>   while the value is in a 64-bit register.
>
> - rdmsr() is a macro storing the upper and lower 32-bit halves in
>   variables specified as macro parameters. This is obscuring variable
>   assignment through a macro. Additionally rdmsrq() is mimicking this
>   pattern by being a macro, too, with the target variable specified as
>   a parameter as well.
>
> For those reasons drop the 32-bit interfaces for accessing the x86 MSR
> registers completely and only use the 64-bit variants.

Hi J=C3=BCrgen,

I assume this is fine, but since you don't mention it explicitly here,
please clarify what this means for 32-bit CPUs without the rdmsrq
instruction. Those will continue using the same instructions as before
and just change the calling conventions, right?

> Note that most patches of this series are independent from each other.
> Only the patches removing a specific interface (patches 7, 15, 26 and
> 30) and the last two patches of the series depend on all previous
> patches.

It looks like you are touching most files twice or more here, to
first convert from rdmsr to rdmsrq and then to change the
two-argument rdmsrq() macro to a single-argument inline. If you
introduce the inline version of rdmsrq() first, you should be
able to skip the second step (patch 31) as they could be able
to coexist.

     Arnd

