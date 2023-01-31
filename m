Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A20683786
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Jan 2023 21:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjAaU2R (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 Jan 2023 15:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjAaU2K (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 Jan 2023 15:28:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5618F2D4A;
        Tue, 31 Jan 2023 12:28:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CF37B81EB8;
        Tue, 31 Jan 2023 20:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362CBC4339B;
        Tue, 31 Jan 2023 20:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675196883;
        bh=MX7l6AfPhfgB2B89ZKvj9UQjlQBtzbgEHNVQpqnulMU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SO7BiR/XSAqaRDrI01gYfFDmjtHm5zhjkoswNhTexpnPkgnehJ8lCkXQ8zWQcNp3b
         uQyry6c91fak3tq3zaquRwazxyjRrGMPmlwHbZ49GaZnR2CXU/DCqCXNZEYdGrfuLr
         kxLeb7auxnlxTgIsdLrWYfxsrO9nAjQ72a+X1ITLZRdpdRQ9pTBPbczszz2W9xzsOU
         zimktVQFZUkcut47HeNxI9raQS+qjklDWYxfDSoBzYvdQBJ73bXTh1Jd9skiFy+ocR
         YRzR1V3MYk/Hp0zkMtibcjBhBCP6C8sS3ULX9cvNBMPSfMqteBvcQdEWuNNxR4WPa2
         N1pAEVfRlSjtg==
Received: by mail-vs1-f43.google.com with SMTP id k6so17403580vsk.1;
        Tue, 31 Jan 2023 12:28:03 -0800 (PST)
X-Gm-Message-State: AO0yUKXSe2vbGhFQS5go3swhy5RLPhe7NGAQckvKVw8l0rNSRSAnML/K
        OBNgnYwP8OuohJeT+Vx6v3dQS3UFb33D7yYSqA==
X-Google-Smtp-Source: AK7set+M1V3xuFlo2nAvDwvo3onui82m9KOW7r1ZM8ACmzzvcpa6Zo7eqj6vrmUYhK9e3oHNnpbua+ZwdcG8LQJLlCw=
X-Received: by 2002:a05:6102:54aa:b0:3f5:f5f4:893c with SMTP id
 bk42-20020a05610254aa00b003f5f5f4893cmr27845vsb.85.1675196882190; Tue, 31 Jan
 2023 12:28:02 -0800 (PST)
MIME-Version: 1.0
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 31 Jan 2023 14:27:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKL3JA6nAkEHuuyxbs8-Mm=Q-nNkCmpnDApNUDVbLsvKw@mail.gmail.com>
Message-ID: <CAL_JsqKL3JA6nAkEHuuyxbs8-Mm=Q-nNkCmpnDApNUDVbLsvKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Device tree support for Hyper-V VMBus driver
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 31, 2023 at 12:10 PM Saurabh Sengar
<ssengar@linux.microsoft.com> wrote:
>
> This set of patches expands the VMBus driver to include device tree
> support.
>
> The first two patches enable compilation of Hyper-V APIs in a non-ACPI
> build.
>
> The third patch converts the VMBus driver from acpi to more generic
> platform driver.
>
> Further to add device tree documentation for VMBus, it needs to club with
> other virtualization driver's documentation. For this rename the virtio
> folder to more generic hypervisor, so that all the hypervisor based
> devices can co-exist in a single place in device tree documentation. The
> fourth patch does this renaming.
>
> The fifth patch introduces the device tree documentation for VMBus.
>
> The sixth patch adds device tree support to the VMBus driver. Currently
> this is tested only for x86 and it may not work for other archs.

I can read all the patches and see *what* they do. You don't really
need to list that here. I'm still wondering *why*. That is what the
cover letter and commit messages should answer. Why do you need DT
support? How does this even work on x86? FDT is only enabled for
CE4100 platform.

Rob
