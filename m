Return-Path: <linux-hyperv+bounces-11308-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHSXJqYVGGrKbggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11308-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 12:15:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE455F0621
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 12:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A3883219BF9
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 10:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE77F303A37;
	Thu, 28 May 2026 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FesYG6J+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A327E792
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962473; cv=pass; b=IYZzmqLpipPyHTA8UvghfgdJyNySZOdE03Lhl5Hi/EGmlIjRQjPPnat+uKEv900jPGIbDDEp1Ji8QliSRwn4Yc6GDUf7SsEv7O5gYdZDmvX2V/URO0FGKIkeZEV4+uRw9+2i8Nwp7bIbrPblqiYecqylIqZ5WwCJzT8bsBy7WdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962473; c=relaxed/simple;
	bh=FzjUixVwJw0+1KE94lj+u5deezMCXP0d7xN7kG2mtOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXVjp1EEJJDVsNWL4jcutis4B4NUgWJLcDypsn3ET2O8zRgcXkGy+4kexrduELwd7EMJL72JpUvX/kZvDgai1uAz7IG+HQBH+YtegGF4IO4AVVW6ycX61RXPZ6f0uPHdSv2HOi/dHE5zZ8z3+cBA4TTGk0jfrI3Pls9Dwr/rpOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FesYG6J+; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65c1ba7eeb6so12456506d50.1
        for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 03:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779962471; cv=none;
        d=google.com; s=arc-20240605;
        b=NhVkB58RNHH+DM9fLpPEV5MNvs/XOa1PHxfC1L21wk+TvTA+8IuqR7FFc6ggi16hHv
         ymIYFyLGg9jUnplOrOSMBKvo9fCjwjK44TkCB3wSfqWKbgnFKcs3c28oWu7nA/hV2Yrp
         r5SlLIChyhb7GYffnnrYntyYZYUn0kNYsfceFdYv8pWfQx1wDs1lvnfgSgTt3Iqhr2s8
         GlG420Dh4K51XDeci2DDce1Cimb3wzFWUoWkjm6Cy/xDsVbUaSD11U0BcBflAlpMZ5K8
         9xHchXo5SKIBIzDs0cZWVoBQj94cn+ZWVFAuWzHoMgB3XWKIVggY+NGcZVzDhSTI08UI
         23CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ENaGop7hdOhRvlo9/v6zprcr5Co1+opC5qv3HonlvMs=;
        fh=imtzic9tMyE3Nfh55vX+Xqx9eGnR/wDJ59Qc2FSpKgM=;
        b=GzoAWexrf0vWc+CI2tzUyFkgwelTaPFZEQrtplm+OBiosxtjqdWJFgL2lSvq8+v404
         Y62vxywkaWhrHqV6g9F4vXd308QTWEVYxJOua22+rjdJjtUakCzCMt1q9B+g0JL+sGoD
         QDFWXPAq9vSr+WPdCQZ5o3m+fUWKRmgoK827HH6ATHUJMhxBiKMdF/NYVLCZ3ZEh9EEd
         xkzCrBfLjIca1Ezurgbj/n4768BYvHfa4He5L2Gnah8s/y1tUEB3wJF8Vi6jmaPsxjdV
         W7YkvajioCXshD2LxmlTQvAAvGmuCurYdBwWmzmJTutSVt3b8zEfMxwnwcJ4CzPmeQXV
         4wTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779962471; x=1780567271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENaGop7hdOhRvlo9/v6zprcr5Co1+opC5qv3HonlvMs=;
        b=FesYG6J+l7m+pHb7fyct4xBCLzmz1eWsnoX0b0TxMN1Za33P3X7rZGqwuFsboe69FF
         I5c8nU2oXUIsH/IBM08kFWRN7ONGe/Yb6KxUKGbfnwJaLAUQlKveWEqbqTR0as0K0HUo
         X1jEKKx/ls0osg2OqAEM6tHedcf60hb8KJb7+E2YkpW5zUEneqMYcua11tjN1/gBJ8IM
         XqgnbvpCd9MBSkj5qtZohAmfXeQB8HaYpzHpAZcgVa5P6XRcGh7m2hIb8WKmtZUe0Owq
         6lBJFMEO/2w9v4bALEnTpnRUbkJ/O9HTV0TyrIEAROtVoBgkp9Qjfjf/OgBj7PM2g2e2
         7loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779962471; x=1780567271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ENaGop7hdOhRvlo9/v6zprcr5Co1+opC5qv3HonlvMs=;
        b=eNlLNdpRauxqCIkTgDaXd5GrlD0h88KX0bevX7C+SzRj6XmafoxmuXaCKZoiuBaNlD
         dnyE4Q/8LS4b0bXF5pEjUOA90iyg0wPKGFuCmQcWJfXP+lks5ztCHpxLqmannKWIGzgR
         mD5/GQqTB5D3Gb+Kran/6r0vccKV8wsmijDHEwyKgZL0gFxODTZL/wq9xrgoB9RGStB3
         ySrKnBm2KYr662gIXGPZDNDg8sFQl98X0yA+3laKFbQoD0jQ6qDUQvL1Ffxu6QK3FUBq
         GkbStlbv1m/IdLldOkVMORPKMRFhB13GVS4K6E9cB8PLcLEKEqMuE55SeVAiA2l8obbk
         jxXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/39tljotY4XKhrdq46DZ3/SYj6qqLxZju9rBSMvUFA5SoPfxyUTeJg3ZJzB5Ksn2z047PqvT0BQ2AIfbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx04RbT4jqMXx+K7OyYRcD4kNcJuOUX3wyt735b/rS3E0znnaqu
	ay6fh8IyuLOTvqLwNjOsDI3VKu/X3YI9FjwbJpmLzAfdfk3Y0/p/Mjj5xlQYw+PzBvYqDdonQjT
	o1P5i4MdrhtK/7iEsyiC5y1YHlENA8NA=
