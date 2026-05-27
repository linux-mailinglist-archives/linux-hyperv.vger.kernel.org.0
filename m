Return-Path: <linux-hyperv+bounces-11250-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOyXMW0cF2rw5AcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11250-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 18:31:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E355E7CA3
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 18:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C986A302AB0A
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 16:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03ED37D107;
	Wed, 27 May 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pdi/capn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15913C455B
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899496; cv=pass; b=WTFvHhnlN58y8uepRAOlBplzANrVXb1Rf5UwPePnOisFG7gBWk21MPXZNhsnXIsxnSdrhREmb2kIDO1a/TuNV8+m8Tfd/9Fg2VH1UrPjRZDDdlRULIetNfDd5T8yiQc7Ro4QlFAroBLtkV45t+sD1NDzCf34DsS20FqrW34BgwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899496; c=relaxed/simple;
	bh=41fjdWeo1ypd6ycqKoTySWJowPiFRaJs4jlzo281OZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1ND/Hg6CTbufGEeWcqKDh1OybvVkskPhxzbYkpw0nhTfVxY0zrFeXv8ocnAgBiTTecvo3Ku62Xi8RF8bnl3fp+gdz8my+AhQfF4djHf6NB4UEEmXRMe2qrlJf56doK/sn/1s6vEGH6KCKvKVMeoJHvP86zug+kKBIIrcKoBYkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pdi/capn; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65eb226b1ceso6276810d50.0
        for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 09:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779899492; cv=none;
        d=google.com; s=arc-20240605;
        b=CZYtyspjHTsWAdho1wlWoyvBHMzJ3XzAl0HBfkcKOgbRMX7rljxi0pTqAE1Yh/XveW
         yKKLftC6foJH5nAsEAyhNwr/HbFJuDjAs1r+xfdAO803/mw/5TJIGm4YFiYz6EdhI6JX
         9BrV0/JYoY5Cz5d0OlnnD2cJd5hhCsoGrgqVvAiTLDajyDE1D184OS9eP5oUyZpkrDRg
         TJrc6/CM6xZ/lPFIIsMJu7ZXJG5tGVVVJk8iH7UHH5msSt5doQoZB2ZRfqig8SFAic/F
         RO4PgAC0QF3SeYrPDh20rWWnJEEMX73Oe+B2IuDTHZGS6zEFHQL9fm0qEaysWbAPSxqI
         uBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9tLf8lt1YoAuBidXkoX7o9PfBwuIjJNOIKz1xekd6O8=;
        fh=o3ufkGVSKvYXbCCqZDL0L7HdvxhP6vlJ1z1kdkdxVjQ=;
        b=TXhUOodwj9E5F3cv/qaWnQWR9pt2AachUB2FTb2d9NPXSCReeTAKxCQrSKPmJbFwOA
         eqoh2G4FF7vBYMCf+bGNQS1IMZ1rvOPhWvypJI7NpXccWThp8ih5qrIkR8T9mt2pjgqF
         UTkM+Y/BLwQZ+rwRtRTZq2+/gjesOoGecuyvxmhE8rQHM2Tniy9TwUeAdnGwPt7g+wJO
         K3Rg6/knMmEqDy1hVGH+ZmgUdGeeW/QR8ix91Gz/4LZ8ChSCw/xL8c1/layofg4D+V73
         VbooDkAd9wMiuppTIKr43wBZdqje1EZPmX05/u/Eygqye/coPz/wfzGVQoYoZNGTeJ2b
         AeyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779899492; x=1780504292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tLf8lt1YoAuBidXkoX7o9PfBwuIjJNOIKz1xekd6O8=;
        b=Pdi/capnr64OG11hd9axHgYNn4plUPjBPZgYhtzEPNlEtUNTt1KUgj6Ol4Equ+hQPy
         sfRK0E9mBOMiQVWZ422gWXKNhqwFtnLeEIVMlqtuMziHp5ua9+gfJfF2kjPQLhG8PsPN
         OAqJTLOwhyqCkS3TNTvt/BQb9fS/FU1ymCocbOKguJlIIEv9klutjue2R3hCCul4ng+0
         CaxZZapo4SEkVwvf+KpzBrr5+4WOPkgVFnsmpHxg+jvN5wcQx6UjA7qqJ0GOtjFxeivX
         cgtYK1oAQk58J4+6BL3E8sJraZhySDvDXfUpI+dQYN2s+NSH3gSoEmfS11TKEthLCv8k
         lC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779899492; x=1780504292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9tLf8lt1YoAuBidXkoX7o9PfBwuIjJNOIKz1xekd6O8=;
        b=pmoml3yjIsmreDEM52qeDOnA51Wmg1e8pB3IEi1QxfL7v62VPimEJPUO+JbGTq23TQ
         fUQM4+6RSPSwFe7ABDtzQ6uisRKBFIArULb0igMoMt0U7KeCjfzDbpwdQ6Lar5+U4xDC
         naLL5IrFyF5kbMzp1iB23izOvfUN7b18qT7WR7DDwtCGXXLP451QQbRKqwaWUerA2PbK
         up/1laoicYhNfYZtjK3MT2a/qFLRbM/80gE6ASWMkQ07AgkULXKrTrEAGcq2HqxlLmcp
         X65zkLXFFiTV4Sskr2A6f3wAjWvo0maUkYkCQaz1U2FziuxOidfiSmeB2PcKdsuM46Ra
         HhnA==
