Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C22EA359
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jan 2021 03:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbhAEC2H (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Jan 2021 21:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbhAEC2G (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Jan 2021 21:28:06 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7BAC061574
        for <linux-hyperv@vger.kernel.org>; Mon,  4 Jan 2021 18:27:26 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n7so20333796pgg.2
        for <linux-hyperv@vger.kernel.org>; Mon, 04 Jan 2021 18:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PRqghBQCezpF4101r4+aeMVY7BndpqHmm2VKbm8JDpY=;
        b=F2qbqxFbUlgt2yhECjDqxxONwyjp+UMru0yvfQ1E6IFD1VphsMPCK9L8Vm7qm587Ls
         2PLA6DUgmFwmsDSFbyAh7LArEFEfwUS0QzsGU26ZSQw4k38kYTAI66LXCyRkUbGSV76d
         T+8POfBWb+oVKy2Tm6BQnlfDqM+iGois6sfHb5BWVkau/yL/BN3nEH6EfgOo1EVZ8rc8
         nkF466xuP0waoduQObyPGSGIsvt5Fu+pdwje/1fC3OlEU+c4n79sN15m/qmlaeSrBAQb
         0aZp4uGhswV+nGHX+PdwKoelnqd1/keC8DfR+umKRjMQoyCVmM7BMjdUBtXsIC7gygKt
         J0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PRqghBQCezpF4101r4+aeMVY7BndpqHmm2VKbm8JDpY=;
        b=gg1YbNXEkd+4T3yKR2u44Woj3LrIUD+rkl/6o9mLwyXcFUFP0cZ9ytA/YldRHvlm+7
         OLIx7DVFrCKfyCwV9ZY0I1nX9gK/6jpPH8HQt0zEilV0NuM5oDTqRdmrSSV4F8bGRm3Y
         KTRlKMLmQCMXfFAuDZP9sHEHH4i4+6APeKcnJxvFlGvSGmJMXTsj56AP+jdLLTvvPH9m
         xzBkqtw8o9DRZX/7eCfmTnMi57yLneqa20j6JRz6QlhdesJf+QNCu5va5Tb+0GLBStyI
         gYmEe4Xf/xL0AsPo+BCq3yV6XipvjhQcZUq2vpuz1IddeLnbR78Rh6mM8E3iVY6QNCTM
         QjAg==
X-Gm-Message-State: AOAM5310nAJIIG6RMg3ijYdpcMlh9mToMLsAuSEAyES7Gnus0Iqu/H7L
        viuTPU6mSGBmkg49FyHY+1k=
X-Google-Smtp-Source: ABdhPJwVs/+l19N7R69vDvY824a+P6c8VUB3XnFA8IpjUSmI9ddcz7mEl+Vfozs5zDyGEcP/Ecu8tQ==
X-Received: by 2002:a63:1c09:: with SMTP id c9mr74096667pgc.185.1609813645940;
        Mon, 04 Jan 2021 18:27:25 -0800 (PST)
Received: from [192.168.1.8] (50-47-106-83.evrt.wa.frontiernet.net. [50.47.106.83])
        by smtp.gmail.com with ESMTPSA id s5sm55454610pfh.5.2021.01.04.18.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 18:27:25 -0800 (PST)
Message-ID: <4f7818f99734c0912325e1f3b6b80cb2a04df3ef.camel@gmail.com>
Subject: Re: [PATCH 1/2] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Tang Shaofeng <shaofeng.tang@intel.com>,
        Michael Kelley <mikelley@microsoft.com>
Date:   Mon, 04 Jan 2021 18:27:24 -0800
In-Reply-To: <2b49fcd2-38f7-dae5-2992-721a8bd142a2@suse.de>
References: <20210102060336.832866-1-drawat.floss@gmail.com>
         <2b49fcd2-38f7-dae5-2992-721a8bd142a2@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 2021-01-04 at 14:03 +0100, Thomas Zimmermann wrote:
> Hi,
> 
> I've been looking forward to this patchset. :) The code is really
> nice 
> already.

Thanks Thomas for the review.


> >   
> > +config DRM_HYPERV
> > +       tristate "DRM Support for hyperv synthetic video device"
> > +       depends on DRM && PCI && MMU && HYPERV
> > +       select DRM_KMS_HELPER
> > +       select DRM_GEM_SHMEM_HELPER
> 
> SHMEM helpers might not be a good choice, because you need this blit 
> code, which has a memcpy.
> 
> I guess it's easily possible to configure 16 MiB or more for the
> guest's 
> VRAM? If so, I suggest to use VRAM helpers. Guests will be able to 
> render into VRAM directly with the driver's memcpy. The driver will
> do 
> page flipping. The bochs driver would be an example.
> 
> Hyperv doesn't need buffer sharing with other devices, I guess?
> 

It's not possible to do page flip with this virtual device. The call to
SYNTHVID_VRAM_LOCATION is only honoured once. So unfortunately need to
use SHMEM helpers.

> > +#define PCI_VENDOR_ID_MICROSOFT 0x1414
> > +#define PCI_DEVICE_ID_HYPERV_VIDEO 0x5353
> > +
> > +struct hyperv_device {
> 
> Could this name lead to conflicts with other hyperv drivers? I
> suggest 
> to name it hyperv_drm_device.
> 
> 

Sure make sense to use hyperv_drm_device.

> > 
> > +
> > +struct synthvid_pointer_shape {
> 
> Do you have plans for adding cursor support?
> 

Yes I have tested with a prototype and cursor works. Will attempt this
in future iteration.

> > +
> > +       /* Negotiate the protocol version with host */
> > +       switch (vmbus_proto_version) {
> > +       case VERSION_WIN10:
> > +       case VERSION_WIN10_V5:
> > +               ret = synthvid_negotiate_ver(hdev,
> > SYNTHVID_VERSION_WIN10);
> > +               if (!ret)
> > +                       break;
> > +               fallthrough;
> > +       case VERSION_WIN8:
> > +       case VERSION_WIN8_1:
> > +               ret = synthvid_negotiate_ver(hdev,
> > SYNTHVID_VERSION_WIN8);
> > +               if (!ret)
> > +                       break;
> > +               fallthrough;
> > +       case VERSION_WS2008:
> > +       case VERSION_WIN7:
> > +               ret = synthvid_negotiate_ver(hdev,
> > SYNTHVID_VERSION_WIN7);
> > +               break;
> > +       default:
> > +               ret = synthvid_negotiate_ver(hdev,
> > SYNTHVID_VERSION_WIN10);
> 
> I don't get the logic of this switch statement. If the host is Win10,
> I'd expect the graphics device to use Win10's protocol, if the host
> is 
> Win8, the graphics device uses win8 protocols. So what's the point of
> the fallthroughs? Can there be newer versions of vmbus_proto_version 
> that only support older devices?
> 
> 

This is copied as it is from hyperv_fb driver. I suppose this is just
to accomodate newer version.
> 

Deepak

