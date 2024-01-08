Return-Path: <linux-hyperv+bounces-1382-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D18AF826AA3
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 10:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701D81F216E0
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 09:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973E311709;
	Mon,  8 Jan 2024 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvN70p+1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B01170A
	for <linux-hyperv@vger.kernel.org>; Mon,  8 Jan 2024 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704705995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6YTWyI9pnmCGgMl9btSzC0QrUqFEx74j7BArMXqCJjM=;
	b=VvN70p+1NQDWxDayHvy4WqHFz8YrtbFdWIfYN6w61vUcneL1afCeA8cKSyLXfMLgDfgn3L
	7T+2m66Rafuu2CDsm822gUi8J2NP9Knv8lfT1quK2ivuIuH/W/SjWMHqGiyf+vBa5EKuZG
	A9+//VA09get4jWZ3OVcCaSxT/GrD4U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-dvyOc6dJPzSt42cxZgid0A-1; Mon, 08 Jan 2024 04:26:33 -0500
X-MC-Unique: dvyOc6dJPzSt42cxZgid0A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-337707db5b1so76927f8f.1
        for <linux-hyperv@vger.kernel.org>; Mon, 08 Jan 2024 01:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705992; x=1705310792;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6YTWyI9pnmCGgMl9btSzC0QrUqFEx74j7BArMXqCJjM=;
        b=r266s8KEoJLuXbAAhrVVDctOD30/GTQtV807dXxRYtaXVJRuMv9838sLSKt2FHmlA3
         0QGhzE9lWWegIyOdCYd8RT/vHYGhwBOhU/IkCc21Y0uuAceAW09xQl4fjwGZl3UM9Gh/
         6wMG61ivKLAWQzqahSMNtg81vDp8xTK4RZ6ljbC5Qo55J3a3eimtG3ooFCIDLQ+KAlS2
         C+iMRFIyMnS4c07fAr1QKzlDOaV1q2towXEm12FF9aFNVjwGSPfR9FRQ2nvr7YYsSPMx
         nL7xbTcD9JQS1l6TsPbVJg814MEyy0XOe/QV0djg14n8k+p9WNy5wEwfQURuyixleK2I
         8k3w==
X-Gm-Message-State: AOJu0Yw19vpJ8P13lSctC0eBahJrzOV1VcgOtrxPAfL19Jyd97VpO0Qr
	PqGrXPVq+92xc87GCldCNpWhYp4ekowtVoSZirzfGthLTMCV0ixeObjZkmaEhyFnqD4eMx5PiG1
	Pt8ATdB/CBnUexzljj49BheJBCEMo6+cw
X-Received: by 2002:adf:f6cd:0:b0:336:8767:2e2f with SMTP id y13-20020adff6cd000000b0033687672e2fmr1627248wrp.7.1704705992335;
        Mon, 08 Jan 2024 01:26:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElQ85E5AG8DGOKkrtDXTZaOebM+TMHkse/0Vdzz+KyAM6wy4odUSkHjozFDOl2/e8dH60OhQ==
X-Received: by 2002:adf:f6cd:0:b0:336:8767:2e2f with SMTP id y13-20020adff6cd000000b0033687672e2fmr1627242wrp.7.1704705992051;
        Mon, 08 Jan 2024 01:26:32 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o14-20020adfeace000000b0033690139ea5sm7289677wrn.44.2024.01.08.01.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:26:31 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, drawat.floss@gmail.com,
 deller@gmx.de, decui@microsoft.com, wei.liu@kernel.org,
 haiyangz@microsoft.com, kys@microsoft.com, daniel@ffwll.ch,
 airlied@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/4] drm/hyperv: Remove firmware framebuffers with
 aperture helper
In-Reply-To: <20240103102640.31751-2-tzimmermann@suse.de>
References: <20240103102640.31751-1-tzimmermann@suse.de>
 <20240103102640.31751-2-tzimmermann@suse.de>
Date: Mon, 08 Jan 2024 10:26:30 +0100
Message-ID: <87a5pgdvll.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Replace use of screen_info state with the correct interface from
> the aperture helpers. The state is only for architecture and firmware
> code. It is not guaranteed to contain valid data. Drivers are thus
> not allowed to use it.
>
> For removing conflicting firmware framebuffers, there are aperture
> helpers. Hence replace screen_info with the correct function that will
> remove conflicting framebuffers for the hyperv-drm driver. Also
> move the call to the correct place within the driver.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


