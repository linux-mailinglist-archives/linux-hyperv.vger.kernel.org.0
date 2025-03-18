Return-Path: <linux-hyperv+bounces-4571-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC84DA66E19
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 09:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19021897698
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 08:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509EF1EF362;
	Tue, 18 Mar 2025 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qivy7a8H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rMWUotlF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qivy7a8H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rMWUotlF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88D1E5214
	for <linux-hyperv@vger.kernel.org>; Tue, 18 Mar 2025 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286348; cv=none; b=SJlYmXJB/7R66E07htAuvjMcBJMlDt4erXDlhZFXcZ7GeLi/nuhhRdfUo3j/u6WO+eD0V7Vxs0YI93TJE/efE3fSMNdOAEVsc/i4Wh+bl/TDTMty3LU+vy6zN2noAZZILvW3oOIeRT0keSIigNfAo9jlIyyeTIU2Bni5B24u2u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286348; c=relaxed/simple;
	bh=9IJrmloCtBiE4195UcDZyW1bVeNSoSPL/mBOc2DZpS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYDvKmQWflAhQjXk6DN2R649VBcGM1wOvzWlx9P2Gz4NjCKUQ3JVGOZr6McpCj+rze+bs28uMpMr+MimfzmZtNdLzmRFv8LjGHpC0JsmgcV99fpCn3b1yck1y7voMIUo+/36U038Fi24IsWnJdmP2BfE9OecDJBgI0ZEu1FpIPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qivy7a8H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rMWUotlF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qivy7a8H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rMWUotlF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 808FE2211A;
	Tue, 18 Mar 2025 08:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742286344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aFIRLv9ZFPcf34t7s2kaSQm5KSWWtqzzFUWGOObMEaM=;
	b=qivy7a8Ha8xTEjghR6RsgguWM8RRScp0GbzVLxkDi7rj7pyVTIuaBnQduPIbfA2CfrfvI/
	VxxsMGyOo80ai1Bv6m3Z3bYnsI/3IyB0i8Cnd6fkj3nNtGw4Pn1eYsAM7VXgSjJypsJ+/i
	cKWNWnh7j+713iKieNWCCnUmOGfnW7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742286344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aFIRLv9ZFPcf34t7s2kaSQm5KSWWtqzzFUWGOObMEaM=;
	b=rMWUotlFOlHAxGuLosQoMsJl2l7YpEpEA6COkJiRQaXhpDiq1D0HvVFoJTH5Tpg2Ab5kSF
	7qtf8ZP5neopBKBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742286344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aFIRLv9ZFPcf34t7s2kaSQm5KSWWtqzzFUWGOObMEaM=;
	b=qivy7a8Ha8xTEjghR6RsgguWM8RRScp0GbzVLxkDi7rj7pyVTIuaBnQduPIbfA2CfrfvI/
	VxxsMGyOo80ai1Bv6m3Z3bYnsI/3IyB0i8Cnd6fkj3nNtGw4Pn1eYsAM7VXgSjJypsJ+/i
	cKWNWnh7j+713iKieNWCCnUmOGfnW7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742286344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aFIRLv9ZFPcf34t7s2kaSQm5KSWWtqzzFUWGOObMEaM=;
	b=rMWUotlFOlHAxGuLosQoMsJl2l7YpEpEA6COkJiRQaXhpDiq1D0HvVFoJTH5Tpg2Ab5kSF
	7qtf8ZP5neopBKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 599311379A;
	Tue, 18 Mar 2025 08:25:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OBcKFAgu2WegDQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 18 Mar 2025 08:25:44 +0000
Message-ID: <a4fa1dbb-4989-4fc2-acbc-055f786e9b48@suse.de>
Date: Tue, 18 Mar 2025 09:25:43 +0100
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
In-Reply-To: <SN6PR02MB4157227300E59ACB3B0DABD0D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,vger.kernel.org];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

Hi

Am 18.03.25 um 03:05 schrieb Michael Kelley:
> I've been trying to get mmap() working with the hyperv_fb.c fbdev driver, which
> is for Linux guests running on Microsoft's Hyper-V hypervisor. The hyperv_fb driver
> uses fbdev deferred I/O for performance reasons. But it looks to me like fbdev
> deferred I/O is fundamentally broken when the underlying framebuffer memory
> is allocated from kernel memory (alloc_pages or dma_alloc_coherent).
>
> The hyperv_fb.c driver may allocate the framebuffer memory in several ways,
> depending on the size of the framebuffer specified by the Hyper-V host and the VM
> "Generation".  For a Generation 2 VM, the framebuffer memory is allocated by the
> Hyper-V host and is assigned to guest MMIO space. The hyperv_fb driver does a
> vmalloc() allocation for deferred I/O to work against. This combination handles mmap()
> of /dev/fb<n> correctly and the performance benefits of deferred I/O are substantial.
>
> But for a Generation 1 VM, the hyperv_fb driver allocates the framebuffer memory in
> contiguous guest physical memory using alloc_pages() or dma_alloc_coherent(), and
> informs the Hyper-V host of the location. In this case, mmap() with deferred I/O does
> not work. The mmap() succeeds, and user space updates to the mmap'ed memory are
> correctly reflected to the framebuffer. But when the user space program does munmap()
> or terminates, the Linux kernel free lists become scrambled and the kernel eventually
> panics. The problem is that when munmap() is done, the PTEs in the VMA are cleaned
> up, and the corresponding struct page refcounts are decremented. If the refcount goes
> to zero (which it typically will), the page is immediately freed. In this way, some or all
> of the framebuffer memory gets erroneously freed. From what I see, the VMA should
> be marked VM_PFNMAP when allocated memory kernel is being used as the
> framebuffer with deferred I/O, but that's not happening. The handling of deferred I/O
> page faults would also need updating to make this work.

I cannot help much with HyperV, but there's a get_page callback in 
struct fb_deferred_io. [1] It'll allow you to provide a custom page on 
each page fault. We use it in DRM to mmap SHMEM-backed pages. [2] Maybe 
this helps with hyperv_fb as well.

Best regards
Thomas

[1] https://elixir.bootlin.com/linux/v6.13.7/source/include/linux/fb.h#L229
[2] 
https://elixir.bootlin.com/linux/v6.13.7/source/drivers/gpu/drm/drm_fbdev_shmem.c#L82

>
> The fbdev deferred I/O support was originally added to the hyperv_fb driver in the
> 5.6 kernel, and based on my recent experiments, it has never worked correctly when
> the framebuffer is allocated from kernel memory. fbdev deferred I/O support for using
> kernel memory as the framebuffer was originally added in commit 37b4837959cb9
> back in 2008 in Linux 2.6.29. But I don't see how it ever worked properly, unless
> changes in generic memory management somehow broke it in the intervening years.
>
> I think I know how to fix all this. But before working on a patch, I wanted to check
> with the fbdev community to see if this might be a known issue and whether there
> is any additional insight someone might offer. Thanks for any comments or help.
>
> Michael Kelley
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


