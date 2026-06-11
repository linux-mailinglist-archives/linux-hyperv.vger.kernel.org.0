Return-Path: <linux-hyperv+bounces-11601-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m47YKNyJKmr5rwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11601-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 12:11:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D47D670B96
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 12:11:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=V4wDati0;
	dkim=pass header.d=redhat.com header.s=google header.b=aUSRzXU9;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11601-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11601-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E88E83011042
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 10:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E671375ABD;
	Thu, 11 Jun 2026 10:11:33 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF76D3CAA31
	for <linux-hyperv@vger.kernel.org>; Thu, 11 Jun 2026 10:11:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172692; cv=none; b=OjvaRZ+e2AQOeyhmUEgLi2913AostNNwriZrQANs/xtBmujhNLzmNZd0gNoXuXfwkzyRetzlMEcIN9NRGn9Eiezqm7xljE8XwIr/bMegOQbNOuDf50iEpsNHSJ/L5DEyE6XrFy4T9ApteQ/wlj45fpBGfaTIEKjfb0i908c/jPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172692; c=relaxed/simple;
	bh=jYECQqhOuGSVvKdTwPWyVL5AujdqMA5a0nxgPXJ1KXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=igRU15aIErmdtPa5xVr3ddkSnQ6dcw1Gd4sTEO0gCZZGv0xCfjBeBlx+XS8uDPvZwPH7JbdZnXt3au3/K6k5cDRJwkFf+lf56nNfHi3A9NtNTDN926AiNfgY7gCPQuSPrIwLK+hNCEWKPpRqadU/c+srp7el0XUgE4cGh8RkLy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4wDati0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUSRzXU9; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781172689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8J03CxoywVvGkdqDT93IzLl+xZxTV2J8FpCDOD6Xyq8=;
	b=V4wDati0cTd3kX5sMPsw3op3tmBPD0gd4A6IfmxwLfYgxXcXdJx89HZu5LWLlBs0Ps1Tr0
	5uExXAQbYeULw1ta3bFLyJDqOlAareV/IpqtUu1IhNRgb/I4NVnINKIhDKLEiF4o7fYn1+
	vlySgvoppTd5TWK78f9zWAqwIYx3iiA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-g9dfAIIaOw6FkGoWECmTlA-1; Thu, 11 Jun 2026 06:11:28 -0400
X-MC-Unique: g9dfAIIaOw6FkGoWECmTlA-1
X-Mimecast-MFC-AGG-ID: g9dfAIIaOw6FkGoWECmTlA_1781172687
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef55779d1so4930069f8f.0
        for <linux-hyperv@vger.kernel.org>; Thu, 11 Jun 2026 03:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781172687; x=1781777487; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8J03CxoywVvGkdqDT93IzLl+xZxTV2J8FpCDOD6Xyq8=;
        b=aUSRzXU9QGaPji1/m7+ubGAHyjvOG+cgcCuYdukcDW3oA/SA0WNQNZOwPoZbL+qVUh
         6pYQi7GBoOXMx1VbafPxYNybbDG1qfs+8envw+5udPKDaNq/DhwV/fXqa8lMRgkCKh2k
         f7oL9yGzd9Aafzg+wP5TGSDL+AbTmgaQP+MMEakWYHBkPyzhqwKvsUPOkWSTgHU66XhA
         rurCOFr6ZtC7i+/POAS795ZYG2t8Rz9ASJXkk5b/r9//qynvC4lIYUNM2wy3YixFQq8q
         ZVvV6ny4Wp19+8Htbmd0+LN2xrOfUN01SZpjfX8u/dqLOnY0gXaFG9MmqdKXOVyqHtIk
         FELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172687; x=1781777487;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8J03CxoywVvGkdqDT93IzLl+xZxTV2J8FpCDOD6Xyq8=;
        b=dlJGK5EI9Rb8IlwGQ6US0g7unNXssLJORMMzp/yLs0Jl08bb8cnTTMNFidWizrnbbZ
         oVpt+ofXn/s9WgPI1a8j5uKP5EvQ1IrH/eNy0DibSyyZR3bjTIaxy+8g/i4QqEekbQMe
         l/nJteBpLZQ4c9Dc+rXcFKOaexAZ9+z+BzMTP2rZzyNOT+ATFd6B6Qv2l3N8A/aopqod
         5XkL03sXqfZY/h+/HwWjTc3BU56NuUHD2iW41vydqs98PBdosVb39LHwPB2oHx6i3JeL
         K0UYrkcqF9fn+LxHoFv5WCUspiywwmZ7O82veME5WyzQZM44AqlRjmkNfxeyH7hw/txg
         dTcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1dDLTfRgzEoi7trL5WgOgV3753K91hkaFU45rBNo6CSxF55ip04d+MUZ0Tpddswhlv8/9jy3VIFwu1QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMInWU6fSLbI5AEqP9XkdqIIJr9qEcwJfQxoD13lKvJtBK/z1j
	otYN/doRcG2sW6lduZ8otIbvK2jJLu8OWIR22UAeeJfW3gRc3T1mE6ETf7B6/9/++eLHft6ZifR
	Qzfc0lhWna2xPwv7MV+cxxyVPZDjkCXdyhw0CfuND0bgykHmWMLMFIapSlCxaDUtUag==
