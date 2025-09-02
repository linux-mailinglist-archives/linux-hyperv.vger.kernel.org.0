Return-Path: <linux-hyperv+bounces-6689-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57168B3F81D
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Sep 2025 10:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BEA27B225F
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Sep 2025 08:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC8E2E62D1;
	Tue,  2 Sep 2025 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1OnqSU+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BDD2E8B90
	for <linux-hyperv@vger.kernel.org>; Tue,  2 Sep 2025 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800929; cv=none; b=lyqajffQQb3BkghHHj3jN85tY+eiLZlhzoHrfPVQp558O2KJgbP9DTtRV0k0LQ/dfsy/KEWefEp7AkZj3wqO4l2e1NFJz07zovtc9VHhf2bBgrqTaMgfGRSYivVFAypK1m72H2neKC4HjcLsLwjbO1qx1DiURaMzZszAKb9ie80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800929; c=relaxed/simple;
	bh=aUJmm2L2ogYNzBGzxvtFOLJmc+bvS03Qds6m+oHE448=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CIzzw1t8lO4J92bBosYgDmuo62+o6Ruc4BnY71utEGEub3BgOh8C8etFQtB3j05OYUIBMDTUelbzO+Ouo/Cq51BYd2BVl1ZaE/o5uRXHKv0VdiIlORaemdt8yuMnKrVyQyhbX/56GoOp6LQQYrebSKqwiLogqWunDXlUQI+3OdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1OnqSU+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756800926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HXRyi8QQ+yoEJQrCXQN+YoD6Y9D+uJQKqe1ifwkGZM0=;
	b=I1OnqSU+JLZ11NV3V1TJlvPTnMfNDJ65TY2INSYQdE18bJQXiJR85xq8nuuTrLHuZVBVkh
	EfUuXk1sQTtVFpZUl6Aaa17RDyff0+n2RIzlkd3uj/mftkmb8vcj7bW2UBvQmnzCkTJu8S
	YtDi2jvo10lXrUrXFePzJUf89/E+PsU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-VllyTqbzN7u5GnndKE0UuA-1; Tue, 02 Sep 2025 04:15:25 -0400
X-MC-Unique: VllyTqbzN7u5GnndKE0UuA-1
X-Mimecast-MFC-AGG-ID: VllyTqbzN7u5GnndKE0UuA_1756800924
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b7d84d8a0so13144785e9.1
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Sep 2025 01:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800924; x=1757405724;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXRyi8QQ+yoEJQrCXQN+YoD6Y9D+uJQKqe1ifwkGZM0=;
        b=nFWP7wX7TQ1og7zrZp0c1mKMtvk486qRNeuve6zVgWbxrmKUB8fMITF+d9rINbsATV
         tdnqCFkJWVJ7zKwU/b0Ss9QPQLqv0FUCEjNj6+sKp1WCmvMoaW+/jbqh/mdW/AIMQVt8
         /6E+EhPYOZJS+ZOZIjO8ivv+gbPImbxmiCITsRDKkhLytB1hnrOYvOh5kd3JNqo2iLP0
         nlYzIx0h8v5TK7RlfZKuhNLks9Y3+oZxb0a9oGh/0mj4ICWfcxcN242UHpSEqILP7sdT
         GZrF/oS6EheSngseOg5wm6WlhhRbcEI+L5qnKSmmPOcGTM0eJ0K3jDiB0oVRnmLI8bK6
         cF+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBPAmdt2Dj5ZRXyT+kAw5zA0wwoJe8lsxVj/hT+gXclQzyqNavlaIxeXzGZJXY72mOi0+kktjVtQNko5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyExfikQCdP1Awott1r3GbgzKaYJpxk4Cou5t6yNd+HOE6hRUwG
	2mMbnmWDwNKB6oCj9YRvmVS37UnsdewiIiUMdR922f1TFzsIqAUaftnise9iET/RmCc4oo7LcqN
	5FuMvMPwd+FBS4CjsT9iq7lbL/R+mLKJP/gR9/KmIh1Q7tQcy/rdxyVgUifWTEjtSRA==
X-Gm-Gg: ASbGncsunupfHYC2xEXeUpZxytcvmSytrGyFCHxXGG+7l/yhWBbXUh7ZAODE654LMut
	Rib+K7RMjetjdRFAAy7ZXQ/X55BYnvydRB1Xwldeb7t8HGPbrCMQyRqkmk/6waryXBLwjug973c
	Gda1F5W6MOumxEQy9FQyi4Scj9dJCky4ZKfjaMJWq5/y9i6cO9udLFPuX7hY7sGqff/2feooYq0
	gAMJot/u1SinnXYlXRmB/9vl5u1ONJEI/HUv1b1bgTttBZsYl6v9JHku6mtNdeNlLHQlKbpblgn
	YA+vOplL6bOUtfRdNyaQPE/rXIlZ4QA7WPImvXOB06IK9f4nesj631EyrQS/7dA8fA==
X-Received: by 2002:a05:600c:4ecd:b0:45b:876b:bccd with SMTP id 5b1f17b1804b1-45b876bc00dmr78095835e9.6.1756800924061;
        Tue, 02 Sep 2025 01:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf3BXjXuhH+zQHiKvFQfBOrdSHe7/u6GM1yafj+Lz0Rrl2E0wkGX+XU06hmLpkjw/X//Nfmg==
X-Received: by 2002:a05:600c:4ecd:b0:45b:876b:bccd with SMTP id 5b1f17b1804b1-45b876bc00dmr78095555e9.6.1756800923608;
        Tue, 02 Sep 2025 01:15:23 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7eb05fd9sm186678105e9.24.2025.09.02.01.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 01:15:23 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, louis.chauvet@bootlin.com,
 drawat.floss@gmail.com, hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 mhklinux@outlook.com, simona@ffwll.ch, airlied@gmail.com,
 maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 3/4] drm/vkms: Convert to DRM's vblank timer
In-Reply-To: <20250901111241.233875-4-tzimmermann@suse.de>
References: <20250901111241.233875-1-tzimmermann@suse.de>
 <20250901111241.233875-4-tzimmermann@suse.de>
Date: Tue, 02 Sep 2025 10:15:21 +0200
Message-ID: <87cy89fexy.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Replace vkms' vblank timer with the DRM implementation. The DRM
> code is identical in concept, but differs in implementation.
>
> Vblank timers are covered in vblank helpers and initializer macros,
> so remove the corresponding hrtimer in struct vkms_output. The
> vblank timer calls vkms' custom timeout code via handle_vblank_timeout
> in struct drm_crtc_helper_funcs.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


