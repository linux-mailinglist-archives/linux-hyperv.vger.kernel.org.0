Return-Path: <linux-hyperv+bounces-6722-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B72B431CB
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Sep 2025 07:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335611BC13FF
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Sep 2025 05:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8099022D4C8;
	Thu,  4 Sep 2025 05:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSe9z1Tz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F21239E9D
	for <linux-hyperv@vger.kernel.org>; Thu,  4 Sep 2025 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756965011; cv=none; b=rmjpH/UEdh9daO9iZnNVMD+beHKDT0lNl27qRKkZMTDeF8F9ne+E1R0V9IgSVjsSjT9blKk7L2lrYPbQ2Ss1iOwR36zAuvV5297ASXQ1ceRO5Cy7rhKKRvt7pU3/UnYZiKF+ObTnjeD2puj3noHXlJtss+QMZLRUZ4ufPH71z2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756965011; c=relaxed/simple;
	bh=rzsGRnYZke+AtJrXo8Hyz4DNrhkuDnZXT+4Z2unp6gQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n4LP72gTIb7OjCkN8JNqCd40PBjAJvJ6QDi+Rca/3Gg7IyAuY4xFzlVv5mbQ0KrX7lnr95PSnmjeIliEcPJApY9MGYGZCSx1Iiis9kIAnq9G8rq+AI0FF4O27wpwmXfgSD6Spcgg0hpVNgazegPkUlXN4hB4HnsBe8V6WjbOuK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSe9z1Tz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756965008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qggW7KTjlU6ejI6l4Tlv5hPrvn0I0l0hfP1BwcalHUY=;
	b=jSe9z1Tz6OmrdePgMHzuvhkotdRiVXy/ujblK0GHkkdf8VQM4z43+LMiNLy5kBaWL4ym1X
	kIRQfeWt10GH5c0w3W7zpGAQJr5jvVHHw9QRoW7E/qCNFLFjLSsh8zGA6k26GjGtf7KwmD
	Oktn50t83CzUOr13F2rt/pCgtjkWSIk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-y6MmKaJXO5Cs08KxALbLOw-1; Thu, 04 Sep 2025 01:50:06 -0400
X-MC-Unique: y6MmKaJXO5Cs08KxALbLOw-1
X-Mimecast-MFC-AGG-ID: y6MmKaJXO5Cs08KxALbLOw_1756965005
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b71fe31ffso3828855e9.2
        for <linux-hyperv@vger.kernel.org>; Wed, 03 Sep 2025 22:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756965005; x=1757569805;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qggW7KTjlU6ejI6l4Tlv5hPrvn0I0l0hfP1BwcalHUY=;
        b=Y76ptKOEFfAM1+QKFuvZBdbff4b9CsETXx57028LrthlOtyNHvQfldM4wFJJo5rNS5
         9PZgFe6EtpAg1tpIERbe+nBVIbYSK3Su26/QaOxXiX3q5HZoR7fryT/sR54GWBJmSLPu
         ycn6ySsL/ZeovN8zZGLWQyfyPQbWZbtJUSpOb54fB5vf9t8sHjKuXS33Yn4MZV3bUJcY
         C+GC7SDhlvfyRvmu9k+XbniM8rcPcZzFnvT5ucxjceH3Ms5fXkhUq4+EpX79VwT8OuFT
         a2xohCU/8h4jQb/pGTIZTlFHFotbWbk+VxehDtiyNFyb8oJWMAJasGfPDrP8WeAEEwjt
         sPDw==
X-Forwarded-Encrypted: i=1; AJvYcCXcURI69Eot7UOmqGcuTVffj/UBEMSIZSmMnmQSGQ+fKCZELSYNWVm9ftq2pGXyjsj+WIqU+S/aGP4+LFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGMU184p8ttTy9K9KmxXfUjtnxodCvmXPBApUBOL69QHPpfBw
	kZwi1MfFJu2AQIelltGfA6a1Hij76O0plj/nH3hYc1xxE36Z3a+bOQCN4QH+EeMuPuE3eo220tP
	u4+zAWyaUTqNpTF+wK2Gy+sNJWXVf1W+CDxa2XTvQFvmSgHwOUweX4iGFixq5rqjGTg==
X-Gm-Gg: ASbGncvQS7tSli1cGp8+86+f1gcxxK8+etqyWZwP5XHxbZKHRUVspb5KNZzCcvnt4Xp
	86O53kDvDcMzrF5zv16Xg3ZypsTXjmEEW7TnokJ/+/+//4o5VWk9oijoZbQo4x0w5ZTHJ4mxFim
	SC+1qQSpOwTlgOFP6DpGVy2Kld7A34dnwj9HPaVYeKDKnpnIHTHxD5qd+LlbXIE/yvt2sjuUm61
	5B7hG9NL1XXQYKwhbReY9ZZ7+K1X2OzyMM4dG3eCrg/Wp9GnhM47ImEA3Wr5Y4aZbtTlF6ZgDQF
	ut46wZ7GnOhaIJZkZLDJBtoUQ+7aTdycgRSYjc/PTt1HO0AkhMpiS6FjrHRpJ/L8CQ==
X-Received: by 2002:a05:600c:1c87:b0:45b:8b34:3489 with SMTP id 5b1f17b1804b1-45b9861e89dmr68782285e9.4.1756965005121;
        Wed, 03 Sep 2025 22:50:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGljutTKAncoAqAVhV+oQMlYYaXul/AlVZTtBGh6Ygzxqtw2Kk9jxwPI/ddWWTqfmuy5XKM2w==