X-Forwarded-Encrypted: i=1; AFNElJ+zmtEQLmSIlvu0eYTsajSTX0LEo8BXsdtMCgjL5vvxoV85ZB6K2Sexn+6KsrvHNh2gSEK3G5BibQRH+f4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo1BmZSw7EnLn3At38BgFId3zBo8N/zN5R9ec844eoK9T5wqL5
	zQW/XuZmNvFX0vLgjBgDY3CEaGu/LA4PhijsDtIKIZVwfrMj5iZuwhmmnbQLSsj5gBLo3vzHt69
	7kndUb8OkvU7S5k3w/M7Ygbk0pvopgy0=
X-Gm-Gg: Acq92OExoCTQr6NnNiKOQ6oPXS/7KN/nzb/YYQrnVrhXULaLeePPICJQ5gKiBhx92x7
	Tk974zkp73UVtsY+S6Hs+g0GrfEmlPAJNiCYHmK3hVyeym7rj3AMjg2AopdG0iYZZMBTSRO3k+R
	ufgo8/ahaqaRyLw5j460fRu4drSmEN5RSRz6+W8e1KjHxAQV9+b+y8L5XUsQVCs//6Z9ggGBqjX
	l3Vq4hFw2R7naPgyTjJrDwk/uzfdwLPaBJFTlKkmeueJaX874iHjhUnAe3OH0Brvmn8cLjD/Ekk
	iAvvCTlAAyTGx/w0KUctdDZp5HZtDX8+4x+Q040KOBdEZEUnLRevrWPF+g9UlStHdRTvh3tK
X-Received: by 2002:a05:690e:158f:10b0:65e:14b6:b1c3 with SMTP id
 956f58d0204a3-65ec965c9f8mr17896814d50.16.1779899491716; Wed, 27 May 2026
 09:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527133917.207150-1-tzimmermann@suse.de>
In-Reply-To: <20260527133917.207150-1-tzimmermann@suse.de>
From: Julian Orth <ju.orth@gmail.com>
Date: Wed, 27 May 2026 18:31:22 +0200
X-Gm-Features: AVHnY4LiGKeklklqrya8rDzPqcZQqpOuXv9liIo0k9FzrL8MbPYNMzvo_QUUG_E
Message-ID: <CAHijbEVZBRTK7yhZy8gaZwb19JMzUD_nA2S1LOKX2NrK19RBsQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] drm: Limit DRM_IOCTL_WAIT_VBLANK to vblank interrupts
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, airlied@gmail.com, mdaenzer@redhat.com, 
	pekka.paalanen@collabora.com, jadahl@gmail.com, contact@emersion.fr, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, mhklinux@outlook.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	wayland-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11250-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,redhat.com,collabora.com,emersion.fr,linux.intel.com,kernel.org,outlook.com,lists.freedesktop.org,vger.kernel.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juorth@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,people.freedesktop.org:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 60E355E7CA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 3:39=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> DRM's WAIT_VBLANK ioctl synchronizes user-space clients to display
