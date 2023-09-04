Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A6979181B
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Sep 2023 15:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbjIDN3r (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Sep 2023 09:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239721AbjIDN3r (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Sep 2023 09:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA1B19B
        for <linux-hyperv@vger.kernel.org>; Mon,  4 Sep 2023 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693834137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ogc35j5wnFZjYknca/Dmxrctu7aJYOr7uX6tINC9GWs=;
        b=eVMR9mHWlE+I25vv9vjngZNjD2SmjS/XMAZrK8cTk7kD0sdVAcRBcFfxzL9T0UsOYvkrOB
        EqHSot500snx9SFPg50x42o8lsq7tDv+ig1u48ATVv56U+Tp/4vt5YAJvJJXI098KEylsM
        hVSQnMU3WuR9fJbI1equGbue5uVtSUo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-QNndvP3bO0mdiu1E8EYz5w-1; Mon, 04 Sep 2023 09:28:55 -0400
X-MC-Unique: QNndvP3bO0mdiu1E8EYz5w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3172a94b274so824818f8f.0
        for <linux-hyperv@vger.kernel.org>; Mon, 04 Sep 2023 06:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693834134; x=1694438934;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ogc35j5wnFZjYknca/Dmxrctu7aJYOr7uX6tINC9GWs=;
        b=lcGZKvkFe8oEsYDYYmw3YRrm352ovGEwDWPk+4IfeM/hbPEl2sVyyPgMpmpr3RHHvk
         pHLC8gCc9haGm6cvPCivkm8uzgkElRLjxbYBbMxDomGrE9vLlYjqqyjk49RdEN01rv6d
         r5xbXkK4bMLbKQOD1fOoy7TGN+pWwm+ougTX2bnbIYkHmlWCmZ8WcnnYD9PuNHU+9xV9
         j5f3rdVVA1clb3Va0qkbPBu9nNxTgESIfHWQeNltv9N0Beh86YB+RNemOXXgz5QGww2A
         SNy5DShtVeXxQ6hoF0/uHIUWP9ZfJ4+7D/6zU8CkxDZBpS1XhX9sNyVSv1aqLdCyJpnl
         dA0Q==
X-Gm-Message-State: AOJu0YzIrLpmQs0XQLRgNpbJePq3we+U1KZ33aoOl8u6J0K+QnftChId
        DcraWCF0PpsyXGqCluLVP5luu9a4vbfu2tHS0hA29h7g5ilrWHCCGiNQcH2jQL/gCnCFyWrmRtA
        TAUMwt7Di2dDMrB8GA5miyzdJ
X-Received: by 2002:a5d:43c3:0:b0:317:3d36:b2cd with SMTP id v3-20020a5d43c3000000b003173d36b2cdmr6107643wrr.71.1693834134387;
        Mon, 04 Sep 2023 06:28:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3pL/7M37MZ8DDYOtxB0J933cOF0hsfKFCSqFaXm8ULHyrObL/1Lf5LyHUOXJD35lTdHtBaw==
X-Received: by 2002:a5d:43c3:0:b0:317:3d36:b2cd with SMTP id v3-20020a5d43c3000000b003173d36b2cdmr6107629wrr.71.1693834134083;
        Mon, 04 Sep 2023 06:28:54 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c1d8300b00401e32b25adsm14407260wms.4.2023.09.04.06.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:28:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 8/8] staging/fbtft: Use fb_ops helpers for deferred I/O
In-Reply-To: <20230828132131.29295-9-tzimmermann@suse.de>
References: <20230828132131.29295-1-tzimmermann@suse.de>
 <20230828132131.29295-9-tzimmermann@suse.de>
Date:   Mon, 04 Sep 2023 15:28:53 +0200
Message-ID: <874jkacbje.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Generate callback functions for struct fb_ops with the fbdev macro
> FB_GEN_DEFAULT_DEFERRED_SYSMEM_OPS(). Initialize struct fb_ops to
> the generated functions with an fbdev initializer macro.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

