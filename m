Return-Path: <linux-hyperv+bounces-4778-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F97CA79076
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Apr 2025 15:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5F83B9EDD
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Apr 2025 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C25823AE95;
	Wed,  2 Apr 2025 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chnN6Ra/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28C9239089
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Apr 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601939; cv=none; b=ZVVez/BNIFdMgrtM3TWQPoxeDT1nbifHOcxzQpL4QCHegJ2n6ZQQHkyUeeqG8V7hQPrAK33X7cLrCjDzRg17gKxde++NE63jt0D64oR/1ZJrxqlsxxPWBRaGOCMDjKkmeIXIh9f5FiNi/mP47o9tCm5Ny89SO7cbGJiLb7drr1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601939; c=relaxed/simple;
	bh=A6G9thMdXGNij6sKP+YM3dlgxFr0/ZSLvkA5bH/ujFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxpGOLjX10Jsit/o6QYo8mlrTN+GioQZnirXeYYsju3/GMwmhOqAaixflyoHzkhiyFFoBqTZaVFX4CW3+Hg5YH/QaBCF7oHGS50YUPU0dTxUc7Qs79n4Y5mRtvTFkLhKYCZKuIdAgDdB9IQIkfrVc+VKRzSeWAi0apnh3A8nAb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chnN6Ra/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743601935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOgJPmykAObI2jQBeah+5x6J5ky48bfmV5G/uZspF+c=;
	b=chnN6Ra/eFho3KmkS21PLt78OV0Dp6EQ4fM79yQhOddFsDwwbuoYdToCFI+67UhgSzWXNs
	TEQT1+8tw/BItPUYdj2mHMRnZz5TVEL0J0xeMI7vCZPChKQGmYrhjjyNA713+7gCS34vvc
	Opcp0ikTFesbAhDphGDfUuMetcwhXBs=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-h1wl5byBOZ2KjWG68B6_9g-1; Wed, 02 Apr 2025 09:52:14 -0400
X-MC-Unique: h1wl5byBOZ2KjWG68B6_9g-1
X-Mimecast-MFC-AGG-ID: h1wl5byBOZ2KjWG68B6_9g_1743601933
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7394772635dso97055b3a.0
        for <linux-hyperv@vger.kernel.org>; Wed, 02 Apr 2025 06:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743601933; x=1744206733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOgJPmykAObI2jQBeah+5x6J5ky48bfmV5G/uZspF+c=;
        b=rGHNODQEEDM0J5Om3OREcG67pkNMcKoDYVm0QSD4y4Q7oxsn7gVBGU8BkRMcuSKtWe
         fwsfcBiOWtKoJZKW+FzPL+XPp53KM1kmrB0KVJSkGuxYcZjyyylIxhfPUZ5WS2PSq9ZG
         C0xj+Ow/Z1284n0UgIPgkylcUP6kAHh1E9aNSTzuk00PcCLXGBBAeLxLJ7KHB1tTHQGD
         2ymBrTE+tl6ygC5r/25DRMrLVw24qTs+Pi7fSdAf27znFYnDlJSahPjiJfGYhDj/b2Ef
         PL+RHbpfqeH5aT8mvrypQWUjt+lrm3ElksUUGJFtug+n/YQdT/a9lVGfPamOrpaGZbfF
         ouig==
X-Forwarded-Encrypted: i=1; AJvYcCVypeL5+ku6sB8E3hgNnVc1fzb2qfvx99NdHqQqcoE2/UpXQfaBKT5+XVTw+Z78jBZf8R4n5Y5fe+A3fok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5agwdDTDTyIG/8b3Qn/xuBS50VB/qlpwDL9BXLXPYvsPqQ5yf
	3Je4LHx/KWlz840S2xJaFB1kstWYS/Ok7xUZDXc1upZXSROBMGUgXkKwoJDUdVp2mx/BKGyeuyZ
	ZtlKOBc/AyY/CLhzE+BMjV0RxO1XKgeqM4E1LMBCNUfGDzkz2WGITXevK0lu4D+M2AJIHC4wKmu
	ePkmB9kE3J3Cesia3Gb0OqlkhqOJdwQO30dlLI
