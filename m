Return-Path: <linux-hyperv+bounces-9917-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JlSNrufzmlZpAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9917-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 18:56:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1E438C412
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 18:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05D523094029
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 16:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB53F3F1658;
	Thu,  2 Apr 2026 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SbNsQGJr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jekHnRJI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B90436403A;
	Thu,  2 Apr 2026 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775148563; cv=none; b=InGLOpx2qu8gtHoSbV6Pu4JSGN7XIRtjfH2tuoY4XNaZwNJmND83ode8zGbCMgQuU/S9XTeetWACjoRoWYhTrRWX53grLWEWrdMd/iO0RJI8r8f/t71NldGQ6WvZtxNktieYubd78eLFyWEEg2kisi747ontcgBADn2TRdb0oaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775148563; c=relaxed/simple;
	bh=lY8OSAjdvIRcXKeggCWDfTpxvAJNDC+l8OE4qqpRHlI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Bhj+hnCuFUv0TLXBGDh+XtOQvWG4NxFpXyaPR8zw1wAOpyr0yVo4uRkabfqncofFt/5ifSp1YnhSxH39mys2tCeuziz5o8N3AhzUbCP1lGhfygIdDmwsObypyMNt0yVuaNIuHg85yYZ0PhLiVytlTQA86TRzRx6erfZpP/ooD4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SbNsQGJr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jekHnRJI; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F0B3C7A00DC;
	Thu,  2 Apr 2026 12:49:11 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 12:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775148551;
	 x=1775234951; bh=lYV/HE/eaLjj4haLdqZX1D55ej4Hm/J5ZQp8Ipwz81U=; b=
	SbNsQGJrGjnB8ek6JMQE3rHUQ2eUZ2jW9OQWsaMHhAu3T8VI5iSevjK4RHN3QMKD
	/kjRkhCWK7n6krz5Y5jUWRRobjA+NsF+nMuB8Jb3+gNaX/jWelDwsEInvt4JxRSv
	sLX1i72t3HMmj+kjDeWBHol2RF4kFmJJYjLcOSilVLOoyMLrWBp7m03iF/MWqrlR
	UmhV9T97QFqNQGogOFD9CRI85tnJEOgaJSGr4F0R5o8fHrhnkhdaOyTsNmcIQbdp
	kj41b6kGgeK/K2S7uWRHV2iXi+9kUz8TIhmoDkAjLzBnpZWciM6atk51S5QC2CwO
	f6ilWCBh6l8kEHQVfmXC0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775148551; x=
	1775234951; bh=lYV/HE/eaLjj4haLdqZX1D55ej4Hm/J5ZQp8Ipwz81U=; b=j
	ekHnRJIb57zb6LNOJw/r5P4rlGsJAg3yyh9+jR8fDFI3oMOD4JBygyuuyKyhE8FL
	LIieQ5o8+IapaBHO8Kfv10zCNuLkTlagAYq6qpFi61cuv54UXNpUic6uR4ZlYRRc
	61vOt+0wa/qbp6RufGXIfm8lggh9zOUC2+XO4Oh336G7NcN5O5aIB72koZKkdxFr
	DWbVXav9gZgiQAQThSVmbmtzlGczE+qqFyouqpYWnOReOOYqe1OT++8ORlsunYws
	r79VWh6bCXLiK08tza93I3YRq/bk9LfdIl7MssNZWGv5kqRbhgDmXdX2Vul9ftlk
	ChEIlBFRarXY8yq+mrJOA==
X-ME-Sender: <xms:B57Oaah1IAVM1MpqVucregry5V56_mF6D_tfVj0QyHv3UO9mypWXSQ>
    <xme:B57OaV3c9VoVWeV8baNic297CVGm1HWc3HargMvcEsE5WTlW8umiBCVlgCSHWlBuq
    6gvBHj2nKSaoztXPOPqff5CZH8oSnPjesjCD5X4vLXFn_c1pVXrH7N5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiheehucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:B57OaXq7Fq8tP7x6l5dBAWWWbFxGc72eT4nZc1Ez2R9yelqsIbe0iw>
    <xmx:B57OadGA3pgF6EIjYalsXy3pJ2CMHaefryWrCjjpq2PpqIhrBWtQFA>
    <xmx:B57OaS7FFU3NE9O5REXDd6c-ZPeED_eMbfTPjk8ySEwf_duLCEL7kA>
    <xmx:B57OaYB3dmTgiRgVub4R4xNil6GrnUqBFP0V5-YXn9cE-BSTBYwEqA>
    <xmx:B57OaVNHy5qQPJxXUY3g2qeqnNDg8D1RrXtmnTXvVchJ2_tkVfjYL5Pz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EE7BE700065; Thu,  2 Apr 2026 12:49:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATYY62_w4Fts
Date: Thu, 02 Apr 2026 18:47:01 +0200
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
Message-Id: <295a43ce-92fb-435d-a82f-d1cfa8f4f28d@app.fastmail.com>
In-Reply-To: <001efe27-9cbb-4a89-8d2d-a1f3ae15e505@suse.de>
References: <20260402092305.208728-1-tzimmermann@suse.de>
 <20260402092305.208728-4-tzimmermann@suse.de>
 <78f76717-8f1e-41d6-92f7-261df96b84b6@app.fastmail.com>
 <3e466158-c2e5-4e23-934f-dcdbb71ad41f@suse.de>
 <d3d7c545-3b07-4881-a16d-45b6f039de19@app.fastmail.com>
 <001efe27-9cbb-4a89-8d2d-a1f3ae15e505@suse.de>
