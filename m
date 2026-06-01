Return-Path: <linux-hyperv+bounces-11424-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAqBId9hHWojZwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11424-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:41:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B2161DB7C
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F88B30BB28B
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 10:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E13F399889;
	Mon,  1 Jun 2026 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHA1kqDv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="slX06cMp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202AB399358
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Jun 2026 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309352; cv=none; b=jQRSonYYI8W4AGEmn50u+FdK/h+Y7FNx3ocsiZwENhzKUfYUKsocj+P9z1pWtJVkAyNIBbek2YhWG3tEUrU1yA+lDYBkxbYyH3PwKAAD1nl3Cq+wYBsqqCHAIhbsL8edSBerGyXhp29x+GxxdzAZdnqX/N4uAdw51lnBwccI830=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309352; c=relaxed/simple;
	bh=NRFqPa3kJwcSLBJ2wEeOqlBygR75BmmbNgByz+aBuPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DTbnuiT0/jXSonLpIx1sdoZb1ug217c8BxxFcCU/pkUqfQunLSMw0Y3eULbmeq4GPprmJ0IAtJXlDwYHlDqKviGGpNNJdsN2Ing3CjbV1NP7Yt6eD8mk02ytkFKl3n8eHxO1ZSRTEkoWilIaLUtd4QAsr4peC3ZN1tpsyNX4VcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHA1kqDv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=slX06cMp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYSWdrjn4aqQxQd0Cf2jKHSTVgv+zTIrZalUlPmgVOc=;
	b=JHA1kqDvAphyub391mJ3rxaYpdSzwIn+04KfRcyzlWz5wXXW6pSNMJ4vj83E3uTatCvXA2
	Ww05f0Jbw3q0ZPoYox1Ts3E90NKI0VoEdpeNTaEHhXFLcZ0ECYI2hzlBn6cMT1HdmwDI/x
	qt38PHDCTYIy+83yiiimchMw7E12pps=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-AELFf1nJM6ye6SA24y-7Yg-1; Mon, 01 Jun 2026 06:22:27 -0400
X-MC-Unique: AELFf1nJM6ye6SA24y-7Yg-1
X-Mimecast-MFC-AGG-ID: AELFf1nJM6ye6SA24y-7Yg_1780309347
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490ae0167ceso2026985e9.1
        for <linux-hyperv@vger.kernel.org>; Mon, 01 Jun 2026 03:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780309346; x=1780914146; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYSWdrjn4aqQxQd0Cf2jKHSTVgv+zTIrZalUlPmgVOc=;
        b=slX06cMpX3rn7dIHbKp+WJpsLM/GvMcqyuu2iaaewSobKE/b4lMVS2Ux4ntdq/HNne
         EEJK6whY0Bhhm7Gju30TSWclZLU9DTzY/73y/KlqwoaOk5Tm39FCPsQHCgnlEtycvpfn
         NtK+f3tOIJRoFunZgLdkejRcQlWPOxmbVlLgzrC7fjD4dUFO/ReO+NTo+COQKMfctqOQ
         DSLzmh658KX263pVUCPOBsZWqlDMMsrJyeZiD3b54fGTsm9MaECE44iRFZdjisGwdTeZ
         Xsl6iqI5lCTMH0a49T9xi98LqcPfPAJ01RBxSyyZu9ZtClqIRnPY9L+vxx4H+/NcYj1h
         f0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309346; x=1780914146;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYSWdrjn4aqQxQd0Cf2jKHSTVgv+zTIrZalUlPmgVOc=;
        b=ik3pxdxeWX/61gNWOmEBSr2s6Z8dTWsmy8m4vrZYcpX/rPx8GC+XfsA81hkQuQeP7x
         yrsDxLFsg2NVYwoAgiG76lCz6b1jMkPDh/KAUA2MVSpebhNW/zKDnY+kwts1VpPWq6NR
         umAfekVY64VMFRqwWX+uHa0oBJ9orHXSkOqj6TEapSrtPA/HHy4JIkh11s0Y2D5tLy5W
         pUx0X0nYEL0daq6o/swpNo44/pE7hkCceN+sFC8gRWjBVe3B8YCuzGXpB+k7uydfVNZO
         x6pa8GbH/06QswSSL6mh9syO8nmBBwLZiswjmAXFzFaf0YwoBorEOc6JvlgqYO6lzXHF
         t/vg==
X-Forwarded-Encrypted: i=1; AFNElJ9lpSQYUbsn0N7dqibQ7ysNdEluroXCCgVSPEs3zwxs0FNv/68Gz5RAkylpGA9hQu2hOL1N4sH5ZqPY+YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA7foo0YG9pabYRRXfiiqy+7M+btC6g4kpBZi+bn/8YtI5k83l
	KiFcUZKpxaK3PYEMyp7nSlFrpXrkk/TC1z0oLkpXRcDkmW+FIAJA/hL4DU3EwGRTwQDJ7w2lgUM
	alhuAtGjFXCqIGOycfq8DEZT9AC/n0MSduMoBCoSRpSU1jCR0EXf6DhU6pK9mHggwjw==
X-Gm-Gg: Acq92OFIJrJWhS9f/MJ6xXBqLM+1Ysm5277R39x6GPUraxV3ta3ScBeL+KqMyK4QciP
	h6fJZy1yZsCTx93y8PSBV5UvZOhHovAbJRnPxajq5DIBSuHbfgNi8gbD/lALfPfYy+O/HCpWHOo
	MzvvnFABKgu8lc+3zmQWyoBtVpXD+j8ILkDMl+M6LloW0hwh5LIU8g7baDi3ZAxOShOruJuuGmZ
	vRT0QccmC1dVY5sgng4KMByA0tnnoRndDBrJwrI7zLIUxtcUCJ/YKpzQvimpQrePRVRcvM1yTvQ
	09wsZ98F+CdYyUpOdB2d1A/6n7sJ7rIPBrsbl4e8zz5PCMB8fTGajBxEGCLHz4Kw0eab3z8VKwu
	7PWo563HrSBIQP8qtPDuFsoY8dv8JhJSTbQCM0HWpaiGoUzywIQ8RPoDwrZv6kpOB8QV3QSibYv
	qAmT0J+xct6LgrcI0=
X-Received: by 2002:a05:600d:848c:10b0:490:a1a9:4ffe with SMTP id 5b1f17b1804b1-490a291197bmr137427715e9.12.1780309346503;
        Mon, 01 Jun 2026 03:22:26 -0700 (PDT)
X-Received: by 2002:a05:600d:848c:10b0:490:a1a9:4ffe with SMTP id 5b1f17b1804b1-490a291197bmr137427265e9.12.1780309346037;
        Mon, 01 Jun 2026 03:22:26 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490aaebf4f1sm74962075e9.12.2026.06.01.03.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:22:25 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklinux@outlook.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 05/10] drm/atomic_helper: Do not evaluate plane
 damage before atomic_check
In-Reply-To: <20260530185716.65688-6-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-6-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:22:24 +0200
Message-ID: <87mrxelfvj.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11424-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,outlook.com,broadcom.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javierm@redhat.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,broadcom.com:email,ocarina.mail-host-address-is-not-set:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E8B2161DB7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Remove the call to drm_atomic_helper_check_plane_damage() from before
> calling the atomic_check helpers. The call has no longer any purpose,
> as the actual evaluation happens after running atomic_check.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


