Return-Path: <linux-hyperv+bounces-4638-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE5FA6A0AE
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 08:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822C416A601
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 07:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942091EF38D;
	Thu, 20 Mar 2025 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PqlDziOh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v1Tp57FW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PqlDziOh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v1Tp57FW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F651DE2CD
	for <linux-hyperv@vger.kernel.org>; Thu, 20 Mar 2025 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456729; cv=none; b=eCIJ/f6x4ZXIcsXieLckxKBvNQecRAw8Mih0eI8z/e7hveBNSvNimGPDPDo+5jrXZEQ8hE+WgJWzk2Pz03Ryr0Un2b/B7gKYKk17ETWDz1nWsEzhPTPMa9clFxf5Twe1ZctAE2FtUPsZWK1TVqKePx057RicYuZgviz9ZxVJy2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456729; c=relaxed/simple;
	bh=0e6NEfG/qpxKMn42AQkTAVlrM9MZlAIVbusb360JCWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWRS6I0IaTJmtGJraOOUFTYmNygBt/OeRxLjbnULWfhjZb4LlZ0jFl6JQmAHN5CfKB76GaBrwqR8Mh5YwNQ37Hg8fdgJ0VqYUrFEXKjTQdtfls+AKFkbjYMhVDWdBqaboYVTm9w4wi+WXVRXRu3Sp7ZzjcKa7Cleotv2Gno314o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PqlDziOh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v1Tp57FW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PqlDziOh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v1Tp57FW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8456C22017;
	Thu, 20 Mar 2025 07:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742456725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gA2/H1BeCo6ljHC6Z1zZsBCsoR53L6XI0RJHQvvt4hA=;
	b=PqlDziOh1FVdzLQJx0UGbSNQlba7R9S3X7sxYRrN7SrswkoYX6e1DR3MdVQoBp2v8kBNyS
	EblEK7Zotueg7SFwQP5HKMI/zjwGQmfEERF9wjUAYkYs5GttlPo4mK9clD3JwxNSIwOPqC
	IjVIeEF2+RHtiqZcSRezNRkOqEbd2C4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742456725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gA2/H1BeCo6ljHC6Z1zZsBCsoR53L6XI0RJHQvvt4hA=;
	b=v1Tp57FW+X+8pMM3yfCFBPQgIcWXoewHmKk84pb0/EcqJj7cON2QWntpbp8EKIWhTMqoWm
	0ShvfqN1XovrrzAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PqlDziOh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v1Tp57FW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742456725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gA2/H1BeCo6ljHC6Z1zZsBCsoR53L6XI0RJHQvvt4hA=;
	b=PqlDziOh1FVdzLQJx0UGbSNQlba7R9S3X7sxYRrN7SrswkoYX6e1DR3MdVQoBp2v8kBNyS
	EblEK7Zotueg7SFwQP5HKMI/zjwGQmfEERF9wjUAYkYs5GttlPo4mK9clD3JwxNSIwOPqC
	IjVIeEF2+RHtiqZcSRezNRkOqEbd2C4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742456725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gA2/H1BeCo6ljHC6Z1zZsBCsoR53L6XI0RJHQvvt4hA=;
	b=v1Tp57FW+X+8pMM3yfCFBPQgIcWXoewHmKk84pb0/EcqJj7cON2QWntpbp8EKIWhTMqoWm
	0ShvfqN1XovrrzAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6288913757;
	Thu, 20 Mar 2025 07:45:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x0KZFpXH22cOVAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 20 Mar 2025 07:45:25 +0000
