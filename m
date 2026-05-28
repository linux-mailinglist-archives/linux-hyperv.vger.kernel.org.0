Return-Path: <linux-hyperv+bounces-11302-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEAQKWXdF2oUTggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11302-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 08:15:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A69105ED2D2
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 08:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12B75301B1C3
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 06:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C6F2C15AC;
	Thu, 28 May 2026 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QsmuQI6l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gUwSe44R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QsmuQI6l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gUwSe44R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9123523BCF7
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 06:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948896; cv=none; b=fBGXWpDGruITGX58LoF5MA+OEHiTr1O4NVUk44IqGvRvkUT+tPS/ep0k9sGOT9zhLuCZYHFTnHR8fXqEZ3vMv2zXuQhxv/mvGTK7CDN3z3vmXvMo82iv/lL4mr9B3hT2jsX6djxIDrsca+m7z8THYE1T78YrSN4rRzGLcIh+CjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948896; c=relaxed/simple;
	bh=2bK7PT7izEcocejQvHw3OSKE2A3Pc69JwsyCors9BFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSUEVvKsDCYLrMMLQlDhgpVvJcPuq6NyF/n+W0Q44htbiKUCpMrAbrtSdsbGnW9iJEJEz8/GvjP1I3iHgEMgQRM0wBmzHJatcDVPo+nhKaTmQ161jihrLuwutrsWIBBFkVvbrmkMF3RtQ72XW1n5pkNEEmY7WKGOY9Uejc6Sx58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QsmuQI6l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gUwSe44R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QsmuQI6l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gUwSe44R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA575672C6;
	Thu, 28 May 2026 06:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779948892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rD2q/7ZAH16ADF4bRqwBKk/NpKcW9E1DBI7Xrh/6WoI=;
	b=QsmuQI6lL/BNCGmSn/PILJxD9ELGyrjaeJMoc1oM5zfyl8Eqnp8oZsAD3pC8zXZR5yp9CW
	HbhyoFvzK6CLxs6G9/n8eXaVxjPf4HICP8vUnVAThunlDrNVQ3DMxeVL4mYbj84B/mqgQy
	s3+IpuoeUcVYpcbh6m9HDZjcbtF31xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779948892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rD2q/7ZAH16ADF4bRqwBKk/NpKcW9E1DBI7Xrh/6WoI=;
	b=gUwSe44RLMXgO7KuEFbhWBIs3yv/9nnZAOLtVLsNyHjz+MNcGQAh0dmG2fPjs6VnkZjvtw
	o7XMUlelg81OMkDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QsmuQI6l;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gUwSe44R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779948892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rD2q/7ZAH16ADF4bRqwBKk/NpKcW9E1DBI7Xrh/6WoI=;
	b=QsmuQI6lL/BNCGmSn/PILJxD9ELGyrjaeJMoc1oM5zfyl8Eqnp8oZsAD3pC8zXZR5yp9CW
	HbhyoFvzK6CLxs6G9/n8eXaVxjPf4HICP8vUnVAThunlDrNVQ3DMxeVL4mYbj84B/mqgQy
	s3+IpuoeUcVYpcbh6m9HDZjcbtF31xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779948892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rD2q/7ZAH16ADF4bRqwBKk/NpKcW9E1DBI7Xrh/6WoI=;
	b=gUwSe44RLMXgO7KuEFbhWBIs3yv/9nnZAOLtVLsNyHjz+MNcGQAh0dmG2fPjs6VnkZjvtw
	o7XMUlelg81OMkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2EFC5AC36;
	Thu, 28 May 2026 06:14:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Fo5SJlzdF2q9AwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 28 May 2026 06:14:52 +0000
Message-ID: <195283d4-bec0-4f8a-aa8a-a0a0aa7d4a86@suse.de>
Date: Thu, 28 May 2026 08:14:52 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] drm/damage-helper: Do not alter damage clips on
 modeset, but ignore them
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
References: <20260527145113.241595-2-tzimmermann@suse.de>
 <20260527151944.F29571F000E9@smtp.kernel.org>
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
In-Reply-To: <20260527151944.F29571F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11302-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.de:mid,suse.de:dkim,suse.com:url]
X-Rspamd-Queue-Id: A69105ED2D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Am 27.05.26 um 17:19 schrieb sashiko-bot@kernel.org:
[...]
> [Severity: High]
> By no longer setting plane_state->fb_damage_clips to NULL during a modeset,
> will this break drivers that bypass the damage iterator?

No drivers bypass the damage iterator. Doing so would be an error.

>
> Drivers like AMDGPU (in fill_dc_dirty_rects) and vmwgfx directly call
> drm_plane_get_damage_clips_count() and drm_plane_get_damage_clips().
> Because these accessor functions do not check the new ignore_damage_clips flag,
> won't they see a non-zero clip count if userspace provided one?
>
> If they see a non-zero clip count during a modeset, will they incorrectly
> skip their fallback paths and perform a partial update instead of the
> required full framebuffer update?
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



