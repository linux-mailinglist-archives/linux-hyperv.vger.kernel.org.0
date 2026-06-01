Return-Path: <linux-hyperv+bounces-11422-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Gj5H5BhHWojZwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11422-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:40:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD1D61DB0F
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44E18304743F
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 10:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6A2391833;
	Mon,  1 Jun 2026 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h14RMu/y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tgeWTFco"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941433921DF
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Jun 2026 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309265; cv=none; b=Ox7DuwgxYRQUYfZ4ruZ/ZYD5Uqv0VNJcZf34NbLpAxeIfcR9PpFu3Zggp3SFZTu3dcPwJvwXwrccLwT8Ck4I5XsYQuSSMqnBunDyM2mT7ok6rKqFoYneZHeKHQrygc72qdEvU8TR5bztPuKdM7+sVCVYY/hqg2SVfKcBRxW2bxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309265; c=relaxed/simple;
	bh=326g4EpO+TBbZXT0k/fdB+P1jFfmFRBJEf+jFr0a2Gg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YNXbSCcJPDnEY0BXmvzM+d9ZAOX7te0mZbs/qy2kj7vg5Qa2ky1lYvuKRn01Atm+CCaR71mp7w92Rn4wfpIJL9sM38p5qpzTnEm5BoOGM16wYdGpBtx6YhwZZXM751Xp7E2TEKwuKoaoIhqH932Nu0T9H+s/9hfdEhp8YV5GqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h14RMu/y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tgeWTFco; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PtraVy72eIuUfdejQSU7WTEFINXM3tMuzrGKzIN4pEs=;
	b=h14RMu/yjv2gPdqpZr8vIoS715XR2o8uXdC9OZ5yXtm/EH5vhgqD9EF5PL/IGimn2Hx0Y7
	xNwzUXQY7o700I0A4oJZg1KTd2adWoMeR5Mj4MxSRVmK4bpE19xobbDwOLoNALUA0C3i0X
	Y0S5KStyDx3yhJe+82SZgFtCucpiurs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-kYtJ2iBpMXiStfyOZZqlqA-1; Mon, 01 Jun 2026 06:21:00 -0400
X-MC-Unique: kYtJ2iBpMXiStfyOZZqlqA-1
X-Mimecast-MFC-AGG-ID: kYtJ2iBpMXiStfyOZZqlqA_1780309259
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4909deb82d0so23147885e9.1
        for <linux-hyperv@vger.kernel.org>; Mon, 01 Jun 2026 03:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780309259; x=1780914059; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PtraVy72eIuUfdejQSU7WTEFINXM3tMuzrGKzIN4pEs=;
        b=tgeWTFcoJfOaw9rArHyK8x0OA4JG7d1VaOfuzQN+5tYYRk5qOTvyIWTVFKAgfNx674
         7Y0drA0hJu/nmsGTkLGF3XUrOH7oL3Dr6r9OgB5CC1CzFidip0FbJ0+jKOaJ8wdox2TN
         7X1Ikwb0s5YY41TnWHgIUWvDFGO9P38h1i1q7nJKfxQDVns7bxDVINuztj6aS4luS1FQ
         //aV8AJDldy4/Sb7eYs2sNSCTZg8txR41Ilo4E2JQwadGsr87+cD+VZRNELe3LvTbsR7
         nBfyrQlHR7RHbjAjp/9A5iESpKdivzSQZ9mVSykZsa6lH3IAdWGQtUEqHAbGQHrArOf5
         XZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309259; x=1780914059;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtraVy72eIuUfdejQSU7WTEFINXM3tMuzrGKzIN4pEs=;
        b=kvZu/AURXRLJNSqC6S8cfwFv7bLvjDJb/xGVs8hfpsJc7XVnYG+7ciiErAXBmWUIJ4
         n4zjtjJsP/8GfF6XkJamwqFAqHslvsoTTEeLHMZ7F5h4B7kb8HM+3pEvW99d0Q4I9EnY
         KAOVtyDFTFjRKq5q2W5x6zhqQLKbQJLfB0mjm/tDyZ/HpGvWPww6wK+NA95HOcUczgQP
         BibT3xySNYCyju0hHthHe3NiVThqGCwD3nDnKhLNR2kaqFDpKztxlRWZLuGJJeKxgB0m
         ZsrONbn8j05lXHxFCwDf28g8JtcArz8Q2IwysHCF/GKZ/yak9X6WSjigoJWJjXuE6dAt
         siZg==
X-Forwarded-Encrypted: i=1; AFNElJ9dI212S+YhjrWGoHDix+YoZ7EBSgH8NXnf0MlrZFeBpsxUqmp4T1JbnK9xeSzGjQaAgPR8cQ8Hane8JOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoJR7GcsW+Qdy8l+PDDZgldpobQ4sWiILx/OX9lwaknIgq6jZf
	GK9+PhXvTie6BBsmZePLGXFQmerxKZAO6tnHeGvx0I2LwLGffR9DGmOJThHUf9HT9y5QHkGUOA+
	bFBFS9vieb2DBQ9tk5q9yTAfvGsg+CTOhCfLPXp+Gxxi+Y4W6nXNr9tQzZoH8gVO1mQ==
X-Gm-Gg: Acq92OGiM0KNQh/ewYOu04O3quK70KtKw6/IObMr0LlTtZ6+C/sfLMib4bn7D5jMkRg
	liDMskHA0cEUMpcaDesOnK7oK2tEF2WX0ijiY1BtE5NsH/VBmv8wC72pUVb9rMKkYUCjCPZF7Z9
	IBQ7GtfP5IZFYHvlM37wNv/aVI9LK026S4Rd7uqtxS4SfC1D2rqaWVWNY01hrgv8sxWCc4FBAVE
	Eqs7Nb5LjgEy9MqrKT5F9XcnYEkD9uJE/5lDZSXzg4dj8YP2wZ1avkdWArEqSagouq4vv/FYVud
	eVBssHBwsjWzzaNsMGpTN87+S/RGk0xNG8aAu9phmybn/hoCbnxh73aTI7w52idegvzV5N3Lalp
	27/Lf1vJGkG0PzRJxXE0xyNCIvZB8Uw5s2Hdn7XP9w1qXkswa2malmLtrNjdZ3GVc7+zJ8tTebR
	eyYgxD9AW6ivUnJyI=
X-Received: by 2002:a05:600c:1992:b0:490:adb6:793d with SMTP id 5b1f17b1804b1-490adb67fc0mr29782775e9.26.1780309258856;
        Mon, 01 Jun 2026 03:20:58 -0700 (PDT)
X-Received: by 2002:a05:600c:1992:b0:490:adb6:793d with SMTP id 5b1f17b1804b1-490adb67fc0mr29781855e9.26.1780309258391;
        Mon, 01 Jun 2026 03:20:58 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490aeacecfasm19237985e9.4.2026.06.01.03.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:20:57 -0700 (PDT)
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
Subject: Re: [PATCH v4 03/10] drm/ingenic: Remove calls to
 drm_atomic_helper_check_plane_damage()
In-Reply-To: <20260530185716.65688-4-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-4-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:20:56 +0200
Message-ID: <87se76lfxz.fsf@ocarina.mail-host-address-is-not-set>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11422-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,outlook.com,broadcom.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,broadcom.com:email,ocarina.mail-host-address-is-not-set:mid,suse.de:email]
X-Rspamd-Queue-Id: 0FD1D61DB0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Atomic helpers call drm_atomic_helper_check_plane_damage() after the
> atomic_check anyway. See atomic_helper_check_planes(). Remove the calls
> from the planes' atomic_check.
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


