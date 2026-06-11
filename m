Return-Path: <linux-hyperv+bounces-11602-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EmXtN/+JKmoMsAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11602-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 12:12:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 764F4670BBD
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 12:12:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=jQH+Awhi;
	dkim=pass header.d=redhat.com header.s=google header.b=QR3XvazO;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11602-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11602-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDCA53004D32
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF6B23EA94;
	Thu, 11 Jun 2026 10:12:12 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DA13375CB
	for <linux-hyperv@vger.kernel.org>; Thu, 11 Jun 2026 10:12:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172732; cv=none; b=ltzxzNAcJ46D+MTn6S7qqZ39DmxGtjz815ZsqShjQfDHsBIvffRlxs9OxymDbyr6cS/OtivxNneA/34WBIJDXe7/9T/I+BjMwmE3dypZrycqC8ABCzURmJEknEAh/SDTnIPJgLzk3FfIxi/w8QPl2OtLsLN9d7amCrEk+hPaI2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172732; c=relaxed/simple;
	bh=0DTkubvoxHBUMHmj/JTP8y1M7mVG+8twCULO8Aq9NZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZsJMF1T3RQ/pcxgenJwmKiXiEuheUAQGxa5Jt/+4rKD7j0MNEtMTIAq9Aqvn/DwuNgTgVP44tQHbkdJ+lZChtTGdZroOYbo4fTeIpJhSri9eMT7yUeSSiGkV3ErY0N7aGN4DkT7+b/PTgr8OJeWXW+BlE3SMFuG2/oVfiV83f3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQH+Awhi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QR3XvazO; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781172730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0r9Bb05wU768Bts6kNipr0zjojivSJzgQogOHI5wH0=;
	b=jQH+AwhiNYfDNE+fpr4EyyfDzX+dLcde4fPwRfQtPkFv4U4Ir1NylXa63M2xY7sHY9Lsh0
	2QjNaTT2VebPP1X4WLmCuDf8Q08O5dzGXjc8KU7LN722trj0LbRBVADxg9kRbg8AOdBkGb
	FynE6i7WfrFwElLyvj9LvMXWaXI+0/g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-5-3LXCjNNLyOdTGGZ6h1zg-1; Thu, 11 Jun 2026 06:12:09 -0400
X-MC-Unique: 5-3LXCjNNLyOdTGGZ6h1zg-1
X-Mimecast-MFC-AGG-ID: 5-3LXCjNNLyOdTGGZ6h1zg_1781172728
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490c4f61a34so41269755e9.2
        for <linux-hyperv@vger.kernel.org>; Thu, 11 Jun 2026 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781172728; x=1781777528; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q0r9Bb05wU768Bts6kNipr0zjojivSJzgQogOHI5wH0=;
        b=QR3XvazOsjMUZk1ZXGzPlbIZJ65yiI1gk/o8VU5XSCgCZnJU8bl/twjoPQcdWbAdZX
         KdJ1vgB3WkGOxvyKlFmJzbxZtpUueoWp3eAMZRtTpz+PPmZoA9RbiKe5RdzGtJiUqnvS
         WVMqE+L/7wg+2Y3lczY7UNyXATbYk/0Zn/nfBSN/MwdTyAgfkHBq9bPh7QeAHhniaUQ/
         2NLUM/XdKhD+zdEqQlCdebSKp6IH3YdUT0fuLpL5IiNbG+dmC5429KH3FOX/v1951u1G
         8lP3yXir0mDlJOPir73L2UAUEoXWBLzqYyWcCyK0OvdEsrIa5MgaGkE8GANZORZtzRWY
         U15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172728; x=1781777528;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0r9Bb05wU768Bts6kNipr0zjojivSJzgQogOHI5wH0=;
        b=QjU/NYtdTINkY+MPI3BP/hOocec9h3H39huEBsPZZ0HfGfTSXKoxNwEHTmj6N5o9fh
         91mTirLhihl4HNfSC26lizi7CBe+AqaXZmGSJ9m02IDnpAzUug86EUD6wb8CJ233KQKH
         k1fQQhX2/ZVcxLKeW8+Si2kPFZJ36zK2FidlsWjxhiGiuvxd5oS0A4PmFEyBOouF7lfB
         DZm14bvr9d5dJsSJjMhSPoNmRCfGxkD6lc5EQ6wBTMI2fg2uoSxPu9R3sLTGtek4F6wd
         ppOZR6lxFTXUrHK0KPtyJymr896AjsSdGN8vlddtsuFE+WIGu9k3VWOKoS8TrntP+ayL
         Mqjg==