X-Received: by 2002:a05:600c:1c87:b0:45b:8b34:3489 with SMTP id 5b1f17b1804b1-45b9861e89dmr68782055e9.4.1756965004601;
        Wed, 03 Sep 2025 22:50:04 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f306c93sm354419545e9.14.2025.09.03.22.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 22:50:03 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Michael Kelley <mhklinux@outlook.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, "louis.chauvet@bootlin.com"
 <louis.chauvet@bootlin.com>, "drawat.floss@gmail.com"
 <drawat.floss@gmail.com>, "hamohammed.sa@gmail.com"
 <hamohammed.sa@gmail.com>, "melissa.srw@gmail.com"
 <melissa.srw@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] drm/hypervdrm: Use vblank timer
In-Reply-To: <SN6PR02MB4157EFAA19227FAFD21E1466D400A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250901111241.233875-1-tzimmermann@suse.de>
 <20250901111241.233875-5-tzimmermann@suse.de>
 <87a53dfe87.fsf@minerva.mail-host-address-is-not-set>
 <5cd7f22d-e39a-4d37-8286-0194d6c9a818@suse.de>
 <877bygg8vb.fsf@minerva.mail-host-address-is-not-set>
 <SN6PR02MB4157EFAA19227FAFD21E1466D400A@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Thu, 04 Sep 2025 07:50:01 +0200
Message-ID: <87ldmuzrzq.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Kelley <mhklinux@outlook.com> writes:

Hello Michael,

> From: Javier Martinez Canillas <javierm@redhat.com> Sent: Tuesday, September 2, 2025 8:41 AM
>> 
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>> 
>> [...]
>> 
>> >>
>> >> I'm not familiar with hyperv to know whether is a problem or not for the
>> >> host to not be notified that the guest display is disabled. But I thought
>> >> that should raise this question for the folks familiar with it.
>> >
>> > The feedback I got at
>> > https://lore.kernel.org/dri-devel/SN6PR02MB4157F630284939E084486AFED46FA@SN6PR02MB4157.namprd02.prod.outlook.com/ 
>> > is that the vblank timer solves the problem of excessive CPU consumption
>> > on hypervdrm. Ans that's also the observation I had with other drivers.
>> > I guess, telling the host about the disabled display would still make sense.
>> >
>> 
>> Yes, I read the other thread you referenced and that's why I said that
>> your patch is correct to solve the issue.
>> 
>> I just wanted to point out, since it could be that as a follow-up the
>> driver could need its own .atomic_disable instead of using the default
>> drm_crtc_vblank_atomic_disable(). Something like the following maybe:
>> 
>> +static void hyperv_crtc_helper_atomic_disable(struct drm_crtc *crtc,
>> +                                             struct drm_atomic_state *state)
>> +{
>> +       struct hyperv_drm_device *hv = to_hv(crtc->dev);
>> +       struct drm_plane *plane = &hv->plane;
>> +       struct drm_plane_state *plane_state = plane->state;
>> +       struct drm_crtc_state *crtc_state = crtc->state;
>> +
>> +       hyperv_hide_hw_ptr(hv->hdev);
>> +       /* Notify the host that the guest display is disabled */
>> +       hyperv_update_situation(hv->hdev, 0,  hv->screen_depth,
>> +                               crtc_state->mode.hdisplay,
>> +                               crtc_state->mode.vdisplay,
>> +                               plane_state->fb->pitches[0]);
>> +
>> +       drm_crtc_vblank_off(crtc);
>> +}
>> +
>>  static const struct drm_crtc_helper_funcs hyperv_crtc_helper_funcs = {
>>         .atomic_check = drm_crtc_helper_atomic_check,
>>         .atomic_flush = drm_crtc_vblank_atomic_flush,
>>         .atomic_enable = hyperv_crtc_helper_atomic_enable,
>> -       .atomic_disable = drm_crtc_vblank_atomic_disable,
>> +       .atomic_disable = hyperv_crtc_helper_atomic_disable,
>>  };
>
> I have some historical expertise in the Hyper-V fbdev driver from
> back when I was a Microsoft employee (I'm now retired). The fbdev
> driver is similar to the DRM driver in that it tells the Hyper-V host
> that the device is "active" during initial setup, but there's never a
> time when the driver tells Hyper-V that the device is "not active".
>
> I agree that symmetry suggests having disable function that sets
> "active" to 0, but I don't know what the effect would be. I don't know
> if Hyper-V anticipates any circumstances when the driver should tell
> Hyper-V the device is not active. My chances are not good in finding
> someone on the Hyper-V team who could give a definitive answer,
> as it's probably an area that is not under active development. The
> Hyper-V VMBus frame buffer device functionality is what it is, and
> isn't likely to be getting enhancements.
>
> I suggest that we assume it's not necessary to add a "disable"
> function, and proceed with Thomas' proposed changes to the Hyper-V
> DRM driver. Adding "disable" now risks breaking something due
> to effects we're unaware of. If in the future the need arises to mark
> the device not active, the "disable" function can be added after
> a clarifying conversation with the Hyper-V team.
>
> If anyone at Microsoft wants to chime in, please do so. :-)
>

Thanks a lot for the insight. I agree that probably is not worth the risk
to notify of a display disable, since is unclear what the effect would be.

> Michael
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