X-Gm-Gg: Acq92OGCEHDBhM3cOLyRqWxu6gsTAy+ZUBAGwbsukSckyTmcpNhl+QquTrQzatmkTP9
	gGxskBK5GIJDgXhAP1VlsdlQTNgrRLHyCDVzgpfqWAcfuyVnlEbK7vH2hDS5SUTdW5Tyt06Xorc
	8pDu5BYLAL3/1MaKTd2KDaD6Qdq/0R6MKdjvq0QXYTPzLkZwRi5WV4kudm1RQxROCETITeNZ+fa
	EVTcoyMCfKuuZHMPsjibRwOOTpvnQDX9hrgJOj/0k6uyGB+5P9VG8NAfQJQTG0sCupAeoycY5eT
	jzZ0CGQJpAWlpwZo4HCK9vx60IokWsphPoNyaJdXGYQcHUzs5dgp+7OJ0ngOelklWhPfaxrDHdA
	O7PCR1g==
X-Received: by 2002:a05:690e:4090:b0:65e:421f:25a with SMTP id
 956f58d0204a3-65ec9938b9dmr23205364d50.53.1779962469261; Thu, 28 May 2026
 03:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527133917.207150-1-tzimmermann@suse.de> <CAHijbEVZBRTK7yhZy8gaZwb19JMzUD_nA2S1LOKX2NrK19RBsQ@mail.gmail.com>
 <1d399c2d-b50f-4d19-8170-9db8961e4227@suse.de>
In-Reply-To: <1d399c2d-b50f-4d19-8170-9db8961e4227@suse.de>
From: Julian Orth <ju.orth@gmail.com>
Date: Thu, 28 May 2026 12:01:01 +0200
X-Gm-Features: AVHnY4Kd6TXNqqh3i-IesxOIMTyuSSIzXsJX_ARE_lWWTyd_wM1yd783Bw12QD0
Message-ID: <CAHijbEUKpOuDLJES9AbSp8Pk+egeDPe7KPyBy1xBFM9ET9peCg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11308-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EAE455F0621
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 9:54=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 27.05.26 um 18:31 schrieb Julian Orth:
> > On Wed, May 27, 2026 at 3:39=E2=80=AFPM Thomas Zimmermann <tzimmermann@=
suse.de> wrote:
> >> DRM's WAIT_VBLANK ioctl synchronizes user-space clients to display
> >> refresh. This is meaningless with vblank timers, which run unrelated
> >> to the hardware's vblank.
> >>
> >> Disable the ioctl for simulated vblanks. Set DRM_VBLANK_FLAG_SIMULATED
> >> for CRTCs with simulated vblank events in all such drivers. The vblank
> >> timers of these devices still rate-limit the number of page-flip event=
s
> >> to match the display refresh.
> >>
> >> According to maintainers, user-space compositors do not require the io=
ctl
> >> for rate-limitting display output. Weston, Kwin and Mutter rely on com=
pletion
> >> events. Mutter optionally uses the WAIT_VBLANK ioctl only to optimize =
the
> >> time from input to output.
> >>
> >> When testing with mutter and weston, the page-flip rate appears correc=
t
> >> with the patch set applied.
> > To avoid this being a regression, you need to test that this change
> > does not regress input latency.
>
> Let me stress that the current situation is that there's high-quality,
> and low-quality and no timing information. Depends on the driver and
> hardware.
>
> >
> > As discussed on IRC, compositors use vblank data to predict the time
> > of the next flip event. For each device that you are touching here,
> > there are two possibilities:
> >
> > - The vblank data is related to the flip timing, i.e. flip events and
> > vblank events are sent at almost the same time. In this case removing
> > these apis removes the path for compositors to predict the time of the
> > next flip event. Input latency will therefore regress after idle
> > periods when the compositor no longer has the time of the last vblank.
>
> User-space compositors seem to operate under this assumption. That, I
> think, makes sense on better hardware with rendering and vblank IRQs.
> Page flips are fast on such systems.
>
> >
> > - The vblank data has nothing to do with the time of the next flip
> > event. In this case this series could in fact improve latency because
> > it removes the incorrect data from the compositor.
>
> Most of the hardware that would use vblank timers falls in this
> category. Page flips often consist of memcpys into video memory, or they
> transfer pixel data over slow peripheral busses. The amount of work per
> page flip varies with the size of the damage rectangles.
>
> Any vblank timing information here is therefore of low quality. For some
> scenarios, it would be common to miss a vblank or even the one after it.

