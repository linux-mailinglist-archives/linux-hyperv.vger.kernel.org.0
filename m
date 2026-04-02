Return-Path: <linux-hyperv+bounces-9905-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC8kKF+GzmnfoAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9905-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:08:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D717B38B0CF
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BED83063AFB
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5E03EF646;
	Thu,  2 Apr 2026 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Emkb4mKQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CxcCtsyC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A623EF0DC;
	Thu,  2 Apr 2026 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142018; cv=none; b=F0pt6Qyx19X85xr0OVaelmg8YcYPGHXtkcmLtahATicdfG+/9mIZka3fsnLkq85jJuTFNE8On2iiXOpK5uCcY0eITlnRhU8/XpVzoYCU+ny813Yr82+4s9z4TKUhg6+t/j3S7v8fHjUTONwcf3VZFs7wQXqmb6U5S6HRlEb/t/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142018; c=relaxed/simple;
	bh=yZWWGtgdbV9qqiZhd0+J8YvHh+FohjfLQFQ1ZavkcVg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=g8dAK82AO9s83iWzIYp5JmF+LRYqwGF2p6VNqtq4QBAOzrsztQdhYUwqMz/5XfuSN8J8uIBqIhl6l1hQn8athSH3UHWu5jFbQsxAgSoPU9ycuQxRrl08nTY4QW6yS1ExjzjSwgLUEM0CjsiTZeXyMJOpSM/Mg/lytuGK7BPJg+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Emkb4mKQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CxcCtsyC; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CEE01D00338;
	Thu,  2 Apr 2026 11:00:15 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 11:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775142015;
	 x=1775228415; bh=pssyYGpmcMDITeJql5XIx2lmyOqjHKa/++zlF/mlDic=; b=
	Emkb4mKQv2pBI4JjvrWZmiej12xItuHlLguR/vqsF4ZTCFG+djscA3RwnCCa6Oqk
	mGq6fP5v8RB+XNo2yCiZtaZyF9pdoImGBOBrlzdZdotMsP1B/W618wH3iVEht3tg
	pfldlySalgH49WUOfN0Q6hTFQQIDgbB1jNhjyb4+dXVIc8J8DXorSY19ghMUps3K
	3kchYP8VyAPPUGc5kXGo6epZiHgin6VNHMLkxVuF4CA7uB91zcKG4uhphBy1PRRo
	ke3mM2WS7CfJWguxEgdXPixE3XPFC8NPXIzBERszpCagJJruBe4okwqe1PQ7n92R
	8onul8jeFbhj4WK4ZTjUjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775142015; x=
	1775228415; bh=pssyYGpmcMDITeJql5XIx2lmyOqjHKa/++zlF/mlDic=; b=C
	xcCtsyCWad0b7tPGSOFsqplJcE+HquTY9fiRDyog1ZnP0RyEOe0OJ81j7OSXV9n3
	kElz8MHnjGtOnS/XPHVSdEtBpBm2GNvdJHYaKSTHocYKAMN1gPR/FCjEfJgtMSWM
	tTxTzGKApYmnDRp0e3PLjH1kiXNDcRE5+G0PmFNSQ6WJFziv7NTfYaWLX7+btrMf
	iNWrMlPa1WnH0g1tycJ35gyJbiWxamhwRlUQ049ufwlYKgMpjxV61BUwkTyufeDB
	aAx7LCLWSOZvQv9sujkCYIkaNj0k+XBWUD9aZl8SQEfEMVq+EyzuOQWGI/W6YgEa
	Z0igxAbFbCfOd1yIruPwg==
X-ME-Sender: <xms:foTOaY4Fm_g3QZ76mmsBynPE7SHBsfNuP_mBmkqQHJ_OxQPDpbq85g>
    <xme:foTOaUvFdT8O7_sqcjzTqLdJltwAxnPTR7_wo2iIgrU1y8ImVSFZ1EZqLeiCs_pWf
    fPxZl6tlHrmjSMnIJiSHdk6bXAxurcbakCjWmAeFw15DH6MBLXwqNPy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeifeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    ephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtoheprghirhhlih
    gvugesghhmrghilhdrtghomhdprhgtphhtthhopeguvghllhgvrhesghhmgidruggvpdhr
    tghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgvnhhhuh
    grtggriheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepfigvihdrlhhiuheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepihhlihgrshdrrghprghlohguihhmrghssehlihhnrghrohdrohhrghdprhgt
    phhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrd
    gtohhm
