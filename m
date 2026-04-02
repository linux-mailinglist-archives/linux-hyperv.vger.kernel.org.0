Return-Path: <linux-hyperv+bounces-9911-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBkROQyLzmlMoQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9911-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:28:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 606C138B41C
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5DFC304E81A
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A8033F8CA;
	Thu,  2 Apr 2026 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NcND9pxl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+XN1aYgE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NcND9pxl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+XN1aYgE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F934D91F
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Apr 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143636; cv=none; b=pPoiWjlswZ+DtFfWyWycI4scsgaxXKKzNs5lNV+qgH7PVo90sIBa1PETOwS79qT/sXCVUS8/AEW6vAP4MCmQAweOFd7qJ4R0IkV7zbiLbDNioIayjT0XfsdvwkDaR2d4L7m0s/iPfK2hxutxGlExO2V5/SJgqvC/faNFcrGyNLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143636; c=relaxed/simple;
	bh=HEXRPBaUhk+CH6QuCrpn+ci3ZzkvqoqOJQOeckQFB1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpXwBuGsfQA4KJSZK8GI7OjYSJ/UawuRw8z24P6u5flWw5WNG+Y+NTS/+GnqZjuJIlnIVW/qLETM8w6+yy8VwyGlvMybc4XfdzNX3N2FSPtldJHcyynHRHlEerKf3yVa0R9/Rte/RFoSdIUTs855CDVE62ZOej8bOtuMBMnr5Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NcND9pxl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+XN1aYgE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NcND9pxl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+XN1aYgE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 71E825BE1C;
	Thu,  2 Apr 2026 15:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775143633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IIJkyZ4vqVqocU0260kV/9e9mxp7Nf7GppVgKAYDdSY=;
	b=NcND9pxl0yg+bfnMPz3DZPhuSNTO7WXGIqZ2SRslgy6FRLaAKFjKfkltXIT8wMKtvaQMat
	wdr7zHgc3mhpRKS/hH180m35ntqkHAutmXyxaqyjx+/Z6WXlp6SuMsGmLMtgtv9Lppw1la
	YAbd3oISpYzHZJ1J85SjGAqbskJUCUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775143633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IIJkyZ4vqVqocU0260kV/9e9mxp7Nf7GppVgKAYDdSY=;
	b=+XN1aYgEZxrW4VREe8WxPTgskOQKj2Mh89mLE/+Ni4A5KzK+ErobJbFr7AepIrMve9+sA3
	rF1W61MS7QyQnIDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NcND9pxl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+XN1aYgE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775143633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IIJkyZ4vqVqocU0260kV/9e9mxp7Nf7GppVgKAYDdSY=;
	b=NcND9pxl0yg+bfnMPz3DZPhuSNTO7WXGIqZ2SRslgy6FRLaAKFjKfkltXIT8wMKtvaQMat
	wdr7zHgc3mhpRKS/hH180m35ntqkHAutmXyxaqyjx+/Z6WXlp6SuMsGmLMtgtv9Lppw1la
	YAbd3oISpYzHZJ1J85SjGAqbskJUCUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775143633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IIJkyZ4vqVqocU0260kV/9e9mxp7Nf7GppVgKAYDdSY=;
	b=+XN1aYgEZxrW4VREe8WxPTgskOQKj2Mh89mLE/+Ni4A5KzK+ErobJbFr7AepIrMve9+sA3
	rF1W61MS7QyQnIDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC57A4A0B0;
	Thu,  2 Apr 2026 15:27:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6UFUNNCKzmnZUwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 02 Apr 2026 15:27:12 +0000
Message-ID: <001efe27-9cbb-4a89-8d2d-a1f3ae15e505@suse.de>
Date: Thu, 2 Apr 2026 17:27:12 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] firmware: sysfb: Make CONFIG_SYSFB a user-selectable
 option
To: Arnd Bergmann <arnd@arndb.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Dave Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, longli@microsoft.com,
 Helge Deller <deller@gmx.de>
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-fbdev@vger.kernel.org
References: <20260402092305.208728-1-tzimmermann@suse.de>
 <20260402092305.208728-4-tzimmermann@suse.de>
 <78f76717-8f1e-41d6-92f7-261df96b84b6@app.fastmail.com>
 <3e466158-c2e5-4e23-934f-dcdbb71ad41f@suse.de>
 <d3d7c545-3b07-4881-a16d-45b6f039de19@app.fastmail.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <d3d7c545-3b07-4881-a16d-45b6f039de19@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9911-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[arndb.de,redhat.com,kernel.org,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,microsoft.com,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.963];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:url]