X-Gm-Gg: Acq92OGgYdxSJiiHQkmh3Tyip/a2LD2GR3npQw5scY3tUal50Nv3DNQOSPNEvfwydgQ
	PYrUlqQ8Ax8eBXAuFB/L2BSOm4NB8zJUPHqZ/NiVmUSpPD8KkPvNQM9BbMEUerpdf7WgF/PsbSw
	0AcuPv9mUetmIdS9BhdhEmz1vvgeyXYWiQnTpZrxQ2SbrZIQRPnmph0xto8MIfB9b95Je0xtXU6
	XPkxc0ZQFikPXeVe3zFPsGjKIHRJz7VJYy4mX2Uve8gruMseGLiOOCbqzlsGW3XHNJJnBUrOoZn
	dqhP23K5W63zvZJJxP3C3YYMxjLKlE8OHXNewNAnWRHRJJ24FxFuLfUUSEvn3s8glPbOA1mLqNM
	GM/EvVg7wnw2LkaiT1ik7Rgx7h2hFUUkuLG0yTmjP9Kq0zWfVxfawYsasYHkDqtrMazzck8BBM3
	E0z8u2CgTifD5PqJI=
X-Received: by 2002:a5d:524f:0:b0:460:3233:bee8 with SMTP id ffacd0b85a97d-460677b28camr2150196f8f.40.1781172687246;
        Thu, 11 Jun 2026 03:11:27 -0700 (PDT)
X-Received: by 2002:a5d:524f:0:b0:460:3233:bee8 with SMTP id ffacd0b85a97d-460677b28camr2150129f8f.40.1781172686816;
        Thu, 11 Jun 2026 03:11:26 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm63288157f8f.10.2026.06.11.03.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:11:26 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklkml@zohomail.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 stable@vger.kernel.org, Zack Rusin <zackr@vmware.com>
Subject: Re: [PATCH v5 02/15] drm/i915/display: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-3-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-3-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:11:25 +0200
Message-ID: <87v7bp5quq.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11601-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER(0.00)[javierm@redhat.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tzimmermann@suse.de,m:mripard@kernel.org,m:maarten.lankhorst@linux.intel.com,m:airlied@redhat.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:admin@kodeit.net,m:gargaditya08@proton.me,m:paul@crapouillou.net,m:jani.nikula@linux.intel.com,m:mhklkml@zohomail.com,m:zack.rusin@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:harry.wentland@amd.com,m:sunpeng.li@amd.com,m:siqueira@igalia.com,m:alexander.deucher@amd.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:tursulin@ursulin.net,m:dmitry.osipenko@collabora.com,m:gurchetansingh@chromium.org,m:olvaffe@gmail.com,m:dri-devel@lists.freedesktop.org,m:linux-hyperv@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:intel-xe@lists.freedesktop.org,m:linux-mips@vger.kernel.org,m:virtualization@lists.linux.dev,m:amd-gfx@lists.freedesktop.org,m:stable@vger.kernel.org,m:zackr@vmware.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,zohomail.com,broadcom.com,amd.com,igalia.com,intel.com,ursulin.net,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javierm@redhat.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email,ocarina.mail-host-address-is-not-set:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D47D670B96

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The mode-setting pipeline can disabled damage clippings for a commit
> by setting ignore_damage_clips in struct drm_plane_state. The commit
> will then do a full display update. Commit 35ed38d58257 ("drm: Allow
> drivers to indicate the damage helpers to ignore damage clips") introduced
> ignore_damage_clips to selectively ignore damage clipping in certain
> framebuffer changes.
>
> The i915 driver does not modify the flag, but DRM's damage iterator
> will soon rely on it. Calling drm_atomic_helper_check_plane_damage()
> right before drm_atomic_helper_damage_merged() guarantees that it
> has the correct state. The i915 driver does not do this elsewhere
> so far.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

Same comment here than for patch #1. I don't think this is a fix.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


