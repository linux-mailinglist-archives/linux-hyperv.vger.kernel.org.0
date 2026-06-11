Return-Path: <linux-hyperv+bounces-11603-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wLLOHjCKKmoisAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11603-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 12:13:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77834670BF5
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 12:13:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=S7nDLOGy;
	dkim=pass header.d=redhat.com header.s=google header.b=MXxR86fN;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11603-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11603-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87AB93008442
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 10:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ADA3CAA57;
	Thu, 11 Jun 2026 10:13:00 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83803CAE69
	for <linux-hyperv@vger.kernel.org>; Thu, 11 Jun 2026 10:12:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172780; cv=none; b=FhcAKEKTcD3CIrrAqdEsdeWpftFpi98ygKcysQyBBGx/3i8djFAB8GbYmYlM6AvohWEhplx/hcxBfCUwwMIEWb3FpXzskUSrPDSX9uwN1qQrsuXxEUmQ44IqaoUGj2IeSwQtwWz0DvRSHUU+1Mf8JF97p6SxQCgb3anNsDRhzpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172780; c=relaxed/simple;
	bh=JQ5T8Ove8mxcipFoyWUXvQY6lHTB2vT/asE++CDukY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ThMQRVZ/zJdVO+QYADDTKtHh3sZTp70z5RFjX2esDbb4SEfN/VA5PLvHsa8eCbTbE2D96h5eyyAbhdJa/K42l4ue3cZpD0K5mbggkAT/8UR87Gn+gTwi2WaN3/Rc0rQNvItXknIgV5E1/l8bqusC/9NYMFum/9hwq7fNxPGjbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7nDLOGy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXxR86fN; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781172778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dFYGrtWClhfZ3Q43+mH8yJXNZwovzAkM0JScXulojb8=;
	b=S7nDLOGyFPRaEikbcq3NQrD2tMAPNChi5RYfGHBS3lz1B8meEJU91c2/JttKS+z8+ymrry
	Nm72CUA5Gr88YE0hWg/wLdTH0VTAfwtsSiAQPM29ivIlZYAcIA5AT8/tQ/yPOYKHxcUBJ4
	2PLnnoeHtOirtNWhOAqfUOv7R9ZL+EM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-0Rj0U7IBPVqzspuvKnq11A-1; Thu, 11 Jun 2026 06:12:56 -0400
X-MC-Unique: 0Rj0U7IBPVqzspuvKnq11A-1
X-Mimecast-MFC-AGG-ID: 0Rj0U7IBPVqzspuvKnq11A_1781172776
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490bfd70b0fso78222535e9.0
        for <linux-hyperv@vger.kernel.org>; Thu, 11 Jun 2026 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781172775; x=1781777575; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dFYGrtWClhfZ3Q43+mH8yJXNZwovzAkM0JScXulojb8=;
        b=MXxR86fNpMK2OJliQ1xWyAYroB+y4pje2MzQ2LzDglJfeX9+gsikXoQmeyrFdzpRsb
         YEE/VR4MBldAruYqG+EdchGJ727Kfox2A+AgqT6XpMDo1hG+uQaL+6DUMOEAox3jv/Nn
         vHd5Dp72LumCHe6v7UHqD8WhymbA68gHwyYYBEbNyzeo23AAUIYxYDSZixmkjEXxkhhk
         JeCDMrvLi8p6+bAKDs+X3/upH7KmN7phxBGQydi/Rm9kTMiMZbe47aEfvg+f7sVSp7Ch
         cQaQBKOSKT8gHifd2WR0gd7BHj8a22rlxPHo5fFoKS0MONDKI2+RVyxLfDaRxyrvDjs8
         cqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172775; x=1781777575;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFYGrtWClhfZ3Q43+mH8yJXNZwovzAkM0JScXulojb8=;
        b=pL5oIr+A4izWJT6CmfM6Oy1hYjf1lEyGlaGO9RAwirmXplEYXWeiMsn+hDYvK18sY3
         OIKYbBZLrl08lxpj2Yk0hh8mWU8B6uGYrcgPMjXZxw2HQj6WOctdmkaf8GvUXK+H4RJr
         C0BEybLVTr0KDSpIclOQX0cmHPoAYvMytPGZ5Qs1o9DjrPTnFeEEgTq6Iameh5cq6vIk
         m7IyOATN5qMQBqPnDY4qDljzuR+gujj6gC/okXWM16C6gWGWEOYh0+j03gB98QPo1HLV
         qkLaYaom/+fBirDGLq+OABl3MyBRIH4a8095SXDR0rWGkMZBjz+7rcjfOOvdLuEGmAH6
         +qnA==
