Return-Path: <linux-hyperv+bounces-5166-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D97A9E06A
	for <lists+linux-hyperv@lfdr.de>; Sun, 27 Apr 2025 09:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9BC17E7ED
	for <lists+linux-hyperv@lfdr.de>; Sun, 27 Apr 2025 07:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4BD2459D2;
	Sun, 27 Apr 2025 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Is+oWpTV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE8B7081F
	for <linux-hyperv@vger.kernel.org>; Sun, 27 Apr 2025 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745738971; cv=none; b=RDj2tFSNn3kAUX/q5NTu9bNOx7lvqEtoKH+Zow0CeN6JhzodQ7BTX9fOCChk0Iox1iUTZOojPbxihtUGetJZFrK+dGuL5FjhTVlZRfkx4SwD3OcgnupGHj4tk4EHbTpU6iaWd6kOnHV2JnyRUPN7f8urcwe7u+GaKNCEVqcQN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745738971; c=relaxed/simple;
	bh=YmIdSq43KeqVX2RY3EWr0cE19/g+nxXYj6wkj+8bK7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=izDGZX7MeJ8CMfofk3btF3xI8DGdNpBIBxL0yzjcR8cW+q5//eFfyl+yipEl6ElGVvvhnnyg6COz5/yZO73UjpIti7SQRLZ9Dtcnl7fwuU0X7YrFATchsFGHftL0UFGJB6locfPPf+iRoar7+gFDTFxjekep3IAO05kuVBPjPYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Is+oWpTV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745738967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wcGQpFTguItVa6CDu+q0byxuNxLDL/Np928mwDKp2zQ=;
	b=Is+oWpTV6S7/aK/v/Ng3NVe5/7DfH8YuLnihzo7J5jXqu4OB6r8Z5/yAQ88foLmlx6iVeW
	jJL2GN05tCzxgI0SVK0g/WFmiCUy1X09+ZeOoqUcBDh5JQLB+bTtaYi5NS36tSlziIYd4j
	uMB1DSsn5unJ7x37W63KhwRcsxrChVo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-_9kuWgeHPhmboenfbAvFSg-1; Sun, 27 Apr 2025 03:29:25 -0400
X-MC-Unique: _9kuWgeHPhmboenfbAvFSg-1
X-Mimecast-MFC-AGG-ID: _9kuWgeHPhmboenfbAvFSg_1745738964
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so22052955e9.1
        for <linux-hyperv@vger.kernel.org>; Sun, 27 Apr 2025 00:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745738964; x=1746343764;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcGQpFTguItVa6CDu+q0byxuNxLDL/Np928mwDKp2zQ=;
        b=jDM5S5zQ7mZzKCpPuop3d/IUvLHNYVhse3rILv30V0ZZ2uKs5XO37nxn1xl1G0WDkB
         hVS0oceu0SnIWl86nEt80UjJSE0ObMccttIJ9FmIn6x2Gyw3G83XOFcN+Pqc+1fmgVt3
         O3FpMhnGyHID1e2+d3gUWmq8/zbEAMtVThM7UmZ1dNzJZueWfUhpukvSAXon0PBj+hom
         paFBKeQK77dXHkmzd7ZBMW3mEUpzedUDO15w6IUiOdUH2UnI6bENOSAkfd02F+m5Jqj0
         2aeQjOnPmhsNN9xVn1NNoqQ653Tx9jORgAYE2owvKnn8+EKuc48Ce55x9hrj9w6jm8vR
         Krsw==
X-Forwarded-Encrypted: i=1; AJvYcCVgcZ9BS7zM38qE0b9bGZyRMSgyhkT4DNTWMwf8x8UJUCFt7ap+fZH70zJKTQd+X9xi8LRfANlamkKvNb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD5zb2UyoTwjdJqf2+ds0HW7MVU/FEe6rTZQHAj12hp/VAL4sv
	o+tuftwRq/cysrj1wmmawIkz+2dhOUFFkVelhoDNV2fHHz1Pwt6ZxxE22uoW2kRbJ3Ii9xSjZ6f
	ZxxsMC6K7BbcqJhqks5a7tCJIkvzLwEa0kSp4sqVY7Bd5s/6rIDQ06AK0S+dS/w==
