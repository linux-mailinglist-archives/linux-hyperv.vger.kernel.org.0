Return-Path: <linux-hyperv+bounces-11425-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EFLLmJfHWo/ZwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11425-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:30:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FE061D713
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC077303B1E2
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 10:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C27B3998B1;
	Mon,  1 Jun 2026 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmfYGi0m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewcwaDyN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A14E399342
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Jun 2026 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309676; cv=none; b=J2uJtb5u2dLvzEWgFXJ9r87zpbc+lnpozJDfkDyFKX1Lt9ew4diEfrF83AQ1Ddwntkin0HLVQaE5KyNQLjft34PaLLxrzEF9JtmIlXJ9V9+X7Krdi+I4gJ8fwQx3uooHbbeNJPv/D8FPzybdHVslgnSAymuX1ibbgtRRSsZ7yys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309676; c=relaxed/simple;
	bh=SAgXIx89304YyTe8+6UMLZsSBSUvLSpMqzKtolzE27s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CB1BBMCBExWc8LCgW4XR1fYH3ZrhPWlMhSYLzzn03gEmJTFUo/+FaUFZ1U10KOm4OBad5Q9F2voSgg3y4+/Z+PmiOHJXHdDuQZn8vYJmiHaJMTq/pSJ9b/HTDO/JYK61SVluoRZZAK7FD3XAjJlyqPpabaImWOoeMyH4Wm8yd34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmfYGi0m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewcwaDyN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hD1h4dJE66yskCwSbjuaF026xxijLvV5fH5oqPl0EUY=;
	b=UmfYGi0m8oncNum3kqRpmPcpBA2GMqAdTvpZ11yraU1mCFPPpl/Et8fsgK61glWAMXXU1j
	w4lVXJ+RKKPVpzthX1C0U37zuX9ZULJPXf6TBkEpbZQCc+yKpnusMuarQzV22uXRT1eCv2
	8vkMJpFxo3g1YqJgGiBqxGmaUYmRWwM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-L-_PyZJhOWm9UswCbZE-_w-1; Mon, 01 Jun 2026 06:27:48 -0400
X-MC-Unique: L-_PyZJhOWm9UswCbZE-_w-1
X-Mimecast-MFC-AGG-ID: L-_PyZJhOWm9UswCbZE-_w_1780309667
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49045243094so124586975e9.2
        for <linux-hyperv@vger.kernel.org>; Mon, 01 Jun 2026 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780309667; x=1780914467; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hD1h4dJE66yskCwSbjuaF026xxijLvV5fH5oqPl0EUY=;
        b=ewcwaDyNPq7+CD7eIO2nvwQiAedlQUiqFevgJTn6tqqaWKienHc05ZMTF2MIsFckSL
         /Z/DrRgo6X3dW//cgKAImBv26Fg7j7FAemdU6EVTmtGPafJkHxwn4M2bFhO68QXFvjuL
         c0j2690B3zzEDQVO3IU9RyIMVwR0uy9JBGA2wlFXQKMHxJRS6sMKLchoj4xhgnGCtoVs
         uYcgLbc8qsonWqKlpCW5JL+Dk36oNQsJj9UjAaHWQEPyC7nkGjNLp3SXf/z36pefdqIy
         i8fWM+sEwWLBmv1g1mNwdGWxkzGO7+I/cwAoXMApRwSCSmotBdJfZ1OprA+Fi8RyvsVO
         CpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309667; x=1780914467;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hD1h4dJE66yskCwSbjuaF026xxijLvV5fH5oqPl0EUY=;
        b=LCc7YBtapKh2kpCFiy8BBovU+U6lDvoDjYoi2uGbcOu8lWuXVlm9t5iX8++Ngz6ulo
         7Szz01MIyCzqGc2Njl5+Br/BylHFzamUxaXz9s63BUj73nP4c+ONutUVnHMrbk/Un6Cr
         2jIf8j/U8FCpAp5yhWj86gE+fE58puyrjiGg8EUWcz9VEyKqF4Y6yC6HYQqkS1Gsk+XN
         DjFgu1SGYOfi2b/Sqn6rOadg2jePHRiRwoNrTDcTUykZxrzw8jiyWDmFcWf1+nJyhAEh
         9vTvnEJD0rIb6HqMQFoZfh+oB15Oc4DYd2IByf9DyXoODLIt0jPmRDa4jwPl/RienciP
         WdSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8BELW8hT//yQak8FeFWd1RFm+822gMhI1MFhm0JAA5Nf5D92hgHjDbHR86uChGb7X59rpZdnQyoBJe0Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4rcgIsHmueIZDxOte6cpUms8OXTQZ3MbDHYGAlAwmJ6ciXlZH
	aUs447tcC8FfFVyEUGmi4TcxIBe9x5VabnedaiDP81bGsDYiuq08tfbwAx9a1qcvFo4ufeU9/1Y
	Qj/Ja0iIH7pgPG4JjElephx0lDgjRHPqK1tVdmXsKRLOyhbN6HMqoNH+rqHsprNCqIQ==
X-Gm-Gg: Acq92OHTj0LwejApLNTzv5wFaZqcWcPgstVbJ691LY81AYdOmuxi86YwUuam6Ox/2F4
	yrD3QPtC6we7lgBC2No9Da5DOBZDxOl/dkid1CCc7BpRr3Qu/6z5UueF9xy2pzJ1bNGDyEIgNdX
	e1mFE3JCH0kmO2rDK1vsOba98umW12eck9C39MKsSkfdH6Y5MQRRt3Wpxj/XqSwUPw6MbQe06OK
	BhO8aVAz6Y63/UPBCSWaB0kBhGcitvsA7q4mRSex9+vQFA51WmLKrSaheeuc+DS2cmZKyIslOAx
	sUL3NN1cNXcDRRQguz2e2EEI6SMwrcOuHavLbq9ZsaDQY7AKrvBpFu0Zf3rB/ZYvXXN3W6Pcdfo
	QPnPPKOn4YIOpbGLeS90/oZJuMcFbSg2sS7NQs2a8AL0brjBtTW4EEgAsHGVTLxjMydi57b8ZlO
	r5ewQY88gtxtSwq30=
X-Received: by 2002:a05:600c:a111:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490a2933355mr153783175e9.12.1780309666739;
        Mon, 01 Jun 2026 03:27:46 -0700 (PDT)
X-Received: by 2002:a05:600c:a111:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490a2933355mr153782735e9.12.1780309666314;
        Mon, 01 Jun 2026 03:27:46 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef32fabcasm23690022f8f.0.2026.06.01.03.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:27:45 -0700 (PDT)
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
Subject: Re: [PATCH v4 06/10] drm/damage-helper: Test src coord in
 drm_atomic_helper_check_plane_damage()
In-Reply-To: <20260530185716.65688-7-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-7-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:27:44 +0200
Message-ID: <87jysilfmn.fsf@ocarina.mail-host-address-is-not-set>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11425-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,outlook.com,broadcom.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email,ocarina.mail-host-address-is-not-set:mid]
X-Rspamd-Queue-Id: 67FE061D713
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Planes require a full update if the source coordinates change across
> atomic commits. Evaluate this during the atomic-check and set the flag
> ignore_damage_clips in the plane state, if so. Remove the check from
> drm_atomic_helper_damage_iter_init().
>
> This will help with removing the old state from the atomic-commit phase
> and simplify atomic_update helpers a bit.
>
> Several unit tests check against the change of the src coordinate. Drop
> them as they do no longer serve a purpose. If the src coordinate changes
> across commits, atomic helpers will set the plane state's
> ignore_damage_clips flag, for which a separate unit test exists.
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


