Return-Path: <linux-hyperv+bounces-10125-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OUlBpCY3GnVTgkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10125-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 09:17:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C734E3E8236
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 09:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6070F3017F92
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7465B3932CC;
	Mon, 13 Apr 2026 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EMPBYo7m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZvsBVw15";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EMPBYo7m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZvsBVw15"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B5638AC72
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Apr 2026 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776064635; cv=none; b=ocM2apw1LDC/LJEoNS2ZONyd8FLj1fmoXNHOkYBTVR2w5Oueqa0DTTsVMonU7eQPjnxgu6LjR+k0k3lMAaQ7VGpbnWbY400+S3Xnj9tWS2/NgTGLLl8jw7i5vphTmD6QT1Eq8tNNaK1OHuwUJXKO4AVfy1f+yLVVkSfxEFeuXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776064635; c=relaxed/simple;
	bh=ze4rn4nn/Wo6g0BVi89lHVlN8HQ2KybbuWDeVEPYQ2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAvNt1zcyyXWSE14zBoEeUEQnZfdGq2T8fyZwOYDlMJy/yQ7kO3eJ1PqdWGCaNQpbwyUJPdorufVhByWCzqzu8RYfIYQU82ZYvuArqdE9/SG9YZOuOMNtSaNfTgK2p36aos0yV1u0ultZWdXY5FiwvILZyYdGDsUd/zRsyJSbf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EMPBYo7m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZvsBVw15; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EMPBYo7m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZvsBVw15; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D7BB6A7CA;
	Mon, 13 Apr 2026 07:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776064631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rW5R3xGds9bg8qA2Ep9wnIOEprJ657jFgsGGoKUBMeQ=;
	b=EMPBYo7maOolaDclqrmqB7DoCjl8hY7R4nEKa6AIy3rB1y3LfX+HoXBy7v/39LT1OKozid
	PuG7L6eBwWC+Lp1r7PzZRvDZ4NYYI+DPKy1TUuFlIPTi4EdrW/bHW1Z9cjxBUis2Uw17Sw
	HoiFtvk2JVm4WKbGYsztTjtOmWmQ+QE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776064631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rW5R3xGds9bg8qA2Ep9wnIOEprJ657jFgsGGoKUBMeQ=;
	b=ZvsBVw15CdLOkuECwK4FZfeeJL2S20COYfNUOGcCvtUx5gkYos6MV477z2JoIsUf6YWR/H
	+S/m0SXjg3jbqcDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776064631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rW5R3xGds9bg8qA2Ep9wnIOEprJ657jFgsGGoKUBMeQ=;
	b=EMPBYo7maOolaDclqrmqB7DoCjl8hY7R4nEKa6AIy3rB1y3LfX+HoXBy7v/39LT1OKozid
	PuG7L6eBwWC+Lp1r7PzZRvDZ4NYYI+DPKy1TUuFlIPTi4EdrW/bHW1Z9cjxBUis2Uw17Sw
	HoiFtvk2JVm4WKbGYsztTjtOmWmQ+QE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776064631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rW5R3xGds9bg8qA2Ep9wnIOEprJ657jFgsGGoKUBMeQ=;
	b=ZvsBVw15CdLOkuECwK4FZfeeJL2S20COYfNUOGcCvtUx5gkYos6MV477z2JoIsUf6YWR/H
	+S/m0SXjg3jbqcDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E7034AD72;
	Mon, 13 Apr 2026 07:17:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iMDYFXaY3GkWRQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 13 Apr 2026 07:17:10 +0000
Message-ID: <2fe8ce91-2dc5-4cf2-b7cf-d495e5cff14b@suse.de>
Date: Mon, 13 Apr 2026 09:17:09 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hv: Select CONFIG_SYSFB only for CONFIG_HYPERV_VMBUS
To: Saurabh Singh Sengar <ssengar@microsoft.com>,
 "javierm@redhat.com" <javierm@redhat.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "ardb@kernel.org" <ardb@kernel.org>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
 "kernel@xen0n.name" <kernel@xen0n.name>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
 Long Li <longli@microsoft.com>, "deller@gmx.de" <deller@gmx.de>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 Michael Kelley <mhklinux@outlook.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260402092305.208728-1-tzimmermann@suse.de>
 <20260402092305.208728-2-tzimmermann@suse.de>
 <KUZP153MB14449BBE44CBAEEA7621A4A0BE51A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
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
In-Reply-To: <KUZP153MB14449BBE44CBAEEA7621A4A0BE51A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.freedesktop.org,outlook.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microsoft.com,redhat.com,arndb.de,kernel.org,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,gmx.de];
	TAGGED_FROM(0.00)[bounces-10125-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:url,suse.de:dkim,suse.de:email,suse.de:mid,outlook.com:email]
X-Rspamd-Queue-Id: C734E3E8236
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

Am 02.04.26 um 12:50 schrieb Saurabh Singh Sengar:
>> Hyperv's sysfb access only exists in the VMBUS support. Therefore only select
>> CONFIG_SYSFB for CONFIG_HYPERV_VMBUS. Avoids sysfb code on systems
>> that don't need it.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Fixes: 96959283a58d ("Drivers: hv: Always select CONFIG_SYSFB for Hyper-V
>> guests")
>> Cc: Michael Kelley <mhklinux@outlook.com>
>> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Cc: Wei Liu <wei.liu@kernel.org>
>> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>> Cc: Haiyang Zhang <haiyangz@microsoft.com>
>> Cc: Dexuan Cui <decui@microsoft.com>
>> Cc: Long Li <longli@microsoft.com>
>> Cc: linux-hyperv@vger.kernel.org
>> Cc: <stable@vger.kernel.org> # v6.16+
>> ---
>>   drivers/hv/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig index
>> 7937ac0cbd0f..2d0b3fcb0ff8 100644
>> --- a/drivers/hv/Kconfig
>> +++ b/drivers/hv/Kconfig
>> @@ -9,7 +9,6 @@ config HYPERV
>>   	select PARAVIRT
>>   	select X86_HV_CALLBACK_VECTOR if X86
>>   	select OF_EARLY_FLATTREE if OF
>> -	select SYSFB if EFI && !HYPERV_VTL_MODE
>>   	select IRQ_MSI_LIB if X86
>>   	help
>>   	  Select this option to run Linux as a Hyper-V client operating @@ -62,6
>> +61,7 @@ config HYPERV_VMBUS
>>   	tristate "Microsoft Hyper-V VMBus driver"
>>   	depends on HYPERV
>>   	default HYPERV
>> +	select SYSFB if EFI && !HYPERV_VTL_MODE
>>   	help
>>   	  Select this option to enable Hyper-V Vmbus driver.
>>
>> --
>> 2.53.0
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

This fix is independent from the rest of the series. Do you want to 
merge it or can I take it into DRM trees?

Best regards
Thomas

>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