X-ME-Proxy: <xmx:foTOaQDgmwNtb_d4pYFIDoo1CNK_HkrBIx2bnzxua9Ubpn-pkWS5Aw>
    <xmx:foTOad9x5xOAq8wlo-iVzSKVbQXvcB5bEsoVBAaM3TSZyL34wd15fQ>
    <xmx:foTOaST8XhWPRBAMq1wJvzYiMwtgZG2XOBcrN8e9eNNOYcm4DwBVHA>
    <xmx:foTOaT7iy3G9XhuHXObB1084AYWscFLTcO4XzqiJYBJtrX3l2Saj-Q>
    <xmx:f4TOacnM7-O8MPwR8jWy0xn0FAt4orE8mfhFCSjxO3ToReT2gITeUJro>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 38C8970006A; Thu,  2 Apr 2026 11:00:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATYY62_w4Fts
Date: Thu, 02 Apr 2026 16:59:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Javier Martinez Canillas" <javierm@redhat.com>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Dave Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "K. Y. Srinivasan" <kys@microsoft.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>,
 "Dexuan Cui" <decui@microsoft.com>, longli@microsoft.com,
 "Helge Deller" <deller@gmx.de>
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Message-Id: <d3d7c545-3b07-4881-a16d-45b6f039de19@app.fastmail.com>
In-Reply-To: <3e466158-c2e5-4e23-934f-dcdbb71ad41f@suse.de>
References: <20260402092305.208728-1-tzimmermann@suse.de>
 <20260402092305.208728-4-tzimmermann@suse.de>
 <78f76717-8f1e-41d6-92f7-261df96b84b6@app.fastmail.com>
 <3e466158-c2e5-4e23-934f-dcdbb71ad41f@suse.de>
Subject: Re: [PATCH 3/8] firmware: sysfb: Make CONFIG_SYSFB a user-selectable option
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9905-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,redhat.com,kernel.org,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,microsoft.com,gmx.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail,messagingengine.com:server fail,arndb.de:server fail,app.fastmail.com:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.892];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid]
X-Rspamd-Queue-Id: D717B38B0CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026, at 16:10, Thomas Zimmermann wrote:
> Am 02.04.26 um 15:08 schrieb Arnd Bergmann:
>> On Thu, Apr 2, 2026, at 11:09, Thomas Zimmermann wrote:
>> I don't really like this part of the series and would prefer
>> to keep CONFIG_SYSFB hidden as much as possible as an x86
>> (and EFI) specific implementation detail, with the hope
>> of eventually seperating out the x86 bits from the EFI ones.
>
> You mean, you want to use the EFI-provided framebuffers without the 
> intermediate step of going through sysfb_primary_display?
>
> In that case, CONFIG_SYSFB would become an x86-internal thing, right?

The part that is still needed from sysfb is the arbitration
between DRM_EFI and the PCI device driver for the same hardware,
so I think some part of sysfb is clearly needed, in particular
the sysfb_disable() function that removes the EFI framebuffer
when there is a conflicting simpledrm or hardware specific
driver.

The parts that I want to keep out of that is anything
related to the x86 boot protocol, non-EFI framebuffers,
text console, and kexec handoff, which we don't need on
non-x86 UEFI systems.

I don't mind the idea of having a sysfb_primary_display
in the EFI code if that helps keep EFI sane on x86,
but it would be good to make that local to
drivers/firmware/efi and (eventually) detached from
include/uapi/linux/screen_info.h.

>> In general, I am always in favor of properly using Kconfig
>> dependencies over 'select' statements, for the same reasons
>> you describe, but I don't want the the x86 logic for
>> the legacy VESA and VGA console handling to leak into more
>> architectures than necessary.
>>
>> Do you think we could instead move the sysfb_init()
>> function into the same two places that contain the
>> sysfb_primary_display definition (arch/x86/kernel/setup.c,
>> drivers/firmware/efi/efi-init.c) and simplify the efi version
>> to take out the x86 bits? That would reduce the rest
>> of sysfb-primary.c to the logic to unregister the device,
>> and that could then be selected by both x86 and EFI.
>
> No, I'm more than happy that sysfb finally consolidates all the 
> init-framebuffer setup and detection that floated around in the kernel. 
> I would not want it to be duplicated again.
>
> For now, we could certainly keep CONFIG_SYSFB hidden and autoselected. 
> Although I think this will require soem sort of solution at a later point.

Can you clarify which problem you are trying to solve
with that?

     Arnd

