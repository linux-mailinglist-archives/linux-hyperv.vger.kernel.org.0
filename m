Return-Path: <linux-hyperv+bounces-10518-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM4TMzD48mnFwAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10518-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 08:35:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CCD49E1DC
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 08:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8962A300BB98
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 06:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D7B9443;
	Thu, 30 Apr 2026 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KQ61o7p4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cZn5CA9f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rNprQVbr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kmexgdeq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D82BE7AB
	for <linux-hyperv@vger.kernel.org>; Thu, 30 Apr 2026 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777530926; cv=none; b=l96XL6uTnDLgO8/+FANr/1c2yRnvvS2zJbVTVt061m1uh4xvCb9gTKIZHvMv08YoOzYNbfVFyGF2FgdooKF7FMX9LSuP4mYvazgM9nDgN3Z9t4zomMpjNqkCMmeRzx7sc38GtThQdiMEOjtfTBAHbB9sYhKCO0lNr8G8Cjs7FMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777530926; c=relaxed/simple;
	bh=q0IdfS84XFBqKC7wln01aji8PKQdtX9bmCrIlNxiQoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrzeF1K9lQf6Xi+QEZPnIrrFOY4qE/dnVZzUVdLY3ArjjyBMa/qHQAIzSZQHpRoa7nq8Bz7AjgvnR6KHNntJaEhFtoAsxECNxTYVUg3QK2UurML30ORV6RokmMAbnZ0ihgMTFNoVLnGKvmbwafWWJ7fBLY2YWDYbnWU+oR8Wv9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KQ61o7p4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cZn5CA9f; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rNprQVbr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kmexgdeq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 88D5F5BD6E;
	Thu, 30 Apr 2026 06:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777530923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a0LF9opS/4b9B5ZY/UhjqVoZf/jyWF4njFUo2Jwl3Jg=;
	b=KQ61o7p4Lud8fy8AuyJ5fPImBAR44t1XUReUywn47MtP+OkBWooU6zMWYg2a05H5x0y3NC
	6fY5Tn8gBiUR1/lNx1u0PZlXoTtva2b+f+7s3VOcpya9eEgI4hZtOTi7jX06z9gO7k7ir2
	WwYgcnuWLl1f2yAwhRltkbP2DN/aZLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777530923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a0LF9opS/4b9B5ZY/UhjqVoZf/jyWF4njFUo2Jwl3Jg=;
	b=cZn5CA9fBiY9CgVLbVPBwOShViQOhEx7epHbKyV+WHvfSb3BQ8InkrR6ksK5FnBy1JzhkS
	1KQGwrECYhXZUCBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777530922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a0LF9opS/4b9B5ZY/UhjqVoZf/jyWF4njFUo2Jwl3Jg=;
	b=rNprQVbr58snlf0nWjdC8xT6swp9DU4zo9KAyEO5LBExhaa69LfzB9hC84Nm1zrXVcuYRy
	LGPzuNsQNnJawTf4y0r3zQbdvz7SE5YrSP1CBEBfn7BWMZ1jmreBEic6kSxYqz7xnGI+/c
	rOo92tNFNGal0oDaVdyKQywbgxVDFzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777530922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a0LF9opS/4b9B5ZY/UhjqVoZf/jyWF4njFUo2Jwl3Jg=;
	b=kmexgdeqeFSnoq8f26oKl38iMGX2IFk04AQ84o2Xy0n/o14JzuiefpBblXbVyyHDJ+AAvt
	eH/vEWwpLDqvV3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E564F593B0;
	Thu, 30 Apr 2026 06:35:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v3YtNin48mlKFAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 30 Apr 2026 06:35:21 +0000
Message-ID: <fb6e2aa8-3636-407f-a3fc-846a80e34d7b@suse.de>
Date: Thu, 30 Apr 2026 08:35:21 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] firmware: sysfb: Consolidate config/code wrt.
 sysfb_primary_screen
To: patchwork-bot+linux-riscv@kernel.org
Cc: linux-riscv@lists.infradead.org, javierm@redhat.com, arnd@arndb.de,
 ardb@kernel.org, ilias.apalodimas@linaro.org, chenhuacai@kernel.org,
 kernel@xen0n.name, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, deller@gmx.de, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-efi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-fbdev@vger.kernel.org
References: <20260402092305.208728-1-tzimmermann@suse.de>
 <177751955329.2274119.12779807302343885295.git-patchwork-notify@kernel.org>
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
In-Reply-To: <177751955329.2274119.12779807302343885295.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Queue-Id: 73CCD49E1DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,redhat.com,arndb.de,kernel.org,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,microsoft.com,gmx.de,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-10518-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,linux-riscv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi

Am 30.04.26 um 05:25 schrieb patchwork-bot+linux-riscv@kernel.org:
> Hello:
>
> This series was applied to riscv/linux.git (fixes)
> by Ard Biesheuvel <ardb@kernel.org>:

Patch 3 was fairly controversial.

Best regards
Thomas

>
> On Thu,  2 Apr 2026 11:09:14 +0200 you wrote:
>> The global state sysfb_primary_screen holds information about the
>> framebuffer provided by EFI/BIOS systems. It is part of the sysfb
>> module, but used in several places without direct connection to
>> sysfb. Fix this by making users of sysfb_primary_screen depend on
>> CONFIG_SYSFB. Fix a few issues in the process.
>>
>> Patches 1 and 2 fix general errors in the Kconfig rules. In any case,
>> these patches should be considered even without the rest of the series.
>>
>> [...]
> Here is the summary with links:
>    - [1/8] hv: Select CONFIG_SYSFB only for CONFIG_HYPERV_VMBUS
>      https://git.kernel.org/riscv/c/d33db956c961
>    - [2/8] firmware: efi: Never declare sysfb_primary_display on x86
>      https://git.kernel.org/riscv/c/5241c2ca33bb
>    - [3/8] firmware: sysfb: Make CONFIG_SYSFB a user-selectable option
>      (no matching commit)
>    - [4/8] firmware: sysfb: Split sysfb.c into sysfb_primary.c and sysfb_pci.c
>      (no matching commit)
>    - [5/8] firmware: sysfb: Implement screen_info relocation for primary display
>      (no matching commit)
>    - [6/8] firmware: sysfb: Avoid forward-declaring sysfb_parent_dev()
>      (no matching commit)
>    - [7/8] firmware: efi: Make CONFIG_EFI_EARLYCON depend on CONFIG_SYSFB; clean up
>      (no matching commit)
>    - [8/8] firmware: sysfb: Move CONFIG_FIRMWARE_EDID to firmware options
>      (no matching commit)
>
> You are awesome, thank you!

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



