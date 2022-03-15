Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7814DA1CF
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Mar 2022 19:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350845AbiCOSDr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Mar 2022 14:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350834AbiCOSDp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Mar 2022 14:03:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40235593B8;
        Tue, 15 Mar 2022 11:02:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bi12so43283565ejb.3;
        Tue, 15 Mar 2022 11:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lEC/nkhZWgafnlNYWqRvQ8T9pwDdv1X4bS+vmmN1SPI=;
        b=TlfZFBpL4ZxfH1h0A4azfOpuLuqRtduCM9W127vgQdbSX84AaRxquI24AZvaA/0Mhu
         W5o4xZkQR752Hf126heU6U/BBocdrE6/a2Ihx8NnsX9drwO5lACiezAZxvUZP3XJP8CY
         RgL/YsUwucofJYAR5HTDtSgiXc/8GSxvQKtINLDlNNpQhcJWsrikOyezbu8mRlY3gTlv
         rEOGgvjWGrYlDAjMi05/fTIC1jrV0GVsW+UEpEd1os1ZbL3wwjfaDDRl0voUi4hHNHYk
         rJABGDMHxUmjB3eeAevsUeKUu16sJWDZhY2h8sMc8S1ej06qZ5FAgZCqYTXYxZQxhKT7
         g/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lEC/nkhZWgafnlNYWqRvQ8T9pwDdv1X4bS+vmmN1SPI=;
        b=VPQYYS9KNUCyH1mUYRqrjpmKhQuRjkVTzpakjmzslZbInPw+bval+CVvfkbHSX7VRE
         H5+VS3PO8ppfBwYH3uLBVITN9+5K2xggz7Sg0esvMtt6j6SRwYnLSGjnzmQE106WcPIN
         J9X7G0tiTwlRzyjh8HBctbVqbXl/EFrT7kH18uqRMqhoKMN2jE5tX4BUgJB0j878W2W8
         Jl+bMY8G1sBbUF3mTwt8MHkZhLhAJpjNNtmls2CRKv06hDYY41JACeBcl5W+6tBoV3jM
         xTvwm7BBjiKjKPe7bFcRrBMdIpdWiuuJonrjePRRl1NUWFwlXuqIyBgWnARSjWjyYge9
         zEmA==
X-Gm-Message-State: AOAM532nDQGhrvCtU3GBL2tRwBuNrfXyq6F2ka4cS2W3fRfA7UeTfboH
        P+R7RuXE6CBbonfso3uOGvVb19KiaMR3cj0BXHE=
X-Google-Smtp-Source: ABdhPJwQNXcLkTGaCJKCgGEQ39fH/f9rG+zOEFi6wUHEyZIylN9K230wh3LynYxeoxVpwJTKYSVD3SjkIYeMUl1wmGU=
X-Received: by 2002:a17:907:6e01:b0:6d0:562c:e389 with SMTP id
 sd1-20020a1709076e0100b006d0562ce389mr23976723ejc.497.1647367351540; Tue, 15
 Mar 2022 11:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com> <20220312132856.65163-6-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220312132856.65163-6-krzysztof.kozlowski@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Mar 2022 20:01:18 +0200
Message-ID: <CAHp75VfLtjfrB4Zj9ncOg3VYQrX58chEL+6g31_5fwuMUuURPg@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] PCI: Use driver_set_override() instead of open-coding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Mar 12, 2022 at 4:09 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Use a helper to set driver_override to reduce amount of duplicated code.

the amount

> Make the driver_override field const char, because it is not modified by
> the core and it matches other subsystems.


Seems like mine #4 here
https://gist.github.com/andy-shev/a2cb1ee4767d6d2f5d20db53ecb9aabc :-)
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks!

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci-sysfs.c | 28 ++++------------------------
>  include/linux/pci.h     |  6 +++++-
>  2 files changed, 9 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 602f0fb0b007..5c42965c32c2 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -567,31 +567,11 @@ static ssize_t driver_override_store(struct device *dev,
>                                      const char *buf, size_t count)
>  {
>         struct pci_dev *pdev = to_pci_dev(dev);
> -       char *driver_override, *old, *cp;
> -
> -       /* We need to keep extra room for a newline */
> -       if (count >= (PAGE_SIZE - 1))
> -               return -EINVAL;
> -
> -       driver_override = kstrndup(buf, count, GFP_KERNEL);
> -       if (!driver_override)
> -               return -ENOMEM;
> -
> -       cp = strchr(driver_override, '\n');
> -       if (cp)
> -               *cp = '\0';
> -
> -       device_lock(dev);
> -       old = pdev->driver_override;
> -       if (strlen(driver_override)) {
> -               pdev->driver_override = driver_override;
> -       } else {
> -               kfree(driver_override);
> -               pdev->driver_override = NULL;
> -       }
> -       device_unlock(dev);
> +       int ret;
>
> -       kfree(old);
> +       ret = driver_set_override(dev, &pdev->driver_override, buf, count);
> +       if (ret)
> +               return ret;
>
>         return count;
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60d423d8f0c4..415491fb85f4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -516,7 +516,11 @@ struct pci_dev {
>         u16             acs_cap;        /* ACS Capability offset */
>         phys_addr_t     rom;            /* Physical address if not from BAR */
>         size_t          romlen;         /* Length if not from BAR */
> -       char            *driver_override; /* Driver name to force a match */
> +       /*
> +        * Driver name to force a match.  Do not set directly, because core
> +        * frees it.  Use driver_set_override() to set or clear it.
> +        */
> +       const char      *driver_override;
>
>         unsigned long   priv_flags;     /* Private flags for the PCI driver */
>
> --
> 2.32.0
>


-- 
With Best Regards,
Andy Shevchenko
