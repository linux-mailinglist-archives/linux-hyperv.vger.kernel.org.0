Return-Path: <linux-hyperv+bounces-11423-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EUjZIkldHWobZwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11423-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:22:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B94261D418
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5B4130078AC
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 10:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F34738AC9A;
	Mon,  1 Jun 2026 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIGsXs0c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nv+DG/sT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7706F3932E3
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Jun 2026 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309318; cv=none; b=BiAbu6yPEE3f1u1oFClz+QSDsAsEzzu6Mt2ZvNdnocsVvKDNA7ySp5Q2+1k2ofgFdiVzPA2gsdIhF5TuJ0OXyrOh9gsM9hVCD1SR0IvhaG7ditvFzBuLVraxGezqknGYo24n3wMErgQRati8z9YRvL/8patDE+bhkql2ZNMds+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309318; c=relaxed/simple;
	bh=+GFFl+Rwg7JHhjyaixD5rn1nx7MuuwFPfvgFiQ+tuhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MS3QkfRNpHHvfzwYRtt9sjyMsuiMrtMIDpKvgiyVMDSbk+NujTBLah1Guth/ofIneBMN9dQ2ZqmAkrvSZ/Mvziupb3LzNpo0BiuvuKB9ebq64utg/SCL2UUTfUzfWm0Oei6OahdKidxzw2T+z2J+uYe6fBWDzqP95mM415juuMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RIGsXs0c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nv+DG/sT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cbduX2ADEGxdwqbVWpmygVu5C4B36x/+bcdfT1PUUqQ=;
	b=RIGsXs0cMKBwTnwVFEDAV3//WaQHg4zl1hpNPIfMrjpEzy3rLECIG3LmunqKsOsJkxE6t0
	3ZAxZPTVZye63+jVfJkCDY+0PRzolwkM2O6mvdMiSjloYb7iD9r++9tZ75H08b2whO3c0D
	NpXQYyWcqYyGOFbpcDLsVH950JSYlEc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-P3R4m3XMMtewi5lRpgEA5g-1; Mon, 01 Jun 2026 06:21:53 -0400
X-MC-Unique: P3R4m3XMMtewi5lRpgEA5g-1
X-Mimecast-MFC-AGG-ID: P3R4m3XMMtewi5lRpgEA5g_1780309312
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46011aa5000so416772f8f.3
        for <linux-hyperv@vger.kernel.org>; Mon, 01 Jun 2026 03:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780309312; x=1780914112; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cbduX2ADEGxdwqbVWpmygVu5C4B36x/+bcdfT1PUUqQ=;
        b=Nv+DG/sTMIuGr52pWsMESt8ZWqJzA6+VomUqc/VsEOXI4mZq5Fl1jRugyLiBEMOAIF
         Vo5Rrgc67ILSKEh+fKw33aCK1WHEESxYhrrBq8UyPdF0hU0Jlg7NbUV5jdlScUvhWbYG
         wTQtC04yQ4big+pDih4oQrP+tAmQue+RGhBG+YPvU1fTH46JOCqDIBI9QU62W0hv11Fg
         bgsqRWGZmgNV4p+0rh3K/JNkn9al3IzwHzFca8ISJxPuUnWQYgBYjGDMtOL/bSj6kV8T
         RusuFIu8OlZzV2JyomXT9chEBEzAcT/h5oH11nd7ENaJVhUmKwK76qeYA+vLC9rytYPk
         1/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309312; x=1780914112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbduX2ADEGxdwqbVWpmygVu5C4B36x/+bcdfT1PUUqQ=;
        b=qt3b78YosofEAC9AVziz5p6WHiEotYk7bPcsdoxFuHdOjZq1oPKffuqaFPEwZgAxnX
         i9AZAmgD7NDcMkh8zxpEi13mDtoBeacSnLKdFA37Osahs4ieOW77vq5NIukVrzUiIbxV
         7X4bSXTf/X/bnQBLu+OuzC7zwQAVipYlCcc4X8mVWRwuDE8czBmFWcWVJ4vQdat5KEO0
         2fE9IWVx2q6XbbMIUr9wDoTckZ/u9HQqLZai3UTdkuMoVPaAiOerI0cB0gc/oDJetA0L
         FDdfccdrTSQvdbj3kWQhx9Ndd4Psoo4Cy5V7O6zLxFNb6DzDV953pGnrGxq5w6VvNpf7
         fqLQ==
