Return-Path: <linux-hyperv+bounces-9903-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKhxC41szmmpngYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9903-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 15:18:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DCA389881
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 15:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 907E731C861A
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 13:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302D73E5593;
	Thu,  2 Apr 2026 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FBxYlgk5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="agPYXQIZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C1B371D0A;
	Thu,  2 Apr 2026 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135373; cv=none; b=j2ETmJzodBJG/m7nYDRAWGOWOG0gxZzUXSJxY2s84ycvtwufKOs+Yjie9jCPYq1QMlgcaB1VflQ+i+7mBJYqdxZbYkvtrmvTE0df79dFbopykXk4SeuZ0laxzx1dlH5BfoxCrCd/CuH9mJdR4znHdwfUY934hc2hRMN0gpG5Y+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135373; c=relaxed/simple;
	bh=+IvFOuVs28xANyS/ogfV1Pq/Sq/UwTNttO7Vn4bEkv0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Wvx+Yx7HcGSHHgyJ793lhgG6Us4Y13RtD+K41Juuu+2aqLxGsTSdup+k1GJNQcHEPDhZBhjdotEINS1fXUHe6BQOs4+EpoR/CBbsDC3oLHrqycuTXDWxNlBT7wI01eu4YKHHXyYEvv+kzZN7aVs1cu/l9zWMmIMZ6CEmHhjKWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FBxYlgk5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=agPYXQIZ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4567A7A011F;
	Thu,  2 Apr 2026 09:09:26 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 09:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775135366;
	 x=1775221766; bh=44e76YJxkd5q+hgUlWAXtOLYIJKiZNYp0nUsEzVCRk0=; b=
	FBxYlgk5LwTbC6Hd0pYsekY+cj/43xfDic3Nq5KUYXIuAByjWcQC/4MynK8EvGyv
	Uexk61LrbgEEKfXkfTlK/shMDYl5tyAn5shj5yTVpfPkur7h2UHMqxssu5nPxFoa
	8vRfS2ciCetboKjFIxSqY/FCKB4xHDco2m54AOjrLpQIp74wqvRjCB/NWCddnFbT
	0OTw/HpU2+VuBssb4bSjrLHtUqxuTg6rsGhW5fhjLiN2JmVBTYGLY7+coU3dR9Xh
	kqkSyJqdDab0AXssZVE+URd2eVr0yDCGcxJxKLmiq6mHj7HSPdlt4CCQUxUTgVUD
	sPIHM0gA5KivuyxhzN/y+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775135366; x=
	1775221766; bh=44e76YJxkd5q+hgUlWAXtOLYIJKiZNYp0nUsEzVCRk0=; b=a
	gPYXQIZnT60HzAt2D0PVne9tKUzCK0FsozqUq7cu6ndYiCt4Z/zV7H3GR6snL8YH
	Nia8I0kaiAnShNcTT/6fGyjj95fpYvgUCc2AH+6xSurhsnlZ0/6xukuewVctmEsx
	caolHX6d3alkzc44sfHAEk/0YOY+sjm4Ulbwnunt1Z9c/aHUj2GGIQ5OaUk7ZUqB
	qY8rSjZg92tjU6RaPqkWQnkAXLL5Jlys5BzrZH/DGIlwyuvhzujN3faH5snylGiP
	c8fS9Rb3CO+ArMxP1zOFsIDznAp7cTRsV6Szkag3nisaBKJyi+L/Guz8OyI468i/
	XwUvWnLeDj7G6x+YHKoMg==
X-ME-Sender: <xms:hWrOacBTCxdDYIcJJmzYbVFEnnKq3VZJ2svW2EbxtuMV_IEV78GleA>
    <xme:hWrOaZX8n43r1AuPAp20ZIPd-3JBc8md8Q2lCb8q6ld8xW__eIdTD4wKGkj2WLlkC
    RaGDhtaQ6b9vmBnJwRoYLO0DM2MVb-fENcE3LIWtDZK0VG9hguYe8wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiudduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:hWrOaRJECYk7puPdfEJsTZFmLUHJ2_Z9AuyoEdU1gXrkS-yMyi0yeQ>
    <xmx:hWrOaYk5-wfc0FB5RtkxmKUuvjk5TSISjWQ-QCF72nf8aIeKlC4K2A>
    <xmx:hWrOaYa75UPVpD3coPM_gSmGfD7moZUk6STsXIaichwb1GQ5apWUDA>
    <xmx:hWrOafhqdbusxY3d9sJNkItrflm8nihdTYsks40u3x14gzVAeZ__yw>
    <xmx:hmrOaavXLi6cH6_83S9pbfjqCQNQGiA5wxCo72vsfMgeAep0jKjdGOSp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 462A2700065; Thu,  2 Apr 2026 09:09:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATYY62_w4Fts
Date: Thu, 02 Apr 2026 15:08:43 +0200
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
Message-Id: <78f76717-8f1e-41d6-92f7-261df96b84b6@app.fastmail.com>
In-Reply-To: <20260402092305.208728-4-tzimmermann@suse.de>
References: <20260402092305.208728-1-tzimmermann@suse.de>
 <20260402092305.208728-4-tzimmermann@suse.de>
Subject: Re: [PATCH 3/8] firmware: sysfb: Make CONFIG_SYSFB a user-selectable option
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,redhat.com,kernel.org,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,microsoft.com,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9903-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.863];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arndb.de:dkim,app.fastmail.com:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: A0DCA389881
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026, at 11:09, Thomas Zimmermann wrote:
> Add a descriptive string and help text to CONFIG_SYSFB, so that users
> can modify it. Flip all implicit selects in the Kconfig options into
> dependencies. This avoids cyclic dependencies in the config.
>
> Enabling CONFIG_SYSFB makes the kernel provide a device for the firmware
> framebuffer. As this can (slightly) affect system behavior, having a
> user-facing option seems preferable. Some users might also want to set
> every detail of their kernel config.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

I don't really like this part of the series and would prefer
to keep CONFIG_SYSFB hidden as much as possible as an x86
(and EFI) specific implementation detail, with the hope
of eventually seperating out the x86 bits from the EFI ones.

In general, I am always in favor of properly using Kconfig
dependencies over 'select' statements, for the same reasons
you describe, but I don't want the the x86 logic for
the legacy VESA and VGA console handling to leak into more
architectures than necessary.

Do you think we could instead move the sysfb_init()
function into the same two places that contain the
sysfb_primary_display definition (arch/x86/kernel/setup.c,
drivers/firmware/efi/efi-init.c) and simplify the efi version
to take out the x86 bits? That would reduce the rest
of sysfb-primary.c to the logic to unregister the device,
and that could then be selected by both x86 and EFI.

      Arnd

