Return-Path: <linux-hyperv+bounces-11420-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFkWNJFhHWojZwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11420-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:40:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A6D61DB16
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F05F304F2E3
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 10:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD5B395AD8;
	Mon,  1 Jun 2026 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bG97OOPA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qYqFzf19"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD24395ADC
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Jun 2026 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780308969; cv=none; b=pn8mRzPf5pZ8ahEKpsjSGvrnoe+MwEi09Cs3u/cyANtJ499Q+QJtrQK7pvf15IQa+EJcpfF2WXMZDASCu5aDLheMdKISvXmoc74dobx8cL2NP2Z+ZO4goQHGzeSosDlroJXZFeGrbT6ACTAkadCyTjk/eR99VUy6Q6x08m6VNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780308969; c=relaxed/simple;
	bh=//fpv6KtnZGPacElQOdywvJfvUtWfzycEBrOQGiMPzk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lag2h8w6m5LuI/5KJs8SZPcr0LacO+jYJSaLvctPXOxL/oTB3CIxP5bneD65Zi4HJAyZOcZo1P+xlSR1msuhoHFbX2gmwGPWeWV1IQRp9QZ1uO5BhFDbNIIJVMq2xMJr7tnqfcP04bGE0GGqmayCO6zAx+XZ43VdzetyLFAXs54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bG97OOPA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qYqFzf19; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780308964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ec/J4tNvrAMdwkOq5RTOf80WrT+IRWDMG7cFT7/0gaw=;
	b=bG97OOPAoHu9sfEqhiUz+D42kqucPKFn4+sshDR/VXpNGLmDVaTEgP2R54uiN2L3HHo2zO
	jzvjYnrPIG4a3Jzhet9bvw/ibed2K84i6Ofv5Wc+4N19MY+Z1W2OQ3QyccwWNqWYrsA6Y5
	yHQkjhDV+Vc7NUW2GqIz90nagSVmSFw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-EVn8R7RfOxaSH_eL7r0mKg-1; Mon, 01 Jun 2026 06:16:03 -0400
X-MC-Unique: EVn8R7RfOxaSH_eL7r0mKg-1
X-Mimecast-MFC-AGG-ID: EVn8R7RfOxaSH_eL7r0mKg_1780308962
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45eed49ee63so2755140f8f.3
        for <linux-hyperv@vger.kernel.org>; Mon, 01 Jun 2026 03:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780308962; x=1780913762; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec/J4tNvrAMdwkOq5RTOf80WrT+IRWDMG7cFT7/0gaw=;
        b=qYqFzf198t5SPjnGYTxm2tKTCvzMBJI2CCWRPxD/dU3kRMjYnN/ed9VLpQGypAl5Ho
         i4eXAZE4oKfy/iOKRi8EoCjlTsPIDbf5+pOdP20Y5kgylUZBD40govnhIm5EQ6N4NrRa
         Wb7OYlj/DVytwIL5+uMkcU53JMnU4adtZ0FoZdDJUaBdJbrmIVU88xJOFhtNky9FwnXK
         /gvlEUJD4nRuaNkhon5QjDtGDIt0eitUjXr+cL51lm7cO8v0wjNLpwj3Fo6kW3mVzKcs
         +clN1HG6CImY9UL1mRmZsfVXzWrMXt88sCM0SE1UvBMbKKGn66gbqD1R7hVWmCBSRn4t
         Pm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780308962; x=1780913762;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ec/J4tNvrAMdwkOq5RTOf80WrT+IRWDMG7cFT7/0gaw=;
        b=pYJ7CJYTu8aC6B2FfvVWAF7kuaiEL1BhLTzHJL3SmevMcmPNF7BWR0YDiW4T44ynkB
         fpN8fZXOGsalHzYcEK9rKNqldurCDUo7L0L2KYvF36TuOU1ZBx3+KFakIRUqRkVOaXaU
         EBKSG2CMjJAdWTVA+5mXL0/h5sOkP8XqHlK94Q7v1BwdZsxSTENbVABQAcpbqfuOe0TQ
         yUVAII16sjMav3wx+l9kxEPLWOBXI8zdy+pFGsXpQ2ojUjky4kGB1ddozHhwYBmBn3GG
         rQIqkKNjRAYenyahk4DV0VaXOvZIRFcZ9JDo/+FDI6F8gAIamDuLGUAcyC0FYQtMqPij
         GvkA==
X-Forwarded-Encrypted: i=1; AFNElJ+scdenwDjIWLjkNAU/aEPAHzbjfNPAKonBrA1/t18vBGNPuQOYx7gXs4UGD1Ud8vRaiI5KerIgZ7LkR9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzevahAyQRd+yVgigV4bIFNQ46SNZQL+v/L3j9B5kJ9VUIPEX7k
	dvU4sFO9V4jMRopJChvK6yQSu1VepokmuESmPO+8sn9HXMyvtXyblzs7rL8m6RgQoRvYbxGr70g
	5nSn66YdqiC+obdMRBx/ZdT6Kr89E82BRe5yVPCns/mw1BekRupP0OOlA3xmpYXmWvQ==