X-Forwarded-Encrypted: i=1; AFNElJ/cmEc/YeAMuPv5Q8rLda9AmEGQ0KQk1kdrB0NEpaTsGS6NQzkhMAKl96R1+cdUjjzamRNo6tdsFXEMweY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJE4xWapzSUBs7t+10YkMMHdxTxm94dORotxcZAl6UJipb7RpE
	3RI8RtHLZQBTWAF7juqQqP3cki5S53InhhIEe9eu6KJ45cuD/Pp00rRls9YZyTRxSL6A3iYuzWh
	H3zdxWA3ujCg5jO+YIWvmyQXArv2XCQdYqxauY69zZ6Pc7D7mz/DmChEQWgE+neLcxQ==
X-Gm-Gg: Acq92OEF2whuZfhtq/Nw+R3d7SWY4XrrA+fxu0j42BGiEzLWdmvYHj985XNfPI+1yiI
	9pKbZls9yEX0I2ry5m04r0/GIHWprTnl66ZzvaUHQJXK8SU662wF68ao6Gn445YyXTMG+SJY05+
	WVoAfww+Mz5RI9HBVljcymGoTD8Q+Nz8JWQJejLjWT77E8NW7xNbqyGR+ldWPend0meeHwAHVQR
	6r73gcnthI1DYJU1NhnkF1mRLo+jW1U4+i65a3jodcypDxn9A9XpyKae1iDIj5FgMEg+WQdL5lm
	b7WD5192u6VWyDn3CphwpteMF0OLqPB15MROO6Qv5FbswUuoviEPB8dDIG96HQivBamfGXfzwFz
	ASwqzfJWLTTEtBjVKqTAOuCk5xVbLYu4G9KOg1f1EKPpE+eHFrmfUwJClC/OLeWM6py0ur2Jw8i
	8mp/hzy0LtZUMa2ks=
X-Received: by 2002:a05:600c:c493:b0:490:a298:3859 with SMTP id 5b1f17b1804b1-490e5639bf0mr26218455e9.24.1781172775378;
        Thu, 11 Jun 2026 03:12:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:490:a298:3859 with SMTP id 5b1f17b1804b1-490e5639bf0mr26217975e9.24.1781172775016;
        Thu, 11 Jun 2026 03:12:55 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e532c778sm38051805e9.14.2026.06.11.03.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:12:54 -0700 (PDT)
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
Subject: Re: [PATCH v5 04/15] drm/vmwgfx: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-5-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-5-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:12:53 +0200
Message-ID: <87pl1x5qsa.fsf@ocarina.mail-host-address-is-not-set>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11603-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ocarina.mail-host-address-is-not-set:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77834670BF5

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The mode-setting pipeline can disabled damage clippings for a commit
> by setting ignore_damage_clips in struct drm_plane_state. The commit
> will then do a full display update.
>
> Test the flag in the primary ldu plane's atomic_update and do a full
> update if it has been set.
>
> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
> to ignore damage clips") introduced ignore_damage_clips to selectively
> ignore damage clipping in certain framebuffer changes. Vmwgfx does not
> do that, but DRM's damage iterator will soon rely on the flag. Therefore
> supporting it here as well make sense for consistency.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


