Return-Path: <linux-hyperv+bounces-10086-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP+EF3di1mnIEwgAu9opvQ
	(envelope-from <linux-hyperv+bounces-10086-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 16:13:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B76503BD78D
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 16:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05BE93015E14
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 14:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3483D1CB4;
	Wed,  8 Apr 2026 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="chExnYNH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xdGis38r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="chExnYNH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xdGis38r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE01C3D0929
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Apr 2026 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657274; cv=none; b=Z7PerQG8t2n8deB0t5tFH7RQ55sv7Z51y0S7AZ5mY8GQ+ywTqXni8QaJYTtJcrDjVidpDqtew+m3jwUbMrq53yXhPKaLUCIpbajfjLIrNFKkZppgiZL2p+pqfViMf7MwXSeWlPW5aZoh0Hp3EKb6BAdw2FB/VYVYC7jxzElfzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657274; c=relaxed/simple;
	bh=vifCC4U+ujhVWQuBmpKGQKVOnSnJtO7gU0fTZutv+Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLRW7n1HQkTG2PCHu713HhKGTYUrClDgX/3Abw2Kw9aYO/VjMARMo6a0vwZC1U7/naqvMXWG7zn6HjDCszwE0YM6vKngkRL/izVj5175APL4LMxU4N8iffcuB41TL/gIR9+eIBUxm7501SUpNGBt3yUxv29DPEZ2R8FpnqWTgCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=chExnYNH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xdGis38r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=chExnYNH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xdGis38r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A9F15BCC1;
	Wed,  8 Apr 2026 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775657271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xBsJJwq3aAo0fN1L2VfiJuBT66sNDAZYxUUPKQMoEU0=;
	b=chExnYNHZVd6FlMm0KVTdGdxr1iOqTnYs0eOmqY/NDE+R7ASlx9be4QtcQm322Cx/L1lnF
	FmjbE976ZWnbCqGsd6hxWjpTHM+4afD1EJdbuCeDWVUXEH+Dkrs832GrkcKjWInszBYj0d
	6YfdjLuwRTRKUsAeKFrjNb+iBIrrPNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775657271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xBsJJwq3aAo0fN1L2VfiJuBT66sNDAZYxUUPKQMoEU0=;
	b=xdGis38rNXjq+3iIGU6GIiIqi/CK8kNi603q2wpt0k7FkCarq0ixd58TiSzXRlaXxA1qW7
	TZK1Pug7lR8WK4Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775657271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xBsJJwq3aAo0fN1L2VfiJuBT66sNDAZYxUUPKQMoEU0=;
	b=chExnYNHZVd6FlMm0KVTdGdxr1iOqTnYs0eOmqY/NDE+R7ASlx9be4QtcQm322Cx/L1lnF
	FmjbE976ZWnbCqGsd6hxWjpTHM+4afD1EJdbuCeDWVUXEH+Dkrs832GrkcKjWInszBYj0d
	6YfdjLuwRTRKUsAeKFrjNb+iBIrrPNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775657271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xBsJJwq3aAo0fN1L2VfiJuBT66sNDAZYxUUPKQMoEU0=;
	b=xdGis38rNXjq+3iIGU6GIiIqi/CK8kNi603q2wpt0k7FkCarq0ixd58TiSzXRlaXxA1qW7
	TZK1Pug7lR8WK4Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80E424A0B3;
	Wed,  8 Apr 2026 14:07:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bj9EHjZh1mn1TQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 08 Apr 2026 14:07:50 +0000
Message-ID: <5b08f041-b820-4c63-8e1b-b4348909bf0f@suse.de>
Date: Wed, 8 Apr 2026 16:07:50 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] firmware: efi: Never declare sysfb_primary_display on
 x86
To: Ard Biesheuvel <ardb@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>, Arnd Bergmann
 <arnd@arndb.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 kys@microsoft.com, haiyangz@microsoft.com, Wei Liu <wei.liu@kernel.org>,
 decui@microsoft.com, Long Li <longli@microsoft.com>,
 Helge Deller <deller@gmx.de>
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-fbdev@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20260402092305.208728-1-tzimmermann@suse.de>
 <20260402092305.208728-3-tzimmermann@suse.de>
 <d0624a61-b96b-4b2f-89c2-029e8671039d@app.fastmail.com>
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
In-Reply-To: <d0624a61-b96b-4b2f-89c2-029e8671039d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10086-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,arndb.de,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,microsoft.com,gmx.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,10.150.64.97:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email,intel.com:email]
X-Rspamd-Queue-Id: B76503BD78D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

Am 08.04.26 um 15:45 schrieb Ard Biesheuvel:
> Hi Thomas,
>
> On Thu, 2 Apr 2026, at 11:09, Thomas Zimmermann wrote:
>> The x86 architecture comes with its own instance of the global
>> state variable sysfb_primary_display. Never declare it in the EFI
>> subsystem. Fix the test for CONFIG_FIRMWARE_EDID accordingly.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Fixes: e65ca1646311 ("efi: export sysfb_primary_display for EDID")
>> Cc: kernel test robot <lkp@intel.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: linux-efi@vger.kernel.org
>> ---
>>   drivers/firmware/efi/efi-init.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
> Should this be sent out as a fix?

Yes, please.



-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



