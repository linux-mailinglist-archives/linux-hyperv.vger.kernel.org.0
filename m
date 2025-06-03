Return-Path: <linux-hyperv+bounces-5719-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFB0ACC026
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 08:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0961916D22B
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 06:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0041F25D21C;
	Tue,  3 Jun 2025 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RGfUUgAp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="syc0Mgqr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RGfUUgAp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="syc0Mgqr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9EC25D213
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Jun 2025 06:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748931935; cv=none; b=cYpF/ItuK6YkunEjrX1eMl0q09/NaSfD3FcuOp4ujQw89gqmnggP66hb+P5aDVsGO+kMT1D6IXuaBBDWbCzU/v/z2BsFEBs18Mi5XpQeIsHv/bCVcaArB4gbNw4d9Nq6P+xehnQjnTcpNy+ByD5OEb9Dt7ljWKIfP5zK4KzCYcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748931935; c=relaxed/simple;
	bh=tHEq19w5o7E/Yt7tms7pdglFkgf2KGqzNo9T06DgvAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvkPViCTLyJRZmDofTvuRoxPbM+rvBWUm9c0XUYEHd2Qhm5kHRWsX8/6wV9eRE2H0Fzc7BbxQqHNHReJJKYPKF2mYk0y/UECQs8skC0+1/yOG1/cu4+wFQjf6pF/W6H99Z9oqm9VEAkGvzz6ei4fsMhpwwfuxbcqZqeiUnWBJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RGfUUgAp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=syc0Mgqr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RGfUUgAp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=syc0Mgqr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B8B962126A;
	Tue,  3 Jun 2025 06:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748931925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DqlhqDH+e2vFicbuco4eCCmjcNtipVk/C0dg4d70Inc=;
	b=RGfUUgAp+m5lbTIpdHpByrBu0pni1JoL1uq6PSeKaibC23WxQx7J1p6TIYnj5Uw5/IVANn
	mFeNed/yV6OgNeeBtjwl7Tma0K5JD29HrnVXsL9XFrd24cyNOMTJ4FFKu0amuxCUO9xfW5
	IKpe+BBCTKaiQFWM3+9PjnyQiZMalcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748931925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DqlhqDH+e2vFicbuco4eCCmjcNtipVk/C0dg4d70Inc=;
	b=syc0Mgqr+wgCce7/H3q7Lx8OCxTExO6Z5nJO5Ge04dgb119/BGQANYLHrcRVdijEfTCKNq
	0hTZh+bkkKbVu3Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RGfUUgAp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=syc0Mgqr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748931925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DqlhqDH+e2vFicbuco4eCCmjcNtipVk/C0dg4d70Inc=;
	b=RGfUUgAp+m5lbTIpdHpByrBu0pni1JoL1uq6PSeKaibC23WxQx7J1p6TIYnj5Uw5/IVANn
	mFeNed/yV6OgNeeBtjwl7Tma0K5JD29HrnVXsL9XFrd24cyNOMTJ4FFKu0amuxCUO9xfW5
	IKpe+BBCTKaiQFWM3+9PjnyQiZMalcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748931925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DqlhqDH+e2vFicbuco4eCCmjcNtipVk/C0dg4d70Inc=;
	b=syc0Mgqr+wgCce7/H3q7Lx8OCxTExO6Z5nJO5Ge04dgb119/BGQANYLHrcRVdijEfTCKNq
	0hTZh+bkkKbVu3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B4B513A1D;
	Tue,  3 Jun 2025 06:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f/MgCFWVPmi1egAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 03 Jun 2025 06:25:25 +0000
Message-ID: <c0b91a50-d3e7-44f9-b9c5-9c3b29639428@suse.de>
Date: Tue, 3 Jun 2025 08:25:24 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] fbdev/deferred-io: Support contiguous kernel
 memory framebuffers
To: Michael Kelley <mhklinux@outlook.com>,
 David Hildenbrand <david@redhat.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "deller@gmx.de" <deller@gmx.de>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "weh@microsoft.com" <weh@microsoft.com>, "hch@lst.de" <hch@lst.de>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20250523161522.409504-1-mhklinux@outlook.com>
 <20250523161522.409504-4-mhklinux@outlook.com>
 <de0f2cb8-aed6-436f-b55e-d3f7b3fe6d81@redhat.com>
 <SN6PR02MB41573C075152ECD8428CAF5ED46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
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
In-Reply-To: <SN6PR02MB41573C075152ECD8428CAF5ED46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[outlook.com,redhat.com,ffwll.ch,gmx.de,microsoft.com,kernel.org,linux-foundation.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmx.de,outlook.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B8B962126A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

Hi

Am 03.06.25 um 03:49 schrieb Michael Kelley:
[...]
>> Will the VMA have VM_PFNMAP or VM_MIXEDMAP set? PFN_SPECIAL is a
>> horrible hack.
>>
>> In another thread, you mention that you use PFN_SPECIAL to bypass the
>> check in vm_mixed_ok(), so VM_MIXEDMAP is likely not set?
> The VMA has VM_PFNMAP set, not VM_MIXEDMAP.  It seemed like
> VM_MIXEDMAP is somewhat of a superset of VM_PFNMAP, but maybe that's
> a wrong impression. vm_mixed_ok() does a thorough job of validating the
> use of __vm_insert_mixed(), and since what I did was allowed, I thought
> perhaps it was OK. Your feedback has set me straight, and that's what I
> needed. :-)
>
> But the whole approach is moot with Alistair Popple's patch set that
> eliminates pfn_t. Is there an existing mm API that will do mkwrite on a
> special PTE in a VM_PFNMAP VMA? I didn't see one, but maybe I missed
> it. If there's not one, I'll take a crack at adding it in the next version of my
> patch set.

What is the motivation behind this work? The driver or fbdev as a whole 
does not have much of a future anyway.

I'd like to suggest removing hyperv_fb entirely in favor of hypervdrm?

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