> refresh. This is meaningless with vblank timers, which run unrelated
> to the hardware's vblank.
>
> Disable the ioctl for simulated vblanks. Set DRM_VBLANK_FLAG_SIMULATED
> for CRTCs with simulated vblank events in all such drivers. The vblank
> timers of these devices still rate-limit the number of page-flip events
> to match the display refresh.
>
> According to maintainers, user-space compositors do not require the ioctl
> for rate-limitting display output. Weston, Kwin and Mutter rely on comple=
tion
> events. Mutter optionally uses the WAIT_VBLANK ioctl only to optimize the
> time from input to output.
>
> When testing with mutter and weston, the page-flip rate appears correct
> with the patch set applied.

To avoid this being a regression, you need to test that this change
does not regress input latency.

As discussed on IRC, compositors use vblank data to predict the time
of the next flip event. For each device that you are touching here,
there are two possibilities:

- The vblank data is related to the flip timing, i.e. flip events and
vblank events are sent at almost the same time. In this case removing
these apis removes the path for compositors to predict the time of the
next flip event. Input latency will therefore regress after idle
periods when the compositor no longer has the time of the last vblank.

- The vblank data has nothing to do with the time of the next flip
event. In this case this series could in fact improve latency because
it removes the incorrect data from the compositor.

Whether the times of the flip events correspond to hardware timings is
not relevant. Everything in wayland compositors is scheduled against
flip event timings and they are also forwarded to clients for their
frame scheduling. If the flip timings are wrong/out of sync with the
hardware, then removing the vblank apis does not improve this
situation.

>
> This change has been discussed at length on IRC recently.
>
> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highl=
ight_names=3D&date=3D2026-05-08&show_html=3Dtrue
> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highl=
ight_names=3D&date=3D2026-05-12&show_html=3Dtrue
> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highl=
ight_names=3D&date=3D2026-05-13&show_html=3Dtrue
> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highl=
ight_names=3D&date=3D2026-05-15&show_html=3Dtrue
>
> v2:
> - add filter to CRTC_GET_SEQUENCE and CRTC_QUEUE_SEQUENCE ioctls (Michel)
> - clarify Mutter's behavior in cover letter (Michel)
>
> Thomas Zimmermann (9):
>   drm/vblank: Add drmm_vblank_init() to indicate managed cleanup
>   drm/vblank: Add DRM_VBLANK_FLAG_SIMULATED
>   drm/amdgpu: vkms: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/bochs: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/cirrus: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/hypervdrm: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/qxl: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/virtgpu: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/vkms: Set DRM_VBLANK_FLAG_SIMULATED
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c    |  3 ++-
>  drivers/gpu/drm/drm_vblank.c                | 26 +++++++++++++++------
>  drivers/gpu/drm/drm_vblank_helper.c         |  2 +-
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |  2 +-
>  drivers/gpu/drm/qxl/qxl_display.c           |  2 +-
>  drivers/gpu/drm/tiny/bochs.c                |  2 +-
>  drivers/gpu/drm/tiny/cirrus-qemu.c          |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_display.c    |  2 +-
>  drivers/gpu/drm/vkms/vkms_drv.c             |  4 ++--
>  include/drm/drm_crtc.h                      |  2 +-
>  include/drm/drm_device.h                    |  2 +-
>  include/drm/drm_vblank.h                    | 15 +++++++++++-
>  12 files changed, 45 insertions(+), 19 deletions(-)
>
>
> base-commit: 5fb5a9a63cf5ece68e0eeb6fa397da27712bccf0
> --
> 2.54.0
>