What matters is if the flip event will be aligned to _some_ vblank
event. As long as that is the case, the compositor can estimate which
vblank it will hit based on previous frames and can schedule its work
accordingly. I believe KWin and Mutter already support scheduling
frames for multiple vblanks in the future to support low-powered
devices or devices that are under high load. I have not looked into
this myself.

But even on high-powered devices compositors already take per-commit
kernel work into account. For example, by default I aim to commit 1.5
ms before vblank. This grace period is adjusted dynamically if I miss
the expected vblank.

Therefore I don't think this is an argument against exposing vblank
info. Even if the hardware had such an interrupt, the memcpy and
slow-bus issues would continue to apply.

>
>
> IMHO, the first thing to discuss is whether having possibly low-quality
> timing information is preferable to having either high-quality timing or
> none. I have no strong opinion, but would tend to the latter.

If you want to make userspace aware that vblank events are not backed
by hardware interrupts, then maybe this could be exposed as a driver
cap or a flag in the vblank event. Userspace could then decide on
their own what to do with that information.

Currently I don't think any compositor would use that information
since they target flip times and don't care if those times are driven
by hardware or software (since this is not actionable by userspace
anyway). So maybe the useful flag would be "flip times will not be
aligned to any vblank event" if that applies to any driver.

>
> Best regards
> Thomas
>
>
> >
> > Whether the times of the flip events correspond to hardware timings is
> > not relevant. Everything in wayland compositors is scheduled against
> > flip event timings and they are also forwarded to clients for their
> > frame scheduling. If the flip timings are wrong/out of sync with the
> > hardware, then removing the vblank apis does not improve this
> > situation.
> >
> >> This change has been discussed at length on IRC recently.
> >>
> >> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&hi=
ghlight_names=3D&date=3D2026-05-08&show_html=3Dtrue
> >> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&hi=
ghlight_names=3D&date=3D2026-05-12&show_html=3Dtrue
> >> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&hi=
ghlight_names=3D&date=3D2026-05-13&show_html=3Dtrue
> >> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&hi=
ghlight_names=3D&date=3D2026-05-15&show_html=3Dtrue
> >>
> >> v2:
> >> - add filter to CRTC_GET_SEQUENCE and CRTC_QUEUE_SEQUENCE ioctls (Mich=
el)
> >> - clarify Mutter's behavior in cover letter (Michel)
> >>
> >> Thomas Zimmermann (9):
> >>    drm/vblank: Add drmm_vblank_init() to indicate managed cleanup
> >>    drm/vblank: Add DRM_VBLANK_FLAG_SIMULATED
> >>    drm/amdgpu: vkms: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/bochs: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/cirrus: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/hypervdrm: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/qxl: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/virtgpu: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/vkms: Set DRM_VBLANK_FLAG_SIMULATED
> >>
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c    |  3 ++-
> >>   drivers/gpu/drm/drm_vblank.c                | 26 +++++++++++++++----=
--
> >>   drivers/gpu/drm/drm_vblank_helper.c         |  2 +-
> >>   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |  2 +-
> >>   drivers/gpu/drm/qxl/qxl_display.c           |  2 +-
> >>   drivers/gpu/drm/tiny/bochs.c                |  2 +-
> >>   drivers/gpu/drm/tiny/cirrus-qemu.c          |  2 +-
> >>   drivers/gpu/drm/virtio/virtgpu_display.c    |  2 +-
> >>   drivers/gpu/drm/vkms/vkms_drv.c             |  4 ++--
> >>   include/drm/drm_crtc.h                      |  2 +-
> >>   include/drm/drm_device.h                    |  2 +-
> >>   include/drm/drm_vblank.h                    | 15 +++++++++++-
> >>   12 files changed, 45 insertions(+), 19 deletions(-)
> >>
> >>
> >> base-commit: 5fb5a9a63cf5ece68e0eeb6fa397da27712bccf0
> >> --
> >> 2.54.0
> >>
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG N=C3=
=BCrnberg)
>
>

