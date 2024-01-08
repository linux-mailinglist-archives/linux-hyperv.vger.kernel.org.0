Return-Path: <linux-hyperv+bounces-1386-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24975826ACD
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 10:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2551C21BFB
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 09:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB00812B6C;
	Mon,  8 Jan 2024 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXG0IRqp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517912B68
	for <linux-hyperv@vger.kernel.org>; Mon,  8 Jan 2024 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704706581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QF07YVQH2syGFQtZnfOAe1/qfQiBqJlIcNmMYcsZHj4=;
	b=fXG0IRqpTFPyOzS04FM+pu7rLNoUqIxg/mWfDmyFzQygOtUq+/lNhlT6vG/OPVDs734Gy9
	fVju/yv9mR+lqYQJrn/zZ0yD5AfrTV3XdzNxC6DvWUz30SSftV4N0WwXwtR3h0QoBOHNxK
	Xu5wMS1hbuZUkJF4h2L3wOzzNOYqPKA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-of1nBy3MNVKe2qvzO4sr4g-1; Mon, 08 Jan 2024 04:36:19 -0500
X-MC-Unique: of1nBy3MNVKe2qvzO4sr4g-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2cd0804c5e6so13081921fa.0
        for <linux-hyperv@vger.kernel.org>; Mon, 08 Jan 2024 01:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706578; x=1705311378;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QF07YVQH2syGFQtZnfOAe1/qfQiBqJlIcNmMYcsZHj4=;
        b=pd8fhAcWlp9QOM2hYJ9k6LbWfFlkZL5sebyLQZ+yXIXK4lIT8QTCs3DHiJUBPAra1Q
         mM1efZNyD+3c7Alz4vVLjYWzxYMkhl8DXw+mfc5CFqqO4rNKrV3i5/KNVY63KNEu6Iwk
         Olp3YOBWyDRmw9ZhX/6RGo4fLS2Ny7PwSL0vgRcyeu1aJaIN9wX3W3cP4qVQulHDBkU+
         6Aunfw9JszoakxUn9OVTAmv9UWnyQryGNFSa0ue7902kgUnsfS8bQsH3BvgOIiQAEF0a
         QqTrwlEoi2rauyWMwRECAvE0rRE49ncnUquGVfAzY+2CjqX45ANw2Et4RdiEKOXtYxtr
         v4jw==
X-Gm-Message-State: AOJu0Yx4I0n6v4tCqcEw6es6RAt1mwZD3H6LqcfBoqKBTfX13/J9KZv2
	D8a/eARKcdWeb7QS4FhVx8+GxHAtpaOtU3IEnV7fTO52VP3Xk4QzRxTCIp8LBLbQWevjjlL+Hlh
	qkM96wvijjkUgvcpOoqxxlUUEB92Mh/HW
X-Received: by 2002:a05:651c:a07:b0:2cd:10be:cf14 with SMTP id k7-20020a05651c0a0700b002cd10becf14mr1730538ljq.19.1704706578546;
        Mon, 08 Jan 2024 01:36:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEofyXwklxoZpXnBRHO6GYjy+PST2V1Cnh2j8jUOksB0ztim7vP0b57O9VfxEXUzcwJzK8ZbA==
X-Received: by 2002:a05:651c:a07:b0:2cd:10be:cf14 with SMTP id k7-20020a05651c0a0700b002cd10becf14mr1730525ljq.19.1704706578200;
        Mon, 08 Jan 2024 01:36:18 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d410f000000b00336e43e8e57sm7273851wrp.58.2024.01.08.01.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:36:18 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, drawat.floss@gmail.com,
 deller@gmx.de, decui@microsoft.com, wei.liu@kernel.org,
 haiyangz@microsoft.com, kys@microsoft.com, daniel@ffwll.ch,
 airlied@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 4/4] fbdev/hyperv_fb: Do not clear global screen_info
In-Reply-To: <20240103102640.31751-5-tzimmermann@suse.de>
References: <20240103102640.31751-1-tzimmermann@suse.de>
 <20240103102640.31751-5-tzimmermann@suse.de>
Date: Mon, 08 Jan 2024 10:36:17 +0100
Message-ID: <871qasdv5a.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Do not clear the global instance of screen_info. If necessary, clearing
> fields in screen_info should be done by architecture or firmware code
> that maintains the firmware framebuffer.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