X-Gm-Gg: ASbGncv1w0prpdi5lfMJZnRa5VcrRFK4moZFmOWtwuL1j/3DI5v52tT5zo76Hz7Y+/N
	MULbftLN15j2zaouo3HI6FaGD3EeNB6jh9ymUvX+PqwrcQ7K9ZvCNs8mxId47BMC+9TBAXpNZf0
	2d+J8Ua8lBWnm46mRGxvyDtVKd2dtfp18Qf1FzJDGIwN0fZKuB6SU5DjitPwzbGayTYzp8n+JcJ
	9/yzSNgytznC6mmnbkl366Mp67kn/pn/7W8YaiKmOZacqlZmj4hMC1dEZDpvEy0pDEI+kkxoz7m
	jEYW4I4pZdKQlpbllocQdMOmaOvMQW6z7Zm+N7hM+RUqBNGImp2nwfW+tF9G2MWbOMLZ7Q==
X-Received: by 2002:a05:600c:1e84:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-440a66b7b68mr66727235e9.29.1745738963927;
        Sun, 27 Apr 2025 00:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHimZlDfyKX+dV1RunsI8DPPpzKCieKScXo5Xcy7H8gXFHsd947YK1+IzF4ivCFxFOjPMb/Zw==
X-Received: by 2002:a05:600c:1e84:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-440a66b7b68mr66727125e9.29.1745738963562;
        Sun, 27 Apr 2025 00:29:23 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4408d0a7802sm102831515e9.1.2025.04.27.00.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 00:29:22 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: drawat.floss@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, jfalempe@redhat.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-next v2] drm/hyperv: Replace simple-KMS with regular
 atomic helpers
In-Reply-To: <CAHpthZqJPKtXUjFiVRLP+LEmTKFowUKVHGDe9=NS4aGx7WWcMA@mail.gmail.com>
References: <20250425063234.757344-1-ryasuoka@redhat.com>
 <87wmb8yani.fsf@minerva.mail-host-address-is-not-set>
 <CAHpthZqJPKtXUjFiVRLP+LEmTKFowUKVHGDe9=NS4aGx7WWcMA@mail.gmail.com>
Date: Sun, 27 Apr 2025 09:29:20 +0200
Message-ID: <87selugizz.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ryosuke Yasuoka <ryasuoka@redhat.com> writes:

Hello Ryosuke,

> Hi Javier,
>
> On Fri, Apr 25, 2025 at 4:15=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> Ryosuke Yasuoka <ryasuoka@redhat.com> writes:
>>
>> Hello Ryosuke,
>>
>> > Drop simple-KMS in favor of regular atomic helpers to make the code mo=
re
>> > modular. The simple-KMS helper mix up plane and CRTC state, so it is
>> > obsolete and should go away [1]. Since it just split the simple-pipe
>> > functions into per-plane and per-CRTC, no functional changes is
>> > expected.
>> >
>> > [1] https://lore.kernel.org/lkml/dae5089d-e214-4518-b927-5c4149babad8@=
suse.de/
>> >
>> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>> >
>>
>>
>>
>> > -static void hyperv_pipe_enable(struct drm_simple_display_pipe *pipe,
>> > -                            struct drm_crtc_state *crtc_state,
>> > -                            struct drm_plane_state *plane_state)
>> > +static const uint32_t hyperv_formats[] =3D {
>> > +     DRM_FORMAT_XRGB8888,
>> > +};
>> > +
>> > +static const uint64_t hyperv_modifiers[] =3D {
>> > +     DRM_FORMAT_MOD_LINEAR,
>> > +     DRM_FORMAT_MOD_INVALID
>> > +};
>> > +
>>
>> I think the kernel u32 and u64 types are preferred ?
>
> I'm not sure if I should fix this in this patch because I did not add the=
se
> variables. IMO, we need to split the commit if we fix them.
>

Right, I got confused for how the diff showed the changes. But I agree with
you that should be a separate patch since the variables already exist.

[...]

>>
>> Acked-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Thank you for your review and comment. I'll fix them and add your ack.
>

Thanks!

> Best regards,
> Ryosuke
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


