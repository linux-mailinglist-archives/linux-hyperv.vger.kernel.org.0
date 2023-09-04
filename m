Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E94791810
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Sep 2023 15:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbjIDN2Q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Sep 2023 09:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjIDN2N (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Sep 2023 09:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBC3CFE
        for <linux-hyperv@vger.kernel.org>; Mon,  4 Sep 2023 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693834032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxZkq0it8hCbAJaaXiECPzcax9Qu561b49DP/zFJ1B0=;
        b=RpkcatcZze8FSd1aXxYm+TxnJ4pf+TugslB6i1+rcDLfmuwvtrkZB5ux7yaYm8SDelklIA
        5LnHaKviumrOFZHbB+17qUpOXYUxipHzQ6E5wmZVZibFK8BVOW0yhbMbdZy+6X3Ntle/lk
        pG5Fuw2TbOVVzS7B3WWAOgk0tp/CwRI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-fbK8cvgPPeKevskJ8h7KSw-1; Mon, 04 Sep 2023 09:27:10 -0400
X-MC-Unique: fbK8cvgPPeKevskJ8h7KSw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31f46ccee0fso443303f8f.1
        for <linux-hyperv@vger.kernel.org>; Mon, 04 Sep 2023 06:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693834029; x=1694438829;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxZkq0it8hCbAJaaXiECPzcax9Qu561b49DP/zFJ1B0=;
        b=Icwf/4TH0o2dB6abRgEGLvR3pwGYtyZXzpDhGzWgsBPuppKQRz3H/W6MkuCPAcDayy
         4DKBZexSjYh/WM5EJKx8S8DeeMB3kH4SPebmX6hF8Tx6kmcjTHVqFXHx/d3YU8LFXGgh
         lJqn/5ngkDQSAWsh7ZKBBd5lpcTrCPEwSirUd19Feih16GXdaPJuM27N+cP3hehCnD/Z
         WvEVvHrE7fBCHonTDze9VoTX9uIPWkWILWQuSOIItwWkQ7EtE0aaCo+buAMYnLjsg+mS
         qfZjQi/K0elsfCW7oWtM1fkck5nirGB0ymjLevfXO4/YpL8kqtyB4eXHnkhzWhfSGPh5
         2Czg==
X-Gm-Message-State: AOJu0YzQqWgOPxXAADI0eCWmim0rc07IplWXHnNGvf7eXCBC25qsPWCe
        OfgCCt8pzU64a3FeWsxwcD5QHfy2YjVfKN9dXjM3oZ/23HXTu8Ny2yNie6YHtFdyteXP3yhOyij
        oeUcoWT4ocDrHcWPQz5v61SP8
X-Received: by 2002:a5d:4612:0:b0:317:ce01:fe99 with SMTP id t18-20020a5d4612000000b00317ce01fe99mr7234109wrq.9.1693834029682;
        Mon, 04 Sep 2023 06:27:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaqwNGWlc6zhQO+ObluvLtHBcvGlX5RhgjUyBHLBy+K84UjEg1PZVnv6fvBEAk50QZ/mL+mA==
X-Received: by 2002:a5d:4612:0:b0:317:ce01:fe99 with SMTP id t18-20020a5d4612000000b00317ce01fe99mr7234089wrq.9.1693834029373;
        Mon, 04 Sep 2023 06:27:09 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y1-20020adff6c1000000b00317a29af4b2sm14399476wrp.68.2023.09.04.06.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:27:09 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bruno =?utf-8?Q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 6/8] hid/picolcd: Use fb_ops helpers for deferred I/O
In-Reply-To: <20230828132131.29295-7-tzimmermann@suse.de>
References: <20230828132131.29295-1-tzimmermann@suse.de>
 <20230828132131.29295-7-tzimmermann@suse.de>
Date:   Mon, 04 Sep 2023 15:27:08 +0200
Message-ID: <87a5u2cbmb.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> Generate callback functions for struct fb_ops with the fbdev macro
> FB_GEN_DEFAULT_DEFERRED_SYSMEM_OPS(). Initialize struct fb_ops to
> the generated functions with an fbdev initializer macro.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: "Bruno Pr=C3=A9mont" <bonbons@linux-vserver.org>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

