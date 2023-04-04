Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4066D6ECE
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Apr 2023 23:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbjDDVUe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 Apr 2023 17:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjDDVUd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Apr 2023 17:20:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CB044AE;
        Tue,  4 Apr 2023 14:20:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id fi11so12592485edb.10;
        Tue, 04 Apr 2023 14:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1680643230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5+FAUacxS+s9wS9+WZNPmawepdrV15aiNOEp44JCVM=;
        b=La2q1cdEt1u8ad1MBI9z/YWXhjb1ddmFhaPLuOFZUYuelVrfE8HIhxNPyvFClV0P7g
         svtJ9lEKx+c3VSuhd0Oz8p5I/gXLjPr7+DglxX6aD7V5k0vz++j4xeNMqMgquRg3AEv3
         4y4BFu26N3/RiY4pKwASDwLAlCj7SrYCR+5KaJHbmQQzEQUeT2zoiOUeE0TkZcOSvoLC
         Z38gr3u/CJgZr4/T46A4/jqp+5gxiDeMV+GgKpmdtndU+NCKQVBh1OgsPzu2NOAn8FYW
         Bej2iZ9mMb+l4XonfKUVNMU/JWDiqiU4JrOABkvWWYqw8U+GKBEdUHA0SZjHpeTvE4Kn
         ffXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680643230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5+FAUacxS+s9wS9+WZNPmawepdrV15aiNOEp44JCVM=;
        b=2K8HugRNbznLmRZGIIpZqDt6jQRbpbEtdlx5oXK4QWwfFzqk8dj02eIVmEvEmKt6tk
         W9cTDVZpcCiwAxCLtfoKVbStatvUBqqCiEiaXD5lO5wyhPqBjGgPGNpEtk1m8omZ6+1L
         n/YwncvEyGAAa6RhirHAU6Qt+dUhknwHQLX++CSb1gd6Ir+pY1JWvNTUJLKBuR+GqQFV
         0l/dFUQkPaoA42EcFIsxr1VTT196dz0XJyNcj/LtBw0uT6suK3NC/AE1xZfSe1OvixCi
         gN/SG0n8BVQdb7IL5gGW1YmXfTNTqle+0pZEOvpM0ZWCiDDppAbvNXUDKxtq3m6DVZj6
         0MTA==
X-Gm-Message-State: AAQBX9d9QLrxCkz1HO9waF5rHX6+RU5tWBB9kmFbZTd8RPHzK/Qn1+07
        Up2QvPoODH6HudAJIOA21ltweh5q25s9HgDOkig=
X-Google-Smtp-Source: AKy350YQ8eox73r1Pc5Z61GA80cewysG9JVXMIiHYkLb+7yCzu/Auu3EHBU62rmW7kSappwZiTuB5zbuMVnl6rg80/s=
X-Received: by 2002:a17:907:c80b:b0:8f5:2e0e:6def with SMTP id
 ub11-20020a170907c80b00b008f52e0e6defmr565741ejc.0.1680643230540; Tue, 04 Apr
 2023 14:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230404201842.567344-1-daniel.vetter@ffwll.ch> <20230404201842.567344-3-daniel.vetter@ffwll.ch>
In-Reply-To: <20230404201842.567344-3-daniel.vetter@ffwll.ch>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 4 Apr 2023 23:20:19 +0200
Message-ID: <CAFBinCCQ+DRZ-T8rBO=fpP8s47X11iM4oZ5=LEjp_HqjAFSivg@mail.gmail.com>
Subject: Re: [PATCH 3/8] drm/aperture: Remove primary argument
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Emma Anholt <emma@anholt.net>, Helge Deller <deller@gmx.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-hyperv@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 4, 2023 at 10:18=E2=80=AFPM Daniel Vetter <daniel.vetter@ffwll.=
ch> wrote:
>
> Only really pci devices have a business setting this - it's for
> figuring out whether the legacy vga stuff should be nuked too. And
> with the preceeding two patches those are all using the pci version of
I think it's spelled "preceding"

[...]
>  drivers/gpu/drm/meson/meson_drv.c           |  2 +-
for the meson driver:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Thank you and best regards,
Martin
