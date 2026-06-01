Return-Path: <linux-hyperv+bounces-11421-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCQ4CCxiHWojZwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11421-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:42:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC6661DBE7
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 12:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF4AB300E384
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 10:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D403A395AF1;
	Mon,  1 Jun 2026 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1BzJoW1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMk9x/UF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B412395ACA
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Jun 2026 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309206; cv=none; b=qDd4y8XvLY3dZM6h2/rB8QMO/9CfLtAtdaT9cW1YeioJHcThF/itNXJWQzQSl4eUK4mpwbpBKUPb4owlv+ApSttLhu0KrCIYvcY+xVKkXzxJIMIuO94Hq2+/nexGBVQESdv3H4Borxo0aY0dVa+hTlv0NCMmiXp/7cnKg0Rrjmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309206; c=relaxed/simple;
	bh=o3mo65fLt7N33RYK+WAo3bfYLXxMeZQmBkFurOPJA88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S4ghs+Lc2toSy8SOWozRqxKp5lOJXJiadWHMo3DbO+7OilZRdJdxAc1Tf/o65Y8u7qSVrBTJO76vA0t0LiumONMvBo1eMrHYiLem04AzWN9Ub5YjZCJvBKbp/GQRsmIbb979+TL2AFsXGYgiEQWH42vcnCAvI/CohzkatRcuM4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1BzJoW1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMk9x/UF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2pmaS/rwYkc2+fCZTYV9toIp0r3BjOevXJeqgzIBH1c=;
	b=D1BzJoW1QrTNa3quIfK/fBkzaVAKXEqGng7o8JtD8uwbTghyYEfzOqt4NCEY3wlg0SxLOU
	urb7yuOay8RQbrdPBHW+Kv/D3XF2ajhLW6+1BwfUJuJbwtWho3ofmJ/9xre43uPV11R/ln
	cRw1taIAEVtfEeB2cEreHBf8bHp2rKs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-b601HZJ0Ot-iwoXXAuz-Fg-1; Mon, 01 Jun 2026 06:20:01 -0400
X-MC-Unique: b601HZJ0Ot-iwoXXAuz-Fg-1
X-Mimecast-MFC-AGG-ID: b601HZJ0Ot-iwoXXAuz-Fg_1780309200
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46010392f89so642760f8f.2
        for <linux-hyperv@vger.kernel.org>; Mon, 01 Jun 2026 03:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780309200; x=1780914000; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2pmaS/rwYkc2+fCZTYV9toIp0r3BjOevXJeqgzIBH1c=;
        b=JMk9x/UFKQA/JjOLg5On7IKKCgCIODENVsCCJjDnyJwnjxiFxSzzRqyLJerVm7w1ec
         nhf+a9/gjQ06VMkg/1Ct+zVhqjcas7NW0cW00F4XPbJlrEwv9V4KdujzdzLattoWl2ek
         Wz4ExHn0lpwWIw2NVraca2yJJwxvZdGMu+aB93bnh6X2E4aCZKKlUdn6hv1ckIAHabWd
         /0cNiUuopymjdV4OOo0zgUpuaYUduO5LLq12lbgtqXw24KS5P0PsC0yWz1qp9WNhj6wJ
         6pR2mGeAWgD51+CUntfsh37QmMCnxRKxQ4gb9LXx+r8qX/KX1+0KmeMVv5LPZO4Z6bAt
         FtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309200; x=1780914000;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pmaS/rwYkc2+fCZTYV9toIp0r3BjOevXJeqgzIBH1c=;
        b=iTBz8YvEXhgulpx9xmVxqbrzgzViBAqNmm2VF6j55Qz1epgFe1ET6SSLDaxYDDeydW
         7tzP9zmFf/44mP08KFpgRPzsL13l3XklhIIIBfI6Igh1BQVBbIBMjPNlKssoiZ3bdulx
         7cO0aVNV+hIL4Qgbr5u5cu1q8p1uncZUDFis6x5eFw3ljsLtMCM2xJuxblBJhz65FX6R
         wNy0K8ULkfn+v4hydi4Dv3cYWaAL0bwTjTs2v8sTaZUDPSkkyY8+YcNQbsqVcVPMcePV
         6qnblQDPvicHMO1tYswLB3HFprHQb9aSRUocjgoIkAMQkpc8SuGmX3bE2R24Fd5TkF+V
         2KXw==
