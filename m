Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A176D7B5E
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Apr 2023 13:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbjDELb2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Apr 2023 07:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbjDELb1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Apr 2023 07:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B048F35BE
        for <linux-hyperv@vger.kernel.org>; Wed,  5 Apr 2023 04:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680694239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RNLFmKiaJhCbpMv6NNLJ01MSUH3fUGQXMqewzc3mLvQ=;
        b=XCO+Ppei3G0VGbswljyXoEJPt/LtB0Ti52/4nPLjBxkt9E1RUm2rNZYKrD/LKfbVYW/YAO
        cNVthVWq8LCiLc7/3XXlv1QAJTN+iX1adqRPn2DGA7w3IH+fbgDcxzGHhAoz8mBv/sDUC4
        QV8l2qKQpiCuR6hVJwJORm22IA8jc6I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Y_hnhOdzOji47s_qdxTbVQ-1; Wed, 05 Apr 2023 07:30:38 -0400
X-MC-Unique: Y_hnhOdzOji47s_qdxTbVQ-1
Received: by mail-wm1-f69.google.com with SMTP id k25-20020a05600c1c9900b003ef79f2c207so11487303wms.5
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Apr 2023 04:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680694237;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNLFmKiaJhCbpMv6NNLJ01MSUH3fUGQXMqewzc3mLvQ=;
        b=OnX3pvZjFrsrtnNQL8Hwm7QWhyoaEVwGHJvfd16E+yhV04MhOJ8nrgeMPulIjp8PBK
         9na517NwxH6NjrEWhYd0g3xmE+VgOsfnKvU17jblnkbyOqzrOheaatzDqtppTevQkPl1
         g3CDetfOh4E1USv3vXOFr19PmCbBdyfRTPS75WF4zVYVfIhIVzr1n03WDHtuueIpTB32
         u1DsY72CdsdLWe2pjoeTuz5/A7uo3KO/63FZ96N1bEDYxIkhy2Wh5baZRBYbR1XrPPP1
         7QmY1nDquDcW4NzqS9mIIo75HSy/sevxUwbTRxG6erdwy2v+0lu0dYRpsE/CUUNfZpHW
         HEYQ==
X-Gm-Message-State: AAQBX9ew3bCK6gRnzICanEyO9EtVwVhyH3kvlPi8iHJBm8+mK7RT95kF
        Daynvl61vwn3EQwtrYXGavusQJ80IAJlKITvkRMgBGVbfWmm4kWnJY8RNjG4f6wq+m5sILF9eq6
        ALXlsj7g2ezvCZqkIQlpZwSoeFAa5fGtcpgU=
X-Received: by 2002:adf:e409:0:b0:2ce:a0c1:bcaa with SMTP id g9-20020adfe409000000b002cea0c1bcaamr1759107wrm.9.1680694237462;
        Wed, 05 Apr 2023 04:30:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z+rEnxummXTXBERQ/WiQlDGMhXDsQ6asLHd92imjUbjJ+WG229BKVrkkBNa50e3N/32xHrgg==
X-Received: by 2002:adf:e409:0:b0:2ce:a0c1:bcaa with SMTP id g9-20020adfe409000000b002cea0c1bcaamr1759090wrm.9.1680694237126;
        Wed, 05 Apr 2023 04:30:37 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w3-20020adfcd03000000b002d45575643esm14727267wrm.43.2023.04.05.04.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:30:36 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Emma Anholt <emma@anholt.net>, Helge Deller <deller@gmx.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-hyperv@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 3/8] drm/aperture: Remove primary argument
In-Reply-To: <20230404201842.567344-3-daniel.vetter@ffwll.ch>
References: <20230404201842.567344-1-daniel.vetter@ffwll.ch>
 <20230404201842.567344-3-daniel.vetter@ffwll.ch>
Date:   Wed, 05 Apr 2023 13:30:36 +0200
Message-ID: <871qkyd0rn.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Daniel Vetter <daniel.vetter@ffwll.ch> writes:

> Only really pci devices have a business setting this - it's for
> figuring out whether the legacy vga stuff should be nuked too. And
> with the preceeding two patches those are all using the pci version of
> this.
>
> Which means for all other callers primary == false and we can remove
> it now.
>
> v2:
> - Reorder to avoid compile fail (Thomas)
> - Include gma500, which retained it's called to the non-pci version.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

