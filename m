Return-Path: <linux-hyperv+bounces-11430-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFY9NLJgHWojZwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11430-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:36:34 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 003EC61D9A7
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56BD730575F4
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D207356766;
	Mon,  1 Jun 2026 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQm6PenR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHurnysD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60732351C2D
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Jun 2026 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309831; cv=none; b=JIGe/+Q2lrQ1E4XtoBZNGmfSGBoVP6yDiQpLEwN+j2Sz7a5tjYDWR8S7oK1Zd/agycRZV8dzgOncyfd305AfmUPmv5EIfLqQZ586WIo8zg2fFkHeLMFcKSjQOociKFpDpHsXbEJhODRFKDOC4hZ8ic+0PyZbssG5bjnuZxnW7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309831; c=relaxed/simple;
	bh=QwPby8X/UWc3SSFrtbajyvQr/e6eT36Z4APpEAoWVYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VFDsJtoZbYJBMZiZec6fJnYuP3RJScHddN2Y6rMHA4SwzWV+J6yQQxJeDIn8R1OZG/6taJPAy7wPoezopcd9l3tdBUNXTtT7aJKRsqPr28MiSw+zpHCvlG13gvo0gT8ur1mKVGP6/sObWeKD9nf5EussGmwJgLlmMZwtT0Q/Py0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQm6PenR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHurnysD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m5PnIUHVz9ACSP+/e7SnC4cD1TL+Z3tg4EIuDM06718=;
	b=GQm6PenRqlHE5fwAvh+yBpQ2UAw1QmnxoIow7O6zDOsku8TzYA8QdOyu3j6l42Q8L6yizA
	5a51IR6zIJR1uWwRz+k2MmEajcFk0WuFqy9wnSqKh5LCcXCM5yv89TPmlIFNRY2FRoVaWv
	s6u9HfZ18Lg58gep2XyVg2OvnJBRT1w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-5jptegXeNqiqi1m-tiVQcw-1; Mon, 01 Jun 2026 06:30:27 -0400
X-MC-Unique: 5jptegXeNqiqi1m-tiVQcw-1
X-Mimecast-MFC-AGG-ID: 5jptegXeNqiqi1m-tiVQcw_1780309826
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49049100a40so61802325e9.2
        for <linux-hyperv@vger.kernel.org>; Mon, 01 Jun 2026 03:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780309826; x=1780914626; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m5PnIUHVz9ACSP+/e7SnC4cD1TL+Z3tg4EIuDM06718=;
        b=UHurnysDfKjAHL3T1dknaMI8R1FlKid3c6TPkh531o9wZkrFPEoiFbgNG6yPU/JIM5
         1sxFfsbMqdSQShICtfO5CQzGHAvivHOZx1LPFV6GsxL3KChSb2ga/u6uvm7/6Rl9tXuc
         U8+DyLFsq3uZOTbUEZTRQ0vPvLgbKdBNSgzkyusmRZSEbHYKkC7hg/DYtylx3KS7wGkB
         WUbQxif7m7acWd2t2SVeq0tPH8IjWlze3HJNro4fiiOLAUbqLWqFVEkoAg+SjcI2qQki
         8msc4StfxC4eGGFaEVuSksC49XCD0vhGs41Wv5+v87L8pS1Gnu8yyo79bbG6NcNHi6UN
         iM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309826; x=1780914626;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5PnIUHVz9ACSP+/e7SnC4cD1TL+Z3tg4EIuDM06718=;
        b=FxLwN7JmZC2vZDhJcxQZNK9AqUax55qY1Y1ltUhrZQPn2G2xhMWDcQBIDgftYDKLxF
         lN4IYqNwABR2L3NbNuPx5cabl+Cm7jcubwkmyI/hDhmQ2mNnI9E0qZGwG3pm9YsMGpbK
         Ab6JARfcbQ4ixaE+nJPyKWc++GhIcRiRxg0oVJi1l4b+IZKsof2LnmKFUkgf5PLytsWR
         ysxz5zg72DsJkBgR5OrmNfajhdbuqJDlpntkb2jUOdubFD1EbxLHlqaF2GZ+bSOO7H3R
         upAWbFtnszCiYrRh4tfno821TMsEj9uoLvsUqLKocPIn9Zes1iUQ7gys5nc8B2LC83L8
         UBKg==
X-Forwarded-Encrypted: i=1; AFNElJ+1TgnnFq4vnLy+0KdY+65QsbrgPExSOUmSemCP3w9noq2uy0KsChtZmmxh10j/Mc1jv68ISB2W4uaOjZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaJaeHU8rciRMONBSQYw5ylIh2w0d6Zijr8ZWB68X+1mznMIYq
	UOj3hfQP3DkB2InDH0ccb3gUEBZYfTZFZqNl1BjUDSO0q/tNcxS0PgFG58cSDAT1RjR+d5AxAb8
	Zruf3zPftE46qze4JbiRoKuaFhaPMfW8YjnOI1jA8OwlzgBL3er0jPdsOA2o19m3Eiw==
X-Gm-Gg: Acq92OH3Zndo9jX3wRL3gAEmRVsVhNw49M7znhPsimEivbmgnb8WQM/okG8c2Qg6xYe
	8b6Puf3MXBxBUP24TsDrnLCQGELWMV1m5H223/Y/usUruz52AfgVSm/jBSs4GuMjx18VvsxGLBY
	c9sr3n2I+ZhR53b9wa/TiUTqVn09pJcq15NIJOdrkYOshlLVC8qczqObc26/v9iNS05HIH15QS+
	WYwC21Zc2sG9UaX+chtuWYkPAgiBevQwIDWhkOwfdBLd6S3JF8yfcEcutMEGhor/fAj2RA5wD+C
	+5A/prCvvnuElsB4Tdh4tqx9PGToxobb2BAR/QtIeWl53J2gxC9WEtl2tUK0d2q2FkvD4Gti6AQ
	F48M4ikkhCsl7Q7nNgFIotq7AaOO1OVue0Y04PmZFN980DTrGykmcc0CcVYwqPVNq0n40E4o9Hg
	Vci/c0z6NfeEW7LF4=
X-Received: by 2002:a05:600c:8582:b0:490:51e9:deba with SMTP id 5b1f17b1804b1-490a293b7c1mr147144815e9.27.1780309826067;
        Mon, 01 Jun 2026 03:30:26 -0700 (PDT)
X-Received: by 2002:a05:600c:8582:b0:490:51e9:deba with SMTP id 5b1f17b1804b1-490a293b7c1mr147143955e9.27.1780309825482;
        Mon, 01 Jun 2026 03:30:25 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490adb4381csm24027695e9.3.2026.06.01.03.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:30:24 -0700 (PDT)
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
Subject: Re: [PATCH v4 10/10] drm/vmwgfx: Remove unused field struct
 vmwgfx_du_update_plane.old_state
In-Reply-To: <20260530185716.65688-11-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-11-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:30:23 +0200
Message-ID: <878q8ylfi8.fsf@ocarina.mail-host-address-is-not-set>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11430-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,outlook.com,broadcom.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ocarina.mail-host-address-is-not-set:mid,broadcom.com:email]
X-Rspamd-Queue-Id: 003EC61D9A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Plane updates no longer require the old plane state. Remove the field
> from struct vmwgfx_du_update_plane and fix all callers.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