X-Forwarded-Encrypted: i=1; AFNElJ/5/+Qgg42KIBHF9a3hiMhF7hgvbfmYmx5sjhNtk1Exipn5iljlRY92jt3Ytk+XTurLryhSt1pfsjGhZY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjgD7ztQsOmSBwhCv2OJNNok6Ciw/dxeVdQTOeDSMNujEy+HoI
	+lG+AwQc5VCZOowAL9Pqiz8os8f4+F079mkKkvgsYAa5RzWw7ckIJyb6cfX5FeqSK1aujWqTOBL
	SZTMna6BVvivn95vB2kuWOUQUdRuk1Q+IVXzHglNHG16nr8OKkijQe2Ss6K5H15up4g==
X-Gm-Gg: Acq92OGJFcoM53kcd4LqRjD4tg/EuHq/aeTINA+Vta8byyAO4pa5py6knxKwG+49RPc
	lI4nQDNTQZ2TNaMphr0ch19oc980OdrzK5eZEJnWnhv7jqaz75DHk3wLdqZBB29gVNWQs2XLdZ8
	4r3gnxZHJ3Ey67pI7sWzYWpcXUJ57E6w2Z+As+43/ZCjTHjzfKflzX6t0RY8w6zITk5XUDGGTLI
	LKk4ftEjSZthSKEevBkSoultAz6MUJWs8W6JEY+ZseO6TxpXuKlgeL43Nwt6yv7YphbpYwzLnxI
	xBvSq6goBAQutGGeuNjAhgzjI5Fv9+AT7j7xxVwvMjrqemgtSbz7X98R1mMv9lhADCiCX0VC+Lc
	/XLFeOASby0T7iqmimP2Lutl0Q1UP5xX9jCNsiyOvCgxnVIfUM+0CmnNIjlpwPkM9PF1vI/g0Ak
	8Sb0vwppY6YEMdXdY=
X-Received: by 2002:a05:6000:2581:b0:45e:f8d0:d22c with SMTP id ffacd0b85a97d-45ef8d0d485mr18400676f8f.25.1780309199700;
        Mon, 01 Jun 2026 03:19:59 -0700 (PDT)
X-Received: by 2002:a05:6000:2581:b0:45e:f8d0:d22c with SMTP id ffacd0b85a97d-45ef8d0d485mr18400611f8f.25.1780309199267;
        Mon, 01 Jun 2026 03:19:59 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cf0dsm24570236f8f.17.2026.06.01.03.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:19:58 -0700 (PDT)
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
Subject: Re: [PATCH v4 02/10] drm/atomic-helpers: Evaluate plane damage
 after atomic_check
In-Reply-To: <20260530185716.65688-3-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-3-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:19:57 +0200
Message-ID: <87v7c2lfzm.fsf@ocarina.mail-host-address-is-not-set>
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
	TAGGED_FROM(0.00)[bounces-11421-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ocarina.mail-host-address-is-not-set:mid,suse.de:email,broadcom.com:email]
X-Rspamd-Queue-Id: 7AC6661DBE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Each plane's and CRTC's atomic_check might trigger a full modeset. As
> this affects the plane's damage handling, evaluate damage clips after
> running the atomic_check helpers.
>
> Examples can be found in a number of drivers, such as ast, gud, ingenic,
> mgag200 or vmwgfx, which all set mode_changed in the CRTC state to true.
> Ingenic even re-evaluates damage information in its plane's atomic_check.
> Doing this after the atomic_check helpers ran benefits all drivers.
>
> There's already a damage evaluation before the calls to atomic_check.
> With a few fixes to drivers, this can be removed.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 51f39edc31ed..4c37299e8ccb 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1065,6 +1065,10 @@ drm_atomic_helper_check_planes(struct drm_device *dev,
>  		}
>  	}
>  
> +	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
> +		drm_atomic_helper_check_plane_damage(state, new_plane_state);
> +	}
> +

I wonder if it's worth to mention this in the drm_atomic_helper_check_planes()
function kernel-doc comment. But regardless, the change makes sense to me:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


