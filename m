Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBE6791816
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Sep 2023 15:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbjIDN3D (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Sep 2023 09:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbjIDN3C (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Sep 2023 09:29:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96C0CCE
        for <linux-hyperv@vger.kernel.org>; Mon,  4 Sep 2023 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693834098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8BbS0VR+viLE45lChE7wLN6LwznzmsTUr7hWT6afTU=;
        b=ZiAZFSGOxYgxpFBYbTMXDXXXhXWGWdpyuSB/p7MK4lE9bcU45hBJFEO5k0zohlJSXT+TZx
        JMPWokm687TDw79vaWBM7OfVdJl/MyOvKyp39MgOoImVH7de2rMQ2FW44OV+e8A4aldo45
        FsQ7DI5fhBpOSL6bA9zRFWenDE+M2Z8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-X29-TA3dNnKlU1D5k6BSOw-1; Mon, 04 Sep 2023 09:28:17 -0400
X-MC-Unique: X29-TA3dNnKlU1D5k6BSOw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fd0fa4d08cso9511905e9.1
        for <linux-hyperv@vger.kernel.org>; Mon, 04 Sep 2023 06:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693834096; x=1694438896;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8BbS0VR+viLE45lChE7wLN6LwznzmsTUr7hWT6afTU=;
        b=LZmLCyoxZhHw/kO+KTOPdC06uKgil+4pIMqQSzuIEI3tTy2XAGWBnMq9E4MQ2/8d+B
         dAAJdmtrc7MnARCyFmQqMo4+vgBX+rwEpmTxPj65S/RkKflYcnWOF5u19Hps8nxfv8im
         3ygjhtBVFXjaYicrnyzf4gos/x4e28+YJla3McyensckVRSaLVuabuCyO/Viyc58oyxC
         km7TgvNr6piL7CrJ5NxcLczm3I79VQYb0rh1utPByoELix9x3koqeph1DNp/3AITsRpA
         MH9WvDru3WRdj9jST+Gpaqf89R5SdJyLfV6P/+E1fdFzsGAp/8/Fitb7q7nrw2JDeqe2
         z4mA==
X-Gm-Message-State: AOJu0YyavIu0qAO7hZdZWN8M/Cy9WT6iNBa5FyLO+t8HmKn1NmBNPFZh
        /pa21TQ7QlxZjM73vYxD/EtkMgPtT3V0qMcEUb/H9LXYgGuNVxMRyCAfRDAW9nU36JfSIdpNNT4
        mvj3idGXUIZt/7moGB2WfvvvB
X-Received: by 2002:a05:600c:2945:b0:3fe:89be:cd3 with SMTP id n5-20020a05600c294500b003fe89be0cd3mr7455263wmd.22.1693834095942;
        Mon, 04 Sep 2023 06:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl7VfR/OsiuaD0NLKpcBP58yIezvg5tTwL4OjRo81CSensP8glNKF1MPDnFaTMcS52nY0Kpw==
X-Received: by 2002:a05:600c:2945:b0:3fe:89be:cd3 with SMTP id n5-20020a05600c294500b003fe89be0cd3mr7455246wmd.22.1693834095589;
        Mon, 04 Sep 2023 06:28:15 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p9-20020a1c7409000000b003fee53feab5sm14253513wmc.10.2023.09.04.06.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:28:15 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 7/8] staging/fbtft: Initialize fb_op struct as static const
In-Reply-To: <20230828132131.29295-8-tzimmermann@suse.de>
References: <20230828132131.29295-1-tzimmermann@suse.de>
 <20230828132131.29295-8-tzimmermann@suse.de>
Date:   Mon, 04 Sep 2023 15:28:14 +0200
Message-ID: <877cp6cbkh.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Replace dynamic allocation of the fb_ops instance with static
> allocation. Initialize the fields at module-load time. The owner
> field changes to THIS_MODULE, as in all other fbdev drivers.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