X-Rspamd-Queue-Id: 606C138B41C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

Am 02.04.26 um 16:59 schrieb Arnd Bergmann:
> On Thu, Apr 2, 2026, at 16:10, Thomas Zimmermann wrote:
>> Am 02.04.26 um 15:08 schrieb Arnd Bergmann:
>>> On Thu, Apr 2, 2026, at 11:09, Thomas Zimmermann wrote:
>>> I don't really like this part of the series and would prefer
>>> to keep CONFIG_SYSFB hidden as much as possible as an x86
>>> (and EFI) specific implementation detail, with the hope
>>> of eventually seperating out the x86 bits from the EFI ones.
>> You mean, you want to use the EFI-provided framebuffers without the
>> intermediate step of going through sysfb_primary_display?
>>
>> In that case, CONFIG_SYSFB would become an x86-internal thing, right?
> The part that is still needed from sysfb is the arbitration
> between DRM_EFI and the PCI device driver for the same hardware,
> so I think some part of sysfb is clearly needed, in particular
> the sysfb_disable() function that removes the EFI framebuffer
> when there is a conflicting simpledrm or hardware specific
> driver.

We do most of that in the aperture-helper module. (see 
<linux/aperture.h>). Calling sysfb_disable() from there is a workaround 
for some corner cases. We can have an EFI-specific function that does 
the same.

BTW, simpledrm-on-EFI/VESA is considered obsolete and should preferably 
be removed from that driver. Simpledrm should become a driver for 
Devicetree nodes of type simple-framebuffer (as it originally has been 
intended).

>
> The parts that I want to keep out of that is anything
> related to the x86 boot protocol, non-EFI framebuffers,
> text console, and kexec handoff, which we don't need on
> non-x86 UEFI systems.
>
> I don't mind the idea of having a sysfb_primary_display
> in the EFI code if that helps keep EFI sane on x86,
> but it would be good to make that local to
> drivers/firmware/efi and (eventually) detached from
> include/uapi/linux/screen_info.h.

Efidrm retrieves the framebuffer settings from the contained struct 
screen_info. Disconnecting from screen_info would require separate 
graphics drivers for x86 and non-x86. If we split off EFI from sysfb, 
we'd likely need a sysfbdrm driver of some sort. Just saying.

I think we'd also have to duplicate the framebuffer-relocation code that 
currently works on anything using struct screen_info (see patch 5).

>
>>> In general, I am always in favor of properly using Kconfig
>>> dependencies over 'select' statements, for the same reasons
>>> you describe, but I don't want the the x86 logic for
>>> the legacy VESA and VGA console handling to leak into more
>>> architectures than necessary.
>>>
>>> Do you think we could instead move the sysfb_init()
>>> function into the same two places that contain the
>>> sysfb_primary_display definition (arch/x86/kernel/setup.c,
>>> drivers/firmware/efi/efi-init.c) and simplify the efi version
>>> to take out the x86 bits? That would reduce the rest
>>> of sysfb-primary.c to the logic to unregister the device,
>>> and that could then be selected by both x86 and EFI.
>> No, I'm more than happy that sysfb finally consolidates all the
>> init-framebuffer setup and detection that floated around in the kernel.
>> I would not want it to be duplicated again.
>>
>> For now, we could certainly keep CONFIG_SYSFB hidden and autoselected.
>> Although I think this will require soem sort of solution at a later point.
> Can you clarify which problem you are trying to solve
> with that?

One thing is that some users simply what control over their kernel build.

I also think that there might be systems that want to use 
sysfb_primary_display (plus the relocation feature), but not create the 
framebuffer device. Say for efi-earlycon. It needs user-control over the 
SYSFB option to do that.

As a side-effect, user-configurable SYSFB gives us a nice place to put 
SYSFB_SIMPLEFB and FIRMWARE_EDID; two options that currently float 
around in the config somewhat arbitrarily.

Best regards
Thomas

>
>       Arnd

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



