Return-Path: <linux-hyperv+bounces-11427-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ2sAntfHWo/ZwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11427-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:31:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B428B61D762
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E2343007B89
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 10:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A3394EA7;
	Mon,  1 Jun 2026 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1CDticZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUPt0t/r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A0233953
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Jun 2026 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309743; cv=none; b=uA9GtmvecXvIOqUTa5I5hnq2OLp3O1w9Wg0DASatUjKbtqK6Ov783CMnjg6yedrdl3Z2EvWdUzwZkLBbhkNwHUD/zR9mLfdl2kfR+ARXq7K6FgxpxpZHIcedBfmi1wdb1+bs6XpX+3TChymBxGYLH/9+C3feE86nUKQaYP5neHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309743; c=relaxed/simple;
	bh=fWhbb8RP2B9GFzJgG02F16ZQKziy0+yRxPE3hHDevpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JnQDGuGq177UkCVxYzC9Auds5RsLrqdRPbBp6sfYSLdRF0pm6gNRby/gmTINeCS2ijccSiPOX3bIwk9FR7cGBbOK/L2mznpYRSuoxidYRXjPPAdK2cC5lVv1BuK0ALBAI12MC2VgKxt4egdCWp+k9OWX1Mnvmay3AqsVQ0HEuII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X1CDticZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUPt0t/r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rR3vdJBAgyYpZ/mB0zSfLOFP8KAbUlqalAgRbWXUhZ4=;
	b=X1CDticZ+CJXYMssi4qhtx3o0Bv2W0WJYZy40DWc73E7EQizIBpr26BgiONy8Gq31xgLWL
	4XrLON6SGtBYwLT77hPAx8PnyV/5GEcTwzpeg4mR0i5tn3pr5zHQbJOEsmAmwhBsKBEpWI
	hqZxqpWwkmV8UNdrDPi9iikVKJyVwkI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-CtR6UcKGOy2u5XFYfX04hQ-1; Mon, 01 Jun 2026 06:28:59 -0400
X-MC-Unique: CtR6UcKGOy2u5XFYfX04hQ-1
X-Mimecast-MFC-AGG-ID: CtR6UcKGOy2u5XFYfX04hQ_1780309739
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a786f987so12292965e9.3
        for <linux-hyperv@vger.kernel.org>; Mon, 01 Jun 2026 03:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780309738; x=1780914538; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rR3vdJBAgyYpZ/mB0zSfLOFP8KAbUlqalAgRbWXUhZ4=;
        b=ZUPt0t/r9bJ4kSWsvYpVlvsKMkAniozNbGeQORgSPfBkQfbSuBv1cPHoU4zy9Ps5SK
         VJhBqxghNoFnGOMXokawPNwl88QaQokVJ+k6v9g/MHrGpcz0K7+elWH3eWbbY3ESARSB
         gTekgth72S1oXw++VHeOup5cMOEMtcup6WWC/aMFGvQosbtsWbvIqpaixwIqHhy9tzBT
         LzsQe0sgkJUnRYC85WHL5P+HAeUm2hn6La7o8MD4Gd67or+wllpdCfm2P0ZL0glDSSKI
         o189yHOS2FPaNs0gTj2tlOV4UZodz8WjK1uczhUJI4IRjL2FKA4i4t1IPcpOGEsq/gQZ
         PsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309738; x=1780914538;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rR3vdJBAgyYpZ/mB0zSfLOFP8KAbUlqalAgRbWXUhZ4=;
        b=lIjihezbBpQRtTW+SKjTJ+uqMgzB2qCgIjmk0kmaYMLFyyeP4CgOsc6b7yMOkNuuqI
         KO9G40iBYfYkb83lMmta6NH9/ChLgH5y68jE7aUNn/cVqoTfGuuC515ojRNMUuAJ5DqD
         7mS4QsECEOyjGd0t30G9I9HnIHE7nH8H11FWhikzk9ZBbn/1YVshC3mFkl0Neu1pyBU9
         WpySyeo9EfItd+cmHoaja1BrzH4O8iWqj+ya23oO7Ilw7dvVMxP+V4sjOuyg0DH26Dl2
         mBabHXwr0tpiCxvxfIE3d7xRgMGCcyfBPpTQyeyvZEdkW4oVhc3SE4mTJwbbht8JTXcs
         yZbg==
X-Forwarded-Encrypted: i=1; AFNElJ8YRbWLp+/MNDPC82mLvuVGtnRM5mSNqknZPexIL6ozcG7afsRMJVDHLKhhhLXi+AzfWKZtbpStf2yFUto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaDTPLmIppDHjFWUBDlQ4lDUt2g2xTMZOereMcEEqMhJLs6NGe
	WR9cd6Hulv43qHIUWOZDXft5xQ2ILaoQe2ZawZ0tIupxwO/KUarAK1S9JSRcV+DcYKUprgtMT+u
	E+8X6JrCbl6iPi7etqZ7iECel1E40WPnk2s7ZwLDG80Xu1Ne2Ss53g2T1Qh+jSSVr5g==
X-Gm-Gg: Acq92OEaVvPl0iOlVP054YGahb4zQ16XWhZj0xVDLRPlFLt6qmb0UHBLE+xMXbqaLQn
	Q9NKliTOpkFLGOyypZ22JDUPSeO+/a0KDaLGkGWdHVQgWez7qddYvvOB+DnPJJ09EaNAjwWjook
	08zd5bnFswdo+06TZfaG83f5+VvAUK8cB3LfKhBgs9y1SOnep/qd9eqqJy58HtjaAu32zVrqBjh
	dDLc+vfxU9WD59KAUswME50fyucys+bch2xSofuVTGeBGX8W6QxvKfHOAs9O3DI0EScBsG/vomX
	GH/1KjddrADqNnPh5m1xxWrz/FPvW+pdtTHq0ppAxY2LaNDFuG2mQ9e+yl2tEVmIDYWMr2h94Nd
	zU6xVZDV7mY64WZSFWoMxIucsvfv6Gy1weuQSzs8t0WdCCKgqDT9JXAWdSUjxOoCh1eK/KinD99
	2rwL4nfJj8HJzVbX4=
X-Received: by 2002:a05:600c:a214:b0:490:9782:3eb8 with SMTP id 5b1f17b1804b1-490a2948f0cmr117371395e9.25.1780309738540;
        Mon, 01 Jun 2026 03:28:58 -0700 (PDT)
X-Received: by 2002:a05:600c:a214:b0:490:9782:3eb8 with SMTP id 5b1f17b1804b1-490a2948f0cmr117370965e9.25.1780309738117;
        Mon, 01 Jun 2026 03:28:58 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ae3901cesm8445615e9.7.2026.06.01.03.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:28:57 -0700 (PDT)
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
Subject: Re: [PATCH v4 07/10] drm/damage-helper: Remove old state from
 drm_atomic_helper_damage_iter_init()
In-Reply-To: <20260530185716.65688-8-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-8-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:28:56 +0200
Message-ID: <87h5nmlfkn.fsf@ocarina.mail-host-address-is-not-set>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11427-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,outlook.com,broadcom.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email,ocarina.mail-host-address-is-not-set:mid,broadcom.com:email]
X-Rspamd-Queue-Id: B428B61D762
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Nothing in drm_atomic_helper_damage_iter_init() requires the old
> plane state. Remove the parameter and mass-convert callers.
>
> Most callers now no longer require the old plane state in their plane's
> atomic_update helper. Remove it as well.
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