X-Gm-Gg: Acq92OGTf2j/PLaOceSlkvPfLUiLlVFteEOUxxd5fsl2pdosgyOvXbctAKkF3J2vRPh
	ehce940AqrxsVkAVEqyfzJTNWm2fW1O4QiVt3dEJc8fbedpybESQT5Pt67YYlsNpUyOs244K8Z6
	eAsnthwtfs7bdCfOc8CbrWtArskDgH+Z47SI5ObI/su4+PhtcywbvMP6vKSG4Z+fwOL+95rGZth
	eeuLvwWqP9uFg+fCtDCvR2my2WNeZtQ5U0ErYpvPBu2BJZRRDdUGwBt0MRgi/1uQ8iZGkzfmmVq
	MCiSYk6inYRAHC31reXliAZGabsUe2PhF8m1jyuUMMQWYEAGPQFgwxKR6RcIfdNTrhI57Clky4D
	BL20QrzJUjmeGSHAaFAGdV0UyOJp6bWrbgBP5x4C6ByOJSPBaVyYKh6QESQDHZp7Ow2Ht0i37Ne
	dAJ3l2nE88zfSDFug=
X-Received: by 2002:a05:600c:1c06:b0:490:a298:3859 with SMTP id 5b1f17b1804b1-490a29838b6mr211911545e9.24.1780308962209;
        Mon, 01 Jun 2026 03:16:02 -0700 (PDT)
X-Received: by 2002:a05:600c:1c06:b0:490:a298:3859 with SMTP id 5b1f17b1804b1-490a29838b6mr211910935e9.24.1780308961705;
        Mon, 01 Jun 2026 03:16:01 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef32fabcasm23621879f8f.0.2026.06.01.03.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:16:01 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklinux@outlook.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v4 01/10] drm/damage-helper: Do not alter damage clips
 on modeset, but ignore them
In-Reply-To: <20260530185716.65688-2-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-2-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:16:00 +0200
Message-ID: <87y0gylg67.fsf@ocarina.mail-host-address-is-not-set>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11420-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,outlook.com,broadcom.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,ocarina.mail-host-address-is-not-set:mid,broadcom.com:email,lists.freedesktop.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 78A6D61DB16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> User space supplies rectangles for damage clipping in a plane property.
> For full mode sets, drivers still require a full plane update. In this
> case, leave the information as-is and set the ignore_damage_clips flag
> instead. The damage iterator will later ignore any damage information.
>
> Also fixes a bug where ignore_damage_clips was not cleared across plane-
> state duplications.
>
> Leaving the damage information as-is might be helpful to drivers that
> benefit from this information even on full modesets (e.g., for cache
> management). It will also help with consolidating the damage-handling
> logic.
>
> Also add a new unit test that evaluates the ignore_damage_clips flag. It
> sets two damage clips plus the flag and tests if the reported damage
> covers the entire framebuffer.
>
> v4:
> - slightly reword the commit description
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.10+
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c     |  1 +
>  drivers/gpu/drm/drm_damage_helper.c           |  6 ++--
>  .../gpu/drm/tests/drm_damage_helper_test.c    | 28 +++++++++++++++++++
>  3 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index cc70508d4fdb..84d5231ccac1 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -359,6 +359,7 @@ void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
>  	state->fence = NULL;
>  	state->commit = NULL;
>  	state->fb_damage_clips = NULL;
> +	state->ignore_damage_clips = false;
>  	state->color_mgmt_changed = false;
>  }

I would split this as a separate patch since is the bug you are fixing for
commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to
ignore damage clips").

>  EXPORT_SYMBOL(__drm_atomic_helper_plane_duplicate_state);
> diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
> index 74a7f4252ecf..945fac8dc27b 100644
> --- a/drivers/gpu/drm/drm_damage_helper.c
> +++ b/drivers/gpu/drm/drm_damage_helper.c
> @@ -78,10 +78,8 @@ void drm_atomic_helper_check_plane_damage(struct drm_atomic_commit *state,
>  		if (WARN_ON(!crtc_state))
>  			return;
>  
> -		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
> -			drm_property_blob_put(plane_state->fb_damage_clips);
> -			plane_state->fb_damage_clips = NULL;
> -		}
> +		if (drm_atomic_crtc_needs_modeset(crtc_state))
> +			plane_state->ignore_damage_clips = true;
>  	}
>  }

This makes sense to me as well and I agree that re-using the flag for this
is better than making plane_state->fb_damage_clips == NULL the condition.

As mentioned though, I would make it a separate patch. Both changes look
good to me:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