X-Forwarded-Encrypted: i=1; AFNElJ8CDVJwGL+zzjvwmzer4WKDIbx9XOIk7UrsbFluCKeaSePYWLgi729HK8i0sPp0TxY15oT//1ypHjXfjSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLjNFEBtOzusBofrAJ5Apx2AzAhVcqDu/bQKu8SbptlQGngWNP
	C/j44c/fXLVGq5e53Zrv9dVk0dHHFLmd0uz09krJiDZo7iF4oyf8xY/t7AysOe9nprSrr8BDZ9i
	Wkk9NBNnnSmR35cityu5bYI/pO72I5a6sZJ28scMauw9+/59zXBM+aue+pfzPHOG1UA==
X-Gm-Gg: Acq92OGAIjUqk65LwlKqwgayk5b5Z/mjKnr8BiyQZb3vMJ621TCTz7we9NKeYh+uJSV
	Ig68X9daRg8srG0NSaJ/59A29avZnR0PPT1YVPVT9WrEvdiMOSpoo2/enTlNWgWCR0+vMPUuG0U
	3rDvXSYwI22JJRJ+L5PDeG5jsmgogRTujNXabHQ4Zoo4FzpvNbOmKIXZfR++HCnvkaOT3/cQU7x
	/Erv/iqZ4rhw94onz8yXA7UmlpcvIUPlyUkWe6A2KUMaIsHWw8YtuABWeELTNd8ktSP7cJkZz6W
	zE7gMsRzUhIwcbozBBeJh7pKedd+ErmBCh30YzYmiw5rMcIAGYAYfKSgPPF2durP+kSrK8zQsph
	r3018APkDkz5OvcWSBpEYhdGM1S+iyogdDRfl4nP5OYknqY3jbJi/mPHM2CyBZLLfLedziFEaUf
	t03BsqRgrJIduFuXM=
X-Received: by 2002:a05:600c:a415:b0:490:60cb:55f0 with SMTP id 5b1f17b1804b1-490a292febdmr182719215e9.21.1780309311981;
        Mon, 01 Jun 2026 03:21:51 -0700 (PDT)
X-Received: by 2002:a05:600c:a415:b0:490:60cb:55f0 with SMTP id 5b1f17b1804b1-490a292febdmr182718675e9.21.1780309311464;
        Mon, 01 Jun 2026 03:21:51 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68a925sm366735475e9.2.2026.06.01.03.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:21:50 -0700 (PDT)
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
Subject: Re: [PATCH v4 04/10] drm/appletbdrm: Allocate request/response
 buffers in begin_fb_access
In-Reply-To: <20260530185716.65688-5-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-5-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:21:50 +0200
Message-ID: <87pl2alfwh.fsf@ocarina.mail-host-address-is-not-set>
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
	TAGGED_FROM(0.00)[bounces-11423-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ocarina.mail-host-address-is-not-set:mid]
X-Rspamd-Queue-Id: 4B94261D418
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thomas Zimmermann <tzimmermann@suse.de> writes:

> In atomic_check, damage handling is not fully evaluated. Another
> atomic_check helper could trigger a full modeset and thus invalidate
> damage clips.
>
> Allocation of the request/response buffers in appletbdrm depends on
> correct damage information. Otherwise it might allocate incorrectly
> sized buffers. Allocate the buffers in the driver's begin_fb_access
> helper. It runs early during the commit when damage clipping has been
> fully evaluated.
>
> v2:
> - allocate before drm_gem_begin_shadow_fb_access() to avoid leak on error

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


