Return-Path: <linux-hyperv+bounces-1351-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF5F817079
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Dec 2023 14:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2ACCB23C82
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Dec 2023 13:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68C8129EDC;
	Mon, 18 Dec 2023 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oBtY1kaK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QnGhIuXf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oBtY1kaK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QnGhIuXf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA2C129ECB;
	Mon, 18 Dec 2023 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CE1721114;
	Mon, 18 Dec 2023 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702905946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ty1ebFHrGCFAEU0DJdlP8arzaofS7C9pk9rcJiKwC5E=;
	b=oBtY1kaKD5OfVRRAcZTFvmfa463s1zrIX/UpxglLNnZIrOR6Ixq0gUhnbYahN0aIF9/5WL
	8VoitEucmQDD7p05+qRVXnM2KE0AHHZwoiTvk2eW0qdPb77n5rO2I+RthPWjAlzTQ7aM/K
	APui2wIQJwUiGviDrv/hvopQgpMzGH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702905946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ty1ebFHrGCFAEU0DJdlP8arzaofS7C9pk9rcJiKwC5E=;
	b=QnGhIuXf362lcKiDg7FYiAAYTCcfdE5LNTC2oQRqbAECwcfvMge4TdykuYcJNuxIVagqqW
	X34onLdVVYczhpDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702905946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ty1ebFHrGCFAEU0DJdlP8arzaofS7C9pk9rcJiKwC5E=;
	b=oBtY1kaKD5OfVRRAcZTFvmfa463s1zrIX/UpxglLNnZIrOR6Ixq0gUhnbYahN0aIF9/5WL
	8VoitEucmQDD7p05+qRVXnM2KE0AHHZwoiTvk2eW0qdPb77n5rO2I+RthPWjAlzTQ7aM/K
	APui2wIQJwUiGviDrv/hvopQgpMzGH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702905946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ty1ebFHrGCFAEU0DJdlP8arzaofS7C9pk9rcJiKwC5E=;
	b=QnGhIuXf362lcKiDg7FYiAAYTCcfdE5LNTC2oQRqbAECwcfvMge4TdykuYcJNuxIVagqqW
	X34onLdVVYczhpDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 023B313BC8;
	Mon, 18 Dec 2023 13:25:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 7h/YN1hIgGWNWwAAn2gu4w
	(envelope-from <dkirjanov@suse.de>); Mon, 18 Dec 2023 13:25:44 +0000
Message-ID: <1cea5a82-0868-44bb-950c-5d5b6e124e39@suse.de>
Date: Mon, 18 Dec 2023 16:25:44 +0300
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mana: select PAGE_POOL
Content-Language: en-US
To: Yury Norov <yury.norov@gmail.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231215203353.635379-1-yury.norov@gmail.com>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20231215203353.635379-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: *
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.87 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 R_RATELIMIT(0.00)[to_ip_from(RLamt7mne8fattfpn1k385npzo)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[gmail.com,microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-2.07)[95.46%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oBtY1kaK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QnGhIuXf
X-Spam-Score: -0.87
X-Rspamd-Queue-Id: 0CE1721114



On 12/15/23 23:33, Yury Norov wrote:
> Mana uses PAGE_POOL API. x86_64 defconfig doesn't select it:
> 
> ld: vmlinux.o: in function `mana_create_page_pool.isra.0':
> mana_en.c:(.text+0x9ae36f): undefined reference to `page_pool_create'
> ld: vmlinux.o: in function `mana_get_rxfrag':
> mana_en.c:(.text+0x9afed1): undefined reference to `page_pool_alloc_pages'
> make[3]: *** [/home/yury/work/linux/scripts/Makefile.vmlinux:37: vmlinux] Error 1
> make[2]: *** [/home/yury/work/linux/Makefile:1154: vmlinux] Error 2
> make[1]: *** [/home/yury/work/linux/Makefile:234: __sub-make] Error 2
> make[1]: Leaving directory '/home/yury/work/build-linux-x86_64'
> make: *** [Makefile:234: __sub-make] Error 2
> 
> So we need to select it explicitly.
> 
Fixes: ca9c54d2 ("net: mana: Add a driver for Microsoft Azure Network Adapter")
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