Message-ID: <a815031b-262d-4f74-b23a-1f9e59aa4c80@suse.de>
Date: Thu, 20 Mar 2025 08:45:25 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fbdev deferred I/O broken in some scenarios
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <SN6PR02MB4157227300E59ACB3B0DABD0D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <a4fa1dbb-4989-4fc2-acbc-055f786e9b48@suse.de>
 <BN7PR02MB4148864DDB065271B79FD3E4D4D92@BN7PR02MB4148.namprd02.prod.outlook.com>
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
In-Reply-To: <BN7PR02MB4148864DDB065271B79FD3E4D4D92@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8456C22017
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[outlook.com,vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hi

Am 19.03.25 um 21:38 schrieb Michael Kelley:
> From: Thomas Zimmermann <tzimmermann@suse.de> Sent: Tuesday, March 18, 2025 1:26 AM
>> Am 18.03.25 um 03:05 schrieb Michael Kelley:
>>> I've been trying to get mmap() working with the hyperv_fb.c fbdev driver, which
>>> is for Linux guests running on Microsoft's Hyper-V hypervisor. The hyperv_fb driver
>>> uses fbdev deferred I/O for performance reasons. But it looks to me like fbdev
>>> deferred I/O is fundamentally broken when the underlying framebuffer memory
>>> is allocated from kernel memory (alloc_pages or dma_alloc_coherent).
>>>
>>> The hyperv_fb.c driver may allocate the framebuffer memory in several ways,
>>> depending on the size of the framebuffer specified by the Hyper-V host and the VM
>>> "Generation".  For a Generation 2 VM, the framebuffer memory is allocated by the
>>> Hyper-V host and is assigned to guest MMIO space. The hyperv_fb driver does a
>>> vmalloc() allocation for deferred I/O to work against. This combination handles mmap()
>>> of /dev/fb<n> correctly and the performance benefits of deferred I/O are substantial.
>>>
>>> But for a Generation 1 VM, the hyperv_fb driver allocates the framebuffer memory in
>>> contiguous guest physical memory using alloc_pages() or dma_alloc_coherent(), and
>>> informs the Hyper-V host of the location. In this case, mmap() with deferred I/O does
>>> not work. The mmap() succeeds, and user space updates to the mmap'ed memory are
>>> correctly reflected to the framebuffer. But when the user space program does munmap()
>>> or terminates, the Linux kernel free lists become scrambled and the kernel eventually
>>> panics. The problem is that when munmap() is done, the PTEs in the VMA are cleaned
>>> up, and the corresponding struct page refcounts are decremented. If the refcount goes
>>> to zero (which it typically will), the page is immediately freed. In this way, some or all
>>> of the framebuffer memory gets erroneously freed. From what I see, the VMA should
>>> be marked VM_PFNMAP when allocated memory kernel is being used as the
>>> framebuffer with deferred I/O, but that's not happening. The handling of deferred I/O
>>> page faults would also need updating to make this work.
>> I cannot help much with HyperV, but there's a get_page callback in
>> struct fb_deferred_io. [1] It'll allow you to provide a custom page on
>> each page fault. We use it in DRM to mmap SHMEM-backed pages. [2] Maybe
>> this helps with hyperv_fb as well.
>>
> Thanks for your input. See also my reply to Helge.
>
> Unfortunately, using a custom get_page() callback doesn't help. In the problematic
> case, the standard deferred I/O get_page() function works correctly for getting the
> struct page.  My current thinking is that the problem is in fb_deferred_io_mmap()
> where the vma needs to have the VM_PFNMAP flag set when the framebuffer
> memory is a direct kernel allocation and not through vmalloc(). And there may be
> some implications on the mkwrite function as well, but I'll need to sort that out
> once I start coding.
>
> For the DRM code using SHMEM-backed pages, do you know where the shared
> memory comes from? Is that ultimately a kernel vmalloc() allocation?

I think it's something special, as the regular vmalloc'ed-pages would be 
handled by fb_defio automatically. In DRM we sometimes also use a 
separate vmalloc'ed shadow buffer that serves as the fbdev framebuffer. 
We then sync internally with the physical framebuffer memory. See [1] 
for the related code. Udlfb does the as well IIRC.

Best regards
Thomas

[1] 
https://elixir.bootlin.com/linux/v6.13.7/source/drivers/gpu/drm/drm_fbdev_ttm.c#L201

>
> Michael
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


