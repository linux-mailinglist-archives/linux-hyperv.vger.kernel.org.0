Return-Path: <linux-hyperv+bounces-7023-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFFDBAD7AC
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Sep 2025 17:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABECA324C20
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Sep 2025 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198671EE02F;
	Tue, 30 Sep 2025 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a4bdjFPD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9N9f1OOK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a4bdjFPD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9N9f1OOK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2782E1F152D
	for <linux-hyperv@vger.kernel.org>; Tue, 30 Sep 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244619; cv=none; b=rSEIXfUEe0pXq6tu6Xkb6jRyKPkVuh/CW0OT2qicM7BCEfMR4QU4w6QkJZrCdV90JngYLBjma1gu2osMKXmHzUWBeY8v/E9g/gijAP+tNlJVbADPk24+At7xk7v+pVV8xcxUysnKxTpsRo+um/LcTmYjB44xkA2AIL/VM0uXlXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244619; c=relaxed/simple;
	bh=3judcfPsvF//8egVwFX9HkW56dLg23Gi284n2gw7S+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqg0LMOmduwGuNAzEyPpWtdUaFedaYR2aGH6Cpj7JH9bUV/N2H1TLi4UjOKZWPdHo2BKGKkwa1K8sO5/z0nVGJhsfGevo2+T+OPBBiF0nMlgjvxezIdNZi6IjkokBNyR8omBKhyFv2aU7IuVThwOFs16BHwHzsIxUrfHAAfDcg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a4bdjFPD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9N9f1OOK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a4bdjFPD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9N9f1OOK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FFC133694;
	Tue, 30 Sep 2025 15:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759244613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DbCieBTZ9CBAujUJtF69jxkLH7Z56BlmIqOGkEo/h+A=;
	b=a4bdjFPDOnsPnFI8j0uIzoj/1DjFRWOGuZFn5Gqy0sWa+rHSYDvNJN970IugbtoNhrH3uw
	Xepc03xEbhyTeNKLFwpaWnQyv8k3LVNaJsI/CehD8n9RELaL2suOYI96hxis2IuPR9xto9
	PPm1ZUFKBRGE85Tt8b1eaFpHAlMR4VA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759244613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DbCieBTZ9CBAujUJtF69jxkLH7Z56BlmIqOGkEo/h+A=;
	b=9N9f1OOK1q72KwDMDK83gsxj7zOViWKoooTDkcTlWlcpxra66pfNw+knzEcZ4OKvsRHiDR
	TsJNAYkWVejBDfCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=a4bdjFPD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9N9f1OOK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759244613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DbCieBTZ9CBAujUJtF69jxkLH7Z56BlmIqOGkEo/h+A=;
	b=a4bdjFPDOnsPnFI8j0uIzoj/1DjFRWOGuZFn5Gqy0sWa+rHSYDvNJN970IugbtoNhrH3uw
	Xepc03xEbhyTeNKLFwpaWnQyv8k3LVNaJsI/CehD8n9RELaL2suOYI96hxis2IuPR9xto9
	PPm1ZUFKBRGE85Tt8b1eaFpHAlMR4VA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759244613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DbCieBTZ9CBAujUJtF69jxkLH7Z56BlmIqOGkEo/h+A=;
	b=9N9f1OOK1q72KwDMDK83gsxj7zOViWKoooTDkcTlWlcpxra66pfNw+knzEcZ4OKvsRHiDR
	TsJNAYkWVejBDfCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E643213A3F;
	Tue, 30 Sep 2025 15:03:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZPjDNkTx22hwYwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 30 Sep 2025 15:03:32 +0000
Message-ID: <b2a15b41-7f20-46ac-9f62-d5e48c597760@suse.de>
Date: Tue, 30 Sep 2025 17:03:32 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] drm: Add vblank timers for devices without
 interrupts
To: Michael Kelley <mhklinux@outlook.com>,
 "louis.chauvet@bootlin.com" <louis.chauvet@bootlin.com>,
 "drawat.floss@gmail.com" <drawat.floss@gmail.com>,
 "hamohammed.sa@gmail.com" <hamohammed.sa@gmail.com>,
 "melissa.srw@gmail.com" <melissa.srw@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "airlied@gmail.com"
 <airlied@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
 "lyude@redhat.com" <lyude@redhat.com>,
 "javierm@redhat.com" <javierm@redhat.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20250904145806.430568-1-tzimmermann@suse.de>
 <SN6PR02MB4157E793515BE2B63615AD92D403A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <BN7PR02MB4148E80C13605F6EAD2B0A03D40FA@BN7PR02MB4148.namprd02.prod.outlook.com>
 <c6ef1912-84b8-4f01-85cc-2fb18f1ad1ed@suse.de>
 <SN6PR02MB41575149CA466B89283B920DD414A@SN6PR02MB4157.namprd02.prod.outlook.com>
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
In-Reply-To: <SN6PR02MB41575149CA466B89283B920DD414A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4FFC133694
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,bootlin.com,gmail.com,ffwll.ch,linux.intel.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Spam-Score: -3.01

Hi

Am 16.09.25 um 17:00 schrieb Michael Kelley:
> From: Thomas Zimmermann <tzimmermann@suse.de> Sent: Tuesday, September 16, 2025 1:31 AM
>> Hi
>>
>> Am 09.09.25 um 05:29 schrieb Michael Kelley:
>>> From: Michael Kelley Sent: Thursday, September 4, 2025 10:36 PM
>>>> From: Thomas Zimmermann <tzimmermann@suse.de> Sent: Thursday, September 4, 2025 7:56 AM
>>>>> Compositors often depend on vblanks to limit their display-update
>>>>> rate. Without, they see vblank events ASAP, which breaks the rate-
>>>>> limit feature. This creates high CPU overhead. It is especially a
>>>>> problem with virtual devices with fast framebuffer access.
>>>>>
>>>>> The series moves vkms' vblank timer to DRM and converts the hyperv
>>>>> DRM driver. An earlier version of this series contains examples of
>>>>> other updated drivers. In principle, any DRM driver without vblank
>>>>> hardware can use the timer.
>>>> I've tested this patch set in a Hyper-V guest against the linux-next20250829
>>>> kernel. All looks good. Results and perf are the same as reported here [4].
>>>> So far I haven't seen the "vblank timer overrun" error, which is consistent
>>>> with the changes you made since my earlier testing. I'll keep running this
>>>> test kernel for a while to see if anything anomalous occurs.
>>> As I continued to run with this patch set, I got a single occurrence of this
>>> WARN_ON. I can't associate it with any particular action as I didn't notice
>>> it until well after it occurred.
>> I've investigated. The stack trace comes from the kernel console's
>> display update. It runs concurrently to the vblank timeout. What likely
>> happens here is that the update code reads two values and in between,
>> the vblank timeout updates them. So the update then compares an old and
>> a new value; leading to an incorrect result with triggers the warning.
>>
>> I'll include a fix in the series' next iteration. But I also think that
>> it's not critical. DRM's vblank helpers can usually deal with such problems.
> Thanks! I'm giving your v4 series a try now. Good that the underlying
> problem is not critical. But I was seeing the WARN_ON() output in
> dmesg every few days (a total of 4 times now), and that's not really
> acceptable even if everything continues to work correctly.

So it's probably a good sign that I haven't heard from you recently. :) 
If you haven't seen any warnings with v4, I'd like to merge the series soon.

Best regards
Thomas

>
> Michael

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