X-Forwarded-Encrypted: i=1; AFNElJ+CqHfDC1btZ57BZ+CatsmlJsqrnZyJYmpdK9K2FjP1FdCxpcSpmlP51kmOsXTe+0IFRfeNG2Fa8sAAvRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqu7gCIRYzmWv2NP9RqbHIFM+TemskCzh48T0iT2TWayKkf4b1
	1HSd+mIjkDg2uvLvChVDPxY+mbYHKs4YQ3X84fRMx8pRiO+4oh0O9u6fPeazLK8YxgD7zM6PKP6
	Yz75ErArVBWFVWFmUc9oyFbvqYrolcbhHcx43UiNHKNUz4OJXk+YjMWBktxWDy5MJNw==
X-Gm-Gg: Acq92OEC0ZpCxTVVctYKzlIfBl5GXk2b5pvZWeBSjEM8oqKA+XSqBhmkABG/H3QxZiR
	zRN2eg9vWFXR66jl1inkfjXmZE/A3fvIG30BE/b0vHhA0vTGAsZWEKRk3RSyFFck8Yie31uwTOf
	OofTF3yxnHA/66D7Y3EFCFUnV6/Gpmb5NXr73csytnCizJtJ9jN3O3+Vh8q7py0J5pFj980udmY
	aF14nhdtjXz8wnbBBZYLfyAKPWNPD2qvCZW8puv/NGuH/7SnTII8DCj0ug87oXfXUgobbnM6kj7
	PUgL3RMn+rYXZWcSLjls1+gVpuqZgX4QC3wrfn4UvjOErML9TsiHLOZw7euLKj/MnSR27XVUAcN
	ZUnnFfaNj7XCR9XedDl8CevST2mC6C1Tq8zU+Q8F0dEopfjbkOHY8ujE9Mf2n1nbmdlhWgEalIq
	j95I8GVD2fZsGuahA=
X-Received: by 2002:a05:600c:a39b:b0:490:c08b:b24b with SMTP id 5b1f17b1804b1-490e5607e3cmr15876015e9.26.1781172728108;
        Thu, 11 Jun 2026 03:12:08 -0700 (PDT)
X-Received: by 2002:a05:600c:a39b:b0:490:c08b:b24b with SMTP id 5b1f17b1804b1-490e5607e3cmr15875655e9.26.1781172727683;
        Thu, 11 Jun 2026 03:12:07 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2d09a85sm51975965e9.14.2026.06.11.03.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:12:07 -0700 (PDT)
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
 Zack Rusin <zackr@vmware.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 03/15] drm/vboxvideo: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-4-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-4-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:12:06 +0200
Message-ID: <87se6t5qtl.fsf@ocarina.mail-host-address-is-not-set>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11602-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER(0.00)[javierm@redhat.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tzimmermann@suse.de,m:mripard@kernel.org,m:maarten.lankhorst@linux.intel.com,m:airlied@redhat.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:admin@kodeit.net,m:gargaditya08@proton.me,m:paul@crapouillou.net,m:jani.nikula@linux.intel.com,m:mhklkml@zohomail.com,m:zack.rusin@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:harry.wentland@amd.com,m:sunpeng.li@amd.com,m:siqueira@igalia.com,m:alexander.deucher@amd.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:tursulin@ursulin.net,m:dmitry.osipenko@collabora.com,m:gurchetansingh@chromium.org,m:olvaffe@gmail.com,m:dri-devel@lists.freedesktop.org,m:linux-hyperv@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:intel-xe@lists.freedesktop.org,m:linux-mips@vger.kernel.org,m:virtualization@lists.linux.dev,m:amd-gfx@lists.freedesktop.org,m:zackr@vmware.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ocarina.mail-host-address-is-not-set:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 764F4670BBD

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The mode-setting pipeline can disabled damage clippings for a commit
> by setting ignore_damage_clips in struct drm_plane_state. The commit
> will then do a full display update.
>
> Test the flag in the primary plane's atomic_update and do a full update
> if it has been set.
>
> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
> to ignore damage clips") introduced ignore_damage_clips to selectively
> ignore damage clipping in certain framebuffer changes. Vboxvideo does not
> do that, but DRM's damage iterator will soon rely on the flag. Therefore
> supporting it here as well make sense for consistency.
>
> While at it, also replace uint32_t with the preferred u32.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

And for this one as well.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


