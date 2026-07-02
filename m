Return-Path: <linux-hyperv+bounces-11801-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bx7eCwMJRmpzIAsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11801-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 08:45:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AEC6F3E18
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 08:45:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="h/Xr9hcW";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FzNHR3f2;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WVCFPNKN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aic2NIuu;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11801-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11801-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B54E302D0A5
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 06:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161A53655D4;
	Thu,  2 Jul 2026 06:45:20 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F56B30E0E5
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Jul 2026 06:45:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974720; cv=none; b=YO7G4vfIRLBTqtesXLXM+AJpy/pxfbBWyPmaQUlvEgYW9PriyUlNgb/qRhX5VG8gjVmnVlB6C8G2Jzs/5QiWIxXHcJl+G9Dn6lgbsqFUyl1Yid09RGD2x3i2YU9nRJ4P9HwcwiCu07bQCWd5MgXE6m4kBTEU0d6wO8zMQ8ERGcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974720; c=relaxed/simple;
	bh=PcHlQBMC4Onf35OKFfdZDdQYlp3nn0NSWpkTEMHdC6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0ewJfBixY8I+ZwiQVstYDE/B2F/cZ8+yWapsdey8oTDi+5kvmnO5j5kf9oofgUlqeh9WpQ/LBniCv18eU0Q14NBUrN06NV+sQKgyB203gSvIhAAPnCWRrVFU/DUptoOFrSCCcIbGhPsZ/vu/7bXNgPNB3LQjORdlraX3ThVDU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h/Xr9hcW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FzNHR3f2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WVCFPNKN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aic2NIuu; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6DE4475AF9;
	Thu,  2 Jul 2026 06:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782974716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Mfu2k4FXErdZDQ9bdFmvwlGMeeFPsZf5v5nHeEcXfow=;
	b=h/Xr9hcWYjp5MFf8UGEmmghsrxS0sG9bHRvmWqj+D9q6V4LV+g8ugRbgzycX71b1XsjoMh
	mBS+rPWDEmLcjwgkuASxQ2QpiSjC9AgVoZoRBZP1nLZxwFK+tAB5LA6gJRRT901s0rF9Gn
	NVsvxZOgBKDzvrj33FsekCCfhLBQJsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782974716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Mfu2k4FXErdZDQ9bdFmvwlGMeeFPsZf5v5nHeEcXfow=;
	b=FzNHR3f2TIzbZj0xUxLowjLchxe4bDjfkgNlaxOIR7s/zkLibzw4ekmDqZybfaYN9HmPj9
	yAlJDrnW+bGsymCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782974715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Mfu2k4FXErdZDQ9bdFmvwlGMeeFPsZf5v5nHeEcXfow=;
	b=WVCFPNKN7g2yge0Yg6OWgiKUtFDv82q+I9LfPCJaOKCBigDneS7OyzgcBvtbZWceNWQvl8
	unlf+/qZpeVUrtfhi6zybXBdUF3MFkFA6psaX0+NX/3F3bu8gXvSxUl7boAIIT55pgEMPg
	NntwOlBqLNapa1sqHDVvC4XyBLbxyOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782974715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Mfu2k4FXErdZDQ9bdFmvwlGMeeFPsZf5v5nHeEcXfow=;
	b=aic2NIuun8yQkk8/bSmqDxTwA98tbblp/ZUfzyVNKJvjrZPUoQMs8mZ0RsUlYZmOLSWcjY
	i39i97KrpkNoDHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26709779AA;
	Thu,  2 Jul 2026 06:45:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NoU+CPsIRmpuVQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 02 Jul 2026 06:45:15 +0000
Message-ID: <56983c6a-6459-4145-bf6a-909d2f3ee9a4@suse.de>
Date: Thu, 2 Jul 2026 08:45:14 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] drm/hyperv: Drop useless empty remove callback
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
 <8a85b5f4a5ed8ec35b5a213423d4be40e34f9cb9.1782925276.git.u.kleine-koenig@baylibre.com>
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
In-Reply-To: <8a85b5f4a5ed8ec35b5a213423d4be40e34f9cb9.1782925276.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11801-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:decui@microsoft.com,m:longli@microsoft.com,m:ssengar@linux.microsoft.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:linux-hyperv@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,microsoft.com,linux.microsoft.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:from_mime,suse.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,baylibre.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90AEC6F3E18

Hi

Am 01.07.26 um 19:05 schrieb Uwe Kleine-König (The Capable Hub):
> Having an empty remove callback is equivalent to no remove callback.
> (The only minor difference is that with an empty remove callback
> pm_runtime_get_sync() and pm_runtime_put_noidle() are called.)
>
> Drop this useless function.
>
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
>   drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index e766d87b7a9d..e3f41336a831 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -45,10 +45,6 @@ static int hv_drm_pci_probe(struct pci_dev *pdev,
>   	return 0;
>   }
>   
> -static void hv_drm_pci_remove(struct pci_dev *pdev)
> -{

It would be better to call drm_dev_unplug() from here.  With a bit more 
work, the driver can have hot-unplug functionality.

Best regards
Thomas

> -}
> -
>   static const struct pci_device_id hv_drm_pci_tbl[] = {
>   	{
>   		PCI_VDEVICE_SUB(MICROSOFT, PCI_DEVICE_ID_HYPERV_VIDEO,
> @@ -64,7 +60,6 @@ static struct pci_driver hv_drm_pci_driver = {
>   	.name =		KBUILD_MODNAME,
>   	.id_table =	hv_drm_pci_tbl,
>   	.probe =	hv_drm_pci_probe,
> -	.remove =	hv_drm_pci_remove,
>   };
>   
>   static int hv_drm_setup_vram(struct hv_drm_device *hv,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