Subject: Re: [PATCH 3/8] firmware: sysfb: Make CONFIG_SYSFB a user-selectable option
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,redhat.com,kernel.org,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,microsoft.com,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9917-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid]
X-Rspamd-Queue-Id: 1E1E438C412
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026, at 17:27, Thomas Zimmermann wrote:
> Am 02.04.26 um 16:59 schrieb Arnd Bergmann:
>> On Thu, Apr 2, 2026, at 16:10, Thomas Zimmermann wrote:
>>> Am 02.04.26 um 15:08 schrieb Arnd Bergmann:
>>>> On Thu, Apr 2, 2026, at 11:09, Thomas Zimmermann wrote:
>>>> I don't really like this part of the series and would prefer
>>>> to keep CONFIG_SYSFB hidden as much as possible as an x86
>>>> (and EFI) specific implementation detail, with the hope
>>>> of eventually seperating out the x86 bits from the EFI ones.
>>> You mean, you want to use the EFI-provided framebuffers without the
>>> intermediate step of going through sysfb_primary_display?
>>>
>>> In that case, CONFIG_SYSFB would become an x86-internal thing, right?
>> The part that is still needed from sysfb is the arbitration
>> between DRM_EFI and the PCI device driver for the same hardware,
>> so I think some part of sysfb is clearly needed, in particular
>> the sysfb_disable() function that removes the EFI framebuffer
>> when there is a conflicting simpledrm or hardware specific
>> driver.
>
> We do most of that in the aperture-helper module. (see 
> <linux/aperture.h>). Calling sysfb_disable() from there is a workaround 
> for some corner cases. We can have an EFI-specific function that does 
> the same.

That sounds good, yes. The same change would need to go into
of_platform_default_populate_init() then.

> BTW, simpledrm-on-EFI/VESA is considered obsolete and should preferably 
> be removed from that driver. Simpledrm should become a driver for 
> Devicetree nodes of type simple-framebuffer (as it originally has been 
> intended).

Sure, I was only thinking of the case where there are both
sysfb (from Arm/riscv UEFI) and simpledrm (from devicetree)
objects referring to the same one, not the simpledrm
device created by sysfb_simplefb.

>> The parts that I want to keep out of that is anything
>> related to the x86 boot protocol, non-EFI framebuffers,
>> text console, and kexec handoff, which we don't need on
>> non-x86 UEFI systems.
>>
>> I don't mind the idea of having a sysfb_primary_display
>> in the EFI code if that helps keep EFI sane on x86,
>> but it would be good to make that local to
>> drivers/firmware/efi and (eventually) detached from
>> include/uapi/linux/screen_info.h.
>
> Efidrm retrieves the framebuffer settings from the contained struct 
> screen_info. Disconnecting from screen_info would require separate 
> graphics drivers for x86 and non-x86. If we split off EFI from sysfb, 
> we'd likely need a sysfbdrm driver of some sort. Just saying.

Yes, I saw that as well and don't have an immediate idea for how
to best do it. I saw that you already abstracted the access to
the screen_info members in drm_sysfb_screen_info.c, which I think
is a step in that direction.

I also noticed that efidrm is mostly a subset of vesadrm, so
in theory they could be merged back into an x86 drm driver
along with the drm_sysfb_screen_info helpers, and have a non-x86
driver that constructs a drm_sysfb_device directly from the
EFI structures.

> I think we'd also have to duplicate the framebuffer-relocation code that 
> currently works on anything using struct screen_info (see patch 5).

You mean the code from include/linux/screen_info.h? I think
it would make sense to have an x86 specific version of that
to operate on the x86 screen_info, and a simpler version
that just updates the resource for the efirdrm driver, but
that could also be done one level higher or lower.

>>>> In general, I am always in favor of properly using Kconfig
>>>> dependencies over 'select' statements, for the same reasons
>>>> you describe, but I don't want the the x86 logic for
>>>> the legacy VESA and VGA console handling to leak into more
>>>> architectures than necessary.
>>>>
>>>> Do you think we could instead move the sysfb_init()
>>>> function into the same two places that contain the
>>>> sysfb_primary_display definition (arch/x86/kernel/setup.c,
>>>> drivers/firmware/efi/efi-init.c) and simplify the efi version
>>>> to take out the x86 bits? That would reduce the rest
>>>> of sysfb-primary.c to the logic to unregister the device,
>>>> and that could then be selected by both x86 and EFI.
>>> No, I'm more than happy that sysfb finally consolidates all the
>>> init-framebuffer setup and detection that floated around in the kernel.
>>> I would not want it to be duplicated again.
>>>
>>> For now, we could certainly keep CONFIG_SYSFB hidden and autoselected.
>>> Although I think this will require soem sort of solution at a later point.
>> Can you clarify which problem you are trying to solve
>> with that?
>
> One thing is that some users simply what control over their kernel build.
>
> I also think that there might be systems that want to use 
> sysfb_primary_display (plus the relocation feature), but not create the 
> framebuffer device. Say for efi-earlycon. It needs user-control over the 
> SYSFB option to do that.

I'm still not following, sorry. efi-earlycon doesn't require
CONFIG_SYSFB today, and I don't see why that would need to change,
or why it couldn't just 'select SYSFB' if it it does change.

> As a side-effect, user-configurable SYSFB gives us a nice place to put 
> SYSFB_SIMPLEFB and FIRMWARE_EDID; two options that currently float 
> around in the config somewhat arbitrarily.

You said that SYSFB_SIMPLEFB should get phased out in the future,
right?

I'm also missing your plan for CONFIG_FIRMWARE_EDID. I only
see three legacy drivers using the old fb_firmware_edid()
interface, so I assume this is not what you are interested in. 

For the global copy that is filled by x86 and efi, and
consumed by vesadrm and efidrm, does that even need to
be a configuration option rather than get always enabled?

       Arnd