X-Gm-Gg: ASbGncv71CbgsecuKtC0FCgcVmwmpP/M2cooOYChje/+KC8VPkkp8i52UKam2HkL5QZ
	9aBrVcYqKU50ON1NEm35nBGa26wc7GkojhjjNP9fiuO7iCP0v10uFNoiplkGuRX94Wy+b7FQddK
	cAyZdj1pltVdQnLknXP4AFreLQQNPa
X-Received: by 2002:a05:6a00:4606:b0:736:64b7:f104 with SMTP id d2e1a72fcca58-7398034d311mr21220199b3a.5.1743601933108;
        Wed, 02 Apr 2025 06:52:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0zGL/a3PY98j5a5/Uh1iZIbTLXGDprDz04ve4TfMxa8U5wSK0yN9qe8umGPmAsIHrQ6w5aWwqZRLDXm7JuF0=
X-Received: by 2002:a05:6a00:4606:b0:736:64b7:f104 with SMTP id
 d2e1a72fcca58-7398034d311mr21220172b3a.5.1743601932776; Wed, 02 Apr 2025
 06:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402084351.1545536-1-ryasuoka@redhat.com> <dae5089d-e214-4518-b927-5c4149babad8@suse.de>
In-Reply-To: <dae5089d-e214-4518-b927-5c4149babad8@suse.de>
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Wed, 2 Apr 2025 22:52:01 +0900
X-Gm-Features: AQ5f1Jpw7m9T_UxVBqa763yKKRkEwQNaxAeOXPrh1fO22sf04fLAjs0UuR6sE_k
Message-ID: <CAHpthZp5L-iyE=sggm-fjooVsgLcMPpBSyNkfCC5Dj0B=Vy2JQ@mail.gmail.com>
Subject: Re: [PATCH RFC drm-next 0/1] Add support for drm_panic
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
	simona@ffwll.ch, drawat.floss@gmail.com, jfalempe@redhat.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 6:45=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
> Hi
>
> Am 02.04.25 um 10:43 schrieb Ryosuke Yasuoka:
> > This patch adds drm_panic support for hyperv-drm driver. This function
> > works but it's still needed to brush up. Let me hear your opinions.
> >
> > Once kernel panic occurs we expect to see a panic screen. However, to
> > see the screen, I need to close/re-open the graphic console client
> > window. As the panic screen shows correctly in the small preview
> > window in Hyper-V manager and debugfs API for drm_panic works correctly=
,
> > I think kernel needs to send signal to Hyper-V host that the console
> > client refreshes, but I have no idea what kind of signal is needed.
> >
> > This patch is tested on Hyper-V 2022.
> >
> > Ryosuke Yasuoka (1):
> >    drm/hyperv: Add support for drm_panic
> >
> >   drivers/gpu/drm/drm_simple_kms_helper.c     | 26 +++++++++++++
> >   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 42 ++++++++++++++++++++=
+
> >   include/drm/drm_simple_kms_helper.h         | 22 +++++++++++
>
> No changes to simple_kms_helper please. This is obsolete and should go
> away. Just put everything into hyperv_drm.

OK. Maybe it will work without any modification in simple_kms_helper if we =
can
call the pipe->funcs from draw_panic_plane() like drm_plane_helper_funcs.

Currently, the hyperv_drm is implemented with a simple display pipeline.
The pipeline control functions are in pipe->funcs and they will call via
drm_simple_kms_palne_helper_funcs. And these helper functions will
be called by drm_panic_plane().

Thank you for your comment.
Ryosuke

> Best regards
> Thomas
>
> >   3 files changed, 90 insertions(+)
> >
> >
> > base-commit: cf05922d63e2ae6a9b1b52ff5236a44c3b29f78c
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>


